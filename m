Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC0DF1945F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 19:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgCZSAe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Mar 2020 14:00:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32829 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgCZSAd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Mar 2020 14:00:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so9043437wrd.0
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Mar 2020 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=IGULUYpzMGusH01Af6yW0ZvhDTOzKMLH2JJyzyrtC6A=;
        b=NFoplFRrnwUFOhs6HJy8T8YIgOk2VjaosP3n8Wv1V1gTtAubKmOM9IlLwOWJ0aeExG
         g69kiATIqkmYm2YI3C4pJMZYbL2VWlmKbXKJO/nDU2DgaKP+rPzJlEo2b8j/90zBydTK
         FvvvDTV0JVJvVm9DO+AX8shcvHWfgQGhOB2hfsueXn28ZfXNpfzpqewitqwWlACJ68Gi
         cROD0AfS5B3SPp82mPcUDYtrfM6hl35qPzFXY889CYFBNV8GjroOsyLAPPXME9Fhmtmb
         bl+gwheZ8Ll/0BDcpQBG4J2FOsf1g9kL3fWFcVYoMbGB6x5iOQHJmotKJwup1Ao6d2h5
         yWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=IGULUYpzMGusH01Af6yW0ZvhDTOzKMLH2JJyzyrtC6A=;
        b=eGJua7c4Y9t5maet0unLNQN2r9X6gtHrg2AY1MRdj+jrqCT5Cm5tnsdIst2Z2DcqEb
         e+CJ7o7C3lDmbP1lYVv5Wti3ZFS17U+KVlcGSsxTPF9IM6O5MBNzNCnDjt4AOQS1KQd1
         gv5DM6JjYfkc+IGBVTI2M0Q3HaUhvFrOyOxcwBOiKyDXTDEFKQNytftG6xYXRG4xQ0mg
         Ti7OKFs239ujMC+/oJ4KcsjErhG/BlDw9tsuioNvzMyhzxmFNOENhBcWLDnFMGxIxEgE
         +uhRy8M78W2oqaiSnr2YzyNv9f3XdIAygg5brvaE09+SnCZlbCr58Vlszv0Ixpq7xfrP
         PySA==
X-Gm-Message-State: ANhLgQ0/gui8haHzNYPYx47CipzQL+2QMCsD34vM0ywwxTqyRhImkgKj
        o3rejnaZPpYsyltPOE9DonJqLA==
X-Google-Smtp-Source: ADFU+vuTuzSPYUE+FoKI2M4/mFPg1ZSvAPX06lQgP6Zb3F8KSisjaBiHXtXf1jC4TR5KRaSQLQgmLg==
X-Received: by 2002:adf:a319:: with SMTP id c25mr10512296wrb.197.1585245631971;
        Thu, 26 Mar 2020 11:00:31 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id x206sm4523916wmg.17.2020.03.26.11.00.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 11:00:31 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Thu, 26 Mar 2020 18:00:30 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <891018657.12028.1585245631463.JavaMail.javamailuser@localhost>
Subject: next-20200326 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_12027_118598805.1585245630471"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_12027_118598805.1585245630471
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0-rc7
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 89295c59c1f063b533d071ca49d0fa0c0783ca6f
git describe: next-20200326
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200326

Regressions (compared to build next-20200325)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200325)                                                                   
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

juno-r2:

juno-r2-kasan:

i386:

juno-r2-compat:

x86:

x86-kasan:

hi6220-hikey:

dragonboard-410c:

x15:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_12027_118598805.1585245630471--
