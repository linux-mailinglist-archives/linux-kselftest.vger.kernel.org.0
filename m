Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2115B18CE58
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Mar 2020 14:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCTNAh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Mar 2020 09:00:37 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:42218 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgCTNAh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Mar 2020 09:00:37 -0400
Received: by mail-wr1-f48.google.com with SMTP id v11so7323645wrm.9
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Mar 2020 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=Xhfkn6y+NNJSuqZNsXsxHgT3naZfXhd0+8DljCa8R3I=;
        b=gmmE8b5DE8zJ8MNNiRme6M7ygPYT5Q42eXVdWIATJY7hIC7fT2p4ntcaTs2erBB0li
         c+ClVrm6oCNFOGWL1cx1FZ7VS27TSubgQ7cHRz87LWCE37F4hAwVFaTxmk1WC0iZty+E
         lDHVlb/D2nHhOkxrxDhgeC3NjzxExirekToQnTkYGF28Fze+KuV3dfJ46/zPDS4WeK9f
         nfphTaDovoj8bc7exG0x8r5ND02kKl6+/N0r7VoVCO1IRzsWOUmGRs0NjekttnWw8Irw
         Uqa7ZH4K0g6uvooOsVYOJhVSP1+NG4r1WQ08ukuERf7yFLX6z/iMBECWBCcUsvHBNl6h
         3CFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=Xhfkn6y+NNJSuqZNsXsxHgT3naZfXhd0+8DljCa8R3I=;
        b=dfZ1YP7VFh4duP/obq82UVJ1LMWh4SIdmLK2h7da7yanbfYhXrFgUBYHW49yTTgVQU
         xmByDCl9dVyc10m25JFLTESLQMMjLaawjGNyijC90YqALzktVb1gyMULvISYRzJIJOez
         5ywhlYZoVRNWtkLjj51z7/fdEmG+WHpBXFcnGRh28QMuMv7WcOm3q+7n3/jPVcOIKLrf
         7xQWr6T/zK14QqLk8CKz7CuGOapVaqGuaaUN2+nz/wIWwDRJOZ57iK9ZJL+T2bJK0bzo
         UxedPJngsiPAUqDiGSNeSY/3f5Ve5Qy38H+x7PdfioYn+8TNRSkm/vekpEepiLe8nD08
         5mvQ==
X-Gm-Message-State: ANhLgQ1hNc7U9xK+BDCSw4eVR0TcGDUf+i2ejZHPRE5Knn+au9uMxTgs
        wu1FdZN55qFUqCARJROT1g083g==
X-Google-Smtp-Source: ADFU+vt1mBPDeHvC/tzwRq1jw7JgvDb5YACtdzB1ZJPym7MnaJGCFiO4c0ChGFHVrXVbbjRxfh6pig==
X-Received: by 2002:a05:6000:144:: with SMTP id r4mr10335317wrx.190.1584709230183;
        Fri, 20 Mar 2020 06:00:30 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id t16sm4543778wra.17.2020.03.20.06.00.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Mar 2020 06:00:29 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Fri, 20 Mar 2020 13:00:28 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <411460208.10801.1584709229560.JavaMail.javamailuser@localhost>
Subject: next-20200320 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_10800_458678328.1584709228883"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_10800_458678328.1584709228883
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0-rc6
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: d8f289c16fbb72e17b783175c1fb0942816264fd
git describe: next-20200320
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200320

Regressions (compared to build next-20200319)
------------------------------------------------------------------------
qemu_x86_64:                                                                                                      
 kselftest:                                                                                         
    * net_traceroute.sh                                                                                                         
                                                                                                      
 kselftest/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
qemu_x86_64:                                                                                                      
 kselftest:                                                                                         
    * net_traceroute.sh                                                                                                         
                                                                                                      
 kselftest/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
juno-r2:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_lpm_map                                                                                                         
                                                                                                      
 kselftest/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
juno-r2:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_lpm_map                                                                                                         
                                                                                                      
 kselftest/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
i386:                                                                                                      
 kselftest/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * memory-hotplug_mem-on-off-test.sh                                                                                                         
                                                                                                      
 kselftest/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * x86_fsgsbase_64                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * memory-hotplug_mem-on-off-test.sh                                                                                                         
                                                                                                      
 kselftest/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * x86_fsgsbase_64                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * memory-hotplug_mem-on-off-test.sh                                                                                                         
                                                                                                      
 kselftest/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * x86_fsgsbase_64                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * memory-hotplug_mem-on-off-test.sh                                                                                                         
                                                                                                      
 kselftest/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * x86_fsgsbase_64                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * memory-hotplug_mem-on-off-test.sh                                                                                                         
                                                                                                      
 kselftest/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * x86_fsgsbase_64                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
qemu_i386:                                                                                                      
 kselftest:                                                                                         
    * futex_run.sh                                                                                                         
                                                                                                      
 kselftest/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
qemu_i386:                                                                                                      
 kselftest:                                                                                         
    * futex_run.sh                                                                                                         
                                                                                                      
 kselftest/filesystems:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200319)                                                                   
------------------------------------------------------------------------                                               
x86:                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
                                                                                         
    * x86_fsgsbase_64                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * rtc_rtctest                                                                                                         
x86:                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
                                                                                         
    * x86_fsgsbase_64                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * rtc_rtctest                                                                                                         


In total:
------------------------------------------------------------------------
Ran 2177 total tests in the following environments and test suites.
pass 771
fail 1137
xfail 0
skip 269

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
* kselftest/networking
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-native/drivers
* kselftest-vsyscall-mode-native/filesystems
* kselftest-vsyscall-mode-native/net
* kselftest-vsyscall-mode-native/networking
* kselftest-vsyscall-mode-none
* kselftest-vsyscall-mode-none/drivers
* kselftest-vsyscall-mode-none/filesystems
* kselftest-vsyscall-mode-none/net
* kselftest-vsyscall-mode-none/networking


Failures
------------------------------------------------------------------------

x15:

juno-r2:
* kselftest/filesystems/binderfs_binderfs_test
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lpm_map
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
* kselftest/bpf_test_tag
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_verifier
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_redirect.sh
* kselftest/bpf_test_xdp_vlan_mode_generic.sh
* kselftest/bpf_test_xdp_vlan_mode_native.sh
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
* kselftest/memory-hotplug_mem-on-off-test.sh
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_rule_tests.sh
* kselftest/net_fib_tests.sh
* kselftest/netfilter_conntrack_icmp_related.sh
* kselftest/netfilter_nft_concat_range.sh
* kselftest/netfilter_nft_nat.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/pidfd_pidfd_fdinfo_test
* kselftest/pidfd_pidfd_test

x86:
* kselftest/filesystems/binderfs_binderfs_test
* kselftest-vsyscall-mode-native/filesystems/binderfs_binderfs_test
* kselftest-vsyscall-mode-none/filesystems/binderfs_binderfs_test
* kselftest/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-none/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-native/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-native/bpf_test_bpftool.sh
* kselftest/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-none/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-native/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-native/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-none/bpf_test_netcnt
* kselftest/bpf_test_netcnt
* kselftest-vsyscall-mode-native/bpf_test_netcnt
* kselftest-vsyscall-mode-none/bpf_test_progs-no_alu32
* kselftest/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-native/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-native/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-none/bpf_test_skb_cgroup_id.sh
* kselftest/bpf_test_skb_cgroup_id.sh
* kselftest/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-none/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-none/bpf_test_socket_cookie
* kselftest/bpf_test_socket_cookie
* kselftest-vsyscall-mode-native/bpf_test_socket_cookie
* kselftest-vsyscall-mode-native/bpf_test_sock_fields
* kselftest-vsyscall-mode-none/bpf_test_sock_fields
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest-vsyscall-mode-none/bpf_test_sockmap
* kselftest-vsyscall-mode-native/bpf_test_sockmap
* kselftest-vsyscall-mode-none/bpf_test_sysctl
* kselftest/bpf_test_sysctl
* kselftest-vsyscall-mode-native/bpf_test_sysctl
* kselftest-vsyscall-mode-native/bpf_test_tc_edt.sh
* kselftest/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-none/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-none/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-native/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-native/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-none/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-none/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-native/bpf_test_tcpnotify_user
* kselftest/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_xdping.sh
* kselftest/bpf_test_xdping.sh
* kselftest-vsyscall-mode-native/bpf_test_xdping.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_generic.sh
* kselftest/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_native.sh
* kselftest/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-native/firmware_fw_run_tests.sh
* kselftest/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-none/firmware_fw_run_tests.sh
* kselftest/ftrace_ftracetest
* kselftest-vsyscall-mode-native/ftrace_ftracetest
* kselftest-vsyscall-mode-none/ftrace_ftracetest
* kselftest-vsyscall-mode-none/intel_pstate_run.sh
* kselftest/intel_pstate_run.sh
* kselftest-vsyscall-mode-native/intel_pstate_run.sh
* kselftest/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_cr4_cpuid_sync_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-native/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-none/kvm_demand_paging_test
* kselftest-vsyscall-mode-native/kvm_demand_paging_test
* kselftest/kvm_demand_paging_test
* kselftest-vsyscall-mode-none/kvm_dirty_log_test
* kselftest/kvm_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_dirty_log_test
* kselftest/kvm_evmcs_test
* kselftest-vsyscall-mode-none/kvm_evmcs_test
* kselftest-vsyscall-mode-native/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-native/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-none/kvm_hyperv_cpuid
* kselftest/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-none/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-native/kvm_kvm_create_max_vcpus
* kselftest/kvm_platform_info_test
* kselftest-vsyscall-mode-native/kvm_platform_info_test
* kselftest-vsyscall-mode-none/kvm_platform_info_test
* kselftest-vsyscall-mode-native/kvm_set_memory_region_test
* kselftest/kvm_set_memory_region_test
* kselftest-vsyscall-mode-none/kvm_set_memory_region_test
* kselftest-vsyscall-mode-native/kvm_set_sregs_test
* kselftest/kvm_set_sregs_test
* kselftest-vsyscall-mode-none/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest-vsyscall-mode-none/kvm_smm_test
* kselftest-vsyscall-mode-native/kvm_smm_test
* kselftest/kvm_state_test
* kselftest-vsyscall-mode-native/kvm_state_test
* kselftest-vsyscall-mode-none/kvm_state_test
* kselftest-vsyscall-mode-native/kvm_steal_time
* kselftest/kvm_steal_time
* kselftest-vsyscall-mode-none/kvm_steal_time
* kselftest-vsyscall-mode-native/kvm_sync_regs_test
* kselftest/kvm_sync_regs_test
* kselftest-vsyscall-mode-none/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-none/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-native/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-native/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-none/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-native/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-none/kvm_vmx_tsc_adjust_test
* kselftest/kvm_xss_msr_test
* kselftest-vsyscall-mode-native/kvm_xss_msr_test
* kselftest-vsyscall-mode-none/kvm_xss_msr_test
* kselftest-vsyscall-mode-native/lib_printf.sh
* kselftest/lib_printf.sh
* kselftest-vsyscall-mode-none/lib_printf.sh
* kselftest/lkdtm_ACCESS_NULL.sh
* kselftest-vsyscall-mode-native/lkdtm_ACCESS_NULL.sh
* kselftest-vsyscall-mode-none/lkdtm_ACCESS_NULL.sh
* kselftest/lkdtm_ACCESS_USERSPACE.sh
* kselftest-vsyscall-mode-native/lkdtm_ACCESS_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_ACCESS_USERSPACE.sh
* kselftest-vsyscall-mode-native/lkdtm_BUG.sh
* kselftest-vsyscall-mode-none/lkdtm_BUG.sh
* kselftest/lkdtm_BUG.sh
* kselftest/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest-vsyscall-mode-native/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest-vsyscall-mode-none/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest/lkdtm_CORRUPT_USER_DS.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_USER_DS.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_USER_DS.sh
* kselftest/lkdtm_EXCEPTION.sh
* kselftest-vsyscall-mode-native/lkdtm_EXCEPTION.sh
* kselftest-vsyscall-mode-none/lkdtm_EXCEPTION.sh
* kselftest/lkdtm_EXEC_DATA.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_DATA.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_DATA.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_KMALLOC.sh
* kselftest/lkdtm_EXEC_KMALLOC.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_KMALLOC.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_NULL.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_NULL.sh
* kselftest/lkdtm_EXEC_NULL.sh
* kselftest/lkdtm_EXEC_RODATA.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_RODATA.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_RODATA.sh
* kselftest/lkdtm_EXEC_STACK.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_STACK.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_STACK.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_USERSPACE.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_USERSPACE.sh
* kselftest/lkdtm_EXEC_USERSPACE.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_VMALLOC.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_VMALLOC.sh
* kselftest/lkdtm_EXEC_VMALLOC.sh
* kselftest-vsyscall-mode-native/lkdtm_READ_AFTER_FREE.sh
* kselftest/lkdtm_READ_AFTER_FREE.sh
* kselftest-vsyscall-mode-none/lkdtm_READ_AFTER_FREE.sh
* kselftest-vsyscall-mode-native/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest-vsyscall-mode-none/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest/lkdtm_SLAB_FREE_CROSS.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_CROSS.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_CROSS.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_PAGE.sh
* kselftest/lkdtm_SLAB_FREE_PAGE.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_PAGE.sh
* kselftest-vsyscall-mode-native/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest-vsyscall-mode-native/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest/lkdtm_STACKLEAK_ERASING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACKLEAK_ERASING.sh
* kselftest-vsyscall-mode-native/lkdtm_STACKLEAK_ERASING.sh
* kselftest-vsyscall-mode-native/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest-vsyscall-mode-none/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest-vsyscall-mode-native/lkdtm_UNSET_SMEP.sh
* kselftest/lkdtm_UNSET_SMEP.sh
* kselftest-vsyscall-mode-none/lkdtm_UNSET_SMEP.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest/lkdtm_USERCOPY_KERNEL.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_KERNEL.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_KERNEL.sh
* kselftest/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest-vsyscall-mode-native/lkdtm_WARNING_MESSAGE.sh
* kselftest/lkdtm_WARNING_MESSAGE.sh
* kselftest-vsyscall-mode-none/lkdtm_WARNING_MESSAGE.sh
* kselftest/lkdtm_WARNING.sh
* kselftest-vsyscall-mode-none/lkdtm_WARNING.sh
* kselftest-vsyscall-mode-native/lkdtm_WARNING.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_KERN.sh
* kselftest/lkdtm_WRITE_KERN.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_KERN.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest/lkdtm_WRITE_RO.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_RO.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_RO.sh
* kselftest/memory-hotplug_mem-on-off-test.sh
* kselftest-vsyscall-mode-none/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-native/mqueue_mq_perf_tests
* kselftest/mqueue_mq_perf_tests
* kselftest/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-none/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-native/net_fib_tests.sh
* kselftest/net_fib_tests.sh
* kselftest-vsyscall-mode-none/net_fib_tests.sh
* kselftest-vsyscall-mode-none/netfilter_nft_concat_range.sh
* kselftest-vsyscall-mode-native/netfilter_nft_concat_range.sh
* kselftest/netfilter_nft_concat_range.sh
* kselftest-vsyscall-mode-none/net_ip_defrag.sh
* kselftest-vsyscall-mode-native/net_ip_defrag.sh
* kselftest/net_ip_defrag.sh
* kselftest-vsyscall-mode-none/net_l2tp.sh
* kselftest-vsyscall-mode-native/net_l2tp.sh
* kselftest/net_l2tp.sh
* kselftest-vsyscall-mode-none/net_pmtu.sh
* kselftest/net_pmtu.sh
* kselftest-vsyscall-mode-native/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest-vsyscall-mode-none/net_psock_snd.sh
* kselftest-vsyscall-mode-native/net_psock_snd.sh
* kselftest-vsyscall-mode-native/net_run_netsocktests
* kselftest/net_run_netsocktests
* kselftest-vsyscall-mode-none/net_run_netsocktests
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-none/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-native/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-native/net_traceroute.sh
* kselftest-vsyscall-mode-none/net_traceroute.sh
* kselftest/net_traceroute.sh
* kselftest/net_udpgro_bench.sh
* kselftest-vsyscall-mode-native/net_udpgro_bench.sh
* kselftest-vsyscall-mode-none/net_udpgro_bench.sh
* kselftest-vsyscall-mode-none/net_udpgro.sh
* kselftest-vsyscall-mode-native/net_udpgro.sh
* kselftest/net_udpgro.sh
* kselftest-vsyscall-mode-native/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_udpgso_bench.sh
* kselftest/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_xfrm_policy.sh
* kselftest/net_xfrm_policy.sh
* kselftest-vsyscall-mode-native/net_xfrm_policy.sh
* kselftest-vsyscall-mode-native/openat2_openat2_test
* kselftest-vsyscall-mode-none/openat2_openat2_test
* kselftest/openat2_openat2_test
* kselftest-vsyscall-mode-native/openat2_rename_attack_test
* kselftest-vsyscall-mode-none/openat2_rename_attack_test
* kselftest/openat2_rename_attack_test
* kselftest/openat2_resolve_test
* kselftest-vsyscall-mode-native/openat2_resolve_test
* kselftest-vsyscall-mode-none/openat2_resolve_test
* kselftest/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-native/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-none/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-native/pidfd_pidfd_poll_test
* kselftest/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-none/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-none/pstore_pstore_tests
* kselftest-vsyscall-mode-native/pstore_pstore_tests
* kselftest/pstore_pstore_tests
* kselftest-vsyscall-mode-native/rtc_rtctest
* kselftest/rtc_rtctest
* kselftest-vsyscall-mode-native/seccomp_seccomp_bpf
* kselftest/seccomp_seccomp_bpf
* kselftest-vsyscall-mode-none/seccomp_seccomp_bpf
* kselftest-vsyscall-mode-none/timers_inconsistency-check
* kselftest/timers_inconsistency-check
* kselftest-vsyscall-mode-native/timers_inconsistency-check
* kselftest-vsyscall-mode-native/timers_nsleep-lat
* kselftest-vsyscall-mode-none/timers_nsleep-lat
* kselftest/timers_nsleep-lat
* kselftest/timers_raw_skew
* kselftest-vsyscall-mode-native/timers_raw_skew
* kselftest-vsyscall-mode-none/timers_raw_skew
* kselftest-vsyscall-mode-native/timers_set-timer-lat
* kselftest/timers_set-timer-lat
* kselftest-vsyscall-mode-none/timers_set-timer-lat
* kselftest-vsyscall-mode-none/networking/timestamping_txtimestamp.sh
* kselftest/networking/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-native/networking/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-native/vm_run_vmtests
* kselftest-vsyscall-mode-none/vm_run_vmtests
* kselftest/vm_run_vmtests
* kselftest-vsyscall-mode-none/x86_fsgsbase_64

x86-kasan:

qemu_x86_64:
* kselftest/filesystems/binderfs_binderfs_test
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool.sh
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_progs-no_alu32
* kselftest/bpf_test_skb_cgroup_id.sh
* kselftest/bpf_test_sock_addr.sh
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_sysctl
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_redirect.sh
* kselftest/bpf_test_xdp_vlan_mode_generic.sh
* kselftest/bpf_test_xdp_vlan_mode_native.sh
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
* kselftest/mqueue_mq_perf_tests
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_tests.sh
* kselftest/netfilter_nft_concat_range.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_traceroute.sh
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
* kselftest/rtc_rtctest
* kselftest/seccomp_seccomp_bpf
* kselftest/timers_inconsistency-check
* kselftest/timers_nsleep-lat
* kselftest/timers_raw_skew
* kselftest/timers_set-timer-lat
* kselftest/networking/timestamping_txtimestamp.sh
* kselftest/vm_run_vmtests
* kselftest/x86_fsgsbase_64

qemu_i386:
* kselftest/filesystems/binderfs_binderfs_test
* kselftest/bpf_get_cgroup_id_user
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
* kselftest/futex_run.sh
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

juno-r2-kasan:

i386:
* kselftest/filesystems/binderfs_binderfs_test
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_hashmap
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
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
* kselftest/lkdtm_WARNING_MESSAGE.sh
* kselftest/lkdtm_WARNING.sh
* kselftest/lkdtm_WRITE_KERN.sh
* kselftest/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest/lkdtm_WRITE_RO.sh

juno-r2-compat:

qemu_arm64:
* kselftest/filesystems/binderfs_binderfs_test
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_kmod.sh
* kselftest/bpf_test_lpm_map
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
* kselftest/bpf_test_tag
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_verifier
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_redirect.sh
* kselftest/bpf_test_xdp_vlan_mode_generic.sh
* kselftest/bpf_test_xdp_vlan_mode_native.sh
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
* kselftest/memory-hotplug_mem-on-off-test.sh
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_rule_tests.sh
* kselftest/net_fib_tests.sh
* kselftest/netfilter_conntrack_icmp_related.sh
* kselftest/netfilter_nft_concat_range.sh
* kselftest/netfilter_nft_nat.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_traceroute.sh
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh

hi6220-hikey:
* kselftest/filesystems/binderfs_binderfs_test
* kselftest/bpf_get_cgroup_id_user
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
* kselftest/bpf_test_tag
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_verifier
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_redirect.sh
* kselftest/bpf_test_xdp_vlan_mode_generic.sh
* kselftest/bpf_test_xdp_vlan_mode_native.sh
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
* kselftest/memory-hotplug_mem-on-off-test.sh
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_rule_tests.sh
* kselftest/net_fib_tests.sh
* kselftest/netfilter_conntrack_icmp_related.sh
* kselftest/netfilter_nft_concat_range.sh
* kselftest/netfilter_nft_nat.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/pidfd_pidfd_fdinfo_test
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/pidfd_pidfd_test
* kselftest/networking/timestamping_txtimestamp.sh

dragonboard-410c:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_10800_458678328.1584709228883--
