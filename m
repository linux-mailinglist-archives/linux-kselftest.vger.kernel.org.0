Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349E367133B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jan 2023 06:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjARFdO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Jan 2023 00:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjARFdN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Jan 2023 00:33:13 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4953650871;
        Tue, 17 Jan 2023 21:33:12 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso10042800oti.10;
        Tue, 17 Jan 2023 21:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6beyNixeQ7si9aATYgUYpbzyTnRAgWf99qAfjLOhX0=;
        b=jmVYdJlVrUmo/JB6YywZxIS3LpdpfQBaUISM3nb4kYgjozmyxVsTBE6psVSlxX2duA
         3d6wvh+4G2CasoGnHciSDCDXa6Ap/+xeuzYN2wMkbT7Q9gJcpn8gbcDcVYM7nvHyFuwE
         l9YjdGrBDHVpr4gVVKpL1CIkHUojXKT4XWhT6/nTf6cGFIb1jQ7Nf7A5a1zMdducPoPG
         2vdZ9SuUtA798O7QC+osHSgP2Ek6m3srD8aj/Vi3hv9+Wk88RWRj88pVctwjR6m5Mdll
         MZ84ct0FbYXLgwAUieuolbMmFi2euxzH77FpVznizkMaEHQz/SclfDNzznNqPKpZS8rM
         nQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6beyNixeQ7si9aATYgUYpbzyTnRAgWf99qAfjLOhX0=;
        b=epaSn9F19erXAiOWlGtwcF5ImSil/XEyMdoAPwaPOc5NJps/kb823m+rNakYkHonQj
         GaBLJepMMH0ph6ajhOrQqluXMI9S+ay3OIhhqCoOWo60aFncplc/0Pn2zujtmmS6t4fB
         tVAMCN29UDlkGBlId8nQT1E8RfqHPpq/bKPk2prMKbnezScEvevK1hVDTZw7yelWl4lU
         xomPQQk6wjK6Kgl85cxPq3et6y01Al6ctF5u8iY525eTs5Xd1XNC6SmM/7KuKRaw4wKM
         YJLGJWb9Y5jMp/wN72LEu3V6NLKzLn1wz+xmqTF0a0wNpLkRvhcjc6+lxpdVdt+vir3J
         OmOg==
X-Gm-Message-State: AFqh2koz+abja3lyjSo+DfnYYVXNxa2If3SOFqNfrYL/mXQ1a5gcWvlM
        Kyf2JhaQDNVaFyNDeH7R93iarbSVxMnAA5XKkAEykS0WyI/5cA==
X-Google-Smtp-Source: AMrXdXvlEG41Pgg/uwnXbcg6UV6k5dT3kG7sVgWf3WzSkrl2He8jU4eFDIeYPk/JSfFAsygNfvCTIvbAHUy8T2HiSJU=
X-Received: by 2002:a9d:12d:0:b0:670:6dc1:6c2c with SMTP id
 42-20020a9d012d000000b006706dc16c2cmr314512otu.375.1674019991551; Tue, 17 Jan
 2023 21:33:11 -0800 (PST)
MIME-Version: 1.0
References: <20230115210535.4085-1-apantykhin@gmail.com> <CAGS_qxpoGCXAK=q+unFoYKN0GtH8V9Ojmntz0YZrae8zBeX-qw@mail.gmail.com>
In-Reply-To: <CAGS_qxpoGCXAK=q+unFoYKN0GtH8V9Ojmntz0YZrae8zBeX-qw@mail.gmail.com>
From:   Alexander Pantyukhin <apantykhin@gmail.com>
Date:   Wed, 18 Jan 2023 09:33:02 +0400
Message-ID: <CAPi66w-D-x_rhv+eQBSPqmqpK3nF2_VuizZPA9dZ0kL1=XAf-w@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/kunit/kunit.py: remove redundant double check
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Daniel.
Thank you very much for your review!
Could you advise me whom I can address the V2 patch "to"?

Best, Alex.

=D1=81=D1=80, 18 =D1=8F=D0=BD=D0=B2. 2023 =D0=B3. =D0=B2 01:56, Daniel Laty=
pov <dlatypov@google.com>:
>
> On Sun, Jan 15, 2023 at 1:05 PM Alexander Pantyukhin
> <apantykhin@gmail.com> wrote:
> >
> > The build_tests function contained the doulbe checking for not success
>
> very nit: if we're fixing the "doulbe" typo, can we also do
>   "the doulbe" =3D> "double" (drop the "the")
>
> > result. It is fixed in the current patch. Additional small
> > simplifications of code like useing ternary if were applied (avoid use
> > the same operation by calculation times differ in two places).
> >
> > Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
>
> Thanks!
> I can't believe we never noticed the duplicate `if not success` blocks
> before now.
>
> Some minor suggestions below if we're already going to send a v2 out for =
typos.
>
> > ---
> >  tools/testing/kunit/kunit.py | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.p=
y
> > index 43fbe96318fe..481c213818bd 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -77,10 +77,8 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree=
,
> >         config_start =3D time.time()
> >         success =3D linux.build_reconfig(request.build_dir, request.mak=
e_options)
> >         config_end =3D time.time()
> > -       if not success:
> > -               return KunitResult(KunitStatus.CONFIG_FAILURE,
> > -                                  config_end - config_start)
> > -       return KunitResult(KunitStatus.SUCCESS,
> > +       status =3D KunitStatus.SUCCESS if success else KunitStatus.CONF=
IG_FAILURE
> > +       return KunitResult(status,
> >                            config_end - config_start)
>
> nit: perhaps we can shorten this to one line, i.e.
>   return KunitResult(status, config_end - config_start)
>
> >
> >  def build_tests(linux: kunit_kernel.LinuxSourceTree,
> > @@ -92,13 +90,8 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
> >                                      request.build_dir,
> >                                      request.make_options)
> >         build_end =3D time.time()
> > -       if not success:
> > -               return KunitResult(KunitStatus.BUILD_FAILURE,
> > -                                  build_end - build_start)
> > -       if not success:
> > -               return KunitResult(KunitStatus.BUILD_FAILURE,
> > -                                  build_end - build_start)
>
> Oh huh, I guess this duplication comes from commit 45ba7a893ad8
> ("kunit: kunit_tool: Separate out config/build/exec/parse")
>
> @@ -64,78 +84,167 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
>         build_end =3D time.time()
>         if not success:
>                 return KunitResult(KunitStatus.BUILD_FAILURE, 'could
> not build kernel')
> +       if not success:
> +               return KunitResult(KunitStatus.BUILD_FAILURE,
> +                                  'could not build kernel',
>
> > -       return KunitResult(KunitStatus.SUCCESS,
> > +       status =3D KunitStatus.SUCCESS if success else KunitStatus.BUIL=
D_FAILURE
> > +       return KunitResult(status,
> >                            build_end - build_start)
>
> ditto here,
>   return KunitResult(status, build_end - build_start)
>
> >
> >  def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
> > @@ -145,7 +138,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree,=
 request: KunitExecRequest) -
> >                 tests =3D _list_tests(linux, request)
> >                 if request.run_isolated =3D=3D 'test':
> >                         filter_globs =3D tests
> > -               if request.run_isolated =3D=3D 'suite':
> > +               elif request.run_isolated =3D=3D 'suite':
>
> This is better, thanks.
>
> Daniel
