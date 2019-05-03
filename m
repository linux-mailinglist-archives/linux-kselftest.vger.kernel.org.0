Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 834FE12643
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2019 04:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfECCAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 May 2019 22:00:30 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:36029 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfECCAa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 May 2019 22:00:30 -0400
Received: by mail-wr1-f47.google.com with SMTP id o4so5829083wra.3
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2019 19:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=NTHb6kWNQ6VCIcyVd23v5R4e6KITAdnfmGiumrb1bfQ=;
        b=WiRJZ4kMM8e11xm49X0b58qbqUnncf9xfeios548l5vNmIJP+s9PFThP6VaZcbRIQh
         4bTU8AtG6/IzjuFDDTNFDQmkoae/Qz6wEUFfwMRTjIkAPVKMeTVYffws+RHfdfEiFoQr
         w3TDSqAzD9x9nWOxRD+mbB103YBf4SsK4ArEjuBNgox88EiLmTddIx9Rs9Xb91DJms3N
         pFIvLFGMd7R5INzJPd5P/PbjR+7YL2GaInXRPQzkMmjllElRJzjODTmkWiZGPV1VjH9L
         RyvJlIGeHT1cQG/eJy9t2XkGe2Uw8o9vA1lWVDFrX8mMMi7wvd8+BK4rA0fnM4dNLtr9
         4vKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=NTHb6kWNQ6VCIcyVd23v5R4e6KITAdnfmGiumrb1bfQ=;
        b=A+NVMFn7Y7G1tcyn5TXSHycJ1Db5yW+k3XPFOr753FyZcNP/okS2uPZ1wXhakwdtFk
         xma3HpCrq6vxEyui9oTlGZF7kX+lL7IPAIatr8e/r31U07YNGUuzdfpBzMtty9uH29rk
         Ibrxh/H7cruEKtvGlRM+sGt8kzVbVri7HPuEj9ffiJVU3Oo88fYP/wnUWFS/igs2WRly
         PU51EB9pyMNAS2HHlUAvCi4Wo3IrDDFb88xxYJ8A/ECkwAghudU/2AAwRyNjP4acEMsl
         KoXGjioscKOvrW9D8fRLlvLIkfP///ACddKhR8ypXN4apLJiLAk0nTK7cAbmTomLx1uo
         k/ZQ==
X-Gm-Message-State: APjAAAUaWdFW/tasZ+gs0st5rSAqw60+7lZpYAimT5gOYKTT8s9d8+S8
        iv/0llr5wpkTKJKVMBlF2ok8Sg==
X-Google-Smtp-Source: APXvYqytnpoiYII5vm4cUVD0mgGdD0sLl0sPUhSe1AqGuoy/2pBy08mvVLnS90XXiw4MB/aY/yvx6g==
X-Received: by 2002:a05:6000:1181:: with SMTP id g1mr4783866wrx.56.1556848827325;
        Thu, 02 May 2019 19:00:27 -0700 (PDT)
Received: from a6c5c67cda76 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id g5sm659267wrh.44.2019.05.02.19.00.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 May 2019 19:00:26 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Fri, 3 May 2019 02:00:26 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        linux-kselftest@vger.kernel.org
Message-ID: <1847077412.16901.1556848826838.JavaMail.jenkins@a6c5c67cda76>
Subject: next-20190502 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_16900_1878413545.1556848826304"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_16900_1878413545.1556848826304
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.1.0-rc7
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: e8b243ea3b19b6f3b9fffca232a2c7b000964d6b
git describe: next-20190502
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190502

Regressions (compared to build next-20190501)
------------------------------------------------------------------------
qemu_arm:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_maps                                                                                                         
qemu_i386:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_tcpbpf_user                                                                                                         
qemu_x86_64:                                                                                                      
 kselftest:                                                                                         
    * net_fib_rule_tests.sh                                                                                                         
x15 - arm:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_maps                                                                                                         
                                                                                         
    * cgroup_test_freezer                                                                                                         
                                                                                         
    * net_fib_rule_tests.sh                                                                                                         
x86_64:                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * net_fib_rule_tests.sh                                                                                                         
                                                                                                          
                                                                                                                       
Fixes (compared to build next-20190501)                                                                   
------------------------------------------------------------------------                                               
qemu_x86_64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
x86_64:                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * net_fib-onlink-tests.sh                                                                                                         


In total:
------------------------------------------------------------------------
Ran 555 total tests in the following environments and test suites.
pass 337
fail 179
xfail 0
skip 39

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot-lkft-kselftests-master-512
* kselftest
* boot-lkft-kselftests-vsyscall-mode-native-master-512
* boot-lkft-kselftests-vsyscall-mode-none-master-512
* kselftest-vsyscall-mode-none


Failures
------------------------------------------------------------------------

dragonboard-410c:

hi6220-hikey:

juno-r2:

qemu_i386:
* kselftest/bpf_test_maps
* kselftest/bpf_test_progs
* kselftest/bpf_test_tcpbpf_user

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
* kselftest/livepatch_test-shadow-vars.sh
* kselftest/membarrier_membarrier_test
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_rule_tests.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_msg_zerocopy.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_tls
* kselftest/net_xfrm_policy.sh
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
* kselftest/vm_run_vmtests
* kselftest/x86_fsgsbase_64

x15:
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
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_verifier
* kselftest/cgroup_test_core
* kselftest/cgroup_test_freezer
* kselftest/dma-buf_udmabuf
* kselftest/firmware_fw_run_tests.sh
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
* kselftest/net_fib_rule_tests.sh
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
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh
* kselftest/vm_run_vmtests

qemu_arm:
* kselftest/bpf_test_maps
* kselftest/bpf_test_progs
* kselftest/bpf_test_verifier

i386:
* kselftest/bpf_test_maps
* kselftest/bpf_test_progs

x86:
* kselftest-vsyscall-mode-none/binderfs_binderfs_test
* kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-none/bpf_test_lirc_mode2_user
* kselftest-vsyscall-mode-none/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-none/bpf_test_netcnt
* kselftest-vsyscall-mode-none/bpf_test_progs
* kselftest-vsyscall-mode-none/bpf_test_sock_fields
* kselftest-vsyscall-mode-none/bpf_test_sockmap
* kselftest-vsyscall-mode-none/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-none/cgroup_test_core
* kselftest-vsyscall-mode-none/dma-buf_udmabuf
* kselftest-vsyscall-mode-none/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-none/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-none/kvm_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_evmcs_test
* kselftest-vsyscall-mode-none/kvm_platform_info_test
* kselftest-vsyscall-mode-none/kvm_set_sregs_test
* kselftest-vsyscall-mode-none/kvm_smm_test
* kselftest-vsyscall-mode-none/kvm_state_test
* kselftest-vsyscall-mode-none/kvm_sync_regs_test
* kselftest-vsyscall-mode-none/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-none/lib_bitmap.sh
* kselftest-vsyscall-mode-none/lib_prime_numbers.sh
* kselftest-vsyscall-mode-none/lib_printf.sh
* kselftest-vsyscall-mode-none/lib_strscpy.sh
* kselftest-vsyscall-mode-none/livepatch_test-callbacks.sh
* kselftest-vsyscall-mode-none/livepatch_test-livepatch.sh
* kselftest-vsyscall-mode-none/livepatch_test-shadow-vars.sh
* kselftest-vsyscall-mode-none/membarrier_membarrier_test
* kselftest-vsyscall-mode-none/net_fib_rule_tests.sh
* kselftest-vsyscall-mode-none/net_ip_defrag.sh
* kselftest-vsyscall-mode-none/net_msg_zerocopy.sh
* kselftest-vsyscall-mode-none/net_pmtu.sh
* kselftest-vsyscall-mode-none/net_psock_snd.sh
* kselftest-vsyscall-mode-none/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-none/net_xfrm_policy.sh
* kselftest-vsyscall-mode-none/pidfd_pidfd_test
* kselftest-vsyscall-mode-none/pstore_pstore_tests
* kselftest-vsyscall-mode-none/rseq_basic_percpu_ops_test
* kselftest-vsyscall-mode-none/rseq_basic_test
* kselftest-vsyscall-mode-none/rseq_param_test
* kselftest-vsyscall-mode-none/rseq_param_test_benchmark
* kselftest-vsyscall-mode-none/rseq_param_test_compare_twice
* kselftest-vsyscall-mode-none/rseq_run_param_test.sh
* kselftest-vsyscall-mode-none/seccomp_seccomp_bpf
* kselftest-vsyscall-mode-none/timestamping_txtimestamp.sh


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_16900_1878413545.1556848826304--
