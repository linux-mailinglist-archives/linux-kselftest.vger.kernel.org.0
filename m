Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92416116152
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Dec 2019 11:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfLHKAc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Dec 2019 05:00:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43841 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfLHKAc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Dec 2019 05:00:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so12605377wre.10
        for <linux-kselftest@vger.kernel.org>; Sun, 08 Dec 2019 02:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=Nugbxl+9aqt+DNfKVFE2QTQqApnistvla54Q4QlK5Vg=;
        b=EJVdJlmEjMbMdxNIw0Br5njFy/dVkNGSXQalNZEWKa325cYmvBMDVv3TVzgGkVGuvO
         Dp7dgvWxC98uGG06j2NtPSkpEgj1PIJtYyKD/+TK+PB2V6AZST/vK+QRnJ+/eDy8O0ah
         LpiXlm4wjlI3ac/gW2+QiKWM2OMJp85ecjerXC8y6nDsEuQ0O+y1UJv0D4CvJY2awrlc
         QSeUX3X/H/nFkgpkWSuFH4a23MQo4hMLbkN96A19u2JA+IGMTCGXeEsUDjLxbu0gUU0a
         L8JP5pPMqBcXQ3ErI3TkFI8dqc3bWI3f/FL08yXWdtTRNkvegvTTuqoP5s2nWggy3LTy
         Clew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=Nugbxl+9aqt+DNfKVFE2QTQqApnistvla54Q4QlK5Vg=;
        b=ZPyuSVsW51ef6/qjc1Jw6fWGs9Xhdjw/a/4yFxlkH3qtgEYL5zd3e0OEByDtTibQZQ
         qBnIOJdZuetNhPugcxCNIu7D2WrD9hzOnM2v4vhLMohXckgEesU6GdeWPI+MGpbgsJ7R
         9mz3Ya4wNd0XRWKeviXiYeO/M0N+89sIQ7lUaGpOWj6sTniVU7+nRB2yVRKAHuMU/Zv5
         YvXbZCfg8HTaTiOHFHeu8GOPEaFjlhdkmmRWzAkToF9BN35jkBYI6KhYGwhn/cFcY40S
         hJR2x/U83lxrQZ/wz7ESpvckr82y3FvX/uFLUsdcI5C10QLCd0H3tjT0v22ULfDc/3ID
         U8PA==
X-Gm-Message-State: APjAAAW2Db+HTbif/43XvtYW9Ij4cCxu4mYMmU5utZDIkAlJeHQktiM9
        bunQ7xDV6SuFPWeU8f/BCZ+zkA==
X-Google-Smtp-Source: APXvYqxqKk7Pr3zdQOhL+yUW30+FIqU2lQYTVwsBV6B0hmGLfq/5G6mMPCMj9uvdqgUWzY0H58ySaA==
X-Received: by 2002:a5d:4752:: with SMTP id o18mr24360073wrs.330.1575799227100;
        Sun, 08 Dec 2019 02:00:27 -0800 (PST)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id f11sm9476725wmc.25.2019.12.08.02.00.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Dec 2019 02:00:26 -0800 (PST)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Sun, 8 Dec 2019 10:00:25 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <65682491.3877.1575799226394.JavaMail.javamailuser@localhost>
Subject: next-20191208 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_3876_1036140376.1575799225326"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_3876_1036140376.1575799225326
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.4.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: c34be716fb373fad4ce1d2c4462b6267158070b1
git describe: next-20191208
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191208

Regressions (compared to build next-20191207)
------------------------------------------------------------------------
i386:                                                                                                      
 kselftest:                                                                                         
    * net_tcp_fastopen_backup_key.sh                                                                                                         
                                                                                         
    * seccomp_seccomp_benchmark                                                                                                         
                                                                                         
    * x86_ldt_gdt_32                                                                                                         
qemu_x86_64:                                                                                                      
 kselftest:                                                                                         
    * futex_run.sh                                                                                                         
qemu_i386:                                                                                                      
 kselftest:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * net_so_txtime.sh                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * net_so_txtime.sh                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * net_so_txtime.sh                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * net_so_txtime.sh                                                                                                         
                                                                                                          
                                                                                                                       
Fixes (compared to build next-20191207)                                                                   
------------------------------------------------------------------------                                               
x86:                                                                                                      
 kselftest:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         
qemu_arm:                                                                                                      
 kselftest:                                                                                         
    * cgroup_test_freezer                                                                                                         


In total:
------------------------------------------------------------------------
Ran 1490 total tests in the following environments and test suites.
pass 836
fail 538
xfail 0
skip 116

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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none


Failures
------------------------------------------------------------------------

i386:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_hashmap
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs-no_alu32
* kselftest/bpf_test_select_reuseport
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
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/kvm_xss_msr_test
* kselftest/lib_bitmap.sh
* kselftest/mqueue_mq_perf_tests
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_tests.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_traceroute.sh
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgso_bench.sh
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/proc_proc-self-syscall
* kselftest/pstore_pstore_tests
* kselftest/rseq_run_param_test.sh
* kselftest/rtc_rtctest
* kselftest/seccomp_seccomp_benchmark
* kselftest/size_get_size
* kselftest/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh
* kselftest/vm_run_vmtests
* kselftest/x86_ldt_gdt_32

qemu_i386:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_hashmap
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_progs-no_alu32
* kselftest/bpf_test_select_reuseport
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
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/kvm_xss_msr_test
* kselftest/lib_bitmap.sh
* kselftest/mqueue_mq_perf_tests
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_tests.sh
* kselftest/netfilter_conntrack_icmp_related.sh
* kselftest/netfilter_nft_nat.sh
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
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/proc_proc-self-syscall
* kselftest/pstore_pstore_tests
* kselftest/rseq_run_param_test.sh
* kselftest/rtc_rtctest
* kselftest/size_get_size
* kselftest/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh
* kselftest/vm_run_vmtests

qemu_x86_64:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_progs-no_alu32
* kselftest/bpf_test_select_reuseport
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
* kselftest/futex_run.sh
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
* kselftest/kvm_sync_regs_test
* kselftest/kvm_xss_msr_test
* kselftest/mqueue_mq_perf_tests
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_tests.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_so_txtime.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/net_xfrm_policy.sh
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/pstore_pstore_tests
* kselftest/rseq_run_param_test.sh
* kselftest/rtc_rtctest
* kselftest/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh
* kselftest/vm_run_vmtests
* kselftest/x86_fsgsbase_64

qemu_arm:
* kselftest/bpf_get_cgroup_id_user
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
* kselftest/bpf_test_select_reuseport
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
* kselftest/clone3_clone3_clear_sighand
* kselftest/cpufreq_main.sh
* kselftest/firmware_fw_run_tests.sh
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
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/kvm_xss_msr_test
* kselftest/lib_bitmap.sh
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_rule_tests.sh
* kselftest/net_fib_tests.sh
* kselftest/netfilter_conntrack_icmp_related.sh
* kselftest/netfilter_nft_nat.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_reuseport_bpf_numa
* kselftest/net_run_netsocktests
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/pidfd_pidfd_test
* kselftest/proc_proc-self-syscall
* kselftest/pstore_pstore_tests
* kselftest/rseq_basic_percpu_ops_test
* kselftest/rtc_rtctest
* kselftest/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh

qemu_arm64:
* kselftest/bpf_get_cgroup_id_user
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
* kselftest/bpf_test_select_reuseport
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
* kselftest/clone3_clone3
* kselftest/clone3_clone3_clear_sighand
* kselftest/clone3_clone3_set_tid
* kselftest/cpufreq_main.sh

x86:
* kselftest/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-native/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-none/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-native/bpf_test_dev_cgroup
* kselftest/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-none/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-native/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest-vsyscall-mode-native/bpf_test_maps
* kselftest-vsyscall-mode-none/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest-vsyscall-mode-native/bpf_test_netcnt
* kselftest-vsyscall-mode-none/bpf_test_netcnt
* kselftest-vsyscall-mode-none/bpf_test_progs
* kselftest/bpf_test_progs
* kselftest-vsyscall-mode-native/bpf_test_progs
* kselftest-vsyscall-mode-native/bpf_test_progs-no_alu32
* kselftest/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-none/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-native/bpf_test_select_reuseport
* kselftest-vsyscall-mode-none/bpf_test_select_reuseport
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-none/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-native/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-none/bpf_test_sock_addr.sh
* kselftest/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_socket_cookie
* kselftest-vsyscall-mode-none/bpf_test_socket_cookie
* kselftest/bpf_test_socket_cookie
* kselftest-vsyscall-mode-none/bpf_test_sock_fields
* kselftest/bpf_test_sock_fields
* kselftest-vsyscall-mode-native/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest-vsyscall-mode-none/bpf_test_sockmap
* kselftest-vsyscall-mode-native/bpf_test_sockmap
* kselftest-vsyscall-mode-native/bpf_test_sysctl
* kselftest/bpf_test_sysctl
* kselftest-vsyscall-mode-none/bpf_test_sysctl
* kselftest/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-none/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-native/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-native/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-none/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-native/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-none/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-none/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-native/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_xdping.sh
* kselftest/bpf_test_xdping.sh
* kselftest-vsyscall-mode-none/bpf_test_xdping.sh
* kselftest/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_generic.sh
* kselftest/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_native.sh
* kselftest/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_native.sh
* kselftest/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-native/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-none/firmware_fw_run_tests.sh
* kselftest/intel_pstate_run.sh
* kselftest-vsyscall-mode-none/intel_pstate_run.sh
* kselftest-vsyscall-mode-native/intel_pstate_run.sh
* kselftest/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-none/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-native/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-native/kvm_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_dirty_log_test
* kselftest/kvm_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_evmcs_test
* kselftest/kvm_evmcs_test
* kselftest-vsyscall-mode-none/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-none/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-native/kvm_kvm_create_max_vcpus
* kselftest/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-none/kvm_platform_info_test
* kselftest-vsyscall-mode-native/kvm_platform_info_test
* kselftest/kvm_platform_info_test
* kselftest-vsyscall-mode-none/kvm_set_sregs_test
* kselftest/kvm_set_sregs_test
* kselftest-vsyscall-mode-native/kvm_set_sregs_test
* kselftest-vsyscall-mode-none/kvm_smm_test
* kselftest-vsyscall-mode-native/kvm_smm_test
* kselftest/kvm_smm_test
* kselftest-vsyscall-mode-none/kvm_state_test
* kselftest-vsyscall-mode-native/kvm_state_test
* kselftest/kvm_state_test
* kselftest-vsyscall-mode-none/kvm_sync_regs_test
* kselftest-vsyscall-mode-native/kvm_sync_regs_test
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-none/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-native/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-native/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-native/kvm_vmx_tsc_adjust_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-none/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-none/kvm_xss_msr_test
* kselftest-vsyscall-mode-native/kvm_xss_msr_test
* kselftest/kvm_xss_msr_test
* kselftest-vsyscall-mode-native/mqueue_mq_perf_tests
* kselftest/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-none/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-native/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-none/net_fib-onlink-tests.sh
* kselftest/net_fib_tests.sh
* kselftest-vsyscall-mode-native/net_fib_tests.sh
* kselftest-vsyscall-mode-none/net_fib_tests.sh
* kselftest/net_ip_defrag.sh
* kselftest-vsyscall-mode-native/net_ip_defrag.sh
* kselftest-vsyscall-mode-none/net_ip_defrag.sh
* kselftest-vsyscall-mode-native/net_l2tp.sh
* kselftest-vsyscall-mode-none/net_l2tp.sh
* kselftest/net_l2tp.sh
* kselftest-vsyscall-mode-none/net_pmtu.sh
* kselftest-vsyscall-mode-native/net_pmtu.sh
* kselftest/net_pmtu.sh
* kselftest-vsyscall-mode-native/net_psock_snd.sh
* kselftest/net_psock_snd.sh
* kselftest-vsyscall-mode-none/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest-vsyscall-mode-native/net_run_netsocktests
* kselftest-vsyscall-mode-none/net_run_netsocktests
* kselftest-vsyscall-mode-native/net_so_txtime.sh
* kselftest/net_so_txtime.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-none/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-native/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-native/net_traceroute.sh
* kselftest-vsyscall-mode-none/net_traceroute.sh
* kselftest/net_traceroute.sh
* kselftest/net_udpgro_bench.sh
* kselftest-vsyscall-mode-none/net_udpgro_bench.sh
* kselftest-vsyscall-mode-native/net_udpgro_bench.sh
* kselftest-vsyscall-mode-native/net_udpgro.sh
* kselftest/net_udpgro.sh
* kselftest-vsyscall-mode-none/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest-vsyscall-mode-native/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_xfrm_policy.sh
* kselftest/net_xfrm_policy.sh
* kselftest-vsyscall-mode-native/net_xfrm_policy.sh
* kselftest/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-native/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-none/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-native/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-none/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-native/pstore_pstore_tests
* kselftest/pstore_pstore_tests
* kselftest-vsyscall-mode-none/pstore_pstore_tests
* kselftest-vsyscall-mode-none/rseq_run_param_test.sh
* kselftest/rseq_run_param_test.sh
* kselftest-vsyscall-mode-native/rseq_run_param_test.sh
* kselftest-vsyscall-mode-none/rtc_rtctest
* kselftest/rtc_rtctest
* kselftest-vsyscall-mode-native/rtc_rtctest
* kselftest/seccomp_seccomp_benchmark
* kselftest-vsyscall-mode-none/seccomp_seccomp_benchmark
* kselftest-vsyscall-mode-native/seccomp_seccomp_benchmark
* kselftest/timers_set-timer-lat
* kselftest-vsyscall-mode-native/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-native/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-none/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest-vsyscall-mode-none/tpm2_test_smoke.sh
* kselftest-vsyscall-mode-native/tpm2_test_smoke.sh
* kselftest-vsyscall-mode-none/tpm2_test_space.sh
* kselftest-vsyscall-mode-native/tpm2_test_space.sh
* kselftest/tpm2_test_space.sh
* kselftest/vm_run_vmtests
* kselftest-vsyscall-mode-native/vm_run_vmtests
* kselftest-vsyscall-mode-none/vm_run_vmtests


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_3876_1036140376.1575799225326--
