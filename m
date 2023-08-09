Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1F6776ACA
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 23:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjHIVLH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 17:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjHIVLG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 17:11:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD19BE76
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 14:11:04 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe1e44fd2bso8965e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Aug 2023 14:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691615463; x=1692220263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGWwEk1CXGSfUHS6hHNB1416wO7EbVlYeuLxfEO0mho=;
        b=pIP/Aq4RNHoSmXRTcfcMd0NreWN703bmAT9og27xLswzphuBji3M/nrY2IsOmTDBRL
         PdOhJlUsvNcQYuZLeycozUmLq8/ebuu8635WAroMgxcYGuVS6XXqFaxqAAYy+qjCkDcr
         NGFxwr4nZ6t+syK1B42UA9WtZ3jf2SGG0S7ld6cHSqoOwcsIqFiuQsWgmkff1pF014Pp
         ZsgeeA0HnHJeBupZ2r7g8IFM9XpdWQvAmcsichS301wV07VTFwzeE2TBOim6bGA9ahQp
         VK9wscobpwTOgIU7BL5yb9v/EoapybveYQ5m9YQwi14dAQWSxLuYtH5MiNXeW6HAgr6H
         8sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691615463; x=1692220263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGWwEk1CXGSfUHS6hHNB1416wO7EbVlYeuLxfEO0mho=;
        b=k2ICmZ+2jT7jPXRZqIs0+wBElPwE2AJ2SQ9HcnhbyrxU/j9i/4Rwnqm0kE8XfO3Uod
         ZebxWJbs8Smyx5vGSBZCV04RCHZoufBrUe+C/SdW1kluflaDpD3EB2N75BWMtxKSMGfV
         bFiDgirdZqfsfcjSQPIEVE5sjVp4SNsatYSw+WoIB3IF8cUiQJIYkHbTibsK4rPmcGTK
         n0FhM4wQYTbyiK+wBsRLyWXAB7Uic0DjFMB7E6eAQsz7s76LmN4X1FqfrmamNt37CJYA
         aFtL5D0n7cEx34VMX+5W0WyInxB1AIk69A/mruWDiPuG3it3o9WNgEdFRej8GgwRQJGC
         gMMA==
X-Gm-Message-State: AOJu0YyTU1+4IoEYKiTL/75kTJKe1eKdcTVTzosjNddWqp956lD/FpqU
        G3H9xlkWFLMAsj4bpmDHBEgJ6ECm7pGDPHhyJ1jBYqi1Gl/cVBor49V6yA==
X-Google-Smtp-Source: AGHT+IE97Gt+uL0jUA/R8XqLl3m3pevtht6FglRL/lyPkRqv/MG/ueIdVfRd3VAuWgMlwyj8Vwe4cT4WOoz5XL100EY=
X-Received: by 2002:a05:600c:c05:b0:3fe:5228:b7a2 with SMTP id
 fm5-20020a05600c0c0500b003fe5228b7a2mr153553wmb.5.1691615463245; Wed, 09 Aug
 2023 14:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230809155438.22470-1-rf@opensource.cirrus.com> <20230809155438.22470-3-rf@opensource.cirrus.com>
In-Reply-To: <20230809155438.22470-3-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Wed, 9 Aug 2023 17:10:51 -0400
Message-ID: <CA+GJov5Txxq=V2_N8LNM3gHtP6sjS5CKhj-pzpYqN8mVm-a3ww@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] kunit: kunit-test: Add test cases for extending
 log buffer
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
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

On Wed, Aug 9, 2023 at 11:54=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add test cases for the dynamically-extending log buffer.
>
> kunit_log_init_frag_test() tests that kunit_init_log_frag() correctly
> initializes new struct kunit_log_frag.
>
> kunit_log_extend_test_1() logs a series of numbered lines then tests
> that the resulting log contains all the lines.
>
> kunit_log_extend_test_2() logs a large number of lines of varying length
> to create many fragments, then tests that all lines are present.
>
> kunit_log_newline_test() has a new test to append a line that is exactly
> the length of the available space in the current fragment and check that
> the resulting log has a trailing '\n'.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Hello!

These tests now pass for me. Thanks!

I do have a few comments below mostly regarding comments and a few
clarifying questions.

-Rae

> ---
>  lib/kunit/kunit-test.c | 182 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 174 insertions(+), 8 deletions(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index a199f83bac67..c0ee33a8031e 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -7,6 +7,7 @@
>   */
>  #include <kunit/test.h>
>  #include <kunit/test-bug.h>
> +#include <linux/prandom.h>
>
>  #include "try-catch-impl.h"
>
> @@ -530,10 +531,12 @@ static struct kunit_suite kunit_resource_test_suite=
 =3D {
>         .test_cases =3D kunit_resource_test_cases,
>  };
>
> -static char *get_concatenated_log(struct kunit *test, const struct list_=
head *log)
> +static char *get_concatenated_log(struct kunit *test, const struct list_=
head *log,
> +                                 int *num_frags)
>  {
>         struct kunit_log_frag *frag;
>         size_t len =3D 0;
> +       int frag_count =3D 0;
>         char *p;
>
>         list_for_each_entry(frag, log, list)
> @@ -542,24 +545,42 @@ static char *get_concatenated_log(struct kunit *tes=
t, const struct list_head *lo
>         len++; /* for terminating '\0' */
>         p =3D kunit_kzalloc(test, len, GFP_KERNEL);
>
> -       list_for_each_entry(frag, log, list)
> +       list_for_each_entry(frag, log, list) {
>                 strlcat(p, frag->buf, len);
> +               ++frag_count;
> +       }
> +
> +       if (num_frags)
> +               *num_frags =3D frag_count;
>
>         return p;
>  }
>
> -static void kunit_log_test(struct kunit *test)
> +static void kunit_log_init_frag_test(struct kunit *test)
>  {
> -       struct kunit_suite suite;
>         struct kunit_log_frag *frag;
>
> -       suite.log =3D kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL)=
;
> -       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
> -       INIT_LIST_HEAD(suite.log);
>         frag =3D kunit_kmalloc(test, sizeof(*frag), GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
> +       memset(frag, 0x5a, sizeof(*frag));
> +

Why is the fragment getting filled here with memset? Should this be
tested? Feel free to let me know, I'm just uncertain.

>         kunit_init_log_frag(frag);
>         KUNIT_EXPECT_EQ(test, frag->buf[0], '\0');
> +       KUNIT_EXPECT_TRUE(test, list_is_first(&frag->list, &frag->list));
> +       KUNIT_EXPECT_TRUE(test, list_is_last(&frag->list, &frag->list));
> +}
> +
> +static void kunit_log_test(struct kunit *test)
> +{
> +       struct kunit_suite suite;
> +       struct kunit_log_frag *frag;
> +
> +       suite.log =3D kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL)=
;
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
> +       INIT_LIST_HEAD(suite.log);
> +       frag =3D kunit_kzalloc(test, sizeof(*frag), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
> +       kunit_init_log_frag(frag);
>         list_add_tail(&frag->list, suite.log);
>
>         kunit_log(KERN_INFO, test, "put this in log.");
> @@ -586,23 +607,168 @@ static void kunit_log_test(struct kunit *test)
>
>  static void kunit_log_newline_test(struct kunit *test)
>  {
> +       struct kunit_suite suite;
>         struct kunit_log_frag *frag;
> +       char *p;

Similar to last email, could we change p to be a more descriptive name
such as concat_log?

>
>         kunit_info(test, "Add newline\n");
>         if (test->log) {
>                 frag =3D list_first_entry(test->log, struct kunit_log_fra=
g, list);
>                 KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(frag->buf, "Add ne=
wline\n"),
>                         "Missing log line, full log:\n%s",
> -                       get_concatenated_log(test, test->log));
> +                       get_concatenated_log(test, test->log, NULL));
>                 KUNIT_EXPECT_NULL(test, strstr(frag->buf, "Add newline\n\=
n"));
> +

Should this section of kunit_log_newline_test be separated into a new
test? This test seems a bit long and seems to have two distinct
sections?

> +               suite.log =3D kunit_kzalloc(test, sizeof(*suite.log), GFP=
_KERNEL);
> +               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
> +               INIT_LIST_HEAD(suite.log);

I would love to see a comment here to explain and break up this
section similar to the comment from the previous email.

> +               frag =3D kunit_kzalloc(test, sizeof(*frag), GFP_KERNEL);
> +               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
> +               kunit_init_log_frag(frag);
> +               list_add_tail(&frag->list, suite.log);
> +
> +               /* String that exactly fills fragment leaving no room for=
 \n */
> +               memset(frag->buf, 0, sizeof(frag->buf));
> +               memset(frag->buf, 'x', sizeof(frag->buf) - 9);
> +               kunit_log_append(suite.log, "12345678");
> +               p =3D get_concatenated_log(test, suite.log, NULL);
> +               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +               KUNIT_EXPECT_NOT_NULL_MSG(test, strstr(p, "x12345678\n"),
> +                       "Newline not appended when fragment is full. Log =
is:\n'%s'", p);
>         } else {
>                 kunit_skip(test, "only useful when debugfs is enabled");
>         }
>  }
>
> +static void kunit_log_extend_test_1(struct kunit *test)

In general, I would really like to see more comments in the next two
tests describing the test behavior. I would prefer a comment for each
of the while/do-while loops below. I just found the behavior to be
slightly confusing to understand without comments (although I do
appreciate the comments that are in kunit_log_extend_test_2).

Also, I really appreciate how detailed these tests are.

Another potential idea is to rename these two tests to be
kunit_log_extend_test() and kunit_log_rand_extend_test() instead to be
more descriptive?

> +{
> +#ifdef CONFIG_KUNIT_DEBUGFS
> +       struct kunit_suite suite;
> +       struct kunit_log_frag *frag;
> +       char line[60];
> +       char *p, *pn;

Similar to before, could we change p and pn to be slightly more
descriptive names? Maybe concat_log and newline_ptr or newline_log or
newline_char?

> +       size_t len, n;
> +       int num_lines, num_frags, i;
> +
> +       suite.log =3D kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL)=
;
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
> +       INIT_LIST_HEAD(suite.log);
> +       frag =3D kunit_kzalloc(test, sizeof(*frag), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
> +       kunit_init_log_frag(frag);
> +       list_add_tail(&frag->list, suite.log);
> +
> +       i =3D 0;
> +       len =3D 0;
> +       do {
> +               n =3D snprintf(line, sizeof(line),
> +                            "The quick brown fox jumps over the lazy pen=
guin %d\n", i);
> +               KUNIT_ASSERT_LT(test, n, sizeof(line));
> +               kunit_log_append(suite.log, line);
> +               ++i;
> +               len +=3D n;
> +       }  while (len < (sizeof(frag->buf) * 30));

Are we trying to restrict the num_frags to less than 30? And then we
could check that with a KUNIT_EXPECT? Currently, the num_frags are
just above 30. That is ok too. I just was wondering if this was
intentional? (Same as kunit_log_extend_test_2)

> +       num_lines =3D i;
> +
> +       p =3D get_concatenated_log(test, suite.log, &num_frags);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +       KUNIT_EXPECT_GT(test, num_frags, 1);
> +
> +       kunit_info(test, "num lines:%d num_frags:%d total len:%zu\n",
> +                  num_lines, num_frags, strlen(p));
> +
> +       i =3D 0;
> +       while ((pn =3D strchr(p, '\n')) !=3D NULL) {
> +               *pn =3D '\0';
> +               snprintf(line, sizeof(line),
> +                        "The quick brown fox jumps over the lazy penguin=
 %d", i);
> +               KUNIT_EXPECT_STREQ(test, p, line);
> +               p =3D pn + 1;
> +               ++i;
> +       }
> +       KUNIT_EXPECT_EQ(test, i, num_lines);
> +#else
> +       kunit_skip(test, "only useful when debugfs is enabled");
> +#endif
> +}
> +
> +static void kunit_log_extend_test_2(struct kunit *test)
> +{
> +#ifdef CONFIG_KUNIT_DEBUGFS
> +       struct kunit_suite suite;
> +       struct kunit_log_frag *frag;
> +       struct rnd_state rnd;
> +       char line[101];
> +       char *p, *pn;

Similar to above, could p and pn be renamed to be more descriptive?

> +       size_t len;
> +       int num_lines, num_frags, n, i;
> +
> +       suite.log =3D kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL)=
;
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
> +       INIT_LIST_HEAD(suite.log);
> +       frag =3D kunit_kzalloc(test, sizeof(*frag), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
> +       kunit_init_log_frag(frag);
> +       list_add_tail(&frag->list, suite.log);
> +
> +       /* Build log line of varying content */
> +       line[0] =3D '\0';
> +       i =3D 0;
> +       do {
> +               char tmp[9];
> +
> +               snprintf(tmp, sizeof(tmp), "%x", i++);
> +               len =3D strlcat(line, tmp, sizeof(line));
> +       } while (len < sizeof(line) - 1);

Could there be an expectation statement here to check the line has
been properly filled. Maybe checking the length?

> +
> +       /*
> +        * Log lines of different lengths until we have created
> +        * many fragments.
> +        * The "randomness" must be repeatable.
> +        */
> +       prandom_seed_state(&rnd, 3141592653589793238ULL);
> +       i =3D 0;
> +       len =3D 0;
> +       num_lines =3D 0;
> +       do {
> +               kunit_log_append(suite.log, "%s\n", &line[i]);
> +               len +=3D sizeof(line) - i;
> +               num_lines++;
> +               i =3D prandom_u32_state(&rnd) % (sizeof(line) - 1);
> +       } while (len < (sizeof(frag->buf) * 30));
> +
> +       /* There must be more than one buffer fragment now */
> +       KUNIT_EXPECT_FALSE(test, list_is_singular(suite.log));
> +
> +       p =3D get_concatenated_log(test, suite.log, &num_frags);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +       KUNIT_EXPECT_GT(test, num_frags, 1);
> +
> +       kunit_info(test, "num lines:%d num_frags:%d total len:%zu\n",
> +                  num_lines, num_frags, strlen(p));
> +
> +       prandom_seed_state(&rnd, 3141592653589793238ULL);
> +       i =3D 0;
> +       n =3D 0;
> +       while ((pn =3D strchr(p, '\n')) !=3D NULL) {
> +               *pn =3D '\0';
> +               KUNIT_EXPECT_STREQ(test, p, &line[i]);
> +               p =3D pn + 1;
> +               n++;
> +               i =3D prandom_u32_state(&rnd) % (sizeof(line) - 1);
> +       }
> +       KUNIT_EXPECT_EQ_MSG(test, n, num_lines, "Not enough lines.");

Is it possible for this to be too many lines instead? Should this
comment instead be "Unexpected number of lines". Also could we have a
similar message for the test above for this expectation regarding the
number of lines.


> +#else
> +       kunit_skip(test, "only useful when debugfs is enabled");
> +#endif
> +}
> +
>  static struct kunit_case kunit_log_test_cases[] =3D {
> +       KUNIT_CASE(kunit_log_init_frag_test),
>         KUNIT_CASE(kunit_log_test),
>         KUNIT_CASE(kunit_log_newline_test),
> +       KUNIT_CASE(kunit_log_extend_test_1),
> +       KUNIT_CASE(kunit_log_extend_test_2),
>         {}
>  };
>
> --
> 2.30.2
>
