Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E773219EA43
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Apr 2020 12:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgDEKA1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Apr 2020 06:00:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50994 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgDEKA1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Apr 2020 06:00:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id x25so532103wmc.0
        for <linux-kselftest@vger.kernel.org>; Sun, 05 Apr 2020 03:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:date:to:message-id:subject:mime-version;
        bh=3Phuc/QwAyy2JPWLFBEQFC5gvUmkLSjPBEG9LIo/O7w=;
        b=QvCqRpoktEL42R1FN1zBzcbBGgb5CkHZF/z9jhfe7AwR9eFbbVtbBefSK100qQ91Mp
         KqzwdgwRdgHj0rEybpSW6WejFQM+GjWeQZHRY+W1LXKkI9MmqGYIW4cU00YMdjF1wm3A
         pLPaAY2QBsDEHvAM7XxLr2WPdpjTL6OQYf4yj+pamqZ+DJsekltwBHkw8NDuEN4zVPaW
         s2h7qrQL7EWJOO6q9l2aUPdxCHhOYHm1+trO4NvFqzGiCScXa9MTdR9JEz/nIQukVtpJ
         fngj3CC/w4I+waM6yc2VQY9wXJCu14FbCwnYEscymfbYV5T8jcAR4yUfNq3tEE5179So
         hDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:message-id:subject:mime-version;
        bh=3Phuc/QwAyy2JPWLFBEQFC5gvUmkLSjPBEG9LIo/O7w=;
        b=XH0Tkqdunfh9GqNcITFEUDRNGu6+SqNipAznZBxBcnvvSouFRkofUzJxT7BePkK6Oh
         Ap4WKi7vvMnQAYWVGCor6LG9cSB/2X0FKOxRWIe3cQ+OLqFmmzUiAUOEJOBbjBEeG119
         S8iWQMllDYMVXZCzYQsYIWtEG0p9E4dFadPWm0Kvr/NMGggV0PrqgiZTa24vNP8ZSg/S
         SkbOX62S4j8JKBdKUt9jqVQeZAEonHDyUCmwHwX8fksK25maL5bFH+pbpkEZqHv2Z8lC
         7k8HbFYTlXngksab7aiygcvksjo9olxeOE1C0rV4KZ0CaexRCh5WdodWvI4QtRCrjX9r
         ZyBw==
X-Gm-Message-State: AGi0PuZfCuAun/poTbbGl5b7YoKN8GUF4CvzyXxn1w9JZcjwNBbjWR6B
        vTKlLo1jkoAHLPd8qkehguXzyuhbjGA=
X-Google-Smtp-Source: APiQypJMkSJzrpjD2Wi2VdW3ijSaC9mHi0mfnyD6v5L62MqoXC8Q/ej3lBkLCou24mq1t2ksw5eXBQ==
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr17117086wmh.65.1586080824520;
        Sun, 05 Apr 2020 03:00:24 -0700 (PDT)
Received: from 172.17.0.4 (ci.linaro.org. [88.99.136.175])
        by smtp.gmail.com with ESMTPSA id y1sm12559245wmd.14.2020.04.05.03.00.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Apr 2020 03:00:23 -0700 (PDT)
From:   ci_notify@linaro.org
X-Google-Original-From: linaro-infrastructure-errors@lists.linaro.org
Date:   Sun, 5 Apr 2020 10:00:22 +0000 (UTC)
To:     lkft-triage@lists.linaro.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, naresh.kamboju@linaro.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <827837100.14429.1586080823916.JavaMail.javamailuser@localhost>
Subject: next-20200405 kselftest results
MIME-Version: 1.0
Content-Type: multipart/mixed; 
        boundary="----=_Part_14428_267380592.1586080822960"
X-Jenkins-Job: LKFT Notify kselftest on next
X-Jenkins-Result: SUCCESS
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

------=_Part_14428_267380592.1586080822960
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary
------------------------------------------------------------------------
kernel: 5.6.0
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
git branch: master
git commit: 57021046c3316f8a6970506b09ec83337a4f5304
git describe: next-20200405
Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200405

Regressions (compared to build next-20200404)
------------------------------------------------------------------------
No regressions                                                                                                          
                                                                                                                       
Fixes (compared to build next-20200404)                                                                   
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

hi6220-hikey:

i386:

juno-r2-kasan:

x86:

x86-kasan:

dragonboard-410c:

x15:

juno-r2-compat:


Skips
------------------------------------------------------------------------
No skips


-- 
Linaro LKFT
https://lkft.linaro.org
------=_Part_14428_267380592.1586080822960--
