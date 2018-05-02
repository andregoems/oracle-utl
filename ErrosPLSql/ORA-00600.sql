alter session set query_rewrite_enabled=false;

alter session set "_query_rewrite_vop_cleanup"=false;

alter session set "_complex_view_merging"=false;

alter session set optimizer_features_enable = "11.1.0.7";