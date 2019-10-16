Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 549A4D8C0F
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 11:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbfJPJAs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 05:00:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53333 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbfJPJAr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 05:00:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so1982683wmd.3
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2019 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=riyS0tjaVTKBC7tGImAeAxSE/Rtud0PmGoDTgcNDTXk=;
        b=ctFILknA65DDYlr7L1psSrexaeqE9zQR6iJhQZmvJb0ZWhLcugmFfWrEMNNh1G6Gjg
         4CTA/o97QU8zNjX7WgJS2FVm6MCcMknBjGjd5rHqll7B0XZCVE+LDWbwTlAVwo8dU306
         3uJMFoHjMTEQIv0Lutt41aYj0mK6lWRECS+8/OYM9st2Opqrj9prywmMc5drvuGQVuuI
         mD9dBqiUxkOYaxWgEkQqFKhx2+K8/xpLYVf/esAOVFuvvgBaZXk94WWaXTUGVV+k4kgL
         krXccmfHu2Ts3rvHTAGVl8wuOl5jQb35fIZOhnGu1OCY6SNZFMP8u/bPfcOQ7VeDBy2S
         ekkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=riyS0tjaVTKBC7tGImAeAxSE/Rtud0PmGoDTgcNDTXk=;
        b=BRvWUJzGx3R4OZZO++S5Gm+udNRlLp/1zXVigA9U8PMCiCKxu0iyhmDulFo1xLKh5G
         WZ/13DygcyO03HCnN4nzROA2vEcgrh5wg4TIPon0o8y8XYF3VSa71qXAcu9+J57DV8ah
         25ko927uULAZnlI+Jsv/EVDEGVGifTttrp4BOyVyYTWEpj4PP8tVBsTaByeDkGKhEbkz
         Lb3KJV1/NeWd9G6oWBF5pVvI3XSPfU4/OITdBm9t8OrdZyCeUXHok5Uo0bmnIkxJ5nqj
         5dotPVbI2fMv0XLg6wyBcGBnuCPLMBO1whyQtp1KGvT4oW4N2bhrZMhctEiD+MjJ0aBd
         qfiA==
X-Gm-Message-State: APjAAAXR9Q9uaWe1tUr4kc8vimE9sfF6xvEPvTe573B3OdUQ+cedV87c
        FEXes7eGF/zNq6w3wXxTiknubg==
X-Google-Smtp-Source: APXvYqx9CVM4fnMyCTrOoyf6ETXmXUNMShh5VapDkvLXiqLiGZdbtzSlzOlTtVAEXLuzyIwiLsRbsQ==
X-Received: by 2002:a05:600c:2489:: with SMTP id 9mr2286649wms.23.1571216444693;
        Wed, 16 Oct 2019 02:00:44 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id c4sm23902217wru.31.2019.10.16.02.00.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Oct 2019 02:00:43 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Wed, 16 Oct 2019 09:00:43 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <1958288036.7598.1571216443775.JavaMail.javamailuser@localhost>
Subject: next-20191016 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_7597_1116154851.1571216443255"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_7597_1116154851.1571216443255
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.4.0-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 78662bffde37ccbb66ac3311fa709d8960435e98
git describe: next-20191016
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191016

Regressions (compared to build next-20191015)
------------------------------------------------------------------------
i386:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_sock                                                                                                         
x15 - arm:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_sock                                                                                                         
qemu_i386:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_sock                                                                                                         
qemu_arm:                                                                                                      
 kselftest:                                                                                         
    * bpf_test_sock                                                                                                         
                                                                                                          
                                                                                                                       
Fixes (compared to build next-20191015)                                                                   
------------------------------------------------------------------------                                               
No fixes

In total:
------------------------------------------------------------------------
Ran 159 total tests in the following environments and test suites.
pass 71
fail 88
xfail 0
skip 0

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
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_sock
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_tcpnotify_user

dragonboard-410c:
* kselftest/bpf_test_lpm_map
* kselftest/bpf_test_maps
* kselftest/bpf_test_progs
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tag
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_verifier

x15:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_maps
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_sock
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tag
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_verifier

juno-r2:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_maps
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_sock
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tag
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_verifier

hi6220-hikey:
* kselftest/bpf_test_lpm_map
* kselftest/bpf_test_maps
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_tag
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcpnotify_user
* kselftest/bpf_test_verifier

x86:
* kselftest-vsyscall-mode-native/bpf_test_maps
* kselftest-vsyscall-mode-native/bpf_test_sock
* kselftest-vsyscall-mode-none/bpf_test_maps
* kselftest-vsyscall-mode-none/bpf_test_sock
* kselftest-vsyscall-mode-none/bpf_test_sockmap
* kselftest/bpf_test_maps
* kselftest/bpf_test_sockmap

qemu_i386:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_maps
* kselftest/bpf_test_netcnt
* kselftest/bpf_test_progs
* kselftest/bpf_test_select_reuseport
* kselftest/bpf_test_sock
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sock_fields
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_tcpnotify_user

qemu_arm:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_maps
* kselftest/bpf_test_progs
* kselftest/bpf_test_sock
* kselftest/bpf_test_socket_cookie
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tag
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_verifier

qemu_arm64:
* kselftest/bpf_get_cgroup_id_user
* kselftest/bpf_test_lpm_map
* kselftest/bpf_test_maps
* kselftest/bpf_test_progs
* kselftest/bpf_test_sock
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tag
* kselftest/bpf_test_tcpbpf_user
* kselftest/bpf_test_verifier

qemu_x86_64:
* kselftest/bpf_test_dev_cgroup
* kselftest/bpf_test_maps
* kselftest/bpf_test_progs
* kselftest/bpf_test_sock
* kselftest/bpf_test_sockmap
* kselftest/bpf_test_tcpbpf_user


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_7597_1116154851.1571216443255--
