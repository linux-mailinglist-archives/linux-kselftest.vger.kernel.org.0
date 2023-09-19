Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BED67A6CDE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 23:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjISVTF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 17:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjISVTF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 17:19:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB60AF
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 14:18:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4047c6ec21dso32445e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 14:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695158337; x=1695763137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0mEjcifAMmd5ubXRblSphhZqePAkqWyOBejjs3OPgzw=;
        b=LVZampVqDstBkkl/CfPQIngFTT0tPmgZNJmAIIR5+ShoRpeWz1hygkBimXHsKfmWIt
         43xf996gPka+GBC4o0zEEce88LOV9P4hrlFJACzoijOYo3vfRfQs55maIIeBCN5b4iNq
         Vlx4GUBnkLKDkVPgxw3NkAyDn62tz/b6A35hEavPQ5Sz9ioKWZXmS8logCtXlLujmh7Y
         tyk96KpMLprvPZ5ELFxRJkWpbEaCFLi0Vzis0wt18K2VGGtGvydsbkqirWUiYhj3di6e
         gw6HwtrPtPKgjvofCnT5mNLbFybFARfs23J2OUa2sV8U8G78ViFc8MBduVN/hJw3zHUr
         R2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695158337; x=1695763137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mEjcifAMmd5ubXRblSphhZqePAkqWyOBejjs3OPgzw=;
        b=ZGMTJELDNBIUHxjZdd/Dxhi/Aniuc+b/bZrCLGEWgdxT0vE+hmkZg8k/AcPnzoa8pk
         P5H8idAmJjUQqmlQdYAqbRtR5xrCzkRA58n6TB5jtnDZbBUoQhCsa3gr17GnKOxlltM3
         yHnLzLgq5PpYk7MXWqpN66X4o1gs6NMh8IhP7azJS7KvkMOr/TRg4sYVuuhI8NgRzP1B
         fE+7hQnZ+S74Scc5CPDBMTDy1FSgPW2v5O+iFX3EmljPcgdgxl3xZac8m61yRip755WQ
         D9pJGcX4DxAX5bfQ9Ic/BgV52s6F2tSa/4Wve7Y0CsrPvfBG2zcGyTRMGAJvmZpDiqVk
         BG3A==
X-Gm-Message-State: AOJu0YxOuG05YMUl1zD/M1Rqge5eKrGtgRPy3s85jab9dHWbqVlehIuB
        vxd9Ew7U0wXV5IXbjstCTdolfv5BAvGUTxVAmatE2g==
X-Google-Smtp-Source: AGHT+IHw1g4Y330tGOXgL2B4af6/+QpN/ACMaYhna1qhrJLljNxH1iMdyRQsbkLxT5EVrjuvF7AK6BPNwi9zBtYakSM=
X-Received: by 2002:a05:600c:49a4:b0:404:7462:1f87 with SMTP id
 h36-20020a05600c49a400b0040474621f87mr25176wmp.6.1695158337184; Tue, 19 Sep
 2023 14:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230914114629.1517650-1-ruanjinjie@huawei.com> <20230914114629.1517650-4-ruanjinjie@huawei.com>
In-Reply-To: <20230914114629.1517650-4-ruanjinjie@huawei.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 19 Sep 2023 17:18:45 -0400
Message-ID: <CA+GJov6VnaojY7aA7LvhwmWwPziyAVOLZB97oAJMTWRh19r0eg@mail.gmail.com>
Subject: Re: [PATCH 3/4] kunit: Fix possible memory leak in kunit_filter_suites()
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        skhan@linuxfoundation.org, dlatypov@google.com,
        janusz.krzysztofik@linux.intel.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 14, 2023 at 7:47=E2=80=AFAM 'Jinjie Ruan' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> If the outer layer for loop is iterated more than once and it fails not
> in the first iteration, the filtered_suite and filtered_suite->test_cases
> allocated in the last kunit_filter_attr_tests() in last inner for loop
> is leaked.
>
> So add a new free_filtered_suite err label and free the filtered_suite
> and filtered_suite->test_cases so far. And change kmalloc_array of copy
> to kcalloc to Clear the copy to make the kfree safe.
>
> Fixes: 5d31f71efcb6 ("kunit: add kunit.filter_glob cmdline option to filt=
er suites")
> Fixes: 529534e8cba3 ("kunit: Add ability to filter attributes")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Hello!

This looks good to me. I just have one comment below.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/executor.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 9358ed2df839..1236b3cd2fbb 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -157,10 +157,11 @@ kunit_filter_suites(const struct kunit_suite_set *s=
uite_set,
>         struct kunit_suite_set filtered =3D {NULL, NULL};
>         struct kunit_glob_filter parsed_glob;
>         struct kunit_attr_filter *parsed_filters =3D NULL;
> +       struct kunit_suite * const *suites;
>
>         const size_t max =3D suite_set->end - suite_set->start;
>
> -       copy =3D kmalloc_array(max, sizeof(*filtered.start), GFP_KERNEL);
> +       copy =3D kcalloc(max, sizeof(*filtered.start), GFP_KERNEL);
>         if (!copy) { /* won't be able to run anything, return an empty se=
t */
>                 return filtered;
>         }
> @@ -195,7 +196,7 @@ kunit_filter_suites(const struct kunit_suite_set *sui=
te_set,
>                                         parsed_glob.test_glob);
>                         if (IS_ERR(filtered_suite)) {
>                                 *err =3D PTR_ERR(filtered_suite);
> -                               goto free_parsed_filters;
> +                               goto free_filtered_suite;
>                         }
>                 }
>                 if (filter_count > 0 && parsed_filters !=3D NULL) {
> @@ -212,11 +213,11 @@ kunit_filter_suites(const struct kunit_suite_set *s=
uite_set,
>                                 filtered_suite =3D new_filtered_suite;
>
>                                 if (*err)
> -                                       goto free_parsed_filters;
> +                                       goto free_filtered_suite;
>
>                                 if (IS_ERR(filtered_suite)) {
>                                         *err =3D PTR_ERR(filtered_suite);
> -                                       goto free_parsed_filters;
> +                                       goto free_filtered_suite;
>                                 }
>                                 if (!filtered_suite)
>                                         break;
> @@ -231,6 +232,14 @@ kunit_filter_suites(const struct kunit_suite_set *su=
ite_set,
>         filtered.start =3D copy_start;
>         filtered.end =3D copy;
>
> +free_filtered_suite:
> +       if (*err) {
> +               for (suites =3D copy_start; suites < copy; suites++) {
> +                       kfree((*suites)->test_cases);
> +                       kfree(*suites);
> +               }
> +       }
> +

As this is pretty similar code to kunit_free_suite_set, I wish you
could use that method instead but I'm not actually sure it would be
cleaner.


>  free_parsed_filters:
>         if (filter_count)
>                 kfree(parsed_filters);
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230914114629.1517650-4-ruanjinjie%40huawei.com.
