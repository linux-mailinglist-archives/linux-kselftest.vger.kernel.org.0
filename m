Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 029C0BA227
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Sep 2019 14:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbfIVMAm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 22 Sep 2019 08:00:42 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39392 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbfIVMAm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 22 Sep 2019 08:00:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so6331864wml.4
        for <linux-kselftest@vger.kernel.org>; Sun, 22 Sep 2019 05:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=n/UT69Vj4MhfELarw8BcijH4cnAFrEZ6/fY08Ckkbls=;
        b=OaucPD7/B5er7xsg6E+fU8OGVsIzU04dgQryj9oa3Ic89UGIh0in9ZSg8tLxNOcX+D
         pli4LARjg/8IVijcjWeJ98tKVGgdJLQX/tTYD1Be0diIiTD8g/tSGf+du7iK0L4bW+Cn
         5J75b/DRrd8OTi9yYoX4Z59SI3+yBeT1x559x3WICMZFTtLk4LySx+u+UIf+TXxeMqIM
         QRGRfHO4pZmI9hcMOh6C4GamPJayXH/t2bsaBb/Zw4Y9qnfJx/wMwmrpr3pU9S1wFre5
         Sefc7Ty4w/qn7krBrydJGpZrTACotH6lUPAVaOKtJaDsuG6YUkqxjLvJ3t/amTFzLpM/
         p1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=n/UT69Vj4MhfELarw8BcijH4cnAFrEZ6/fY08Ckkbls=;
        b=Gs+hRCjEseDO2Srf0+jueemSMdbLXIlwmPSKhaGouP3PxHNLfre9PFxHrac/ixujBP
         WhOsNlZYOKYsG4eL+IxCTyznPcc36Ri0Oi447BzcIsOYy82Y/QEnCc22Obz9TXgQnyMY
         mYrUrcHGYW4OBMl31xqNbKe4z0T6nR6pB+v3beSXwaOvg+27rJoRxFOPChTSbg90OHlL
         I8CNkKjETdwIg3V/Clm5dogCGp3+ZMD0jlxOO7sma6aD2vxHWk1wjOhfciJjjSnTvic3
         35U+D9Q29l7UE/kHWz1gO7NYpbj9SlPm650YanqGnCWtN5zxkw6JWNxo+Ru/bb5YxuLh
         Z+wA==
X-Gm-Message-State: APjAAAXWKB6liX+cY5b46PC3LamW28r7hy8Wi6rK0j7qtEouds+I7te6
        pfZGaK+JEJASe7R2op9YM05duQ==
X-Google-Smtp-Source: APXvYqxXOgqfBFLavRb3UunG4exEdVLg/MLUYCFo7bd92a5/0vytFNvNgV/nRllM7yXiTGxV9tzLCw==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr10915617wmc.124.1569153636519;
        Sun, 22 Sep 2019 05:00:36 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id n1sm10568252wrg.67.2019.09.22.05.00.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Sep 2019 05:00:35 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Sun, 22 Sep 2019 12:00:35 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <184615697.2328.1569153635844.JavaMail.javamailuser@localhost>
Subject: next-20190920 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_2327_914286230.1569153635193"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_2327_914286230.1569153635193
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.3.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: b5b3bd898ba99fb0fb6aed3b23ec6353a1724d6f
git describe: next-20190920
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190920

Regressions (compared to build next-20190919)
------------------------------------------------------------------------
x15 - arm:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
dragonboard-410c - arm64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
qemu_arm:                                                                                                      
 kselftest:                                                                                         
    * cgroup_test_freezer                                                                                                         
                                                                                                          
                                                                                                                       
Fixes (compared to build next-20190919)                                                                   
------------------------------------------------------------------------                                               
dragonboard-410c - arm64:                                                                                                      
 kselftest:                                                                                         
    * timestamping_txtimestamp.sh                                                                                                         
juno-r2 - arm64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
qemu_arm:                                                                                                      
 kselftest:                                                                                         
    * net_so_txtime.sh                                                                                                         


In total:
------------------------------------------------------------------------
Ran 1878 total tests in the following environments and test suites.
pass 1112
fail 634
xfail 0
skip 132

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

juno-r2:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_btf_dump
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_libbpf.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_verifier
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_xdping
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
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_rule_tests.sh
* kselftest/net_fib_tests.sh
* kselftest/netfilter_conntrack_icmp_related.sh
* kselftest/netfilter_nft_nat.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/pidfd_pidfd_test
* kselftest/pidfd_pidfd_wait
* kselftest/pstore_pstore_tests
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh

x86:
* kselftest-vsyscall-mode-native/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-native/bpf_test_bpftool_build.sh
* kselftest-vsyscall-mode-native/bpf_test_btf_dump
* kselftest-vsyscall-mode-native/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-native/bpf_test_libbpf.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-native/bpf_test_maps
* kselftest-vsyscall-mode-native/bpf_test_netcnt
* kselftest-vsyscall-mode-native/bpf_test_progs
* kselftest-vsyscall-mode-native/bpf_test_select_reuseport
* kselftest-vsyscall-mode-native/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_socket_cookie
* kselftest-vsyscall-mode-native/bpf_test_sock_fields
* kselftest-vsyscall-mode-native/bpf_test_sockmap
* kselftest-vsyscall-mode-native/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-native/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-native/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-native/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_xdping.sh
* kselftest-vsyscall-mode-native/bpf_xdping
* kselftest-vsyscall-mode-native/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-native/ftrace_ftracetest
* kselftest-vsyscall-mode-native/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-native/kvm_dirty_log_test
* kselftest-vsyscall-mode-native/kvm_evmcs_test
* kselftest-vsyscall-mode-native/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-native/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-native/kvm_platform_info_test
* kselftest-vsyscall-mode-native/kvm_set_sregs_test
* kselftest-vsyscall-mode-native/kvm_smm_test
* kselftest-vsyscall-mode-native/kvm_state_test
* kselftest-vsyscall-mode-native/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-native/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-native/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-native/lib_bitmap.sh
* kselftest-vsyscall-mode-native/lib_prime_numbers.sh
* kselftest-vsyscall-mode-native/lib_printf.sh
* kselftest-vsyscall-mode-native/lib_strscpy.sh
* kselftest-vsyscall-mode-native/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-native/net_fib_tests.sh
* kselftest-vsyscall-mode-native/net_ip_defrag.sh
* kselftest-vsyscall-mode-native/net_l2tp.sh
* kselftest-vsyscall-mode-native/net_pmtu.sh
* kselftest-vsyscall-mode-native/net_psock_snd.sh
* kselftest-vsyscall-mode-native/net_run_netsocktests
* kselftest-vsyscall-mode-native/net_tcp_fastopen_backup_key.sh
* kselftest-vsyscall-mode-native/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-native/net_xfrm_policy.sh
* kselftest-vsyscall-mode-native/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-native/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-native/pstore_pstore_tests
* kselftest-vsyscall-mode-native/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-native/tpm2_test_smoke.sh
* kselftest-vsyscall-mode-native/tpm2_test_space.sh
* kselftest-vsyscall-mode-none/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-none/bpf_test_bpftool_build.sh
* kselftest-vsyscall-mode-none/bpf_test_btf_dump
* kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-none/bpf_test_libbpf.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-none/bpf_test_maps
* kselftest-vsyscall-mode-none/bpf_test_netcnt
* kselftest-vsyscall-mode-none/bpf_test_progs
* kselftest-vsyscall-mode-none/bpf_test_select_reuseport
* kselftest-vsyscall-mode-none/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-none/bpf_test_socket_cookie
* kselftest-vsyscall-mode-none/bpf_test_sock_fields
* kselftest-vsyscall-mode-none/bpf_test_sockmap
* kselftest-vsyscall-mode-none/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-none/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-none/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_xdping.sh
* kselftest-vsyscall-mode-none/bpf_xdping
* kselftest-vsyscall-mode-none/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-none/ftrace_ftracetest
* kselftest-vsyscall-mode-none/kvm_clear_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_cr4_cpuid_sync_test
* kselftest-vsyscall-mode-none/kvm_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_evmcs_test
* kselftest-vsyscall-mode-none/kvm_hyperv_cpuid
* kselftest-vsyscall-mode-none/kvm_kvm_create_max_vcpus
* kselftest-vsyscall-mode-none/kvm_platform_info_test
* kselftest-vsyscall-mode-none/kvm_set_sregs_test
* kselftest-vsyscall-mode-none/kvm_smm_test
* kselftest-vsyscall-mode-none/kvm_state_test
* kselftest-vsyscall-mode-none/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-none/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-none/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-none/lib_bitmap.sh
* kselftest-vsyscall-mode-none/lib_prime_numbers.sh
* kselftest-vsyscall-mode-none/lib_printf.sh
* kselftest-vsyscall-mode-none/lib_strscpy.sh
* kselftest-vsyscall-mode-none/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-none/net_fib_tests.sh
* kselftest-vsyscall-mode-none/net_ip_defrag.sh
* kselftest-vsyscall-mode-none/net_l2tp.sh
* kselftest-vsyscall-mode-none/net_pmtu.sh
* kselftest-vsyscall-mode-none/net_psock_snd.sh
* kselftest-vsyscall-mode-none/net_run_netsocktests
* kselftest-vsyscall-mode-none/net_tcp_fastopen_backup_key.sh
* kselftest-vsyscall-mode-none/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-none/net_xfrm_policy.sh
* kselftest-vsyscall-mode-none/pidfd_pidfd_open_test
* kselftest-vsyscall-mode-none/pidfd_pidfd_poll_test
* kselftest-vsyscall-mode-none/pstore_pstore_tests
* kselftest-vsyscall-mode-none/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-none/tpm2_test_smoke.sh
* kselftest-vsyscall-mode-none/tpm2_test_space.sh
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_btf_dump
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_libbpf.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_sock_addr.sh
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_xdping
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
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_tests.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_xfrm_policy.sh
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/pstore_pstore_tests
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh

x15:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_btf_dump
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_libbpf.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
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
* kselftest/bpf_test_verifier
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_xdping
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
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
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
* kselftest/net_so_txtime.sh
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/proc_proc-self-map-files-002
* kselftest/proc_proc-self-syscall
* kselftest/pstore_pstore_tests
* kselftest/rtc_rtctest
* kselftest/seccomp_seccomp_bpf
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh

qemu_x86_64:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_btf_dump
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_libbpf.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_xdping
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
* kselftest/kvm_sync_regs_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_tests.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_xfrm_policy.sh
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/pstore_pstore_tests
* kselftest/timers_rtcpie
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh
* kselftest/x86_fsgsbase_64

qemu_arm:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_btf_dump
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_libbpf.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
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
* kselftest/bpf_test_verifier
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_xdping
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
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
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
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/proc_proc-self-map-files-002
* kselftest/proc_proc-self-syscall
* kselftest/pstore_pstore_tests
* kselftest/seccomp_seccomp_bpf
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh

hi6220-hikey:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_btf_dump
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_libbpf.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_sock_addr.sh
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_verifier
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_xdping

qemu_arm64:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_btf_dump
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_libbpf.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_verifier
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_xdping
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
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_rule_tests.sh
* kselftest/net_fib_tests.sh
* kselftest/netfilter_conntrack_icmp_related.sh
* kselftest/netfilter_nft_nat.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/pidfd_pidfd_test
* kselftest/pidfd_pidfd_wait
* kselftest/pstore_pstore_tests
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh

qemu_i386:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_btf_dump
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_hashmap
* kselftest/bpf_test_libbpf.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_sysctl
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_xdping
* kselftest/cpufreq_main.sh

i386:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_btf_dump
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_hashmap
* kselftest/bpf_test_libbpf.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_sysctl
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_xdping

dragonboard-410c:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_btf_dump
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_libbpf.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_sock_addr.sh
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tc_edt.sh
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest/bpf_test_verifier
* kselftest/bpf_test_xdping.sh
* kselftest/bpf_xdping
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
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_close_while_nested_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
* kselftest/net_fib-onlink-tests.sh
* kselftest/net_fib_rule_tests.sh
* kselftest/net_fib_tests.sh
* kselftest/netfilter_conntrack_icmp_related.sh
* kselftest/netfilter_nft_nat.sh
* kselftest/net_ip_defrag.sh
* kselftest/net_l2tp.sh
* kselftest/net_pmtu.sh
* kselftest/net_psock_snd.sh
* kselftest/net_run_netsocktests
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/pidfd_pidfd_open_test
* kselftest/pidfd_pidfd_poll_test
* kselftest/pidfd_pidfd_test
* kselftest/pidfd_pidfd_wait
* kselftest/pstore_pstore_tests
* kselftest/rtc_rtctest
* kselftest/timers_rtcpie
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh
* kselftest/vm_run_vmtests


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_2327_914286230.1569153635193--
