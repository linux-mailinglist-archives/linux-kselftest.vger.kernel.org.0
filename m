Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920A213B636
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 00:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgANXxL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jan 2020 18:53:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46931 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgANXxK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jan 2020 18:53:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so5901639pll.13
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2020 15:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j2E7ZFy6aieNRC/FnnKvvkc+wJEJ/BlK5p7TcHenYqg=;
        b=Fb+1mHnYFzLqwCbfsucuxwt0wY+h3w4IlMju1fc0DKE2j5G5drb/oMOhZOLjmhY6Cm
         UBSBLkcRwfQkWW3VcGlkbdZFmm/CxHmc/2Cyf3jsXzVSebCwPNJ3gbxegEJgO4vqXYuB
         O6G/wcmz551H/oc5Zazco/bimLiHWykwQs3jvWoCtz62t2knGN1/LLs8UoT4ZgOKAYWH
         xfsjM0/XnppMiz0cPvApP3BH8y6C9sq7q14LY5ZBZd7oVtj9doWc8+zZqozQo5urFXRP
         BYH5UgxcjFbZ66PDI/USdqohoUsrFnrXl82ZSjpngY7c4LxdgZrXmdEbjMwrrUsUffKQ
         DEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j2E7ZFy6aieNRC/FnnKvvkc+wJEJ/BlK5p7TcHenYqg=;
        b=s6zO7RU2bWVZJLgnY7l7M+wlLW/apLVyDkZm9eOOFbDrTeYBSQM8vMsCH/DVRSBYVa
         kzTgbrzR00bi63+ng7fvbdZwVSSdYSCM9qqnmwvn88rta+mx8nFd5qRDuHGDYqRk1Ykh
         7gN0ZPg1GB1O0cXadyxtxqf78D+FMMDbmwYXrDdbJmWCHM4qj8pkxlyW9mSLW+atKPKU
         qXWQzZgVQXuIvnG4N+OjalBo+XWQ3iXC/JFSEle+s0+dCIa37tUneO1KFO/82g1KAO3D
         za0mvTg7/pcymIVE6QM27W0b+R3A7Du8eneqnknHMYb9V3wORcFyea+TqtH2nEGdbBWu
         RFUA==
X-Gm-Message-State: APjAAAUPJWLsZ+yCTnvAtIkoQewnywyXnduUCMik4de3xYpLEtbFA8/t
        ym2mJnbBqmzGny/ZD+L1AXdg1bw80dHcikAeFHO26w==
X-Google-Smtp-Source: APXvYqwnx0dad7N/SaM9hd+5nBJXlA/iobnlbtzjmtuuf7lccodkk2OuAJgL+VX8zJSDFFC3D20UmtA5hgMoLN2iXRA=
X-Received: by 2002:a17:902:7d94:: with SMTP id a20mr22016821plm.297.1579045989763;
 Tue, 14 Jan 2020 15:53:09 -0800 (PST)
MIME-Version: 1.0
References: <1579018183-14879-1-git-send-email-alan.maguire@oracle.com>
 <alpine.LRH.2.20.2001141639240.15464@dhcp-10-175-171-251.vpn.oracle.com>
 <51d7d427-2ef6-b0cd-ad23-2fb75b06b763@infradead.org> <1973062.CA44Rh9njY@kreacher>
In-Reply-To: <1973062.CA44Rh9njY@kreacher>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 14 Jan 2020 15:52:57 -0800
Message-ID: <CAFd5g46q94DZYtk-dfDaX=nNaGdXoYZeshvTiFh6D8UsQrvVHg@mail.gmail.com>
Subject: Re: [PATCH] software node: introduce CONFIG_KUNIT_DRIVER_PE_TEST
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 14, 2020 at 2:43 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Tuesday, January 14, 2020 5:45:56 PM CET Randy Dunlap wrote:
> > On 1/14/20 8:42 AM, Alan Maguire wrote:
> > > On Tue, 14 Jan 2020, Randy Dunlap wrote:
> > >
> > >> Hi Alan,
> > >>
> > >> On 1/14/20 8:09 AM, Alan Maguire wrote:
> > >>> currently the property entry kunit tests are built if CONFIG_KUNIT=y.
> > >>> This will cause warnings when merged with the kunit tree that now
> > >>> supports tristate CONFIG_KUNIT.  While the tests appear to compile
> > >>> as a module, we get a warning about missing module license.
> > >>>
> > >>> It's better to have a per-test suite CONFIG variable so that
> > >>> we can do selective building of kunit-based suites, and can
> > >>> also avoid merge issues like this.
> > >>>
> > >>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > >>
> > >> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > >>
> > >
> > > Apologies for missing you out here.
> > >
> > >>> Fixes: c032ace71c29 ("software node: add basic tests for property entries")
> > >>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > >>> ---
> > >>>  drivers/base/test/Kconfig  | 3 +++
> > >>>  drivers/base/test/Makefile | 2 +-
> > >>>  2 files changed, 4 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/base/test/Kconfig b/drivers/base/test/Kconfig
> > >>> index 86e85da..d29ae95 100644
> > >>> --- a/drivers/base/test/Kconfig
> > >>> +++ b/drivers/base/test/Kconfig
> > >>> @@ -8,3 +8,6 @@ config TEST_ASYNC_DRIVER_PROBE
> > >>>     The module name will be test_async_driver_probe.ko
> > >>>
> > >>>     If unsure say N.
> > >>> +config KUNIT_DRIVER_PE_TEST
> > >>> + bool "KUnit Tests for property entry API"
> > >>> + depends on KUNIT
> > >>
> > >> Why is this bool instead of tristate?
> > >>
> > >
> > > The support for building kunit and kunit tests as modules has not merged
> > > into linux-next yet, so if we set the option to tristate the build would
> > > fail for allmodconfig builds.   Once it's merged we can revisit though; I
> > > should have mentioned this, thanks for reminding me!
> >
> > Oh. I see.  Thanks.
>
> Patch applied, thanks!

Cool, looks good. Thanks!
