Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32F5A1836C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Mar 2020 18:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgCLRAc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Mar 2020 13:00:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33926 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLRAc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Mar 2020 13:00:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id z15so8447072wrl.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Mar 2020 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=sk/DVuzfe5nXdNz1FAJsHI0JR5tNmmPAt+fJ+Mz/Suw=;
        b=WOS6gqI4HsejtDPidH0OHmUF1nyXD6dPco/v7H7Fskj5WzfjbbZTp95f4QxcHxxSBf
         4XmRlWMTOwSDExPDloqrJEULw5yI+sh0LTVKW6VAlzryf7t4LlPqXYBtLqJGgIAQIpKK
         SeftgUH+LyU6fPP3exNqJnIab9dTS9qqfzJgq5g5xzFOn2jTMFLox8ubme3wTrNL87uZ
         W5bQbhyhD3s70/cydvi3/rA2F9/E1J3brpgpwz8ZTrv+WdnD9eakmugyL+MITfbSf/de
         YvjqT3L0AgLg6pHGJSVPA5uoopc+0LFG7Tk2kKCbHmLamtuqfofe1bsEakUuAIhBkyK3
         VwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=sk/DVuzfe5nXdNz1FAJsHI0JR5tNmmPAt+fJ+Mz/Suw=;
        b=MiMXsvEqFiZtXaS+Bjh23meK5o8J/GvhhJPNlyIrUV+WpjM9TWsR419DQsMSIcuLTr
         EP3mE00qs3TdSAffGqBKrsxzle49S0tUK1eGyy2DUHhEuoDHsO6Du8Dh8+zlWy6x6WnV
         5jOvMHKwQgBF8XTzNvMDWNCwoGwebQnh91sl1MOYqRJbQTArX8vrVLcuDKJLqWhSjqry
         s2/CGORbuBxzILvEbg8wXquvs0WBZ6GDGHCXxAeKWGlI6f2REXMG6MwdlgRk4LO9/KG4
         QVUuHB20YRqn+ObsaLevB39SY0B6M53IKVMS3ErKNso38Ia8B7m4rZkxys64zJtH4K0x
         xJWw==
X-Gm-Message-State: ANhLgQ2vJE6JsioUp1FQcESNE5+Ddxu8kQC3l6VYvVWwOIxCtMY7Sq/5
        lLobwFkpa7ofS94jwKX4/w1eXQ==
X-Google-Smtp-Source: ADFU+vvtk68jjhmsMa9FztlpDVVfeqzwMhdsSZD8R2nOxrAErgKSqcAufCDG54/UjOxiYIXd9ZuofA==
X-Received: by 2002:adf:9599:: with SMTP id p25mr11523390wrp.43.1584032427797;
        Thu, 12 Mar 2020 10:00:27 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id k4sm18300996wrx.27.2020.03.12.10.00.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Mar 2020 10:00:27 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Thu, 12 Mar 2020 17:00:26 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <1950020221.9842.1584032427116.JavaMail.javamailuser@localhost>
Subject: next-20200312 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_9841_407089196.1584032426414"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_9841_407089196.1584032426414
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0-rc5
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 407b0a62b422526e943e1261c7939b2e52ee17cb
git describe: next-20200312
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200312

Regressions (compared to build next-20200311)
------------------------------------------------------------------------
x86:                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none/net:                                                                                         
    * mptcp_mptcp_connect.sh                                                                                                         
x86:                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none/net:                                                                                         
    * mptcp_mptcp_connect.sh                                                                                                         
                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200311)                                                                   
------------------------------------------------------------------------                                               
No fixes

In total:
------------------------------------------------------------------------
Ran 838 total tests in the following environments and test suites.
pass 257
fail 470
xfail 0
skip 111

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

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


Failures
------------------------------------------------------------------------

qemu_x86_64:
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
* kselftest/ftrace_ftracetest
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest/kvm_dirty_log_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_kvm_create_max_vcpus
* kselftest/kvm_platform_info_test
* kselftest/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest/kvm_state_test
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
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/net_xfrm_policy.sh
* kselftest/networking/timestamping_txtimestamp.sh

x86:
* kselftest-vsyscall-mode-none/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-native/bpf_get_cgroup_id_user
* kselftest/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-native/bpf_test_bpftool.sh
* kselftest-vsyscall-mode-none/bpf_test_bpftool.sh
* kselftest/bpf_test_bpftool.sh
* kselftest/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-none/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-native/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-native/bpf_test_flow_dissector.sh
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-none/bpf_test_maps
* kselftest-vsyscall-mode-native/bpf_test_maps
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest-vsyscall-mode-none/bpf_test_netcnt
* kselftest-vsyscall-mode-native/bpf_test_netcnt
* kselftest-vsyscall-mode-none/bpf_test_progs
* kselftest-vsyscall-mode-native/bpf_test_progs
* kselftest/bpf_test_progs
* kselftest/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-native/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-none/bpf_test_progs-no_alu32
* kselftest/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-native/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-none/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-native/bpf_test_sock_addr.sh
* kselftest/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-none/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_socket_cookie
* kselftest-vsyscall-mode-none/bpf_test_socket_cookie
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest-vsyscall-mode-native/bpf_test_sock_fields
* kselftest-vsyscall-mode-none/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest-vsyscall-mode-none/bpf_test_sockmap
* kselftest-vsyscall-mode-native/bpf_test_sockmap
* kselftest/bpf_test_sysctl
* kselftest-vsyscall-mode-native/bpf_test_sysctl
* kselftest-vsyscall-mode-none/bpf_test_sysctl
* kselftest-vsyscall-mode-native/bpf_test_tc_edt.sh
* kselftest/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-none/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-native/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-none/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-none/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-native/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-none/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-native/bpf_test_tcpnotify_user
* kselftest/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tunnel.sh
* kselftest/bpf_test_xdping.sh
* kselftest-vsyscall-mode-native/bpf_test_xdping.sh
* kselftest-vsyscall-mode-none/bpf_test_xdping.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_redirect.sh
* kselftest/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_generic.sh
* kselftest/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_generic.sh
* kselftest/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_native.sh
* kselftest/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-none/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-native/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-none/ftrace_ftracetest
* kselftest-vsyscall-mode-native/ftrace_ftracetest
* kselftest/ftrace_ftracetest
* kselftest-vsyscall-mode-none/intel_pstate_run.sh
* kselftest/intel_pstate_run.sh
* kselftest-vsyscall-mode-native/kvm_clear_dirty_log_test
* kselftest/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-none/kvm_cr4_cpuid_sync_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-native/kvm_dirty_log_test
* kselftest/kvm_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_evmcs_test
* kselftest/kvm_evmcs_test
* kselftest-vsyscall-mode-native/kvm_evmcs_test
* kselftest-vsyscall-mode-none/kvm_hyperv_cpuid
* kselftest/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-native/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-none/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-native/kvm_kvm_create_max_vcpus
* kselftest/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-none/kvm_platform_info_test
* kselftest-vsyscall-mode-native/kvm_platform_info_test
* kselftest/kvm_platform_info_test
* kselftest-vsyscall-mode-none/kvm_set_sregs_test
* kselftest/kvm_set_sregs_test
* kselftest-vsyscall-mode-native/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest-vsyscall-mode-native/kvm_smm_test
* kselftest-vsyscall-mode-none/kvm_smm_test
* kselftest-vsyscall-mode-native/kvm_state_test
* kselftest-vsyscall-mode-none/kvm_state_test
* kselftest/kvm_state_test
* kselftest/kvm_sync_regs_test
* kselftest-vsyscall-mode-native/kvm_sync_regs_test
* kselftest-vsyscall-mode-none/kvm_sync_regs_test
* kselftest-vsyscall-mode-native/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-none/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-native/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-none/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-native/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-native/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-none/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-native/kvm_xss_msr_test
* kselftest-vsyscall-mode-none/kvm_xss_msr_test
* kselftest/kvm_xss_msr_test
* kselftest-vsyscall-mode-native/lib_printf.sh
* kselftest-vsyscall-mode-none/lib_printf.sh
* kselftest/lib_printf.sh
* kselftest-vsyscall-mode-none/lkdtm_ACCESS_NULL.sh
* kselftest-vsyscall-mode-native/lkdtm_ACCESS_NULL.sh
* kselftest/lkdtm_ACCESS_NULL.sh
* kselftest-vsyscall-mode-native/lkdtm_ACCESS_USERSPACE.sh
* kselftest/lkdtm_ACCESS_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_ACCESS_USERSPACE.sh
* kselftest/lkdtm_BUG.sh
* kselftest-vsyscall-mode-native/lkdtm_BUG.sh
* kselftest-vsyscall-mode-none/lkdtm_BUG.sh
* kselftest-vsyscall-mode-native/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest-vsyscall-mode-none/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_USER_DS.sh
* kselftest/lkdtm_CORRUPT_USER_DS.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_USER_DS.sh
* kselftest-vsyscall-mode-native/lkdtm_EXCEPTION.sh
* kselftest-vsyscall-mode-none/lkdtm_EXCEPTION.sh
* kselftest/lkdtm_EXCEPTION.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_DATA.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_DATA.sh
* kselftest/lkdtm_EXEC_DATA.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_KMALLOC.sh
* kselftest/lkdtm_EXEC_KMALLOC.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_KMALLOC.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_NULL.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_NULL.sh
* kselftest/lkdtm_EXEC_NULL.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_RODATA.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_RODATA.sh
* kselftest/lkdtm_EXEC_RODATA.sh
* kselftest/lkdtm_EXEC_STACK.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_STACK.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_STACK.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_USERSPACE.sh
* kselftest/lkdtm_EXEC_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_VMALLOC.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_VMALLOC.sh
* kselftest/lkdtm_EXEC_VMALLOC.sh
* kselftest/lkdtm_READ_AFTER_FREE.sh
* kselftest-vsyscall-mode-none/lkdtm_READ_AFTER_FREE.sh
* kselftest-vsyscall-mode-native/lkdtm_READ_AFTER_FREE.sh
* kselftest/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest-vsyscall-mode-native/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest-vsyscall-mode-none/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest/lkdtm_SLAB_FREE_CROSS.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_CROSS.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_CROSS.sh
* kselftest/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_PAGE.sh
* kselftest/lkdtm_SLAB_FREE_PAGE.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_PAGE.sh
* kselftest-vsyscall-mode-native/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest-vsyscall-mode-native/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest/lkdtm_STACKLEAK_ERASING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACKLEAK_ERASING.sh
* kselftest-vsyscall-mode-native/lkdtm_STACKLEAK_ERASING.sh
* kselftest/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest-vsyscall-mode-native/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest-vsyscall-mode-none/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest-vsyscall-mode-native/lkdtm_UNSET_SMEP.sh
* kselftest-vsyscall-mode-none/lkdtm_UNSET_SMEP.sh
* kselftest/lkdtm_UNSET_SMEP.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_KERNEL.sh
* kselftest/lkdtm_USERCOPY_KERNEL.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_KERNEL.sh
* kselftest/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest-vsyscall-mode-native/lkdtm_WARNING_MESSAGE.sh
* kselftest-vsyscall-mode-none/lkdtm_WARNING_MESSAGE.sh
* kselftest/lkdtm_WARNING_MESSAGE.sh
* kselftest/lkdtm_WARNING.sh
* kselftest-vsyscall-mode-none/lkdtm_WARNING.sh
* kselftest-vsyscall-mode-native/lkdtm_WARNING.sh
* kselftest/lkdtm_WRITE_KERN.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_KERN.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_KERN.sh
* kselftest/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_RO.sh
* kselftest/lkdtm_WRITE_RO.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_RO.sh
* kselftest-vsyscall-mode-none/net/mptcp_mptcp_connect.sh
* kselftest-vsyscall-mode-native/mqueue_mq_perf_tests
* kselftest/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-none/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-native/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-none/net_fib-onlink-tests.sh
* kselftest/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-native/net_fib_tests.sh
* kselftest/net_fib_tests.sh
* kselftest-vsyscall-mode-none/net_fib_tests.sh
* kselftest/netfilter_nft_concat_range.sh
* kselftest-vsyscall-mode-native/netfilter_nft_concat_range.sh
* kselftest-vsyscall-mode-none/netfilter_nft_concat_range.sh
* kselftest/net_ip_defrag.sh
* kselftest-vsyscall-mode-native/net_ip_defrag.sh
* kselftest-vsyscall-mode-none/net_ip_defrag.sh
* kselftest-vsyscall-mode-native/net_l2tp.sh
* kselftest-vsyscall-mode-none/net_l2tp.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest-vsyscall-mode-native/net_pmtu.sh
* kselftest-vsyscall-mode-none/net_pmtu.sh
* kselftest-vsyscall-mode-none/net_psock_snd.sh
* kselftest-vsyscall-mode-native/net_psock_snd.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest-vsyscall-mode-native/net_run_netsocktests
* kselftest-vsyscall-mode-none/net_run_netsocktests
* kselftest-vsyscall-mode-none/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-native/net_test_vxlan_under_vrf.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-native/net_traceroute.sh
* kselftest-vsyscall-mode-none/net_traceroute.sh
* kselftest/net_traceroute.sh
* kselftest-vsyscall-mode-native/net_udpgro_bench.sh
* kselftest-vsyscall-mode-none/net_udpgro_bench.sh
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest-vsyscall-mode-none/net_udpgro.sh
* kselftest-vsyscall-mode-native/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_udpgso_bench.sh
* kselftest-vsyscall-mode-native/net_udpgso_bench.sh
* kselftest-vsyscall-mode-native/net_xfrm_policy.sh
* kselftest/net_xfrm_policy.sh
* kselftest-vsyscall-mode-none/net_xfrm_policy.sh
* kselftest/networking/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-native/networking/timestamping_txtimestamp.sh

hi6220-hikey:

qemu_i386:

i386:

x15:

dragonboard-410c:

juno-r2:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_9841_407089196.1584032426414--
