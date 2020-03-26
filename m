Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D1C193C75
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 11:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgCZKA1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 06:00:27 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:53396 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgCZKA1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 06:00:27 -0400
Received: by mail-wm1-f53.google.com with SMTP id b12so5765543wmj.3
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Mar 2020 03:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=XozM3UuWL4ZEukgfhXFQg1YZqddkNKooCzIL0t4ERLA=;
        b=E8N5lHW4hpWuwfZCgzKTqjRN/qsaZ5LoqMvOU3JS+HCD1gxoaURx+ITj/pD4FacTlV
         CmBvDF6B1p+xHVfIm7lEPQxQmb37dwMiI+094Wwd9DyBdLIrgXfoCWcQYyioBk3YM8JM
         pmpyI/xdgYEdatZmypuvZrPFClVHs8voBMWYfkms+Dd6hGC1QM5EQ6mpwl5PLWtjvDhC
         vgtIEnqyP3Lc/PTBYFD/NraFdjHXSh2p7opKkvx+3UzXzxCCmiXh+Fq0vPHHwOBMeCRW
         guDHAnXKU4IPHS9L0uC/h2dXo7LBkIWxYIHY5FnRw86UnYdqRV1bXkGHszJKHM/JVAF3
         qGHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=XozM3UuWL4ZEukgfhXFQg1YZqddkNKooCzIL0t4ERLA=;
        b=RibawMkrgtoTnHn00KsVgNwMXF2AjGfwsFm+kQ5duXAxV1qjaknvSZ1Fc3Mp0Oav+A
         VfNGgQb/jksEPOEhfcfiR6kLcRkDZtDvQry7cS0I/ubRT+0hOTp/0aTCy+sa1o3yj91A
         yxnC0FugiJSmZE1TvVECKt93Uux6zMM1sRD665gWSOkqXD9rD7iw0kVOkHlVCm7ais2N
         hrSPv3VxSVeuPzBgsIC76CaiXheplZ1hLi+WvvrGZIEb2ryPVFFO3E216IGwRllLrd17
         VaXJYxLulKF3SN3KQFZVd84NaJYHiv1lobIEclNZe+KOdpyaQGDHGzhZucxuJyN/UDpl
         BBFQ==
X-Gm-Message-State: ANhLgQ171WSA+8ytHW0sU2ouw6nu6HdiAH84XwU8eYcM2j4q0x/KhVej
        TkNhszF1IkLrRLC+6g5r/UWSWA==
X-Google-Smtp-Source: ADFU+vtxWAe1JhBWKuWzJ6fIKliGI11RU2QzbTvV8Q1kffrJE5iJyXjrlAL6+14pbjKPmh4XQhWA3A==
X-Received: by 2002:a1c:ba06:: with SMTP id k6mr2189932wmf.136.1585216823920;
        Thu, 26 Mar 2020 03:00:23 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id d21sm2842088wrb.51.2020.03.26.03.00.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 03:00:23 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Thu, 26 Mar 2020 10:00:22 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <2112107488.11934.1585216823454.JavaMail.javamailuser@localhost>
Subject: next-20200325 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_11933_363244824.1585216822881"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_11933_363244824.1585216822881
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0-rc7
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: bfd7a248502373da8b1c8eb0e811fdb19cc3f8b6
git describe: next-20200325
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200325

Regressions (compared to build next-20200323)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200323)                                                                   
------------------------------------------------------------------------                                               
No fixes

In total:
------------------------------------------------------------------------
Ran 0 total tests in the following environments and test suites.
pass 0
fail 0
xfail 0
skip 0

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- x15 - arm
- x86_64

Test Suites
-----------


Failures
------------------------------------------------------------------------

dragonboard-410c:

x15:

hi6220-hikey:

i386:

juno-r2:

x86:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_11933_363244824.1585216822881--
