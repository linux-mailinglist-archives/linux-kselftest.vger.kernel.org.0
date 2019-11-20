Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D220E103724
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2019 11:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKTKA1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Nov 2019 05:00:27 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39443 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKTKA1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Nov 2019 05:00:27 -0500
Received: by mail-wm1-f49.google.com with SMTP id t26so7081330wmi.4
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2019 02:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=LlyF9kCpBLQgpmM0clbjcg+sWBpwQeV6xGzme+kf+4g=;
        b=BYnqicqs2I6ixrHXKOMArFvJXdHEan2pS2xu5x9TRrXzS0El+at1np1l5hlEliv89L
         6usTxGobZrC2bEfvspeY1RCbaxzSogc9KSZCjqZNpLPApeKRDIG3EkrRyHuDBsw9uYhe
         n+EZYXr7mfQCuAeQUwFOm3BQvSxNuGkqDzdu3P7sT8mVCWnOa90sk/tUqzgfz+lpu1Hg
         j30P7RuNnUvnbSW8900Iv6d7yN2EMQZjF5IXxflEhm+5iUc3v1PrLOG5K46MxK5lTf4Y
         ta/FOa2jKuPnrO/iWLl31+QxuugkIeNdjNPwUWk6GQuSqV1qmKpj3szyrRbAeHCs+E4p
         GyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=LlyF9kCpBLQgpmM0clbjcg+sWBpwQeV6xGzme+kf+4g=;
        b=HNUJYVWSixs+khJnQEsmSq4s/GAadoMRINC7qvTdStgdAoz8ilhZdlcaRhIQuPn4qx
         5b6rWL9a/L4WWkFFN7R9r8JuUvth9RCUWChswfGFQgiDNVQZJ/jxi75SHTv2G9JB9YTx
         nCmFoYSW+yJEtNHpvtc3kWM1cWD9y2slrhqU65xF4TDg1Y8gi70/C1pnHSkW2TFKkRg0
         af3FKmQpruSFmu8P5VOJI4JOttxBNufoRqWFKvOV9hq3PvXGW+ZL4kFI7mcp3uBsGQTp
         zSYwggOejWNR7dRLsEAv0j2xHivpHtYSM45W30iEpmzRfpNxJyG4YJymf/Mw+qSj0Ec+
         CmVg==
X-Gm-Message-State: APjAAAUlLJrd9C9Zx5vmFX2Jg1MvYnywgcnchiaSP04G/uv05LHftnAK
        laI7TC0Hr5/bbZ5vSITiHs7BnA==
X-Google-Smtp-Source: APXvYqyIY76v7UVRkuJJgHevZAdzeuyBg1mu84IqyMSW/U01en6a20ZWfTIF5NfI9C8bmbNZOTAHCQ==
X-Received: by 2002:a05:600c:299:: with SMTP id 25mr2210002wmk.50.1574244024897;
        Wed, 20 Nov 2019 02:00:24 -0800 (PST)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id w10sm5850290wmd.26.2019.11.20.02.00.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Nov 2019 02:00:24 -0800 (PST)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Wed, 20 Nov 2019 10:00:23 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <1236842353.1664.1574244024216.JavaMail.javamailuser@localhost>
Subject: next-20191120 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_1663_949038860.1574244023477"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_1663_949038860.1574244023477
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.4.0-rc8
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 1fef9976397fc9b951ee54467eccd65e0c508785
git describe: next-20191120
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191120

Regressions (compared to build next-20191119)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20191119)                                                                   
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
- x15 - arm

Test Suites
-----------


Failures
------------------------------------------------------------------------

x15:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_1663_949038860.1574244023477--
