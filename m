Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A5941BBBA
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 02:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243397AbhI2Afk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 20:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243381AbhI2Afk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 20:35:40 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441B7C061745
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 17:34:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t8so1329009wri.1
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 17:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSdhi5MD3J11mywOpDX17swzDtW7khzOFHmAT7RZlcY=;
        b=delwZA3PvlcFeAc1BlOlesya2RRKOCOBwSS2vHqtKOJKz9eoS+AWiXS/9S0AnHld6X
         OgwS+wy0u79R35QTZ9Z0uw+HASzBwrEwRGR4Jgvg+7xASRDt9k53DbY0ii625hsqRLtV
         Tp27g3vk5ml/y7cOYxw2bfv799qpEw+ECAC+ADT4YViKF8bjC4jHWA0RxXEXERH0Qy2y
         NAHhY36mlpAwVIZWnHhwzhZhNePt9fgJ3jEPNKdG5XoP4ZftZvoqGmwAfcmGL1hKIAzI
         6kMa5md6FcUhcoGdvBStC4grrpNAPIBPPGT3JoyWAxqOjwYHJGVljfJ1x+E0GA/TS8EF
         cuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSdhi5MD3J11mywOpDX17swzDtW7khzOFHmAT7RZlcY=;
        b=3ipHWxyXOIiZHEChdfbDo7JHAhPkkFvTr9vmSYPIwJK14lldWhf290wPEGjc9sMPtZ
         Xtddv3fEbsnfJAUILRHOp7LVnNxSNBSfiFdwxq6cqp+1Nt4Gfdg9Cq2Y93nqX2JYbP0W
         YlEkovpswh+Ld+FqzcS59aBHjdJo0rHqBRSO3/5bMDuMEX1Hc/Bwl/8M6CvO3p6Sg7PI
         HyvybuSnC2N5h0mianzYribjqnx1vEHbtcU2MAgWk39QDyH0/S+RQcJw1UHWJwhMIU/s
         uj9SNbT2pbV47DKtue4ZyaCbS2gsJWS2w0nlQTyAUb4v7TmM51Rve2cT6w+91IXi3BZV
         3ZGA==
X-Gm-Message-State: AOAM533Fr75w7IHMcJBSTkguk/KsSLgLLVz7SJb3H0rqHEw4ZsgPs9ll
        BOVUJ6+Ml7MHKUC8yI2DS9S8qYGpsyMl3oHldSPaoQ==
X-Google-Smtp-Source: ABdhPJwNa5YuLE7ElHy5BCEAzIuUz0ClkJjlxnz/5YVr9faR2sHTg3Uxqzdl6UbdIqOWFYWgcXlHzRpESMRIBWVaitY=
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr3517966wrt.147.1632875638582;
 Tue, 28 Sep 2021 17:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210928221111.1162779-1-dlatypov@google.com>
In-Reply-To: <20210928221111.1162779-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 29 Sep 2021 08:33:47 +0800
Message-ID: <CABVgOS=0K78N+KMK3km5TKVDD9L8AMRpNCfvihCqU2h3U-oE-w@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: misc fixes (unused vars, imports, leaked files)
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 29, 2021 at 6:11 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Drop some variables in unit tests that were unused and/or add assertions
> based on them.
>
> For ExitStack, it was imported, but the `es` variable wasn't used so it
> didn't do anything, and we were leaking the file objects.
> Refactor it to just use nested `with` statements to properly close them.
>
> And drop the direct use of .close() on file objects in the kunit tool
> unit test, as these can be leaked if test assertions fail.

To clarify for a python novice: this is referring to using "with" so
that the file isn't leaked if the assertion fails, rather than
suggesting that leaks are okay for failing tests, right?

> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

These all seem sensible to me. Thanks for cleaning this up!

Reviewed-by: David Gow <davidgow@google.com>

-- David
