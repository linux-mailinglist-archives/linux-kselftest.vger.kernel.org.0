Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA91651B1A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 May 2022 00:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346332AbiEDWQJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 18:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239733AbiEDWQI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 18:16:08 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338CD50E00
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 15:12:31 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e5e433d66dso2604853fac.5
        for <linux-kselftest@vger.kernel.org>; Wed, 04 May 2022 15:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wquqW3x/NVz0JD2PQXTktSWbyNjB4MSdaRsMfdQ/Zrs=;
        b=R7BE21HU+q0r9itfOFa4ZZBxOpuGYg5HWV9A9y3ufNAq/107F0JV8+d3Ice3rMW8K1
         DkezRmzH0i709qnS7rusfIID1r2ORBfFr5m7cqjKp0pL8L1gUWrRUzfd/JpWv7Uxm4Z/
         EBIg/0IirjaJTzzMUynZevhMPQasV1E7NICalwDQahjVT3zG5VjDEz6ydG+16aRh5y2C
         yAPkBfTXAAAOZqOZbahYVVljOAEfgi140CMPFx2hYTga+jgnL6Xe/klDsrK2Anq6C5ar
         Cab/zGVerAuPIHCM9dQtkcdhhNakWsiKz9n7IivyjxjGsf92ElJWWUWmp3+MYRCuPuJg
         BAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wquqW3x/NVz0JD2PQXTktSWbyNjB4MSdaRsMfdQ/Zrs=;
        b=OEJoD9npufFj5+RpwP+KapiuW9h7s3zjLEqyCZbZcVuIvq6CMYn1z7U/ii8pc+DlQe
         KmkamwsTfLmuY6zcZwxPo5P168WQ1+razvW7jxIESpV/No757oGQRH2BYmrm3xWEDFRE
         F65kdm1arATB9MoIqbGXwuSugctxUqPVBEhxAG0GkCXl47DZfAerwjkNb6p83cO3I6sP
         DpILATmrcCnHQA97E+b7DGKQeyyIXHcMlCcNEcec5dfEizatVy9Q6tsHpC8NvtR5Tbjg
         2gJLJQtjWUssm5aMm0RwkplCTV4DUMIBioysaWCFmNdStE2cDwB8U9eiXUuqKKY2FGiZ
         VWtQ==
X-Gm-Message-State: AOAM530pO9tLaepNVkJF0swvNdTKWE5qk6+JJntfglmgjeItiHFRdNut
        aoI/22AWMr3mKl+Ce9Tjszdm42SNEt+OzYPSE+au6twjZzwoXA==
X-Google-Smtp-Source: ABdhPJw9RAW6gV3GBRIHhsfV4MFjHHQN6T08u6egeYgBJl4X62rWrpQVpH7Qu7QnuWKAMo+wZ+Ng/P9Q5bRHx76qphc=
X-Received: by 2002:a05:6870:c683:b0:ed:efb9:ffe9 with SMTP id
 cv3-20020a056870c68300b000edefb9ffe9mr859642oab.241.1651702350192; Wed, 04
 May 2022 15:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220504182908.1322874-1-yuanchu@google.com> <20220504184537.130085-1-sj@kernel.org>
In-Reply-To: <20220504184537.130085-1-sj@kernel.org>
From:   Yuanchu Xie <yuanchu@google.com>
Date:   Wed, 4 May 2022 15:12:19 -0700
Message-ID: <CAJj2-QGQsuAPR0nYaS9+YA=DWXRQD83UZgk3QUjRJA9BTwqp4w@mail.gmail.com>
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

Hi SeongJae,

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
Thank you, I missed this when trying to figure out how to add
additional comments for a revision.

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
I see, I'm running

    $ gcc --version
    gcc (Debian 11.2.0-16+build1) 11.2.0

I believe this is a new warning for gcc-11 [1], and somewhat
unfortunate that it results in a warning for gcc-9.4. I'm not sure
what the preference is here.
[1] https://gcc.gnu.org/onlinedocs/gcc-10.3.0/gcc/Warning-Options.html

Thanks,
Yuanchu
