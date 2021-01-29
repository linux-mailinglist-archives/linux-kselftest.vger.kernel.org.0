Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BEE308F74
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jan 2021 22:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhA2VaR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Jan 2021 16:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhA2VaN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Jan 2021 16:30:13 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693B4C06174A
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Jan 2021 13:29:32 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x9so119431plb.5
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Jan 2021 13:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tzQsONGruEyjt5Iym23vI9HLnucrCfyMF2lrfS7LSKo=;
        b=dfFvPhN/zaDEnQjnsdzGUnt46hQnAerCAHB5gFqm0IBnwmpGrwbTmzVqeI0kzv2Mxz
         1qh3wayCvSJiVuZRgBzDSiigh+I9pDuxZre2fAbeLPehMrb9TvMpL+/u4vl57JfVLG02
         l7EVSXApCIktH25rMivtF8lrf9drTCAIgiIRh7HDa+mqat5fMR+CeaAsfz9qs6ekv2Zu
         cxe9XdLxOEUysnYGvahF1Z/K3Nn8eIh/h4ys2yKIQ4r+SnSVnGayvrYMUc3ku0bJnPmv
         q1sIDbRJCCmsi/j5O0mtio+Pl165XJIFtZQJuYFP38VRqVSh+ulyUt7KuxNyi5t23sJ+
         hcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tzQsONGruEyjt5Iym23vI9HLnucrCfyMF2lrfS7LSKo=;
        b=oBJgEXPnfO83TOrm50LmflWtLf7B37mkTag40DGSdevgZuvExft5Hm4XJD5JGSQua1
         LNiRDTzRT7zdQhpJBX02HYe3F5IA0SomEy48UxhTyeRogdNgRz7HziO6ZSXbB3pYxUVO
         i2qjMC9BimihYK4cpyIsBPNRbvZDe0p0gHTwKCbZQTd2niNjDQOhTZMuYXB7Hir6Z/+v
         RPLQI2PLmEcBrwPu16iYxNyXxdNfNrWUt+m/skNDu0ig0OjyW3bwRpzEPGOCgX2eD1fz
         2msiwY0Egd8u7pLwdwe1bPVrU0lbvnI243SB/xsd3CASa3TvkVlbiTLq/n3IBTcjeyop
         2ZjA==
X-Gm-Message-State: AOAM531ZPRDRP7XCix79D/3WENMOEbs69bWB8VIN/lc5iaeJ6zNj9NAF
        HOVlDO9WPivGI2owFWuWU7v8S+IoMsEHGH5enikwlw==
X-Google-Smtp-Source: ABdhPJzv8Hua+OLhiVvzmJb2o2ndUE23YH7tA5+ja75YoKggWl2k12NDBeDg1qQaSWCwGAaJZtgHovGqaN2RGoqrxfw=
X-Received: by 2002:a17:902:760f:b029:df:e6bf:7e53 with SMTP id
 k15-20020a170902760fb02900dfe6bf7e53mr5997159pll.80.1611955771785; Fri, 29
 Jan 2021 13:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20210125124533.101339-1-arnd@kernel.org> <202101271213.4F331332E@keescook>
In-Reply-To: <202101271213.4F331332E@keescook>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 29 Jan 2021 13:29:20 -0800
Message-ID: <CAFd5g45+JqKDqewqz2oZtnphA-_0w62FdSTkRs43K_NJUgnLBg@mail.gmail.com>
Subject: Re: [RFC 0/3] kunit vs structleak
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        linux-hardening@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 27, 2021 at 12:15 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Jan 25, 2021 at 01:45:25PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > I ran into a couple of problems with kunit tests taking too much stack
> > space, sometimes dangerously so. These the the three instances that
> > cause an increase over the warning limit of some architectures:
> >
> > lib/bitfield_kunit.c:93:1: error: the frame size of 7440 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> > drivers/base/test/property-entry-test.c:481:1: error: the frame size of 2640 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> > drivers/thunderbolt/test.c:1529:1: error: the frame size of 1176 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> >
> > Ideally there should be a way to rewrite the kunit infrastructure
> > that avoids the explosion of stack data when the structleak plugin
> > is used.
> >
> > A rather drastic measure would be to use Kconfig logic to make
> > the two options mutually exclusive. This would clearly work, but
> > is probably not needed.
> >
> > As a simpler workaround, this disables the plugin for the three
> > files in which the excessive stack usage was observed.
> >
> >       Arnd
> >
> > Arnd Bergmann (3):
> >   bitfield: build kunit tests without structleak plugin
> >   drivers/base: build kunit tests without structleak plugin
> >   thunderbolt: build kunit tests without structleak plugin
> >
> >  drivers/base/test/Makefile   | 1 +
> >  drivers/thunderbolt/Makefile | 1 +
> >  lib/Makefile                 | 1 +
> >  3 files changed, 3 insertions(+)
>
> I think I'd prefer centralizing the disabling, as done with the other
> plugins, instead of sprinkling "open coded" command-line options around
> the kernel's Makefiles. :)
>
> For example:
>
>
> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> index 952e46876329..2d5009e3b593 100644
> --- a/scripts/Makefile.gcc-plugins
> +++ b/scripts/Makefile.gcc-plugins
> @@ -21,6 +21,10 @@ gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL)  \
>                 += -fplugin-arg-structleak_plugin-byref-all
>  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)              \
>                 += -DSTRUCTLEAK_PLUGIN
> +ifdef CONFIG_GCC_PLUGIN_STRUCTLEAK
> +    DISABLE_STRUCTLEAK_PLUGIN += -fplugin-arg-structleak_plugin-disable
> +endif
> +export DISABLE_STRUCTLEAK_PLUGIN
>
>  gcc-plugin-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)     += randomize_layout_plugin.so
>  gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)              \
>
>
> And then use DISABLE_STRUCTLEAK_PLUGIN.

This looks fine to me. Does somebody want me to send this out as a
patch? Don't want to steal anyone's thunder :-)
