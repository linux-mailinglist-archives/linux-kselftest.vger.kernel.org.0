Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A389345874D
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Nov 2021 01:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhKVAF4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Nov 2021 19:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhKVAFz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Nov 2021 19:05:55 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC12C061714
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Nov 2021 16:02:50 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id u74so34280811oie.8
        for <linux-kselftest@vger.kernel.org>; Sun, 21 Nov 2021 16:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQkLqKDE0H9YwXXJ1zrR6AA7PdcZT038DZZN0r6ZUUg=;
        b=y5HQHAnTnKWTfXsXe9mqwk5iADXGSxEwzRRjYGT36sbAcW/153mT4BAOv+DGUrXZbz
         8wg+4eyMS2oVD+r0aDy4m+UiYp2/RvPKVvqepdD96M3CKkYNDuzXVVwPs/j8s2u5dlN2
         LDH89Y5B0xet6Nltj8JPBsskovYHEpKZCDRb2fnIEk3wbHCmJ217eyDSHEtdOicZMKVt
         H/AthpcXKePE0em9nOHExd1+ZZQbVNzNtXmVbaKCeq9QyJz0k1KR5E8GLnx/FO00u9Xq
         RF8zLYM3fiojHLF72FEpc4rH97WOIsGw5C9g6urec9EQCLwk+m42zJPZ+CFLs2puh0a0
         4f3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQkLqKDE0H9YwXXJ1zrR6AA7PdcZT038DZZN0r6ZUUg=;
        b=1OGymJB2c7vpMLwiWKCjY50E3f0c5e/MHFPEPV1zfNw1ITJzKHcwpX+/BH9I2dBzBL
         tTh8LZKUPY0qc+KkLDuGar5+jvv3nSF6FrGjIL/ha9yfKrQZcBb3obKzJ2Zu/Ig5B3ep
         QvS9R+k4BVVwIFlriPtn0FIfY2dgDdXq5cF6m3ChB3Ab24d44DvuMznGL5QP1ozllOGB
         ts/TEdyAblHDBca8sLiDkkxeBqFy3/QcurUSZi4XtEB1gGTVqDFaGhf39Np+NZ3O8oPS
         X4j5DlL2CovdTxoZgbcE5Vi7VaCtX72CgX9ce4V8bHtzaKdgFH4VTCEJVRT4dOYnzpzg
         /WXA==
X-Gm-Message-State: AOAM530F0WQFXs5nNKglNnsosTmw83xp9JrK4Q4eDi7BIuuDJNBGAlFT
        BGByMa/EnKIVNvyFTy2jlr+ndhK1PZOJr1+L4HoS0A==
X-Google-Smtp-Source: ABdhPJzqyDfm7zh4TSMLOwrStOYwp8ExgHvFYRGqaq6CkhtzWiqrOdIOfUWA9OGs8SLcwDpyhrmrq6BXCZ7f0RX/kSU=
X-Received: by 2002:a54:4791:: with SMTP id o17mr18098001oic.114.1637539369551;
 Sun, 21 Nov 2021 16:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20211118145142.14519-1-brgl@bgdev.pl>
In-Reply-To: <20211118145142.14519-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Nov 2021 01:02:38 +0100
Message-ID: <CACRpkdbn=govgPeiEEtVF_+bMYD1Oi1yC+diZ2-owO4O6-oCwg@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] gpio-sim: configfs-based GPIO simulator
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 18, 2021 at 3:51 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> v8 -> v9:
> - dropped the patches implementing committable-items and reworked the
>   driver to not use them
> - reworked the gpio-line-names property and configuring specific lines
>   in general
> - many smaller tweaks here and there

The series:
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Let's go with this.

Yours,
Linus Walleij
