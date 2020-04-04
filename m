Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B684E19E400
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Apr 2020 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgDDJA1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Apr 2020 05:00:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38305 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDJA0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Apr 2020 05:00:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id c7so11305358wrx.5
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Apr 2020 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=r3uMoC07H5sblWWR/ulSmPyRD66/jfRT9oxj0LuJEDs=;
        b=VMa3DdJJN1HLPzh1qMZzXrh91XL4Q+aqYLLRm+vsD/sRxX+7teD0wGFV99+YNWVqVk
         Wec4VVy5cm1PKbv0caP4+YJANtF1M0kuAdkgU9KDBwK5gQ/MFkp0qPmenIfPG5DHIXPr
         vh408wTcMw8FfIKBXy516suuTSAsTIwJl2EH7KHSp/yFXsbUDWYsybsos0aY+isOtVEl
         TUwigeeHA0krkhxZgmttokVce0Zpfrbum9f9QbM9xMAd0pMDoHj//RFDXKeO/XKkNIie
         E8IkbH+WCQowTXoV6P+r3LwCMWo6W2zQ8dHlFejLIldjtnlmuhOpvxHi9T6F+hgoiORB
         c/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=r3uMoC07H5sblWWR/ulSmPyRD66/jfRT9oxj0LuJEDs=;
        b=LLMkc97xEwDRicLf4Bem143rpg+Xh9K8/Ll6oiVIeoIonCJXVwuhmmvHTfUYLC6Swc
         XdkhCrytqDG4WJ1QxbIf4lvggqSoXDXrDAKJ3Nj45THSR59n8IjQiNhpAZ3YmB0PhRzI
         6wUAW5TryR7LiBjrJPwS/Qa57TC/4eNsAz0BoQ8R+bfpLaLZaE9SeP0tuIPyGYrd99ee
         U0Rn3uBhaSk5Db+w18p64oBq903fhOvu1dACFAMQHpZeIxCUODZuuOdWFKVqeLBlUCTu
         VqcM/kSDSCibsXmNcL/6luX+3RoXRMY1N1mk0ig0stzQUc5aF3GeKjLr6fVsGxBmn4of
         7UOg==
X-Gm-Message-State: AGi0Pua9hrUp8LDTIXtIYhXUyF67h5xDWsmswqw42t1iaU0TbtmzggnV
        0weE0+ZURW8GlNZ9Z47cvlpZaA==
X-Google-Smtp-Source: APiQypJ195aJUdr5VHWLwIpMHJL2JmByNpbjHoDK7eenWtR552Z9QVlFxpoz/0OE4dBZgalYNgJKOw==
X-Received: by 2002:adf:f48d:: with SMTP id l13mr13678069wro.96.1585990824397;
        Sat, 04 Apr 2020 02:00:24 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id q9sm17888146wrp.84.2020.04.04.02.00.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Apr 2020 02:00:23 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Sat, 4 Apr 2020 09:00:22 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <467152629.14307.1585990823794.JavaMail.javamailuser@localhost>
Subject: next-20200403 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_14306_119811382.1585990822722"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_14306_119811382.1585990822722
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 606b5dac8e15e82e5866fa59e675ca6a6b7276c0
git describe: next-20200403
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200403

Regressions (compared to build next-20200402)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200402)                                                                   
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
- x15 - arm
- x86_64
- x86-kasan

Test Suites
-----------


Failures
------------------------------------------------------------------------

x86:

juno-r2:

juno-r2-kasan:

juno-r2-compat:

dragonboard-410c:

hi6220-hikey:

i386:

x15:

x86-kasan:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_14306_119811382.1585990822722--
