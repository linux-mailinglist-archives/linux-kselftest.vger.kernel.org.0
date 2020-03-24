Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F542190863
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 10:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgCXJAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Mar 2020 05:00:30 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:43383 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgCXJAa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Mar 2020 05:00:30 -0400
Received: by mail-wr1-f50.google.com with SMTP id b2so20350598wrj.10
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Mar 2020 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=dud9sTtmuIIvoK0uglkV5CiMUVycEqdHvXhoDLGnkOE=;
        b=WWmmcszMkboA1dzyuxKH0O/i0AHNCGNBP4sR0qoqz936FZoaroRDUMIqtIO5UGtchw
         LA2egcp19n7G50mrPNyLhweoZFa5NviqM6YuLW4awoKtDXjwRwlfpAUKCDMsoTzNcH2p
         XcIHntsvkLinGJDcfJ/bDHUUavPzCjKZp1a0wqXyimXHuPdlhbFFIZ9bIQNjdx1NILDm
         bmQ3H7E/sqdTb1SdJTvWTIaslLo9fDkBdYo0vR/VjkLYM+0etofWnFq/B4LGr1/VonNw
         JN50seZ3w7Y30xJzSo9Uhq9lxEuWQxkX0ZIMVJ9Yskt2iwiAV5HegxeWD3bXaDRH5i8D
         zYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=dud9sTtmuIIvoK0uglkV5CiMUVycEqdHvXhoDLGnkOE=;
        b=lT5ESz5So9LVLGI2rQuOIakzGww1JN853NMTrVL7GFFoyZThzPJCVPap/Nm39dbPJ+
         KeAeOgTYH/+aJwIhinoHJT5TpaRj8wixbAoFXqYOHhcIQQnvoi82GLGAOwJhYW1yKhJP
         GErtVs3q58t7uPA4LiTYkaT/zMoF9ZE0pyTZdid5stOKsaLoRdnS9b/+0yorg5EZOAYS
         xtRqK6YJ9yDlZIeBgOYhjtSYecGonxVTxBKUZFSftTiigx5GpHuFeJjuy9N34AjXVDLu
         eqM/mwI+8/wW/YGg2MGwB31hiCAB4zg/OH8wx/MOJO9PWQCZ46NlzB1mCVQblUVSS13z
         pLcQ==
X-Gm-Message-State: ANhLgQ1Dz2k7LXrm7Con3BI5+vu5Ux6kcJO7qdE3Y4cUXWh/CEUhyLAp
        Ow68FSvc0X1zZtLztrPerQGH5Q==
X-Google-Smtp-Source: ADFU+vvkdcshdyCbMFW54YPbBi7CkaBUaTHdkMQ2NI0uzX1H6+RceqKJxzrIxRthlLein15gVPYUiw==
X-Received: by 2002:a5d:6146:: with SMTP id y6mr35553250wrt.107.1585040426333;
        Tue, 24 Mar 2020 02:00:26 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id z21sm3354020wmf.28.2020.03.24.02.00.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Mar 2020 02:00:25 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Tue, 24 Mar 2020 09:00:24 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <2110335547.11319.1585040425798.JavaMail.javamailuser@localhost>
Subject: next-20200324 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_11318_1250033111.1585040424998"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_11318_1250033111.1585040424998
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0-rc7
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: f15e8108f6251f3480d572bca5729c1b849edfb3
git describe: next-20200324
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200324

Regressions (compared to build next-20200323)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200323)                                                                   
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

dragonboard-410c:

i386:

x15:

x86:

juno-r2:

hi6220-hikey:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_11318_1250033111.1585040424998--
