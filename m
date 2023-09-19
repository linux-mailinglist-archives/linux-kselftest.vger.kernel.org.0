Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F4C7A6CE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 23:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjISVTq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Sep 2023 17:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjISVTq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Sep 2023 17:19:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F4BAD
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 14:19:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-404f881aa48so34405e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Sep 2023 14:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695158379; x=1695763179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMmQrINiB4YFWAg2y3rBGkBRYK/jjwp5TBrlh2him8A=;
        b=xQeo8n98oJmDtBUsii0tSxNIoM9MO126YpKd7Xtl7YGtBh/HSgK7psD3sj2Gkg+vN5
         Vq73+D0kk5vJy0EIeMPW/PKvJ5/vD/cdyet9anQ1L72nNjO2dZWAKnIUFouhTeENObuf
         ju/gcaZQqgfzgfadwXO/fLFdeiO8+suYfg3Jm2mf60/RNLpScLKN5sm4xEjOix4eDNBB
         wiIw5cunjV7fDQpiKvS7KAHMgB9JRe7bh555XNfjPzrXmTl1fiNtyLjeONVDlI+9iqcH
         Z8A5QOh43h1gBxEiGhU576NpK4QOfSNGeAZvp5uBJ2UsLiADa4I1aN7dKUUkowBmaadR
         eDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695158379; x=1695763179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMmQrINiB4YFWAg2y3rBGkBRYK/jjwp5TBrlh2him8A=;
        b=mEJsYxtObHyPEvAQwAz94/bIqA1jhEvAvRwnmvcmfLorSiMhBszwhTEaoBnF05U0pa
         LGZELgYsKRJ2FL6ydbnTRk3kvseB4H26yj2VlNxa6dA7fKTq05GzHw+vwK0uA20yx9fD
         uLkOsjifSAT96yQNLP7M/Jr6mwaVlI8UTX+S+3Au3ATY+f+YFlvjDzaISbIXUL2kTXN7
         yv1hl6gQI+8wXcQK3i3x9Ab4gWrTHlUF1QIYGj5QP9GchE53SMqlyjoYdrUTR1to0avx
         gaWe4+ztI1EXz0Py1cV9vWu7BVHYUY2FBbeJyI1ARBDdXPjo1JUjYRCXjl7RDTzfeEsj
         OYTA==
X-Gm-Message-State: AOJu0YxvK2hy3/Lc92YM8PifF2TP2wYCc8GH9Ww4KRHg6V8Loo54HY0k
        FLuXxrMgpOpw1OCwig7Pm+T0C+T4WaY2HdjBLWNMnw==
X-Google-Smtp-Source: AGHT+IGrlEmfTda08vOIGUJ/rOcRftJ8T8BK91Yz5Mfg2u+1W8L3cLIaMchxGZq+qnNfRoqBW7UmbK2dec290au66gg=
X-Received: by 2002:a05:600c:3b1c:b0:3f4:fb7:48d4 with SMTP id
 m28-20020a05600c3b1c00b003f40fb748d4mr4356wms.3.1695158378589; Tue, 19 Sep
 2023 14:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230914114629.1517650-1-ruanjinjie@huawei.com> <20230914114629.1517650-5-ruanjinjie@huawei.com>
In-Reply-To: <20230914114629.1517650-5-ruanjinjie@huawei.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 19 Sep 2023 17:19:26 -0400
Message-ID: <CA+GJov7Uya8r4T6EtQQ03KQ7BPRsCb8N3y687eDxDitnJ3Aifw@mail.gmail.com>
Subject: Re: [PATCH 4/4] kunit: test: Fix the possible memory leak in executor_test
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        skhan@linuxfoundation.org, dlatypov@google.com,
        janusz.krzysztofik@linux.intel.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
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

On Thu, Sep 14, 2023 at 7:47=E2=80=AFAM 'Jinjie Ruan' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> If kunit_filter_suites() succeeds, not only copy but also filtered_suite
> and filtered_suite->test_cases should be freed.
>
> So use kunit_free_suite_set() to free the filtered_suite,
> filtered_suite->test_cases and copy as kunit_module_exit() and
> kunit_run_all_tests() do it.
>
> Fixes: e5857d396f35 ("kunit: flatten kunit_suite*** to kunit_suite** in .=
kunit_test_suites")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Hello!

This looks mostly good to me. But I have one notable comment. See below.

Thanks!
-Rae

> ---
>  lib/kunit/executor_test.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index b4f6f96b2844..987b81dce01e 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -56,7 +56,6 @@ static void filter_suites_test(struct kunit *test)
>         got =3D kunit_filter_suites(&suite_set, "suite2", NULL, NULL, &er=
r);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
> -       kfree_at_end(test, got.start);
>
>         /* Validate we just have suite2 */
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
> @@ -64,6 +63,9 @@ static void filter_suites_test(struct kunit *test)
>
>         /* Contains one element (end is 1 past end) */
>         KUNIT_ASSERT_EQ(test, got.end - got.start, 1);
> +
> +       if (!err)
> +               kunit_free_suite_set(got);

I definitely appreciate the change to free all of "got" rather than
just "got.start".

However, kfree_at_end used deferred actions to ensure the kfree would
occur at the end of the test. With this change, if the test fails the
suite set could not be freed.

Intead, is there any way to alter the function kfree_at_end (could be
renamed) to take in "got" and then use deferred actions to ensure
kunit_free_suite_set is called at the end of the test?

Let me know what you think about this.


>  }
>
>  static void filter_suites_test_glob_test(struct kunit *test)
> @@ -82,7 +84,6 @@ static void filter_suites_test_glob_test(struct kunit *=
test)
>         got =3D kunit_filter_suites(&suite_set, "suite2.test2", NULL, NUL=
L, &err);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
> -       kfree_at_end(test, got.start);
>
>         /* Validate we just have suite2 */
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
> @@ -93,6 +94,9 @@ static void filter_suites_test_glob_test(struct kunit *=
test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>         KUNIT_EXPECT_STREQ(test, (const char *)got.start[0]->test_cases[0=
].name, "test2");
>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
> +
> +       if (!err)
> +               kunit_free_suite_set(got);
>  }
>
>  static void filter_suites_to_empty_test(struct kunit *test)
> @@ -109,10 +113,12 @@ static void filter_suites_to_empty_test(struct kuni=
t *test)
>
>         got =3D kunit_filter_suites(&suite_set, "not_found", NULL, NULL, =
&err);
>         KUNIT_ASSERT_EQ(test, err, 0);
> -       kfree_at_end(test, got.start); /* just in case */
>
>         KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
>                                 "should be empty to indicate no match");
> +
> +       if (!err)
> +               kunit_free_suite_set(got);
>  }
>
>  static void parse_filter_attr_test(struct kunit *test)
> @@ -172,7 +178,6 @@ static void filter_attr_test(struct kunit *test)
>         got =3D kunit_filter_suites(&suite_set, NULL, filter, NULL, &err)=
;
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
> -       kfree_at_end(test, got.start);
>
>         /* Validate we just have normal_suite */
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]);
> @@ -183,6 +188,9 @@ static void filter_attr_test(struct kunit *test)
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
>         KUNIT_EXPECT_STREQ(test, got.start[0]->test_cases[0].name, "norma=
l");
>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].name);
> +
> +       if (!err)
> +               kunit_free_suite_set(got);
>  }
>
>  static void filter_attr_empty_test(struct kunit *test)
> @@ -200,10 +208,12 @@ static void filter_attr_empty_test(struct kunit *te=
st)
>
>         got =3D kunit_filter_suites(&suite_set, NULL, filter, NULL, &err)=
;
>         KUNIT_ASSERT_EQ(test, err, 0);
> -       kfree_at_end(test, got.start); /* just in case */
>
>         KUNIT_EXPECT_PTR_EQ_MSG(test, got.start, got.end,
>                                 "should be empty to indicate no match");
> +
> +       if (!err)
> +               kunit_free_suite_set(got);
>  }
>
>  static void filter_attr_skip_test(struct kunit *test)
> @@ -222,7 +232,6 @@ static void filter_attr_skip_test(struct kunit *test)
>         got =3D kunit_filter_suites(&suite_set, NULL, filter, "skip", &er=
r);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start);
>         KUNIT_ASSERT_EQ(test, err, 0);
> -       kfree_at_end(test, got.start);
>
>         /* Validate we have both the slow and normal test */
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, got.start[0]->test_cases);
> @@ -233,6 +242,9 @@ static void filter_attr_skip_test(struct kunit *test)
>         /* Now ensure slow is skipped and normal is not */
>         KUNIT_EXPECT_EQ(test, got.start[0]->test_cases[0].status, KUNIT_S=
KIPPED);
>         KUNIT_EXPECT_FALSE(test, got.start[0]->test_cases[1].status);
> +
> +       if (!err)
> +               kunit_free_suite_set(got);
>  }
>
>  static struct kunit_case executor_test_cases[] =3D {
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230914114629.1517650-5-ruanjinjie%40huawei.com.
