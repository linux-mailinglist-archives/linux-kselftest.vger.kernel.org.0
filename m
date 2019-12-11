Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1176011A666
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2019 10:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfLKJAb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Dec 2019 04:00:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39354 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfLKJAb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Dec 2019 04:00:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so23083450wrt.6
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2019 01:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=5qhQgtZgYY4+Z7Cqhz314j9UFGYoeVqYbiE65ssT8qU=;
        b=VzC0lVirmvCvG8lRe1sMD90EbUDcP+jMBn5abTZU4KdNpeF3G18q22ydc0bj2KYtkh
         XuP0BH9VtlmzN/QMaMW6MEdJ+k695t5R/MaIlL8XyIm9WITZNbwYvaLQB/p426ySIO0c
         09dtRZnXbCCycxlDaXAH9T+szeL7rkk54F8EPSLRxWQHnRYCCpSk4xMLmv+YxTe9GQUE
         d2VK0RjXst5JWwbzzv2mOJfdYxtQaLxVDiuD3gSfgvhz45rp7WoXvIvPWJvRye46Dayj
         ttUWh0hcoeZLuUbjo6Ow+tnh0lPB6R9/DbI8tXwQXSBa0wU9kL6hGjTp4ldCteX96gtD
         4V0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=5qhQgtZgYY4+Z7Cqhz314j9UFGYoeVqYbiE65ssT8qU=;
        b=kn+6dKhT9wzwCEwtLbNev3pjkwWeMgyvc3YdKmtANPYRxP8XdSBYA8107+IE6hQk+a
         0iUPYROF8bDPoPG9rJjzCHwIK9a51KZauXy+q9gSriFMU7bM9W6X8WtgXa5xhoOF/rhX
         at2US0GzZ9vpjRK5Bgx1it/I4wkAweS2o/KzFwWODpP6CcFcxMUeXxmWWglaLdJyo7Nt
         dr1B1VN+2OT0X5fymJiYpi3lTc8wdhBMVnh6kMRnoRTglKPvnEyRnAj8vh9orkmcIgRp
         1UChg+7wGbEDtG7Ng/lBIXj3/8ccyi+q6FqtsZZKDQnAFkiqOs3ibFZNRmzRfBn7k0Xu
         6DYA==
X-Gm-Message-State: APjAAAVwUbMbnAQG7O5LXV+At0A48SrYiGlpwTIMphGAXCee+AyhxiGL
        NO7zLvg+x47yR2j/xA6Hs49o6A==
X-Google-Smtp-Source: APXvYqzINo2fxDxo+xFfk4PvtLMQOr6CDeg8HbKmUNH0FdOCq3YGMyZ2k6qkcKKtDHyt0R+6IEJMAA==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr2457272wrn.384.1576054827928;
        Wed, 11 Dec 2019 01:00:27 -0800 (PST)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id i16sm1542535wmb.36.2019.12.11.01.00.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 01:00:27 -0800 (PST)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Wed, 11 Dec 2019 09:00:26 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <1215988151.4282.1576054827217.JavaMail.javamailuser@localhost>
Subject: next-20191211 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_4281_1559608014.1576054826278"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_4281_1559608014.1576054826278
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.5.0-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 938f49c85b36076b19251b316eeaa5435c50ff6e
git describe: next-20191211
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191211

Regressions (compared to build next-20191209)
------------------------------------------------------------------------
i386:                                                                                                      
 kselftest:                                                                                         
    * binderfs_binderfs_test                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * binderfs_binderfs_test                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * binderfs_binderfs_test                                                                                                         
x86:                                                                                                      
 kselftest:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * binderfs_binderfs_test                                                                                                         
qemu_arm64:                                                                                                      
 kselftest:                                                                                         
    * binderfs_binderfs_test                                                                                                         
                                                                                                          
                                                                                                                       
Fixes (compared to build next-20191209)                                                                   
------------------------------------------------------------------------                                               
x86:                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * cgroup_test_freezer                                                                                                         


In total:
------------------------------------------------------------------------
Ran 540 total tests in the following environments and test suites.
pass 225
fail 272
xfail 0
skip 43

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

dragonboard-410c:

x86:
* kselftest/binderfs_binderfs_test
* kselftest-vsyscall-mode-none/binderfs_binderfs_test
* kselftest-vsyscall-mode-native/binderfs_binderfs_test
* kselftest-vsyscall-mode-none/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-native/bpf_get_cgroup_id_user
* kselftest/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-none/bpf_test_dev_cgroup
* kselftest/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-native/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-native/bpf_test_flow_dissector.sh
* kselftest/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-none/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest-vsyscall-mode-none/bpf_test_maps
* kselftest-vsyscall-mode-native/bpf_test_maps
* kselftest-vsyscall-mode-none/bpf_test_netcnt
* kselftest-vsyscall-mode-native/bpf_test_netcnt
* kselftest/bpf_test_netcnt
* kselftest-vsyscall-mode-native/bpf_test_progs
* kselftest-vsyscall-mode-none/bpf_test_progs
* kselftest/bpf_test_progs
* kselftest/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-native/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-none/bpf_test_progs-no_alu32
* kselftest-vsyscall-mode-none/bpf_test_select_reuseport
* kselftest-vsyscall-mode-native/bpf_test_select_reuseport
* kselftest/bpf_test_select_reuseport
* kselftest-vsyscall-mode-native/bpf_test_skb_cgroup_id.sh
* kselftest/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-none/bpf_test_skb_cgroup_id.sh
* kselftest/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-none/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_socket_cookie
* kselftest/bpf_test_socket_cookie
* kselftest-vsyscall-mode-none/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest-vsyscall-mode-native/bpf_test_sock_fields
* kselftest-vsyscall-mode-none/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest-vsyscall-mode-native/bpf_test_sockmap
* kselftest-vsyscall-mode-none/bpf_test_sockmap
* kselftest-vsyscall-mode-native/bpf_test_sysctl
* kselftest/bpf_test_sysctl
* kselftest-vsyscall-mode-none/bpf_test_sysctl
* kselftest/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-native/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-none/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-native/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-none/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-native/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-none/bpf_test_tcp_check_syncookie.sh
* kselftest/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-none/bpf_test_tcpnotify_user
* kselftest/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-native/bpf_test_tcpnotify_user
* kselftest/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tunnel.sh
* kselftest/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tunnel.sh
* kselftest/bpf_test_xdping.sh
* kselftest-vsyscall-mode-none/bpf_test_xdping.sh
* kselftest-vsyscall-mode-native/bpf_test_xdping.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_meta.sh
* kselftest/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_redirect.sh
* kselftest/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_generic.sh
* kselftest/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_native.sh
* kselftest/bpf_test_xdp_vlan_mode_native.sh

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

qemu_arm64:
* kselftest/binderfs_binderfs_test
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

hi6220-hikey:

x15:
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

i386:
* kselftest/binderfs_binderfs_test
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_dev_cgroup
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


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_4281_1559608014.1576054826278--
