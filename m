Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E772E06AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Dec 2020 08:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLVH1U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Dec 2020 02:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVH1T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Dec 2020 02:27:19 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF0CC0613D3
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Dec 2020 23:26:39 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m25so29601992lfc.11
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Dec 2020 23:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Vx3cDcQdZKzUI+ck2Dq/cx3S5niRqUMe+pbtUC7RZQ=;
        b=D8a9vSc3LvG7f9fa448uE0iHZ5ZnyLqNK7jv2O2fQoFK+uAXaa8/xq3jNLnlEbeuep
         wPt09auzDKJnmrgniyHJ9Za9NghR03THIjPVefd0yAEZbiEWcIJU7tSIpoCqF+SixWNK
         lXDIxRHdpDYESJBypkmxr1LrJUM6peG28AmpP5VIEGHkukeZ7SppIEXzy4lLEcq65pES
         zjCUSsrfvXOVVR0XUpt2dPDO/p1ijOmBDiiEtTqiTK7N62aE7v5+inpf/c4aW8bWnWya
         9+jYO80cPzKAivqfWs95yU2fhIi0ZKXlGf4MC2Z3bVfRhyQ7vkUhyPiiCO4Zy4gSEZCq
         QPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Vx3cDcQdZKzUI+ck2Dq/cx3S5niRqUMe+pbtUC7RZQ=;
        b=spj3sglRA1fawJNstey0JC56Ya319MMiK21ALj39Nhro+w69WdTDg6u6ESwhOtnEzz
         TSG9U0/P24/NTLAADDepJ+k8f9lPQ+m0eKo75DGSNAMT2ijUiVdehs5ZoGLlTrqnQTpw
         XSYXKERfdyoJC83mVQ0uiDVJoLGXMuTfaclrcQaleP/DTrdD6QeG1oLkkIlPDyWAFTmw
         x2oUEtzdP7welSwn2AbAyWYmOf80i27AubpdPuycmdCmUnN6CglUh69XA3P7JlVD4I+v
         gtXZnv5g5mDhuDf1kb4TwTmLUQOSZLk/y3nkjGvpRzdZR5p3uKhkKerJ+BwM4SlmV4Ji
         OoYA==
X-Gm-Message-State: AOAM533x0U02zqjl/8SbovYhWz5Vak6JotbFlwoN1KnjK/f7+wYH0/Bf
        ouidqBFnTj/s8xeWaHBPBvzudP2CNa7w/+XgmKeJmw==
X-Google-Smtp-Source: ABdhPJxZxuekKRO2zDzHiVTw1BlEgjFdnx+eefeFPwlTgTdBYVfSJE2eTpqpoiGj6FrqrytJiaRDk9b79vmNI7lPris=
X-Received: by 2002:a05:6512:3051:: with SMTP id b17mr6005552lfb.16.1608621997509;
 Mon, 21 Dec 2020 23:26:37 -0800 (PST)
MIME-Version: 1.0
References: <20201221144302.GR4077@smile.fi.intel.com> <20201221144510.GS4077@smile.fi.intel.com>
 <2d4b8148-48ca-290f-1d66-33e302e7571d@linuxfoundation.org>
 <20201221192757.GZ4077@smile.fi.intel.com> <20201221194008.GA4077@smile.fi.intel.com>
 <20201221200332.GB4077@smile.fi.intel.com> <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
In-Reply-To: <CABVgOS=tz-611qhrn-pcgokyJeS_NStfxPRBnT60KpPhBVPGpA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 22 Dec 2020 15:26:24 +0800
Message-ID: <CABVgOSnGnFf_LUhcbPxDYYq8q1f3aC228k2kas8=uXMvwVORLQ@mail.gmail.com>
Subject: Re: kunit stopped working
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-um <linux-um@lists.infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 22, 2020 at 9:43 AM David Gow <davidgow@google.com> wrote:
>
> On Tue, Dec 22, 2020 at 4:02 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Dec 21, 2020 at 09:40:08PM +0200, Andy Shevchenko wrote:
> > > +Cc people from culprit commit
> >
> > Guys, revert helps. I am open to test any solution you may propose, thanks!
> >
> > ...
> >
> > > # first bad commit: [757055ae8dedf5333af17b3b5b4b70ba9bc9da4e] init/console: Use ttynull as a fallback when there is no console
> >
> > --
>
> +CC linux-um
>
> There appear to be two problems here:
> 1. UML now no longer has console output by default (which KUnit needs
> to get results)
> 2. UML now seems to crash on startup when ttynull is used (which is now default)

Whoops. I was wrong about number 2 here (thanks Johannes for pointing
that out). The segfault in n_tty_open() actually happens normally as
part of UML startup, and it's recovered from perfectly.

So the only real issue is that this is changing the default console
output to ttynull, and hence hiding the output.

>
> This can be worked around for KUnit by passing console=tty to the
> kernel. I don't think this is a "correct" fix, as UML seems to be
> crashing out-of-the-box anyway (see below), but it may be worth us
> forcing this as we require the console output as well.
>
> In any case, this patch fixes it in kunit_tool for now. I may submit
> this as a proper patch anyway, but that won't fix UML in general:
>
> diff --git a/tools/testing/kunit/kunit_kernel.py
> b/tools/testing/kunit/kunit_kernel.py
> index 57c1724b7e5d..698358c9c0d6 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -198,7 +198,7 @@ class LinuxSourceTree(object):
>                return self.validate_config(build_dir)
>
>        def run_kernel(self, args=[], build_dir='', timeout=None):
> -               args.extend(['mem=1G'])
> +               args.extend(['mem=1G', 'console=tty'])
>                self._ops.linux_bin(args, timeout, build_dir)
>                outfile = get_outfile_path(build_dir)
>                subprocess.call(['stty', 'sane'])
>

I'll send this out properly as a patch to kunit_tool: while I still
think that the default console on UML shouldn't change, it probably
makes sense for KUnit to not rely on the default.

Cheers,
-- David
