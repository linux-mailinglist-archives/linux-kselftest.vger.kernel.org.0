Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00C9D1A5D9E
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Apr 2020 11:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgDLJAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Apr 2020 05:00:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51806 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgDLJAa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Apr 2020 05:00:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id x4so6733501wmj.1
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Apr 2020 02:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=i7CrezMH1BB6PxH9h4jBxLFwO/aZ728RfGaUGfKcCxI=;
        b=etbOYA+KdLlUhaNVCY2d4ec6hq/iU6DGko7GIcF8tVoc0ocOczTj50nbMIFpXv8pMj
         R2WQudUgRetyKl7vC9SIF8Mt669iRSnkpGU/ETBbLTEqVJFaBuAY3Z7cTRt25W5Rt+cn
         Q1rwOq1rNL9wn8zVO6zGrK038EBwkDs6Eb0Pb11x1IzYvD1myltrDHFSSfV/VO0NVtPK
         7LTycbeiuwB/FILUUDaYOS2AfhXc3BGQ1zlfarMMVEuFRluotuJSyHtcLFNML3P9z0or
         Zls/p0CiCtTsO/OBZ4p0ilim/Wqe3McOfQEQQbXDGvFy+srFKjQx240lSJssy+a5PQQr
         WrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=i7CrezMH1BB6PxH9h4jBxLFwO/aZ728RfGaUGfKcCxI=;
        b=iRUztPazx8RlEsfSawInYJhSRG4c5VTIlG3/yrDoP9U58PM4VXvfJqMcSv2qL4GxJF
         jI5mPhIKwIy6anXDYcUHo7nEjLsRNJIXyGlzG5XBj7adutmFwLN++1cdZYVIVsFXMV+e
         1IOCDtCB6zK53YNmhTGOIWouPEq2mxb9Nm37y82kDA0FYaofLWH1yXBhUcq1fewHr3Cg
         vAUjxrZx4x86cfyJiMDNt7Jbo7gwVc1JJ7d4Pmpi0zY4nqIti9uf9TmtVHL7wdUjlVZk
         8zwTzs3IyoQlfHNR93bPDh2GRNhofp0ok1WzNaihYKSgnDtXnKxHbis66pb+ykxda7C+
         hhUQ==
X-Gm-Message-State: AGi0PubnHCd0lglrFjVbduW8kiIW2aFh1Z9YgjOrvnrM30uAHPaoNK8H
        htJByIZmyDBDamubAJvWkwCBluJnOSw=
X-Google-Smtp-Source: APiQypLYBUU5I32OIACHzBwOLZvgBK15eCSp/WvPkCEf6PU11EVslwYUfozWGxMaNzPJE3S7xWTCCA==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr13205553wmk.171.1586682029546;
        Sun, 12 Apr 2020 02:00:29 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id h188sm10320333wme.8.2020.04.12.02.00.28
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 12 Apr 2020 02:00:29 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Sun, 12 Apr 2020 09:00:28 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <1384417092.17074.1586682029011.JavaMail.javamailuser@localhost>
Subject: next-20200412 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_17073_1517993589.1586682028238"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_17073_1517993589.1586682028238
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: d2a22790db7075dbd0738d24d1c5ee4611421c4c
git describe: next-20200412
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200412

Regressions (compared to build next-20200411)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200411)                                                                   
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
- juno-r2-compat
- juno-r2-kasan
- x86_64
- x86-kasan

Test Suites
-----------


Failures
------------------------------------------------------------------------

juno-r2:

i386:

juno-r2-compat:

juno-r2-kasan:

x86:

dragonboard-410c:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_17073_1517993589.1586682028238--
