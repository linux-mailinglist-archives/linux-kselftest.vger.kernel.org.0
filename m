Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CEA4697B3
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 15:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244850AbhLFOHN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 09:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhLFOHN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 09:07:13 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF195C061746
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 06:03:44 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x15so43629538edv.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Dec 2021 06:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TSuvRVLogrBTe7kkjtZaaRoBFVBTLM1V9jTfiZQ7qsA=;
        b=bnmJrbENlFkg97MPUUdUrqzz5nCyjBxNN6sohNARe2kXU1eeZAAe743j4DUVm/t0pF
         u+IE/9SfSiIeUqmXLD5FuOFQPtc4h9fmSQXjB3dZ5QhFK1gXLzXne1T9elUuMUEhIDcz
         T0KZR2ZvNzSr8fz0gH362G+1W3eUolXwpzOVUDVMQ/7Uq4NHi1eRvOtPCT9zsvw3SJbn
         nAHvpBoWZQQ/sgR/kxSZnKW7Ydqis9HChBbBSk5mfZQlLx5oshiERyHNH9c7lGbfZ0QP
         9fhQNlil6B/k+L9afnqTuZiu6CY3lg/b6gLrI2wn7koxn4Nd0V2FK61sB2abuRW59I5s
         CwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSuvRVLogrBTe7kkjtZaaRoBFVBTLM1V9jTfiZQ7qsA=;
        b=ta4dIFWU5ZwNWh3uEl/wpJiSPefvzHodibFZBp3e1zC887w6fo0no15BxY5Uh6ib8u
         QFZ7K1y1Lo73B3H/eKrlseUu30jy0Cp4Ct/gjionbgJKDfQ7r2S/Z5pl0AoC/8nQm4ZX
         ZlPF41JHrhiZSAWOspMB3xOUCk6Pp0IA49cZy0fLqzwrIkbzf9y5WdwKPut9JTc+Bi2w
         5eDmjGQnVEd9LqtcGD0/Fw94SBeDF5NzmVOcqSqvLLn1o/iDDEwLaLtsHrxz3HEoxy0m
         m4EGuIj3Njtj+um1fJZvTlyUz1ln6zxt5nzp+11XGL30QwdcrxvhLrVNZztW0KIqEY9s
         AvTA==
X-Gm-Message-State: AOAM533SlhrYs3BeSR1isvXuZp1y4/0YTr4IkSNo9qRFAcRZOzRk7vsY
        G5WY/geuGyWL2guJazZorEUyhsEM3Oj3DxFhdSwkLENTWe+nrg==
X-Google-Smtp-Source: ABdhPJymN6t7ERCfnYBwAjGcTnW+awEbTsAbeKhy63aSaMdDBakd2YK4ssUz5EO26SwOQrnY+oSvHnnU5aXX5ZI1bu0=
X-Received: by 2002:aa7:cb45:: with SMTP id w5mr55456086edt.405.1638799422190;
 Mon, 06 Dec 2021 06:03:42 -0800 (PST)
MIME-Version: 1.0
References: <20211203133003.31786-1-brgl@bgdev.pl> <20211203133003.31786-4-brgl@bgdev.pl>
 <Ya4WASlzYGOFWORk@smile.fi.intel.com>
In-Reply-To: <Ya4WASlzYGOFWORk@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Dec 2021 15:03:31 +0100
Message-ID: <CAMRc=MeLVsy3hfVdQdofk+m7VcTYYKLKGyeoyK7T4r87qn6sbA@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] gpiolib: of: make fwnode take precedence in
 struct gpio_chip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 6, 2021 at 2:55 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Dec 03, 2021 at 02:29:59PM +0100, Bartosz Golaszewski wrote:
> > If the driver sets the fwnode in struct gpio_chip, let it take
> > precedence over the of_node.
>
> By the way, have you tried this on pure DT-less/ACPI-less platform
> (CONFIG_OF=n, CONFIG_ACPI=n)? I believe gpio-sim in that case won't work,
> because this doesn't affect swnode case, right?
>

Works just fine on a BeagleBone Black - both the regular GPIO
controllers as well as DT-instantiated gpio-sim.

Bart
