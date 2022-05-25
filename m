Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F5A53347B
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 May 2022 02:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiEYAz0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 20:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiEYAzZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 20:55:25 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0146CA8E
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 17:55:23 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-f1d5464c48so24340416fac.6
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 17:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=87TAdO7JVTyU4dJLZx4/twxaR3Jk7wL6ogRvawQDX/I=;
        b=JIv9rAjc5IAfYhvvJ4+4CyGclox8QGMjVLCV4cdp6JH0BX/N5umdP0MRbQAiEZW9iH
         Tepm36gZweXci0jyXQz/OHvziPK6hnlGztgxjOt/n/8mWMSFnW/LjcpcXudoYPCDJeKv
         N3lBWB1XkkmwNMm7/R4jUBR6jvftLDN2KLLFXaCdTgEQEoyAo8FdYCWODHViuca04dbk
         IUtXTEtK8+z0KmykxRAQrE1MMpzcNcGTeOGBHi/dhWq3Z6vZk+H0Qu67jQtyQUUJWz3C
         GhLvq0MPZFFlPmbbg0+zVgmeUyPgb50F9kht7pKLCOKFngI+956xeYdrtxxGIg1b5lnI
         yaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=87TAdO7JVTyU4dJLZx4/twxaR3Jk7wL6ogRvawQDX/I=;
        b=jJx1KEh5lriXmM7NFUF0jCrEB4Zjom70/3+V5wgrsoYV27c0iZja2Xtb/XHNt5dT8T
         KtQPH+0HPlXTGJCeOGTz8XzlOv6UPg/6WP2FI5x39zzzwb8edBY37PvMWOoM+H5GN6w1
         CJyedC7019kSrI9qUC7r59F3XsGwBS1o9ALVb+EjiyuiXxJKoPxXzAseBh0XirldTV0s
         I3A1tGAG06kcQ6OeJIXLCyHdxVMXwg6wfBlLZDBH+/ZkB8Kqk3y1ID0L+sGLQDnUWDTX
         RCUtU+Un8lu7O7t7EyEIDZI+uDtETqtMSyEKoj39tZauR2BsdVQ+Z10Ogf00h2yTefl1
         zMJg==
X-Gm-Message-State: AOAM531a8ybCYCguLU2k5KTUrg1xoWMvFxVsDfI2psSfRGjf44RcSwvS
        XAhN4Rv8lAmECkJxEq5FP0hxFj7OC1hjuyRZr6lfPg==
X-Google-Smtp-Source: ABdhPJwuIQfcxPE3CrjW3nGLNRxcyh8Nyr3XOH9nVNz3aP18UDS9v2PrgtCxeZabMgswSF/jtx1j7MFj7uvcmqz5eic=
X-Received: by 2002:a05:6870:c683:b0:ed:efb9:ffe9 with SMTP id
 cv3-20020a056870c68300b000edefb9ffe9mr4067382oab.241.1653440122904; Tue, 24
 May 2022 17:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220504182908.1322874-1-yuanchu@google.com> <20220504184537.130085-1-sj@kernel.org>
In-Reply-To: <20220504184537.130085-1-sj@kernel.org>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Tue, 24 May 2022 17:55:11 -0700
Message-ID: <CAJj2-QGUsqx8uRTamv7Hbw_-FRJOtrEnX6=fGEseZDJEtcnOaw@mail.gmail.com>
Subject: Re: [PATCH v3] selftests/damon: suppress compiler warnings for huge_count_read_write
To:     Shuah Khan <shuah@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>, Markus Boehme <markubo@amazon.de>,
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

Hi Shuah,

On Wed, May 4, 2022 at 11:45 AM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Yuanchu,
>
> On Wed, 4 May 2022 18:29:08 +0000 Yuanchu Xie <yuanchu@google.com> wrote:
>
> > The test case added in commit db7a347b26fe ("mm/damon/dbgfs:
> > use '__GFP_NOWARN' for user-specified size buffer allocation")
> > intentionally writes and reads with a large count to cause
> > allocation failure and check for kernel warnings. We suppress
> > the compiler warnings for these calls as they work as intended.
> >
> > Signed-off-by: Yuanchu Xie <yuanchu@google.com>
> > ---
>
> It would be a good practice to mention the changes from the previous vers=
ion of
> this patch here[1].
>
> [1] https://docs.kernel.org/process/submitting-patches.html#the-canonical=
-patch-format
>
> >  tools/testing/selftests/damon/huge_count_read_write.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/to=
ols/testing/selftests/damon/huge_count_read_write.c
> > index ad7a6b4cf338..91bd80c75cd9 100644
> > --- a/tools/testing/selftests/damon/huge_count_read_write.c
> > +++ b/tools/testing/selftests/damon/huge_count_read_write.c
> > @@ -2,6 +2,8 @@
> >  /*
> >   * Author: SeongJae Park <sj@kernel.org>
> >   */
> > +#pragma GCC diagnostic ignored "-Wstringop-overflow"
> > +#pragma GCC diagnostic ignored "-Wstringop-overread"
>
> I agree that this must be the cleaner way than v2.  But, I get below warn=
ing
> after applying this:
>
>     $ sudo make -C tools/testing/selftests/damon run_tests
>     make: Entering directory '/home/sjpark/linux/tools/testing/selftests/=
damon'
>     gcc     huge_count_read_write.c  -o /home/sjpark/linux/tools/testing/=
selftests/damon/huge_count_read_write
>     huge_count_read_write.c:6:32: warning: unknown option after =E2=80=98=
#pragma GCC diagnostic=E2=80=99 kind [-Wpragmas]
>         6 | #pragma GCC diagnostic ignored "-Wstringop-overread"
>           |                                ^~~~~~~~~~~~~~~~~~~~~
>
> My gcc version is:
>
>     $ gcc --version
>     gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0

    $ gcc --version
    gcc (Debian 11.2.0-16+build1) 11.2.0

I believe this is a new warning for gcc-11 [1], and somewhat unfortunate th=
at
it results in a warning for gcc-9.4. So a patch that would resolve the test
warnings for gcc 11 would introduce a new warning for gcc 9, and vice versa=
.
What's the preferred solution here?

[1] https://gcc.gnu.org/onlinedocs/gcc-10.3.0/gcc/Warning-Options.html

Thanks,
Yuanchu
