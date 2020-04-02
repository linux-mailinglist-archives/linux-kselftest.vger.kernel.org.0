Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D1419C0A2
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 14:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbgDBMA3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 08:00:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37876 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgDBMA3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 08:00:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so3895049wrm.4
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Apr 2020 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=ucKXgEi1vOsQqsbnW57o6FF0pZp/uz1iSAlKxoKqRDg=;
        b=ZJw0QIee9xhd85VEl3DTNDEoIpFo3vkXB7Rap/D/kW88yRYUjKTOWbQG3PD734FeHt
         ABeuGgFlNtGx9DVYfHMeMN0qkXGAhilJYq6XK9GKoxtXgFwcB9D/D3Xs2cFUHmB3Bsx6
         4J3Ur3oEyu2sDmmoi1nJGiPeLwd1j6eVx48/PHjt+4Nrkf8k5ljMTjZBd6W9e4oPKqOI
         I9I96Bwrk/mHrxkOTlCWwzge1v62oDOdkqj4vROTREX08sliBUyzMHxmItMD8E7q3Tjh
         2cLbRhx77yVad9mFVWzgITXoggHhyFgoKcIcyfG1HqTl4NZSnAJa7rSZRpWGmMMOL9Xz
         IKpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=ucKXgEi1vOsQqsbnW57o6FF0pZp/uz1iSAlKxoKqRDg=;
        b=TJQIUwuvFB9W3nKR2HBwSGzqLxKziieU3xiYO5smWhu8RMSLLjIIsXR/WgSKgROQdG
         5XDAR2zr1ZDBw3cwoyzdYfZo2lHUvA3gnUFPBV0hXERpZcdx+r5LKO7J7lRMeej++XKZ
         qS4dRzVG2K+0/6oNCy/OUX3oh0Yh4JoC07MIYN4TLbgGIDdXbfwEwEGfyoXCSb7acEKD
         RveEfLNrWP9uydwMw/XFtT7h664H5tNGtbxMeuR3F977bEJi/Fr0RdP0FcHxOBB86H5S
         aHkhnhI7R/kupvhy8KMMDAP9cugnguKWd1PSe2GI1HhFXAQ3qtwzTjiLxF1sI71bH9It
         yywg==
X-Gm-Message-State: AGi0Puaeejo00JEJq1x4vavJff26JbSrFl0IZglRJUpP1NXOhfmH22gE
        YCYQ3PzdSD6s0PrixFZhD7WL4g==
X-Google-Smtp-Source: APiQypJ09mltW50+QnglgAinK4tJeCk6Neqrv+PcBAn/irMOgGLeYPlnlvikkRhpOR1FigSh8q+2Cg==
X-Received: by 2002:a5d:6605:: with SMTP id n5mr3104353wru.303.1585828825440;
        Thu, 02 Apr 2020 05:00:25 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id y12sm4136326wrn.55.2020.04.02.05.00.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 05:00:24 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Thu, 2 Apr 2020 12:00:24 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <62428347.13888.1585828824624.JavaMail.javamailuser@localhost>
Subject: next-20200402 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_13887_378510905.1585828824035"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_13887_378510905.1585828824035
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 17f166b56b2583b97f0f6612cfbbb7f99e6889bb
git describe: next-20200402
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200402

Regressions (compared to build next-20200401)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200401)                                                                   
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

dragonboard-410c:

juno-r2:

i386:

x86:

juno-r2-kasan:

juno-r2-compat:

x86-kasan:

x15:

hi6220-hikey:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_13887_378510905.1585828824035--
