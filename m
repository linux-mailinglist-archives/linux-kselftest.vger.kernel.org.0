Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E1367F8B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jan 2023 15:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjA1OiC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Jan 2023 09:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjA1OiB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Jan 2023 09:38:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704E61DBB6;
        Sat, 28 Jan 2023 06:37:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31498B80AF7;
        Sat, 28 Jan 2023 14:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEA9C433EF;
        Sat, 28 Jan 2023 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674916676;
        bh=iXGDlDOkqkta/Z58ealtpbtCBeGmkOhnAEC3w3OPfwg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tkt5Glyvw0QqmgywWHi2l3lzhfMwhT4oR0rveAgDXRHPW4f4hX0WqeL6vDhfZlkSk
         sa6Gxgop9fXux2qqpZC1vR21rCySOKDu/P1JVjM5e+Q4xiDRw73Ifq1ZnzwqTx80p1
         932BJ50szkcxaCH1AvtOhRei2hbLo0bdzdzk80ZXvE1jQFZUmBmsQSmp+wcZbad2cL
         ht3SezMgGVEXTrKKaeFcC+FuKebyikjA4VKNC7Om8cEqwovSgxI3w1y2FfGX1iGrHy
         Q0H/SqCdhX+gqDmVrqb9K8gqn1pRLn1sxEiFI2l2t0q5UxROspVC1G2I1jHwFMJ1Qa
         OPaBennunl2Dg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-15085b8a2f7so10058774fac.2;
        Sat, 28 Jan 2023 06:37:56 -0800 (PST)
X-Gm-Message-State: AFqh2krYvNcW0z4hecyy2O6AaJ3WMsFEI6I2AR/JAqX8cjQ2ITUjt1BC
        gtcK5/nptk63gLjybYSs/kxvf1l8oQsOb6P/gxE=
X-Google-Smtp-Source: AMrXdXsERdJlo7WuxJROs7wS3BSFmieADBiftQj1REUnPUGJxvGoEpGkxWvUx5FDx4/71q9ZWyj0wNifjKoYIwojxK4=
X-Received: by 2002:a05:6870:c20b:b0:15f:1e44:71fd with SMTP id
 z11-20020a056870c20b00b0015f1e4471fdmr2525755oae.194.1674916675934; Sat, 28
 Jan 2023 06:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20230127145708.12915-1-andriy.shevchenko@linux.intel.com> <CABVgOSmZsAQcf6Ou_tyZL=hpiJcxMxXzmMfV5wRyCPBsb_d0UQ@mail.gmail.com>
In-Reply-To: <CABVgOSmZsAQcf6Ou_tyZL=hpiJcxMxXzmMfV5wRyCPBsb_d0UQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 28 Jan 2023 23:37:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASsnDymUS=Pyo77g=0v58fMn38PY66A887nC8_E6_qXAg@mail.gmail.com>
Message-ID: <CAK7LNASsnDymUS=Pyo77g=0v58fMn38PY66A887nC8_E6_qXAg@mail.gmail.com>
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

On Sat, Jan 28, 2023 at 3:56 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, 27 Jan 2023 at 22:56, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > There are almost dozen of .kunitconfig files that are ignored but
> > tracked. Unignore them.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
>
> Thanks! Only the original root-directory .kunitignore file was
> intended to be ignored, and that's no longer as important, and is now
> in the build dir anyway.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
> >  .gitignore | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/.gitignore b/.gitignore
> > index 22984d22d29e..e4f2ba0be516 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -100,6 +100,7 @@ modules.order
> >  !.get_maintainer.ignore
> >  !.gitattributes
> >  !.gitignore
> > +!.kunitconfig
> >  !.mailmap
> >  !.rustfmt.toml
> >
> > --
> > 2.39.0
> >


Why is this a dot file in the first place?



-- 
Best Regards
Masahiro Yamada
