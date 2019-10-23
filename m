Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84335E11E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2019 08:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbfJWGAt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Oct 2019 02:00:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35179 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731266AbfJWGAt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Oct 2019 02:00:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id v6so1309003wmj.0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2019 23:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=K/eoMfXzfINmMI+MvhOhnOityXb0tDhX10k2Mtpt4nc=;
        b=gEfXD8D0CRgLt6dbwE0phE6FBDEr8coISZ5Xz5TeNm76k94tICdxxMyNWVi9qAyysW
         mxpO6OMPsMJ8S3/rFtbJwDACfJdecYJTUgOH3h37i18plGUZpw0kkuUpJ0aNS/DTMEya
         NM008llKas40D+JzGAeiL8BFRehOHqfGCM/+w4EP9NFvqYxAWac5lG07Eoh9t1NmHXVm
         FLSJxzD83+L6+9NZmbK3eYjwjPze94zFcvQRwRK3m7N5gV+ubiQBe80Or59MvrKT3Rz3
         YHBUxJ2H4N7drXS4EooFWDk3eQPzJljjKk4Zk1AG47YUUxmiM5cFCDZwcW/Wazva8cbY
         U26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=K/eoMfXzfINmMI+MvhOhnOityXb0tDhX10k2Mtpt4nc=;
        b=dLrfn/YV3fa4nTc0hvIL3MrhvCTbbHKFXnEis0GbOgfFioArAgtd8FuePAI1IgZOYr
         TImsCIphKjknZgcgc2JfYdGKuhTQfInR8thDO065uj3t/khYJ/DbLPe6u2/scCVYbWtV
         kfmjMzgkZr3kjynx/EdxgEToHtq4RMmgzBCod6igonr0qhF3GADGFssw6swYkjQ7apmJ
         fWhn1iNeVU6vY7a8Zra1xUAp16B8ycAfxNTuYWfpqB+LZuRf9yeDZoCOiLirnth9ZB6Q
         nMyARmd1fKvd4u4RQ2QRxrFmcs6G3TcPkhrKc5oChPLZitUEnoFn9C6/QliMOEud4Z4o
         11uA==
X-Gm-Message-State: APjAAAURj3UBoY7f4iFzqLajzYKzjkCDU/HvWHj9FDq48cxb24zqjJdE
        hFLbZ98+qLyuL97DyVslR08pdjOueJk=
X-Google-Smtp-Source: APXvYqwkBsjFmSZbZvkx2ze9XhViVvjBosYKU06OnkncSebH21erImDQuD6UnP6OnMnlQaFswYdaqQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr5902158wmi.43.1571810446655;
        Tue, 22 Oct 2019 23:00:46 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id w17sm18220004wmi.30.2019.10.22.23.00.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Oct 2019 23:00:46 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Wed, 23 Oct 2019 06:00:45 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <129659379.10244.1571810446022.JavaMail.javamailuser@localhost>
Subject: next-20191023 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_10243_416611622.1571810445217"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_10243_416611622.1571810445217
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.4.0-rc4
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: f3c452cfc59c817950b150b51ec2b33409d7640b
git describe: next-20191023
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191023

Regressions (compared to build next-20191022)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20191022)                                                                   
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

Test Suites
-----------


Failures
------------------------------------------------------------------------

juno-r2:

dragonboard-410c:

i386:

x15:

hi6220-hikey:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_10243_416611622.1571810445217--
