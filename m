Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAB526AAFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Sep 2020 19:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgIORp0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Sep 2020 13:45:26 -0400
Received: from a8-29.smtp-out.amazonses.com ([54.240.8.29]:55154 "EHLO
        a8-29.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727552AbgIORpS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Sep 2020 13:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=iv2huwi6zmqabdt6b4lbuyos6pcvh5gh; d=linaro.org; t=1600191890;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=bcjVu8HuSGRGYIbG3cKReMGEqxVQufnTKkK0KGamA60=;
        b=dII9fPkFAyfybo/5+mPRVQm9mwhpOEwMTYKRyv7PK4E7svdoznVIKiUrvSaHTYyk
        HF8KzIZvzCV2ElV3cQ7+YL+vQHTtb+pnjuDwo0KHBCMmMLuZPfHp+VYtJ8/tBa7TkG7
        YVRN2eJw7OoTQwtHardgniNs57BS+f4tznNuVFFI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1600191890;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=bcjVu8HuSGRGYIbG3cKReMGEqxVQufnTKkK0KGamA60=;
        b=X/yCEJm24w9DYN9JOf2uR0VGFRTHF4b1N6W2My0pM6p/+XYujGYQbmFwkvY500bA
        yYYypcnmyJObV8hlUnw+b4UWDeru1oytaLsG3J8ASfkKDNubxop0HCO3uFeZ/ALnE3v
        HmIhC5SU8tOPQEkt5eKpRzlLPKSj63GD2V2aPqzM=
From:   LKFT <lkft@linaro.org>
To:     lkft@linaro.org, lkft-triage@lists.linaro.org,
        linux-kselftest@vger.kernel.org, linux-next@vger.kernel.org
Cc:     sfr@canb.auug.org.au, shuah@kernel.org
Subject: [REGRESSION] kselftest: next-20200915
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <0100017492de8180-c524cff4-bd4e-4777-9f33-7e1da2c986d2-000000@email.amazonses.com>
Date:   Tue, 15 Sep 2020 17:44:49 +0000
X-SES-Outgoing: 2020.09.15-54.240.8.29
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Kernel
* kernel: 5.9.0-rc5
* git repo: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: 6b02addb1d1748d21dd1261e46029b264be4e5a0
* git describe: next-20200915
* Test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20200915

## Regressions (compared to build next-20200914)

juno-r2:
  kselftest:
    * memfd_memfd_test

x86:
  kselftest-vsyscall-mode-native:
    * kvm_vmx_preemption_timer_test

## Fixes (compared to build next-20200914)

x86:
  kselftest-vsyscall-mode-none:
    * kvm_vmx_preemption_timer_test

## Summary
### hi6220-hikey, kselftest
* total: 161
* pass: 53
* fail: 79
* skip: 29
* xfail: 0
### i386, kselftest
* total: 166
* pass: 35
* fail: 102
* skip: 29
* xfail: 0
### juno-r2, kselftest
* total: 163
* pass: 57
* fail: 77
* skip: 29
* xfail: 0
### x86, kselftest
* total: 167
* pass: 59
* fail: 81
* skip: 27
* xfail: 0
### x86, kselftest-vsyscall-mode-native
* total: 168
* pass: 61
* fail: 80
* skip: 27
* xfail: 0
### x86, kselftest-vsyscall-mode-none
* total: 164
* pass: 58
* fail: 79
* skip: 27
* xfail: 0

## Environments
* dragonboard-410c
* hi6220-hikey
* i386
* juno-r2
* juno-r2-compat
* juno-r2-kasan
* nxp-ls2088
* qemu_arm
* qemu_arm64
* qemu_i386
* qemu_x86_64
* x15
* x86
* x86-kasan

## Suites
* kselftest
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

## Failures
### hi6220-hikey, kselftest
* bpf_test_verifier
* bpf_test_tag
* bpf_test_maps
* bpf_test_lpm_map
* bpf_test_progs
* bpf_test_dev_cgroup
* bpf_test_tcpbpf_user
* bpf_test_sysctl
* bpf_test_progs-no_alu32
* bpf_test_kmod.sh
* bpf_test_sock_addr.sh
* bpf_test_tunnel.sh
* bpf_test_lwt_seg6local.sh
* bpf_test_flow_dissector.sh
* bpf_test_lwt_ip_encap.sh
* bpf_test_tcp_check_syncookie.sh
* bpf_test_tc_tunnel.sh
* bpf_test_tc_edt.sh
* bpf_test_xdping.sh
* bpf_test_bpftool.sh
* clone3_clone3_cap_checkpoint_restore
* core_close_range_test
* firmware_fw_run_tests.sh
* ftrace_ftracetest
* lkdtm_BUG.sh
* lkdtm_WARNING.sh
* lkdtm_WARNING_MESSAGE.sh
* lkdtm_EXCEPTION.sh
* lkdtm_CORRUPT_LIST_ADD.sh
* lkdtm_CORRUPT_LIST_DEL.sh
* lkdtm_STACK_GUARD_PAGE_LEADING.sh
* lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* lkdtm_UNSET_SMEP.sh
* lkdtm_CORRUPT_PAC.sh
* lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* lkdtm_READ_AFTER_FREE.sh
* lkdtm_READ_BUDDY_AFTER_FREE.sh
* lkdtm_SLAB_FREE_DOUBLE.sh
* lkdtm_SLAB_FREE_CROSS.sh
* lkdtm_SLAB_FREE_PAGE.sh
* lkdtm_EXEC_DATA.sh
* lkdtm_EXEC_STACK.sh
* lkdtm_EXEC_KMALLOC.sh
* lkdtm_EXEC_VMALLOC.sh
* lkdtm_EXEC_RODATA.sh
* lkdtm_EXEC_USERSPACE.sh
* lkdtm_EXEC_NULL.sh
* lkdtm_ACCESS_USERSPACE.sh
* lkdtm_ACCESS_NULL.sh
* lkdtm_WRITE_RO.sh
* lkdtm_WRITE_RO_AFTER_INIT.sh
* lkdtm_WRITE_KERN.sh
* lkdtm_REFCOUNT_INC_OVERFLOW.sh
* lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* lkdtm_REFCOUNT_DEC_ZERO.sh
* lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* lkdtm_REFCOUNT_INC_ZERO.sh
* lkdtm_REFCOUNT_ADD_ZERO.sh
* lkdtm_REFCOUNT_INC_SATURATED.sh
* lkdtm_REFCOUNT_DEC_SATURATED.sh
* lkdtm_REFCOUNT_ADD_SATURATED.sh
* lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* lkdtm_USERCOPY_STACK_FRAME_TO.sh
* lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* lkdtm_USERCOPY_STACK_BEYOND.sh
* lkdtm_USERCOPY_KERNEL.sh
* lkdtm_STACKLEAK_ERASING.sh
* lkdtm_CFI_FORWARD_PROTO.sh
### i386, kselftest
* bpf_test_progs
* bpf_test_dev_cgroup
* bpf_test_tcpbpf_user
* bpf_get_cgroup_id_user
* bpf_test_socket_cookie
* bpf_test_netcnt
* bpf_test_tcpnotify_user
* bpf_test_sock_fields
* bpf_test_sysctl
* bpf_test_progs-no_alu32
* bpf_test_sock_addr.sh
* bpf_test_tunnel.sh
* bpf_test_lwt_seg6local.sh
* bpf_test_flow_dissector.sh
* bpf_test_tc_tunnel.sh
* bpf_test_xdping.sh
* bpf_test_bpftool.sh
* clone3_clone3_clear_sighand
* clone3_clone3_cap_checkpoint_restore
* core_close_range_test
* firmware_fw_run_tests.sh
* ftrace_ftracetest
* intel_pstate_run.sh
* kvm_cr4_cpuid_sync_test
* kvm_evmcs_test
* kvm_hyperv_cpuid
* kvm_mmio_warning_test
* kvm_platform_info_test
* kvm_set_sregs_test
* kvm_smm_test
* kvm_state_test
* kvm_vmx_preemption_timer_test
* kvm_svm_vmcall_test
* kvm_sync_regs_test
* kvm_vmx_close_while_nested_test
* kvm_vmx_dirty_log_test
* kvm_vmx_set_nested_state_test
* kvm_vmx_tsc_adjust_test
* kvm_xss_msr_test
* kvm_debug_regs
* kvm_clear_dirty_log_test
* kvm_demand_paging_test
* kvm_dirty_log_test
* kvm_kvm_create_max_vcpus
* kvm_set_memory_region_test
* kvm_steal_time
* lkdtm_BUG.sh
* lkdtm_WARNING.sh
* lkdtm_WARNING_MESSAGE.sh
* lkdtm_EXCEPTION.sh
* lkdtm_CORRUPT_LIST_ADD.sh
* lkdtm_CORRUPT_LIST_DEL.sh
* lkdtm_STACK_GUARD_PAGE_LEADING.sh
* lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* lkdtm_UNSET_SMEP.sh
* lkdtm_DOUBLE_FAULT.sh
* lkdtm_CORRUPT_PAC.sh
* lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* lkdtm_READ_AFTER_FREE.sh
* lkdtm_READ_BUDDY_AFTER_FREE.sh
* lkdtm_SLAB_FREE_DOUBLE.sh
* lkdtm_SLAB_FREE_CROSS.sh
* lkdtm_SLAB_FREE_PAGE.sh
* lkdtm_EXEC_DATA.sh
* lkdtm_EXEC_STACK.sh
* lkdtm_EXEC_KMALLOC.sh
* lkdtm_EXEC_VMALLOC.sh
* lkdtm_EXEC_RODATA.sh
* lkdtm_EXEC_USERSPACE.sh
* lkdtm_EXEC_NULL.sh
* lkdtm_ACCESS_USERSPACE.sh
* lkdtm_ACCESS_NULL.sh
* lkdtm_WRITE_RO.sh
* lkdtm_WRITE_RO_AFTER_INIT.sh
* lkdtm_WRITE_KERN.sh
* lkdtm_REFCOUNT_INC_OVERFLOW.sh
* lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* lkdtm_REFCOUNT_DEC_ZERO.sh
* lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* lkdtm_REFCOUNT_INC_ZERO.sh
* lkdtm_REFCOUNT_ADD_ZERO.sh
* lkdtm_REFCOUNT_INC_SATURATED.sh
* lkdtm_REFCOUNT_DEC_SATURATED.sh
* lkdtm_REFCOUNT_ADD_SATURATED.sh
* lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* lkdtm_USERCOPY_STACK_FRAME_TO.sh
* lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* lkdtm_USERCOPY_STACK_BEYOND.sh
* lkdtm_USERCOPY_KERNEL.sh
* lkdtm_STACKLEAK_ERASING.sh
* lkdtm_CFI_FORWARD_PROTO.sh
### juno-r2, kselftest
* bpf_test_maps
* bpf_get_cgroup_id_user
* bpf_test_socket_cookie
* bpf_test_netcnt
* bpf_test_tcpnotify_user
* bpf_test_sysctl
* bpf_test_progs-no_alu32
* bpf_test_sock_addr.sh
* bpf_test_tunnel.sh
* bpf_test_lwt_seg6local.sh
* bpf_test_flow_dissector.sh
* bpf_test_lwt_ip_encap.sh
* bpf_test_tcp_check_syncookie.sh
* bpf_test_tc_tunnel.sh
* bpf_test_tc_edt.sh
* bpf_test_xdping.sh
* bpf_test_bpftool.sh
* clone3_clone3_cap_checkpoint_restore
* core_close_range_test
* cpufreq_main.sh
* firmware_fw_run_tests.sh
* ftrace_ftracetest
* lkdtm_BUG.sh
* lkdtm_WARNING.sh
* lkdtm_WARNING_MESSAGE.sh
* lkdtm_EXCEPTION.sh
* lkdtm_CORRUPT_LIST_ADD.sh
* lkdtm_CORRUPT_LIST_DEL.sh
* lkdtm_STACK_GUARD_PAGE_LEADING.sh
* lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* lkdtm_UNSET_SMEP.sh
* lkdtm_CORRUPT_PAC.sh
* lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* lkdtm_READ_AFTER_FREE.sh
* lkdtm_READ_BUDDY_AFTER_FREE.sh
* lkdtm_SLAB_FREE_DOUBLE.sh
* lkdtm_SLAB_FREE_CROSS.sh
* lkdtm_SLAB_FREE_PAGE.sh
* lkdtm_EXEC_DATA.sh
* lkdtm_EXEC_STACK.sh
* lkdtm_EXEC_KMALLOC.sh
* lkdtm_EXEC_VMALLOC.sh
* lkdtm_EXEC_RODATA.sh
* lkdtm_EXEC_USERSPACE.sh
* lkdtm_EXEC_NULL.sh
* lkdtm_ACCESS_USERSPACE.sh
* lkdtm_ACCESS_NULL.sh
* lkdtm_WRITE_RO.sh
* lkdtm_WRITE_RO_AFTER_INIT.sh
* lkdtm_WRITE_KERN.sh
* lkdtm_REFCOUNT_INC_OVERFLOW.sh
* lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* lkdtm_REFCOUNT_DEC_ZERO.sh
* lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* lkdtm_REFCOUNT_INC_ZERO.sh
* lkdtm_REFCOUNT_ADD_ZERO.sh
* lkdtm_REFCOUNT_INC_SATURATED.sh
* lkdtm_REFCOUNT_DEC_SATURATED.sh
* lkdtm_REFCOUNT_ADD_SATURATED.sh
* lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* lkdtm_USERCOPY_STACK_FRAME_TO.sh
* lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* lkdtm_USERCOPY_STACK_BEYOND.sh
* lkdtm_USERCOPY_KERNEL.sh
* lkdtm_STACKLEAK_ERASING.sh
* lkdtm_CFI_FORWARD_PROTO.sh
### x86, kselftest
* bpf_test_progs
* bpf_test_dev_cgroup
* bpf_test_tcpbpf_user
* bpf_get_cgroup_id_user
* bpf_test_socket_cookie
* bpf_test_netcnt
* bpf_test_tcpnotify_user
* bpf_test_sock_fields
* bpf_test_sysctl
* bpf_test_progs-no_alu32
* bpf_test_sock_addr.sh
* bpf_test_tunnel.sh
* bpf_test_lwt_seg6local.sh
* bpf_test_flow_dissector.sh
* bpf_test_lwt_ip_encap.sh
* bpf_test_tc_tunnel.sh
* bpf_test_tc_edt.sh
* bpf_test_xdping.sh
* bpf_test_bpftool.sh
* clone3_clone3_cap_checkpoint_restore
* core_close_range_test
* firmware_fw_run_tests.sh
* ftrace_ftracetest
* intel_pstate_run.sh
* kvm_vmx_preemption_timer_test
* kvm_debug_regs
* lkdtm_BUG.sh
* lkdtm_WARNING.sh
* lkdtm_WARNING_MESSAGE.sh
* lkdtm_EXCEPTION.sh
* lkdtm_CORRUPT_LIST_ADD.sh
* lkdtm_CORRUPT_LIST_DEL.sh
* lkdtm_STACK_GUARD_PAGE_LEADING.sh
* lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* lkdtm_UNSET_SMEP.sh
* lkdtm_CORRUPT_PAC.sh
* lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* lkdtm_READ_AFTER_FREE.sh
* lkdtm_READ_BUDDY_AFTER_FREE.sh
* lkdtm_SLAB_FREE_DOUBLE.sh
* lkdtm_SLAB_FREE_CROSS.sh
* lkdtm_SLAB_FREE_PAGE.sh
* lkdtm_EXEC_DATA.sh
* lkdtm_EXEC_STACK.sh
* lkdtm_EXEC_KMALLOC.sh
* lkdtm_EXEC_VMALLOC.sh
* lkdtm_EXEC_RODATA.sh
* lkdtm_EXEC_USERSPACE.sh
* lkdtm_EXEC_NULL.sh
* lkdtm_ACCESS_USERSPACE.sh
* lkdtm_ACCESS_NULL.sh
* lkdtm_WRITE_RO.sh
* lkdtm_WRITE_RO_AFTER_INIT.sh
* lkdtm_WRITE_KERN.sh
* lkdtm_REFCOUNT_INC_OVERFLOW.sh
* lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* lkdtm_REFCOUNT_DEC_ZERO.sh
* lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* lkdtm_REFCOUNT_INC_ZERO.sh
* lkdtm_REFCOUNT_ADD_ZERO.sh
* lkdtm_REFCOUNT_INC_SATURATED.sh
* lkdtm_REFCOUNT_DEC_SATURATED.sh
* lkdtm_REFCOUNT_ADD_SATURATED.sh
* lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* lkdtm_USERCOPY_STACK_FRAME_TO.sh
* lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* lkdtm_USERCOPY_STACK_BEYOND.sh
* lkdtm_USERCOPY_KERNEL.sh
* lkdtm_STACKLEAK_ERASING.sh
* lkdtm_CFI_FORWARD_PROTO.sh
### x86, kselftest-vsyscall-mode-native
* bpf_test_progs
* bpf_test_dev_cgroup
* bpf_test_tcpbpf_user
* bpf_get_cgroup_id_user
* bpf_test_socket_cookie
* bpf_test_netcnt
* bpf_test_tcpnotify_user
* bpf_test_sock_fields
* bpf_test_sysctl
* bpf_test_progs-no_alu32
* bpf_test_sock_addr.sh
* bpf_test_tunnel.sh
* bpf_test_lwt_seg6local.sh
* bpf_test_flow_dissector.sh
* bpf_test_lwt_ip_encap.sh
* bpf_test_tc_tunnel.sh
* bpf_test_tc_edt.sh
* bpf_test_xdping.sh
* bpf_test_bpftool.sh
* clone3_clone3_cap_checkpoint_restore
* core_close_range_test
* firmware_fw_run_tests.sh
* ftrace_ftracetest
* intel_pstate_run.sh
* kvm_debug_regs
* lkdtm_BUG.sh
* lkdtm_WARNING.sh
* lkdtm_WARNING_MESSAGE.sh
* lkdtm_EXCEPTION.sh
* lkdtm_CORRUPT_LIST_ADD.sh
* lkdtm_CORRUPT_LIST_DEL.sh
* lkdtm_STACK_GUARD_PAGE_LEADING.sh
* lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* lkdtm_UNSET_SMEP.sh
* lkdtm_CORRUPT_PAC.sh
* lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* lkdtm_READ_AFTER_FREE.sh
* lkdtm_READ_BUDDY_AFTER_FREE.sh
* lkdtm_SLAB_FREE_DOUBLE.sh
* lkdtm_SLAB_FREE_CROSS.sh
* lkdtm_SLAB_FREE_PAGE.sh
* lkdtm_EXEC_DATA.sh
* lkdtm_EXEC_STACK.sh
* lkdtm_EXEC_KMALLOC.sh
* lkdtm_EXEC_VMALLOC.sh
* lkdtm_EXEC_RODATA.sh
* lkdtm_EXEC_USERSPACE.sh
* lkdtm_EXEC_NULL.sh
* lkdtm_ACCESS_USERSPACE.sh
* lkdtm_ACCESS_NULL.sh
* lkdtm_WRITE_RO.sh
* lkdtm_WRITE_RO_AFTER_INIT.sh
* lkdtm_WRITE_KERN.sh
* lkdtm_REFCOUNT_INC_OVERFLOW.sh
* lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* lkdtm_REFCOUNT_DEC_ZERO.sh
* lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* lkdtm_REFCOUNT_INC_ZERO.sh
* lkdtm_REFCOUNT_ADD_ZERO.sh
* lkdtm_REFCOUNT_INC_SATURATED.sh
* lkdtm_REFCOUNT_DEC_SATURATED.sh
* lkdtm_REFCOUNT_ADD_SATURATED.sh
* lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* lkdtm_USERCOPY_STACK_FRAME_TO.sh
* lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* lkdtm_USERCOPY_STACK_BEYOND.sh
* lkdtm_USERCOPY_KERNEL.sh
* lkdtm_STACKLEAK_ERASING.sh
* lkdtm_CFI_FORWARD_PROTO.sh
### x86, kselftest-vsyscall-mode-none
* bpf_test_progs
* bpf_test_dev_cgroup
* bpf_test_tcpbpf_user
* bpf_get_cgroup_id_user
* bpf_test_tcpnotify_user
* bpf_test_sock_fields
* bpf_test_sysctl
* bpf_test_progs-no_alu32
* bpf_test_sock_addr.sh
* bpf_test_tunnel.sh
* bpf_test_lwt_seg6local.sh
* bpf_test_flow_dissector.sh
* bpf_test_lwt_ip_encap.sh
* bpf_test_tc_tunnel.sh
* bpf_test_tc_edt.sh
* bpf_test_xdping.sh
* bpf_test_bpftool.sh
* clone3_clone3_cap_checkpoint_restore
* core_close_range_test
* firmware_fw_run_tests.sh
* ftrace_ftracetest
* intel_pstate_run.sh
* kvm_vmx_preemption_timer_test
* kvm_debug_regs
* lkdtm_BUG.sh
* lkdtm_WARNING.sh
* lkdtm_WARNING_MESSAGE.sh
* lkdtm_EXCEPTION.sh
* lkdtm_CORRUPT_LIST_ADD.sh
* lkdtm_CORRUPT_LIST_DEL.sh
* lkdtm_STACK_GUARD_PAGE_LEADING.sh
* lkdtm_STACK_GUARD_PAGE_TRAILING.sh
* lkdtm_UNSET_SMEP.sh
* lkdtm_CORRUPT_PAC.sh
* lkdtm_UNALIGNED_LOAD_STORE_WRITE.sh
* lkdtm_READ_AFTER_FREE.sh
* lkdtm_READ_BUDDY_AFTER_FREE.sh
* lkdtm_SLAB_FREE_DOUBLE.sh
* lkdtm_SLAB_FREE_CROSS.sh
* lkdtm_SLAB_FREE_PAGE.sh
* lkdtm_EXEC_DATA.sh
* lkdtm_EXEC_STACK.sh
* lkdtm_EXEC_KMALLOC.sh
* lkdtm_EXEC_VMALLOC.sh
* lkdtm_EXEC_RODATA.sh
* lkdtm_EXEC_USERSPACE.sh
* lkdtm_EXEC_NULL.sh
* lkdtm_ACCESS_USERSPACE.sh
* lkdtm_ACCESS_NULL.sh
* lkdtm_WRITE_RO.sh
* lkdtm_WRITE_RO_AFTER_INIT.sh
* lkdtm_WRITE_KERN.sh
* lkdtm_REFCOUNT_INC_OVERFLOW.sh
* lkdtm_REFCOUNT_ADD_OVERFLOW.sh
* lkdtm_REFCOUNT_INC_NOT_ZERO_OVERFLOW.sh
* lkdtm_REFCOUNT_ADD_NOT_ZERO_OVERFLOW.sh
* lkdtm_REFCOUNT_DEC_ZERO.sh
* lkdtm_REFCOUNT_DEC_NEGATIVE.sh
* lkdtm_REFCOUNT_DEC_AND_TEST_NEGATIVE.sh
* lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE.sh
* lkdtm_REFCOUNT_INC_ZERO.sh
* lkdtm_REFCOUNT_ADD_ZERO.sh
* lkdtm_REFCOUNT_INC_SATURATED.sh
* lkdtm_REFCOUNT_DEC_SATURATED.sh
* lkdtm_REFCOUNT_ADD_SATURATED.sh
* lkdtm_REFCOUNT_INC_NOT_ZERO_SATURATED.sh
* lkdtm_REFCOUNT_ADD_NOT_ZERO_SATURATED.sh
* lkdtm_REFCOUNT_DEC_AND_TEST_SATURATED.sh
* lkdtm_REFCOUNT_SUB_AND_TEST_SATURATED.sh
* lkdtm_USERCOPY_HEAP_SIZE_TO.sh
* lkdtm_USERCOPY_HEAP_SIZE_FROM.sh
* lkdtm_USERCOPY_HEAP_WHITELIST_TO.sh
* lkdtm_USERCOPY_HEAP_WHITELIST_FROM.sh
* lkdtm_USERCOPY_STACK_FRAME_TO.sh
* lkdtm_USERCOPY_STACK_FRAME_FROM.sh
* lkdtm_USERCOPY_STACK_BEYOND.sh
* lkdtm_USERCOPY_KERNEL.sh
* lkdtm_STACKLEAK_ERASING.sh
* lkdtm_CFI_FORWARD_PROTO.sh

## Skips
### hi6220-hikey, kselftest
* bpf_test_xdp_veth.sh
* cgroup_test_memcontrol
* cgroup_test_kmem
* cgroup_test_core
* cgroup_test_stress.sh
* efivarfs_efivarfs.sh
* fpu_run_test_fpu.sh
* intel_pstate_run.sh
* ir_ir_loopback.sh
* livepatch_test-livepatch.sh
* livepatch_test-callbacks.sh
* livepatch_test-shadow-vars.sh
* livepatch_test-state.sh
* livepatch_test-ftrace.sh
* lkdtm_PANIC.sh
* lkdtm_LOOP.sh
* lkdtm_EXHAUST_STACK.sh
* lkdtm_CORRUPT_STACK.sh
* lkdtm_CORRUPT_STACK_STRONG.sh
* lkdtm_DOUBLE_FAULT.sh
* lkdtm_OVERWRITE_ALLOCATION.sh
* lkdtm_WRITE_AFTER_FREE.sh
* lkdtm_WRITE_BUDDY_AFTER_FREE.sh
* lkdtm_SOFTLOCKUP.sh
* lkdtm_HARDLOCKUP.sh
* lkdtm_SPINLOCKUP.sh
* lkdtm_HUNG_TASK.sh
* lkdtm_REFCOUNT_TIMING.sh
* lkdtm_ATOMIC_TIMING.sh
### i386, kselftest
* bpf_test_xdp_veth.sh
* cgroup_test_memcontrol
* cgroup_test_kmem
* cgroup_test_core
* cgroup_test_stress.sh
* efivarfs_efivarfs.sh
* fpu_run_test_fpu.sh
* ir_ir_loopback.sh
* kexec_test_kexec_load.sh
* kexec_test_kexec_file_load.sh
* livepatch_test-livepatch.sh
* livepatch_test-callbacks.sh
* livepatch_test-shadow-vars.sh
* livepatch_test-state.sh
* livepatch_test-ftrace.sh
* lkdtm_PANIC.sh
* lkdtm_LOOP.sh
* lkdtm_EXHAUST_STACK.sh
* lkdtm_CORRUPT_STACK.sh
* lkdtm_CORRUPT_STACK_STRONG.sh
* lkdtm_OVERWRITE_ALLOCATION.sh
* lkdtm_WRITE_AFTER_FREE.sh
* lkdtm_WRITE_BUDDY_AFTER_FREE.sh
* lkdtm_SOFTLOCKUP.sh
* lkdtm_HARDLOCKUP.sh
* lkdtm_SPINLOCKUP.sh
* lkdtm_HUNG_TASK.sh
* lkdtm_REFCOUNT_TIMING.sh
* lkdtm_ATOMIC_TIMING.sh
### juno-r2, kselftest
* bpf_test_xdp_veth.sh
* cgroup_test_memcontrol
* cgroup_test_kmem
* cgroup_test_core
* cgroup_test_stress.sh
* efivarfs_efivarfs.sh
* fpu_run_test_fpu.sh
* intel_pstate_run.sh
* ir_ir_loopback.sh
* livepatch_test-livepatch.sh
* livepatch_test-callbacks.sh
* livepatch_test-shadow-vars.sh
* livepatch_test-state.sh
* livepatch_test-ftrace.sh
* lkdtm_PANIC.sh
* lkdtm_LOOP.sh
* lkdtm_EXHAUST_STACK.sh
* lkdtm_CORRUPT_STACK.sh
* lkdtm_CORRUPT_STACK_STRONG.sh
* lkdtm_DOUBLE_FAULT.sh
* lkdtm_OVERWRITE_ALLOCATION.sh
* lkdtm_WRITE_AFTER_FREE.sh
* lkdtm_WRITE_BUDDY_AFTER_FREE.sh
* lkdtm_SOFTLOCKUP.sh
* lkdtm_HARDLOCKUP.sh
* lkdtm_SPINLOCKUP.sh
* lkdtm_HUNG_TASK.sh
* lkdtm_REFCOUNT_TIMING.sh
* lkdtm_ATOMIC_TIMING.sh
### x86, kselftest
* bpf_test_xdp_veth.sh
* cgroup_test_memcontrol
* cgroup_test_kmem
* cgroup_test_core
* cgroup_test_stress.sh
* efivarfs_efivarfs.sh
* fpu_run_test_fpu.sh
* ir_ir_loopback.sh
* kexec_test_kexec_load.sh
* kexec_test_kexec_file_load.sh
* kvm_mmio_warning_test
* kvm_svm_vmcall_test
* lkdtm_PANIC.sh
* lkdtm_LOOP.sh
* lkdtm_EXHAUST_STACK.sh
* lkdtm_CORRUPT_STACK.sh
* lkdtm_CORRUPT_STACK_STRONG.sh
* lkdtm_DOUBLE_FAULT.sh
* lkdtm_OVERWRITE_ALLOCATION.sh
* lkdtm_WRITE_AFTER_FREE.sh
* lkdtm_WRITE_BUDDY_AFTER_FREE.sh
* lkdtm_SOFTLOCKUP.sh
* lkdtm_HARDLOCKUP.sh
* lkdtm_SPINLOCKUP.sh
* lkdtm_HUNG_TASK.sh
* lkdtm_REFCOUNT_TIMING.sh
* lkdtm_ATOMIC_TIMING.sh
### x86, kselftest-vsyscall-mode-native
* bpf_test_xdp_veth.sh
* cgroup_test_memcontrol
* cgroup_test_kmem
* cgroup_test_core
* cgroup_test_stress.sh
* efivarfs_efivarfs.sh
* fpu_run_test_fpu.sh
* ir_ir_loopback.sh
* kexec_test_kexec_load.sh
* kexec_test_kexec_file_load.sh
* kvm_mmio_warning_test
* kvm_svm_vmcall_test
* lkdtm_PANIC.sh
* lkdtm_LOOP.sh
* lkdtm_EXHAUST_STACK.sh
* lkdtm_CORRUPT_STACK.sh
* lkdtm_CORRUPT_STACK_STRONG.sh
* lkdtm_DOUBLE_FAULT.sh
* lkdtm_OVERWRITE_ALLOCATION.sh
* lkdtm_WRITE_AFTER_FREE.sh
* lkdtm_WRITE_BUDDY_AFTER_FREE.sh
* lkdtm_SOFTLOCKUP.sh
* lkdtm_HARDLOCKUP.sh
* lkdtm_SPINLOCKUP.sh
* lkdtm_HUNG_TASK.sh
* lkdtm_REFCOUNT_TIMING.sh
* lkdtm_ATOMIC_TIMING.sh
### x86, kselftest-vsyscall-mode-none
* bpf_test_xdp_veth.sh
* cgroup_test_memcontrol
* cgroup_test_kmem
* cgroup_test_core
* cgroup_test_stress.sh
* efivarfs_efivarfs.sh
* fpu_run_test_fpu.sh
* ir_ir_loopback.sh
* kexec_test_kexec_load.sh
* kexec_test_kexec_file_load.sh
* kvm_mmio_warning_test
* kvm_svm_vmcall_test
* lkdtm_PANIC.sh
* lkdtm_LOOP.sh
* lkdtm_EXHAUST_STACK.sh
* lkdtm_CORRUPT_STACK.sh
* lkdtm_CORRUPT_STACK_STRONG.sh
* lkdtm_DOUBLE_FAULT.sh
* lkdtm_OVERWRITE_ALLOCATION.sh
* lkdtm_WRITE_AFTER_FREE.sh
* lkdtm_WRITE_BUDDY_AFTER_FREE.sh
* lkdtm_SOFTLOCKUP.sh
* lkdtm_HARDLOCKUP.sh
* lkdtm_SPINLOCKUP.sh
* lkdtm_HUNG_TASK.sh
* lkdtm_REFCOUNT_TIMING.sh
* lkdtm_ATOMIC_TIMING.sh

--
Linaro LKFT
https://lkft.linaro.org
