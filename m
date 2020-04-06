Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871FA19F000
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Apr 2020 07:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgDFFAY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Apr 2020 01:00:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42237 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgDFFAY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Apr 2020 01:00:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id h15so15741807wrx.9
        for <linux-kselftest@vger.kernel.org>; Sun, 05 Apr 2020 22:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=/9ZaMTJ9SBYxlAfubGqT5qvZOwOgHmq/tit7idyEjNs=;
        b=BGaEIsSWlseL40K7TiEd3Qri6gHhXJl3CLndbLiRwo7724bYmdEjKIJyyfWAeRH3x2
         dDD6Ibv2guyrn1VZun2HeOCRF5WHcSni5Qq6dGRnr1KISFORsGn8VlKgTMVX2K15Za95
         WP89QuCAAFcGIvazOPlX4CjhNXBlDD2l1FogwZKt7PnaeDdVC/St6Ljd0OIj1pwvz4AT
         UkMsqszRW0/7t3ldC2Ps6mFLypdn++jloBrAvUA7jFOrkJ/RdbnGyoL7CQyunAkveB58
         Sd48KW46Bp3YWyQvzjARwruMwkHQew651N2zZ0wNiheOVsUYEmM58CY6dcS+NNPkxdHn
         QnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=/9ZaMTJ9SBYxlAfubGqT5qvZOwOgHmq/tit7idyEjNs=;
        b=L/dm7qamL/aMvexFotFs2BqWFqwnvh8fAdLHbbfwBUIhzDpPbrBWUl4skddPqNwmK4
         o4DGRfbRH++i64l6skkTqOF6QUlUMFrp7o4pXEqolayXX+72hw1df2INlQnnijPTodD0
         SQRLlZdeFF5FCZ5M5Usc/Ux7Kkz1hVUVfviyiknvvQIP5eARBuMdY5YUb1S11JqKp1gc
         PmxSGM6Zg6yOv/Wl6RlIUrnhPe80kqt4wa2TwDjdq4dFYksz0QhwQvFyG4miK13FEt/Z
         AxGDj63AzwvP4YB8DVPEN3Na2/0q+2P7ERSqeigFKqXfjvBfGuUfaGBj0t2Uncv1x6xd
         QcGg==
X-Gm-Message-State: AGi0PuZ4WqqA8/RhjmzxI7udtFzlfoZy25IKEFFsjKBl6uqSLRK3BzIL
        PYWSvHYrfiM9jWWNhF78kZZ7AhsrHUw=
X-Google-Smtp-Source: APiQypLcmDs2wUO+uO0b9D6/M/ts1zDaYJ+HwJ4+Vqc2vSQWRITrM3XzmjR1MfoUIfryFDbkr6/dfA==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr20997057wrp.270.1586149222401;
        Sun, 05 Apr 2020 22:00:22 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id v16sm74342wml.30.2020.04.05.22.00.21
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Apr 2020 22:00:21 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Mon, 6 Apr 2020 05:00:21 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <1318350336.14476.1586149221790.JavaMail.javamailuser@localhost>
Subject: next-20200406 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_14475_1536760125.1586149221102"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_14475_1536760125.1586149221102
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: b2e2a818a01717ba15c74fd355f76822b81a95f6
git describe: next-20200406
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200406

Regressions (compared to build next-20200405)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200405)                                                                   
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
- x15 - arm

Test Suites
-----------


Failures
------------------------------------------------------------------------

x15:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_14475_1536760125.1586149221102--
