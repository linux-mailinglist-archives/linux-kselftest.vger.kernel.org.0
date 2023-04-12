Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DA66DFEDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 21:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDLTnS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 15:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDLTnQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 15:43:16 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67EFE59
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 12:43:07 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id u13so13170555ybu.5
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 12:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681328587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRRX+56b4iWtfLGfy2RTgoz2dxHD8CJnu37mSMLRBTo=;
        b=BFu3nG/THUSeNIXOrkrwgnVWvmiwmTaFTDuUYBkF9Po+ncyoests+La6h0j2n6w7B9
         +/IyV4sUvoEet5t1Oz5l3SdnsJ1vYTuFmodBiBGGTqtZuN5Bi9SvziQtNV6YoN0nE5Kv
         ZRgNZiFXMmPVMgWoIm401rW+GafmCiHD2v15YmBKRo8ZsWKjWXfyWR+8Bq0N3rAsrgiA
         N1wZA1zE2nQF0cKk+3R5wCUnizlC3SefeHzsF5VMSptRUsNFvj8rDxcOSikw04rxMk96
         8QdY3KwuJos3FgDgr/K9rifJXKUICFzla6vjDbJVdSYgzBg85SCXkvNzR/bUrVAM57j6
         13bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRRX+56b4iWtfLGfy2RTgoz2dxHD8CJnu37mSMLRBTo=;
        b=IIunHIGTDWXebTq2ujSGa43GM+6B+wgmTJAJC2qjQXu5jdCEKDz8LLBNmZbOdMn9hi
         t4ziOHCHP3FSOQgxc4T4fg71BCIQNZ2yk7e+aM+YtEx5U4mTvxR7XsdKld7pbimO3H8Q
         1Ocqhniz4YKYOClaFcck3xM6OnmCbHpvuoSxsSwQKmAIAqekVEua9AvHqdyZa37SpG+l
         o1Kzkensyqj2MPVID71FGIRxr6Ir6JBGNH1UZTlpK9N0uXQGQwabyyGG0vvmpAHkTqkF
         YVUJdquOsJ50AiodekytdvXre8JTOWsdBjEpZvsQVdJ4LEGf5u1QWwwSK0DbLHhJTwwG
         KfCg==
X-Gm-Message-State: AAQBX9chnj1F5VZDxq3rEsYCeDH6LJWStzWgpkJ6VhWxxwVjR7/mVFnL
        SflzUbR0PSgunuFanMirXg5v3GDdRxRIx0EU+ps/+g==
X-Google-Smtp-Source: AKy350bi72vr7o0RSCDI1vn5Z6HL2n9dR0FfPBJMKhfTJ5vsP+83MnekjZiezK6ag6ihYj+/Lg40WkZ9iWxyG3DzRW8=
X-Received: by 2002:a25:744e:0:b0:b8b:f61e:65ff with SMTP id
 p75-20020a25744e000000b00b8bf61e65ffmr4849481ybc.5.1681328586994; Wed, 12 Apr
 2023 12:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230411160056.1586-1-michal.wajdeczko@intel.com> <20230411160056.1586-3-michal.wajdeczko@intel.com>
In-Reply-To: <20230411160056.1586-3-michal.wajdeczko@intel.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 12 Apr 2023 15:42:56 -0400
Message-ID: <CA+GJov7UfgddRfy4n05YbeLevhAKAW_Rf8GKs49gp1XTw_Bdxg@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: Fix reporting of the skipped parameterized tests
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 11, 2023 at 12:01=E2=80=AFPM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> Logs from the parameterized tests that were skipped don't include
> SKIP directive thus they are displayed as PASSED. Fix that.

Hi Michal!

This fix looks good to me. Thanks for fixing this!

The only comment I would have for this patch is if we should consider
using an altered version of kunit_print_ok_not_ok() here instead.
However, it seems you address this in the next patch.

Thanks again,
Rae

Reviewed-by: Rae Moar <rmoar@google.com>

>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> ---
>  lib/kunit/test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index c9e15bb60058..5679197b5f8a 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -556,9 +556,11 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                                 kunit_log(KERN_INFO, &test,
>                                           KUNIT_SUBTEST_INDENT KUNIT_SUBT=
EST_INDENT
> -                                         "%s %d %s",
> +                                         "%s %d %s%s%s",
>                                           kunit_status_to_ok_not_ok(test.=
status),
> -                                         test.param_index + 1, param_des=
c);
> +                                         test.param_index + 1, param_des=
c,
> +                                         test.status =3D=3D KUNIT_SKIPPE=
D ? " # SKIP " : "",
> +                                         test.status =3D=3D KUNIT_SKIPPE=
D ? test.status_comment : "");
>
>                                 /* Get next param. */
>                                 param_desc[0] =3D '\0';
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230411160056.1586-3-michal.wajdeczko%40intel.com.
