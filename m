Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F8EF8FD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2019 13:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfKLMoD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Nov 2019 07:44:03 -0500
Received: from foss.arm.com ([217.140.110.172]:33238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfKLMoC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Nov 2019 07:44:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6258A30E;
        Tue, 12 Nov 2019 04:44:01 -0800 (PST)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB7973F6C4;
        Tue, 12 Nov 2019 04:43:59 -0800 (PST)
Subject: Re: next-20191111 kselftest results
To:     ci_notify@linaro.org, lkft-triage@lists.linaro.org,
        dan.rue@linaro.org, anders.roxell@linaro.org,
        naresh.kamboju@linaro.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <Catalin.Marinas@arm.com>
References: <1116308198.389.1573542040574.JavaMail.javamailuser@localhost>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <00673803-67da-5d53-9269-d23c9cd61a7a@arm.com>
Date:   Tue, 12 Nov 2019 12:43:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1116308198.389.1573542040574.JavaMail.javamailuser@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

On 12/11/2019 07:00, ci_notify@linaro.org wrote:
> Summary
> ------------------------------------------------------------------------
> kernel: 5.4.0-rc6
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> git branch: master
> git commit: 6980b7f6f9db7d5f344ae202012460e9d8869d89
> git describe: next-20191111
> Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191111
> 
> Regressions (compared to build next-20191108)
> ------------------------------------------------------------------------
> qemu_arm:                                                                                                      
>  kselftest:                                                                                         
>     * net_so_txtime.sh                                                                                                         
> qemu_x86_64:                                                                                                      
>  kselftest:                                                                                         
>     * epoll_epoll_wakeup_test                                                                                                         
>                                                                                          
>     * livepatch_test-callbacks.sh                                                                                                         
>                                                                                                           
>                                                                                                                        
[snip]

I've seen CI has picked up from next the new arm64 signals tests:

> 
> qemu_arm64:
> * kselftest/arm64_fake_sigreturn_bad_magic
> * kselftest/arm64_fake_sigreturn_bad_size
> * kselftest/arm64_fake_sigreturn_bad_size_for_magic0
> * kselftest/arm64_fake_sigreturn_duplicated_fpsimd
> * kselftest/arm64_fake_sigreturn_misaligned_sp
> * kselftest/arm64_fake_sigreturn_missing_fpsimd
> * kselftest/arm64_mangle_pstate_invalid_compat_toggle
> * kselftest/arm64_mangle_pstate_invalid_daif_bits
> * kselftest/arm64_mangle_pstate_invalid_mode_el1h
> * kselftest/arm64_mangle_pstate_invalid_mode_el1t
> * kselftest/arm64_mangle_pstate_invalid_mode_el2h
> * kselftest/arm64_mangle_pstate_invalid_mode_el2t
> * kselftest/arm64_mangle_pstate_invalid_mode_el3h
> * kselftest/arm64_mangle_pstate_invalid_mode_el3t


and they are all failing in the same way :< :

# Warning file fake_sigreturn_bad_magic is not executable, correct this.

I never saw this kind of issues while testing locally installing on JUNO or a model with

make TARGETS=arm64 INSTALL_PATH=<nfs_mount>/KSFT kselftest-install

OR

make TARGETS=arm64 -C tools/testing/selftests/ INSTALL_PATH=<nfs_mount>/KSFT install

so I was wondering if you have a custom build setup/logic.

Thanks

Cristian

> * kselftest/bpf_get_cgroup_id_user
> * kselftest/bpf_test_bpftool_build.sh
> * kselftest/bpf_test_dev_cgroup
> * kselftest/bpf_test_flow_dissector.sh
> * kselftest/bpf_test_kmod.sh
> * kselftest/bpf_test_lpm_map
> * kselftest/bpf_test_lwt_ip_encap.sh
> * kselftest/bpf_test_lwt_seg6local.sh
> * kselftest/bpf_test_maps
> * kselftest/bpf_test_netcnt
> * kselftest/bpf_test_progs
> * kselftest/bpf_test_progs-no_alu32
> * kselftest/bpf_test_select_reuseport
> * kselftest/bpf_test_skb_cgroup_id.sh
> * kselftest/bpf_test_sock_addr.sh
> * kselftest/bpf_test_socket_cookie
> * kselftest/bpf_test_sock_fields
> * kselftest/bpf_test_sockmap
> * kselftest/bpf_test_sysctl
> * kselftest/bpf_test_tag
> * kselftest/bpf_test_tc_edt.sh
> * kselftest/bpf_test_tcpbpf_user
> * kselftest/bpf_test_tcp_check_syncookie.sh
> * kselftest/bpf_test_tcpnotify_user
> * kselftest/bpf_test_tc_tunnel.sh
> * kselftest/bpf_test_tunnel.sh
> * kselftest/bpf_test_verifier
> * kselftest/bpf_test_xdping.sh
> * kselftest/bpf_test_xdp_meta.sh
> * kselftest/bpf_test_xdp_redirect.sh
> * kselftest/bpf_test_xdp_vlan_mode_generic.sh
> * kselftest/bpf_test_xdp_vlan_mode_native.sh
> * kselftest/bpf_xdping
> * kselftest/clone3_clone3_clear_sighand
> * kselftest/cpufreq_main.sh
> * kselftest/firmware_fw_run_tests.sh
> * kselftest/kvm_clear_dirty_log_test
> * kselftest/kvm_cr4_cpuid_sync_test
> * kselftest/kvm_dirty_log_test
> * kselftest/kvm_evmcs_test
> * kselftest/kvm_hyperv_cpuid
> * kselftest/kvm_kvm_create_max_vcpus
> * kselftest/kvm_mmio_warning_test
> * kselftest/kvm_platform_info_test
> * kselftest/kvm_set_sregs_test
> * kselftest/kvm_smm_test
> * kselftest/kvm_state_test
> * kselftest/kvm_sync_regs_test
> * kselftest/kvm_vmx_close_while_nested_test
> * kselftest/kvm_vmx_dirty_log_test
> * kselftest/kvm_vmx_set_nested_state_test
> * kselftest/kvm_vmx_tsc_adjust_test
> * kselftest/net_fib-onlink-tests.sh
> * kselftest/net_fib_rule_tests.sh
> * kselftest/net_fib_tests.sh
> * kselftest/netfilter_conntrack_icmp_related.sh
> * kselftest/netfilter_nft_nat.sh
> * kselftest/net_ip_defrag.sh
> * kselftest/net_l2tp.sh
> * kselftest/net_pmtu.sh
> * kselftest/net_psock_snd.sh
> * kselftest/net_run_netsocktests
> * kselftest/net_tcp_fastopen_backup_key.sh
> * kselftest/net_test_vxlan_under_vrf.sh
> * kselftest/net_udpgro_bench.sh
> * kselftest/net_udpgro.sh
> * kselftest/net_udpgso_bench.sh
> * kselftest/pidfd_pidfd_fdinfo_test
> * kselftest/pidfd_pidfd_open_test
> * kselftest/pidfd_pidfd_poll_test
> * kselftest/pidfd_pidfd_test
> * kselftest/pidfd_pidfd_wait
> * kselftest/pstore_pstore_tests
> * kselftest/rseq_basic_percpu_ops_test
> * kselftest/rtc_rtctest
> * kselftest/timers_set-timer-lat
> * kselftest/timestamping_txtimestamp.sh
> * kselftest/tpm2_test_smoke.sh
> * kselftest/tpm2_test_space.sh
> 
> qemu_arm:
> * kselftest/bpf_get_cgroup_id_user
> * kselftest/bpf_test_bpftool_build.sh
> * kselftest/bpf_test_dev_cgroup
> * kselftest/bpf_test_flow_dissector.sh
> * kselftest/bpf_test_hashmap
> * kselftest/bpf_test_kmod.sh
> * kselftest/bpf_test_lwt_ip_encap.sh
> * kselftest/bpf_test_lwt_seg6local.sh
> * kselftest/bpf_test_maps
> * kselftest/bpf_test_netcnt
> * kselftest/bpf_test_progs
> * kselftest/bpf_test_progs-no_alu32
> * kselftest/bpf_test_select_reuseport
> * kselftest/bpf_test_skb_cgroup_id.sh
> * kselftest/bpf_test_sock_addr.sh
> * kselftest/bpf_test_socket_cookie
> * kselftest/bpf_test_sock_fields
> * kselftest/bpf_test_sockmap
> * kselftest/bpf_test_sysctl
> * kselftest/bpf_test_tag
> * kselftest/bpf_test_tc_edt.sh
> * kselftest/bpf_test_tcpbpf_user
> * kselftest/bpf_test_tcp_check_syncookie.sh
> * kselftest/bpf_test_tcpnotify_user
> * kselftest/bpf_test_tc_tunnel.sh
> * kselftest/bpf_test_tunnel.sh
> * kselftest/bpf_test_verifier
> * kselftest/bpf_test_xdping.sh
> * kselftest/bpf_test_xdp_meta.sh
> * kselftest/bpf_test_xdp_redirect.sh
> * kselftest/bpf_test_xdp_vlan_mode_generic.sh
> * kselftest/bpf_test_xdp_vlan_mode_native.sh
> * kselftest/bpf_xdping
> * kselftest/clone3_clone3_clear_sighand
> * kselftest/cpufreq_main.sh
> * kselftest/firmware_fw_run_tests.sh
> * kselftest/kvm_clear_dirty_log_test
> * kselftest/kvm_cr4_cpuid_sync_test
> * kselftest/kvm_dirty_log_test
> * kselftest/kvm_evmcs_test
> * kselftest/kvm_hyperv_cpuid
> * kselftest/kvm_kvm_create_max_vcpus
> * kselftest/kvm_mmio_warning_test
> * kselftest/kvm_platform_info_test
> * kselftest/kvm_set_sregs_test
> * kselftest/kvm_smm_test
> * kselftest/kvm_state_test
> * kselftest/kvm_sync_regs_test
> * kselftest/kvm_vmx_close_while_nested_test
> * kselftest/kvm_vmx_dirty_log_test
> * kselftest/kvm_vmx_set_nested_state_test
> * kselftest/kvm_vmx_tsc_adjust_test
> * kselftest/lib_bitmap.sh
> * kselftest/net_fib-onlink-tests.sh
> * kselftest/net_fib_rule_tests.sh
> * kselftest/net_fib_tests.sh
> * kselftest/netfilter_conntrack_icmp_related.sh
> * kselftest/netfilter_nft_nat.sh
> * kselftest/net_ip_defrag.sh
> * kselftest/net_l2tp.sh
> * kselftest/net_pmtu.sh
> * kselftest/net_psock_snd.sh
> * kselftest/net_reuseport_bpf_numa
> * kselftest/net_run_netsocktests
> * kselftest/net_so_txtime.sh
> * kselftest/net_tcp_fastopen_backup_key.sh
> * kselftest/net_test_vxlan_under_vrf.sh
> * kselftest/net_udpgro_bench.sh
> * kselftest/net_udpgro.sh
> * kselftest/net_udpgso_bench.sh
> * kselftest/pidfd_pidfd_open_test
> * kselftest/pidfd_pidfd_poll_test
> * kselftest/pidfd_pidfd_test
> * kselftest/proc_proc-self-syscall
> * kselftest/pstore_pstore_tests
> * kselftest/rseq_basic_percpu_ops_test
> * kselftest/rtc_rtctest
> * kselftest/timers_set-timer-lat
> * kselftest/timestamping_txtimestamp.sh
> * kselftest/tpm2_test_smoke.sh
> * kselftest/tpm2_test_space.sh
> 
> qemu_i386:
> * kselftest/bpf_get_cgroup_id_user
> * kselftest/bpf_test_bpftool_build.sh
> * kselftest/bpf_test_dev_cgroup
> * kselftest/bpf_test_flow_dissector.sh
> * kselftest/bpf_test_hashmap
> * kselftest/bpf_test_lwt_ip_encap.sh
> * kselftest/bpf_test_lwt_seg6local.sh
> * kselftest/bpf_test_maps
> * kselftest/bpf_test_netcnt
> * kselftest/bpf_test_progs
> * kselftest/bpf_test_progs-no_alu32
> * kselftest/bpf_test_select_reuseport
> * kselftest/bpf_test_skb_cgroup_id.sh
> * kselftest/bpf_test_sock_addr.sh
> * kselftest/bpf_test_socket_cookie
> * kselftest/bpf_test_sock_fields
> * kselftest/bpf_test_sockmap
> * kselftest/bpf_test_sysctl
> * kselftest/bpf_test_tc_edt.sh
> * kselftest/bpf_test_tcpbpf_user
> * kselftest/bpf_test_tcp_check_syncookie.sh
> * kselftest/bpf_test_tcpnotify_user
> * kselftest/bpf_test_tc_tunnel.sh
> * kselftest/bpf_test_tunnel.sh
> * kselftest/bpf_test_xdping.sh
> * kselftest/bpf_test_xdp_meta.sh
> * kselftest/bpf_test_xdp_redirect.sh
> * kselftest/bpf_test_xdp_vlan_mode_generic.sh
> * kselftest/bpf_test_xdp_vlan_mode_native.sh
> * kselftest/bpf_xdping
> * kselftest/clone3_clone3_clear_sighand
> * kselftest/cpufreq_main.sh
> * kselftest/firmware_fw_run_tests.sh
> * kselftest/kvm_clear_dirty_log_test
> * kselftest/kvm_cr4_cpuid_sync_test
> * kselftest/kvm_dirty_log_test
> * kselftest/kvm_evmcs_test
> * kselftest/kvm_hyperv_cpuid
> * kselftest/kvm_kvm_create_max_vcpus
> * kselftest/kvm_mmio_warning_test
> * kselftest/kvm_platform_info_test
> * kselftest/kvm_set_sregs_test
> * kselftest/kvm_smm_test
> * kselftest/kvm_state_test
> * kselftest/kvm_sync_regs_test
> * kselftest/kvm_vmx_close_while_nested_test
> * kselftest/kvm_vmx_dirty_log_test
> * kselftest/kvm_vmx_set_nested_state_test
> * kselftest/kvm_vmx_tsc_adjust_test
> * kselftest/lib_bitmap.sh
> * kselftest/mqueue_mq_perf_tests
> * kselftest/net_fib-onlink-tests.sh
> * kselftest/net_fib_tests.sh
> * kselftest/netfilter_conntrack_icmp_related.sh
> * kselftest/netfilter_nft_nat.sh
> * kselftest/net_ip_defrag.sh
> * kselftest/net_l2tp.sh
> * kselftest/net_pmtu.sh
> * kselftest/net_psock_snd.sh
> * kselftest/net_run_netsocktests
> * kselftest/net_test_vxlan_under_vrf.sh
> * kselftest/net_traceroute.sh
> * kselftest/net_udpgro_bench.sh
> * kselftest/net_udpgro.sh
> * kselftest/net_udpgso_bench.sh
> * kselftest/net_xfrm_policy.sh
> * kselftest/pidfd_pidfd_open_test
> * kselftest/pidfd_pidfd_poll_test
> * kselftest/proc_proc-self-syscall
> * kselftest/pstore_pstore_tests
> * kselftest/rseq_run_param_test.sh
> * kselftest/rtc_rtctest
> * kselftest/size_get_size
> * kselftest/timers_set-timer-lat
> * kselftest/timestamping_txtimestamp.sh
> * kselftest/tpm2_test_smoke.sh
> * kselftest/tpm2_test_space.sh
> * kselftest/vm_run_vmtests
> * kselftest/x86_ldt_gdt_32
> * kselftest/x86_sigreturn_32
> 
> x15:
> * kselftest/bpf_get_cgroup_id_user
> * kselftest/bpf_test_bpftool_build.sh
> * kselftest/bpf_test_dev_cgroup
> * kselftest/bpf_test_flow_dissector.sh
> * kselftest/bpf_test_hashmap
> * kselftest/bpf_test_kmod.sh
> * kselftest/bpf_test_lwt_ip_encap.sh
> * kselftest/bpf_test_lwt_seg6local.sh
> * kselftest/bpf_test_maps
> * kselftest/bpf_test_netcnt
> * kselftest/bpf_test_progs
> * kselftest/bpf_test_progs-no_alu32
> * kselftest/bpf_test_select_reuseport
> * kselftest/bpf_test_skb_cgroup_id.sh
> * kselftest/bpf_test_sock_addr.sh
> * kselftest/bpf_test_socket_cookie
> * kselftest/bpf_test_sock_fields
> * kselftest/bpf_test_sockmap
> * kselftest/bpf_test_sysctl
> * kselftest/bpf_test_tag
> * kselftest/bpf_test_tc_edt.sh
> * kselftest/bpf_test_tcpbpf_user
> * kselftest/bpf_test_tcp_check_syncookie.sh
> * kselftest/bpf_test_tcpnotify_user
> * kselftest/bpf_test_tc_tunnel.sh
> * kselftest/bpf_test_tunnel.sh
> * kselftest/bpf_test_verifier
> * kselftest/bpf_test_xdping.sh
> * kselftest/bpf_test_xdp_meta.sh
> * kselftest/bpf_test_xdp_redirect.sh
> * kselftest/bpf_test_xdp_vlan_mode_generic.sh
> * kselftest/bpf_test_xdp_vlan_mode_native.sh
> * kselftest/bpf_xdping
> * kselftest/clone3_clone3_clear_sighand
> * kselftest/epoll_epoll_wakeup_test
> * kselftest/firmware_fw_run_tests.sh
> * kselftest/kvm_clear_dirty_log_test
> * kselftest/kvm_cr4_cpuid_sync_test
> * kselftest/kvm_dirty_log_test
> * kselftest/kvm_evmcs_test
> * kselftest/kvm_hyperv_cpuid
> * kselftest/kvm_kvm_create_max_vcpus
> * kselftest/kvm_mmio_warning_test
> * kselftest/kvm_platform_info_test
> * kselftest/kvm_set_sregs_test
> * kselftest/kvm_smm_test
> * kselftest/kvm_state_test
> * kselftest/kvm_sync_regs_test
> * kselftest/kvm_vmx_close_while_nested_test
> * kselftest/kvm_vmx_dirty_log_test
> * kselftest/kvm_vmx_set_nested_state_test
> * kselftest/kvm_vmx_tsc_adjust_test
> * kselftest/lib_bitmap.sh
> * kselftest/net_fib-onlink-tests.sh
> * kselftest/net_fib_rule_tests.sh
> * kselftest/net_fib_tests.sh
> * kselftest/netfilter_conntrack_icmp_related.sh
> * kselftest/netfilter_nft_nat.sh
> * kselftest/net_ip_defrag.sh
> * kselftest/net_l2tp.sh
> * kselftest/net_pmtu.sh
> * kselftest/net_psock_snd.sh
> * kselftest/net_reuseport_bpf_numa
> * kselftest/net_run_netsocktests
> * kselftest/net_tcp_fastopen_backup_key.sh
> * kselftest/net_test_vxlan_under_vrf.sh
> * kselftest/net_udpgro_bench.sh
> * kselftest/net_udpgro.sh
> * kselftest/net_udpgso_bench.sh
> * kselftest/pidfd_pidfd_open_test
> * kselftest/pidfd_pidfd_poll_test
> * kselftest/pidfd_pidfd_test
> * kselftest/proc_proc-self-syscall
> * kselftest/pstore_pstore_tests
> * kselftest/rseq_basic_percpu_ops_test
> * kselftest/rtc_rtctest
> * kselftest/seccomp_seccomp_benchmark
> * kselftest/timers_set-timer-lat
> * kselftest/timestamping_txtimestamp.sh
> * kselftest/tpm2_test_smoke.sh
> * kselftest/tpm2_test_space.sh
> 
> dragonboard-410c:
> * kselftest/arm64_fake_sigreturn_bad_magic
> * kselftest/arm64_fake_sigreturn_bad_size
> * kselftest/arm64_fake_sigreturn_bad_size_for_magic0
> * kselftest/arm64_fake_sigreturn_duplicated_fpsimd
> * kselftest/arm64_fake_sigreturn_misaligned_sp
> * kselftest/arm64_fake_sigreturn_missing_fpsimd
> * kselftest/arm64_mangle_pstate_invalid_compat_toggle
> * kselftest/arm64_mangle_pstate_invalid_daif_bits
> * kselftest/arm64_mangle_pstate_invalid_mode_el1h
> * kselftest/arm64_mangle_pstate_invalid_mode_el1t
> * kselftest/arm64_mangle_pstate_invalid_mode_el2h
> * kselftest/arm64_mangle_pstate_invalid_mode_el2t
> * kselftest/arm64_mangle_pstate_invalid_mode_el3h
> * kselftest/arm64_mangle_pstate_invalid_mode_el3t
> * kselftest/bpf_get_cgroup_id_user
> * kselftest/bpf_test_bpftool_build.sh
> * kselftest/bpf_test_dev_cgroup
> * kselftest/bpf_test_flow_dissector.sh
> * kselftest/bpf_test_kmod.sh
> * kselftest/bpf_test_lpm_map
> * kselftest/bpf_test_lwt_ip_encap.sh
> * kselftest/bpf_test_lwt_seg6local.sh
> * kselftest/bpf_test_maps
> * kselftest/bpf_test_netcnt
> * kselftest/bpf_test_progs
> * kselftest/bpf_test_progs-no_alu32
> * kselftest/bpf_test_select_reuseport
> * kselftest/bpf_test_skb_cgroup_id.sh
> * kselftest/bpf_test_sock_addr.sh
> * kselftest/bpf_test_socket_cookie
> * kselftest/bpf_test_sock_fields
> * kselftest/bpf_test_sockmap
> * kselftest/bpf_test_sysctl
> * kselftest/bpf_test_tag
> * kselftest/bpf_test_tc_edt.sh
> * kselftest/bpf_test_tcpbpf_user
> * kselftest/bpf_test_tcp_check_syncookie.sh
> * kselftest/bpf_test_tcpnotify_user
> * kselftest/bpf_test_tc_tunnel.sh
> * kselftest/bpf_test_tunnel.sh
> * kselftest/bpf_test_verifier
> * kselftest/bpf_test_xdping.sh
> * kselftest/bpf_test_xdp_meta.sh
> * kselftest/bpf_test_xdp_redirect.sh
> * kselftest/bpf_test_xdp_vlan_mode_generic.sh
> * kselftest/bpf_test_xdp_vlan_mode_native.sh
> * kselftest/bpf_xdping
> * kselftest/clone3_clone3_clear_sighand
> * kselftest/firmware_fw_run_tests.sh
> * kselftest/kvm_clear_dirty_log_test
> * kselftest/kvm_cr4_cpuid_sync_test
> * kselftest/kvm_dirty_log_test
> * kselftest/kvm_evmcs_test
> * kselftest/kvm_hyperv_cpuid
> * kselftest/kvm_kvm_create_max_vcpus
> * kselftest/kvm_mmio_warning_test
> * kselftest/kvm_platform_info_test
> * kselftest/kvm_set_sregs_test
> * kselftest/kvm_smm_test
> * kselftest/kvm_state_test
> * kselftest/kvm_sync_regs_test
> * kselftest/kvm_vmx_close_while_nested_test
> * kselftest/kvm_vmx_dirty_log_test
> * kselftest/kvm_vmx_set_nested_state_test
> * kselftest/kvm_vmx_tsc_adjust_test
> * kselftest/net_fib-onlink-tests.sh
> * kselftest/net_fib_rule_tests.sh
> * kselftest/net_fib_tests.sh
> * kselftest/netfilter_conntrack_icmp_related.sh
> * kselftest/netfilter_nft_nat.sh
> * kselftest/net_ip_defrag.sh
> * kselftest/net_l2tp.sh
> * kselftest/net_pmtu.sh
> * kselftest/net_psock_snd.sh
> * kselftest/net_run_netsocktests
> * kselftest/net_tcp_fastopen_backup_key.sh
> * kselftest/net_test_vxlan_under_vrf.sh
> * kselftest/net_udpgro_bench.sh
> * kselftest/net_udpgro.sh
> * kselftest/net_udpgso_bench.sh
> * kselftest/pidfd_pidfd_fdinfo_test
> * kselftest/pidfd_pidfd_open_test
> * kselftest/pidfd_pidfd_poll_test
> * kselftest/pidfd_pidfd_test
> * kselftest/pidfd_pidfd_wait
> * kselftest/pstore_pstore_tests
> * kselftest/rseq_basic_percpu_ops_test
> * kselftest/rtc_rtctest
> * kselftest/timers_rtcpie
> * kselftest/timers_set-timer-lat
> * kselftest/timestamping_txtimestamp.sh
> * kselftest/tpm2_test_smoke.sh
> * kselftest/tpm2_test_space.sh
> 
> hi6220-hikey:
> 
> i386:
> 
> x86:
> * kselftest/bpf_get_cgroup_id_user
> * kselftest/bpf_test_bpftool_build.sh
> * kselftest/bpf_test_dev_cgroup
> * kselftest/bpf_test_flow_dissector.sh
> * kselftest/bpf_test_lwt_ip_encap.sh
> * kselftest/bpf_test_lwt_seg6local.sh
> * kselftest/bpf_test_maps
> * kselftest/bpf_test_netcnt
> * kselftest/bpf_test_progs
> * kselftest/bpf_test_progs-no_alu32
> * kselftest/bpf_test_select_reuseport
> * kselftest/bpf_test_skb_cgroup_id.sh
> * kselftest/bpf_test_sock_addr.sh
> * kselftest/bpf_test_socket_cookie
> * kselftest/bpf_test_sock_fields
> * kselftest/bpf_test_sockmap
> * kselftest/bpf_test_sysctl
> * kselftest/bpf_test_tc_edt.sh
> * kselftest/bpf_test_tcpbpf_user
> * kselftest/bpf_test_tcp_check_syncookie.sh
> * kselftest/bpf_test_tcpnotify_user
> * kselftest/bpf_test_tc_tunnel.sh
> * kselftest/bpf_test_tunnel.sh
> * kselftest/bpf_test_xdping.sh
> * kselftest/bpf_test_xdp_meta.sh
> * kselftest/bpf_test_xdp_redirect.sh
> * kselftest/bpf_test_xdp_vlan_mode_generic.sh
> * kselftest/bpf_test_xdp_vlan_mode_native.sh
> * kselftest/bpf_xdping
> * kselftest/firmware_fw_run_tests.sh
> * kselftest/intel_pstate_run.sh
> * kselftest/kvm_clear_dirty_log_test
> * kselftest/kvm_cr4_cpuid_sync_test
> * kselftest/kvm_dirty_log_test
> * kselftest/kvm_evmcs_test
> * kselftest/kvm_hyperv_cpuid
> * kselftest/kvm_kvm_create_max_vcpus
> * kselftest/kvm_platform_info_test
> * kselftest/kvm_set_sregs_test
> * kselftest/kvm_smm_test
> * kselftest/kvm_state_test
> * kselftest/kvm_sync_regs_test
> * kselftest/kvm_vmx_close_while_nested_test
> * kselftest/kvm_vmx_dirty_log_test
> * kselftest/kvm_vmx_set_nested_state_test
> * kselftest/kvm_vmx_tsc_adjust_test
> * kselftest/mqueue_mq_perf_tests
> * kselftest/net_fib-onlink-tests.sh
> * kselftest/net_fib_tests.sh
> * kselftest/net_ip_defrag.sh
> * kselftest/net_l2tp.sh
> * kselftest/net_pmtu.sh
> * kselftest/net_psock_snd.sh
> * kselftest/net_run_netsocktests
> * kselftest/net_test_vxlan_under_vrf.sh
> * kselftest/net_traceroute.sh
> * kselftest/net_udpgro_bench.sh
> * kselftest/net_udpgro.sh
> * kselftest/net_udpgso_bench.sh
> * kselftest/net_xfrm_policy.sh
> * kselftest/pidfd_pidfd_open_test
> * kselftest/pidfd_pidfd_poll_test
> * kselftest/pstore_pstore_tests
> * kselftest/rseq_run_param_test.sh
> * kselftest/rtc_rtctest
> * kselftest/seccomp_seccomp_benchmark
> * kselftest/timers_set-timer-lat
> * kselftest/timestamping_txtimestamp.sh
> * kselftest/tpm2_test_smoke.sh
> * kselftest/tpm2_test_space.sh
> * kselftest/vm_run_vmtests
> * kselftest-vsyscall-mode-none/bpf_get_cgroup_id_user
> * kselftest-vsyscall-mode-none/bpf_test_bpftool_build.sh
> * kselftest-vsyscall-mode-none/bpf_test_dev_cgroup
> * kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
> * kselftest-vsyscall-mode-none/bpf_test_lwt_ip_encap.sh
> * kselftest-vsyscall-mode-none/bpf_test_lwt_seg6local.sh
> * kselftest-vsyscall-mode-none/bpf_test_maps
> * kselftest-vsyscall-mode-none/bpf_test_netcnt
> * kselftest-vsyscall-mode-none/bpf_test_progs
> * kselftest-vsyscall-mode-none/bpf_test_progs-no_alu32
> * kselftest-vsyscall-mode-none/bpf_test_select_reuseport
> * kselftest-vsyscall-mode-none/bpf_test_skb_cgroup_id.sh
> * kselftest-vsyscall-mode-none/bpf_test_sock_addr.sh
> * kselftest-vsyscall-mode-none/bpf_test_socket_cookie
> * kselftest-vsyscall-mode-none/bpf_test_sock_fields
> * kselftest-vsyscall-mode-none/bpf_test_sockmap
> * kselftest-vsyscall-mode-none/bpf_test_sysctl
> * kselftest-vsyscall-mode-none/bpf_test_tc_edt.sh
> * kselftest-vsyscall-mode-none/bpf_test_tcpbpf_user
> * kselftest-vsyscall-mode-none/bpf_test_tcp_check_syncookie.sh
> * kselftest-vsyscall-mode-none/bpf_test_tcpnotify_user
> * kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
> * kselftest-vsyscall-mode-none/bpf_test_tunnel.sh
> * kselftest-vsyscall-mode-none/bpf_test_xdping.sh
> * kselftest-vsyscall-mode-none/bpf_test_xdp_meta.sh
> * kselftest-vsyscall-mode-none/bpf_test_xdp_redirect.sh
> * kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_generic.sh
> * kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_native.sh
> * kselftest-vsyscall-mode-none/bpf_xdping
> * kselftest-vsyscall-mode-none/firmware_fw_run_tests.sh
> * kselftest-vsyscall-mode-none/intel_pstate_run.sh
> * kselftest-vsyscall-mode-none/kvm_clear_dirty_log_test
> * kselftest-vsyscall-mode-none/kvm_cr4_cpuid_sync_test
> * kselftest-vsyscall-mode-none/kvm_dirty_log_test
> * kselftest-vsyscall-mode-none/kvm_hyperv_cpuid
> * kselftest-vsyscall-mode-none/kvm_kvm_create_max_vcpus
> * kselftest-vsyscall-mode-none/kvm_platform_info_test
> * kselftest-vsyscall-mode-none/kvm_smm_test
> * kselftest-vsyscall-mode-none/kvm_state_test
> * kselftest-vsyscall-mode-none/kvm_sync_regs_test
> * kselftest-vsyscall-mode-none/kvm_vmx_close_while_nested_test
> * kselftest-vsyscall-mode-none/kvm_vmx_dirty_log_test
> * kselftest-vsyscall-mode-none/kvm_vmx_set_nested_state_test
> * kselftest-vsyscall-mode-none/kvm_vmx_tsc_adjust_test
> * kselftest-vsyscall-mode-none/mqueue_mq_perf_tests
> * kselftest-vsyscall-mode-none/net_fib-onlink-tests.sh
> * kselftest-vsyscall-mode-none/net_fib_tests.sh
> * kselftest-vsyscall-mode-none/net_ip_defrag.sh
> * kselftest-vsyscall-mode-none/net_l2tp.sh
> * kselftest-vsyscall-mode-none/net_pmtu.sh
> * kselftest-vsyscall-mode-none/net_psock_snd.sh
> * kselftest-vsyscall-mode-none/net_run_netsocktests
> * kselftest-vsyscall-mode-none/net_test_vxlan_under_vrf.sh
> * kselftest-vsyscall-mode-none/net_traceroute.sh
> * kselftest-vsyscall-mode-none/net_udpgro_bench.sh
> * kselftest-vsyscall-mode-none/net_udpgro.sh
> * kselftest-vsyscall-mode-none/net_udpgso_bench.sh
> * kselftest-vsyscall-mode-none/net_xfrm_policy.sh
> * kselftest-vsyscall-mode-none/pidfd_pidfd_open_test
> * kselftest-vsyscall-mode-none/pidfd_pidfd_poll_test
> * kselftest-vsyscall-mode-none/pstore_pstore_tests
> * kselftest-vsyscall-mode-none/rseq_run_param_test.sh
> * kselftest-vsyscall-mode-none/rtc_rtctest
> * kselftest-vsyscall-mode-none/seccomp_seccomp_benchmark
> * kselftest-vsyscall-mode-none/timers_set-timer-lat
> * kselftest-vsyscall-mode-none/timestamping_txtimestamp.sh
> * kselftest-vsyscall-mode-none/tpm2_test_smoke.sh
> * kselftest-vsyscall-mode-none/tpm2_test_space.sh
> * kselftest-vsyscall-mode-none/vm_run_vmtests
> * kselftest-vsyscall-mode-native/bpf_get_cgroup_id_user
> * kselftest-vsyscall-mode-native/bpf_test_bpftool_build.sh
> * kselftest-vsyscall-mode-native/bpf_test_dev_cgroup
> * kselftest-vsyscall-mode-native/bpf_test_flow_dissector.sh
> * kselftest-vsyscall-mode-native/bpf_test_lwt_ip_encap.sh
> * kselftest-vsyscall-mode-native/bpf_test_lwt_seg6local.sh
> * kselftest-vsyscall-mode-native/bpf_test_maps
> * kselftest-vsyscall-mode-native/bpf_test_netcnt
> * kselftest-vsyscall-mode-native/bpf_test_progs
> * kselftest-vsyscall-mode-native/bpf_test_progs-no_alu32
> * kselftest-vsyscall-mode-native/bpf_test_select_reuseport
> * kselftest-vsyscall-mode-native/bpf_test_skb_cgroup_id.sh
> * kselftest-vsyscall-mode-native/bpf_test_sock_addr.sh
> * kselftest-vsyscall-mode-native/bpf_test_socket_cookie
> * kselftest-vsyscall-mode-native/bpf_test_sock_fields
> * kselftest-vsyscall-mode-native/bpf_test_sockmap
> * kselftest-vsyscall-mode-native/bpf_test_sysctl
> * kselftest-vsyscall-mode-native/bpf_test_tc_edt.sh
> * kselftest-vsyscall-mode-native/bpf_test_tcpbpf_user
> * kselftest-vsyscall-mode-native/bpf_test_tcp_check_syncookie.sh
> * kselftest-vsyscall-mode-native/bpf_test_tcpnotify_user
> * kselftest-vsyscall-mode-native/bpf_test_tc_tunnel.sh
> * kselftest-vsyscall-mode-native/bpf_test_tunnel.sh
> * kselftest-vsyscall-mode-native/bpf_test_xdping.sh
> * kselftest-vsyscall-mode-native/bpf_test_xdp_meta.sh
> * kselftest-vsyscall-mode-native/bpf_test_xdp_redirect.sh
> * kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_generic.sh
> * kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_native.sh
> * kselftest-vsyscall-mode-native/bpf_xdping
> * kselftest-vsyscall-mode-native/firmware_fw_run_tests.sh
> * kselftest-vsyscall-mode-native/intel_pstate_run.sh
> * kselftest-vsyscall-mode-native/kvm_clear_dirty_log_test
> * kselftest-vsyscall-mode-native/kvm_cr4_cpuid_sync_test
> * kselftest-vsyscall-mode-native/kvm_dirty_log_test
> * kselftest-vsyscall-mode-native/kvm_evmcs_test
> * kselftest-vsyscall-mode-native/kvm_hyperv_cpuid
> * kselftest-vsyscall-mode-native/kvm_kvm_create_max_vcpus
> * kselftest-vsyscall-mode-native/kvm_platform_info_test
> * kselftest-vsyscall-mode-native/kvm_set_sregs_test
> * kselftest-vsyscall-mode-native/kvm_smm_test
> * kselftest-vsyscall-mode-native/kvm_state_test
> * kselftest-vsyscall-mode-native/kvm_sync_regs_test
> * kselftest-vsyscall-mode-native/kvm_vmx_close_while_nested_test
> * kselftest-vsyscall-mode-native/kvm_vmx_dirty_log_test
> * kselftest-vsyscall-mode-native/kvm_vmx_set_nested_state_test
> * kselftest-vsyscall-mode-native/kvm_vmx_tsc_adjust_test
> * kselftest-vsyscall-mode-native/mqueue_mq_perf_tests
> * kselftest-vsyscall-mode-native/net_fib_tests.sh
> * kselftest-vsyscall-mode-native/net_ip_defrag.sh
> * kselftest-vsyscall-mode-native/net_l2tp.sh
> * kselftest-vsyscall-mode-native/net_pmtu.sh
> * kselftest-vsyscall-mode-native/net_psock_snd.sh
> * kselftest-vsyscall-mode-native/net_run_netsocktests
> * kselftest-vsyscall-mode-native/net_test_vxlan_under_vrf.sh
> * kselftest-vsyscall-mode-native/net_traceroute.sh
> * kselftest-vsyscall-mode-native/net_udpgro_bench.sh
> * kselftest-vsyscall-mode-native/net_udpgro.sh
> * kselftest-vsyscall-mode-native/net_udpgso_bench.sh
> * kselftest-vsyscall-mode-native/net_xfrm_policy.sh
> * kselftest-vsyscall-mode-native/pidfd_pidfd_open_test
> * kselftest-vsyscall-mode-native/pidfd_pidfd_poll_test
> * kselftest-vsyscall-mode-native/pstore_pstore_tests
> * kselftest-vsyscall-mode-native/rseq_run_param_test.sh
> * kselftest-vsyscall-mode-native/rtc_rtctest
> * kselftest-vsyscall-mode-native/seccomp_seccomp_benchmark
> * kselftest-vsyscall-mode-native/timers_set-timer-lat
> * kselftest-vsyscall-mode-native/timestamping_txtimestamp.sh
> * kselftest-vsyscall-mode-native/tpm2_test_smoke.sh
> * kselftest-vsyscall-mode-native/tpm2_test_space.sh
> * kselftest-vsyscall-mode-native/vm_run_vmtests
> 
> 
> Skips
> ------------------------------------------------------------------------
> No skips
> 
> 

