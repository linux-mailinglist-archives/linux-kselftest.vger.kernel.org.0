Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D7959CBF2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 01:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiHVXMw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 19:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbiHVXMv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 19:12:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2C9474C4;
        Mon, 22 Aug 2022 16:12:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w29so6238854pfj.3;
        Mon, 22 Aug 2022 16:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=RJgmW2b+G8hXZiK3ZuEGABCQXwn51u/i1lC21liP/hM=;
        b=jmj/omCdwVIDuiWAp4qQLVmEt6FUbOlW0MvTdUyY90z419tVNF+7hGAm22OUgI7XhL
         68zqoxK9CeaBCdEe4aViSysskDc/iKcCOoNhojtXcC5Pddokca2kR2PfBKkSi85pgfPK
         g/j+JEqJEMSH032a4ZijbnlxKYuJjc8NTDAZwtnqQC9JzNNsET06Jod6dr/dB8chp8r8
         LeQJNWsdylf05m+yBL//WT6mfFv/a/nYak8ipa7VSIA2JRxv1o6THqPug6LM/Mu3S5Hb
         Oh2naRDNd/YrChLNim2mjGvvHjwvrSau9cuOIK5ZE/5l5cqajpL09QdvidM41dKdFK/j
         Ld1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=RJgmW2b+G8hXZiK3ZuEGABCQXwn51u/i1lC21liP/hM=;
        b=RlzgEzr2sqjSHFsyydP94F3HyIELUmzQB93XkRKzUI1BbKqZ99yFQphoe7PwY7i8bW
         xShnkGrqEcUdL6wlZOXHZQD34SBvSFeYT8lTXGReZ7ZYhJLlzalb+Em8VRpk8EzyylkJ
         SrG3fn3TkY3azo/atfvzLN6T3EM60QqyKm3sVV4fZ1UtsEM9A3Loqd5LvyNX+kilfOcN
         rOwKrrkavrU7E7PdEt8nM+zpXzZZeTd/DPQgWfftoThibwed38se+MgVQojTIX1ZBgAW
         FDPC1fm/3C8suO1dEnoNfjZtp+dJrqMtbv0Ev0fr4kIWKaaz9phkQpHMOF/AD2Z+SbTy
         rQBQ==
X-Gm-Message-State: ACgBeo1jWTu10vd2X5yqVYlxbAvuotx1yBEIRi5rSz48tN7afvl1GMtq
        6QqLhe1fougiQV3ZNUd9a1K2wDMfIKK//VFdFzg=
X-Google-Smtp-Source: AA6agR5g2knT+beY1JhsSfxLCH4lKMBaFfm1MSAs1YRElEg3QqXt7JjCt0Bmo9/fYFDI8GqyedTmwgAW60MNvgaP+bI=
X-Received: by 2002:a63:cf0b:0:b0:419:f140:2876 with SMTP id
 j11-20020a63cf0b000000b00419f1402876mr18445354pgg.303.1661209967533; Mon, 22
 Aug 2022 16:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
 <20220819053234.241501-8-tales.aparecida@gmail.com> <CAGS_qxoVuRPF39kcVBWGuhnmaixfLAkPN6HaDRyuXmDHqmWPXg@mail.gmail.com>
 <CAGVoLp6CQO=Vw20GYYoYUEZr4BJM5FS8H8Fi3TgS0aXWVie4Lg@mail.gmail.com> <CAGS_qxrGVHWiEQz5b+zWz0JYmUwxnsVaoa_8SYOxb7nsRZ=iSw@mail.gmail.com>
In-Reply-To: <CAGS_qxrGVHWiEQz5b+zWz0JYmUwxnsVaoa_8SYOxb7nsRZ=iSw@mail.gmail.com>
From:   Tales <tales.aparecida@gmail.com>
Date:   Mon, 22 Aug 2022 20:12:09 -0300
Message-ID: <CAGVoLp5zv5CR_Jo-dboaYF+7_8whV=rvfJHRGeVhNRTn6LzMoA@mail.gmail.com>
Subject: Re: [PATCH 7/8] lib: overflow: update reference to kunit-tool
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-doc@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        Melissa Wen <mwen@igalia.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Isabella Basso <isabbasso@riseup.net>,
        Magali Lemes <magalilemes00@gmail.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Em seg., 22 de ago. de 2022 =C3=A0s 19:52, Daniel Latypov
<dlatypov@google.com> escreveu:
>
> On Mon, Aug 22, 2022 at 3:35 PM Tales <tales.aparecida@gmail.com> wrote:
> >
> > Hi Daniel,
> >
> > Em seg., 22 de ago. de 2022 =C3=A0s 17:09, Daniel Latypov
> > <dlatypov@google.com> escreveu:
> > >
> > > On Thu, Aug 18, 2022 at 10:33 PM Tales Aparecida
> > > <tales.aparecida@gmail.com> wrote:
> > > >
> > > > Replace URL with an updated path to the full Documentation page
> > > >
> > > > Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> > > > ---
> > > >  lib/overflow_kunit.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> > > > index 7e3e43679b73..78075106c0df 100644
> > > > --- a/lib/overflow_kunit.c
> > > > +++ b/lib/overflow_kunit.c
> > > > @@ -1,7 +1,7 @@
> > > >  // SPDX-License-Identifier: GPL-2.0 OR MIT
> > > >  /*
> > > >   * Test cases for arithmetic overflow checks. See:
> > > > - * https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-to=
ol.html#configuring-building-and-running-tests
> > > > + * "Running tests with kunit_tool" at Documentation/dev-tools/kuni=
t/start.rst
> > >
> > > Oh, I thought I had sent a patch out for this.
> > > The rewritten version of the patch is
> > > https://www.kernel.org/doc/html/latest/dev-tools/kunit/run_wrapper.ht=
ml
> > > That's what I was intending to rewrite this line to point to.
> > >
> > > But if people like a Documentation/ path to start.rst instead, that a=
lso works.
> > >
> > > Daniel
> >
> > You are absolutely right! You did send and I wasn't aware, sorry.
> > https://lore.kernel.org/all/20220603195626.121922-1-dlatypov@google.com=
/
> > I guess it stalled after that discussion about *where* it should be app=
lied,
> > I got a green flag in IRC and didn't do my due diligence carefully,
> > just tried to find pending patches at linux-kselftest which wasn't
> > CC'd
>
> Oh right, it was that series where I didn't cc linux-kselftest.
> That was my bad, sorry.
>
> But I had forgotten to include a patch in that series to update this
> file still, afaict.
> I could revive that series and add on a version of this patch, if we want=
?
>
> Daniel

I can bring your patches in my V3, if you don't mind! :D
