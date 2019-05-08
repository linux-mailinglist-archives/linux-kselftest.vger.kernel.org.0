Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C4E17464
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2019 11:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbfEHJAm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 May 2019 05:00:42 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39611 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfEHJAm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 May 2019 05:00:42 -0400
Received: by mail-wm1-f45.google.com with SMTP id n25so2191109wmk.4
        for <linux-kselftest@vger.kernel.org>; Wed, 08 May 2019 02:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=htmXpdAkcixI8yKMpYPGZKFPJcoHE+5ylYsuDlqi7KU=;
        b=fiFJBuIiQW76bfl8mnUqpHnEqV2O5zLwfkxYM0q1/VGOC4IrXvuaA/sWqPKc2ylg2k
         hC2NblSyuUx8d/uCnln0pk/1v5vORoezI1mQQoc3AnTt8rbxryj4D5r0Az/LUWuEv2gu
         lqPGVKZxuHkLZfbFufN5v0dRTyIUbbtwDTVIn9J2soV7SsS0LWkApIK+3Zhr3x7Svphp
         W+RisAJFqO/u8Hw4PoBSOrL4QlA8tsG/2Roq8SRUpTe1mWev+JxKDftavc7IeL4aghb2
         QLO5vWezmOcd2lT16fhfcQ2+V2F7lmGXBYTL6CGo4bBHmWp2pLYjrGfoVHo4xDqZ7A4M
         ccww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=htmXpdAkcixI8yKMpYPGZKFPJcoHE+5ylYsuDlqi7KU=;
        b=rW3otox5lEzAYk9pppFAU8n09ula6WC7+H0bukSmg64A9I+v2EpXlhgycXPYALiole
         MXIcDJXeJcDgDF+Hfl2f5WBnMnDrxHgPzN6ekcfHsHZS/bW3iAjrYdTZsSCfOvo55u/C
         IxIEGm/aD4R3Hx4d4XPdor78s+4Z3okY2NqXueyJQ4FraQU8nYQaX41HnhY2n0mz5BYz
         T5nccMO4pAIDZc5y19KI6QrV1tIx9MyKG0UfXWGCYqOoTPisNEVycAHe0UzeP8nAhJmJ
         8VY1E4X45W+C494vdpvOFpvcu59IQuhBKfgeVEbrMihd61rNR3F6RbcHr+CDy+TrU5xx
         jQjA==
X-Gm-Message-State: APjAAAX8ypS0FkemwZ2k/Kf/4DBrlt+LiAMb+WO9nTQ112J2/FvF7jc/
        Yr+y9Q/lrKs71G2jXgpCj2z9n92nkd0=
X-Google-Smtp-Source: APXvYqzwK1AXHmyEaQEwBe4jHPnKP+20y41RuDCX2oWq9h+S//BlOZcJN1HiibZGLbhasNsACkVZ5A==
X-Received: by 2002:a1c:3cc2:: with SMTP id j185mr2229244wma.26.1557306040902;
        Wed, 08 May 2019 02:00:40 -0700 (PDT)
Received: from a6c5c67cda76 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id p13sm2368443wmb.0.2019.05.08.02.00.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 May 2019 02:00:40 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Wed, 8 May 2019 09:00:39 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        linux-kselftest@vger.kernel.org
Message-ID: <1723788338.17782.1557306040400.JavaMail.jenkins@a6c5c67cda76>
Subject: next-20190508 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_17781_1962305424.1557306039996"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_17781_1962305424.1557306039996
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.1.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: unknown
git describe: next-20190508
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190508

Regressions (compared to build next-20190507)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20190507)                                                                   
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

i386:

x86:

x15:

dragonboard-410c:

juno-r2:

hi6220-hikey:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_17781_1962305424.1557306039996--
