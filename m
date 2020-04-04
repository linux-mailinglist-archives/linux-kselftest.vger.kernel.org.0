Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD0C19E50E
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Apr 2020 15:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDDNA3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Apr 2020 09:00:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35744 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgDDNA3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Apr 2020 09:00:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id i19so10832677wmb.0
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Apr 2020 06:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=berZkpm+xZN9rWHrfeTdU6uWbeANgWBvDoGpF0iCCKU=;
        b=fU6T64H4zURc5z/WKFLlq1iJuRO9l1z5LR8X4xxTLOLXmb8DQ0wPtMljpEIlRfnndz
         M0QMUdhAq4iGg2lp7FG7GS7z6jimd5tVeUJgC1NKcPfMgxTK55NYDyr9Sh3VVbzWIc5s
         Y5XiwNvU5L9xRaVWDk7X4gOqGVLD5po5eNjPYkRodH55bgYbqVrdeILFwC8Pzj6TX/zQ
         GnkeVXXOoZ44619nOrH9a/cmeW54rS+3yhCvsyobVgJFg2ZxbHc84G2XEvf+KWgWfdbs
         AHAMd9vKtpCfmdFUr7iwT6fjccDLxCxEAp+dvrZMF/GbPl+TsvpYB6El8Qv7/0cSE2l5
         cPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=berZkpm+xZN9rWHrfeTdU6uWbeANgWBvDoGpF0iCCKU=;
        b=MD2Z8+6pEHTuhfpm2ef3UBdFhe2fvSkkZnbksBSHfmFfrcwktrSW4iwh/UsR4FmbY1
         Aw2cr8LbtaBaqYoLwqcUz5SdkVolwH7k5a9II+dEK9y97iLyxVp2D1ApFy7fDTUBV6sJ
         Lb34M4IJW11e3ltGramCxODVsPRYXLbYNIUr8eTS0m8L9yuFoIr9YX34jmB2+B8uiUm4
         RnTggJLop/TtQMlFZi/mBxT+VcX+NmCYHzuQLh+1IdGUcAjDFpIrGXGyAxnxxr3Gmyk+
         eGabPoOAmGpZuuK6jkoFdNLVhSiWOJx7j6U/Z1HCf8z6YMd7ywoQB0nzumK2bwE7rdYT
         KaNw==
X-Gm-Message-State: AGi0PuYxzqh0yeCgctIb0avqVXUE7gKCRwCJMHzcoNJTJR750nfrqK+8
        w0ZyB4H2heGUJSAWFuNmTOe6ag==
X-Google-Smtp-Source: APiQypIzFQzu1cNQm5lv3zem1H5E+RPR4eR7nu6Zw+jJVp5TceexU04+PTYu5gA2RMvYq+mqrKkuhA==
X-Received: by 2002:a7b:cc07:: with SMTP id f7mr13905984wmh.126.1586005227870;
        Sat, 04 Apr 2020 06:00:27 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id w15sm6170666wra.25.2020.04.04.06.00.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Apr 2020 06:00:27 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Sat, 4 Apr 2020 13:00:26 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <1144649323.14315.1586005227285.JavaMail.javamailuser@localhost>
Subject: next-20200404 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_14314_1846022831.1586005226699"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_14314_1846022831.1586005226699
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: dff79597431045a775f2e5d4d9de31bfa0d32a34
git describe: next-20200404
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200404

Regressions (compared to build next-20200403)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200403)                                                                   
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

i386:

x86:

hi6220-hikey:

dragonboard-410c:

x15:

juno-r2:

juno-r2-kasan:

juno-r2-compat:

x86-kasan:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_14314_1846022831.1586005226699--
