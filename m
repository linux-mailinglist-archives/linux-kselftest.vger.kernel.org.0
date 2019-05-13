Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5619A1B22E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 May 2019 11:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfEMJAi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 May 2019 05:00:38 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:34293 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfEMJAi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 May 2019 05:00:38 -0400
Received: by mail-wr1-f52.google.com with SMTP id f8so4634170wrt.1
        for <linux-kselftest@vger.kernel.org>; Mon, 13 May 2019 02:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=MTB7R0Wk2XDTZADsX1wiEJ5qy06moKNi34XMG3R5kNo=;
        b=QJyRaiFqxmjWCqicu825rky1EKeBV8AfNqECKMGEkFzSuisnHRMFQtIehax6OvvV3g
         bSQgijTSetifVxN/T8dmEMwdwf3fD0GpbWtGcoOrY2zGvUoViHQJrnHLdIDRK5p/E6xG
         8h2A2WKCEh34Y+7qks/vO27MlVwJpKHzjKhgjSzi2YHweJvcjqEmihfhMI6sqJiAaxeF
         2dv9L10iSZwt1YBQYsqDFnp3TUCp0XLKAx0UW6KjOo5IRlI8lmBeLTYS/z0zcJ7h0ttt
         Uyty4Vivui5fFRJWHAtttI4rQL1H6/AQ6QW+7JXnQNBFMZ7rg3rSmAmETzRr3+Lusyih
         bfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=MTB7R0Wk2XDTZADsX1wiEJ5qy06moKNi34XMG3R5kNo=;
        b=EQsQFB3MPIg7CO2gSP96INi1oliYvrxE1TqWvWnVmc7e655nb2gM/1al1pC8JOPel8
         kDJmVi7f4igZ+XOjvp9AxxJA9f/2sE//kS7m8szW8HRreBwfI3q1lbT4z7BL6dd0gbXp
         sEJU0yzbBOe91dF3m0J68nnKuwrd0JEvuNkhXq6pejPTVSWvbmncETzn8wFVypZeE+Y6
         la53CgR9VKT1wkRwJiLBQo5xgkBhNOqz0l4QeXawBDXGqW2WTeYH04W9bLp2O8Ti6Xij
         HPcVU//in/NMucGruifQulpA92CrxN1QkrBAXbNpvO5rCbq2KzHnxQZZYYNyznJzaloH
         ZEzg==
X-Gm-Message-State: APjAAAUNH89OYHqaqpXLRfbw2ucthPSQE5I/weYRCBuuEFPA7KqZOKZ+
        m30gAdRjqUtCcGEkwxhp/2v67Q==
X-Google-Smtp-Source: APXvYqxBLa723IY3ZOLY29r+rdF+rwuukHAiIYX/9J0pr1UNyMhYcYtZNjpgsw9vf/U33L/R4w++Rg==
X-Received: by 2002:a5d:488d:: with SMTP id g13mr16693520wrq.119.1557738036490;
        Mon, 13 May 2019 02:00:36 -0700 (PDT)
Received: from db10df53eddc (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id m8sm23570540wrg.18.2019.05.13.02.00.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 02:00:35 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Mon, 13 May 2019 09:00:35 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        linux-kselftest@vger.kernel.org
Message-ID: <1001978078.2356.1557738035817.JavaMail.jenkins@db10df53eddc>
Subject: next-20190513 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_2355_1452789118.1557738035039"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_2355_1452789118.1557738035039
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.1.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 04c4b6775d34f12f196e056debed9e8718585342
git describe: next-20190513
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20190513

Regressions (compared to build next-20190510)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20190510)                                                                   
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
* boot-lkft-kselftests-master-520
* boot-lkft-kselftests-vsyscall-mode-native-master-520
* boot-lkft-kselftests-vsyscall-mode-none-master-520


Failures
------------------------------------------------------------------------

qemu_i386:

juno-r2:

qemu_arm64:

qemu_x86_64:

hi6220-hikey:

dragonboard-410c:
* boot-lkft-kselftests-master-520/dragonboard-410c

i386:

x86:

qemu_arm:

x15:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_2355_1452789118.1557738035039--
