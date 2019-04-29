Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36942E33A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 15:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfD2NAg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 09:00:36 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:38525 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfD2NAg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 09:00:36 -0400
Received: by mail-wr1-f43.google.com with SMTP id k16so15913973wrn.5
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=FzIJQ0+MMHj8GQpSt6jMR+K9VlwmA4YdN3rzMUy9O2k=;
        b=mET7sjW6xP8PkJ+NJTxg9IHAJzLNCf4TczdVfery5LUg8wxUU5wvEm6g1UCEp2+FR+
         2piIQh4qq8beuL9MB2fs3vXoTQT8s0HzlKpUTvZLQdhnCCgGZgLFK7luE8Ljcn4ZSEbR
         lBo5PuiwIjMg+BaO0ok+0Cjl2lu+iCN2tSD+EoBy8M4hDUviXzWzN9OHjrc3nSJZnrY/
         BOkkv14Kq9TnkQROc5OcVGmgE/e8z4CMKvSn2i9jHfYFEEwnbUhrqRQtd/PBFLT8ekBr
         MF+/m62aP/YAtkjWFPxU935A+cxkBTVGeP1Ky+aEEBeMX6USxkantenHJCKWABvdkg2k
         dOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=FzIJQ0+MMHj8GQpSt6jMR+K9VlwmA4YdN3rzMUy9O2k=;
        b=iIF7gvzE4HMhlECUGrHvbDyMdrtnTb4U4UlBIOPmlFMO4ZSas8Q+HltU4C3lKk0yqp
         LVZ0X3LvgHno33oX+TxxUdzcZvDpXB8tx6+6jwN/O0D2W5C6w01JrXpao713Fjq3HOFy
         onGlQmcg4S39izvBR3vsWd98vhkfg/QcWFQIsN3ER3H4byOYHEHlvU6kNVmcnTzLd2Fd
         1yajqftQWxnVayQwZtwGIoGIBSuCBNTn6uIbKePXXy1Po8htQZLO3d5TA9nWmm0AL+l9
         xM8dQXh43QiVh0IkHTWOkyResJFJ7smFW4QEzmWdfTCsSl6NBjhMz84sv78GHWM/+mxe
         GyRg==
X-Gm-Message-State: APjAAAVhvHtavVew0uhAqVAW4poZWjahsE1R0UEw9JXqA2HsHAWk1zTS
        nnAQmnW5I3xc9MXlDzouHPItrg==
X-Google-Smtp-Source: APXvYqwntM0RLDnjDtFUjg2kwakJnhap53zjL81oOj7scMhf4FnEKOle0qIqczQIvJ5dagdNVvKTQQ==
X-Received: by 2002:adf:ee42:: with SMTP id w2mr39218605wro.161.1556542833168;
        Mon, 29 Apr 2019 06:00:33 -0700 (PDT)
Received: from a6c5c67cda76 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id c2sm30166107wrr.13.2019.04.29.06.00.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Apr 2019 06:00:32 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Mon, 29 Apr 2019 13:00:32 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        linux-kselftest@vger.kernel.org
Message-ID: <259410447.16196.1556542832616.JavaMail.jenkins@a6c5c67cda76>
Subject: next-20190429 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_16195_1098140448.1556542832114"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_16195_1098140448.1556542832114
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.1.0-rc6
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 3d17a1de96a233cf89bfbb5a77ebb1a05c420681
git describe: next-20190429
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190429

Regressions (compared to build next-20190426)
------------------------------------------------------------------------
qemu_arm:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_maps                                                                                                         
                                                                                         
    * bpf_test_sock_fields                                                                                                         
qemu_arm64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_sock_fields                                                                                                         
qemu_x86_64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_sock_fields                                                                                                         
x15 - arm:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_maps                                                                                                         
                                                                                         
    * bpf_test_sock_fields                                                                                                         
x86_64:                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
                                                                                                          
                                                                                                                       
Fixes (compared to build next-20190426)                                                                   
------------------------------------------------------------------------                                               
qemu_arm64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_maps                                                                                                         
                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
                                                                                         
    * bpf_test_sockmap                                                                                                         
qemu_x86_64:                                                                                                      
 kselftest:                                                                                         
    * proc_read                                                                                                         


In total:
------------------------------------------------------------------------
Ran 1250 total tests in the following environments and test suites.
pass 725
fail 419
xfail 0
skip 106

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
* boot-lkft-kselftests-master-509
* kselftest
* boot-lkft-kselftests-vsyscall-mode-native-master-509
* boot-lkft-kselftests-vsyscall-mode-none-master-509
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none


Failures
------------------------------------------------------------------------

qemu_arm:
* kselftest/binderfs_binderfs_test
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lirc_mode2_user
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_sysctl
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_verifier
* kselftest/cgroup_test_core
* kselftest/cpufreq_main.sh
* kselftest/dma-buf_udmabuf
* kselftest/firmware_fw_run_tests.sh
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest/kvm_dirty_log_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_platform_info_test
* kselftest/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest/kvm_state_test
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
* kselftest/livepatch_test-callbacks.sh
* kselftest/livepatch_test-livepatch.sh
* kselftest/livepatch_test-shadow-vars.sh
* kselftest/membarrier_membarrier_test
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_tests.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_msg_zerocopy.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_reuseport_bpf_numa
* kselftest/net_run_netsocktests
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_tls
* kselftest/pidfd_pidfd_test
* kselftest/proc_proc-self-map-files-002
* kselftest/proc_proc-self-syscall
* kselftest/pstore_pstore_tests
* kselftest/rseq_basic_percpu_ops_test
* kselftest/rseq_basic_test
* kselftest/rseq_param_test
* kselftest/rseq_param_test_benchmark
* kselftest/rseq_param_test_compare_twice
* kselftest/rtc_rtctest
* kselftest/seccomp_seccomp_bpf
* kselftest/timers_rtcpie
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh
* kselftest/vm_run_vmtests

i386:
* kselftest/binderfs_binderfs_test
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lirc_mode2_user
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/cgroup_test_core
* kselftest/dma-buf_udmabuf
* kselftest/firmware_fw_run_tests.sh

qemu_i386:
* kselftest/bpf_test_maps
* kselftest/bpf_test_progs

juno-r2:
* kselftest/binderfs_binderfs_test
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_verifier
* kselftest/cgroup_test_core
* kselftest/cpufreq_main.sh
* kselftest/dma-buf_udmabuf
* kselftest/firmware_fw_run_tests.sh
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest/kvm_dirty_log_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_platform_info_test
* kselftest/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest/kvm_state_test
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
* kselftest/livepatch_test-callbacks.sh
* kselftest/livepatch_test-livepatch.sh
* kselftest/livepatch_test-shadow-vars.sh
* kselftest/membarrier_membarrier_test

x15:
* kselftest/binderfs_binderfs_test
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_sock_addr.sh
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_verifier
* kselftest/cgroup_test_core
* kselftest/firmware_fw_run_tests.sh
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_platform_info_test
* kselftest/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest/kvm_state_test
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
* kselftest/livepatch_test-callbacks.sh
* kselftest/livepatch_test-livepatch.sh
* kselftest/livepatch_test-shadow-vars.sh
* kselftest/membarrier_membarrier_test
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_tests.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_msg_zerocopy.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_reuseport_bpf_numa
* kselftest/net_run_netsocktests
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_tls
* kselftest/pidfd_pidfd_test
* kselftest/proc_proc-self-map-files-002
* kselftest/proc_proc-self-syscall
* kselftest/pstore_pstore_tests
* kselftest/rseq_basic_percpu_ops_test
* kselftest/rseq_basic_test
* kselftest/rseq_param_test
* kselftest/rseq_param_test_benchmark
* kselftest/rseq_param_test_compare_twice
* kselftest/rtc_rtctest
* kselftest/seccomp_seccomp_bpf
* kselftest/timestamping_txtimestamp.sh

qemu_x86_64:
* kselftest/binderfs_binderfs_test
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lirc_mode2_user
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/cgroup_test_core
* kselftest/cpufreq_main.sh
* kselftest/dma-buf_udmabuf
* kselftest/firmware_fw_run_tests.sh
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest/kvm_dirty_log_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_platform_info_test
* kselftest/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest/kvm_state_test
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
* kselftest/livepatch_test-callbacks.sh
* kselftest/livepatch_test-livepatch.sh
* kselftest/membarrier_membarrier_test
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_msg_zerocopy.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_tls
* kselftest/net_xfrm_policy.sh
* kselftest/pidfd_pidfd_test
* kselftest/pstore_pstore_tests
* kselftest/rseq_basic_percpu_ops_test
* kselftest/rseq_basic_test
* kselftest/rseq_param_test
* kselftest/rseq_param_test_benchmark
* kselftest/rseq_param_test_compare_twice
* kselftest/rseq_run_param_test.sh
* kselftest/rtc_rtctest
* kselftest/seccomp_seccomp_bpf
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh
* kselftest/vm_run_vmtests
* kselftest/x86_fsgsbase_64

hi6220-hikey:
* boot-lkft-kselftests-master-509/hi6220-hikey-r2

dragonboard-410c:
* boot-lkft-kselftests-master-509/dragonboard-410c

qemu_arm64:
* kselftest/binderfs_binderfs_test
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lirc_mode2_user
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_verifier
* kselftest/cgroup_test_core
* kselftest/cpufreq_main.sh
* kselftest/dma-buf_udmabuf
* kselftest/firmware_fw_run_tests.sh
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest/kvm_dirty_log_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_platform_info_test
* kselftest/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest/kvm_state_test
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
* kselftest/livepatch_test-callbacks.sh
* kselftest/livepatch_test-livepatch.sh
* kselftest/livepatch_test-shadow-vars.sh
* kselftest/membarrier_membarrier_test
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_tests.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_msg_zerocopy.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_tls
* kselftest/pidfd_pidfd_test
* kselftest/pstore_pstore_tests
* kselftest/rseq_basic_percpu_ops_test
* kselftest/rseq_basic_test
* kselftest/rseq_param_test
* kselftest/rseq_param_test_benchmark
* kselftest/rseq_param_test_compare_twice
* kselftest/rtc_rtctest
* kselftest/seccomp_seccomp_bpf
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh
* kselftest/vm_run_vmtests

x86:
* kselftest-vsyscall-mode-native/binderfs_binderfs_test
* kselftest-vsyscall-mode-native/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-native/bpf_test_lirc_mode2_user
* kselftest-vsyscall-mode-native/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-native/bpf_test_netcnt
* kselftest-vsyscall-mode-native/bpf_test_progs
* kselftest-vsyscall-mode-native/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_sock_fields
* kselftest-vsyscall-mode-native/bpf_test_sockmap
* kselftest-vsyscall-mode-native/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-native/cgroup_test_core
* kselftest-vsyscall-mode-native/dma-buf_udmabuf
* kselftest-vsyscall-mode-native/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-native/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-native/kvm_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_evmcs_test
* kselftest-vsyscall-mode-native/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-native/kvm_platform_info_test
* kselftest-vsyscall-mode-native/kvm_set_sregs_test
* kselftest-vsyscall-mode-native/kvm_smm_test
* kselftest-vsyscall-mode-native/kvm_state_test
* kselftest-vsyscall-mode-native/kvm_sync_regs_test
* kselftest-vsyscall-mode-native/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-native/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-native/lib_bitmap.sh
* kselftest-vsyscall-mode-native/lib_prime_numbers.sh
* kselftest-vsyscall-mode-native/lib_printf.sh
* kselftest-vsyscall-mode-native/lib_strscpy.sh
* kselftest-vsyscall-mode-native/livepatch_test-callbacks.sh
* kselftest-vsyscall-mode-native/livepatch_test-livepatch.sh
* kselftest-vsyscall-mode-native/livepatch_test-shadow-vars.sh
* kselftest-vsyscall-mode-native/membarrier_membarrier_test
* kselftest-vsyscall-mode-native/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-native/net_ip_defrag.sh
* kselftest-vsyscall-mode-native/net_msg_zerocopy.sh
* kselftest-vsyscall-mode-native/net_pmtu.sh
* kselftest-vsyscall-mode-native/net_psock_snd.sh
* kselftest-vsyscall-mode-native/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-native/net_xfrm_policy.sh
* kselftest-vsyscall-mode-native/pidfd_pidfd_test
* kselftest-vsyscall-mode-native/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-none/binderfs_binderfs_test
* kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-none/bpf_test_lirc_mode2_user
* kselftest-vsyscall-mode-none/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-none/bpf_test_netcnt
* kselftest-vsyscall-mode-none/bpf_test_progs
* kselftest-vsyscall-mode-none/bpf_test_sock_fields
* kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-none/cgroup_test_core
* kselftest-vsyscall-mode-none/dma-buf_udmabuf
* kselftest-vsyscall-mode-none/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-none/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-none/kvm_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_evmcs_test
* kselftest-vsyscall-mode-none/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-none/kvm_platform_info_test
* kselftest-vsyscall-mode-none/kvm_set_sregs_test
* kselftest-vsyscall-mode-none/kvm_smm_test
* kselftest-vsyscall-mode-none/kvm_state_test
* kselftest-vsyscall-mode-none/kvm_sync_regs_test
* kselftest-vsyscall-mode-none/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-none/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-none/lib_bitmap.sh
* kselftest-vsyscall-mode-none/lib_prime_numbers.sh
* kselftest-vsyscall-mode-none/lib_printf.sh
* kselftest-vsyscall-mode-none/lib_strscpy.sh
* kselftest-vsyscall-mode-none/livepatch_test-callbacks.sh
* kselftest-vsyscall-mode-none/livepatch_test-livepatch.sh
* kselftest-vsyscall-mode-none/livepatch_test-shadow-vars.sh
* kselftest-vsyscall-mode-none/membarrier_membarrier_test
* kselftest-vsyscall-mode-none/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-none/net_ip_defrag.sh
* kselftest-vsyscall-mode-none/net_msg_zerocopy.sh
* kselftest-vsyscall-mode-none/net_pmtu.sh
* kselftest-vsyscall-mode-none/net_psock_snd.sh
* kselftest-vsyscall-mode-none/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-none/net_xfrm_policy.sh
* kselftest-vsyscall-mode-none/pidfd_pidfd_test
* kselftest-vsyscall-mode-none/timestamping_txtimestamp.sh
* kselftest/binderfs_binderfs_test
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lirc_mode2_user
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/cgroup_test_core
* kselftest/dma-buf_udmabuf
* kselftest/firmware_fw_run_tests.sh
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest/kvm_dirty_log_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_platform_info_test
* kselftest/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest/kvm_state_test
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/livepatch_test-callbacks.sh
* kselftest/livepatch_test-livepatch.sh
* kselftest/livepatch_test-shadow-vars.sh
* kselftest/membarrier_membarrier_test
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_msg_zerocopy.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_xfrm_policy.sh
* kselftest/pidfd_pidfd_test
* kselftest/timestamping_txtimestamp.sh


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_16195_1098140448.1556542832114--
