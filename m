Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31964177B53
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Mar 2020 17:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgCCQAg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Mar 2020 11:00:36 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:36445 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgCCQAf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Mar 2020 11:00:35 -0500
Received: by mail-wm1-f44.google.com with SMTP id g83so3408528wme.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Mar 2020 08:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=7yngYIMRsZjJnHu6juUZA78DT8xRhaLF3Tk+qHBOQME=;
        b=dtAchmGjXwFGoYexMnFewg917VmPRn8fQjABhqKccgT8FafPidqxlV5+xUYv/aXHvZ
         GDaIX2TruY4bSgxmvMRB3sYuM+4fki5u11mO+egsYtIaeBks+dpl18SYsQtgpcKFsR1C
         3VHe5nI8p0VneoBGJyTevttb/BoiG/nCgaMMb/dWhB8zTLsRlH1SWVAzC94DGaN/CEbG
         X+9PZWTAflIeZk3PM5g8ED8n8Kp4cb5aWwmPz+VlqxKqpjG+uqu9rIUjKsd2ygINkbDR
         lUQNNNmBId3a8qI5gqwYJ0zE0AgNZAX+h20jy2kA+sGhLj3UAUCRtD4LJ0pr+/DAQgNN
         YWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=7yngYIMRsZjJnHu6juUZA78DT8xRhaLF3Tk+qHBOQME=;
        b=Su90yCUBqwK4bvPZrZCgdZwkR/G9pYnJtvZStW/oExx7/glva62HrfbH9k0+RwhjS2
         VuDObOQMlmhS5ylpqN16929AVEqM2B7DP25+iVZZZzFECtVGL9gQxALDw5gTJwesVGJ0
         Ko1RxOGKAk5EJNBYh/R1obI1uBXVrRl3fGvohlwRqeUrIlVwhsc0xWaoUTAKsTbKdtRx
         bfHY+n2/T/BFq8qm3mZOmLi+8CF8nXOLduAS8mrlhkIYpaNRX1I69Wey0gc/NqAoDgsO
         riKi0Xe3OsoVHX6Q+nu616yQYaQpsPOF1sG8eKttkw30ZtQfcpQkm3bxCX+2pXHKEfrw
         qzZA==
X-Gm-Message-State: ANhLgQ1wG57If14rF3iA5YSR55WO3xFsRTmHZ15KF3/zLO42QWW6VSon
        punkN7y0uP3sDsKUKbbrq1SDHYLJiZ0=
X-Google-Smtp-Source: ADFU+vsHdgcF7R1jwnlTk/nIetwlIrZ265UtL95evi+kaCN9v5LORX9ZBvEGXXjwUshXlTmBTKF1+w==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr4872764wmc.8.1583251230813;
        Tue, 03 Mar 2020 08:00:30 -0800 (PST)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id b10sm34548418wrw.61.2020.03.03.08.00.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2020 08:00:30 -0800 (PST)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Tue, 3 Mar 2020 16:00:29 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <736384510.5730.1583251230185.JavaMail.javamailuser@localhost>
Subject: next-20200303 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_5729_114400577.1583251229488"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_5729_114400577.1583251229488
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0-rc4
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: e78aa714e3261e23c7413fd6e719820e271ff128
git describe: next-20200303
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200303

Regressions (compared to build next-20200302)
------------------------------------------------------------------------
x86:                                                                                                      
 kselftest:                                                                                         
    * memory-hotplug_mem-on-off-test.sh                                                                                                         
                                                                                         
    * rtc_rtctest                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
                                                                                         
    * rtc_rtctest                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * memory-hotplug_mem-on-off-test.sh                                                                                                         
                                                                                         
    * rtc_rtctest                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
                                                                                         
    * rtc_rtctest                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * memory-hotplug_mem-on-off-test.sh                                                                                                         
                                                                                         
    * rtc_rtctest                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
                                                                                         
    * rtc_rtctest                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200302)                                                                   
------------------------------------------------------------------------                                               
x86:                                                                                                      
 kselftest:                                                                                         
    * proc_read                                                                                                         
                                                                                         
    * x86_fsgsbase_64                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * rtc_rtctest                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * proc_read                                                                                                         
                                                                                         
    * x86_fsgsbase_64                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * rtc_rtctest                                                                                                         
i386:                                                                                                      
 kselftest:                                                                                         
    * x86_sigreturn_32                                                                                                         
qemu_arm:                                                                                                      
 kselftest:                                                                                         
    * rtc_rtctest                                                                                                         
                                                                                         
    * seccomp_seccomp_benchmark                                                                                                         


In total:
------------------------------------------------------------------------
Ran 1882 total tests in the following environments and test suites.
pass 789
fail 879
xfail 0
skip 214

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
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
* kselftest-vsyscall-mode-none/networking


Failures
------------------------------------------------------------------------

x86:
* kselftest-vsyscall-mode-native/bpf_get_cgroup_id_user
* kselftest/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-none/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-native/bpf_test_bpftool.sh
* kselftest-vsyscall-mode-none/bpf_test_bpftool.sh
* kselftest/bpf_test_bpftool.sh
* kselftest-vsyscall-mode-none/bpf_test_dev_cgroup
* kselftest/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-native/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-native/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-native/bpf_test_maps
* kselftest/bpf_test_maps
* kselftest-vsyscall-mode-none/bpf_test_maps
* kselftest-vsyscall-mode-none/bpf_test_netcnt
* kselftest/bpf_test_netcnt
* kselftest-vsyscall-mode-native/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest-vsyscall-mode-none/bpf_test_progs
* kselftest-vsyscall-mode-native/bpf_test_progs
* kselftest-vsyscall-mode-native/bpf_test_progs-no_alu32
* kselftest/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-none/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-none/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-native/bpf_test_skb_cgroup_id.sh
* kselftest/bpf_test_skb_cgroup_id.sh
* kselftest/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-none/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-none/bpf_test_socket_cookie
* kselftest-vsyscall-mode-native/bpf_test_socket_cookie
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest-vsyscall-mode-none/bpf_test_sock_fields
* kselftest-vsyscall-mode-native/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest-vsyscall-mode-none/bpf_test_sockmap
* kselftest-vsyscall-mode-native/bpf_test_sockmap
* kselftest/bpf_test_sysctl
* kselftest-vsyscall-mode-native/bpf_test_sysctl
* kselftest-vsyscall-mode-none/bpf_test_sysctl
* kselftest-vsyscall-mode-native/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-none/bpf_test_tc_edt.sh
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-none/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-native/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-none/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-native/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-none/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-native/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_xdping.sh
* kselftest/bpf_test_xdping.sh
* kselftest-vsyscall-mode-none/bpf_test_xdping.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_redirect.sh
* kselftest/bpf_test_xdp_redirect.sh
* kselftest/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_native.sh
* kselftest/bpf_test_xdp_vlan_mode_native.sh
* kselftest/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-native/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-none/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-none/ftrace_ftracetest
* kselftest/ftrace_ftracetest
* kselftest-vsyscall-mode-native/ftrace_ftracetest
* kselftest/intel_pstate_run.sh
* kselftest-vsyscall-mode-native/intel_pstate_run.sh
* kselftest-vsyscall-mode-none/intel_pstate_run.sh
* kselftest-vsyscall-mode-native/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_clear_dirty_log_test
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-none/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-native/kvm_cr4_cpuid_sync_test
* kselftest/kvm_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_evmcs_test
* kselftest-vsyscall-mode-none/kvm_evmcs_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-native/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-native/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-none/kvm_kvm_create_max_vcpus
* kselftest/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-none/kvm_platform_info_test
* kselftest/kvm_platform_info_test
* kselftest-vsyscall-mode-native/kvm_platform_info_test
* kselftest/kvm_set_sregs_test
* kselftest-vsyscall-mode-native/kvm_set_sregs_test
* kselftest-vsyscall-mode-none/kvm_set_sregs_test
* kselftest-vsyscall-mode-none/kvm_smm_test
* kselftest-vsyscall-mode-native/kvm_smm_test
* kselftest/kvm_smm_test
* kselftest-vsyscall-mode-native/kvm_state_test
* kselftest/kvm_state_test
* kselftest-vsyscall-mode-none/kvm_state_test
* kselftest/kvm_sync_regs_test
* kselftest-vsyscall-mode-native/kvm_sync_regs_test
* kselftest-vsyscall-mode-none/kvm_sync_regs_test
* kselftest-vsyscall-mode-native/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-none/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-native/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-native/kvm_vmx_tsc_adjust_test
* kselftest/kvm_xss_msr_test
* kselftest-vsyscall-mode-native/kvm_xss_msr_test
* kselftest-vsyscall-mode-none/kvm_xss_msr_test
* kselftest/lkdtm_ACCESS_NULL.sh
* kselftest-vsyscall-mode-none/lkdtm_ACCESS_NULL.sh
* kselftest-vsyscall-mode-native/lkdtm_ACCESS_NULL.sh
* kselftest-vsyscall-mode-native/lkdtm_ACCESS_USERSPACE.sh
* kselftest/lkdtm_ACCESS_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_ACCESS_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_BUG.sh
* kselftest/lkdtm_BUG.sh
* kselftest-vsyscall-mode-native/lkdtm_BUG.sh
* kselftest-vsyscall-mode-native/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest-vsyscall-mode-none/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest/lkdtm_CFI_FORWARD_PROTO.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_LIST_ADD.sh
* kselftest/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_LIST_DEL.sh
* kselftest-vsyscall-mode-none/lkdtm_CORRUPT_USER_DS.sh
* kselftest-vsyscall-mode-native/lkdtm_CORRUPT_USER_DS.sh
* kselftest/lkdtm_CORRUPT_USER_DS.sh
* kselftest-vsyscall-mode-none/lkdtm_EXCEPTION.sh
* kselftest/lkdtm_EXCEPTION.sh
* kselftest-vsyscall-mode-native/lkdtm_EXCEPTION.sh
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
* kselftest-vsyscall-mode-native/lkdtm_EXEC_RODATA.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_RODATA.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_STACK.sh
* kselftest/lkdtm_EXEC_STACK.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_STACK.sh
* kselftest/lkdtm_EXEC_USERSPACE.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_USERSPACE.sh
* kselftest-vsyscall-mode-none/lkdtm_EXEC_VMALLOC.sh
* kselftest/lkdtm_EXEC_VMALLOC.sh
* kselftest-vsyscall-mode-native/lkdtm_EXEC_VMALLOC.sh
* kselftest/lkdtm_READ_AFTER_FREE.sh
* kselftest-vsyscall-mode-native/lkdtm_READ_AFTER_FREE.sh
* kselftest-vsyscall-mode-none/lkdtm_READ_AFTER_FREE.sh
* kselftest/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest-vsyscall-mode-native/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest-vsyscall-mode-none/lkdtm_READ_BUDDY_AFTER_FREE.sh
* kselftest/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest/lkdtm_REFCOUNT_ADD_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_DEC_ZERO.sh
* kselftest/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_OVERFLOW.sh
* kselftest/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_SATURATED.sh
* kselftest/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_INC_ZERO.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* kselftest/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-none/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_CROSS.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_CROSS.sh
* kselftest/lkdtm_SLAB_FREE_CROSS.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_DOUBLE.sh
* kselftest-vsyscall-mode-none/lkdtm_SLAB_FREE_PAGE.sh
* kselftest-vsyscall-mode-native/lkdtm_SLAB_FREE_PAGE.sh
* kselftest/lkdtm_SLAB_FREE_PAGE.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest-vsyscall-mode-native/lkdtm_STACK_GUARD_PAGE_LEADING.sh
* kselftest/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest-vsyscall-mode-native/lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* kselftest-vsyscall-mode-native/lkdtm_STACKLEAK_ERASING.sh
* kselftest-vsyscall-mode-none/lkdtm_STACKLEAK_ERASING.sh
* kselftest/lkdtm_STACKLEAK_ERASING.sh
* kselftest/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest-vsyscall-mode-native/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest-vsyscall-mode-none/lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* kselftest-vsyscall-mode-none/lkdtm_UNSET_SMEP.sh
* kselftest/lkdtm_UNSET_SMEP.sh
* kselftest-vsyscall-mode-native/lkdtm_UNSET_SMEP.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_KERNEL_DS.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_KERNEL.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_KERNEL.sh
* kselftest/lkdtm_USERCOPY_KERNEL.sh
* kselftest/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_BEYOND.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* kselftest/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest-vsyscall-mode-native/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest-vsyscall-mode-none/lkdtm_USERCOPY_STACK_FRAME_TO.sh
* kselftest/lkdtm_WARNING_MESSAGE.sh
* kselftest-vsyscall-mode-native/lkdtm_WARNING_MESSAGE.sh
* kselftest-vsyscall-mode-none/lkdtm_WARNING_MESSAGE.sh
* kselftest-vsyscall-mode-native/lkdtm_WARNING.sh
* kselftest/lkdtm_WARNING.sh
* kselftest-vsyscall-mode-none/lkdtm_WARNING.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_KERN.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_KERN.sh
* kselftest/lkdtm_WRITE_KERN.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_RO_AFTER_INIT.sh
* kselftest-vsyscall-mode-none/lkdtm_WRITE_RO.sh
* kselftest-vsyscall-mode-native/lkdtm_WRITE_RO.sh
* kselftest/lkdtm_WRITE_RO.sh
* kselftest/memory-hotplug_mem-on-off-test.sh
* kselftest/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-native/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-none/mqueue_mq_perf_tests
* kselftest/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-native/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-none/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-none/net_fib_tests.sh
* kselftest/net_fib_tests.sh
* kselftest-vsyscall-mode-native/net_fib_tests.sh
* kselftest-vsyscall-mode-none/netfilter_nft_concat_range.sh
* kselftest-vsyscall-mode-native/netfilter_nft_concat_range.sh
* kselftest/netfilter_nft_concat_range.sh
* kselftest/net_ip_defrag.sh
* kselftest-vsyscall-mode-native/net_ip_defrag.sh
* kselftest-vsyscall-mode-none/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest-vsyscall-mode-native/net_l2tp.sh
* kselftest-vsyscall-mode-none/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest-vsyscall-mode-none/net_pmtu.sh
* kselftest-vsyscall-mode-native/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest-vsyscall-mode-none/net_psock_snd.sh
* kselftest-vsyscall-mode-native/net_psock_snd.sh
* kselftest-vsyscall-mode-native/net_run_netsocktests
* kselftest/net_run_netsocktests
* kselftest-vsyscall-mode-native/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-none/net_test_vxlan_under_vrf.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_traceroute.sh
* kselftest-vsyscall-mode-none/net_traceroute.sh
* kselftest-vsyscall-mode-native/net_traceroute.sh
* kselftest-vsyscall-mode-none/net_udpgro_bench.sh
* kselftest/net_udpgro_bench.sh
* kselftest-vsyscall-mode-native/net_udpgro_bench.sh
* kselftest-vsyscall-mode-none/net_udpgro.sh
* kselftest-vsyscall-mode-native/net_udpgro.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_udpgso_bench.sh
* kselftest-vsyscall-mode-native/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_xfrm_policy.sh
* kselftest/net_xfrm_policy.sh
* kselftest-vsyscall-mode-native/net_xfrm_policy.sh
* kselftest/openat2_openat2_test
* kselftest-vsyscall-mode-native/openat2_openat2_test
* kselftest-vsyscall-mode-none/openat2_openat2_test
* kselftest-vsyscall-mode-native/openat2_rename_attack_test
* kselftest-vsyscall-mode-none/openat2_rename_attack_test
* kselftest/openat2_rename_attack_test
* kselftest-vsyscall-mode-none/openat2_resolve_test
* kselftest-vsyscall-mode-native/openat2_resolve_test
* kselftest/openat2_resolve_test
* kselftest-vsyscall-mode-native/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-none/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-native/pidfd_pidfd_poll_test
* kselftest/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-none/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-none/pstore_pstore_tests
* kselftest/pstore_pstore_tests
* kselftest-vsyscall-mode-native/pstore_pstore_tests
* kselftest-vsyscall-mode-native/rtc_rtctest
* kselftest/rtc_rtctest
* kselftest-vsyscall-mode-none/seccomp_seccomp_benchmark
* kselftest/seccomp_seccomp_benchmark
* kselftest-vsyscall-mode-native/seccomp_seccomp_benchmark
* kselftest-vsyscall-mode-none/seccomp_seccomp_bpf
* kselftest-vsyscall-mode-native/seccomp_seccomp_bpf
* kselftest/seccomp_seccomp_bpf
* kselftest-vsyscall-mode-native/timers_inconsistency-check
* kselftest-vsyscall-mode-none/timers_inconsistency-check
* kselftest/timers_inconsistency-check
* kselftest/timers_nsleep-lat
* kselftest-vsyscall-mode-native/timers_nsleep-lat
* kselftest-vsyscall-mode-none/timers_nsleep-lat
* kselftest/timers_raw_skew
* kselftest-vsyscall-mode-none/timers_raw_skew
* kselftest-vsyscall-mode-native/timers_raw_skew
* kselftest-vsyscall-mode-native/timers_set-timer-lat
* kselftest/timers_set-timer-lat
* kselftest-vsyscall-mode-none/timers_set-timer-lat
* kselftest-vsyscall-mode-none/networking/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-native/networking/timestamping_txtimestamp.sh
* kselftest/networking/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-native/vm_run_vmtests
* kselftest/vm_run_vmtests
* kselftest-vsyscall-mode-none/vm_run_vmtests

qemu_arm:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_hashmap
* kselftest/bpf_test_kmod.sh
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
* kselftest/cgroup_test_freezer
* kselftest/clone3_clone3_clear_sighand
* kselftest/cpufreq_main.sh
* kselftest/firmware_fw_run_tests.sh
* kselftest/ftrace_ftracetest
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest/kvm_dirty_log_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_kvm_create_max_vcpus
* kselftest/kvm_mmio_warning_test
* kselftest/kvm_platform_info_test
* kselftest/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest/kvm_state_test
* kselftest/kvm_svm_vmcall_test
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/kvm_xss_msr_test
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
* kselftest/net_reuseport_bpf_numa
* kselftest/net_run_netsocktests
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_traceroute.sh
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/openat2_openat2_test
* kselftest/openat2_rename_attack_test
* kselftest/openat2_resolve_test
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/pidfd_pidfd_test
* kselftest/proc_proc-self-syscall
* kselftest/pstore_pstore_tests
* kselftest/seccomp_seccomp_bpf
* kselftest/timers_inconsistency-check
* kselftest/timers_nsleep-lat
* kselftest/timers_raw_skew
* kselftest/timers_set-timer-lat
* kselftest/networking/timestamping_txtimestamp.sh
* kselftest/vm_run_vmtests

dragonboard-410c:
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

x15:

i386:
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
* kselftest/firmware_fw_run_tests.sh
* kselftest/ftrace_ftracetest
* kselftest/intel_pstate_run.sh
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest/kvm_dirty_log_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_kvm_create_max_vcpus
* kselftest/kvm_mmio_warning_test
* kselftest/kvm_platform_info_test
* kselftest/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest/kvm_state_test
* kselftest/kvm_svm_vmcall_test
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/kvm_xss_msr_test
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
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_traceroute.sh
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgso_bench.sh
* kselftest/openat2_openat2_test
* kselftest/openat2_rename_attack_test
* kselftest/openat2_resolve_test
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/proc_proc-self-syscall
* kselftest/pstore_pstore_tests
* kselftest/rtc_rtctest
* kselftest/seccomp_seccomp_bpf
* kselftest/timers_inconsistency-check
* kselftest/timers_nsleep-lat
* kselftest/timers_raw_skew
* kselftest/timers_set-timer-lat
* kselftest/networking/timestamping_txtimestamp.sh
* kselftest/vm_run_vmtests

qemu_i386:

qemu_x86_64:

juno-r2:
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
* kselftest/cgroup_test_freezer
* kselftest/cpufreq_main.sh
* kselftest/firmware_fw_run_tests.sh
* kselftest/ftrace_ftracetest
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest/kvm_dirty_log_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_kvm_create_max_vcpus
* kselftest/kvm_mmio_warning_test
* kselftest/kvm_platform_info_test
* kselftest/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest/kvm_state_test
* kselftest/kvm_svm_vmcall_test
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/kvm_xss_msr_test
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

hi6220-hikey:
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

qemu_arm64:
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


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_5729_114400577.1583251229488--
