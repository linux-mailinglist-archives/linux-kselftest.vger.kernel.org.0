Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9C678B288
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjH1OEV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 10:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjH1OEP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 10:04:15 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB2EC7;
        Mon, 28 Aug 2023 07:04:12 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34ca1bcb48fso11801225ab.2;
        Mon, 28 Aug 2023 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693231451; x=1693836251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QO/0yzinyXD/hSG0Q5f8uk+7u0UqykPSt0Y98zMTs2E=;
        b=VtgrswRmSpieizDNd3sDh4uK2sYz+YMy76+l+go2+LU+FbOdPOJAeoEWrvrGStBK2x
         xZUSCk7LLD8Y0GheITvIVHnSZmOrCEUa8YbK2fROUIpHREdKIc8LzfHHBTndYiNdZDFj
         incMH/0FSsapifMrsqVmxmIGDoIOH8496eWmw2v6KmgPmFxP1QMn7cBL1159aIv85tWy
         wTVRIIeZ6l7ZPZII4HJ0Xgjtblel8/H8A1I/abNDT8JNLxRVEUgsG87pug4Qx0JB7SKd
         8LIFaSK68h1tSgJ9obolIMzU7wshC6GgbVxvLhVS9p/ai73KpI/I/I4jg8YLSiZ4s7pq
         iPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693231452; x=1693836252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QO/0yzinyXD/hSG0Q5f8uk+7u0UqykPSt0Y98zMTs2E=;
        b=OD3pN68vUCu8tX3xsBFfRr0VZ8HwPZlNDCjS2YJ8CmfSeoToC/RTVbgyzuO3U01MFE
         W9v0tj0Vo/27D/d6qrrY0k8E4crhqg/P9UlGLKqL/CiIzK9zRSaB+HPhzKwPafG4e5/H
         BCKMaFTxRE/st2ZJAzmhAR/dxmMeW9hMAFuSpF9ILKik7sAkSndvmRG3+us+0v5f2euG
         y5G1mp7a0QbDjdHWA2i+MS84e8KjLuhQZYQegCJZjNtGvPaPzOCiQgGQ5q0AluFpY4cK
         0hAhpGhr/JdTokIB/LGu1Qsq21N/PH3K/0mVajImYaxMVfbBNi7wOiLem5jE8NfRhoKQ
         IXLw==
X-Gm-Message-State: AOJu0YyJZx3q/y7oWk5o8YjRNcEjSW4JhklpGzRubnyD7iOegLLXrLLb
        GZqLvfQKFINT4HClCiB27B9dYCXmTar/r7VclUg=
X-Google-Smtp-Source: AGHT+IHD6r4K9VOXiW0zzZKA3tw281hWmYbuHL0gBRqgtlMGVnobIrVdBBxtk1LpfuNpCDVJ5n+7QuH8kvFme18WdFY=
X-Received: by 2002:a05:6e02:12ac:b0:348:987a:fd8c with SMTP id
 f12-20020a056e0212ac00b00348987afd8cmr14265345ilr.31.1693231451670; Mon, 28
 Aug 2023 07:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693216959.git.maciej.wieczor-retman@intel.com>
 <8417dcd7ebdc464d12850873d6c48f95293e673c.1693216959.git.maciej.wieczor-retman@intel.com>
 <CAKEwX=NnDCjNQDQUt4x8Lw16uUf_NoOw24dXzQvBCTmc4czxuQ@mail.gmail.com>
In-Reply-To: <CAKEwX=NnDCjNQDQUt4x8Lw16uUf_NoOw24dXzQvBCTmc4czxuQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 28 Aug 2023 10:04:00 -0400
Message-ID: <CAKEwX=N8dEFEGXdARQG-1_TrCk7=acWbYgc-jRT=R6+O7=VMig@mail.gmail.com>
Subject: Re: [PATCH 2/6] selftests/cachestat: Fix print_cachestat format
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, ilpo.jarvinen@linux.intel.com,
        reinette.chatre@intel.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Aug 28, 2023 at 10:00=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Mon, Aug 28, 2023 at 6:50=E2=80=AFAM Wieczor-Retman, Maciej
> <maciej.wieczor-retman@intel.com> wrote:
> >
> > The format specifier in printf() call expects long int variables and
> > received long long int.
> >
> > Change format specifiers to long long int so they match passed
> > variables.
> >
> > Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
> > ---
> >  tools/testing/selftests/cachestat/test_cachestat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools=
/testing/selftests/cachestat/test_cachestat.c
> > index 77620e7ecf56..a7adf42afb20 100644
> > --- a/tools/testing/selftests/cachestat/test_cachestat.c
> > +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> > @@ -25,7 +25,7 @@ static const char * const dev_files[] =3D {
> >  void print_cachestat(struct cachestat *cs)
> >  {
> >         ksft_print_msg(
> > -       "Using cachestat: Cached: %lu, Dirty: %lu, Writeback: %lu, Evic=
ted: %lu, Recently Evicted: %lu\n",
> > +       "Using cachestat: Cached: %llu, Dirty: %llu, Writeback: %llu, E=
victed: %llu, Recently Evicted: %llu\n",
> The fields of struct cachestat should all be unsigned longs,
> Is there a compiler warning that prompt this change?
Ah nvm, it's _u64. %llu is probably the better format specifier indeed.

Acked-by: Nhat Pham <nphamcs@gmail.com>
> >         cs->nr_cache, cs->nr_dirty, cs->nr_writeback,
> >         cs->nr_evicted, cs->nr_recently_evicted);
> >  }
> > --
> > 2.42.0
> >
