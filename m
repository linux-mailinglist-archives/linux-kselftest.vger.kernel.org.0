Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016946821EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 03:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjAaCL7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 21:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjAaCL6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 21:11:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5F034C00;
        Mon, 30 Jan 2023 18:11:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0803D61207;
        Tue, 31 Jan 2023 02:11:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6946DC4339E;
        Tue, 31 Jan 2023 02:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675131111;
        bh=J4THsiG9lLyLN3k2Af+1RJMzU2KokWwxCCLUO1sPYt8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cm2cfj0u3Ip5CCGI9jFiEtPOTPAfCuRIpoQwi+E5172677H+x+qdVRxhOc0k1kCEP
         B525O3vQ85VjjvOIBvEB1Oy2dct0Fmh4Wr5n+rKyhs7LIaNrNCNNX89UDXDIuBl5DJ
         UZ4bdNRMLzm7bF6BTHUROa6olyodCfIkWQya1BBCAeUEqSQjdRNIhPenmaPCWzIcYi
         WLu6Ogi3hh5l5qDH3hLVqRNDTUF5k5oX9mkpsbAhu7jabpuvkFHVKw95Msw4iEGaRU
         hS3+ZhQf8lJL3niGFgMpxPOyaY4RJfqezeoHXqkYn25UQgwfDlkDy15yWY8j3lttum
         a6saradCwGwmA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-142b72a728fso17635813fac.9;
        Mon, 30 Jan 2023 18:11:51 -0800 (PST)
X-Gm-Message-State: AO0yUKUhBh+ZytLE4OmStgpyTgo3KTvMl5dpT40ozmWz1WlLUk1rsvFA
        zOPKBsnViCRVzI3fqGukG+p3O4mHH9VtrH7q/v4=
X-Google-Smtp-Source: AK7set88x7PTFS/EkgEmwBm7Z2BVIAeds9RHbeMd/xFzfWrHyFzj6viRldUTxcVcDzFNyBcQOd8RnWSxJDDWhbHcY+g=
X-Received: by 2002:a05:6870:330b:b0:163:a45a:9e41 with SMTP id
 x11-20020a056870330b00b00163a45a9e41mr522847oae.194.1675131110687; Mon, 30
 Jan 2023 18:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20230127145708.12915-1-andriy.shevchenko@linux.intel.com>
 <CABVgOSmZsAQcf6Ou_tyZL=hpiJcxMxXzmMfV5wRyCPBsb_d0UQ@mail.gmail.com>
 <CAK7LNASsnDymUS=Pyo77g=0v58fMn38PY66A887nC8_E6_qXAg@mail.gmail.com> <CABVgOSnRC3AuUo4Qc2K3pXEcj3Wbt9LE2DTbejGrPOCKefxB2g@mail.gmail.com>
In-Reply-To: <CABVgOSnRC3AuUo4Qc2K3pXEcj3Wbt9LE2DTbejGrPOCKefxB2g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 31 Jan 2023 11:11:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR8D6E_md3=1dLAc-o73xmKXDRXv9Fi_hiav1VhPSW58w@mail.gmail.com>
Message-ID: <CAK7LNAR8D6E_md3=1dLAc-o73xmKXDRXv9Fi_hiav1VhPSW58w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] .gitignore: Unignore .kunitconfig
To:     David Gow <davidgow@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 31, 2023 at 9:01 AM David Gow <davidgow@google.com> wrote:
>
> On Sat, 28 Jan 2023 at 22:37, Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Sat, Jan 28, 2023 at 3:56 PM David Gow <davidgow@google.com> wrote:
> > >
> > > On Fri, 27 Jan 2023 at 22:56, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > There are almost dozen of .kunitconfig files that are ignored but
> > > > tracked. Unignore them.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > >
> > > Thanks! Only the original root-directory .kunitignore file was
> > > intended to be ignored, and that's no longer as important, and is now
> > > in the build dir anyway.
> > >
> > > Reviewed-by: David Gow <davidgow@google.com>
> > >
> > > Cheers,
> > > -- David
> > >
> > > >  .gitignore | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/.gitignore b/.gitignore
> > > > index 22984d22d29e..e4f2ba0be516 100644
> > > > --- a/.gitignore
> > > > +++ b/.gitignore
> > > > @@ -100,6 +100,7 @@ modules.order
> > > >  !.get_maintainer.ignore
> > > >  !.gitattributes
> > > >  !.gitignore
> > > > +!.kunitconfig
> > > >  !.mailmap
> > > >  !.rustfmt.toml
> > > >
> > > > --
> > > > 2.39.0
> > > >
> >
> >
> > Why is this a dot file in the first place?
> >
>
> In short, historical reasons.
>
> The long answer is that there are two places "kunitconfig" files are
> used: as a user-provided file with their preferred test config (which
> is kept local), and as a recommended test config for a given subsystem
> (which is checked in).
> Originally, no .kunitconfig files were checked in: one was either
> autogenerated or manually modified and left in the root source
> directory. This eventually moved into the build directory, and a
> number of features which de-emphasized it in favour of command-line
> arguments and the (new) checked-in per-subsystem configs, which
> probably shouldn't be hidden.


Do you mean there are two types for .kunitconfig - auto-generated ones
and check-in ones?

If this patch is applied, is there a possibility where
auto-generated .kunitconfig files would be accidentally
added to the repository?





> There's no fundamental reason (other than it being a bit annoying to
> rename everything and update the code) we can't change it, either for
> all kunitconfig files, or just the checked-in ones, if that's
> preferred.
>
> -- David



-- 
Best Regards
Masahiro Yamada
