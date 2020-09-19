Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC7A271065
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Sep 2020 21:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgIST4k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Sep 2020 15:56:40 -0400
Received: from a48-34.smtp-out.amazonses.com ([54.240.48.34]:58996 "EHLO
        a48-34.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgIST4k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Sep 2020 15:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=iv2huwi6zmqabdt6b4lbuyos6pcvh5gh; d=linaro.org; t=1600545398;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date;
        bh=k6cEeAvVSC8GlzjEww5wcm+t/vczcQ0go8rdKw6+KS0=;
        b=TTuK7S5klCQXq6fikays+K7sxEIWRVBOGK2h0kpHVu118LcUE1wI1imNbrTgQaht
        mWClIdQpD21wUttC8+Tb0Y9QNQKA+FEOdoIl0oyBPwhF/4iDH6rAxqCuuXw9MVYAi0z
        QZvhRmsXHFsMqp6JU2ltIGEYx+1iywVuNXSVcHyg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1600545398;
        h=From:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:Date:Feedback-ID;
        bh=k6cEeAvVSC8GlzjEww5wcm+t/vczcQ0go8rdKw6+KS0=;
        b=isqaaYIU5t5c9uQY90ZgtZxa9+35pNG/lc6OXERfo0o7GMoNKeeWdvbhJt9CpUg3
        /C8dB9tQuB7BfhMUVyTNwgYyDB+DIoaVhYHmC9G6JbWrl/gWlICW1ZnBRuNv1fZk2fr
        tkiC+zyzF6aLMLV9aqds3OfsnHGE9/zj2yzs+H3M=
From:   LKFT <lkft@linaro.org>
To:     lkft@linaro.org, lkft-triage@lists.linaro.org,
        linux-kselftest@vger.kernel.org, linux-next@vger.kernel.org
Cc:     sfr@canb.auug.org.au, shuah@kernel.org
Subject: [REGRESSION] kselftest: next-20200918
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID: <01000174a7f09e85-5d9ca9c6-1d75-4c00-9fed-aa405edfe366-000000@email.amazonses.com>
Date:   Sat, 19 Sep 2020 19:56:38 +0000
X-SES-Outgoing: 2020.09.19-54.240.48.34
Feedback-ID: 1.us-east-1.MCLpz+6YeXzvh9aTd6J8upg22bI0XPzIkR2gghvgyqQ=:AmazonSES
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## Kernel
* kernel: 5.9.0-rc5
* git repo: ['https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git', 'https://gitlab.com/Linaro/lkft/mirrors/next/linux-next']
* git branch: master
* git commit: b652d2a5f2a4e93d803cc33eb57fdc41ee528500
* git describe: next-20200918
* Test details: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20200918

## Regressions (compared to build next-20200917)

juno-r2:
  kselftest:
    * cgroup_test_freezer

x86:
  kselftest-vsyscall-mode-native:
    * net_fib-onlink-tests.sh
    * tc-testing_tdc.sh
  kselftest-vsyscall-mode-none:
    * kvm_vmx_preemption_timer_test

## Fixes (compared to build next-20200917)

x86:
  kselftest:
    * kvm_vmx_preemption_timer_test
    * net_ip_defrag.sh
    * proc_read

i386:
  kselftest:
    * pidfd_pidfd_test

## Summary
### i386, kselftest
* total: 318
* pass: 144
* fail: 135
* skip: 39
* xfail: 0
### juno-r2, kselftest
* total: 278
* pass: 127
* fail: 116
* skip: 35
* xfail: 0
### x86, kselftest
* total: 312
* pass: 167
* fail: 111
* skip: 34
* xfail: 0
### x86, kselftest-vsyscall-mode-native
* total: 315
* pass: 166
* fail: 115
* skip: 34
* xfail: 0
### x86, kselftest-vsyscall-mode-none
* total: 314
* pass: 166
* fail: 114
* skip: 34
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
* bpf_test_lwt_ip_encap.sh
* bpf_test_tc_tunnel.sh
* bpf_test_tc_edt.sh
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
* mincore_mincore_selftest
* mqueue_mq_perf_tests
* net_fib_tests.sh
* net_fib-onlink-tests.sh
* net_pmtu.sh
* net_udpgso_bench.sh
* net_psock_snd.sh
* net_test_vxlan_under_vrf.sh
* net_l2tp.sh
* net_traceroute.sh
* net_altnames.sh
* net_icmp_redirect.sh
* net_txtimestamp.sh
* net_vrf-xfrm-tests.sh
* net_devlink_port_split.py
* netfilter_nft_concat_range.sh
* netfilter_nft_queue.sh
* pidfd_pidfd_open_test
* pidfd_pidfd_poll_test
* proc_proc-self-syscall
* proc_proc-fsconfig-hidepid
* pstore_pstore_tests
* ptrace_vmaccess
* openat2_openat2_test
* openat2_resolve_test
* openat2_rename_attack_test
* rtc_rtctest
* seccomp_seccomp_bpf
* seccomp_seccomp_benchmark
* splice_short_splice_read.sh
* vm_run_vmtests
### juno-r2, kselftest
* bpf_test_tag
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
* cgroup_test_freezer
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
* memory-hotplug_mem-on-off-test.sh
* mincore_mincore_selftest
* net_run_netsocktests
* net_fib_tests.sh
* net_fib-onlink-tests.sh
* net_pmtu.sh
* net_udpgso_bench.sh
* net_fib_rule_tests.sh
* net_psock_snd.sh
* net_test_vxlan_under_vrf.sh
* net_tcp_fastopen_backup_key.sh
* net_l2tp.sh
* net_fib_nexthops.sh
* net_altnames.sh
* net_icmp_redirect.sh
* net_txtimestamp.sh
* net_vrf-xfrm-tests.sh
* net_devlink_port_split.py
* netfilter_nft_nat.sh
* netfilter_conntrack_icmp_related.sh
* netfilter_nft_concat_range.sh
* netfilter_nft_queue.sh
* pidfd_pidfd_test
* pidfd_pidfd_fdinfo_test
* pidfd_pidfd_open_test
* pidfd_pidfd_poll_test
* proc_proc-fsconfig-hidepid
* pstore_pstore_tests
* ptrace_vmaccess
* openat2_openat2_test
* openat2_resolve_test
* openat2_rename_attack_test
* rtc_rtctest
* seccomp_seccomp_bpf
* seccomp_seccomp_benchmark
* splice_short_splice_read.sh
* sysctl_sysctl.sh
* tc-testing_tdc.sh
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
* mqueue_mq_perf_tests
* net_xfrm_policy.sh
* net_fib_tests.sh
* net_fib-onlink-tests.sh
* net_pmtu.sh
* net_udpgso_bench.sh
* net_psock_snd.sh
* net_test_vxlan_under_vrf.sh
* net_l2tp.sh
* net_traceroute.sh
* net_altnames.sh
* net_icmp_redirect.sh
* net_txtimestamp.sh
* net_vrf-xfrm-tests.sh
* net_devlink_port_split.py
* netfilter_nft_concat_range.sh
* netfilter_nft_queue.sh
* pidfd_pidfd_open_test
* pidfd_pidfd_poll_test
* proc_proc-fsconfig-hidepid
* pstore_pstore_tests
* ptrace_vmaccess
* openat2_openat2_test
* openat2_resolve_test
* openat2_rename_attack_test
* rtc_rtctest
* seccomp_seccomp_bpf
* seccomp_seccomp_benchmark
* splice_short_splice_read.sh
* vm_run_vmtests
* x86_syscall_numbering_64
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
* mincore_mincore_selftest
* mqueue_mq_perf_tests
* net_run_netsocktests
* net_xfrm_policy.sh
* net_fib_tests.sh
* net_fib-onlink-tests.sh
* net_pmtu.sh
* net_udpgso_bench.sh
* net_psock_snd.sh
* net_test_vxlan_under_vrf.sh
* net_l2tp.sh
* net_traceroute.sh
* net_altnames.sh
* net_icmp_redirect.sh
* net_txtimestamp.sh
* net_vrf-xfrm-tests.sh
* net_devlink_port_split.py
* netfilter_nft_concat_range.sh
* netfilter_nft_queue.sh
* pidfd_pidfd_test
* pidfd_pidfd_open_test
* pidfd_pidfd_poll_test
* proc_proc-fsconfig-hidepid
* pstore_pstore_tests
* ptrace_vmaccess
* openat2_openat2_test
* openat2_resolve_test
* openat2_rename_attack_test
* rtc_rtctest
* seccomp_seccomp_bpf
* seccomp_seccomp_benchmark
* splice_short_splice_read.sh
* tc-testing_tdc.sh
* vm_run_vmtests
* x86_syscall_numbering_64
### x86, kselftest-vsyscall-mode-none
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
* mincore_mincore_selftest
* mqueue_mq_perf_tests
* net_run_netsocktests
* net_xfrm_policy.sh
* net_fib_tests.sh
* net_pmtu.sh
* net_udpgso_bench.sh
* net_psock_snd.sh
* net_test_vxlan_under_vrf.sh
* net_l2tp.sh
* net_traceroute.sh
* net_altnames.sh
* net_icmp_redirect.sh
* net_txtimestamp.sh
* net_vrf-xfrm-tests.sh
* net_devlink_port_split.py
* netfilter_nft_concat_range.sh
* netfilter_nft_queue.sh
* pidfd_pidfd_open_test
* pidfd_pidfd_poll_test
* proc_proc-fsconfig-hidepid
* pstore_pstore_tests
* ptrace_vmaccess
* openat2_openat2_test
* openat2_resolve_test
* openat2_rename_attack_test
* rtc_rtctest
* seccomp_seccomp_bpf
* seccomp_seccomp_benchmark
* splice_short_splice_read.sh
* vm_run_vmtests
* x86_fsgsbase_64
* x86_syscall_numbering_64

## Skips
### i386, kselftest
* bpf_test_xdp_veth.sh
* bpf_test_bpftool_metadata.sh
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
* memory-hotplug_mem-on-off-test.sh
* net_reuseport_bpf_numa
* netfilter_ipvs.sh
* netfilter_nft_conntrack_helper.sh
* netfilter_nft_meta.sh
* proc_proc-pid-vm
* pstore_pstore_post_reboot_tests
* tpm2_test_smoke.sh
* tpm2_test_space.sh
### juno-r2, kselftest
* bpf_test_xdp_veth.sh
* bpf_test_bpftool_metadata.sh
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
* net_xfrm_policy.sh
* netfilter_ipvs.sh
* netfilter_nft_conntrack_helper.sh
* netfilter_nft_meta.sh
* proc_proc-pid-vm
* pstore_pstore_post_reboot_tests
### x86, kselftest
* bpf_test_xdp_veth.sh
* bpf_test_bpftool_metadata.sh
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
* netfilter_ipvs.sh
* netfilter_nft_conntrack_helper.sh
* netfilter_nft_meta.sh
* pstore_pstore_post_reboot_tests
* tpm2_test_smoke.sh
* tpm2_test_space.sh
### x86, kselftest-vsyscall-mode-native
* bpf_test_xdp_veth.sh
* bpf_test_bpftool_metadata.sh
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
* netfilter_ipvs.sh
* netfilter_nft_conntrack_helper.sh
* netfilter_nft_meta.sh
* pstore_pstore_post_reboot_tests
* tpm2_test_smoke.sh
* tpm2_test_space.sh
### x86, kselftest-vsyscall-mode-none
* bpf_test_xdp_veth.sh
* bpf_test_bpftool_metadata.sh
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
* netfilter_ipvs.sh
* netfilter_nft_conntrack_helper.sh
* netfilter_nft_meta.sh
* pstore_pstore_post_reboot_tests
* tpm2_test_smoke.sh
* tpm2_test_space.sh

--
Linaro LKFT
https://lkft.linaro.org
