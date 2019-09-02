Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7FBA5B9A
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2019 19:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfIBRA3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Sep 2019 13:00:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54079 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfIBRA3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Sep 2019 13:00:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id q19so6494715wmc.3
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Sep 2019 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=/4ulUCiUvCrs2k12tHx+x5ZufsyAbL+LphYt4ZcKfNI=;
        b=YoE7Os8w5zKzSPCOsqCMEwLEE6l8eWtfXbd5RgGWjdO0qYGmy8RkJaaR/GHZZBaQH+
         L6tE+14WOZJ6JwBnRKcm4az97/H6Udzwk0D/SzZ1yby7YLi4awDjVejKSp4oiVnSpCAK
         zOzlK9ls52Wj9FCIoPh8WEsCVM53lM3O7IeHcVqbHyakrAup2ijdqwlH2qWL13uRfMQ8
         MS/NOSs9CkOvS3gp5Y91f2mcdGK3ClJ7SSojrhYsf2xoembZ3khzaF6nAy38kbtGyefR
         OYZt+oBhhc/RyGxOpnzRNkCkopzVRL5V2PVyC272jSAso0xv6rqIeiEqodnn2QMOP+M+
         nPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=/4ulUCiUvCrs2k12tHx+x5ZufsyAbL+LphYt4ZcKfNI=;
        b=dobDkofqiv9CfKyTj6J+nYiXt2LhhvEtneTXC1mKR/Bhqtf6v6faswR3vo9rQn2OAg
         ffy4Iml/pjGioOsMuS40WRQ6e3HOP+piSVzn/67pEnKIoa0/83XwDmhI92hEfCOZPc7W
         6EI/hi3ZGGykRF1pXnbSjGCeAyrFP6TFNBsn+SNSFvXbZXr6NdvZuyD3qOQ0haWCyv9r
         aHD0sXNBMof6TfSGAwpFVUn+IOw8FqGhqvIQcebge8hMdnZ6EhgVIR9huZn9Xkf3Fs9T
         TonBGc6IeGJktG27mn436ATb1WHYkgtNOr3OuX6kQJvrEzabVbm7C29+G+Am8j5oj05w
         4bAQ==
X-Gm-Message-State: APjAAAWINCcuTkKsKJhITHKQRPeurO/Y3N4Y0JHEHMD1l00Gf1585i0v
        6PO6xfA9Zrh86Re4XNWU2xjjLA==
X-Google-Smtp-Source: APXvYqzMLVqx8fBi6uUzVSqIlMx2JSv/ydLTUXd7GeLb9oMMGU4T08vJmSrZIZ0FLxoq5hiJ3Kgjvw==
X-Received: by 2002:a1c:790b:: with SMTP id l11mr38038623wme.3.1567443626980;
        Mon, 02 Sep 2019 10:00:26 -0700 (PDT)
Received: from jenkins (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id w125sm33061964wmg.32.2019.09.02.10.00.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Sep 2019 10:00:26 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Mon, 2 Sep 2019 17:00:25 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        linux-kselftest@vger.kernel.org
Message-ID: <1965600628.3502.1567443626124.JavaMail.javamailuser@localhost>
Subject: next-20190902 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_3501_398652034.1567443625265"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_3501_398652034.1567443625265
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.3.0-rc6
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: b5f466091e130caaf0735976648f72bd5e09aa84
git describe: next-20190902
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190902

Regressions (compared to build next-20190830)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20190830)                                                                   
------------------------------------------------------------------------                                               
No fixes

In total:
------------------------------------------------------------------------
Ran 12 total tests in the following environments and test suites.
pass 0
fail 12
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
* boot-lkft-kselftests-master-597
* boot-lkft-kselftests-vsyscall-mode-native-master-597
* boot-lkft-kselftests-vsyscall-mode-none-master-597


Failures
------------------------------------------------------------------------

x86:
* boot-lkft-kselftests-master-597/x86
* boot-lkft-kselftests-vsyscall-mode-none-master-597/x86
* boot-lkft-kselftests-vsyscall-mode-native-master-597/x86

i386:
* boot-lkft-kselftests-master-597/x86

qemu_arm:
* boot-lkft-kselftests-master-597/qemu-arm

qemu_x86_64:
* boot-lkft-kselftests-master-597/qemu

dragonboard-410c:
* boot-lkft-kselftests-master-597/dragonboard-410c

x15:
* boot-lkft-kselftests-master-597/x15

qemu_arm64:
* boot-lkft-kselftests-master-597/qemu-arm

hi6220-hikey:
* boot-lkft-kselftests-master-597/hi6220-hikey-r2

qemu_i386:
* boot-lkft-kselftests-master-597/qemu

juno-r2:
* boot-lkft-kselftests-master-597/juno-r2


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_3501_398652034.1567443625265--
