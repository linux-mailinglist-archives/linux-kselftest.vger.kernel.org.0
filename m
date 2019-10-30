Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 492C2EA3E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2019 20:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfJ3TPo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Oct 2019 15:15:44 -0400
Received: from smtprelay0036.hostedemail.com ([216.40.44.36]:44742 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726304AbfJ3TPo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Oct 2019 15:15:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id F3B86181D341A;
        Wed, 30 Oct 2019 19:15:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::,RULES_HIT:4:41:355:379:599:966:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:2194:2195:2196:2197:2198:2199:2200:2201:2202:2203:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3653:3865:3867:3870:3871:3872:3874:4321:4384:4385:4395:4605:5007:7903:8526:9010:9012:10004:10848:11026:11232:11658:11914:12043:12109:12297:12438:12740:12760:12895:13255:13439:13972:14096:14097:14659:21080:21221:21627:21740:30012:30054:30091,0,RBL:47.151.135.224:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:24,LUA_SUMMARY:none
X-HE-Tag: dress32_88cddd72e9a00
X-Filterd-Recvd-Size: 18607
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Oct 2019 19:15:39 +0000 (UTC)
Message-ID: <2b3b48a8512d2c567fce388394ad1d262d31908e.camel@perches.com>
Subject: Re: [PATCH linux-kselftest/test v6] lib/list-test: add a test for
 the 'list' doubly linked list
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, shuah <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 30 Oct 2019 12:15:30 -0700
In-Reply-To: <20191030184600.GC18421@kadam>
References: <20191024224631.118656-1-davidgow@google.com>
         <0cb1d948-0da3-eb0f-c58f-ae3a785dd0dd@kernel.org>
         <CABVgOSmCHbGjZBjeWSbPEZbJw22SaBQnoO77xxNzN_ugAwzNiQ@mail.gmail.com>
         <20191030104217.GA18421@kadam>
         <42a8270d-ed6f-d29f-5e71-7b76a074b63e@kernel.org>
         <20191030184600.GC18421@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 2019-10-30 at 21:46 +0300, Dan Carpenter wrote:
> Hm...  I imagined the checkpatch code a little different in my head but
> this would also work to make it stricter.  I doubt it miss very many
> real life style problems.

Well, doubts vs reality...

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3607,7 +3607,7 @@ sub process {
>  
>  # if/while/etc brace do not go on next line, unless defining a do while loop,
>  # or if that brace on the next line is for something else
> -		if ($line =~ /(.*)\b((?:if|while|for|switch|(?:[a-z_]+|)for_each[a-z_]+)\s*\(|do\b|else\b)/ && $line !~ /^.\s*\#/) {
> +		if ($line =~ /(.*)\b((?:if|while|for|switch|(?:list|hlist)_for_each[a-z_]+)\s*\(|do\b|else\b)/ && $line !~ /^.\s*\#/) {
>  			my $pre_ctx = "$1$2";
>  
>  			my ($level, @ctx) = ctx_statement_level($linenr, $realcnt, 0);

So - nak

$ git grep -P '(?:[a-z0-9_]+_)?for_each(?:_[a-z0-9_]+)?' -- '*.[ch]' | \
  grep -P -oh '(?:[a-z0-9_]+_)?for_each(?:_[a-z0-9_]+)?' | \
  sort | uniq -c | sort -rn | grep -v -P '(?:h?list_| for_each)'
    225 netdev_for_each_mc_addr
    157 device_for_each_child
    132 idr_for_each_entry
    101 nla_for_each_nested
     96 drm_for_each_connector_iter
     91 kvm_for_each_vcpu
     88 rdev_for_each
     82 scsi_for_each_sg
     75 ata_for_each_dev
     73 sk_for_each
     66 bus_for_each_dev
     64 xa_for_each
     62 hash_for_each_possible
     59 shost_for_each_device
     54 idr_for_each
     54 efx_for_each_channel
     48 hash_for_each_safe
     48 ata_for_each_link
     47 ef4_for_each_channel
     46 snd_pcm_group_for_each_entry
     46 bond_for_each_slave
     44 netdev_for_each_uc_addr
     44 drm_for_each_crtc
     39 rbtree_postorder_for_each_entry_safe
     38 xas_for_each
     37 bio_for_each_segment_all
     36 of_property_for_each_string
     36 bio_for_each_segment
     32 radix_tree_for_each_slot
     31 class_for_each_device
     30 queue_for_each_hw_ctx
     29 rq_for_each_segment
     28 of_property_for_each_u32
     28 drm_connector_for_each_possible_encoder
     27 drm_atomic_for_each_plane_damage
     27 bond_for_each_slave_rcu
     26 snd_array_for_each
     26 rdma_for_each_port
     26 drm_for_each_encoder
     26 device_for_each_child_node
     25 ubi_rb_for_each_entry
     24 driver_for_each_device
     23 nla_for_each_attr
     23 hash_for_each
     23 drm_for_each_plane
     21 xas_for_each_marked
     21 snd_soc_dapm_widget_for_each_sink_path
     21 pci_bus_for_each_resource
     21 drm_mm_for_each_node_safe
     20 __shost_for_each_device
     20 mdesc_for_each_node_by_name
     20 mdesc_for_each_arc
     20 iscsi_host_for_each_session
     19 media_device_for_each_entity
     19 drm_client_for_each_modeset
     19 bus_for_each_drv
     18 pci_for_each_dma_alias
     18 nexthop_for_each_fib6_nh
     18 netdev_for_each_lower_dev
     18 label_for_each
     18 in_dev_for_each_ifa_rcu
     18 efx_for_each_channel_tx_queue
     17 starget_for_each_device
     17 snd_soc_dapm_widget_for_each_source_path
     17 hash_for_each_possible_rcu
     17 eeh_for_each_pe
     17 drm_for_each_plane_mask
     17 css_for_each_descendant_pre
     16 wl12xx_for_each_wlvif
     16 rhl_for_each_entry_rcu
     16 ice_for_each_traffic_class
     16 fn_for_each_confined
     16 ebitmap_for_each_positive_bit
     16 bpf_object__for_each_program
     15 tx_queue_for_each
     15 fn_for_each
     15 flow_action_for_each
     15 ef4_for_each_channel_tx_queue
     15 eeh_pe_for_each_dev
     15 drm_for_each_encoder_mask
     15 cpufreq_for_each_valid_entry
     14 rdev_for_each_rcu
     14 kvm_for_each_memslot
     14 ice_for_each_vsi
     14 hists__for_each_format
     13 xa_for_each_marked
     13 pwrdm_for_each
     13 klp_for_each_object
     13 in_dev_for_each_ifa_rtnl
     13 ice_for_each_q_vector
     13 efx_for_each_channel_rx_queue
     13 drm_for_each_detailed_block
     13 cgroup_taskset_for_each
     12 v4l2_device_for_each_subdev
     12 __rq_for_each_bio
     12 rcu_for_each_leaf_node
     12 drm_atomic_crtc_for_each_plane
     11 wl12xx_for_each_wlvif_sta
     11 while_for_each_ftrace_op
     11 sctp_skb_for_each
     11 queue_for_each
     11 qed_for_each_vf
     11 klp_for_each_func
     11 iommu_group_for_each_dev
     11 ide_port_for_each_present_dev
     11 i2c_for_each_dev
     11 hash_for_each_rcu
     11 ef4_for_each_channel_rx_queue
     11 do_for_each_ftrace_rec
     11 cpufreq_for_each_valid_entry_idx
     11 cpufreq_for_each_entry
     10 while_for_each_ftrace_rec
     10 sk_for_each_bound
     10 rpc_clnt_iterate_for_each_xprt
     10 of_for_each_phandle
     10 input_handler_for_each_handle
     10 drm_mm_for_each_node
     10 do_for_each_ftrace_op
     10 clkdm_for_each
     10 bpf_object__for_each_map
      9 vlan_group_for_each_dev
      9 vlan_for_each
      9 toptree_for_each
      9 perf_event_for_each_child
      9 ixgbe_for_each_ring
      9 io_wq_for_each_worker
      9 ide_port_for_each_dev
      9 i3c_bus_for_each_i3cdev
      9 dp_for_each_set_bit
      9 ax25_for_each
      8 vfio_pci_for_each_slot_or_bus
      8 usbhs_for_each_pipe_with_dcp
      8 usb_for_each_dev
      8 snd_soc_dapm_widget_for_each_path
      8 sk_nulls_for_each
      8 sk_for_each_rcu
      8 rt2x00queue_for_each_entry
      8 rht_for_each_from
      8 rcu_for_each_node_breadth_first
      8 omap_hwmod_for_each
      8 netdev_for_each_tx_queue
      8 ide_host_for_each_port
      8 hashmap__for_each_key_entry
      8 hashmap__for_each_entry
      8 fn_for_each_in_ns
      8 fdt_for_each_subnode
      8 drm_mm_for_each_hole
      8 drm_atomic_crtc_state_for_each_plane
      8 device_for_each_child_reverse
      8 cpuset_for_each_descendant_pre
      8 __bio_for_each_segment
      7 vsock_for_each_connected_socket
      7 tcf_exts_for_each_action
      7 snd_soc_dapm_for_each_direction
      7 sk_nulls_for_each_rcu
      7 sctp_for_each_hentry
      7 rdma_for_each_block
      7 radix_tree_for_each_tagged
      7 pnp_for_each_dev
      7 pack_for_each_init
      7 netdev_for_each_upper_dev_rcu
      7 mtd_for_each_device
      7 mlx5e_for_each_hash_node
      7 key_for_each
      7 kcore_copy__for_each_phdr
      7 ixgbevf_for_each_ring
      7 intel_atomic_crtc_state_for_each_plane_state
      7 idr_for_each_entry_continue
      7 i3c_bus_for_each_i2cdev
      7 hsr_for_each_port
      7 fdt_for_each_property_offset
      7 drm_atomic_crtc_state_for_each_plane_state
      7 dma_fence_chain_for_each
      7 data__for_each_file
      7 blkg_for_each_descendant_pre
      7 ath_for_each_chanctx
      7 ata_qc_for_each_raw
      6 xa_for_each_start
      6 while_for_each_event_file
      6 v4l2_m2m_for_each_src_buf_safe
      6 uwb_dev_for_each
      6 usb_hub_for_each_child
      6 __starget_for_each_device
      6 sbitmap_for_each_set
      6 perf_config_items__for_each_entry
      6 page_chain_for_each
      6 omap2_clk_for_each
      6 nlmsg_for_each_attr
      6 map__for_each_symbol
      6 machine__for_each_thread
      6 label_for_each_in_ns
      6 label_for_each_confined
      6 ipmr_for_each_table
      6 ice_for_each_txq
      6 ice_for_each_rxq
      6 func_for_each_insn_all
      6 dpm_for_each_dev
      6 do_for_each_event_file
      6 dfl_fpga_dev_for_each_feature
      6 css_for_each_descendant_post
      6 css_for_each_child
      6 cpuset_for_each_child
      6 cgroup_for_each_live_descendant_pre
      6 blkg_for_each_descendant_post
      6 at91_for_each_port
      5 wl12xx_for_each_wlvif_ap
      5 usb3_for_each_dma
      5 unwind_for_each_frame
      5 udp_portaddr_for_each_entry_rcu
      5 trace_probe_for_each_link_rcu
      5 rq_for_each_bvec
      5 rht_for_each_rcu
      5 rds_for_each_conn_info
      5 ppr_for_each_entry
      5 omap_hwmod_for_each_by_class
      5 nouveau_for_each_non_mst_connector_iter
      5 nft_rule_for_each_expr
      5 label_for_each_cont
      5 klp_for_each_patch
      5 ip6mr_for_each_table
      5 __iommu_group_for_each_dev
      5 intel_gvt_for_each_tracked_mmio
      5 inet_bind_bucket_for_each
      5 idr_for_each_entry_ul
      5 ice_for_each_ring
      5 i40e_for_each_ring
      5 hashmap__for_each_entry_safe
      5 hash_for_each_possible_safe
      5 gen_pool_for_each_chunk
      5 gadget_for_each_ep
      5 fwnode_for_each_child_node
      5 fm10k_for_each_ring
      5 fec_for_each_buffer_rs_block
      5 enclosure_for_each_device
      5 drm_client_for_each_connector_iter
      5 drbd_for_each_overlap
      5 devres_for_each_res
      5 db_for_each_64
      5 cpufreq_for_each_entry_idx
      5 bpf_for_each_spilled_reg
      5 bip_for_each_vec
      5 bio_for_each_bvec
      5 b53_for_each_port
      5 ax25_uid_for_each
      4 xen_for_each_gfn
      4 xan_for_each_marked
      4 wpan_phy_for_each
      4 v4l2_m2m_for_each_dst_buf_safe
      4 usbhs_for_each_dfifo
      4 toptree_for_each_child_safe
      4 target_for_each_device
      4 ssb_for_each_bus_call
      4 srcu_for_each_node_breadth_first
      4 sk_for_each_safe
      4 sk_for_each_from
      4 sk_for_each_entry_offset_rcu
      4 sctp_for_each_transport
      4 sctp_for_each_endpoint
      4 __sbitmap_for_each_set
      4 resort_rb__for_each_entry
      4 register_for_each_vma
      4 rdev_for_each_list
      4 rbt_ib_umem_for_each_in_range
      4 qeth_for_each_output_queue
      4 ping_portaddr_for_each_entry
      4 perf_event_for_each
      4 perf_cpu_map__for_each_cpu
      4 perf_config_set__for_each_entry
      4 pcpu_for_each_unpop_region
      4 nr_node_for_each_safe
      4 nr_node_for_each
      4 nlmsg_for_each_msg
      4 nfp_for_each_insn_walk2
      4 __neigh_for_each_release
      4 neigh_for_each
      4 mlxsw_sp_rif_neigh_for_each
      4 mlxsw_sp_nexthop_for_each
      4 idr_for_each_entry_continue_ul
      4 hists__for_each_sort_list
      4 hctx_for_each_ctx
      4 fwnode_for_each_available_child_node
      4 fs_for_each_prio
      4 elf_symtab__for_each_symbol
      4 efx_for_each_possible_channel_tx_queue
      4 ef4_for_each_possible_channel_tx_queue
      4 drm_mm_for_each_node_in_range
      4 drm_for_each_legacy_plane
      4 drm_for_each_fb
      4 do_for_each_event_file_safe
      4 cma_for_each_area
      4 chp_id_for_each
      4 cgroup_taskset_for_each_leader
      4 cgroup_for_each_live_descendant_post
      4 card_for_each_dev
      4 bt_tags_for_each
      4 __btree_for_each
      4 bt_for_each
      4 bpf_object__for_each_safe
      4 __ata_qc_for_each
      4 ata_qc_for_each
      4 apei_exec_for_each_entry
      4 apei_estatus_for_each_section
      4 amdgpu_umc_for_each_channel
      4 acpi_nvs_for_each_region
      3 xas_for_each_conflict
      3 wl12xx_for_each_wlvif_bss_type
      3 vnic_hash_for_each
      3 v4l2_m2m_for_each_dst_buf
      3 uwb_dev_for_each_f
      3 __usbhsh_for_each_udev
      3 usbhsg_for_each_uep_with_dcp
      3 __usbhsg_for_each_uep
      3 __usbhs_for_each_pipe
      3 usb3_for_each_ep
      3 ubi_for_each_used_peb
      3 ubi_for_each_protected_peb
      3 ubi_for_each_free_peb
      3 txall_queue_for_each
      3 toptree_for_each_safe
      3 toptree_for_each_child
      3 tcm_for_each_slice
      3 symbols__for_each_entry
      3 simple_for_each_link
      3 shdma_for_each_chan
      3 sec_for_each_insn_from
      3 sec_for_each_insn
      3 sctp_for_each_tx_datachunk
      3 sb_for_each_fn
      3 rocker_tlv_for_each
      3 rht_for_each_rcu_from
      3 rht_for_each_entry_rcu_from
      3 rht_for_each_entry_from
      3 reiserfs_for_each_xattr
      3 rdev_for_each_safe
      3 rcar_thermal_for_each_priv
      3 perf_event_groups_for_each
      3 pcpu_for_each_md_free_region
      3 pcpu_for_each_fit_region
      3 nr_neigh_for_each_safe
      3 nr_neigh_for_each
      3 nanddev_io_for_each_page
      3 mtrr_for_each_mem_type
      3 mlxsw_sp_prefix_usage_for_each
      3 mlxsw_afk_element_usage_for_each
      3 mlx5_esw_for_each_vf_vport_num_reverse
      3 mlx5_esw_for_each_host_func_vport
      3 mlx5e_for_each_arfs_rule
      3 media_device_for_each_intf
      3 machines__for_each_thread
      3 iov_iter_for_each_range
      3 inet_lhash2_for_each_icsk_rcu
      3 ice_for_each_alloc_txq
      3 ice_for_each_alloc_rxq
      3 iavf_for_each_ring
      3 hns3_for_each_ring
      3 graph_for_each_link
      3 gmap_for_each_rmap_safe
      3 genradix_for_each
      3 gen6_for_each_pde
      3 fwnode_graph_for_each_endpoint
      3 fs_for_each_ft
      3 fq_ring_for_each
      3 __for_each_sgt_daddr
      3 fn_for_each_not_in_set
      3 fifo_for_each
      3 fec_for_each_prealloc_buffer
      3 fec_for_each_extra_buffer
      3 fec_for_each_buffer
      3 dsos__for_each_with_build_id
      3 dso__for_each_symbol
      3 drm_for_each_privobj
      3 drm_for_each_lessee
      3 data__for_each_file_start
      3 data__for_each_file_new
      3 dapm_kcontrol_for_each_path
      3 btree_for_each_safe64
      3 btree_for_each_safe32
      3 btf_for_each_str_off
      3 bpf__for_each_map_named
      3 bio_for_each_integrity_vec
      3 ata_qc_for_each_with_internal
      3 arm_ccn_for_each_valid_region
      2 zorro_for_each_dev
      2 wl12xx_for_each_wlvif_continue
      2 vtb_for_each_detailed_block
      2 vnic_hash_for_each_safe
      2 vnic_hash_for_each_possible
      2 virtio_device_for_each_vq
      2 v4l2_m2m_for_each_src_buf
      2 usbhsh_for_each_udev_with_dev0
      2 usbhsh_for_each_udev
      2 udp_portaddr_for_each_entry
      2 ubi_for_each_scrub_peb
      2 trace_probe_for_each_link
      2 test_for_each_set_clump8
      2 tb_property_for_each
      2 snd_soc_dapm_widget_for_each_path_safe
      2 sk_nulls_for_each_from
      2 sctp_for_each_rx_skb
      2 scsi_for_each_prot_sg
      2 rocker_tlv_for_each_nested
      2 rht_for_each_entry_safe
      2 rht_for_each_entry_rcu
      2 rht_for_each_entry
      2 rht_for_each
      2 rhl_for_each_rcu
      2 protocol_for_each_dev
      2 protocol_for_each_card
      2 pnp_for_each_card
      2 perf_config_sections__for_each_entry
      2 pcpu_for_each_pop_region
      2 pci_mmcfg_for_each_region
      2 page_chain_for_each_safe
      2 of_property_for_each_string_index
      2 nfp_for_each_insn_walk3
      2 netdev_for_each_lower_private_rcu
      2 netdev_for_each_lower_private
      2 mlx5_esw_for_each_vf_vport_num
      2 mlx5_esw_for_each_vf_vport
      2 mlx5_esw_for_each_vf_rep_reverse
      2 mlx5_esw_for_each_vf_rep
      2 mlx5_esw_for_each_host_func_vport_reverse
      2 mlx5_esw_for_each_host_func_rep
      2 mlx5e_for_each_hash_arfs_rule
      2 media_device_for_each_pad
      2 media_device_for_each_link
      2 __map__for_each_symbol_by_name
      2 map__for_each_symbol_by_name
      2 libbpf_nla_for_each_attr
      2 __labelset_for_each
      2 label_for_each_in_merge
      2 label_for_each_comb
      2 klp_for_each_patch_safe
      2 klp_for_each_object_static
      2 klp_for_each_object_safe
      2 klp_for_each_func_static
      2 klp_for_each_func_safe
      2 key_for_each_safe
      2 hashmap__for_each_key_entry_safe
      2 hash_for_each_possible_rcu_notrace
      2 genradix_for_each_from
      2 func_for_each_insn_continue_reverse
      2 func_for_each_insn
      2 fs_for_each_ns
      2 fs_for_each_fg
      2 __for_each_thread
      2 __for_each_child_of_node
      2 elf_section__for_each_rela
      2 elf_section__for_each_rel
      2 efx_for_each_channel_rev
      2 ef4_for_each_channel_rev
      2 drm_crtc_for_each_plane
      2 devcom_for_each_component
      2 cgroup_for_each_live_child
      2 cea_for_each_detailed_block
      2 carl9170fw_for_each_hdr
      2 bpf__for_each_map
      2 __bio_for_each_bvec
      1 usbhsg_for_each_uep
      1 usbhs_for_each_pipe
      1 ubi_for_each_scub_peb
      1 toptree_for_each_sibling
      1 snd_soc_dapm_widget_for_each_sink_path_safe
      1 sec_for_each_insn_continue
      1 rmi_for_each_dev
      1 pwrdm_for_each_nolock
      1 pwrdm_for_each_clkdm
      1 pneigh_for_each
      1 perf_config_set__for_each
      1 perf_config_sections__for_each
      1 perf_config_items__for_each
      1 nilfs_for_each_segbuf_before
      1 nand_io_for_each_page
      1 mlx5_esw_for_each_vf_vport_reverse
      1 mlx5_esw_for_each_host_func_rep_reverse
      1 map__for_each_symbol_with_name
      1 label_for_each_not_in_set
      1 gmap_for_each_rmap
      1 fs_for_each_ns_or_ft_reverse
      1 fs_for_each_ns_or_ft
      1 fs_for_each_ft_safe
      1 fs_for_each_fte
      1 fs_for_each_dst
      1 fn_for_each_in_merge
      1 fn_for_each_comb
      1 drm_crtc_atomic_state_for_each_plane_state
      1 drm_crtc_atomic_state_for_each_plane
      1 class_for_each_dev
      1 bus_for_each
      1 btree_for_each_safel
      1 btree_for_each_safe128
      1 bpf_map__for_each
      1 blk_queue_for_each_rl


