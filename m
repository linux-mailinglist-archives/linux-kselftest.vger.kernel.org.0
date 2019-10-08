Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B14D01F8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 22:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfJHUPt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 16:15:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38650 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfJHUPs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 16:15:48 -0400
Received: by mail-io1-f68.google.com with SMTP id u8so39415197iom.5
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2019 13:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=otRbhTmgSy8pwdZUI8Iq1+AW20muB0yz3zfRcvtCULc=;
        b=KnTqlgADbCjqAncN7hhp53r9ZeBPku7kyaGspsV9kvDYT4xWTfeQROquTITUx4VRVa
         B72S3C8ra+A5lrh76/SXB77jYP0C3x+6H+S+ZznCjFQOeqGBakAZswIADi24v49FQiAd
         dnLdhJUecKthyN7AfJpYsqL8WnjqlQ4GfotUX9S+pGEv/pMutmRXioKA1LTViTzu4cMq
         j34yb6RXh6VyG1JsawDgvkbxEmEwqipBw6m24t1WHLY5Gnylp4Usgj4+r7gELrxGnyyk
         tVJWBy6vEcIAj0UACmnOr7jr/P0mP4sulxzGLXCmdwxsy+xT1Qu+3nKAzy1HfD0DQp7w
         3paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=otRbhTmgSy8pwdZUI8Iq1+AW20muB0yz3zfRcvtCULc=;
        b=qE7c1rsYeddcr9uIDsIg1ROYBYI4ojcpbzTGZwWcrRJ7viTjvxDNYSmwS38cckjgkH
         adAuyyCnVixfSX4QiE7qcHXk+Nl7FlzYKZEGZDDi6Csxjv/Txjqbd8NQ5eJLDRbfgaC7
         PXj+JLosKbf1fIraGMfRcMaYnWun54swG/WZ3XluOOsZnmeoze+rewh6p6QUJIDxdQkw
         QPVNWY1adgB7ytLnNEzIExziA0sJ3/zGvquF780mEcQHZYrBGWCMlwgZACHtJRrAr4Az
         aTxsdAyyaryi4cr/4EWQglgkOwsow+kyio0lDl4RnSaB65+bZ3oAIxk4CI6VpzHe/TGp
         CKKw==
X-Gm-Message-State: APjAAAULSHDSGOtvWqbc9QtW5vulTCIvsIj13vnLd9+AhEgCZZvtpUxe
        NFa0A75190qQADEjPvQXp12lIg==
X-Google-Smtp-Source: APXvYqyEV/xONbuiHXP8VEMlwLZe8xJxqENF7He+GUtnNXR6bO7JPVBi2wS7rRt4q47a7p1ClXIOyA==
X-Received: by 2002:a92:9cca:: with SMTP id x71mr207613ill.245.1570565746848;
        Tue, 08 Oct 2019 13:15:46 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id q74sm15254iod.72.2019.10.08.13.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 13:15:45 -0700 (PDT)
Date:   Tue, 8 Oct 2019 15:15:45 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     ci_notify@linaro.org
Cc:     lkft-triage@lists.linaro.org, anders.roxell@linaro.org,
        naresh.kamboju@linaro.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: next-20191008 kselftest results
Message-ID: <20191008201545.ri74vx66w6czqz5g@xps.therub.org>
References: <860973729.5879.1570564829288.JavaMail.javamailuser@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <860973729.5879.1570564829288.JavaMail.javamailuser@localhost>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 08, 2019 at 08:00:28PM +0000, ci_notify@linaro.org wrote:
> Summary
> ------------------------------------------------------------------------
> kernel: 5.4.0-rc2
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> git branch: master
> git commit: 442630f691a1537b7e0cc35e3d580222077549cb
> git describe: next-20191008
> Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191008
> 
> Regressions (compared to build next-20191004)
> ------------------------------------------------------------------------
> No regressions
>
> Fixes (compared to build next-20191004)
> ------------------------------------------------------------------------
> No fixes

This struck me as unlikely so I went and looked; next-20191004 had a
build failure, and so none of the tests ran. In such a case, there are
no regressions or fixes to report.

> 
> In total:
> ------------------------------------------------------------------------
> Ran 1558 total tests in the following environments and test suites.
> pass 901
> fail 549
> xfail 0
> skip 108
> 
> Environments
> --------------
> - dragonboard-410c - arm64
> - hi6220-hikey - arm64
> - i386
> - juno-r2 - arm64
> - qemu_arm64
> - qemu_i386
> - qemu_x86_64
> - x15 - arm
> - x86_64
> 
> Test Suites
> -----------
> * kselftest
> * kselftest-vsyscall-mode-native
> * kselftest-vsyscall-mode-none
> 
> 
> Failures
> ------------------------------------------------------------------------
> 
> x15:
> 
> qemu_x86_64:
> * kselftest/bpf_get_cgroup_id_user
> * kselftest/bpf_test_bpftool_build.sh
> * kselftest/bpf_test_btf_dump
> * kselftest/bpf_test_dev_cgroup
> * kselftest/bpf_test_flow_dissector.sh
> * kselftest/bpf_test_libbpf.sh
> * kselftest/bpf_test_lwt_ip_encap.sh
> * kselftest/bpf_test_lwt_seg6local.sh
> * kselftest/bpf_test_maps
> * kselftest/bpf_test_netcnt
> * kselftest/bpf_test_progs
> * kselftest/bpf_test_select_reuseport
> * kselftest/bpf_test_socket_cookie
> * kselftest/bpf_test_sock_fields
> * kselftest/bpf_test_sockmap
> * kselftest/bpf_test_tc_edt.sh
> * kselftest/bpf_test_tcpbpf_user
> * kselftest/bpf_test_tcpnotify_user
> * kselftest/bpf_test_tc_tunnel.sh
> * kselftest/bpf_test_tunnel.sh
> * kselftest/bpf_test_xdping.sh
> * kselftest/bpf_xdping
> * kselftest/cpufreq_main.sh
> * kselftest/firmware_fw_run_tests.sh
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
> * kselftest/kvm_vmx_dirty_log_test
> * kselftest/lib_bitmap.sh
> * kselftest/lib_prime_numbers.sh
> * kselftest/lib_printf.sh
> * kselftest/lib_strscpy.sh
> * kselftest/mqueue_mq_perf_tests
> * kselftest/net_fib-onlink-tests.sh
> * kselftest/net_fib_tests.sh
> * kselftest/net_ip_defrag.sh
> * kselftest/net_l2tp.sh
> * kselftest/net_pmtu.sh
> * kselftest/net_psock_snd.sh
> * kselftest/net_run_netsocktests
> * kselftest/net_tcp_fastopen_backup_key.sh
> * kselftest/net_test_vxlan_under_vrf.sh
> * kselftest/net_udpgso_bench.sh
> * kselftest/net_xfrm_policy.sh
> * kselftest/pidfd_pidfd_open_test
> * kselftest/pidfd_pidfd_poll_test
> * kselftest/pstore_pstore_tests
> * kselftest/rseq_run_param_test.sh
> * kselftest/rtc_rtctest
> * kselftest/timers_set-timer-lat
> * kselftest/timestamping_txtimestamp.sh
> * kselftest/tpm2_test_smoke.sh
> * kselftest/tpm2_test_space.sh
> * kselftest/vm_run_vmtests
> * kselftest/x86_fsgsbase_64
> 
> x86:
> * kselftest/bpf_get_cgroup_id_user
> * kselftest/bpf_test_bpftool_build.sh
> * kselftest/bpf_test_btf_dump
> * kselftest/bpf_test_dev_cgroup
> * kselftest/bpf_test_flow_dissector.sh
> * kselftest/bpf_test_libbpf.sh
> * kselftest/bpf_test_lwt_ip_encap.sh
> * kselftest/bpf_test_lwt_seg6local.sh
> * kselftest/bpf_test_maps
> * kselftest/bpf_test_netcnt
> * kselftest/bpf_test_progs
> * kselftest/bpf_test_select_reuseport
> * kselftest/bpf_test_socket_cookie
> * kselftest/bpf_test_sock_fields
> * kselftest/bpf_test_sockmap
> * kselftest/bpf_test_tcpbpf_user
> * kselftest/bpf_test_tcpnotify_user
> * kselftest/bpf_test_tc_tunnel.sh
> * kselftest/bpf_test_tunnel.sh
> * kselftest/bpf_test_xdping.sh
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
> * kselftest/lib_bitmap.sh
> * kselftest/lib_prime_numbers.sh
> * kselftest/lib_printf.sh
> * kselftest/lib_strscpy.sh
> * kselftest/mqueue_mq_perf_tests
> * kselftest/net_fib-onlink-tests.sh
> * kselftest/net_fib_tests.sh
> * kselftest/net_ip_defrag.sh
> * kselftest/net_l2tp.sh
> * kselftest/net_pmtu.sh
> * kselftest/net_psock_snd.sh
> * kselftest/net_run_netsocktests
> * kselftest/net_tcp_fastopen_backup_key.sh
> * kselftest/net_test_vxlan_under_vrf.sh
> * kselftest/net_udpgso_bench.sh
> * kselftest/net_xfrm_policy.sh
> * kselftest/pidfd_pidfd_open_test
> * kselftest/pidfd_pidfd_poll_test
> * kselftest/pidfd_pidfd_test
> * kselftest/pstore_pstore_tests
> * kselftest/rseq_run_param_test.sh
> * kselftest/rtc_rtctest
> * kselftest/seccomp_seccomp_benchmark
> * kselftest/timers_set-timer-lat
> * kselftest/timestamping_txtimestamp.sh
> * kselftest/tpm2_test_smoke.sh
> * kselftest/tpm2_test_space.sh
> * kselftest/vm_run_vmtests
> * kselftest-vsyscall-mode-native/bpf_get_cgroup_id_user
> * kselftest-vsyscall-mode-native/bpf_test_bpftool_build.sh
> * kselftest-vsyscall-mode-native/bpf_test_btf_dump
> * kselftest-vsyscall-mode-native/bpf_test_dev_cgroup
> * kselftest-vsyscall-mode-native/bpf_test_flow_dissector.sh
> * kselftest-vsyscall-mode-native/bpf_test_libbpf.sh
> * kselftest-vsyscall-mode-native/bpf_test_lwt_ip_encap.sh
> * kselftest-vsyscall-mode-native/bpf_test_lwt_seg6local.sh
> * kselftest-vsyscall-mode-native/bpf_test_maps
> * kselftest-vsyscall-mode-native/bpf_test_netcnt
> * kselftest-vsyscall-mode-native/bpf_test_progs
> * kselftest-vsyscall-mode-native/bpf_test_select_reuseport
> * kselftest-vsyscall-mode-native/bpf_test_socket_cookie
> * kselftest-vsyscall-mode-native/bpf_test_sock_fields
> * kselftest-vsyscall-mode-native/bpf_test_sockmap
> * kselftest-vsyscall-mode-native/bpf_test_tc_edt.sh
> * kselftest-vsyscall-mode-native/bpf_test_tcpbpf_user
> * kselftest-vsyscall-mode-native/bpf_test_tcpnotify_user
> * kselftest-vsyscall-mode-native/bpf_test_tc_tunnel.sh
> * kselftest-vsyscall-mode-native/bpf_test_tunnel.sh
> * kselftest-vsyscall-mode-native/bpf_test_xdping.sh
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
> * kselftest-vsyscall-mode-native/lib_bitmap.sh
> * kselftest-vsyscall-mode-native/lib_prime_numbers.sh
> * kselftest-vsyscall-mode-native/lib_printf.sh
> * kselftest-vsyscall-mode-native/lib_strscpy.sh
> * kselftest-vsyscall-mode-native/mqueue_mq_perf_tests
> * kselftest-vsyscall-mode-native/net_fib-onlink-tests.sh
> * kselftest-vsyscall-mode-native/net_fib_tests.sh
> * kselftest-vsyscall-mode-native/net_ip_defrag.sh
> * kselftest-vsyscall-mode-native/net_l2tp.sh
> * kselftest-vsyscall-mode-native/net_pmtu.sh
> * kselftest-vsyscall-mode-native/net_psock_snd.sh
> * kselftest-vsyscall-mode-native/net_run_netsocktests
> * kselftest-vsyscall-mode-native/net_tcp_fastopen_backup_key.sh
> * kselftest-vsyscall-mode-native/net_test_vxlan_under_vrf.sh
> * kselftest-vsyscall-mode-native/net_udpgso_bench.sh
> * kselftest-vsyscall-mode-native/net_xfrm_policy.sh
> * kselftest-vsyscall-mode-native/pidfd_pidfd_open_test
> * kselftest-vsyscall-mode-native/pidfd_pidfd_poll_test
> * kselftest-vsyscall-mode-native/pidfd_pidfd_test
> * kselftest-vsyscall-mode-native/pstore_pstore_tests
> * kselftest-vsyscall-mode-native/rseq_run_param_test.sh
> * kselftest-vsyscall-mode-native/rtc_rtctest
> * kselftest-vsyscall-mode-native/seccomp_seccomp_benchmark
> * kselftest-vsyscall-mode-native/timers_set-timer-lat
> * kselftest-vsyscall-mode-native/timestamping_txtimestamp.sh
> * kselftest-vsyscall-mode-native/tpm2_test_smoke.sh
> * kselftest-vsyscall-mode-native/tpm2_test_space.sh
> * kselftest-vsyscall-mode-native/vm_run_vmtests
> * kselftest-vsyscall-mode-none/bpf_get_cgroup_id_user
> * kselftest-vsyscall-mode-none/bpf_test_bpftool_build.sh
> * kselftest-vsyscall-mode-none/bpf_test_btf_dump
> * kselftest-vsyscall-mode-none/bpf_test_dev_cgroup
> * kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
> * kselftest-vsyscall-mode-none/bpf_test_libbpf.sh
> * kselftest-vsyscall-mode-none/bpf_test_lwt_ip_encap.sh
> * kselftest-vsyscall-mode-none/bpf_test_lwt_seg6local.sh
> * kselftest-vsyscall-mode-none/bpf_test_maps
> * kselftest-vsyscall-mode-none/bpf_test_netcnt
> * kselftest-vsyscall-mode-none/bpf_test_progs
> * kselftest-vsyscall-mode-none/bpf_test_select_reuseport
> * kselftest-vsyscall-mode-none/bpf_test_socket_cookie
> * kselftest-vsyscall-mode-none/bpf_test_sock_fields
> * kselftest-vsyscall-mode-none/bpf_test_sockmap
> * kselftest-vsyscall-mode-none/bpf_test_tc_edt.sh
> * kselftest-vsyscall-mode-none/bpf_test_tcpbpf_user
> * kselftest-vsyscall-mode-none/bpf_test_tcpnotify_user
> * kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
> * kselftest-vsyscall-mode-none/bpf_test_tunnel.sh
> * kselftest-vsyscall-mode-none/bpf_test_xdping.sh
> * kselftest-vsyscall-mode-none/bpf_xdping
> * kselftest-vsyscall-mode-none/firmware_fw_run_tests.sh
> * kselftest-vsyscall-mode-none/intel_pstate_run.sh
> * kselftest-vsyscall-mode-none/kvm_clear_dirty_log_test
> * kselftest-vsyscall-mode-none/kvm_cr4_cpuid_sync_test
> * kselftest-vsyscall-mode-none/kvm_dirty_log_test
> * kselftest-vsyscall-mode-none/kvm_evmcs_test
> * kselftest-vsyscall-mode-none/kvm_hyperv_cpuid
> * kselftest-vsyscall-mode-none/kvm_kvm_create_max_vcpus
> * kselftest-vsyscall-mode-none/kvm_platform_info_test
> * kselftest-vsyscall-mode-none/kvm_set_sregs_test
> * kselftest-vsyscall-mode-none/kvm_smm_test
> * kselftest-vsyscall-mode-none/kvm_state_test
> * kselftest-vsyscall-mode-none/kvm_sync_regs_test
> * kselftest-vsyscall-mode-none/kvm_vmx_close_while_nested_test
> * kselftest-vsyscall-mode-none/kvm_vmx_dirty_log_test
> * kselftest-vsyscall-mode-none/kvm_vmx_set_nested_state_test
> * kselftest-vsyscall-mode-none/kvm_vmx_tsc_adjust_test
> * kselftest-vsyscall-mode-none/lib_bitmap.sh
> * kselftest-vsyscall-mode-none/lib_prime_numbers.sh
> * kselftest-vsyscall-mode-none/lib_printf.sh
> * kselftest-vsyscall-mode-none/lib_strscpy.sh
> * kselftest-vsyscall-mode-none/mqueue_mq_perf_tests
> * kselftest-vsyscall-mode-none/net_fib_tests.sh
> * kselftest-vsyscall-mode-none/net_ip_defrag.sh
> * kselftest-vsyscall-mode-none/net_l2tp.sh
> * kselftest-vsyscall-mode-none/net_pmtu.sh
> * kselftest-vsyscall-mode-none/net_psock_snd.sh
> * kselftest-vsyscall-mode-none/net_run_netsocktests
> * kselftest-vsyscall-mode-none/net_tcp_fastopen_backup_key.sh
> * kselftest-vsyscall-mode-none/net_test_vxlan_under_vrf.sh
> * kselftest-vsyscall-mode-none/net_udpgso_bench.sh
> * kselftest-vsyscall-mode-none/net_xfrm_policy.sh
> * kselftest-vsyscall-mode-none/pidfd_pidfd_open_test
> * kselftest-vsyscall-mode-none/pidfd_pidfd_poll_test
> * kselftest-vsyscall-mode-none/pidfd_pidfd_test
> * kselftest-vsyscall-mode-none/pstore_pstore_tests
> * kselftest-vsyscall-mode-none/rseq_run_param_test.sh
> * kselftest-vsyscall-mode-none/rtc_rtctest
> * kselftest-vsyscall-mode-none/seccomp_seccomp_benchmark
> * kselftest-vsyscall-mode-none/timers_set-timer-lat
> * kselftest-vsyscall-mode-none/timestamping_txtimestamp.sh
> * kselftest-vsyscall-mode-none/tpm2_test_smoke.sh
> * kselftest-vsyscall-mode-none/tpm2_test_space.sh
> * kselftest-vsyscall-mode-none/vm_run_vmtests
> 
> juno-r2:
> * kselftest/bpf_get_cgroup_id_user
> * kselftest/bpf_test_bpftool_build.sh
> * kselftest/bpf_test_btf_dump
> * kselftest/bpf_test_flow_dissector.sh
> * kselftest/bpf_test_libbpf.sh
> * kselftest/bpf_test_lwt_ip_encap.sh
> * kselftest/bpf_test_lwt_seg6local.sh
> * kselftest/bpf_test_maps
> * kselftest/bpf_test_netcnt
> * kselftest/bpf_test_progs
> * kselftest/bpf_test_select_reuseport
> * kselftest/bpf_test_socket_cookie
> * kselftest/bpf_test_sock_fields
> * kselftest/bpf_test_sockmap
> * kselftest/bpf_test_tag
> * kselftest/bpf_test_tc_edt.sh
> * kselftest/bpf_test_tcpbpf_user
> * kselftest/bpf_test_tcp_check_syncookie.sh
> * kselftest/bpf_test_tcpnotify_user
> * kselftest/bpf_test_tc_tunnel.sh
> * kselftest/bpf_test_tunnel.sh
> * kselftest/bpf_test_verifier
> * kselftest/bpf_test_xdping.sh
> * kselftest/bpf_xdping
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
> * kselftest/lib_prime_numbers.sh
> * kselftest/lib_printf.sh
> * kselftest/lib_strscpy.sh
> * kselftest/net_fib-onlink-tests.sh
> * kselftest/net_fib_rule_tests.sh
> * kselftest/net_fib_tests.sh
> * kselftest/netfilter_conntrack_icmp_related.sh
> * kselftest/netfilter_nft_nat.sh
> * kselftest/net_ip_defrag.sh
> * kselftest/net_l2tp.sh
> * kselftest/net_pmtu.sh
> * kselftest/net_psock_snd.sh
> * kselftest/net_rtnetlink.sh
> * kselftest/net_run_netsocktests
> * kselftest/net_tcp_fastopen_backup_key.sh
> * kselftest/net_test_vxlan_under_vrf.sh
> * kselftest/net_udpgso_bench.sh
> * kselftest/pidfd_pidfd_open_test
> * kselftest/pidfd_pidfd_poll_test
> * kselftest/pidfd_pidfd_test
> * kselftest/pidfd_pidfd_wait
> * kselftest/pstore_pstore_tests
> * kselftest/rseq_basic_percpu_ops_test
> * kselftest/rtc_rtctest
> * kselftest/timers_set-timer-lat
> * kselftest/timestamping_txtimestamp.sh
> 
> qemu_arm64:
> 
> qemu_i386:
> * kselftest/bpf_get_cgroup_id_user
> * kselftest/bpf_test_bpftool_build.sh
> * kselftest/bpf_test_btf_dump
> * kselftest/bpf_test_dev_cgroup
> * kselftest/bpf_test_flow_dissector.sh
> * kselftest/bpf_test_hashmap
> * kselftest/bpf_test_libbpf.sh
> * kselftest/bpf_test_lwt_ip_encap.sh
> * kselftest/bpf_test_lwt_seg6local.sh
> * kselftest/bpf_test_maps
> * kselftest/bpf_test_netcnt
> * kselftest/bpf_test_progs
> * kselftest/bpf_test_select_reuseport
> * kselftest/bpf_test_socket_cookie
> * kselftest/bpf_test_sock_fields
> * kselftest/bpf_test_sockmap
> * kselftest/bpf_test_sysctl
> * kselftest/bpf_test_tc_edt.sh
> * kselftest/bpf_test_tcpbpf_user
> * kselftest/bpf_test_tcpnotify_user
> * kselftest/bpf_test_tc_tunnel.sh
> * kselftest/bpf_test_tunnel.sh
> * kselftest/bpf_test_xdping.sh
> * kselftest/bpf_xdping
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
> * kselftest/lib_prime_numbers.sh
> * kselftest/lib_printf.sh
> * kselftest/lib_strscpy.sh
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
> * kselftest/net_tcp_fastopen_backup_key.sh
> * kselftest/net_test_vxlan_under_vrf.sh
> * kselftest/net_udpgso_bench.sh
> * kselftest/net_xfrm_policy.sh
> * kselftest/pidfd_pidfd_open_test
> * kselftest/pidfd_pidfd_poll_test
> * kselftest/proc_proc-self-map-files-002
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
> i386:
> * kselftest/bpf_get_cgroup_id_user
> * kselftest/bpf_test_bpftool_build.sh
> * kselftest/bpf_test_btf_dump
> * kselftest/bpf_test_dev_cgroup
> * kselftest/bpf_test_flow_dissector.sh
> * kselftest/bpf_test_hashmap
> * kselftest/bpf_test_libbpf.sh
> * kselftest/bpf_test_lwt_ip_encap.sh
> * kselftest/bpf_test_lwt_seg6local.sh
> * kselftest/bpf_test_maps
> * kselftest/bpf_test_netcnt
> * kselftest/bpf_test_progs
> * kselftest/bpf_test_select_reuseport
> * kselftest/bpf_test_socket_cookie
> * kselftest/bpf_test_sock_fields
> * kselftest/bpf_test_sockmap
> * kselftest/bpf_test_sysctl
> * kselftest/bpf_test_tc_edt.sh
> * kselftest/bpf_test_tcpbpf_user
> * kselftest/bpf_test_tcpnotify_user
> * kselftest/bpf_test_tc_tunnel.sh
> * kselftest/bpf_test_tunnel.sh
> * kselftest/bpf_test_xdping.sh
> * kselftest/bpf_xdping
> * kselftest/firmware_fw_run_tests.sh
> * kselftest/intel_pstate_run.sh
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
> * kselftest/lib_prime_numbers.sh
> * kselftest/lib_printf.sh
> * kselftest/lib_strscpy.sh
> * kselftest/mqueue_mq_perf_tests
> * kselftest/net_fib-onlink-tests.sh
> * kselftest/net_fib_tests.sh
> * kselftest/net_ip_defrag.sh
> * kselftest/net_l2tp.sh
> * kselftest/net_pmtu.sh
> * kselftest/net_psock_snd.sh
> * kselftest/net_run_netsocktests
> * kselftest/net_tcp_fastopen_backup_key.sh
> * kselftest/net_test_vxlan_under_vrf.sh
> * kselftest/net_udpgso_bench.sh
> * kselftest/pidfd_pidfd_open_test
> * kselftest/pidfd_pidfd_poll_test
> * kselftest/proc_proc-self-map-files-002
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
> hi6220-hikey:
> 
> dragonboard-410c:
> * kselftest/bpf_get_cgroup_id_user
> * kselftest/bpf_test_bpftool_build.sh
> * kselftest/bpf_test_btf_dump
> * kselftest/bpf_test_flow_dissector.sh
> * kselftest/bpf_test_kmod.sh
> * kselftest/bpf_test_libbpf.sh
> * kselftest/bpf_test_lpm_map
> * kselftest/bpf_test_lwt_ip_encap.sh
> * kselftest/bpf_test_lwt_seg6local.sh
> * kselftest/bpf_test_maps
> * kselftest/bpf_test_netcnt
> * kselftest/bpf_test_progs
> * kselftest/bpf_test_select_reuseport
> * kselftest/bpf_test_skb_cgroup_id.sh
> * kselftest/bpf_test_socket_cookie
> * kselftest/bpf_test_sock_fields
> * kselftest/bpf_test_sockmap
> * kselftest/bpf_test_tag
> * kselftest/bpf_test_tc_edt.sh
> * kselftest/bpf_test_tcpbpf_user
> * kselftest/bpf_test_tcp_check_syncookie.sh
> * kselftest/bpf_test_tcpnotify_user
> * kselftest/bpf_test_tc_tunnel.sh
> * kselftest/bpf_test_tunnel.sh
> * kselftest/bpf_test_verifier
> * kselftest/bpf_test_xdping.sh
> * kselftest/bpf_xdping
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
> * kselftest/lib_prime_numbers.sh
> * kselftest/lib_printf.sh
> * kselftest/lib_strscpy.sh
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
> * kselftest/net_udpgso_bench.sh
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
> 
> 
> Skips
> ------------------------------------------------------------------------
> No skips
> 
> 
> -- 
> Linaro LKFT
> https://lkft.linaro.org


-- 
Linaro - Kernel Validation
