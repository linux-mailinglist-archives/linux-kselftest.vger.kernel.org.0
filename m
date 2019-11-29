Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 444DD10D0B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2019 05:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfK2EAb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Nov 2019 23:00:31 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:33923 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfK2EAb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Nov 2019 23:00:31 -0500
Received: by mail-wm1-f41.google.com with SMTP id j18so8752373wmk.1
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Nov 2019 20:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=XzCe4GAsqKySx6jvpfW1UqUzZypi0FxuAUgMNpcD/Dw=;
        b=JVc3LqcSJfxZ7syS+cLSlH+VscI8AG0BIxoi0dlAcSVz4il9a8MwsR8tCVQkc6OXsB
         4UvPf+M2B0q0Ts4l1XhESIAL5JEWRaC9ZmiTbeudYq2ALAAip4k/jTWHMDuGfANWdyVh
         derJqBZK1zXYa0OdmMI1z6MRtBI9dnMTHHP3HEklWXBfw193I9XUhHr/X/mmvQqnEmQd
         zqamh+o1ct2YKehwY2toOdU/JJ5kkPnYV4uN6n1DqscBEBrYwnyub2VIVADBErTlV5yF
         7lqCl91fsGf6NZI2TfEf5Q62OAGO1jdfrOGjEhdX4uE78Pgqm55W1JCXXkGs39y0kfx/
         oYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=XzCe4GAsqKySx6jvpfW1UqUzZypi0FxuAUgMNpcD/Dw=;
        b=RkHfUCEczJf9o3rFHMUwp6F+2vVV5MqrvRsp0Vy+ndLPDhWGU0U0HcEYj5PKL60W4Z
         fuN4Aol1cVCZwePT5Xr/1mKWoPURCxGgE+T0iIOB4E+ZBSpVg94ck7GoWw3t+SEu5QsE
         S+Vya6zAZzvi3lqej0blvNR+mKsvAjRFRrs2QKVQdgfncNMiqSuYIQjWpfw1kbDdwEKl
         iDBosLAjdy9v4ubIuD4nb9IhWoH0koqP2WTmtsS+YzOUNxmhV1OhcylPKCSSYX2iH5N2
         7v2Mt8mzh74HJ/EHEmQxXFQGDhjqziX5gQN2yjNApH6uKtRN9RwFc9eaq3S/G+8Ccg4z
         eUrA==
X-Gm-Message-State: APjAAAWbM4XYMuvlpMuPs9cfgOo16Pmf3w4zbYItkX0DUpwwzAX9kY7D
        q3F/rxdJ9gM/7kCwBH58cV1hgw==
X-Google-Smtp-Source: APXvYqyVmZ2pb//ddadF5Fei9j7+TGZ0jhMgD5FipR+v6c5wZHV9iGMRO0Lek5JIryJ9kewv84mFGA==
X-Received: by 2002:a1c:7c0e:: with SMTP id x14mr12013090wmc.62.1575000026726;
        Thu, 28 Nov 2019 20:00:26 -0800 (PST)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id i127sm12958612wma.35.2019.11.28.20.00.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Nov 2019 20:00:26 -0800 (PST)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Fri, 29 Nov 2019 04:00:24 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <1103901391.2917.1575000025980.JavaMail.javamailuser@localhost>
Subject: next-20191128 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_2916_1840019146.1575000024997"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_2916_1840019146.1575000024997
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.4.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: d26b0e226f222c22c3b7e9d16e5b886e7c51057a
git describe: next-20191128
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191128

Regressions (compared to build next-20191127)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20191127)                                                                   
------------------------------------------------------------------------                                               
qemu_x86_64:                                                                                                      
 kselftest:                                                                                         
    * livepatch_test-callbacks.sh                                                                                                         
                                                                                         
    * net_so_txtime.sh                                                                                                         


In total:
------------------------------------------------------------------------
Ran 1085 total tests in the following environments and test suites.
pass 592
fail 415
xfail 0
skip 78

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm64
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

dragonboard-410c:
* kselftest/arm64_fake_sigreturn_bad_magic
* kselftest/arm64_fake_sigreturn_bad_size
* kselftest/arm64_fake_sigreturn_bad_size_for_magic0
* kselftest/arm64_fake_sigreturn_duplicated_fpsimd
* kselftest/arm64_fake_sigreturn_misaligned_sp
* kselftest/arm64_fake_sigreturn_missing_fpsimd
* kselftest/arm64_mangle_pstate_invalid_compat_toggle
* kselftest/arm64_mangle_pstate_invalid_daif_bits
* kselftest/arm64_mangle_pstate_invalid_mode_el1h
* kselftest/arm64_mangle_pstate_invalid_mode_el1t
* kselftest/arm64_mangle_pstate_invalid_mode_el2h
* kselftest/arm64_mangle_pstate_invalid_mode_el2t
* kselftest/arm64_mangle_pstate_invalid_mode_el3h
* kselftest/arm64_mangle_pstate_invalid_mode_el3t
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

hi6220-hikey:

x86:
* kselftest-vsyscall-mode-none/bpf_get_cgroup_id_user
* kselftest/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-native/bpf_get_cgroup_id_user
* kselftest/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-none/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-native/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-native/bpf_test_flow_dissector.sh
* kselftest/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-none/bpf_test_maps
* kselftest/bpf_test_maps
* kselftest-vsyscall-mode-native/bpf_test_maps
* kselftest-vsyscall-mode-native/bpf_test_netcnt
* kselftest/bpf_test_netcnt
* kselftest-vsyscall-mode-none/bpf_test_netcnt
* kselftest/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-none/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-native/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-none/bpf_test_select_reuseport
* kselftest-vsyscall-mode-native/bpf_test_select_reuseport
* kselftest/bpf_test_select_reuseport
* kselftest-vsyscall-mode-none/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-native/bpf_test_skb_cgroup_id.sh
* kselftest/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-none/bpf_test_sock_addr.sh
* kselftest/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_sock_addr.sh
* kselftest/bpf_test_socket_cookie
* kselftest-vsyscall-mode-none/bpf_test_socket_cookie
* kselftest-vsyscall-mode-native/bpf_test_socket_cookie
* kselftest-vsyscall-mode-none/bpf_test_sock_fields
* kselftest-vsyscall-mode-native/bpf_test_sock_fields
* kselftest/bpf_test_sock_fields
* kselftest-vsyscall-mode-native/bpf_test_sockmap
* kselftest/bpf_test_sockmap
* kselftest-vsyscall-mode-none/bpf_test_sockmap
* kselftest/bpf_test_sysctl
* kselftest-vsyscall-mode-native/bpf_test_sysctl
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
* kselftest-vsyscall-mode-native/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-none/bpf_test_tcpnotify_user
* kselftest/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-native/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_xdping.sh
* kselftest-vsyscall-mode-native/bpf_test_xdping.sh
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_generic.sh
* kselftest/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_native.sh
* kselftest/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-none/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-native/firmware_fw_run_tests.sh
* kselftest/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-native/intel_pstate_run.sh
* kselftest/intel_pstate_run.sh
* kselftest-vsyscall-mode-none/intel_pstate_run.sh
* kselftest-vsyscall-mode-native/kvm_clear_dirty_log_test
* kselftest/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-native/kvm_cr4_cpuid_sync_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-native/kvm_dirty_log_test
* kselftest/kvm_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_dirty_log_test
* kselftest/kvm_evmcs_test
* kselftest-vsyscall-mode-none/kvm_evmcs_test
* kselftest-vsyscall-mode-native/kvm_evmcs_test
* kselftest-vsyscall-mode-none/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-native/kvm_hyperv_cpuid
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-none/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-native/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-none/kvm_platform_info_test
* kselftest-vsyscall-mode-native/kvm_platform_info_test
* kselftest/kvm_set_sregs_test
* kselftest-vsyscall-mode-native/kvm_set_sregs_test
* kselftest-vsyscall-mode-none/kvm_set_sregs_test
* kselftest-vsyscall-mode-none/kvm_smm_test
* kselftest/kvm_smm_test
* kselftest-vsyscall-mode-native/kvm_smm_test
* kselftest/kvm_state_test
* kselftest-vsyscall-mode-none/kvm_state_test
* kselftest-vsyscall-mode-native/kvm_state_test
* kselftest-vsyscall-mode-none/kvm_sync_regs_test
* kselftest-vsyscall-mode-native/kvm_sync_regs_test
* kselftest/kvm_sync_regs_test
* kselftest-vsyscall-mode-native/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-none/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-none/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-native/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-native/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-none/kvm_vmx_tsc_adjust_test
* kselftest/kvm_xss_msr_test
* kselftest-vsyscall-mode-none/kvm_xss_msr_test
* kselftest-vsyscall-mode-native/kvm_xss_msr_test
* kselftest-vsyscall-mode-native/mqueue_mq_perf_tests
* kselftest/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-none/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-native/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-none/net_fib-onlink-tests.sh
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_tests.sh
* kselftest-vsyscall-mode-native/net_fib_tests.sh
* kselftest-vsyscall-mode-none/net_fib_tests.sh
* kselftest-vsyscall-mode-native/net_ip_defrag.sh
* kselftest-vsyscall-mode-none/net_ip_defrag.sh
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
* kselftest-vsyscall-mode-none/net_run_netsocktests
* kselftest/net_run_netsocktests
* kselftest-vsyscall-mode-native/net_test_vxlan_under_vrf.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-none/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-none/net_traceroute.sh
* kselftest/net_traceroute.sh
* kselftest-vsyscall-mode-native/net_traceroute.sh
* kselftest/net_udpgro_bench.sh
* kselftest-vsyscall-mode-native/net_udpgro_bench.sh
* kselftest-vsyscall-mode-none/net_udpgro_bench.sh
* kselftest-vsyscall-mode-none/net_udpgro.sh
* kselftest/net_udpgro.sh
* kselftest-vsyscall-mode-native/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_udpgso_bench.sh
* kselftest-vsyscall-mode-native/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_xfrm_policy.sh
* kselftest/net_xfrm_policy.sh
* kselftest-vsyscall-mode-native/net_xfrm_policy.sh
* kselftest-vsyscall-mode-none/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-native/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-native/pidfd_pidfd_poll_test
* kselftest/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-none/pidfd_pidfd_poll_test
* kselftest/pstore_pstore_tests
* kselftest-vsyscall-mode-native/pstore_pstore_tests
* kselftest-vsyscall-mode-none/pstore_pstore_tests
* kselftest/rseq_run_param_test.sh
* kselftest-vsyscall-mode-none/rseq_run_param_test.sh
* kselftest-vsyscall-mode-native/rseq_run_param_test.sh
* kselftest/rtc_rtctest
* kselftest-vsyscall-mode-native/rtc_rtctest
* kselftest-vsyscall-mode-none/rtc_rtctest
* kselftest-vsyscall-mode-none/seccomp_seccomp_benchmark
* kselftest-vsyscall-mode-native/seccomp_seccomp_benchmark
* kselftest/seccomp_seccomp_benchmark
* kselftest-vsyscall-mode-native/timers_set-timer-lat
* kselftest/timers_set-timer-lat
* kselftest-vsyscall-mode-none/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-none/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-native/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-none/tpm2_test_smoke.sh
* kselftest/tpm2_test_smoke.sh
* kselftest-vsyscall-mode-native/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh
* kselftest-vsyscall-mode-native/tpm2_test_space.sh
* kselftest-vsyscall-mode-none/tpm2_test_space.sh
* kselftest-vsyscall-mode-none/vm_run_vmtests
* kselftest/vm_run_vmtests
* kselftest-vsyscall-mode-native/vm_run_vmtests

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

x15:

i386:

qemu_arm64:
* kselftest/arm64_fake_sigreturn_bad_magic
* kselftest/arm64_fake_sigreturn_bad_size
* kselftest/arm64_fake_sigreturn_bad_size_for_magic0
* kselftest/arm64_fake_sigreturn_duplicated_fpsimd
* kselftest/arm64_fake_sigreturn_misaligned_sp
* kselftest/arm64_fake_sigreturn_missing_fpsimd
* kselftest/arm64_mangle_pstate_invalid_compat_toggle
* kselftest/arm64_mangle_pstate_invalid_daif_bits
* kselftest/arm64_mangle_pstate_invalid_mode_el1h
* kselftest/arm64_mangle_pstate_invalid_mode_el1t
* kselftest/arm64_mangle_pstate_invalid_mode_el2h
* kselftest/arm64_mangle_pstate_invalid_mode_el2t
* kselftest/arm64_mangle_pstate_invalid_mode_el3h
* kselftest/arm64_mangle_pstate_invalid_mode_el3t
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
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_rule_tests.sh
* kselftest/net_fib_tests.sh
* kselftest/netfilter_conntrack_icmp_related.sh
* kselftest/netfilter_nft_nat.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_rtnetlink.sh
* kselftest/net_run_netsocktests
* kselftest/net_so_txtime.sh
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/pidfd_pidfd_fdinfo_test
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/pidfd_pidfd_test
* kselftest/pidfd_pidfd_wait
* kselftest/proc_read
* kselftest/pstore_pstore_tests
* kselftest/rseq_basic_percpu_ops_test
* kselftest/rtc_rtctest
* kselftest/sync_sync_test
* kselftest/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_2916_1840019146.1575000024997--
