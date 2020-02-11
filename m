Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B917D158877
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2020 04:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgBKDA2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 22:00:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37665 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727546AbgBKDA1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 22:00:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so10346797wru.4
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2020 19:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=m245zQYFHxH8WWp9ExPuUqaJ1SaKW+vA3x7eNxHC6ZE=;
        b=RXJ6f/jDHYhGYAPMgd3dXTOFZU7DNu+kTHEAouKxgFbQ84IYdgdwUCK5MMtxlwjMBb
         gDGbqM2yu9sBCSlVR/bHB1DPBM1eL2fyDMy0E1Zy5k68VtKunNxAHl1UsMexZ2MrYfmE
         4MQwIpj++eMsEIPVSoYTlMZFdUJGqq1dnFLEdaPcsfGnWongb1UndcjQ6Ki9HTLym6o5
         9tZNJjpg73jMOCsfMRqrUFktr34qtwQpXTmdwTWLhpwecQYKcQREI6BlDB1rggZBXRU/
         te5D12MZnRAHFHZd1Fv1jXKHAJb470+q2+WL1ix3i8W7WXEhxx29/85eQ36YXtOAdsSk
         B9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=m245zQYFHxH8WWp9ExPuUqaJ1SaKW+vA3x7eNxHC6ZE=;
        b=tM4ooDszwL+0ph0myln01nf2XeD8nyIfCkdZ4UokH71fkphoa0Lco53hCIUvWDQmhw
         9EajIIoTLsvL61kzj+rVrDlA23XZeInfDABzhClO4bMTE3TfTZdRvXEHWkWx772Y8u/1
         9NAHebT3Rb4ylLlpV/FcwwPgGsCgF74h+H48Tw+ko2/8OPGMu3dCfy7Cb91yvZe/eOxi
         z4utBFKXabpCJ3wZoqfuqX1NOhCHzXpaJS1KJA82tp/RHHwykqyuMuUymldOWRGFf8aB
         gsD9wcWi60MYxktq7YYNWlU79TVhAu/p7tPugstc4SeNIq8o5ilqydsfKKJOZkn98BvE
         QWXw==
X-Gm-Message-State: APjAAAVxflDlq7QiHnh92i0KpFxJfX6ljkDRz0rbQssPyjXHGKPErZyS
        SDkCrza+hRwapQQJhQVhFd1IIA==
X-Google-Smtp-Source: APXvYqw5d0Xv9ilg4y+Vf1H2PDY/LcEHGZq4svyf7HO4i1R7fbtdQ1sF4rWCp9gxAc9rCXJ4HPVi/Q==
X-Received: by 2002:a5d:62c8:: with SMTP id o8mr5354113wrv.316.1581390024799;
        Mon, 10 Feb 2020 19:00:24 -0800 (PST)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id y17sm3148157wrs.82.2020.02.10.19.00.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Feb 2020 19:00:24 -0800 (PST)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Tue, 11 Feb 2020 03:00:23 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <311133584.738.1581390024188.JavaMail.javamailuser@localhost>
Subject: next-20200211 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_737_1286540830.1581390023311"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_737_1286540830.1581390023311
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: ac431e2d7b1be81bfe58163b9f81ba79bc987dc3
git describe: next-20200211
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200211

Regressions (compared to build next-20200117)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200117)                                                                   
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

juno-r2:

x15:

x86:

i386:

hi6220-hikey:

dragonboard-410c:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_737_1286540830.1581390023311--
