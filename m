Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEBE313E28
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 19:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbhBHSzk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 13:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbhBHSye (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 13:54:34 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BDAC06178B
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Feb 2021 10:53:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d26so9061508pfn.5
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Feb 2021 10:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEpFRJ4PlevumLlf2VLKCFT28k/4UaTOkUzDF1cwLJU=;
        b=FBM4S1y2yuAqEbUGuv8z+KUXYA1QWNF6PLzh53subvR45JrIq8JwVxHYRVvmJY/Uo6
         fETZkDFEB6Zg7ktCV1nKgSFlzqFU701SxZ1wEucCf/Z7XrTpS3lXVFSHb/hYekBCPxPr
         BUIOKtWTICJO2oCkhaWSCcyQ7UDaCE1nF0qRbn+BFXdgiYqMleSiCLtM19Fc/HCTldu9
         t/OL2/cltUDatq8Cd/SzfPLEPwvH5qpbEmtrcm1Vx33Ku6AdWNIjCNGPA+CQb+kwgEPq
         w8BIuwzB2zPJc3F90WIhwJDJ9OOCtMLPsRslcr71d3gvSqP8VdTIUG6MvojY7SQGSL5h
         dRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEpFRJ4PlevumLlf2VLKCFT28k/4UaTOkUzDF1cwLJU=;
        b=i03E7Re3ZDgNKmr7lL4NuluUUbnFlSuvAlk0liHoSICLWlh7OxdG9Cwadq2d4JEVx4
         O/ZYP/1hz2HLX4Lmp8sdZHdN3qaoIUxAeyJJPNjenAEiK1gOeu8Jp+TJpPGrqkSMG9Hj
         4g0qR7PP+68erQ0aIgA46XQzaQjKmefMS/UrQW8NS4FQgSsrdSv+66QBjuttzQrOkfxj
         GVzzvN2BeRIsiDfwnhqXY7fspUACWIoGcXU2cc+cJRHGmU9I+lV1bGQb2CnHwoUSXK6S
         +tBU9ubDTwykDPOntPYW5qcsXuoZnv6rQdAU0pJHS7CuSdPO6d2timo76hLMHRZvX4TU
         3zhQ==
X-Gm-Message-State: AOAM533jjar8sA4cWYsWjrhOWTMtWWhoIVqHqMCziqnmtVXe8tfHJmM9
        vN3vojLUZzyz+xAqEDcp8HUB0+kFeFzthVBwod4HhQ==
X-Google-Smtp-Source: ABdhPJy8zdfOBPn7HnTs9Aax934SSyW3YL61eKkAqdxwpgInp49o/jl5fBnioGqq4uUVouRlds6COcNXSoG/TpuVJ7E=
X-Received: by 2002:a65:4184:: with SMTP id a4mr18800831pgq.384.1612810433706;
 Mon, 08 Feb 2021 10:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20210206000854.2037923-1-dlatypov@google.com>
In-Reply-To: <20210206000854.2037923-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 8 Feb 2021 10:53:42 -0800
Message-ID: <CAFd5g46p+Bj+ibSCai3c8TLh9a4aYajgQBpAWbKmnaE_xsXVXA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] kunit: support running subsets of test suites from kunit.py
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 5, 2021 at 4:09 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> When using `kunit.py run` to run tests, users must populate a
> `kunitconfig` file to select the options the tests are hidden behind and
> all their dependencies.
>
> The patch [1] to allow specifying a path to kunitconfig promises to make
> this nicer as we can have checked in files corresponding to different
> sets of tests.
>
> But it's still annoying
> 1) when trying to run a subet of tests
> 2) when you want to run tests that don't have such a pre-existing
> kunitconfig and selecting all the necessary options is tricky.
>
> This patch series aims to alleviate both:
> 1) `kunit.py run 'my-suite-*'`
> I.e. use my current kunitconfig, but just run suites that match this glob
> 2) `kunit.py run --alltests 'my-suite-*'`
> I.e. use allyesconfig so I don't have to worry about writing a
> kunitconfig at all.
>
> See the first commit message for more details and discussion about
> future work.
>
> This patch series also includes a bugfix for a latent bug that can't be
> triggered right now but has worse consequences as a result of the
> changes needed to plumb in this suite name glob.
>
> [1] https://lore.kernel.org/linux-kselftest/20210201205514.3943096-1-dlatypov@google.com/

Tested-by: Brendan Higgins <brendanhiggins@google.com>
