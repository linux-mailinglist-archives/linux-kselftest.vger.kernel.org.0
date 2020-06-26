Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AD620BBA8
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jun 2020 23:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgFZVfq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Jun 2020 17:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZVfp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Jun 2020 17:35:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90068C03E979
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:35:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a127so5150919pfa.12
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Jun 2020 14:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DqOaaV58EjOIY1VepCG+GQtVeu6B1YTzNiLFMCCxxtU=;
        b=YEN4h/JS6rsbM2TA8UohIHdNyG9IbIr7SJGjr/bFVHhrG/Xom9uuW4VVJlxpjCalyc
         VzYDhmbP8IO2Aln4UuRyuqd6Tgy9Qku2VWWKJ3oZdsqEk7RJQDbYUlIcQKhd+fpKbBRk
         cijP8DnapIIWZQIeC0Y6ZFYLszmtMLfDZQXr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DqOaaV58EjOIY1VepCG+GQtVeu6B1YTzNiLFMCCxxtU=;
        b=m6G2YTmIZ8fPSn7hFHFCUZp73GylbXUE8F9evNEM0ujtRIdaGDFX1mdTwf6XphyZ/m
         lOL9J0aMQn2xLyz13S1Dc1R6Lb0X1dg59o2697WUFmPON8Wjzm/+lsM2vABVKQI9xbd0
         ciLosvMa0OTsaRIgeMBNcYOD2n3nEEC49nsSLucWosynKyt6jw/4NzQR+PmUTFs6Ax8q
         FIKhnctTaExYTwkZk6rcV6e7NA4GA6emkWNJ2kul1DvXbgzj/eZwfB5PjnomjCw6da/A
         iz1Rwp0w94TLZQqhS+fesmrC26qNfqMbEhCV7twO6eAb22XsA8ZfRdqQxNU1ChUtcUuh
         YKrw==
X-Gm-Message-State: AOAM532GWkibIVo53UW6QAC8ioiI97zeXnpej32ZtqyEUlQNbILqzu63
        GhSToT3nQKAboTq3k/CQ2VDFRQ==
X-Google-Smtp-Source: ABdhPJzxc7cz1MJJ6rNuO5CPPtEcoMO4+f1C1i4DCl9wrVYJnO0GAsRDswfDPhhwjkUn/N4AdYEJaA==
X-Received: by 2002:a63:371c:: with SMTP id e28mr692197pga.114.1593207345125;
        Fri, 26 Jun 2020 14:35:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w135sm7739381pfc.106.2020.06.26.14.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:35:43 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:35:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, skhan@linuxfoundation.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, akpm@linux-foundation.org,
        rppt@linux.ibm.com, frowand.list@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, monstr@monstr.eu,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        chris@zankel.net, jcmvbkbc@gmail.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, logang@deltatee.com, mcgrof@kernel.org,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH v5 09/12] kunit: test: add test plan to KUnit TAP format
Message-ID: <202006261434.119AE33DBB@keescook>
References: <20200626210917.358969-1-brendanhiggins@google.com>
 <20200626210917.358969-10-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626210917.358969-10-brendanhiggins@google.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jun 26, 2020 at 02:09:14PM -0700, Brendan Higgins wrote:
> TAP 14 allows an optional test plan to be emitted before the start of
> the start of testing[1]; this is valuable because it makes it possible
> for a test harness to detect whether the number of tests run matches the
> number of tests expected to be run, ensuring that no tests silently
> failed.
> 
> Link[1]: https://github.com/isaacs/testanything.github.io/blob/tap14/tap-version-14-specification.md#the-plan
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Look good, except...

> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log b/tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
> index 62ebc0288355c4b122ccc18ae2505f971efa57bc..bc0dc8fe35b760b1feb74ec419818dbfae1adb5c 100644
> GIT binary patch
> delta 28
> jcmbQmGoME|#4$jjEVZaOGe1wk(1goSPtRy09}gP<dC~`u
> 
> delta 23
> ecmbQwGmD2W#4$jjEVZaOGe1wk&}5@94;uhhkp{*9
> 
> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-crash.log b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
> index 0b249870c8be417a5865bd40a24c8597bb7f5ab1..4d97f6708c4a5ad5bb2ac879e12afca6e816d83d 100644
> GIT binary patch
> delta 15
> WcmX>hepY;fFN>j`p3z318g2k9Uj*m?
> 
> delta 10
> RcmX>renNbL@5Z2NZU7lr1S$Xk
> 
> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure.log b/tools/testing/kunit/test_data/test_is_test_passed-failure.log
> index 9e89d32d5667a59d137f8adacf3a88fdb7f88baf..7a416497e3bec044eefc1535f7d84ee85703ba97 100644
> GIT binary patch
> delta 28
> jcmZ3&yOLKp#4$jjEVZaOGe1wk(1goSPtRy0-!wJ=eKrU$
> 
> delta 23
> ecmZ3<yM&i7#4$jjEVZaOGe1wk&}5_VG&TTPhX-Z=

What is happening here?? Those logs appear as text to me. Why did git
freak out?

-- 
Kees Cook
