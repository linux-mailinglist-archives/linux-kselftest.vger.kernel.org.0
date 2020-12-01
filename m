Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11F42CA0EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 12:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgLALGw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Dec 2020 06:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgLALGv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Dec 2020 06:06:51 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACC7C0613D2;
        Tue,  1 Dec 2020 03:06:11 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id j13so1027564pjz.3;
        Tue, 01 Dec 2020 03:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKIYXaScaIE7TEOxHPKKOMA1edFOJVdBECoLY/zrsjk=;
        b=gzKNikVppqu163aDscUKjy47nSF+BZMMVUkL1n8ZhDCAzk/k1f5Gz1cvFju0C5AssG
         dMiiNelWookXTDzBGk+qPQ0pW2PrMDJ9NNNnKNDrKmJijIz4t+BzJXhM5TPeuzukh3Zp
         8yLmjVEjzwA1R7OFORS0IAguWeLl2FGTcOajuaOJHRty478JWLV3/s58wiRfmQX9UnOj
         QTeqaI8KUMGlLld21DZJphgMWDR3BROhD52bb5FYj+V6qK3P+f3OTwTu1hiusvUMSTAz
         tRSvYXeCW7oSnKuSv4pTaGdtEW5EUfOtL3nJXcGrbQ1LhIQL7P4VzEDMRz4efDwgK1Ma
         1JFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKIYXaScaIE7TEOxHPKKOMA1edFOJVdBECoLY/zrsjk=;
        b=jKXOD0xL7BJ/M+FQSJo9NjKCvRm7ASUXhBgqA8muLkb5U91Aa0L7PZDHhW6oCO7Sb1
         wv2ntiJ4/G6NuMUXMpVV9iuRg6Ai6nHbNTTy6mpXlpHUVC4KyCbsqkExgYlm+6bUngM+
         MaH4TwHfp3Hbbwen5xo+rfslXbJNtsofWVCK9yKbW5UwMDFFXJtakDuuHVVoU/KL3zb6
         bk1Vyhr1sUR3Te3XCOju62qvMwuKVD+xrn374fjPjF2TEwxImCMk8gNb2wPJtupT62JY
         HcCae4qr/PTjsrl7VtLDwsUyWt9iVM2/e7mOsxp6lj+ruKG1CVGm0SwHggy/nAQT2LQC
         wttg==
X-Gm-Message-State: AOAM532fkHOwTk2+iCQXXGCAOwWT2Dy4WJdnDJx/os1Mroa5dCmFzTA3
        wKjrCYcYGaZh28QR7c9DVKZTbPYKdHvUk7v4MQ8=
X-Google-Smtp-Source: ABdhPJwGj51Jga696lxn1uueNX6o3bKkRA2+c5xczsN64bmbGAJmaBGOQfx6Y32TI0yXWgAaHPiLtdss+msba2YlucA=
X-Received: by 2002:a17:902:ac93:b029:d8:d2c5:e5b1 with SMTP id
 h19-20020a170902ac93b02900d8d2c5e5b1mr2295356plr.17.1606820771072; Tue, 01
 Dec 2020 03:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20201201071632.68471-1-98.arpi@gmail.com>
In-Reply-To: <20201201071632.68471-1-98.arpi@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Dec 2020 13:06:59 +0200
Message-ID: <CAHp75VfV60sRAKkzvbEKW7UEZSiDmNVfd_kB-OOKZRk5MNMeDQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib: Convert test_hexdump.c to KUnit
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 1, 2020 at 9:21 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> Convert test lib/test_hexdump.c to KUnit. More information about
> KUnit can be found at:
> https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html.
> KUnit provides a common framework for unit tests in the kernel.
> KUnit and kselftest are standardizing around KTAP, converting this
> test to KUnit makes this test output in KTAP which we are trying to
> make the standard test result format for the kernel.

Below doesn't suit commit message, perhaps adding it after '---' line
would be good. In the commit message you can choose one failed case
followed by all OK and show the difference.

> I ran both the original and converted tests as is to produce the
> output for success of the test in the two cases. I also ran these
> tests with a small modification to show the difference in the output
> for failure of the test in both cases. The modification I made is:
>  static const char * const test_data_4_le[] __initconst = {
> -       "7bdb32be", "b293180a", "24c4ba70", "9b34837d",
> +       "7bdb32be", "b293180a", "24c4ba70", "9b3483d",
>
> The difference in outputs can be seen here:
> https://gist.github.com/arpi-r/38f53a3c65692bf684a6bf3453884b6e

Looks pretty much good, what I'm sad to see is the absence of the test
statistics. Any ideas if we can get it back?

-- 
With Best Regards,
Andy Shevchenko
