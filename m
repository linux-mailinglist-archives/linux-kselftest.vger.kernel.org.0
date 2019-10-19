Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9F93DD6B9
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2019 07:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfJSFD0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Oct 2019 01:03:26 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:32790 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfJSFDZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Oct 2019 01:03:25 -0400
Received: by mail-wm1-f49.google.com with SMTP id r17so10630398wme.0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2019 22:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:in-reply-to:references:subject:mime-version;
        bh=JAEvgned3BkSDkZXLsbuWc8dx2M58NlvkhIl2DbUbpk=;
        b=mOBtO3Ivwg8ozDrnD/Yj5XIFLOvNhqQJoGpP6+7TaBn/Xbbab8nawN//tPaHOghE+y
         VY9mcexit2zU6YGT7U+sErEXgSpPeazv6JbF+fAK2mu2QZSSGjESMMw2PmHb23/zC3SF
         amXQWD77/W/hkUzsfLzjAL7CxqqbM/taSjiwQpTIB7O90ekfMNzq6gXw2BDYzEgdhlQD
         t/EEF6cN+x6wSqnnkdiCnDYa4XIi7z79vcTQaoHPSQJcRQ++GUuP5wv6VY1dDu3xEcl9
         KYiTYNBD4KwwJ1ZiS1q78mUJBXUgasMPzH8b2b/xizq9HVXSLjnKULD+5kF9WRNRtJnp
         eEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:in-reply-to:references
         :subject:mime-version;
        bh=JAEvgned3BkSDkZXLsbuWc8dx2M58NlvkhIl2DbUbpk=;
        b=cbxS8RWPsJ1hF+IBwVy0g4Oaztap4N/KXBpGUQC7AXryiwX1HQI8Vyi7kyDaRyxTqb
         9sJ3Wv/Vxd3IUFTQNABvx4fzUkBMkAslRqCUbZY5OCDMn6q+g8bs8ZuWgYYjhBwyrq36
         Q6hUnmf8nJNlhI80RbvloxrNvBcA3xqzg2EI6mgFuiaKj+juB+cWh7mZIPOcGipsFHl6
         tS+jOk8jXIxwNqrReBhOHbrPwldFnnzOo9p+qK656k942ik1MmrszeTCtNdbtIfpT84P
         rbjP3xuHm1uoP++AZ+1IDWMSiSBulVMe8SaLOVzhZmV7NmlUKeV1aoP17bPqINt+1Mmt
         gVMA==
X-Gm-Message-State: APjAAAWDdChrtcExGL8sjxJxQBwqGIoYtp84o3n/z6eG1BqYsZOBQ2KA
        dyIr9dJVISIPNBWmAxEtl4DSig==
X-Google-Smtp-Source: APXvYqwhRVUPw0CSWsjseBAEVPuj0o3Wb5Lo+1KCfZd1jPNVHzrvlsI3xQyxxvvT/tltnN9njYqo2w==
X-Received: by 2002:a1c:35c3:: with SMTP id c186mr4343064wma.94.1571461398240;
        Fri, 18 Oct 2019 22:03:18 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id y5sm7924761wma.14.2019.10.18.22.03.17
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Oct 2019 22:03:17 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Sat, 19 Oct 2019 05:03:17 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <834073458.8388.1571461397612.JavaMail.javamailuser@localhost>
In-Reply-To: <849691089.8172.1571364229859.JavaMail.javamailuser@localhost>
References: <849691089.8172.1571364229859.JavaMail.javamailuser@localhost>
Subject: next-20191018 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_8387_90588155.1571461397251"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_8387_90588155.1571461397251
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.4.0-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: c4b9850b3676869ac0def5885d781d17f64b3a86
git describe: next-20191018
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191018

Regressions (compared to build next-20191017)
------------------------------------------------------------------------
x86_64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
                                                                                         
    * bpf_test_sysctl                                                                                                         
                                                                                         
    * bpf_test_tcp_check_syncookie.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
                                                                                         
    * bpf_test_tcp_check_syncookie.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * bpf_test_sysctl                                                                                                         
                                                                                         
    * bpf_test_tcp_check_syncookie.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
x86_64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
                                                                                         
    * bpf_test_sysctl                                                                                                         
                                                                                         
    * bpf_test_tcp_check_syncookie.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
                                                                                         
    * bpf_test_tcp_check_syncookie.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * bpf_test_sysctl                                                                                                         
                                                                                         
    * bpf_test_tcp_check_syncookie.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
x86_64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
                                                                                         
    * bpf_test_sysctl                                                                                                         
                                                                                         
    * bpf_test_tcp_check_syncookie.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-native:                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
                                                                                         
    * bpf_test_tcp_check_syncookie.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * bpf_test_sysctl                                                                                                         
                                                                                         
    * bpf_test_tcp_check_syncookie.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
dragonboard-410c - arm64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_dev_cgroup                                                                                                         
                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sysctl                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
i386:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
                                                                                         
    * bpf_test_tcp_check_syncookie.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
                                                                                         
    * pidfd_pidfd_test                                                                                                         
qemu_i386:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
                                                                                         
    * bpf_test_tcp_check_syncookie.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
qemu_arm64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_dev_cgroup                                                                                                         
                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sysctl                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
hi6220-hikey - arm64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_dev_cgroup                                                                                                         
                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sysctl                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
                                                                                         
    * seccomp_seccomp_benchmark                                                                                                         
x15 - arm:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
qemu_x86_64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sysctl                                                                                                         
                                                                                         
    * bpf_test_tcp_check_syncookie.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
qemu_arm:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * cgroup_test_freezer                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
juno-r2 - arm64:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_dev_cgroup                                                                                                         
                                                                                         
    * bpf_test_skb_cgroup_id.sh                                                                                                         
                                                                                         
    * bpf_test_sock_addr.sh                                                                                                         
                                                                                         
    * bpf_test_sysctl                                                                                                         
                                                                                         
    * bpf_test_xdp_meta.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_redirect.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_generic.sh                                                                                                         
                                                                                         
    * bpf_test_xdp_vlan_mode_native.sh                                                                                                         
                                                                                         
    * net_udpgro.sh                                                                                                         
                                                                                         
    * net_udpgro_bench.sh                                                                                                         
                                                                                                          
                                                                                                                       
Fixes (compared to build next-20191017)                                                                   
------------------------------------------------------------------------                                               
x86_64:                                                                                                      
 kselftest:                                                                                         
    * pidfd_pidfd_test                                                                                                         
                                                                                         
    * x86_fsgsbase_64                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * pidfd_pidfd_test                                                                                                         
x86_64:                                                                                                      
 kselftest:                                                                                         
    * pidfd_pidfd_test                                                                                                         
                                                                                         
    * x86_fsgsbase_64                                                                                                         
                                                                                                      
 kselftest-vsyscall-mode-none:                                                                                         
    * pidfd_pidfd_test                                                                                                         
i386:                                                                                                      
 kselftest:                                                                                         
    * seccomp_seccomp_benchmark                                                                                                         
juno-r2 - arm64:                                                                                                      
 kselftest:                                                                                         
    * net_rtnetlink.sh                                                                                                         


In total:
------------------------------------------------------------------------
Ran 2277 total tests in the following environments and test suites.
pass 1188
fail 911
xfail 0
skip 178

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

qemu_x86_64:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
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
* kselftest/bpf_xdping
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
* kselftest/kvm_vmx_dirty_log_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
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
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/net_xfrm_policy.sh
* kselftest/pstore_pstore_tests
* kselftest/rseq_run_param_test.sh
* kselftest/rtc_rtctest
* kselftest/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh
* kselftest/vm_run_vmtests
* kselftest/x86_fsgsbase_64

x86:
* kselftest-vsyscall-mode-native/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-native/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-native/bpf_test_flow_dissector.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_ip_encap.sh
* kselftest-vsyscall-mode-native/bpf_test_lwt_seg6local.sh
* kselftest-vsyscall-mode-native/bpf_test_maps
* kselftest-vsyscall-mode-native/bpf_test_netcnt
* kselftest-vsyscall-mode-native/bpf_test_progs
* kselftest-vsyscall-mode-native/bpf_test_select_reuseport
* kselftest-vsyscall-mode-native/bpf_test_skb_cgroup_id.sh
* kselftest-vsyscall-mode-native/bpf_test_sock_addr.sh
* kselftest-vsyscall-mode-native/bpf_test_socket_cookie
* kselftest-vsyscall-mode-native/bpf_test_sock_fields
* kselftest-vsyscall-mode-native/bpf_test_sockmap
* kselftest-vsyscall-mode-native/bpf_test_sysctl
* kselftest-vsyscall-mode-native/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-native/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-native/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-native/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-native/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-native/bpf_test_xdping.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-native/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-native/bpf_xdping
* kselftest-vsyscall-mode-native/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-native/intel_pstate_run.sh
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
* kselftest-vsyscall-mode-native/kvm_sync_regs_test
* kselftest-vsyscall-mode-native/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-native/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-native/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-native/lib_bitmap.sh
* kselftest-vsyscall-mode-native/lib_prime_numbers.sh
* kselftest-vsyscall-mode-native/lib_printf.sh
* kselftest-vsyscall-mode-native/lib_strscpy.sh
* kselftest-vsyscall-mode-native/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-native/net_fib_tests.sh
* kselftest-vsyscall-mode-native/net_ip_defrag.sh
* kselftest-vsyscall-mode-native/net_l2tp.sh
* kselftest-vsyscall-mode-native/net_pmtu.sh
* kselftest-vsyscall-mode-native/net_psock_snd.sh
* kselftest-vsyscall-mode-native/net_run_netsocktests
* kselftest-vsyscall-mode-native/net_tcp_fastopen_backup_key.sh
* kselftest-vsyscall-mode-native/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-native/net_udpgro_bench.sh
* kselftest-vsyscall-mode-native/net_udpgro.sh
* kselftest-vsyscall-mode-native/net_udpgso_bench.sh
* kselftest-vsyscall-mode-native/net_xfrm_policy.sh
* kselftest-vsyscall-mode-native/pidfd_pidfd_test
* kselftest-vsyscall-mode-native/pstore_pstore_tests
* kselftest-vsyscall-mode-native/rseq_run_param_test.sh
* kselftest-vsyscall-mode-native/rtc_rtctest
* kselftest-vsyscall-mode-native/seccomp_seccomp_benchmark
* kselftest-vsyscall-mode-native/timers_set-timer-lat
* kselftest-vsyscall-mode-native/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-native/tpm2_test_smoke.sh
* kselftest-vsyscall-mode-native/tpm2_test_space.sh
* kselftest-vsyscall-mode-native/vm_run_vmtests
* kselftest-vsyscall-mode-none/bpf_get_cgroup_id_user
* kselftest-vsyscall-mode-none/bpf_test_bpftool_build.sh
* kselftest-vsyscall-mode-none/bpf_test_dev_cgroup
* kselftest-vsyscall-mode-none/bpf_test_flow_dissector.sh
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
* kselftest-vsyscall-mode-none/bpf_test_sysctl
* kselftest-vsyscall-mode-none/bpf_test_tc_edt.sh
* kselftest-vsyscall-mode-none/bpf_test_tcpbpf_user
* kselftest-vsyscall-mode-none/bpf_test_tcp_check_syncookie.sh
* kselftest-vsyscall-mode-none/bpf_test_tcpnotify_user
* kselftest-vsyscall-mode-none/bpf_test_tc_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_tunnel.sh
* kselftest-vsyscall-mode-none/bpf_test_xdping.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_meta.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_redirect.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_generic.sh
* kselftest-vsyscall-mode-none/bpf_test_xdp_vlan_mode_native.sh
* kselftest-vsyscall-mode-none/bpf_xdping
* kselftest-vsyscall-mode-none/firmware_fw_run_tests.sh
* kselftest-vsyscall-mode-none/intel_pstate_run.sh
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
* kselftest-vsyscall-mode-none/kvm_sync_regs_test
* kselftest-vsyscall-mode-none/kvm_vmx_close_while_nested_test
* kselftest-vsyscall-mode-none/kvm_vmx_dirty_log_test
* kselftest-vsyscall-mode-none/kvm_vmx_set_nested_state_test
* kselftest-vsyscall-mode-none/kvm_vmx_tsc_adjust_test
* kselftest-vsyscall-mode-none/lib_bitmap.sh
* kselftest-vsyscall-mode-none/lib_prime_numbers.sh
* kselftest-vsyscall-mode-none/lib_printf.sh
* kselftest-vsyscall-mode-none/lib_strscpy.sh
* kselftest-vsyscall-mode-none/mqueue_mq_perf_tests
* kselftest-vsyscall-mode-none/net_fib-onlink-tests.sh
* kselftest-vsyscall-mode-none/net_fib_tests.sh
* kselftest-vsyscall-mode-none/net_ip_defrag.sh
* kselftest-vsyscall-mode-none/net_l2tp.sh
* kselftest-vsyscall-mode-none/net_pmtu.sh
* kselftest-vsyscall-mode-none/net_psock_snd.sh
* kselftest-vsyscall-mode-none/net_run_netsocktests
* kselftest-vsyscall-mode-none/net_tcp_fastopen_backup_key.sh
* kselftest-vsyscall-mode-none/net_test_vxlan_under_vrf.sh
* kselftest-vsyscall-mode-none/net_udpgro_bench.sh
* kselftest-vsyscall-mode-none/net_udpgro.sh
* kselftest-vsyscall-mode-none/net_udpgso_bench.sh
* kselftest-vsyscall-mode-none/net_xfrm_policy.sh
* kselftest-vsyscall-mode-none/pstore_pstore_tests
* kselftest-vsyscall-mode-none/rseq_run_param_test.sh
* kselftest-vsyscall-mode-none/rtc_rtctest
* kselftest-vsyscall-mode-none/seccomp_seccomp_benchmark
* kselftest-vsyscall-mode-none/timers_set-timer-lat
* kselftest-vsyscall-mode-none/timestamping_txtimestamp.sh
* kselftest-vsyscall-mode-none/tpm2_test_smoke.sh
* kselftest-vsyscall-mode-none/tpm2_test_space.sh
* kselftest-vsyscall-mode-none/vm_run_vmtests
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
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
* kselftest/bpf_xdping
* kselftest/firmware_fw_run_tests.sh
* kselftest/intel_pstate_run.sh
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
* kselftest/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
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
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/net_xfrm_policy.sh
* kselftest/pstore_pstore_tests
* kselftest/rseq_run_param_test.sh
* kselftest/rtc_rtctest
* kselftest/seccomp_seccomp_benchmark
* kselftest/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh
* kselftest/vm_run_vmtests

qemu_arm:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_hashmap
* kselftest/bpf_test_kmod.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
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
* kselftest/bpf_xdping
* kselftest/cgroup_test_freezer
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
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/pidfd_pidfd_test
* kselftest/proc_proc-self-map-files-002
* kselftest/proc_proc-self-syscall
* kselftest/pstore_pstore_tests
* kselftest/rseq_basic_percpu_ops_test
* kselftest/rtc_rtctest
* kselftest/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh

x15:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_hashmap
* kselftest/bpf_test_kmod.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
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
* kselftest/bpf_xdping
* kselftest/epoll_epoll_wakeup_test
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
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/pidfd_pidfd_test
* kselftest/proc_proc-self-map-files-002
* kselftest/proc_proc-self-syscall
* kselftest/pstore_pstore_tests
* kselftest/rseq_basic_percpu_ops_test
* kselftest/rtc_rtctest
* kselftest/seccomp_seccomp_benchmark
* kselftest/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh

dragonboard-410c:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_kmod.sh
* kselftest/bpf_test_lpm_map
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
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
* kselftest/bpf_xdping
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
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/pidfd_pidfd_fdinfo_test
* kselftest/pidfd_pidfd_test
* kselftest/pidfd_pidfd_wait
* kselftest/pstore_pstore_tests
* kselftest/rseq_basic_percpu_ops_test
* kselftest/rtc_rtctest
* kselftest/timers_rtcpie
* kselftest/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh

qemu_arm64:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_kmod.sh
* kselftest/bpf_test_lpm_map
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
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
* kselftest/bpf_xdping
* kselftest/cgroup_test_freezer
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
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/pidfd_pidfd_fdinfo_test
* kselftest/pidfd_pidfd_test
* kselftest/pidfd_pidfd_wait
* kselftest/pstore_pstore_tests
* kselftest/rseq_basic_percpu_ops_test
* kselftest/rtc_rtctest
* kselftest/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh

qemu_i386:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_hashmap
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
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
* kselftest/bpf_xdping
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
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
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
* kselftest/net_tcp_fastopen_backup_key.sh
* kselftest/net_test_vxlan_under_vrf.sh
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/net_xfrm_policy.sh
* kselftest/proc_proc-self-map-files-002
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
* kselftest/x86_ldt_gdt_32
* kselftest/x86_sigreturn_32

juno-r2:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
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
* kselftest/bpf_xdping
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
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/pidfd_pidfd_fdinfo_test
* kselftest/pidfd_pidfd_test
* kselftest/pidfd_pidfd_wait
* kselftest/pstore_pstore_tests
* kselftest/rseq_basic_percpu_ops_test
* kselftest/rtc_rtctest
* kselftest/timers_set-timer-lat
* kselftest/timestamping_txtimestamp.sh
* kselftest/tpm2_test_smoke.sh
* kselftest/tpm2_test_space.sh

i386:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_hashmap
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
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
* kselftest/bpf_xdping
* kselftest/firmware_fw_run_tests.sh
* kselftest/intel_pstate_run.sh
* kselftest/kvm_clear_dirty_log_test
* kselftest/kvm_cr4_cpuid_sync_test
* kselftest/kvm_evmcs_test
* kselftest/kvm_hyperv_cpuid
* kselftest/kvm_kvm_create_max_vcpus
* kselftest/kvm_mmio_warning_test
* kselftest/kvm_platform_info_test
* kselftest/kvm_set_sregs_test
* kselftest/kvm_smm_test
* kselftest/kvm_state_test
* kselftest/kvm_sync_regs_test
* kselftest/kvm_vmx_dirty_log_test
* kselftest/kvm_vmx_set_nested_state_test
* kselftest/kvm_vmx_tsc_adjust_test
* kselftest/lib_bitmap.sh
* kselftest/lib_prime_numbers.sh
* kselftest/lib_printf.sh
* kselftest/lib_strscpy.sh
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
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgso_bench.sh
* kselftest/pidfd_pidfd_test
* kselftest/proc_proc-self-map-files-002
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
* kselftest/x86_ldt_gdt_32
* kselftest/x86_sigreturn_32

hi6220-hikey:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_bpftool_build.sh
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_flow_dissector.sh
* kselftest/bpf_test_kmod.sh
* kselftest/bpf_test_lpm_map
* kselftest/bpf_test_lwt_ip_encap.sh
* kselftest/bpf_test_lwt_seg6local.sh
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
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
* kselftest/bpf_xdping
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
* kselftest/net_udpgro_bench.sh
* kselftest/net_udpgro.sh
* kselftest/net_udpgso_bench.sh
* kselftest/pidfd_pidfd_fdinfo_test
* kselftest/pidfd_pidfd_test
* kselftest/pidfd_pidfd_wait
* kselftest/pstore_pstore_tests
* kselftest/rseq_basic_percpu_ops_test
* kselftest/rtc_rtctest
* kselftest/seccomp_seccomp_benchmark
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
------=_Part_8387_90588155.1571461397251--
