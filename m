Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DF4197C5A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Mar 2020 15:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgC3NAg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Mar 2020 09:00:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39273 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbgC3NAg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Mar 2020 09:00:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id e9so9861490wme.4
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Mar 2020 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=AWHvGsNPhBXzGS4NrMgp+1wcjkcjrmUG6Apl6yrTBfo=;
        b=hcxg3iYUoVuRC6BGNJDeo4xelV4a0Ry60PkckUgUSdYHHyTa+hqdTuAKmgYCJjxF5y
         /cwWwQfkAT+Kj3giYEYPo0Y/6rCPAuK52iOP8bRzZdNf5ppBSQSPHjlRxp180mrsSpWT
         r3pFwtKmVLmsZoqTYZkOPS/a7Kyj2PO5F36oRUlpYEYTea7zpWgLzGblq5vEKVcpohKJ
         cxmPajyX+348ZqBVuYpSuy3DxJjrJocAGzTGUgg4SotzwbbOtFas+Ts4XTvg6xPGRQh+
         E+isGY5U/fzdHHTSzC2uyJ8Cnoc1rvHfNYaQVybarg2ia0BmhtXI+25wHJfZY3XsL8cY
         6ANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=AWHvGsNPhBXzGS4NrMgp+1wcjkcjrmUG6Apl6yrTBfo=;
        b=oZDyFZl/j8rqR7D1kN1beKIr2P4dup5cgl5LkXn0tmXQAUyO/NK5yAD7DnD5uh2ZiG
         NWMH7KZvCMuskuTrEIm99w5VlNBQHVDUXp6Um84Er+0hmDo3WL4y/B1jT0R9SFDvhryL
         kwUqzq/vTYcME+J6++pSpC9MLmVou6U2UJd6n2uqO3axlhagvSkJkqMGh+OmfVmnWVXK
         QkZ2xep05/omjljmICfxpoq2DET+ZiA0xt54O8Ml1gjfU8XT0oqiD7phRO6k7mTOXwzA
         jNWlnuSJgefff1C0ST3kDNWdM268Ov81R9kGe5yBzSQCVR8ZFIDXqST1KqKmRrJYBYoi
         p9JA==
X-Gm-Message-State: ANhLgQ2f0JyttXJy3UtRXKqDuOPF0ZX0nluZfVXdbLcvrOmns6EPsYMz
        mxXV6zf+Q30fng6pn/yhJFHPww==
X-Google-Smtp-Source: ADFU+vsBqersxtBFSS7l0GooFW8Sc7ZemO0oM0l/miqy78K1YZikyXE44LwXm/DfO7buWO+JZmMFNg==
X-Received: by 2002:a1c:7519:: with SMTP id o25mr12882175wmc.90.1585573233198;
        Mon, 30 Mar 2020 06:00:33 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id f187sm16568039wme.9.2020.03.30.06.00.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Mar 2020 06:00:32 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Mon, 30 Mar 2020 13:00:31 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <1609141678.12917.1585573232719.JavaMail.javamailuser@localhost>
Subject: next-20200330 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_12916_1219523201.1585573231781"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_12916_1219523201.1585573231781
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0-rc7
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 27a8b6c16291760cfb7d955c58d8e34dc27ec9dc
git describe: next-20200330
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200330

Regressions (compared to build next-20200327)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200327)                                                                   
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

i386:

juno-r2:

x86:

hi6220-hikey:

x15:

juno-r2-kasan:

juno-r2-compat:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_12916_1219523201.1585573231781--
