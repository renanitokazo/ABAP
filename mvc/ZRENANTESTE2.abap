*&---------------------------------------------------------------------*
*& Report ZRENANTESTE2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrenanteste2.

TYPES: tt_t100 TYPE STANDARD TABLE OF t100 WITH DEFAULT KEY.

INTERFACE zif_model.

  METHODS select_t100 RETURNING VALUE(rt_t100) TYPE tt_t100.

ENDINTERFACE.

CLASS lcl_model DEFINITION.
  PUBLIC SECTION.
    INTERFACES zif_model.

    METHODS constructor.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_model IMPLEMENTATION.
  METHOD constructor.
  ENDMETHOD.

  METHOD zif_model~select_t100.

    SELECT *
      FROM t100
      INTO TABLE rt_t100 UP TO 10 ROWS.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_model_fake DEFINITION.
  PUBLIC SECTION.
    INTERFACES zif_model.
    METHODS constructor.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_model_fake IMPLEMENTATION.
  METHOD constructor.
  ENDMETHOD.

  METHOD zif_model~select_t100.

    rt_t100 = VALUE #( ( sprsl = 'PT' arbgb = 'ZFICA006' msgnr = '000' text = 'Mensagens salvas com sucesso!' ) ).

  ENDMETHOD.
ENDCLASS.

CLASS lcl_controller DEFINITION.
  PUBLIC SECTION.
    DATA t_100 TYPE TABLE OF t100.
    METHODS constructor IMPORTING model TYPE REF TO zif_model.
    METHODS select_t100 RETURNING VALUE(rt_t100) TYPE tt_t100.
  PRIVATE SECTION.
    DATA o_model TYPE REF TO zif_model.
ENDCLASS.

CLASS lcl_controller IMPLEMENTATION.
  METHOD constructor.
    me->o_model = model.
  ENDMETHOD.

  METHOD select_t100.
    rt_t100 = o_model->select_t100( ).
  ENDMETHOD.
ENDCLASS.

CLASS lcl_view DEFINITION.
  PUBLIC SECTION.
    DATA t_t100 TYPE TABLE OF t100 READ-ONLY.
    METHODS start_of_selection.
    METHODS constructor.
  PRIVATE SECTION.
    DATA o_controller TYPE REF TO lcl_controller.
ENDCLASS.

CLASS lcl_view IMPLEMENTATION.
  METHOD constructor.
    DATA(o_model) = NEW lcl_model( ).
    o_controller = NEW lcl_controller( o_model ).
  ENDMETHOD.

  METHOD start_of_selection.
    t_t100 = o_controller->select_t100( ).

    LOOP AT t_t100 ASSIGNING FIELD-SYMBOL(<fs_t100>).
      WRITE: / <fs_t100>-text.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.

CLASS ltc_test DEFINITION FINAL FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    METHODS:
      setup,
      test_select_t100 FOR TESTING.

    DATA:
      o_fake_model TYPE REF TO lcl_model_fake,
      o_controller TYPE REF TO lcl_controller.
ENDCLASS.

CLASS ltc_test IMPLEMENTATION.
  METHOD setup.
    CREATE OBJECT o_fake_model.
  ENDMETHOD.

  METHOD test_select_t100.
    DATA(o_controller) = NEW lcl_controller( o_fake_model ).
    DATA(lt_t100) = o_controller->select_t100( ).

    cl_abap_unit_assert=>assert_not_initial( lt_t100 ).
  ENDMETHOD.
ENDCLASS.

INITIALIZATION.
  DATA(o_view) = NEW lcl_view( ).

START-OF-SELECTION.
  o_view->start_of_selection( ).
