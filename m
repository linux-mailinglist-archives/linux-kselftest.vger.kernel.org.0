Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1A1A77D
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2019 12:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfEKKPA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 May 2019 06:15:00 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35729 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbfEKKPA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 May 2019 06:15:00 -0400
Received: by mail-wr1-f42.google.com with SMTP id w12so10306304wrp.2
        for <linux-kselftest@vger.kernel.org>; Sat, 11 May 2019 03:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=OljA2d0+ul2bQQ89gwQ/SPdbTjiFlmUTk0bs228MeKs=;
        b=KTJXdd3aJZB7s5PhztiRKHt6WJN4taailLtqF8Ngrli6FcUfaRq1XaLxBwgtoNQWRN
         gFkZKpJe/mZ+CGqxjmvIKFVPzpOzuCKnJeAUsOwxaREZqipjAaHg3HsG6YBVqC9aOn2N
         G4qd3yizvZs+uHU34nSt2fzgAC04QOEOjIAObmO6f+SxTq/ueoU7p6OwmqUXl5dHmNkG
         jforECh1EbgDA43tOCjGitrnnXeQ4qZPU0HsFTSPe5LYUsEsh54/uI3QLbnROjA3JoTk
         jCeunX8/RZOUEvSfshW02y2kAdopwhWvTOQZJN+1fW0wolFzor+8wCxUMLIE+CP3wklF
         mUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=OljA2d0+ul2bQQ89gwQ/SPdbTjiFlmUTk0bs228MeKs=;
        b=XtlH+Xyq1RNuh7NsKTlmldOrKgg3z+/fAV/OB2IaiMrKR+vKdoesB7n5G2l/awZo49
         baUJLGQVY0I5zpOXRZmJHnQJIG+E7cNXUVD4Pzz9P+wcjcPBrGrfPQO3JccXi3LfprHh
         0alp+4qUZJwYOuYhrwfqWoLYjn1L/c9TOu16onDttR+y/4430F0nBD4SZiEU6t8IILtV
         Ss12tAraAQr9hhJkO+VyzgRPNYwZdzmH63M83vsappiOTsA7DyoUfuq1sMFrskKeGVsl
         an+GBhtILW4eZHuhvV18xfuEP8Iiv6L4ylWvT6ntLd8txsr6HjIwdnPDnbLfHG/DoRib
         GEyg==
X-Gm-Message-State: APjAAAWjDfgobU5/64ya/CpmAKI78nWXML1xxiAq2NJKkh5KP2HtYy9o
        CdhXWKRxrnZ2gw9nMo+/lToFYw==
X-Google-Smtp-Source: APXvYqxE6HrQ+Fep3Ge1lPLlMC5BXlVM23LubkPqI9ZVft0fLbsC+uHTFr6ncdhquvmOrqqs2HQ6Yg==
X-Received: by 2002:a5d:6145:: with SMTP id y5mr1105239wrt.96.1557569698439;
        Sat, 11 May 2019 03:14:58 -0700 (PDT)
Received: from db10df53eddc (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id o8sm15387180wra.4.2019.05.11.03.14.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 11 May 2019 03:14:57 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Sat, 11 May 2019 10:14:57 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        linux-kselftest@vger.kernel.org
Message-ID: <359070592.29.1557569697898.JavaMail.jenkins@db10df53eddc>
Subject: next-20190510 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_28_1699005278.1557569697281"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_28_1699005278.1557569697281
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.1.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: a802303934b3bd4df6e2fc8bf2e4ebced1c37556
git describe: next-20190510
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190510

Regressions (compared to build next-20190509)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20190509)                                                                   
------------------------------------------------------------------------                                               
No fixes

In total:
------------------------------------------------------------------------
Ran 12 total tests in the following environments and test suites.
pass 11
fail 1
xfail 0
skip 0

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot-lkft-kselftests-master-519
* boot-lkft-kselftests-vsyscall-mode-native-master-519
* boot-lkft-kselftests-vsyscall-mode-none-master-519


Failures
------------------------------------------------------------------------

qemu_x86_64:

qemu_arm64:

qemu_i386:

x15:

qemu_arm:

x86:

i386:

hi6220-hikey:

juno-r2:

dragonboard-410c:
* boot-lkft-kselftests-master-519/dragonboard-410c


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_28_1699005278.1557569697281--
