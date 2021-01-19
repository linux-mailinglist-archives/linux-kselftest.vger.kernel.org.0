Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419C62FBDFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 18:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbhASOug (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 09:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405084AbhASLDG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 06:03:06 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2284CC0613C1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 03:02:25 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id by1so21483800ejc.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 03:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IZnuFpYCbe19cxJ76+YpreCLRQ8tQhMPYw7R6ZL2WJ4=;
        b=dVu1QHRn/OV4BOewEbA4LqB3AIVpAdfJEJLBv0uhl0JUfflCX6PZh9qezPrSY1MTUe
         EFVugQ8DUoKHFvnVKfTunkq7Uu/Tgmg3mhLL5XWZ1e0j1CsYJdEJ1IPCMsXY5NsSr1r8
         X6nj0wlDdTBpxSSLVxQt0/nk2WMvYwjZlV+8yrgeMSmVA5M+4oQe+4gODTYB6j4r2HgG
         A5zfX4nOKEBo/CufPTw0ywH/WmG34BemWdLgvQlnC7s1puuZ6JexzrrCEqfg+/AFzyZH
         BJdACal/KGggSQB7dFfZ99cha2X3ey4VjJqkD0NcljqFfqnJgeUay9wRukRlptxvk6CK
         scbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZnuFpYCbe19cxJ76+YpreCLRQ8tQhMPYw7R6ZL2WJ4=;
        b=M0NUC2dpjUhSDKE35k+JyWX+xeiaXPBFDIsxNB9s+eiNViG0O6EYlUchMCx7U5AOwc
         5SqBpg2sZ9rM5fyzd1nqsPkeIs7eWTIL5J7O5Kehvok15+u7ocPH0ORWWx6/N+aCbBR3
         AXmwCs4FXGQDmWYmM8rI67rzeCrNkYVQ/RwPdVZQ/UEZLKAX/H0+SkUCq4s15vhUZvdW
         BQ0BSCQfXvz1+5GUka0l92XuuVkAM1O9SMRo8ufSBEXHpkXHz17ZgYKIif+ceWFn3Ucm
         RwGtHpuCvQIlBJyJyZI13LdS3YQz6Gx+/5Y0knpB20XHOyc1hATFdS4AGYsEp0/QjAiA
         RUYw==
X-Gm-Message-State: AOAM531tB+JFooAKuNI4UkwbfwgPImkD406lA8F7GWLlOFCIsUiNwUgA
        M+RK8oBpvjN19sAXcTD7j0+z8McvGTdkWgaBYU34HA==
X-Google-Smtp-Source: ABdhPJylYL+wams8p2wrCMy5DerxN+e+CypiMkGgUS49QH9T5mRlqQu3e4Vb0lqDoSie0F/lQn865oEnI2Cd8ScbyT4=
X-Received: by 2002:a17:906:3146:: with SMTP id e6mr2479848eje.363.1611054143645;
 Tue, 19 Jan 2021 03:02:23 -0800 (PST)
MIME-Version: 1.0
References: <20210107025731.226017-1-warthog618@gmail.com> <CACRpkdZf2GhScg=sUG35nA5P6jXH93uuK0Fq_uhz29wBQLHOKQ@mail.gmail.com>
 <20210119003455.GB5169@sol> <CAMpxmJUkFL+w7afS2NKF-xiMR==HVR1Mk8uQm3782DBoG0qneA@mail.gmail.com>
 <20210119105933.GA21741@sol>
In-Reply-To: <20210119105933.GA21741@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 19 Jan 2021 12:02:13 +0100
Message-ID: <CAMpxmJWMQ2uVJ77MYPr3dhy0=-P8FtAfz3BSoKbxh33J0Gx=Ug@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] selftests: gpio: rework and port to GPIO uAPI v2
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 19, 2021 at 11:59 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Tue, Jan 19, 2021 at 11:37:46AM +0100, Bartosz Golaszewski wrote:
> > On Tue, Jan 19, 2021 at 1:35 AM Kent Gibson <warthog618@gmail.com> wrote:
> > >
> > > On Mon, Jan 18, 2021 at 04:04:51PM +0100, Linus Walleij wrote:
> > > > On Thu, Jan 7, 2021 at 3:58 AM Kent Gibson <warthog618@gmail.com> wrote:
> > > >
> > > > >   selftests: gpio: rework and simplify test implementation
> > > > >   selftests: gpio: remove obsolete gpio-mockup-chardev.c
> > > > >   selftests: remove obsolete build restriction for gpio
> > > > >   selftests: remove obsolete gpio references from kselftest_deps.sh
> > > > >   tools: gpio: remove uAPI v1 code no longer used by selftests
> > > > >   selftests: gpio: port to GPIO uAPI v2
> > > > >   selftests: gpio: add CONFIG_GPIO_CDEV to config
> > > >
> > > > Bartosz I think you can just merge these patches into the GPIO tree, at least
> > > > I think that is what I have done in the past.
> > > >
> > >
> > > Could you touch up that Fixes tag in patch 1 if you merge v2?
> > >
> > > Thanks,
> > > Kent.
> >
> > Kent,
> >
> > This doesn't apply to my for-next branch - there's a conflict in
> > tools/testing/selftests/gpio/Makefile, could you take a look?
> >
>
> Which is your for-next branch?
>
> The patch set is based on and applies cleanly to gpio/for-next 7ac554888233,
> so I'm not sure which branch you are targetting.
>
> Cheers,
> Kent.

Linus W is not picking up patches this release - everything goes through:

    git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next

Sorry for the confusion.

Bartosz
