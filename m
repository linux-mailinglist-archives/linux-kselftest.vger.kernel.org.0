Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F88810F9D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 09:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfLCI2s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 03:28:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46747 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCI2s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 03:28:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id z17so2699402ljk.13;
        Tue, 03 Dec 2019 00:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5oEhfQgkh6INLdW6wa3eTLG84bgQm9Za6O9S9+YUffs=;
        b=eo4Qh7jOOCXXbAe+shu+HJP+6ZdE/VA9D/IsBwKFcv+fhqNIO7FOyZNkFaVKwu6StO
         0DH0mmLewmbyeC0ksEOSnbxYHzgSRnRufiFLfTFCtmKEjdCpbtkjx28riaNCVZJX1vZI
         VEO5SJlDCmnJT2beepGFrsPOIqbT0PBStejXAsPyEabo7Gdr/VprKbn3oEoii933kwLM
         2dhOtpEGzFRXZPfscPZsDJEflvtTbFZarCnv9wRR1wNeD3uztiti3F8jnQbRih3iLtHy
         Gs+iqOjUjs8wStUyXjCfbUUD3ITkByz07DYtrcxuokXphxK7g3P4TX9mHxtOW2jz91pq
         Zo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5oEhfQgkh6INLdW6wa3eTLG84bgQm9Za6O9S9+YUffs=;
        b=nvZ115vnsOEzRRu0x8KNOj+kL6YjFN4csqXB5IwUJXsa1UtGoSLpBthKVSiiAmkvy8
         ZpU+T1HDKee+Q6ThZACbf0gLaN1D0aXa8mplzF8ulHOHZEb9k4N3eX2uAw3c9ehXiOug
         Bq17aGZyLqEPjyvcklHG6ne2tg/clEuqohi2sOKdWwknYEQxR5JDm6788IhOgegAa/Wm
         bPdR59bFOuBCmnsPKoVIvnEPyjGFQWdp2r7ibvw6erEDdm2nxdgkRe8FHRFdU9k1xhrU
         U9keNYLFvdCoLIqBZ2WnRJJXB4dO6a1ChHydu8Q/NJAGKo0OPok0Fjaj53HE2K26N+Yc
         6lIg==
X-Gm-Message-State: APjAAAX1jpURzISzXyPai5hrMoA+9NT+LZmrGorlikjgtKEi01AYfEaJ
        g6t61zYw/06bTHXAJTvDYxclz21I9XreJq2x0u8=
X-Google-Smtp-Source: APXvYqzhtvKxcXPGfDdCxcuKRkf8LkhSldJOtH5NLq+r+zzSSaMNlgbnh7gWBL41PnYneHPYICwutFkXYnU0spkYHds=
X-Received: by 2002:a2e:580c:: with SMTP id m12mr1789990ljb.150.1575361726008;
 Tue, 03 Dec 2019 00:28:46 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
 <1575242724-4937-5-git-send-email-sj38.park@gmail.com> <CAFd5g46bb_46dCpu3t=qT0FMqifS8wodnhjWC7jfpkuhT1ngAQ@mail.gmail.com>
In-Reply-To: <CAFd5g46bb_46dCpu3t=qT0FMqifS8wodnhjWC7jfpkuhT1ngAQ@mail.gmail.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Tue, 3 Dec 2019 09:28:19 +0100
Message-ID: <CAEjAshpyBfo8Pv1jzQfTz2tza5Pr8mLgpWtR_Yt2pp4CkMfmDA@mail.gmail.com>
Subject: Re: [PATCH 4/6] kunit: Create default config in 'build_dir'
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 3, 2019 at 7:41 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > If both '--build_dir' and '--defconfig' are given, the handling of
> > '--defconfig' ignores '--build_dir' option.  This commit modifies the
> > behavior to respect '--build_dir' option.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  tools/testing/kunit/kunit.py | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index f8f2695..1746330 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -114,6 +114,11 @@ def main(argv, linux=None):
> >         cli_args = parser.parse_args(argv)
> >
> >         if cli_args.subcommand == 'run':
> > +               if cli_args.build_dir:
> > +                       kunit_kernel.KUNITCONFIG_PATH = os.path.join(
>
> If you are going to modify the value of KUNITCONFIG_PATH can you
> rename the variable to make it lower_snake_case? UPPER_SNAKE_CASE in
> Python is usually (at least in this directory) used to indicate the
> variable is a constant.

Changed as you suggested in the second version patchset[1].

[1] https://lore.kernel.org/linux-doc/1575361141-6806-1-git-send-email-sj38.park@gmail.com/


Thanks,
SeongJae Park

>
> > +                               cli_args.build_dir,
> > +                               kunit_kernel.KUNITCONFIG_PATH)
> > +
> >                 if cli_args.defconfig:
> >                         create_default_kunitconfig()
> >
> > --
> > 2.7.4
> >
