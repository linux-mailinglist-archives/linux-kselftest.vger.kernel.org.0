Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDBAE2AAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2019 09:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404452AbfJXHAl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Oct 2019 03:00:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53500 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfJXHAl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Oct 2019 03:00:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id n7so606314wmc.3
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Oct 2019 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=ISIpkDySZkMMosxVaPTzsbDahq0wj6IWK4DX7/Ma8Aw=;
        b=uZXbRSM3xv8we0D3qQO7rnTJUVP72pAj2SHoccT93zx+Nsg7u9z/VbLa64uR6BSGnN
         6SBTa5RFFgFZhdO+SUdFqWS5CWT6B10q13gl/NGOGrpl6p03F+jNKer1tztWruUt0qIn
         jNBsU3iiDvX9Uk/cMdT62z62bEaRUd9YXqBBqWSOpOqOG5/MX313ioshyakaMduKNkFJ
         OnCNmZ22IRua4wRxckcp0IcZDZ5sYCtklvM5IB2y79xAQzDiE4yiElJrhP1gxLGCXQDk
         wF0sXK/Eo5sLShErBgjj/s/G5R+o0nRrrmietQJOw1b2sq2rEhFeZDjpwJCGUXl1GJLx
         LboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=ISIpkDySZkMMosxVaPTzsbDahq0wj6IWK4DX7/Ma8Aw=;
        b=O0XKtVz4+6M5+TZ4uBbkwLD7E7YfNxKe4+qgg/tqX9YTGWqi00lQb0nWSQJeqWwbdG
         pkm8xAf/Dgxixdya4K6alZdgRajPeHgjbC2acLcYsCoo37ORO5k/Rvyyg5norvOOLY1R
         CgzUQz+M/AFcvN9/Ptrmr+p5FpniTPqTIATGKtEw4grhotu+E//l/fTdK7GGR/XduvuS
         UcA3DAVC+ffy7owCyNQy6i7kscC5UL2bptO7dbVYCl0S6ISNplBXq8F7eurlgQuinTYX
         bVwpQeU7eFjFmVj9318Qvamczmrz3vckSR8BCdIxG3ZHElwI62lhvxQ3ocTpwXT/z+z+
         sXDg==
X-Gm-Message-State: APjAAAVMqLJzThK4kraYY533OwT+W9FSVCZsSL5Zc4+SuiNgHXZ715LF
        IBKRBsuF19viSwIC1WlMAZ0FDxuuxug=
X-Google-Smtp-Source: APXvYqwKP+CsXiVWzKvWM3d5NdP/yzFnr7vzQpD9Zfo8QzWTjBkdA3nfQTAVv+un0wjH6mVS/yxCcQ==
X-Received: by 2002:a05:600c:225a:: with SMTP id a26mr3376088wmm.73.1571900439119;
        Thu, 24 Oct 2019 00:00:39 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id y3sm38886208wro.36.2019.10.24.00.00.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Oct 2019 00:00:38 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Thu, 24 Oct 2019 07:00:38 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <312839085.10341.1571900438441.JavaMail.javamailuser@localhost>
Subject: next-20191024 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_10340_1358193880.1571900438004"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_10340_1358193880.1571900438004
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.4.0-rc4
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 12d61c6996999e6562cbbed5f270d572248a11c5
git describe: next-20191024
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191024

Regressions (compared to build next-20191023)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20191023)                                                                   
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

juno-r2:

dragonboard-410c:

hi6220-hikey:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_10340_1358193880.1571900438004--
