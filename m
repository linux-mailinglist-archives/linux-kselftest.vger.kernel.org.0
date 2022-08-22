Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A88859CBC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 00:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235552AbiHVWwm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 18:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiHVWwl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 18:52:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F342F50736
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 15:52:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id vw19so10454495ejb.1
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 15:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=XLgtLD7vBAyVMD+9VJI2NLAe64xOTMdHlcCW5KZ1j3Q=;
        b=MPPTHhum2nMwqmEC5B/UTTtOxnE1s2XWYgIYwbTXdf8hZuvbr27Ikh3vl2x6opKRaU
         mBriuDDp0HYdwQDTLydl+ZXUT/XoEMlUIr0zmM3Fzy340X7dN3T+yiwJPzXyterg0ix6
         5O1S37l6K+JwcZ4l9wwta5dJK7YDJiEiRstmrUZWbi8Noec41q59uGTiK2TVYYcVqTtb
         khRyk+bE75HvoHbguCiLq7o79Ica//2MDbEbZKb1Z6N53ewyTqevgtwRHXge6ZDHOsID
         eFzO+al9/mSBG1k1wzLjPGBaonbbx0gl1Y4MJ5VDSOL41mHg6Vm3f9d0T2j5vWxI5F6U
         4EIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=XLgtLD7vBAyVMD+9VJI2NLAe64xOTMdHlcCW5KZ1j3Q=;
        b=A9chck0xOBy4XzJR8cWSstvt7XmXIP3M7uuit+SfnAkfLJl9+zbUu2UzibiqSnxf7c
         vZ+fcMM9cQd1Q/h9qKtcCC7HNde24MkS5/YnIDGUPLEnlf4eg0dS/D3vDiefwMpuDqNK
         wabkxRQVdgfZ/8M8OUGtkQjuTnSuDFk9LcaXnYsrVLvwpjHAfXRANFWW3W5fGSWD85zp
         OwbuyrYedkL6XKq/+MMRlbPfHpSGAfLU9jG2HBOAAw1AwSUETeOeT+cz2p7q2qPLJvqK
         oP6anbgUFHNTCERZt2nWlB8cgvoF3TUbq7Q975/G79qXUVtt7E8MJgaDk5rydj1GmfEp
         7XQg==
X-Gm-Message-State: ACgBeo05X1+RPpClycdzbUc0ts8j8aE3dO5YMUSiXOlMs/JGcqpFX61H
        CHh6L5AV3yDtN0jokpqnroa2y57BwMc1MOZe0VNBBg==
X-Google-Smtp-Source: AA6agR5J+kdNj9PmydczQ5oLNItQ0V0tD8FpH0QxDQnGVEEvJEcNOj+RxXfhEr4HjEMLIdo7koqhYBMsDrNjLfklQjU=
X-Received: by 2002:a17:907:7f9e:b0:73c:6f39:7399 with SMTP id
 qk30-20020a1709077f9e00b0073c6f397399mr12849900ejc.358.1661208758339; Mon, 22
 Aug 2022 15:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220819053234.241501-1-tales.aparecida@gmail.com>
 <20220819053234.241501-8-tales.aparecida@gmail.com> <CAGS_qxoVuRPF39kcVBWGuhnmaixfLAkPN6HaDRyuXmDHqmWPXg@mail.gmail.com>
 <CAGVoLp6CQO=Vw20GYYoYUEZr4BJM5FS8H8Fi3TgS0aXWVie4Lg@mail.gmail.com>
In-Reply-To: <CAGVoLp6CQO=Vw20GYYoYUEZr4BJM5FS8H8Fi3TgS0aXWVie4Lg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 22 Aug 2022 15:52:27 -0700
Message-ID: <CAGS_qxrGVHWiEQz5b+zWz0JYmUwxnsVaoa_8SYOxb7nsRZ=iSw@mail.gmail.com>
Subject: Re: [PATCH 7/8] lib: overflow: update reference to kunit-tool
To:     Tales <tales.aparecida@gmail.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 22, 2022 at 3:35 PM Tales <tales.aparecida@gmail.com> wrote:
>
> Hi Daniel,
>
> Em seg., 22 de ago. de 2022 =C3=A0s 17:09, Daniel Latypov
> <dlatypov@google.com> escreveu:
> >
> > On Thu, Aug 18, 2022 at 10:33 PM Tales Aparecida
> > <tales.aparecida@gmail.com> wrote:
> > >
> > > Replace URL with an updated path to the full Documentation page
> > >
> > > Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
> > > ---
> > >  lib/overflow_kunit.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> > > index 7e3e43679b73..78075106c0df 100644
> > > --- a/lib/overflow_kunit.c
> > > +++ b/lib/overflow_kunit.c
> > > @@ -1,7 +1,7 @@
> > >  // SPDX-License-Identifier: GPL-2.0 OR MIT
> > >  /*
> > >   * Test cases for arithmetic overflow checks. See:
> > > - * https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-tool=
.html#configuring-building-and-running-tests
> > > + * "Running tests with kunit_tool" at Documentation/dev-tools/kunit/=
start.rst
> >
> > Oh, I thought I had sent a patch out for this.
> > The rewritten version of the patch is
> > https://www.kernel.org/doc/html/latest/dev-tools/kunit/run_wrapper.html
> > That's what I was intending to rewrite this line to point to.
> >
> > But if people like a Documentation/ path to start.rst instead, that als=
o works.
> >
> > Daniel
>
> You are absolutely right! You did send and I wasn't aware, sorry.
> https://lore.kernel.org/all/20220603195626.121922-1-dlatypov@google.com/
> I guess it stalled after that discussion about *where* it should be appli=
ed,
> I got a green flag in IRC and didn't do my due diligence carefully,
> just tried to find pending patches at linux-kselftest which wasn't
> CC'd

Oh right, it was that series where I didn't cc linux-kselftest.
That was my bad, sorry.

But I had forgotten to include a patch in that series to update this
file still, afaict.
I could revive that series and add on a version of this patch, if we want?

Daniel
