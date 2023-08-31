Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7055F78F45B
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 23:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242079AbjHaVD6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 17:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240129AbjHaVD6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 17:03:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAD7107
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 14:03:55 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso1095e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Aug 2023 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693515834; x=1694120634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJAUqqvGaLCYiwvVg33mPRXvFUtQ/k9VdJc20d778XA=;
        b=BqQraZIYtNvGry9YMrLEo2GOHbHq92wPUy19DVh23G5+J38L2ilDq6SzxFuWvevqqe
         nyuKDMuLBK64FGUZyOAkNAsxGgD7SFM6jPFXX23kAp8FgOsVkjc0nP+X0NG823nokK2q
         LlT1yVcYSA9FKSiqiiwVOFxhkZAP8A4wSm/uljoFQyn0QuO62r1m8miHHTBseqE/9GRf
         IHSzBmEnRIPcIJULRsl3VmCb8P9UpHCw792dWkq7Vd10tkmfM+TVtYcfq2fcpUKL9Ne8
         NgjwJt0T+gtYKAISmhcSJ3e14a+M1ro/FO6ZUkaDpFcmCzQiYk4LaEtaJMNYwsfRJAZN
         q/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693515834; x=1694120634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJAUqqvGaLCYiwvVg33mPRXvFUtQ/k9VdJc20d778XA=;
        b=MB81aEAM1c/o3CgcKzWRdmpUOpfXZYKrY3o1sHCfmhNjSLJ7WgJwBYoPNQx8ZwWGjK
         1N/S3kOeoIiqx97mi1ls0Daz0v7kXuKw78HnJlL+0NZyMlK45XBBVgmz9JChZnNKZrm0
         GWGOTwTFuiZLNzUsy7GzG+0jgFfjWTr7TTXmWcL+KPorwAfOo6grHF8ZpFKkjJhyAmNK
         N6YhRl9CxjML3DSRnljX5khAaDRlXUQPTVcdJEZIO4V12wfUm3R49hAWQbN2wPzIbjeG
         428n/qW1Gx66sD9B4IJliSrv+mbDWnSp7mN41Sxavn/Giq85LzfQ20HZVJTTYE/G6rvl
         fF1w==
X-Gm-Message-State: AOJu0Yzm1+/siRzxgtlkNUrn9/gSWqDXdvv8KbJ+Irbb5sFGSByFMvzv
        hV3686YEsCcB/x2ZMxq+m/+gAtdpRNM1sR3ug4L/Sg==
X-Google-Smtp-Source: AGHT+IGh8s8CabmaKSQB1MYpjk1kSCMzAn0M6OAD8c0//CRbV8GTEqWMXrIRoaAdt4MQs24wXm4YVAPBGbwBLmrdOz4=
X-Received: by 2002:a05:600c:5113:b0:3fe:ef25:8b86 with SMTP id
 o19-20020a05600c511300b003feef258b86mr47151wms.4.1693515833721; Thu, 31 Aug
 2023 14:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230831071655.2907683-1-ruanjinjie@huawei.com> <20230831071655.2907683-5-ruanjinjie@huawei.com>
In-Reply-To: <20230831071655.2907683-5-ruanjinjie@huawei.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 31 Aug 2023 17:03:39 -0400
Message-ID: <CA+GJov6ay20xB9roSazVWQX7CRj_HSavOe7VCeF0f28g546vmQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] kunit: Fix the wrong error path in kunit_filter_suites()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        skhan@linuxfoundation.org, jk@codeconstruct.com.au,
        dlatypov@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
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

On Thu, Aug 31, 2023 at 3:17=E2=80=AFAM 'Jinjie Ruan' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Take the last kfree(parsed_filters) and add it to be the first. Take
> the first kfree(copy) and add it to be the last. The Best practice is to
> return these errors reversely.
>
> Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
> Fixes: abbf73816b6f ("kunit: fix possible memory leak in kunit_filter_sui=
tes()")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Hello!

This seems fine to me. See my comments from the last patch regarding a
potential change in the order of the patches.

Otherwise, this works for me.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/executor.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 7654c09c1ab1..da9444d22711 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -229,16 +229,16 @@ kunit_filter_suites(const struct kunit_suite_set *s=
uite_set,
>         filtered.end =3D copy;
>
>  err:
> -       if (*err)
> -               kfree(copy);
> +       if (filter_count)
> +               kfree(parsed_filters);
>
>         if (filter_glob) {
>                 kfree(parsed_glob.suite_glob);
>                 kfree(parsed_glob.test_glob);
>         }
>
> -       if (filter_count)
> -               kfree(parsed_filters);
> +       if (*err)
> +               kfree(copy);
>
>         return filtered;
>  }
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230831071655.2907683-5-ruanjinjie%40huawei.com.
