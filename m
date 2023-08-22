Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93F178446D
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236814AbjHVOfE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Aug 2023 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbjHVOfE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Aug 2023 10:35:04 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABDECC6;
        Tue, 22 Aug 2023 07:35:01 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-79a83720538so1584010241.1;
        Tue, 22 Aug 2023 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692714900; x=1693319700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+ZNfPtU0Cttw+VeDpq9OnUhCaE60SVpp2lMWarUKUc=;
        b=Bj7XacAvfZ6coerNUiXEwJdKVf0xGC+OXqZOwA3lUpa0JTkpxgekOtmtlCEoHSHDle
         0rdnLCQK5kZHsIJpziI+2ieYFVI0Q3BIg3STTzrNcv29doMqCMlw2lLNYqQutEBCjNvA
         fPvDYrqsSQAyEl5JiSCdsiOGyoW0E6jitN37eev4m62r96FccmWTjz3VtAWT28dQZQyE
         zP5f5qCwIYqz4IqGIi3GXHNKSPsRmbb86pq8pSmUJymLPTy1gE9ysg262GMr13XF06r0
         j+me8PoNw2hZAZnF1/BADEZRRkyc22+pJmq0cueWsivAxvSA5rXNdItT5DrEPRzEMMLn
         kGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692714900; x=1693319700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+ZNfPtU0Cttw+VeDpq9OnUhCaE60SVpp2lMWarUKUc=;
        b=P3PcvBA7xDkJhJRBtjTIP9+8X2p5pXPk9sgAXDJsUIYyR/n/tuJjcGpQr7WZ5LEVR8
         BBoiwLJ5J9uv1xlicNCu0LAyxQcE4Qk8lfi6gv17ml66U46H52x4nDvH89eJ/F0Uw3Y1
         uBNsWMy97lWQrovdMg9Rs9sXT90mJBm5tn5jj6GoT87Qb2OA3PF4Rq4hoT8q3LfwxAX9
         oXwXL/xrH868+x4nXzA9gH5ymS16Jj1JDNtreXCLklZSeCfefzBQj0fcXPmtjqC1btnG
         r8RPWp1nCodlp5oNjleJoVHk3z/as4G22vp8afEkHmivij0cAhq71ytA3LwqB/FkJQgI
         TuIA==
X-Gm-Message-State: AOJu0YyWkFaXPbM7gLthDrptPXX6vTca5T0zqndQQAWGdLfLr0Nt46lf
        jq+ydbRrOlq0r22WIeqVr2pjNwgCf0ODLiMCnDc=
X-Google-Smtp-Source: AGHT+IEvbFTcsJ11ZJwXI8CgYZaY1++rsw/zqgyPEs0rJFQr7S29crCoaZwGW1YOUQIFFNY97PInmJjBGmiMX7a+ttA=
X-Received: by 2002:a05:6102:2446:b0:44d:5b62:bcd5 with SMTP id
 g6-20020a056102244600b0044d5b62bcd5mr2330918vss.23.1692714900235; Tue, 22 Aug
 2023 07:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
 <20230819195005.99387-2-mahmoudmatook.mm@gmail.com> <64e22df53d1e6_3580162945b@willemb.c.googlers.com.notmuch>
 <7e8c2597c71647f38cd4672cbef53a66@AcuMS.aculab.com>
In-Reply-To: <7e8c2597c71647f38cd4672cbef53a66@AcuMS.aculab.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 22 Aug 2023 10:34:23 -0400
Message-ID: <CAF=yD-+6cWTiDgpsu=hUV+OvzDFRaT2ZUmtQo9qTrCB9i-+7ng@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: Provide local define of min() and max()
To:     David Laight <David.Laight@aculab.com>
Cc:     Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 21, 2023 at 9:05=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: Willem de Bruijn
> > Sent: Sunday, August 20, 2023 4:15 PM
> >
> > Mahmoud Maatuq wrote:
> > > to avoid manual calculation of min and max values
> > > and fix coccinelle warnings such WARNING opportunity for min()/max()
> > > adding one common definition that could be used in multiple files
> > > under selftests.
> > > there are also some defines for min/max scattered locally inside sour=
ces
> > > under selftests.
> > > this also prepares for cleaning up those redundant defines and includ=
e
> > > kselftest.h instead.
> > >
> > > Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
> > > ---
> > >  tools/testing/selftests/kselftest.h | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/self=
tests/kselftest.h
> > > index 829be379545a..e8eb7e9afbc6 100644
> > > --- a/tools/testing/selftests/kselftest.h
> > > +++ b/tools/testing/selftests/kselftest.h
> > > @@ -55,6 +55,13 @@
> > >  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
> > >  #endif
> > >
> > > +#ifndef min
> > > +# define min(x, y) ((x) < (y) ? (x) : (y))
> > > +#endif
> > > +#ifndef max
> > > +# define max(x, y) ((x) < (y) ? (y) : (x))
> > > +#endif
> > > +
> >
> > Should this more closely follow include/linux/minmax.h, which is a lot
> > more strict?
> >
> > I'm fine with this simpler, more relaxed, version for testing, but
> > calling it out for people to speak up.
> >
> > Only the first two of these comments in minmax.h apply to this
> > userspace code.
> >
> > /*
> >  * min()/max()/clamp() macros must accomplish three things:
> >  *
> >  * - avoid multiple evaluations of the arguments (so side-effects like
> >  *   "x++" happen only once) when non-constant.
> >  * - perform strict type-checking (to generate warnings instead of
> >  *   nasty runtime surprises). See the "unnecessary" pointer comparison
> >  *   in __typecheck().
> >  * - retain result as a constant expressions when called with only
> >  *   constant expressions (to avoid tripping VLA warnings in stack
> >  *   allocation usage).
> >  */
> >
> > Note that a more strict version that includes __typecheck would
> > warn on the type difference between total_len and cfg_mss. Fine
> > with changing the type of cfg_mss in the follow-on patch to address
> > that.
>
> That typecheck() is horrid.
> It may well have caused more bugs due to incorrect casts that
> it actually detected.
>
> I'd suggest the version that just avoids multiple evaluations.
> Or just error signed v unsigned comparisons.
> See  https://lore.kernel.org/all/b4ce9dad748e489f9314a2dc95615033@AcuMS.a=
culab.com/
> for an example patch set.

Interesting, thanks. That is also simpler.

Also, the existing patch is no worse than the open coded code today,
so even without code to avoid multiple evaluations, I guess it's okay
to merge.

The coccinelle warnings are arguably false positives, using checks for
kernel code, but being run against userspace code that has no access
to those helpers. But fine to silence them.
