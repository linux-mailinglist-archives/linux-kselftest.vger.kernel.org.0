Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B20CB4B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2019 09:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbfJDHA1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Oct 2019 03:00:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54240 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387820AbfJDHA1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Oct 2019 03:00:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id i16so4550626wmd.3
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Oct 2019 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=w+YhATWxQp3QBmlrt7KEz07gaaTo8Qb8bTf9I4uOB0s=;
        b=wXHaxWBz2jINfRDTlkiAHxpiaX5JqnGr48NPo5kRil5ElXOMWIyEe3hNIckpqNOFTJ
         1kF+nzfD/V0n5SjD1X8GzsFNK828s3XPSE3NTg3Zbrwz7V+5CLqH4ChFRuoTpxwpAyFg
         V04M1Iqm7/Cdla0GdKX1jCAWyx5ltzcNiBFZm+lHDbDuFNWVrEBsuJ6PXLv5zwYrjHh+
         ZR7YD2BbTjirPxWHrQPXBMY13qPSqb48+jRl6PSc+qGLwdoN9dqB8uYi9lwx33tFwv+s
         7jgUQtLvWY5AXHm8MmF5e6XupffPBCstKiAxIrCrS5BdsHvYhmdJDY8wTfx6Xhn9onmT
         jr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=w+YhATWxQp3QBmlrt7KEz07gaaTo8Qb8bTf9I4uOB0s=;
        b=jWWS54GUgs8sDT5Yc/i6SKSg/QKuxQBz8uf9dflK92P1Ww+XQdcYec4JmAEWj2ivkd
         clcvl3VnR4knP/Ahiwh2ppA5Kqwn5pKG9qAP0O0dU16AmIB/Qi3iqF7aDpYuCSqblsZp
         jgbT2GzeH5QzsRur6J1zrZvKNbPmlYJ8DxoPZhpJULmVJgsDDJUuIiCEGveSgnTZJpi3
         2JzKwN2SB3xOauBMzwcjJB04w+VDmoyY4Ew439kEy9WXIDfkhnf+jveDtzJH0BgsL167
         dEwkVMY9TDb2XnPjjHhKWRu8ScjyM6oLzekuB4+Xaz6Cjv8zvVt7Er03JB4cXTtBd/MU
         kQ5w==
X-Gm-Message-State: APjAAAXXD/2vRbwCUPYWm/YHxeZDs4zvboVUAPQEz3/jj4YtL93tBuoj
        Op8ggfBXA0Op09PEycoPGgtf9A==
X-Google-Smtp-Source: APXvYqxUNDhAGiVlC6RRLORsYiGzI+KUDXODClh+HNrnK1Jei1cBEkb7KJQw6Li+Rfqc1pmseSQl9A==
X-Received: by 2002:a1c:1a4b:: with SMTP id a72mr9570770wma.44.1570172425250;
        Fri, 04 Oct 2019 00:00:25 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id r27sm11584106wrc.55.2019.10.04.00.00.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Oct 2019 00:00:24 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Fri, 4 Oct 2019 07:00:24 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <772759105.5040.1570172424644.JavaMail.javamailuser@localhost>
Subject: next-20191004 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_5039_1365586500.1570172424012"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_5039_1365586500.1570172424012
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.4.0-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 311ef88adfa3b69c40234bf3000d1269e718919a
git describe: next-20191004
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191004

Regressions (compared to build next-20191003)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20191003)                                                                   
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

hi6220-hikey:

juno-r2:

i386:

x86:

x15:

dragonboard-410c:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_5039_1365586500.1570172424012--
