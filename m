Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2019B2F6E3A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jan 2021 23:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbhANWa0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 17:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbhANWaZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 17:30:25 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43ACCC061757
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 14:29:39 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id z21so4748430pgj.4
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 14:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jfloksm1SzDZHkQm/k7XRNgYEOtyR/QoHOtukweU6Go=;
        b=jAy/zgngnl7Cr8dZ1T6s8xX7k7uJo2CHAKNkrDhsaLe7PMYCMXzpUgsLqXx0PyB4HA
         x3MMXaBTb8stzzM2yQlrJBcf9HjmOx60qncvKR5Ka+ByULIxVIgBpNATbYtslrgOUegA
         cFzRjQH/RFSEqOcyuzk96g/BSXDF6tO7LazgCeXS4T4h1BkJIZ33mMrhWzWxoY74Zeua
         FYeouTHj0CXdnovOYkXMjXeeyqYsa4TKdn7L9FaJu1Zv9FLwbsrPIj8hirQilPC+NuuS
         7Mx5+KWu6Wir/fhMR+GDmhxWxV4sjRIM9PSZNWTT1m6UGPxqK8Z83NmNUViKm86dwj4b
         2VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jfloksm1SzDZHkQm/k7XRNgYEOtyR/QoHOtukweU6Go=;
        b=t4g50iuR1cIfzMD4elpQgLWW5OUxKVYbsGpflVZ5hWFIFXFMf0G5R54kwA9FzsskV/
         nyNwtt28+v9J+rLUQ27NufdeJ29ipK8igivdqUi002wjVJ4+giakD5gcC2S/ytxUG0jv
         1eUSKpcneKkDLD0U12EJAOW76wbtmJ0ep3Jkve2asHiGtQaRidYzq2MuHgmnXlqSJqjC
         nmV5oRLUosT45p1ISXJdWnaIUkjgNj6VOA5TMjASe7GI7qOqijfu1MmfZ5ig6j9uZkMy
         eoqIoPNdQjsKNa5/LCDgl4oW1aaxfy4wCeM5hy4RMh1sSR4ruXXpaQhl3gn4klwR3YY0
         g43g==
X-Gm-Message-State: AOAM531YeATj6IydxHdI68i+Ig1sDHDtM3AIrhTWNa0svAr+zO+jGXMC
        F7Th4pt/Uvynrhiq5bFP8u6iwUvsDWKSLmMEtpEBdA==
X-Google-Smtp-Source: ABdhPJxIRuKrgiI26rwZ5dYnvENjdprC/CMY3G6TwD8w6ga+aQlc40GZow6nwH0yRLNwSYFROZNh5WYQ7Mw11dCILoc=
X-Received: by 2002:a62:1409:0:b029:19e:14d1:efb0 with SMTP id
 9-20020a6214090000b029019e14d1efb0mr9313677pfu.14.1610663378574; Thu, 14 Jan
 2021 14:29:38 -0800 (PST)
MIME-Version: 1.0
References: <20201216002246.3580422-1-dlatypov@google.com>
In-Reply-To: <20201216002246.3580422-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 14 Jan 2021 14:29:27 -0800
Message-ID: <CAFd5g45JEkdy8vmnr2F19uCVXwYC4J=neNR0ZyL+weaoxrM8DQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: include example of a parameterized test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>, Marco Elver <elver@google.com>,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 15, 2020 at 4:23 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit fadb08e7c750 ("kunit: Support for Parameterized Testing")
> introduced support but lacks documentation for how to use it.
>
> This patch builds on commit 1f0e943df68a ("Documentation: kunit: provide
> guidance for testing many inputs") to show a minimal example of the new
> feature.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Tested-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Brendan Higgins <brendanhiggins@google.com>
