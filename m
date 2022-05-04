Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A81951B035
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 23:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378518AbiEDVTy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 17:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357155AbiEDVTx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 17:19:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB737220C2
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 14:16:15 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b24so3098979edu.10
        for <linux-kselftest@vger.kernel.org>; Wed, 04 May 2022 14:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6MXhFAWbDglpoBwnCNgPXrGcxMNN6VO/SyKkfNQIIaY=;
        b=od9l1MKX7VGnlty0UQGANhz5usp8Mso5lcbHl1nFickQHtjswW8vkxoYHz9GUsdtAU
         f8AMtgLlad2SEhYwyYKIWXo3yBOyjtzO9GEDXVoigHp78Vy7LNTXXcMjmf5Uh+0y9m1K
         cU09NofM9Tb/cXEvvtGa01f7Ej2pwrj93rcxtfNEn+TB0eBVG6N7nHffonOwEG2IBFR5
         gxRbHIun3AuGBf38wjv/TAmzk+9U+1SlrJLS/pWnEiwf8vyjPM56HObsANDRQztEnBtN
         p5tIFznUphSsy1ffWktrtVRSvUjRPWXTZrxiMqKQwDZwpWONN3F+s1PqA3ThuATdZT3q
         pnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6MXhFAWbDglpoBwnCNgPXrGcxMNN6VO/SyKkfNQIIaY=;
        b=EO4lgQ8vF6uC6UUPa+JcBb53jOpYtmlNLPai4y7+raKxrPoT5JQLpaTYE+GRNG3NWy
         4A8Mm18OuQ+wDZ51cOkQ9nnb9Wck3MknZVAHxJTVgFXKOmLTiQZPaqyEBCqFVCB07xoF
         sm+x4Q4TGew64sC1lNaQojOXs20wmIkhIzkEvp/yY0Bsocgr8zIWonyIfkPSrYNQddn1
         c1utOXKTA/xomy5pttutQNG05JPahYbtbz35nsoihMgzTIIpiGYDIvzAyuwTFLPXsY5S
         G81fkJQKxfktfRXeKOLDUr9nTxOFN3tw8Q6xMJXFyyfD+GULXZubwevwEDBEX0F+Kkzs
         nDgg==
X-Gm-Message-State: AOAM533CHTbDsC9RNGhmJayKe2RoSyM3LWhP/nCK/xCBgnafSbxbvkL/
        XLskpJc4GefimoxSnPiFyZH1CDU98m7crAcPp3UWlQ==
X-Google-Smtp-Source: ABdhPJwQ1M2NAmIFQZzAS9SZVXA1FRiwJe04VVWotoV0KyWmS6QO9tP0T66QfbBoTx2NAlraFyhy336blz2Fqf5csD4=
X-Received: by 2002:a05:6402:2995:b0:425:d3a1:28aa with SMTP id
 eq21-20020a056402299500b00425d3a128aamr25411732edb.247.1651698974303; Wed, 04
 May 2022 14:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220318021314.3225240-1-davidgow@google.com> <20220318021314.3225240-2-davidgow@google.com>
 <CAGS_qxqm1ys1qUz__4uXWOgs=34M5MB3QMnhg40FHtRhatF3+g@mail.gmail.com> <CAFd5g452ecbNbSyODT3Prraj5cOEugHm=asE_h+ik-yriUvf6w@mail.gmail.com>
In-Reply-To: <CAFd5g452ecbNbSyODT3Prraj5cOEugHm=asE_h+ik-yriUvf6w@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 4 May 2022 16:16:03 -0500
Message-ID: <CAGS_qxrv_kSR0nnQNTDshUVSz=UT3djzLnHEpNLOV7fMO-fVCg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] kunit: Expose 'static stub' API to redirect functions
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>, Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, May 4, 2022 at 3:42 PM 'Brendan Higgins' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Wed, May 4, 2022 at 4:35 PM Daniel Latypov <dlatypov@google.com> wrote=
:
> >
> > On Thu, Mar 17, 2022 at 9:13 PM David Gow <davidgow@google.com> wrote:
> > > +#define kunit_activate_static_stub(test, real_fn_addr, replacement_a=
ddr) do {  \
> > > +       typecheck(typeof(real_fn_addr), replacement_addr);           =
           \
> >
> > We can't call this macro in the same scope for functions w/ different
> > signatures.
> >
> > E.g. if we add this func to the example test
> >   static void other_func(void) {}
> > then trying to call kunit_activate_static_stub() on it in the same
> > test case, we get
> >
> > ./include/linux/typecheck.h:10:14: error: conflicting types for
> > =E2=80=98__dummy=E2=80=99; have =E2=80=98void(void)=E2=80=99
> >    10 | ({      type __dummy; \
> >       |              ^~~~~~~
> > ./include/kunit/static_stub.h:99:9: note: in expansion of macro =E2=80=
=98typecheck=E2=80=99
> >    99 |         typecheck(typeof(real_fn_addr), replacement_addr);
> >                  \
> >       |         ^~~~~~~~~
> > lib/kunit/example-test.c:64:9: note: in expansion of macro
> > =E2=80=98kunit_activate_static_stub=E2=80=99
> >    64 |         kunit_activate_static_stub(test, other_func, other_func=
);
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/typecheck.h:10:14: note: previous declaration of
> > =E2=80=98__dummy=E2=80=99 with type =E2=80=98int(int)=E2=80=99
> >    10 | ({      type __dummy; \
> >       |              ^~~~~~~
> > ./include/kunit/static_stub.h:99:9: note: in expansion of macro =E2=80=
=98typecheck=E2=80=99
> >    99 |         typecheck(typeof(real_fn_addr), replacement_addr);
> >                  \
> >       |         ^~~~~~~~~
> > lib/kunit/example-test.c:62:9: note: in expansion of macro
> > =E2=80=98kunit_activate_static_stub=E2=80=99
> >    62 |         kunit_activate_static_stub(test, add_one, subtract_one)=
;
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Afaict, the problem is that GCC thinks we're declaring a *function*
> > called __dummy, not a variable.
> > So it bleeds across the scope boundary of do-while unlike normal variab=
les.
>
> Yeah, I ran into that problem too. I posted a fix to gerrit. I have
> been meaning to share it here.

For others, gerrit =3D=3D https://kunit-review.googlesource.com/c/linux/+/5=
129

>
> > There's the typecheck_fn macro, but it doesn't work either.
>
> That's weird. It worked for me.

I'm running on top of 5.5.
I tried reproducing w/ a stripped down version on 5.18 and saw the same iss=
ues.

Huh, I'm trying with
 #define kunit_activate_static_stub(test, real_fn_addr,
replacement_addr) do {  \
-       typecheck(typeof(real_fn_addr), replacement_addr);
         \
+       typecheck_fn(typeof(real_fn_addr), replacement_addr); \
        __kunit_activate_static_stub(test, real_fn_addr,
replacement_addr);     \

This gives me
lib/kunit/example-test.c:62:9: error: function =E2=80=98__tmp=E2=80=99 is i=
nitialized
like a variable
   62 |         kunit_activate_static_stub(test, add_one, subtract_one);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
lib/kunit/example-test.c:64:9: error: function =E2=80=98__tmp=E2=80=99 is i=
nitialized
like a variable
   64 |         kunit_activate_static_stub(test, other_func, other_func);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~

Perhaps I'm missing something silly.

Can you post your fix and I can try it out?
