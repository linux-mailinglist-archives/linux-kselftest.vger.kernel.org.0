Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17AFE1A4E6F
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Apr 2020 09:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgDKHAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 11 Apr 2020 03:00:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54875 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgDKHA3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 11 Apr 2020 03:00:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id h2so4454598wmb.4
        for <linux-kselftest@vger.kernel.org>; Sat, 11 Apr 2020 00:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=pQn7ZwfZ+nWKuNq0bOAKH8ux7T45/Mdn+cYaV3x9pfw=;
        b=Iq5G+ea+F2AaaEJHG+20VQNL3mYaSN99BS5WcD11KmXxw3z6E3DVBfPNIoFoMQ2QYP
         G8Xaij1NIvSUdCb21oErABU2aDSuM2WUmkCUT6/VDrKeJhBCAEBv3BcACMWB8k5p/zJi
         HWFVn17QQ4x8ctPn15MCOiU3/e9YdcPTiuuG/DwL2rF/w7tDrapsTsv2URR3jJWijaiK
         Ploqu9GRqxaGb7hrjkUNA8f47Uhwb6rI5rw0o6krjCdyh+BoaeFMtUV96PUB05Q+eW2c
         IHOV8N2dr+ssiD0zc1Os8vsLmwHXnvE5dn3wLptiO1FO7EZ4l3W3DVhvTh1MJxPf8zRy
         bqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=pQn7ZwfZ+nWKuNq0bOAKH8ux7T45/Mdn+cYaV3x9pfw=;
        b=uG9AD2mu+ZqEKHBfFpAeFfl7OtmL/dqiJCGz+lOtfYBXFpxArqs6gRn4JCZAQ6o3GP
         l79Ee1eM9tTnvX2ZWI9fDnGFpHjrpTHA0Mj8kfvqY7bTL0IxEQiTqtWAtO4UOr2c4PdY
         IT+X2L+iSn6cexikBtDCa/5zffwyffTLLRxLvB++HzuxtEfCQNbLaJ+Sht/7JeeVdMwz
         659PAVZstWfMW/Jt2+19EJzEar32x2kXftqkn5a+OnXsk4+MCP89mgJQiSuHNa/L+6pL
         4nTnxZ/Q6cJGOiY/XFggRfBuvNpxtp40QpFmOqXq3RVj71xMCeOP3VG4qiVVWknzQDBR
         TJjQ==
X-Gm-Message-State: AGi0PubE3nQsr/TyybhuaQqv2Qb3p9ef7WozXi2QGDXVj4bwgkm1QJYi
        YQBl0II5FTlcyhY/h2PYpj9cww==
X-Google-Smtp-Source: APiQypKZDshUqpu34ZNBdQiQ41O0Kptpxn/lp2LdxKMBmMRzNyjlg/fEy+xrR1zQpBmcCvHDEmj++Q==
X-Received: by 2002:a1c:e914:: with SMTP id q20mr8391444wmc.105.1586588426963;
        Sat, 11 Apr 2020 00:00:26 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id x18sm5396637wmi.29.2020.04.11.00.00.25
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 11 Apr 2020 00:00:26 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Sat, 11 Apr 2020 07:00:25 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <625971041.17043.1586588426339.JavaMail.javamailuser@localhost>
Subject: next-20200411 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_17042_407607673.1586588425516"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_17042_407607673.1586588425516
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 11ecafc691e130cff72cc793ee085f5e4a6e127e
git describe: next-20200411
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200411

Regressions (compared to build next-20200410)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200410)                                                                   
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

x15:

juno-r2:

juno-r2-compat:

juno-r2-kasan:

i386:

x86:

dragonboard-410c:

hi6220-hikey:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_17042_407607673.1586588425516--
