Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F2A22A253
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jul 2020 00:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgGVW3T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jul 2020 18:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgGVW3T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jul 2020 18:29:19 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8AEC0619E1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jul 2020 15:29:18 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id j1so1810575ybh.10
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jul 2020 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hDU5F+lKnx2jbAbcQ8EdWpqtNDoD+1zrWyM5bAIpN5w=;
        b=fhWMlcxqko5jvxwun7u9Uh71irn2Il2ZaOvNhovugAKiQoGmJ9IDiPrToHA8cjDMRu
         x1VrYa/E0VvPZoA+NaZhZXbLqncS8YhFZHpYr0fz0yhxXm9p5ySMNW38C59WR90QeHIN
         kWZ4lbpJlxdBM/tAzlp6Aj4Twlsi8M1xoZanH3IeoZa029h5A781Eq8/2XYuLuPXNnUZ
         r/RdyDA+lFa6N7kQAAG4rnbsYAyFVjv9fgJaUVY06JmjP2AsOflm13HWTc3BgsiQLiG/
         t3SwYffYY1obba81noPsvPY03PPzwOCaRAq0ZEtJmkURsIdWLd/Lf5moo2ds+3peAf40
         Zsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hDU5F+lKnx2jbAbcQ8EdWpqtNDoD+1zrWyM5bAIpN5w=;
        b=RCi1bsGxg17oG0iW4EW/0o24kdlM3N0EP5VdCqUyamziXbRD5EKD652VRj4hd9vv7J
         jiuyEBCuiX6NcW/PIoHY0R+iE+mcLAiHiTCnFe3ijk4m7spQOAHJddeH2eXRhwRVB04A
         gub6dfHOaDY6Udw6a5q06f2IIP7NaE17Cp4CVFgB3Z2l3ePgd/mIGB48FlsXrQWKIv1o
         3BTZtRTt0XZHpYCgyZav250IbmaW06lkiAJXkLKZZDyTkOwOhcOhJz/tRRRWtK6zkOR0
         v1Kf5g7AM6LYpSzZRYhwY6pmi+XR9jnZlEa0DAxo+5+On7Z5rKblx87UAU5He8vAg/xn
         sxIQ==
X-Gm-Message-State: AOAM53273Ccs52Uw0TDyq0CZgsgKy5z9WUWwIdqpNX3ZWvSLXXQUVzCb
        X45fiS+dvRQldnC/9RRdAFKBDaNWUHKGnvfxq/VBaQ==
X-Google-Smtp-Source: ABdhPJyLKRl2cLOz/lGg7WJPCuMu3otLZQXrSRuCWupUdKjm0eoPDEEAPrS2s+m18HN0tAIQub01+IJfHDQ0XRTs6cM=
X-Received: by 2002:a25:ae01:: with SMTP id a1mr2350192ybj.119.1595456957139;
 Wed, 22 Jul 2020 15:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200721174654.72132-1-vitor@massaru.org> <202007211207.5BAA9D8D@keescook>
 <CADQ6JjU8rX2F_iBqth3u0EiA+CBgz4H+YL_-nbQ_cojYeLFXKQ@mail.gmail.com>
 <202007211911.666E080@keescook> <CADQ6JjUgVXBfHfb=V2ajwm=rHi12rxiqEtpivjY03xZbp6k7wg@mail.gmail.com>
 <202007221244.4E3C9E45@keescook>
In-Reply-To: <202007221244.4E3C9E45@keescook>
From:   Vitor Massaru Iha <vitor@massaru.org>
Date:   Wed, 22 Jul 2020 19:28:41 -0300
Message-ID: <CADQ6JjV8cXsEKX-Yn2udhnZgJQWkbtS4XL+yaRzfydaWV5EbSQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib: Convert test_user_copy to KUnit test
To:     Kees Cook <keescook@chromium.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 22, 2020 at 4:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jul 22, 2020 at 03:29:27PM -0300, Vitor Massaru Iha wrote:
> > On Tue, Jul 21, 2020 at 11:12 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Tue, Jul 21, 2020 at 07:19:12PM -0300, Vitor Massaru Iha wrote:
> > > > When you talk about end-of-test summary, is it what is written in
> > > > dmesg and not the kunit-tool?
> > >
> > > Right, if I build this as a module and do "modprobe user_copy_kunit",
> > > what will show up in dmesg?
> >
> > No, It doesn't. I'll put the messages again.
>
> Would it be possible to add that behavior to the core KUnit output? Then
> all module-based tests would include a summary line?

Nowadays with modprobe this is shown, is it necessary to add anything else?

root@(none):/# modprobe user_copy_kunit
TAP version 14
    # Subtest: user_copy
    1..1
random: fast init done
    ok 1 - user_copy_test
ok 1 - user_copy
root@(none):/#

>
> --
> Kees Cook
