Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E779DFD7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2019 08:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfJVGCO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Oct 2019 02:02:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36436 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVGCN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Oct 2019 02:02:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id c22so5758566wmd.1
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2019 23:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=SmI564QOmdpEwJRxSB7zX1NlTUlETOy44lKeLKokdXY=;
        b=sB9ECPB/VbhddZCiKxVzXgMzxpUW+mcH1qUU5EH88yS0jJPdkpopTOcnZ5iOQ0IbJw
         UZvLcz5XDAN025mMBJd08Qn8A3uYmbR2q3P+gPgeBRq1I8EG9wqSVcWvgEoRb6m+7luz
         BgYJw3ASj0hFLbK35dH+kKPAd/7csyXQVpTYfqLS/FWx8iJHjmPvPInyzaQVUA5MLCjl
         pJ69TO1jm7kveqJtXA576AKAgKkjYgnx04fC2Sl89vP7nk33jt+Iuyft7HLSETV6zEtk
         AAIwMgLhz/YpwtV+4HHmgaGsT7ENcxZTfW+aC2kybPU9IH5Ho73PvAWjJiH+Uz+frp9M
         wf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=SmI564QOmdpEwJRxSB7zX1NlTUlETOy44lKeLKokdXY=;
        b=ifFTWaQwhVxkARsuwCaef2pRMZutUF24wl7p6UcLEoVXTvs5AbvF5hBuTtrpyBCCiu
         pZO+rjz5z5zZfQ9q942yLppARe9B4RLPWFhdxncVrtVLy5BPn5z6B2Hpimcx72U8HVzi
         lvXk0yfMkI4JKZOTq6P/7lF3XohT4Nugzelz7ghr2CL1MNe5Hqq3BRMo7bnihQ41ZGP1
         0tbPyDaqS7rlSH29TelmAP/wnRFZT2wZIUH2Jyub2MQ5HX0MJrlWkNMECOIz2jtWjsSu
         JNFtYzSPyK6aXnsXSItD24WYK0NgVd4X0EowvazW4d+oYSDxoNTVWcLImt+CEZ4QEKJT
         TC9Q==
X-Gm-Message-State: APjAAAXRqVkeithB0pA8WscnQFxCF9pxXthYMj9ZPWQ/8Sb3Zk4OwnQF
        QjnKPzrfj/hoJvaHbmG9tmb4HCHEqYs=
X-Google-Smtp-Source: APXvYqzJOQ4Rich0YixxyHR/N0GHiu1NiqzTcSuTD8/mFKWq3qzrJu5HcOJdQLKsN+1D/8yZkGW6Pw==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr1315720wmb.140.1571724132375;
        Mon, 21 Oct 2019 23:02:12 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id y186sm21390341wmb.41.2019.10.21.23.02.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 23:02:11 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Tue, 22 Oct 2019 06:02:11 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <1644951908.10113.1571724131784.JavaMail.javamailuser@localhost>
Subject: next-20191022 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_10112_856267118.1571724131109"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_10112_856267118.1571724131109
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.4.0-rc4
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: a722f75b2923b4fd44c17e7255e822ac48fe85f0
git describe: next-20191022
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191022

Regressions (compared to build next-20191018)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20191018)                                                                   
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

dragonboard-410c:

juno-r2:

hi6220-hikey:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_10112_856267118.1571724131109--
