Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C081A282F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Apr 2020 20:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgDHSAi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Apr 2020 14:00:38 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:39771 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgDHSAi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Apr 2020 14:00:38 -0400
Received: by mail-wr1-f54.google.com with SMTP id p10so8896661wrt.6
        for <linux-kselftest@vger.kernel.org>; Wed, 08 Apr 2020 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=hQp0iThNRSTVRYwgESrYJW6KTfAyWpZ8Le87SHwXcwk=;
        b=dzg0rqMJF4DuRukKFCznXE/oiRmO6WePN2Ek276sX4G019TMLHUL4jJ9zvY7yNVAa5
         jtazVYlE3wi33zP1Ic35zG6gkd01qP69NEiXpv9/810UPspeqQ7IT0YfMhOU1a6fj7sX
         iF+U9/+K7/j7+/M0x5wqlrS1rh+J2yioByELRKjEJ9DLsIDMPLetimrloSWX8kAdMHlS
         lRrtICMB+MhDpMo2XK3LLxpqnIqJXU1aotV5Y0YPwvx4H+LAwyoz7mg5n9XEBZpxWYvO
         EPY8EL7QVlQm6rdAPw+6GWP05RjMvUdVTc+vkt4ng/NYiNE+l9RPNXBrJao5mS7fmru9
         DpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=hQp0iThNRSTVRYwgESrYJW6KTfAyWpZ8Le87SHwXcwk=;
        b=hrAY+ZKoxmXu5yByUyfZWiph8vsS/qWrN9T/jRcq70vu2TbaMh1vBxmXqrSEp+10p6
         BGDnrZ6EX2YD41O3ujkEa8cQL2U2t9eEz0G5w6UdEblW7MRdFPvt6N1v1xsQDhrDDW4n
         P6tuUcUY4/6nM/8aVJot5eF/oV7RDXqh9wVP1HOUan37so2c8q9ismGp4JsB8UPV8LNn
         lLZkeR6ZHcBGxXhWepL9bF2T4eMR6T1K3eB7yfmLFm0w9e3DrIILijCTFCcVbeYU+iHw
         s9Cq+mvSwFb/UrHH19tK67z8yd5wzm/zGinGjREWHzcPVmuyzr2ZiXFEx6dk1PPH2Xcy
         6r+Q==
X-Gm-Message-State: AGi0PuaL+H8D2lBLe42/MMX1U4yeo6NrNLL7pdD5QYF9Jbc5rVE2StlP
        76YnNcvS81AtFk3afi3gMrYI0q/ujPA=
X-Google-Smtp-Source: APiQypIjDi6HdoZ7gOkTQPHnP0n3nKJCHiPggMvEgC4uWYaouycqjCD+bDdIBuROYwhcS1kOTz2D2A==
X-Received: by 2002:adf:b1c8:: with SMTP id r8mr9543214wra.218.1586368831659;
        Wed, 08 Apr 2020 11:00:31 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id j10sm19334577wru.85.2020.04.08.11.00.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Apr 2020 11:00:30 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Wed, 8 Apr 2020 18:00:30 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <1548904165.15768.1586368830901.JavaMail.javamailuser@localhost>
Subject: next-20200407 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_15767_1502203509.1586368830293"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_15767_1502203509.1586368830293
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 5fab54423a0a88c4333e802155eeee944e82195b
git describe: next-20200407
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200407

Regressions (compared to build next-20200406)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200406)                                                                   
------------------------------------------------------------------------                                               
x86:                                                                                                      
 kselftest:                                                                                         
    * rtc_rtctest                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
                                                                                         
    * x86_fsgsbase_64                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * rtc_rtctest                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
                                                                                         
    * x86_fsgsbase_64                                                                                                         
qemu_x86_64:                                                                                                      
 kselftest:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         


In total:
------------------------------------------------------------------------
Ran 1777 total tests in the following environments and test suites.
pass 602
fail 991
xfail 0
skip 184

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
* kselftest/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest/lkdtm_UNSET_SMEP.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest/lkdtm_USERCOPY_KERNEL.sh
* kselftest/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest/lkdtm_WARNING_MESSAGE.sh
* kselftest/lkdtm_WARNING.sh
* kselftest/lkdtm_WRITE_KERN.sh
* kselftest/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest/lkdtm_WRITE_RO.sh

x86:
* kselftest-vsyscall-mode-native/filesystems/binderfs_binderfs_test
* kselftest-vsyscall-mode-none/filesystems/binderfs_binderfs_test
* kselftest-vsyscall-mode-none/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-native/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-none/bpf_test_align
* kselftest-vsyscall-mode-native/bpf_test_align
* kselftest-vsyscall-mode-native/bpf_test_bpftool.sh
* kselftest-vsyscall-mode-none/bpf_test_bpftool.sh
* kselftest-vsyscall-mode-none/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-native/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-native/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-none/bpf_test_maps
* kselftest-vsyscall-mode-native/bpf_test_maps
* kselftest-vsyscall-mode-none/bpf_test_netcnt
* kselftest-vsyscall-mode-native/bpf_test_netcnt
* kselftest-vsyscall-mode-none/bpf_test_progs
* kselftest-vsyscall-mode-native/bpf_test_progs
* kselftest-vsyscall-mode-none/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-native/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-native/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-none/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-none/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_socket_cookie
* kselftest-vsyscall-mode-none/bpf_test_socket_cookie
* kselftest-vsyscall-mode-native/bpf_test_sock_fields
* kselftest-vsyscall-mode-none/bpf_test_sock_fields
* kselftest-vsyscall-mode-native/bpf_test_sockmap
* kselftest-vsyscall-mode-none/bpf_test_sockmap
* kselftest-vsyscall-mode-none/bpf_test_sysctl
* kselftest-vsyscall-mode-native/bpf_test_sysctl
* kselftest-vsyscall-mode-native/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-none/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-none/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-native/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-native/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-none/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-none/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-native/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-native/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_xdping.sh
* kselftest-vsyscall-mode-native/bpf_test_xdping.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-native/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-none/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-native/net/forwarding_bridge_igmp.sh
* kselftest-vsyscall-mode-none/net/forwarding_bridge_igmp.sh
* kselftest-vsyscall-mode-native/net/forwarding_bridge_port_isolation.sh
* kselftest-vsyscall-mode-none/net/forwarding_bridge_port_isolation.sh
* kselftest-vsyscall-mode-none/net/forwarding_bridge_sticky_fdb.sh
* kselftest-vsyscall-mode-native/net/forwarding_bridge_sticky_fdb.sh
* kselftest-vsyscall-mode-native/net/forwarding_bridge_vlan_aware.sh
* kselftest-vsyscall-mode-none/net/forwarding_bridge_vlan_aware.sh
* kselftest-vsyscall-mode-native/net/forwarding_bridge_vlan_unaware.sh
* kselftest-vsyscall-mode-none/net/forwarding_bridge_vlan_unaware.sh
* kselftest-vsyscall-mode-native/net/forwarding_ethtool.sh
* kselftest-vsyscall-mode-none/net/forwarding_ethtool.sh
* kselftest-vsyscall-mode-none/net/forwarding_gre_inner_v4_multipath.sh
* kselftest-vsyscall-mode-native/net/forwarding_gre_inner_v4_multipath.sh
* kselftest-vsyscall-mode-native/net/forwarding_gre_inner_v6_multipath.sh
* kselftest-vsyscall-mode-none/net/forwarding_gre_inner_v6_multipath.sh
* kselftest-vsyscall-mode-native/net/forwarding_gre_multipath.sh
* kselftest-vsyscall-mode-none/net/forwarding_gre_multipath.sh
* kselftest-vsyscall-mode-native/net/forwarding_ip6gre_inner_v4_multipath.sh
* kselftest-vsyscall-mode-none/net/forwarding_ip6gre_inner_v4_multipath.sh
* kselftest-vsyscall-mode-native/net/forwarding_ip6gre_inner_v6_multipath.sh
* kselftest-vsyscall-mode-none/net/forwarding_ip6gre_inner_v6_multipath.sh
* kselftest-vsyscall-mode-none/net/forwarding_ipip_flat_gre_key.sh
* kselftest-vsyscall-mode-native/net/forwarding_ipip_flat_gre_keys.sh
* kselftest-vsyscall-mode-none/net/forwarding_ipip_flat_gre_keys.sh
* kselftest-vsyscall-mode-native/net/forwarding_ipip_flat_gre.sh
* kselftest-vsyscall-mode-none/net/forwarding_ipip_flat_gre.sh
* kselftest-vsyscall-mode-native/net/forwarding_ipip_hier_gre_key.sh
* kselftest-vsyscall-mode-none/net/forwarding_ipip_hier_gre_key.sh
* kselftest-vsyscall-mode-native/net/forwarding_ipip_hier_gre_keys.sh
* kselftest-vsyscall-mode-none/net/forwarding_ipip_hier_gre_keys.sh
* kselftest-vsyscall-mode-none/net/forwarding_ipip_hier_gre.sh
* kselftest-vsyscall-mode-native/net/forwarding_ipip_hier_gre.sh
* kselftest-vsyscall-mode-native/net/forwarding_loopback.sh
* kselftest-vsyscall-mode-none/net/forwarding_loopback.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_bound.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_bound.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_bridge_1d.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_bridge_1d.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_bridge_1d_vlan.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_bridge_1d_vlan.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_bridge_1q_lag.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_bridge_1q_lag.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_bridge_1q.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_bridge_1q.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_changes.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_changes.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_flower.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_flower.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_lag_lacp.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_lag_lacp.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_neigh.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_neigh.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_nh.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_nh.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_vlan_bridge_1q.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_vlan_bridge_1q.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_gre_vlan.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_gre_vlan.sh
* kselftest-vsyscall-mode-none/net/forwarding_mirror_vlan.sh
* kselftest-vsyscall-mode-native/net/forwarding_mirror_vlan.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_bridge.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_bridge.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_bridge_vlan.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_bridge_vlan.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_broadcast.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_broadcast.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_mpath_nh.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_mpath_nh.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_multicast.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_multicast.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_multipath.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_multipath.sh
* kselftest-vsyscall-mode-none/net/forwarding_router.sh
* kselftest-vsyscall-mode-native/net/forwarding_router.sh
* kselftest-vsyscall-mode-native/net/forwarding_router_vid_1.sh
* kselftest-vsyscall-mode-none/net/forwarding_router_vid_1.sh
* kselftest-vsyscall-mode-none/net/forwarding_sch_ets.sh
* kselftest-vsyscall-mode-native/net/forwarding_sch_ets.sh
* kselftest-vsyscall-mode-native/net/forwarding_sch_tbf_ets.sh
* kselftest-vsyscall-mode-none/net/forwarding_sch_tbf_ets.sh
* kselftest-vsyscall-mode-none/net/forwarding_sch_tbf_prio.sh
* kselftest-vsyscall-mode-native/net/forwarding_sch_tbf_prio.sh
* kselftest-vsyscall-mode-native/net/forwarding_sch_tbf_root.sh
* kselftest-vsyscall-mode-none/net/forwarding_sch_tbf_root.sh
* kselftest-vsyscall-mode-none/net/forwarding_tc_actions.sh
* kselftest-vsyscall-mode-native/net/forwarding_tc_actions.sh
* kselftest-vsyscall-mode-native/net/forwarding_tc_chains.sh
* kselftest-vsyscall-mode-none/net/forwarding_tc_chains.sh
* kselftest-vsyscall-mode-none/net/forwarding_tc_flower_router.sh
* kselftest-vsyscall-mode-native/net/forwarding_tc_flower_router.sh
* kselftest-vsyscall-mode-none/net/forwarding_tc_flower.sh
* kselftest-vsyscall-mode-native/net/forwarding_tc_flower.sh
* kselftest-vsyscall-mode-native/net/forwarding_tc_shblocks.sh
* kselftest-vsyscall-mode-none/net/forwarding_tc_shblocks.sh
* kselftest-vsyscall-mode-none/net/forwarding_tc_vlan_modify.sh
* kselftest-vsyscall-mode-native/net/forwarding_tc_vlan_modify.sh
* kselftest-vsyscall-mode-native/net/forwarding_vxlan_asymmetric.sh
* kselftest-vsyscall-mode-none/net/forwarding_vxlan_asymmetric.sh
* kselftest-vsyscall-mode-none/net/forwarding_vxlan_bridge_1d_port_8472.sh
* kselftest-vsyscall-mode-native/net/forwarding_vxlan_bridge_1d_port_8472.sh
* kselftest-vsyscall-mode-native/net/forwarding_vxlan_bridge_1d.sh
* kselftest-vsyscall-mode-none/net/forwarding_vxlan_bridge_1d.sh
* kselftest-vsyscall-mode-native/net/forwarding_vxlan_bridge_1q_port_8472.sh
* kselftest-vsyscall-mode-none/net/forwarding_vxlan_bridge_1q_port_8472.sh
* kselftest-vsyscall-mode-none/net/forwarding_vxlan_bridge_1q.sh
* kselftest-vsyscall-mode-native/net/forwarding_vxlan_bridge_1q.sh
* kselftest-vsyscall-mode-none/net/forwarding_vxlan_symmetric.sh
* kselftest-vsyscall-mode-native/net/forwarding_vxlan_symmetric.sh
* kselftest-vsyscall-mode-none/ftrace_ftracetest
* kselftest-vsyscall-mode-native/ftrace_ftracetest
* kselftest-vsyscall-mode-native/intel_pstate_run.sh
* kselftest-vsyscall-mode-none/intel_pstate_run.sh
* kselftest-vsyscall-mode-native/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-native/kvm_demand_paging_test
* kselftest-vsyscall-mode-none/kvm_demand_paging_test
* kselftest-vsyscall-mode-native/kvm_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_evmcs_test
* kselftest-vsyscall-mode-native/kvm_evmcs_test
* kselftest-vsyscall-mode-none/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-native/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-none/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-native/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-none/kvm_platform_info_test
* kselftest-vsyscall-mode-native/kvm_platform_info_test
* kselftest-vsyscall-mode-none/kvm_set_memory_region_test
* kselftest-vsyscall-mode-native/kvm_set_memory_region_test
* kselftest-vsyscall-mode-native/kvm_set_sregs_test
* kselftest-vsyscall-mode-none/kvm_set_sregs_test
* kselftest-vsyscall-mode-none/kvm_smm_test
* kselftest-vsyscall-mode-native/kvm_smm_test
* kselftest-vsyscall-mode-none/kvm_state_test
* kselftest-vsyscall-mode-native/kvm_state_test
* kselftest-vsyscall-mode-none/kvm_steal_time
* kselftest-vsyscall-mode-native/kvm_steal_time
* kselftest-vsyscall-mode-native/kvm_sync_regs_test
* kselftest-vsyscall-mode-none/kvm_sync_regs_test
* kselftest-vsyscall-mode-native/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-none/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-native/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-none/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-native/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-none/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-native/kvm_xss_msr_test
* kselftest-vsyscall-mode-none/kvm_xss_msr_test
* kselftest-vsyscall-mode-none/lib_printf.sh
* kselftest-vsyscall-mode-native/lib_printf.sh
* kselftest-vsyscall-mode-none/lkdtm_ACCESS_NULL.sh
* kselftest-vsyscall-mode-native/lkdtm_ACCESS_NULL.sh
* kselftest-vsyscall-mode-none/lkdtm_ACCESS_USERSPACE.sh
* kselftest-vsyscall-mode-native/lkdtm_ACCESS_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_BUG.sh
* kselftest-vsyscall-mode-native/lkdtm_BUG.sh
* kselftest-vsyscall-mode-native/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest-vsyscall-mode-none/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_USER_DS.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_USER_DS.sh
* kselftest-vsyscall-mode-native/lkdtm_EXCEPTION.sh
* kselftest-vsyscall-mode-none/lkdtm_EXCEPTION.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_DATA.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_DATA.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_KMALLOC.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_KMALLOC.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_NULL.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_NULL.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_RODATA.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_RODATA.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_STACK.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_STACK.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_VMALLOC.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_VMALLOC.sh
* kselftest-vsyscall-mode-native/lkdtm_READ_AFTER_FREE.sh
* kselftest-vsyscall-mode-none/lkdtm_READ_AFTER_FREE.sh
* kselftest-vsyscall-mode-none/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest-vsyscall-mode-native/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_CROSS.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_CROSS.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_PAGE.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_PAGE.sh
* kselftest-vsyscall-mode-native/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest-vsyscall-mode-native/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACKLEAK_ERASING.sh
* kselftest-vsyscall-mode-native/lkdtm_STACKLEAK_ERASING.sh
* kselftest-vsyscall-mode-native/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest-vsyscall-mode-none/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest-vsyscall-mode-native/lkdtm_UNSET_SMEP.sh
* kselftest-vsyscall-mode-none/lkdtm_UNSET_SMEP.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_KERNEL.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_KERNEL.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_WARNING_MESSAGE.sh
* kselftest-vsyscall-mode-native/lkdtm_WARNING_MESSAGE.sh
* kselftest-vsyscall-mode-none/lkdtm_WARNING.sh
* kselftest-vsyscall-mode-native/lkdtm_WARNING.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_KERN.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_KERN.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_RO.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_RO.sh
* kselftest-vsyscall-mode-none/memfd_fuse_mnt
* kselftest-vsyscall-mode-native/memfd_fuse_mnt
* kselftest-vsyscall-mode-none/memfd_fuse_test
* kselftest-vsyscall-mode-native/memfd_fuse_test
* kselftest-vsyscall-mode-native/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-none/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-native/net_altnames.sh
* kselftest-vsyscall-mode-none/net_altnames.sh
* kselftest-vsyscall-mode-native/net_fib_nexthop_multiprefix.sh
* kselftest-vsyscall-mode-none/net_fib_nexthop_multiprefix.sh
* kselftest-vsyscall-mode-none/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-native/net_fib_tests.sh
* kselftest-vsyscall-mode-none/net_fib_tests.sh
* kselftest-vsyscall-mode-native/netfilter_nft_concat_range.sh
* kselftest-vsyscall-mode-none/netfilter_nft_concat_range.sh
* kselftest-vsyscall-mode-native/netfilter_nft_queue.sh
* kselftest-vsyscall-mode-none/netfilter_nft_queue.sh
* kselftest-vsyscall-mode-native/net_icmp_redirect.sh
* kselftest-vsyscall-mode-none/net_icmp_redirect.sh
* kselftest-vsyscall-mode-none/net_ip_defrag.sh
* kselftest-vsyscall-mode-native/net_ip_defrag.sh
* kselftest-vsyscall-mode-none/net_l2tp.sh
* kselftest-vsyscall-mode-native/net_l2tp.sh
* kselftest-vsyscall-mode-native/net_pmtu.sh
* kselftest-vsyscall-mode-none/net_pmtu.sh
* kselftest-vsyscall-mode-native/net_psock_snd.sh
* kselftest-vsyscall-mode-none/net_psock_snd.sh
* kselftest-vsyscall-mode-native/net_run_netsocktests
* kselftest-vsyscall-mode-none/net_run_netsocktests
* kselftest-vsyscall-mode-native/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-none/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-native/net_traceroute.sh
* kselftest-vsyscall-mode-none/net_traceroute.sh
* kselftest-vsyscall-mode-none/net_txtimestamp.sh
* kselftest-vsyscall-mode-native/net_txtimestamp.sh
* kselftest-vsyscall-mode-none/net_udpgro_bench.sh
* kselftest-vsyscall-mode-native/net_udpgro_bench.sh
* kselftest-vsyscall-mode-native/net_udpgro.sh
* kselftest-vsyscall-mode-none/net_udpgro.sh
* kselftest-vsyscall-mode-native/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_xfrm_policy.sh
* kselftest-vsyscall-mode-native/net_xfrm_policy.sh
* kselftest-vsyscall-mode-none/openat2_openat2_test
* kselftest-vsyscall-mode-native/openat2_openat2_test
* kselftest-vsyscall-mode-native/openat2_rename_attack_test
* kselftest-vsyscall-mode-none/openat2_rename_attack_test
* kselftest-vsyscall-mode-native/openat2_resolve_test
* kselftest-vsyscall-mode-none/openat2_resolve_test
* kselftest-vsyscall-mode-none/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-native/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-none/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-native/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-native/pstore_pstore_tests
* kselftest-vsyscall-mode-none/pstore_pstore_tests
* kselftest-vsyscall-mode-none/ptrace_vmaccess
* kselftest-vsyscall-mode-native/ptrace_vmaccess
* kselftest-vsyscall-mode-native/rtc_rtctest
* kselftest-vsyscall-mode-none/rtc_rtctest
* kselftest-vsyscall-mode-native/seccomp_seccomp_bpf
* kselftest-vsyscall-mode-none/seccomp_seccomp_bpf
* kselftest-vsyscall-mode-native/timers_inconsistency-check
* kselftest-vsyscall-mode-none/timers_inconsistency-check
* kselftest-vsyscall-mode-none/timers_nsleep-lat
* kselftest-vsyscall-mode-native/timers_nsleep-lat
* kselftest-vsyscall-mode-none/timers_raw_skew
* kselftest-vsyscall-mode-native/timers_raw_skew
* kselftest-vsyscall-mode-none/timers_set-timer-lat
* kselftest-vsyscall-mode-native/timers_set-timer-lat
* kselftest-vsyscall-mode-none/vm_run_vmtests
* kselftest-vsyscall-mode-native/vm_run_vmtests
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
* kselftest/intel_pstate_run.sh
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
* kselftest/kvm_sync_regs_test
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
* kselftest/net_fib-onlink-tests.sh
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
* kselftest/net_traceroute.sh
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
* kselftest/seccomp_seccomp_bpf
* kselftest/timers_inconsistency-check
* kselftest/timers_nsleep-lat
* kselftest/timers_raw_skew
* kselftest/timers_set-timer-lat
* kselftest/vm_run_vmtests

x15:

dragonboard-410c:

juno-r2:

juno-r2-kasan:

juno-r2-compat:

x86-kasan:

i386:
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
* kselftest/firmware_fw_run_tests.sh
* kselftest/ftrace_ftracetest
* kselftest/intel_pstate_run.sh
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
* kselftest/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest/lkdtm_SLAB_FREE_CROSS.sh
* kselftest/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest/lkdtm_SLAB_FREE_PAGE.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest/lkdtm_UNSET_SMEP.sh
* kselftest/lkdtm_WARNING_MESSAGE.sh
* kselftest/lkdtm_WARNING.sh
* kselftest/lkdtm_WRITE_KERN.sh
* kselftest/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest/lkdtm_WRITE_RO.sh

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

qemu_arm64:

hi6220-hikey:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_15767_1502203509.1586368830293--
