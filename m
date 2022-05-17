Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EE7529686
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 May 2022 03:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbiEQBHk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 21:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiEQBHi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 21:07:38 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2283C403C1
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 18:07:38 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-f165bc447fso12571308fac.6
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 18:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4loixfGJBX/b2d0tY/k6yxdSnhFDGM7TlcCGNU7ptp0=;
        b=Xhr/SVElLugHHcTTc96KL4WT+84spwWYl4MIWiOZB2LmEggYCObeYkSv2Vg+L1CTSB
         DR53XbWR28V3a6LJUV9yl1eOKX4IQ87ZrX+m6oUttMfndOlWMtNfts951EwQpTo8nSrF
         0LnBftUYOfaIkgf7pei/zgMcoL9LB4GSjk4MAj2DaO3FEcUmbJSqypPyHKA1a6VFTba+
         hB9gFztylyA1rkCoOTn5KgMrvPHqFi6fcI+G7Y6MtHg5/OzOIsMXNaDg3D/l0vxe/42Y
         m8yEbuFCL6dHwWkWgjijXPc1kPSHbdNMl9B6LiT1PYk7s9lwqEGLn3iBYJ1FUPlCRBQ0
         oetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4loixfGJBX/b2d0tY/k6yxdSnhFDGM7TlcCGNU7ptp0=;
        b=V7xkjlBVQrl3UQ6O4kNcc7YbukCOeUtCVQ7oPJlh3he51DgQnuWnkw3MUax6nh7ygw
         5bTxUbjBKnrHd4aAmwUpwC7s5L4a54Xijb50/NQCd8uJ+xwNhRW9huTg71lQF16xwbXq
         wq6N8j0G8wBIhflWlH/VQDVveHtmzw63WV62sc79a9DbWdKFnJas3NWfxmvGs/k1wRrr
         1AcaFP8A5Dl6CZOXLrTi53+CPToFIXpWgflwOynia0nqUXcgTgXHIi7cpHkZO5UE2Cg0
         WPMsn0u1ut6UDu797zNr9bMf8ziNOnPpWCOfYkn0eCJSQFpONZy9SxerYqa6ibHZILBv
         ZFyw==
X-Gm-Message-State: AOAM532ZGN/nhSbGuyX53kHrYrWDTTJReT9UM5WD4RYw2IlAd/u0Ir8w
        F/QB33LaEgV8LCxxMiOr/29teGXHkqTlPo4ClO2Rg6AGQZc=
X-Google-Smtp-Source: ABdhPJyvVQl4zKW3GeSWaLTFgBdMEFgS+d4GbYEezcLSzKpZbs//QU5ZPYddnmkfzPV8jiXng/KxB7xutWQBkrMQQbQ=
X-Received: by 2002:a05:6871:438b:b0:ee:326d:b3f9 with SMTP id
 lv11-20020a056871438b00b000ee326db3f9mr17111321oab.126.1652749657202; Mon, 16
 May 2022 18:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220504182908.1322874-1-yuanchu@google.com> <20220504184537.130085-1-sj@kernel.org>
 <CAJj2-QGQsuAPR0nYaS9+YA=DWXRQD83UZgk3QUjRJA9BTwqp4w@mail.gmail.com>
In-Reply-To: <CAJj2-QGQsuAPR0nYaS9+YA=DWXRQD83UZgk3QUjRJA9BTwqp4w@mail.gmail.com>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Mon, 16 May 2022 21:07:25 -0400
Message-ID: <CAJj2-QGk9DmGhjPsjHwL5uj+cQs6=12iKEffpq+Vxv3=CrMPBA@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/damon: suppress compiler warnings for huge_count_read_write
To:     SeongJae Park <sj@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Markus Boehme <markubo@amazon.de>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

SeongJae,

Do you have a preference on how this should be handled?

Thanks,
Yuanchu

On Wed, May 4, 2022 at 6:12 PM Yuanchu Xie <yuanchu@google.com> wrote:
>
> Hi SeongJae,
>
> On Wed, May 4, 2022 at 11:45 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hi Yuanchu,
> >
> > On Wed, 4 May 2022 18:29:08 +0000 Yuanchu Xie <yuanchu@google.com> wrot=
e:
> >
> > > The test case added in commit db7a347b26fe ("mm/damon/dbgfs:
> > > use '__GFP_NOWARN' for user-specified size buffer allocation")
> > > intentionally writes and reads with a large count to cause
> > > allocation failure and check for kernel warnings. We suppress
> > > the compiler warnings for these calls as they work as intended.
> > >
> > > Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> > > ---
> >
> > It would be a good practice to mention the changes from the previous ve=
rsion of
> > this patch here[1].
> >
> > [1] https://docs.kernel.org/process/submitting-patches.html#the-canonic=
al-patch-format
> >
> Thank you, I missed this when trying to figure out how to add
> additional comments for a revision.
>
> > >  tools/testing/selftests/damon/huge_count_read_write.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/=
tools/testing/selftests/damon/huge_count_read_write.c
> > > index ad7a6b4cf338..91bd80c75cd9 100644
> > > --- a/tools/testing/selftests/damon/huge_count_read_write.c
> > > +++ b/tools/testing/selftests/damon/huge_count_read_write.c
> > > @@ -2,6 +2,8 @@
> > >  /*
> > >   * Author: SeongJae Park <sj@kernel.org>
> > >   */
> > > +#pragma GCC diagnostic ignored "-Wstringop-overflow"
> > > +#pragma GCC diagnostic ignored "-Wstringop-overread"
> >
> > I agree that this must be the cleaner way than v2.  But, I get below wa=
rning
> > after applying this:
> >
> >     $ sudo make -C tools/testing/selftests/damon run_tests
> >     make: Entering directory '/home/sjpark/linux/tools/testing/selftest=
s/damon'
> >     gcc     huge_count_read_write.c  -o /home/sjpark/linux/tools/testin=
g/selftests/damon/huge_count_read_write
> >     huge_count_read_write.c:6:32: warning: unknown option after =E2=80=
=98#pragma GCC diagnostic=E2=80=99 kind [-Wpragmas]
> >         6 | #pragma GCC diagnostic ignored "-Wstringop-overread"
> >           |                                ^~~~~~~~~~~~~~~~~~~~~
> >
> > My gcc version is:
> >
> >     $ gcc --version
> >     gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
> I see, I'm running
>
>     $ gcc --version
>     gcc (Debian 11.2.0-16+build1) 11.2.0
>
> I believe this is a new warning for gcc-11 [1], and somewhat
> unfortunate that it results in a warning for gcc-9.4. I'm not sure
> what the preference is here.
> [1] https://gcc.gnu.org/onlinedocs/gcc-10.3.0/gcc/Warning-Options.html
>
> Thanks,
> Yuanchu
