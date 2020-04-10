Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 258FD1A4619
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Apr 2020 14:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgDJMAi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Apr 2020 08:00:38 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:33420 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgDJMAi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Apr 2020 08:00:38 -0400
Received: by mail-wm1-f46.google.com with SMTP id v8so4645358wma.0
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Apr 2020 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=0JPx+QF8YJSlaMU4E9WkvHVnVArpAjIAsfw6/f0Qpaw=;
        b=fzW3v7f+5WAx0sO+dVBQoc+FyvBs+hHucaRLOCNoNHZsNnj+espEJxpkwg+5cnrNZc
         xQaEphRyutybWIcdT5lREP1rE2EeGwW4s/isBhdWnyi4cXHNKcvHHP3bQB+z7WAlyrLY
         h7ybsZJvvx+/asdoFeEf4EBsuOL/+vskyE2ZLHe10b8ypPRC7Jo1y0xXTkMlqLZJjk7K
         svMY0gXR6SZno7bBIdIUj99GbPP2IW+N5O54+mnlIXGW3gUgZtF7oo/MhH228/8rbu4d
         21Zl8BT+jFYRGJD4wmOcFv/cY2ZFELTQ2nPUGpTbcFQqjUNEAi33mYihYQOfX6TOTJAW
         ZdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=0JPx+QF8YJSlaMU4E9WkvHVnVArpAjIAsfw6/f0Qpaw=;
        b=DLJnAtFF4tRpM8wQsYOjf4ALJAsqwEdc4np2SptCceKzWLpNEwRzk1dhEzfr8hf/fP
         073ZQ8OICuImBvvY5BMeDIq8C8X1XnYHJDty1t+0W3ijhatN7vlyQvwPRQeye2FLDegz
         xZRlOByYvzY93p4dV8Kj7EZ7YeF2iqy3v8TbgDwiIlncIPYZY1T5UkS1Wkgk2W+9Y3FC
         ystbRnZx7I5kqRjwEpvgNtATheHkEAYJhfaDjOSCUPbl6jcW80s/bxJP5TPRCor1Fd0c
         BzR7zoE9pnUka3YnQ64RdU737foJTDtvA+setpjBMj6UfzhJXXSbjUq1SgYNeJHs405R
         D4ww==
X-Gm-Message-State: AGi0PuYV2JXoYD2p6pODDX3kR9AxmJJRfP55q/jNiLTZ8QqZoD/LWN3J
        9aj2n+iAw8RMsnoPQ/cyWYTMmw==
X-Google-Smtp-Source: APiQypI0PAwgF6U50Wa0GKXoy5/Djktl/rW9EJHJoa0FYvh6SRS2sUcMbCfLP8nOHb9659jxjiQNyQ==
X-Received: by 2002:a1c:a7c2:: with SMTP id q185mr4929400wme.42.1586520033750;
        Fri, 10 Apr 2020 05:00:33 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id c17sm2573905wrp.28.2020.04.10.05.00.32
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 10 Apr 2020 05:00:33 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Fri, 10 Apr 2020 12:00:32 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <531058420.16972.1586520033104.JavaMail.javamailuser@localhost>
Subject: next-20200410 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_16971_1452009088.1586520032298"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_16971_1452009088.1586520032298
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 0434e521ce3b67f8305d91c3300e93821270cddf
git describe: next-20200410
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200410

Regressions (compared to build next-20200409)
------------------------------------------------------------------------
x86:                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * cgroup_test_freezer                                                                                                         
                                                                                         
    * rtc_rtctest                                                                                                         
                                                                                         
    * x86_fsgsbase_64                                                                                                         
                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200409)                                                                   
------------------------------------------------------------------------                                               
x86:                                                                                                      
 kselftest:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
qemu_x86_64:                                                                                                      
 kselftest:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         


In total:
------------------------------------------------------------------------
Ran 1643 total tests in the following environments and test suites.
pass 575
fail 909
xfail 0
skip 159

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- juno-r2-compat
- juno-r2-kasan
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------
* kselftest
* kselftest/drivers
* kselftest/filesystems
* kselftest/net
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net


Failures
------------------------------------------------------------------------

x86:
* kselftest-vsyscall-mode-native/filesystems/binderfs_binderfs_test
* kselftest/filesystems/binderfs_binderfs_test
* kselftest-vsyscall-mode-none/filesystems/binderfs_binderfs_test
* kselftest/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-native/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-none/bpf_get_cgroup_id_user
* kselftest/bpf_test_align
* kselftest-vsyscall-mode-native/bpf_test_align
* kselftest-vsyscall-mode-none/bpf_test_align
* kselftest-vsyscall-mode-none/bpf_test_bpftool.sh
* kselftest/bpf_test_bpftool.sh
* kselftest-vsyscall-mode-native/bpf_test_bpftool.sh
* kselftest/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-none/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-native/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-native/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest-vsyscall-mode-native/bpf_test_maps
* kselftest-vsyscall-mode-none/bpf_test_maps
* kselftest-vsyscall-mode-native/bpf_test_netcnt
* kselftest-vsyscall-mode-none/bpf_test_netcnt
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest-vsyscall-mode-none/bpf_test_progs
* kselftest-vsyscall-mode-native/bpf_test_progs
* kselftest/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-none/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-native/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-native/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-none/bpf_test_skb_cgroup_id.sh
* kselftest/bpf_test_skb_cgroup_id.sh
* kselftest/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-none/bpf_test_sock_addr.sh
* kselftest/bpf_test_socket_cookie
* kselftest-vsyscall-mode-none/bpf_test_socket_cookie
* kselftest-vsyscall-mode-native/bpf_test_socket_cookie
* kselftest-vsyscall-mode-none/bpf_test_sock_fields
* kselftest/bpf_test_sock_fields
* kselftest-vsyscall-mode-native/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest-vsyscall-mode-none/bpf_test_sockmap
* kselftest-vsyscall-mode-native/bpf_test_sockmap
* kselftest-vsyscall-mode-none/bpf_test_sysctl
* kselftest/bpf_test_sysctl
* kselftest-vsyscall-mode-native/bpf_test_sysctl
* kselftest-vsyscall-mode-native/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-none/bpf_test_tc_edt.sh
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-none/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-native/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-none/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-native/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-native/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-none/bpf_test_tcpnotify_user
* kselftest/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-native/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_xdping.sh
* kselftest/bpf_test_xdping.sh
* kselftest-vsyscall-mode-native/bpf_test_xdping.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_generic.sh
* kselftest/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_native.sh
* kselftest/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-none/cgroup_test_freezer
* kselftest/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-none/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-native/firmware_fw_run_tests.sh
* kselftest/net/forwarding_bridge_igmp.sh
* kselftest-vsyscall-mode-none/net/forwarding_bridge_igmp.sh
* kselftest-vsyscall-mode-native/net/forwarding_bridge_igmp.sh
* kselftest-vsyscall-mode-none/net/forwarding_bridge_port_isolation.sh
* kselftest/net/forwarding_bridge_port_isolation.sh
* kselftest-vsyscall-mode-native/net/forwarding_bridge_port_isolation.sh
* kselftest/net/forwarding_bridge_sticky_fdb.sh
* kselftest-vsyscall-mode-native/net/forwarding_bridge_sticky_fdb.sh
* kselftest-vsyscall-mode-none/net/forwarding_bridge_sticky_fdb.sh
* kselftest-vsyscall-mode-none/net/forwarding_bridge_vlan_aware.sh
* kselftest/net/forwarding_bridge_vlan_aware.sh
* kselftest-vsyscall-mode-native/net/forwarding_bridge_vlan_aware.sh
* kselftest/net/forwarding_bridge_vlan_unaware.sh
* kselftest-vsyscall-mode-none/net/forwarding_bridge_vlan_unaware.sh
* kselftest-vsyscall-mode-native/net/forwarding_bridge_vlan_unaware.sh
* kselftest/net/forwarding_ethtool.sh
* kselftest-vsyscall-mode-native/net/forwarding_ethtool.sh
* kselftest-vsyscall-mode-none/net/forwarding_ethtool.sh
* kselftest-vsyscall-mode-native/net/forwarding_gre_inner_v4_multipath.sh
* kselftest/net/forwarding_gre_inner_v4_multipath.sh
* kselftest-vsyscall-mode-none/net/forwarding_gre_inner_v4_multipath.sh
* kselftest-vsyscall-mode-none/net/forwarding_gre_inner_v6_multipath.sh
* kselftest/net/forwarding_gre_inner_v6_multipath.sh
* kselftest-vsyscall-mode-native/net/forwarding_gre_inner_v6_multipath.sh
* kselftest/net/forwarding_gre_multipath.sh
* kselftest-vsyscall-mode-none/net/forwarding_gre_multipath.sh
* kselftest-vsyscall-mode-native/net/forwarding_gre_multipath.sh
* kselftest-vsyscall-mode-native/net/forwarding_ip6gre_inner_v4_multipath.sh
* kselftest-vsyscall-mode-none/net/forwarding_ip6gre_inner_v4_multipath.sh
* kselftest-vsyscall-mode-native/net/forwarding_ip6gre_inner_v6_multipath.sh
* kselftest-vsyscall-mode-none/net/forwarding_ip6gre_inner_v6_multipath.sh
* kselftest/net/forwarding_ip6gre_inner_v6_multipath.sh
* kselftest-vsyscall-mode-native/net/forwarding_ipip_flat_gre_key.sh
* kselftest/net/forwarding_ipip_flat_gre_key.sh
* kselftest-vsyscall-mode-none/net/forwarding_ipip_flat_gre_key.sh
* kselftest-vsyscall-mode-none/net/forwarding_ipip_flat_gre_keys.sh
* kselftest-vsyscall-mode-native/net/forwarding_ipip_flat_gre_keys.sh
* kselftest/net/forwarding_ipip_flat_gre_keys.sh
* kselftest-vsyscall-mode-none/net/forwarding_ipip_flat_gre.sh
* kselftest/net/forwarding_ipip_flat_gre.sh
* kselftest-vsyscall-mode-native/net/forwarding_ipip_flat_gre.sh
* kselftest/net/forwarding_ipip_hier_gre_key.sh
* kselftest-vsyscall-mode-native/net/forwarding_ipip_hier_gre_key.sh
* kselftest-vsyscall-mode-none/net/forwarding_ipip_hier_gre_key.sh
* kselftest/net/forwarding_ipip_hier_gre_keys.sh
* kselftest-vsyscall-mode-native/net/forwarding_ipip_hier_gre_keys.sh
* kselftest-vsyscall-mode-none/net/forwarding_ipip_hier_gre_keys.sh
* kselftest-vsyscall-mode-native/net/forwarding_ipip_hier_gre.sh
* kselftest/net/forwarding_ipip_hier_gre.sh
* kselftest-vsyscall-mode-none/net/forwarding_ipip_hier_gre.sh
* kselftest/net/forwarding_loopback.sh
* kselftest-vsyscall-mode-native/net/forwarding_loopback.sh
* kselftest-vsyscall-mode-none/net/forwarding_loopback.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_bound.sh
* kselftest/net/forwarding_mirror_gre_bound.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_bound.sh
* kselftest/net/forwarding_mirror_gre_bridge_1d.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_bridge_1d.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_bridge_1d.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_bridge_1d_vlan.sh
* kselftest/net/forwarding_mirror_gre_bridge_1d_vlan.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_bridge_1d_vlan.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_bridge_1q_lag.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_bridge_1q_lag.sh
* kselftest/net/forwarding_mirror_gre_bridge_1q_lag.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_bridge_1q.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_bridge_1q.sh
* kselftest/net/forwarding_mirror_gre_bridge_1q.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_changes.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_changes.sh
* kselftest/net/forwarding_mirror_gre_changes.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_flower.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_flower.sh
* kselftest/net/forwarding_mirror_gre_flower.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_lag_lacp.sh
* kselftest/net/forwarding_mirror_gre_lag_lacp.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_lag_lacp.sh
* kselftest/net/forwarding_mirror_gre_neigh.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_neigh.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_neigh.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_nh.sh
* kselftest/net/forwarding_mirror_gre_nh.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_nh.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre.sh
* kselftest/net/forwarding_mirror_gre.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre.sh
* kselftest/net/forwarding_mirror_gre_vlan_bridge_1q.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_vlan_bridge_1q.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_vlan_bridge_1q.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_vlan.sh
* kselftest/net/forwarding_mirror_gre_vlan.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_vlan.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_vlan.sh
* kselftest/net/forwarding_mirror_vlan.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_vlan.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_bridge.sh
* kselftest/net/forwarding_router_bridge.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_bridge.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_bridge_vlan.sh
* kselftest/net/forwarding_router_bridge_vlan.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_bridge_vlan.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_broadcast.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_broadcast.sh
* kselftest/net/forwarding_router_broadcast.sh
* kselftest/net/forwarding_router_mpath_nh.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_mpath_nh.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_mpath_nh.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_multicast.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_multicast.sh
* kselftest/net/forwarding_router_multicast.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_multipath.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_multipath.sh
* kselftest/net/forwarding_router_multipath.sh
* kselftest-vsyscall-mode-none/net/forwarding_router.sh
* kselftest-vsyscall-mode-native/net/forwarding_router.sh
* kselftest/net/forwarding_router.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_vid_1.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_vid_1.sh
* kselftest/net/forwarding_router_vid_1.sh
* kselftest/net/forwarding_sch_ets.sh
* kselftest-vsyscall-mode-none/net/forwarding_sch_ets.sh
* kselftest-vsyscall-mode-native/net/forwarding_sch_ets.sh
* kselftest-vsyscall-mode-none/net/forwarding_sch_tbf_ets.sh
* kselftest/net/forwarding_sch_tbf_ets.sh
* kselftest-vsyscall-mode-native/net/forwarding_sch_tbf_ets.sh
* kselftest-vsyscall-mode-none/net/forwarding_sch_tbf_prio.sh
* kselftest-vsyscall-mode-native/net/forwarding_sch_tbf_prio.sh
* kselftest/net/forwarding_sch_tbf_prio.sh
* kselftest-vsyscall-mode-none/net/forwarding_sch_tbf_root.sh
* kselftest/net/forwarding_sch_tbf_root.sh
* kselftest-vsyscall-mode-native/net/forwarding_sch_tbf_root.sh
* kselftest-vsyscall-mode-none/net/forwarding_tc_actions.sh
* kselftest/net/forwarding_tc_actions.sh
* kselftest-vsyscall-mode-native/net/forwarding_tc_actions.sh
* kselftest-vsyscall-mode-native/net/forwarding_tc_chains.sh
* kselftest/net/forwarding_tc_chains.sh
* kselftest-vsyscall-mode-none/net/forwarding_tc_chains.sh
* kselftest/net/forwarding_tc_flower_router.sh
* kselftest-vsyscall-mode-native/net/forwarding_tc_flower_router.sh
* kselftest-vsyscall-mode-none/net/forwarding_tc_flower_router.sh
* kselftest/net/forwarding_tc_flower.sh
* kselftest-vsyscall-mode-none/net/forwarding_tc_flower.sh
* kselftest-vsyscall-mode-native/net/forwarding_tc_flower.sh
* kselftest/net/forwarding_tc_shblocks.sh
* kselftest-vsyscall-mode-none/net/forwarding_tc_shblocks.sh
* kselftest-vsyscall-mode-native/net/forwarding_tc_shblocks.sh
* kselftest-vsyscall-mode-none/net/forwarding_tc_vlan_modify.sh
* kselftest-vsyscall-mode-native/net/forwarding_tc_vlan_modify.sh
* kselftest/net/forwarding_tc_vlan_modify.sh
* kselftest-vsyscall-mode-native/net/forwarding_vxlan_asymmetric.sh
* kselftest-vsyscall-mode-none/net/forwarding_vxlan_asymmetric.sh
* kselftest/net/forwarding_vxlan_asymmetric.sh
* kselftest-vsyscall-mode-none/net/forwarding_vxlan_bridge_1d_port_8472.sh
* kselftest/net/forwarding_vxlan_bridge_1d_port_8472.sh
* kselftest-vsyscall-mode-native/net/forwarding_vxlan_bridge_1d_port_8472.sh
* kselftest-vsyscall-mode-none/net/forwarding_vxlan_bridge_1d.sh
* kselftest/net/forwarding_vxlan_bridge_1d.sh
* kselftest-vsyscall-mode-native/net/forwarding_vxlan_bridge_1d.sh
* kselftest-vsyscall-mode-none/net/forwarding_vxlan_bridge_1q_port_8472.sh
* kselftest/net/forwarding_vxlan_bridge_1q_port_8472.sh
* kselftest-vsyscall-mode-native/net/forwarding_vxlan_bridge_1q_port_8472.sh
* kselftest-vsyscall-mode-none/net/forwarding_vxlan_bridge_1q.sh
* kselftest-vsyscall-mode-native/net/forwarding_vxlan_bridge_1q.sh
* kselftest/net/forwarding_vxlan_bridge_1q.sh
* kselftest/net/forwarding_vxlan_symmetric.sh
* kselftest-vsyscall-mode-native/net/forwarding_vxlan_symmetric.sh
* kselftest-vsyscall-mode-none/net/forwarding_vxlan_symmetric.sh
* kselftest-vsyscall-mode-none/ftrace_ftracetest
* kselftest-vsyscall-mode-native/ftrace_ftracetest
* kselftest/ftrace_ftracetest
* kselftest-vsyscall-mode-native/intel_pstate_run.sh
* kselftest-vsyscall-mode-none/intel_pstate_run.sh
* kselftest/intel_pstate_run.sh
* kselftest-vsyscall-mode-none/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_clear_dirty_log_test
* kselftest/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_cr4_cpuid_sync_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-native/kvm_demand_paging_test
* kselftest/kvm_demand_paging_test
* kselftest-vsyscall-mode-none/kvm_demand_paging_test
* kselftest/kvm_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_evmcs_test
* kselftest/kvm_evmcs_test
* kselftest-vsyscall-mode-native/kvm_hyperv_cpuid
* kselftest/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-none/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-native/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-none/kvm_kvm_create_max_vcpus
* kselftest/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-native/kvm_platform_info_test
* kselftest/kvm_platform_info_test
* kselftest-vsyscall-mode-none/kvm_platform_info_test
* kselftest-vsyscall-mode-native/kvm_set_memory_region_test
* kselftest-vsyscall-mode-none/kvm_set_memory_region_test
* kselftest/kvm_set_memory_region_test
* kselftest/kvm_set_sregs_test
* kselftest-vsyscall-mode-none/kvm_set_sregs_test
* kselftest-vsyscall-mode-native/kvm_set_sregs_test
* kselftest-vsyscall-mode-none/kvm_smm_test
* kselftest/kvm_smm_test
* kselftest-vsyscall-mode-native/kvm_smm_test
* kselftest-vsyscall-mode-none/kvm_state_test
* kselftest-vsyscall-mode-native/kvm_state_test
* kselftest/kvm_state_test
* kselftest/kvm_steal_time
* kselftest-vsyscall-mode-none/kvm_steal_time
* kselftest-vsyscall-mode-native/kvm_steal_time
* kselftest/kvm_sync_regs_test
* kselftest-vsyscall-mode-native/kvm_sync_regs_test
* kselftest-vsyscall-mode-none/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-none/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-native/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-none/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-native/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-none/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-native/kvm_vmx_tsc_adjust_test
* kselftest/kvm_xss_msr_test
* kselftest-vsyscall-mode-none/kvm_xss_msr_test
* kselftest-vsyscall-mode-native/kvm_xss_msr_test
* kselftest/lib_printf.sh
* kselftest-vsyscall-mode-none/lib_printf.sh
* kselftest-vsyscall-mode-native/lib_printf.sh
* kselftest-vsyscall-mode-native/lkdtm_ACCESS_NULL.sh
* kselftest/lkdtm_ACCESS_NULL.sh
* kselftest-vsyscall-mode-none/lkdtm_ACCESS_NULL.sh
* kselftest-vsyscall-mode-native/lkdtm_ACCESS_USERSPACE.sh
* kselftest/lkdtm_ACCESS_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_ACCESS_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_BUG.sh
* kselftest/lkdtm_BUG.sh
* kselftest-vsyscall-mode-native/lkdtm_BUG.sh
* kselftest-vsyscall-mode-none/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest-vsyscall-mode-native/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_USER_DS.sh
* kselftest/lkdtm_CORRUPT_USER_DS.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_USER_DS.sh
* kselftest-vsyscall-mode-none/lkdtm_EXCEPTION.sh
* kselftest/lkdtm_EXCEPTION.sh
* kselftest-vsyscall-mode-native/lkdtm_EXCEPTION.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_DATA.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_DATA.sh
* kselftest/lkdtm_EXEC_DATA.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_KMALLOC.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_KMALLOC.sh
* kselftest/lkdtm_EXEC_KMALLOC.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_NULL.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_NULL.sh
* kselftest/lkdtm_EXEC_NULL.sh
* kselftest/lkdtm_EXEC_RODATA.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_RODATA.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_RODATA.sh
* kselftest/lkdtm_EXEC_STACK.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_STACK.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_STACK.sh
* kselftest/lkdtm_EXEC_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_USERSPACE.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_USERSPACE.sh
* kselftest/lkdtm_EXEC_VMALLOC.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_VMALLOC.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_VMALLOC.sh
* kselftest-vsyscall-mode-native/lkdtm_READ_AFTER_FREE.sh
* kselftest-vsyscall-mode-none/lkdtm_READ_AFTER_FREE.sh
* kselftest/lkdtm_READ_AFTER_FREE.sh
* kselftest/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest-vsyscall-mode-none/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest-vsyscall-mode-native/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_CROSS.sh
* kselftest/lkdtm_SLAB_FREE_CROSS.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_CROSS.sh
* kselftest/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_PAGE.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_PAGE.sh
* kselftest/lkdtm_SLAB_FREE_PAGE.sh
* kselftest-vsyscall-mode-none/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest-vsyscall-mode-native/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest-vsyscall-mode-native/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACKLEAK_ERASING.sh
* kselftest/lkdtm_STACKLEAK_ERASING.sh
* kselftest-vsyscall-mode-native/lkdtm_STACKLEAK_ERASING.sh
* kselftest/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest-vsyscall-mode-none/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest-vsyscall-mode-native/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest-vsyscall-mode-none/lkdtm_UNSET_SMEP.sh
* kselftest/lkdtm_UNSET_SMEP.sh
* kselftest-vsyscall-mode-native/lkdtm_UNSET_SMEP.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest/lkdtm_USERCOPY_KERNEL.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_KERNEL.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_KERNEL.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest/lkdtm_WARNING_MESSAGE.sh
* kselftest-vsyscall-mode-none/lkdtm_WARNING_MESSAGE.sh
* kselftest-vsyscall-mode-native/lkdtm_WARNING_MESSAGE.sh
* kselftest/lkdtm_WARNING.sh
* kselftest-vsyscall-mode-native/lkdtm_WARNING.sh
* kselftest-vsyscall-mode-none/lkdtm_WARNING.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_KERN.sh
* kselftest/lkdtm_WRITE_KERN.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_KERN.sh
* kselftest/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_RO.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_RO.sh
* kselftest/lkdtm_WRITE_RO.sh
* kselftest-vsyscall-mode-native/memfd_fuse_mnt
* kselftest-vsyscall-mode-none/memfd_fuse_mnt
* kselftest/memfd_fuse_mnt
* kselftest/memfd_fuse_test
* kselftest-vsyscall-mode-native/memfd_fuse_test
* kselftest-vsyscall-mode-none/memfd_fuse_test
* kselftest/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-native/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-none/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-none/net_altnames.sh
* kselftest/net_altnames.sh
* kselftest-vsyscall-mode-native/net_altnames.sh
* kselftest-vsyscall-mode-none/net_fib_nexthop_multiprefix.sh
* kselftest-vsyscall-mode-native/net_fib_nexthop_multiprefix.sh
* kselftest/net_fib_nexthop_multiprefix.sh
* kselftest-vsyscall-mode-native/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-none/net_fib_tests.sh
* kselftest-vsyscall-mode-native/net_fib_tests.sh
* kselftest/net_fib_tests.sh
* kselftest/netfilter_nft_concat_range.sh
* kselftest-vsyscall-mode-none/netfilter_nft_concat_range.sh
* kselftest-vsyscall-mode-native/netfilter_nft_concat_range.sh
* kselftest/netfilter_nft_queue.sh
* kselftest-vsyscall-mode-native/netfilter_nft_queue.sh
* kselftest-vsyscall-mode-none/netfilter_nft_queue.sh
* kselftest-vsyscall-mode-native/net_icmp_redirect.sh
* kselftest-vsyscall-mode-none/net_icmp_redirect.sh
* kselftest/net_icmp_redirect.sh
* kselftest/net_ip_defrag.sh
* kselftest-vsyscall-mode-none/net_ip_defrag.sh
* kselftest-vsyscall-mode-native/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest-vsyscall-mode-native/net_l2tp.sh
* kselftest-vsyscall-mode-none/net_l2tp.sh
* kselftest-vsyscall-mode-none/net_pmtu.sh
* kselftest/net_pmtu.sh
* kselftest-vsyscall-mode-native/net_pmtu.sh
* kselftest-vsyscall-mode-none/net_psock_snd.sh
* kselftest-vsyscall-mode-native/net_psock_snd.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest-vsyscall-mode-native/net_run_netsocktests
* kselftest-vsyscall-mode-none/net_run_netsocktests
* kselftest-vsyscall-mode-none/net_test_vxlan_under_vrf.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-native/net_test_vxlan_under_vrf.sh
* kselftest/net_traceroute.sh
* kselftest-vsyscall-mode-native/net_traceroute.sh
* kselftest-vsyscall-mode-none/net_traceroute.sh
* kselftest-vsyscall-mode-native/net_txtimestamp.sh
* kselftest/net_txtimestamp.sh
* kselftest-vsyscall-mode-none/net_txtimestamp.sh
* kselftest-vsyscall-mode-none/net_udpgro_bench.sh
* kselftest-vsyscall-mode-native/net_udpgro_bench.sh
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest-vsyscall-mode-none/net_udpgro.sh
* kselftest-vsyscall-mode-native/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest-vsyscall-mode-native/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_xfrm_policy.sh
* kselftest-vsyscall-mode-native/net_xfrm_policy.sh
* kselftest/net_xfrm_policy.sh
* kselftest/openat2_openat2_test
* kselftest-vsyscall-mode-none/openat2_openat2_test
* kselftest-vsyscall-mode-native/openat2_openat2_test
* kselftest/openat2_rename_attack_test
* kselftest-vsyscall-mode-none/openat2_rename_attack_test
* kselftest-vsyscall-mode-native/openat2_rename_attack_test
* kselftest/openat2_resolve_test
* kselftest-vsyscall-mode-native/openat2_resolve_test
* kselftest-vsyscall-mode-none/openat2_resolve_test
* kselftest-vsyscall-mode-none/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-native/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-none/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-native/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-none/pstore_pstore_tests
* kselftest/pstore_pstore_tests
* kselftest-vsyscall-mode-native/pstore_pstore_tests
* kselftest-vsyscall-mode-native/ptrace_vmaccess
* kselftest/ptrace_vmaccess
* kselftest-vsyscall-mode-none/ptrace_vmaccess
* kselftest/rtc_rtctest
* kselftest-vsyscall-mode-native/rtc_rtctest
* kselftest-vsyscall-mode-none/rtc_rtctest
* kselftest/seccomp_seccomp_bpf
* kselftest-vsyscall-mode-native/seccomp_seccomp_bpf
* kselftest-vsyscall-mode-none/seccomp_seccomp_bpf
* kselftest/timers_inconsistency-check
* kselftest-vsyscall-mode-native/timers_inconsistency-check
* kselftest-vsyscall-mode-none/timers_inconsistency-check
* kselftest-vsyscall-mode-native/timers_nsleep-lat
* kselftest-vsyscall-mode-none/timers_nsleep-lat
* kselftest/timers_nsleep-lat
* kselftest/timers_raw_skew
* kselftest-vsyscall-mode-none/timers_raw_skew
* kselftest-vsyscall-mode-native/timers_raw_skew
* kselftest/timers_set-timer-lat
* kselftest-vsyscall-mode-native/timers_set-timer-lat
* kselftest-vsyscall-mode-none/timers_set-timer-lat
* kselftest/vm_run_vmtests
* kselftest-vsyscall-mode-native/vm_run_vmtests
* kselftest-vsyscall-mode-none/vm_run_vmtests
* kselftest-vsyscall-mode-none/x86_fsgsbase_64

x15:

juno-r2:

qemu_arm64:

qemu_x86_64:
* kselftest/filesystems/binderfs_binderfs_test
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_align
* kselftest/bpf_test_bpftool.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_progs-no_alu32
* kselftest/bpf_test_skb_cgroup_id.sh
* kselftest/bpf_test_sock_addr.sh
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_sysctl
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_redirect.sh
* kselftest/bpf_test_xdp_vlan_mode_generic.sh
* kselftest/bpf_test_xdp_vlan_mode_native.sh
* kselftest/cpufreq_main.sh
* kselftest/firmware_fw_run_tests.sh
* kselftest/net/forwarding_bridge_igmp.sh
* kselftest/net/forwarding_bridge_port_isolation.sh
* kselftest/net/forwarding_bridge_sticky_fdb.sh
* kselftest/net/forwarding_bridge_vlan_aware.sh
* kselftest/net/forwarding_bridge_vlan_unaware.sh
* kselftest/net/forwarding_ethtool.sh
* kselftest/net/forwarding_gre_inner_v4_multipath.sh
* kselftest/net/forwarding_gre_inner_v6_multipath.sh
* kselftest/net/forwarding_gre_multipath.sh
* kselftest/net/forwarding_ip6gre_inner_v4_multipath.sh
* kselftest/net/forwarding_ip6gre_inner_v6_multipath.sh
* kselftest/net/forwarding_ipip_flat_gre_key.sh
* kselftest/net/forwarding_ipip_flat_gre_keys.sh
* kselftest/net/forwarding_ipip_flat_gre.sh
* kselftest/net/forwarding_ipip_hier_gre_key.sh
* kselftest/net/forwarding_ipip_hier_gre_keys.sh
* kselftest/net/forwarding_ipip_hier_gre.sh
* kselftest/net/forwarding_loopback.sh
* kselftest/net/forwarding_mirror_gre_bound.sh
* kselftest/net/forwarding_mirror_gre_bridge_1d.sh
* kselftest/net/forwarding_mirror_gre_bridge_1d_vlan.sh
* kselftest/net/forwarding_mirror_gre_bridge_1q_lag.sh
* kselftest/net/forwarding_mirror_gre_bridge_1q.sh
* kselftest/net/forwarding_mirror_gre_changes.sh
* kselftest/net/forwarding_mirror_gre_flower.sh
* kselftest/net/forwarding_mirror_gre_lag_lacp.sh
* kselftest/net/forwarding_mirror_gre_neigh.sh
* kselftest/net/forwarding_mirror_gre_nh.sh
* kselftest/net/forwarding_mirror_gre.sh
* kselftest/net/forwarding_mirror_gre_vlan_bridge_1q.sh
* kselftest/net/forwarding_mirror_gre_vlan.sh
* kselftest/net/forwarding_mirror_vlan.sh
* kselftest/net/forwarding_router_bridge.sh
* kselftest/net/forwarding_router_bridge_vlan.sh
* kselftest/net/forwarding_router_broadcast.sh
* kselftest/net/forwarding_router_mpath_nh.sh
* kselftest/net/forwarding_router_multicast.sh
* kselftest/net/forwarding_router_multipath.sh
* kselftest/net/forwarding_router.sh
* kselftest/net/forwarding_router_vid_1.sh
* kselftest/net/forwarding_sch_ets.sh
* kselftest/net/forwarding_sch_tbf_ets.sh
* kselftest/net/forwarding_sch_tbf_prio.sh
* kselftest/net/forwarding_sch_tbf_root.sh
* kselftest/net/forwarding_tc_actions.sh
* kselftest/net/forwarding_tc_chains.sh
* kselftest/net/forwarding_tc_flower_router.sh
* kselftest/net/forwarding_tc_flower.sh
* kselftest/net/forwarding_tc_shblocks.sh
* kselftest/net/forwarding_tc_vlan_modify.sh
* kselftest/net/forwarding_vxlan_asymmetric.sh
* kselftest/net/forwarding_vxlan_bridge_1d_port_8472.sh
* kselftest/net/forwarding_vxlan_bridge_1d.sh
* kselftest/net/forwarding_vxlan_bridge_1q_port_8472.sh
* kselftest/net/forwarding_vxlan_bridge_1q.sh
* kselftest/net/forwarding_vxlan_symmetric.sh
* kselftest/ftrace_ftracetest
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest/kvm_demand_paging_test
* kselftest/kvm_dirty_log_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_kvm_create_max_vcpus
* kselftest/kvm_platform_info_test
* kselftest/kvm_set_memory_region_test
* kselftest/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest/kvm_state_test
* kselftest/kvm_steal_time
* kselftest/kvm_svm_vmcall_test
* kselftest/kvm_sync_regs_test
* kselftest/kvm_xss_msr_test
* kselftest/lib_printf.sh
* kselftest/lkdtm_ACCESS_NULL.sh
* kselftest/lkdtm_ACCESS_USERSPACE.sh
* kselftest/lkdtm_BUG.sh
* kselftest/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest/lkdtm_CORRUPT_USER_DS.sh
* kselftest/lkdtm_EXCEPTION.sh
* kselftest/lkdtm_EXEC_DATA.sh
* kselftest/lkdtm_EXEC_KMALLOC.sh
* kselftest/lkdtm_EXEC_NULL.sh
* kselftest/lkdtm_EXEC_RODATA.sh
* kselftest/lkdtm_EXEC_STACK.sh
* kselftest/lkdtm_EXEC_USERSPACE.sh
* kselftest/lkdtm_EXEC_VMALLOC.sh
* kselftest/lkdtm_READ_AFTER_FREE.sh
* kselftest/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest/lkdtm_SLAB_FREE_CROSS.sh
* kselftest/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest/lkdtm_SLAB_FREE_PAGE.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest/lkdtm_STACKLEAK_ERASING.sh
* kselftest/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest/lkdtm_UNSET_SMEP.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest/lkdtm_USERCOPY_KERNEL.sh
* kselftest/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest/lkdtm_WARNING_MESSAGE.sh
* kselftest/lkdtm_WARNING.sh
* kselftest/lkdtm_WRITE_KERN.sh
* kselftest/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest/lkdtm_WRITE_RO.sh
* kselftest/memfd_fuse_mnt
* kselftest/memfd_fuse_test
* kselftest/mqueue_mq_perf_tests
* kselftest/net_altnames.sh
* kselftest/net_fib_nexthop_multiprefix.sh
* kselftest/net_fib_tests.sh
* kselftest/netfilter_nft_concat_range.sh
* kselftest/netfilter_nft_queue.sh
* kselftest/net_icmp_redirect.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_txtimestamp.sh
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/net_xfrm_policy.sh
* kselftest/openat2_openat2_test
* kselftest/openat2_rename_attack_test
* kselftest/openat2_resolve_test
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/pstore_pstore_tests
* kselftest/ptrace_vmaccess
* kselftest/rtc_rtctest
* kselftest/seccomp_seccomp_bpf
* kselftest/timers_inconsistency-check
* kselftest/timers_nsleep-lat
* kselftest/timers_raw_skew
* kselftest/timers_set-timer-lat
* kselftest/vm_run_vmtests
* kselftest/x86_fsgsbase_64

qemu_i386:
* kselftest/filesystems/binderfs_binderfs_test
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_align
* kselftest/bpf_test_bpftool.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_hashmap
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_progs-no_alu32
* kselftest/bpf_test_skb_cgroup_id.sh
* kselftest/bpf_test_sock_addr.sh
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_sysctl
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_redirect.sh
* kselftest/bpf_test_xdp_vlan_mode_generic.sh
* kselftest/bpf_test_xdp_vlan_mode_native.sh
* kselftest/clone3_clone3_clear_sighand
* kselftest/cpufreq_main.sh
* kselftest/firmware_fw_run_tests.sh
* kselftest/ftrace_ftracetest
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest/kvm_demand_paging_test
* kselftest/kvm_dirty_log_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_kvm_create_max_vcpus
* kselftest/kvm_mmio_warning_test
* kselftest/kvm_platform_info_test
* kselftest/kvm_set_memory_region_test
* kselftest/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest/kvm_state_test
* kselftest/kvm_steal_time
* kselftest/kvm_svm_vmcall_test
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/kvm_xss_msr_test
* kselftest/lib_printf.sh
* kselftest/lkdtm_ACCESS_NULL.sh
* kselftest/lkdtm_ACCESS_USERSPACE.sh
* kselftest/lkdtm_BUG.sh
* kselftest/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest/lkdtm_CORRUPT_USER_DS.sh
* kselftest/lkdtm_DOUBLE_FAULT.sh
* kselftest/lkdtm_EXCEPTION.sh
* kselftest/lkdtm_EXEC_DATA.sh
* kselftest/lkdtm_EXEC_KMALLOC.sh
* kselftest/lkdtm_EXEC_NULL.sh
* kselftest/lkdtm_EXEC_RODATA.sh
* kselftest/lkdtm_EXEC_STACK.sh
* kselftest/lkdtm_EXEC_USERSPACE.sh
* kselftest/lkdtm_EXEC_VMALLOC.sh
* kselftest/lkdtm_READ_AFTER_FREE.sh
* kselftest/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest/lkdtm_SLAB_FREE_CROSS.sh
* kselftest/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest/lkdtm_SLAB_FREE_PAGE.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest/lkdtm_STACKLEAK_ERASING.sh
* kselftest/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest/lkdtm_UNSET_SMEP.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest/lkdtm_USERCOPY_KERNEL.sh
* kselftest/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest/lkdtm_WARNING_MESSAGE.sh
* kselftest/lkdtm_WARNING.sh
* kselftest/lkdtm_WRITE_KERN.sh
* kselftest/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest/lkdtm_WRITE_RO.sh
* kselftest/memfd_fuse_mnt
* kselftest/memfd_fuse_test
* kselftest/mount_run_tests.sh
* kselftest/mqueue_mq_perf_tests
* kselftest/net_run_netsocktests

i386:

dragonboard-410c:

juno-r2-kasan:

juno-r2-compat:

hi6220-hikey:

x86-kasan:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_16971_1452009088.1586520032298--
