Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E0719A6BC
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Apr 2020 10:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbgDAIAb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Apr 2020 04:00:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44758 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731849AbgDAIAb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Apr 2020 04:00:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id m17so29307683wrw.11
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Apr 2020 01:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=Gh40KHFAhrNR0dJOplyaDGb+kgiEPAdDycNEX+B0l4I=;
        b=jzcaMXAY32zAxKLyUpaSnCv8pwE1HjvqU52Kx792caOD8noOxP5uBghQmnCJDfNo7T
         I8cFDdRcaRpAWzH3czYPrz9sPy7aV9bU/j+5SvbGieWxfXN/C6qDrl4MPx64KY4hStnD
         ZCP8f/nt/9UtNoDFdowH34L7ccNwHC3o8JxnQneRZGnZIn/3Uwi/z0/UIrUUEa119sM1
         cncdpO6opdCqWrBULwT2G/yUJgmBljmXsQ9lYqHQPVFqc5nm/Mn3CfhmdGztvB6YObAI
         3NjOswvSpPOJllVQJw6m4QNZv33AiCd7mCGtjJU148CpfXzvBCurwLeLg4KgiT2FaSJ7
         sK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=Gh40KHFAhrNR0dJOplyaDGb+kgiEPAdDycNEX+B0l4I=;
        b=HXmXx880bazLPut4xKcaUgMHTHTRrbvOMQsqB8uIig4X3dWzVd8VDOFTNj4I9OxLbg
         cxfhHHAZo0ECainx9pfo+Q05AbTCl4hYikm50pf04Hpe9uU35jH31cZC/ngGYJ/AkxBZ
         +BUrZ9PHj8nQSp5NRUFEc75vhO3hQlo3EMQIFQeDQEgODrgW95VV2tKIU3RIj1detqzw
         gzlRUCNtVtZTC2pCCic2cPzbAtewXPP0puPytOp63w5CQUK6XT5Fjm+kTRtmdzHrxfj8
         yCIgZIG4CK4ZX3ZVE284GUZ3OBOz7S0uO1m6zZPJ5hU6rYYkDbrRFiZhFdumaG+esqy5
         qJDQ==
X-Gm-Message-State: ANhLgQ00SZxw2kwOZmQk/4BQVI6Oi0WtLfzkGIA9IxnaGIo5QbBNOQrD
        dNboSo9F+i2zwlP1V6+3+PGoBg==
X-Google-Smtp-Source: ADFU+vs3evzbwrDgd7EO0Qhn7yHW1sJgvIupK6DKv49QMAKSLdriSqA+o5NRRF9aoehJtNPdVJfmGA==
X-Received: by 2002:adf:a54a:: with SMTP id j10mr25595001wrb.188.1585728029087;
        Wed, 01 Apr 2020 01:00:29 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id q14sm1080587wrx.57.2020.04.01.01.00.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Apr 2020 01:00:28 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Wed, 1 Apr 2020 08:00:28 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <1690622441.13596.1585728028573.JavaMail.javamailuser@localhost>
Subject: next-20200331 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_13595_1241886743.1585728028038"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_13595_1241886743.1585728028038
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 3eb7cccdb3ae41ebb6a2f5f1ccd2821550c61fe1
git describe: next-20200331
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200331

Regressions (compared to build next-20200330)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200330)                                                                   
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

hi6220-hikey:

i386:

dragonboard-410c:

juno-r2:

juno-r2-kasan:

juno-r2-compat:

x15:

x86-kasan:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_13595_1241886743.1585728028038--
