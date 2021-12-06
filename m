Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AF746974C
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 14:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244252AbhLFNoS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Dec 2021 08:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244054AbhLFNoR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Dec 2021 08:44:17 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A10DC061746
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Dec 2021 05:40:48 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y13so42901705edd.13
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Dec 2021 05:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZEajfoaUMgQO3wUjsr0AKFBgOxwqqtWRlNRhrN4EWLc=;
        b=rsfpOa7jUnPYmhMXjrmKvAKDasq15WtsVsUZm+qry6uyWbRWV+ExmAmUBpsmXCWzJV
         xZryMpANmJu3fX36FKoW5FKO1lODQq+QUi3BW63FBBPF1cmJHduVjLjkjcvods4zC58C
         APZ2aLAOYq1/lPQd6a49c/7eC6++FrD46747VH9ByKSFrYkP3/NZi77k2k0edvQT8GBT
         hIHp6272hRrk1bHBniIL7wIsrdeljRSlMdbLxb8NeZumZReV9k2zimk8D3YH8fIfuNF7
         srclbdtyOuLgKT8o34xNGFQF0cB8JBH68FxtSLwVF5xXGWpJmCNLCsex9zVBzIGokTrO
         ZmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZEajfoaUMgQO3wUjsr0AKFBgOxwqqtWRlNRhrN4EWLc=;
        b=vKAigqHyeEl3rk7uiB5KKcEJTHJef+rAZrP5LMKjdlHcuy7yScWNdAYwEbaKEr/kS7
         Kpueupc28OifP33K+D8gNYCZBP41euq+QIOwUrARHkscj8YHyyXs1xIzMa/nj5f+iX0V
         EPgpWzNmJVpqIewnCokgFnBO1yaOMtuomtnp8KZdP9GRCF2ZyEKUQIXPOIAXPantUfye
         zqOM7uLBZ/HHdUHql0J9JaNV+SxAiZZJX1LUOCOIdyRkRExJ8Cq3w8K4AxtcuWLdsjOT
         AMRvBYOg3MolytZVcUs1cfCQ7brAz60BhIC7jauTK1kKiEmLxBYeaBDFRnJjVhjc5Yq6
         i2Ew==
X-Gm-Message-State: AOAM5308J2Aw+E08xn16h4GUeqwTYATWhcbYpT7MNWbk466Gf1tuQwpX
        iCpNYmLyOQ62bNqcM8la1uS9ehGavMjWJX06G0hQZvYzBJug0btm
X-Google-Smtp-Source: ABdhPJxazH7u1GuRD1TegRa6qncPcoWD07O91rH2xUDjtvi4KfXf7FTGEgPokhCJs5K+iW7F3RABvxremYNKMSnjkE8=
X-Received: by 2002:a05:6402:354e:: with SMTP id f14mr53829427edd.245.1638798046711;
 Mon, 06 Dec 2021 05:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20211203133003.31786-1-brgl@bgdev.pl> <20211203133003.31786-4-brgl@bgdev.pl>
 <YapnTHQZyNCZXrgp@smile.fi.intel.com> <YapoW+DL4jPo69u8@smile.fi.intel.com>
 <Yapp4vakFxH7JV5B@smile.fi.intel.com> <CAMRc=MeWfKHWFKwRjaqczrfwhAodpDLgrWKF-zqXCsjd=gMv3g@mail.gmail.com>
 <Yap5ctmlw6NeNM+7@smile.fi.intel.com> <CAMRc=MffmFgCZFRziw-QJ+Y3WobJZzUh1Nbp2oym6JLqfnZCdQ@mail.gmail.com>
 <Ya4RHA91Ow9frP8t@smile.fi.intel.com>
In-Reply-To: <Ya4RHA91Ow9frP8t@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Dec 2021 14:40:36 +0100
Message-ID: <CAMRc=MeqGuVsydk4ZKiEKPUv32FdaOUHg7Ee3efUda==RhjXdg@mail.gmail.com>
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

On Mon, Dec 6, 2021 at 2:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Dec 06, 2021 at 09:41:33AM +0100, Bartosz Golaszewski wrote:
> > On Fri, Dec 3, 2021 at 9:10 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
> > This series concerns the gpio-sim driver and it only uses configfs
> > (with manually created platform devices) or device-tree. I would
> > prefer to do ACPI separately and I'd like you to lead that because I
> > neither have any HW to test nor claim to understand it. :)
>
> Please, mention this in the commit message that ACPI is not covered (yet).
>

But the commit message says: "gpiolib: of: make fwnode take precedence
in struct gpio_chip" - it says OF right here. :)

Bart
