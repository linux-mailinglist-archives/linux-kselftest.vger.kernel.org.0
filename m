Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585387783DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 00:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjHJW67 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 18:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHJW67 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 18:58:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECCC272D
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 15:58:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe2a116565so13025e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 15:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691708336; x=1692313136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdpsaGQQt2Y4RqxqF4yAo63jfWsUC4HuA7va+4pi9tU=;
        b=SGchQVlV2GHHQcGnMheJD42brf+UWBoWStKxi7jCpOHhHaPzrkK7lH43eMadTOilqC
         YgyWOToZg4a2UbuPNYAu+G5zhOem0mTsBbAXbCbfyLHelUKNYd6Ax/d6m90r9RNMHEfD
         petT6B8PFavaemF4lMKo+i69tR+o6yQ1fK0cEe1lsLUYqTGBd0gbHAqjoL3s2RZ4X+b7
         K4jb0qcck8mSYyQRuwL5CcddxcJjGkoBhZ+SGfWmA4I8jDcQFhpR+PsYaVPG7Js/7XVT
         PwRYb/Ht+sKlNSoCUqfaj1PBMelKYt/DF+4vB5FACo5PXuBcXJZtVexjQRhicLgMQSSH
         /Oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691708336; x=1692313136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdpsaGQQt2Y4RqxqF4yAo63jfWsUC4HuA7va+4pi9tU=;
        b=dnvB3yEADr+8Fbneke6iNnXo1EL3Bh0QMLSu1dE6CZjvq054nW/Jm6ECc4Iuoq//Jt
         QH8K4sKZJy5tbG1CMN6VLLMkN3AxJMkt6cf+qzdijMi/+Clk2qwEW8nKJTCBav7SvQSG
         NxKh2aII+s8YACbdc5R7il4R1fR5JYrw7w3CXGzi1sSBcINTj1Vx8Nmk2e5qXoyIlwFt
         NKPGHODF/aeNe4E8+6MS2TIcIhA/scmVlJh4o2y/I2ZUXN39mBrAHB2fw/wNODWjZBqv
         wvt/B2o4RM4vA7B20zGsHx7VLLGBkPpMILOPxeXSxZKb15AXaTUYPAWj31k0KbSQ7kmd
         y/0Q==
X-Gm-Message-State: AOJu0Yy8kQe71msd3BogGOv12mOWPf/0MG2YPts9M5Gnft7EcyTz5IJY
        Hk9d+Chrtk+hLcHVZwQEiKesJ5uM/plAX86XaH3m/A==
X-Google-Smtp-Source: AGHT+IGRXDB2PKsFQJ6DCjTEGkXksb3XeTBtNQyLEIBCKvFMivhydZE79tF8eX6FnPYURdHIrKVHW/Bezy184SHJ22Y=
X-Received: by 2002:a7b:cc93:0:b0:3f1:70d1:21a6 with SMTP id
 p19-20020a7bcc93000000b003f170d121a6mr54523wma.0.1691708336474; Thu, 10 Aug
 2023 15:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230809155438.22470-1-rf@opensource.cirrus.com> <20230809155438.22470-6-rf@opensource.cirrus.com>
In-Reply-To: <20230809155438.22470-6-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Thu, 10 Aug 2023 17:58:44 -0500
Message-ID: <CA+GJov5MH4Y72w4L7ue1OWp8747qOrm9fc4EPz7jzLrN7DtR9w@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] kunit: kunit-test: Add test cases for logging very
 long lines
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

On Wed, Aug 9, 2023 at 10:54=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add kunit_log_long_line_test() to test that logging a line longer than
> the buffer fragment size doesn't truncate the line.
>
> Add extra tests to kunit_log_newline_test() for lines longer than the
> buffer fragment size.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Hello!

This test looks good to me. I have included just a few comments below.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/kunit-test.c | 84 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 9ac81828d018..c079550c3afd 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -609,7 +609,7 @@ static void kunit_log_newline_test(struct kunit *test=
)
>  {
>         struct kunit_suite suite;
>         struct kunit_log_frag *frag;
> -       char *p;
> +       char *p, *line;
>
>         kunit_info(test, "Add newline\n");
>         if (test->log) {
> @@ -635,6 +635,33 @@ static void kunit_log_newline_test(struct kunit *tes=
t)
>                 KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
>                 KUNIT_EXPECT_NOT_NULL_MSG(test, strstr(p, "x12345678\n"),
>                         "Newline not appended when fragment is full. Log =
is:\n'%s'", p);
> +               kunit_kfree(test, p);
> +

I really like the thoroughness of this test. However, I do wonder if
this newline test could be broken into at least 2 parts as the test is
quite long with all these additions. I spoke on this in a previous
patch and just wanted to touch on it here as well.

> +               /* String that is much longer than a fragment */
> +               line =3D kunit_kzalloc(test, sizeof(frag->buf) * 6, GFP_K=
ERNEL);
> +               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, line);
> +               memset(line, 'x', (sizeof(frag->buf) * 6) - 1);
> +               kunit_log_append(suite.log, "%s", line);
> +               p =3D get_concatenated_log(test, suite.log, NULL);
> +               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +               KUNIT_EXPECT_EQ(test, p[strlen(p) - 1], '\n');
> +               KUNIT_EXPECT_NULL(test, strstr(p, "\n\n"));
> +               kunit_kfree(test, p);
> +

I would also consider adding comments between these three cases to
describe their differences and maybe what the desired behavior would
be.

> +               kunit_log_append(suite.log, "%s\n", line);
> +               p =3D get_concatenated_log(test, suite.log, NULL);
> +               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +               KUNIT_EXPECT_EQ(test, p[strlen(p) - 1], '\n');
> +               KUNIT_EXPECT_NULL(test, strstr(p, "\n\n"));
> +               kunit_kfree(test, p);
> +
> +               line[strlen(line) - 1] =3D '\n';
> +               kunit_log_append(suite.log, "%s", line);
> +               p =3D get_concatenated_log(test, suite.log, NULL);
> +               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +               KUNIT_EXPECT_EQ(test, p[strlen(p) - 1], '\n');
> +               KUNIT_EXPECT_NULL(test, strstr(p, "\n\n"));
> +               kunit_kfree(test, p);
>         } else {
>                 kunit_skip(test, "only useful when debugfs is enabled");
>         }
> @@ -799,6 +826,60 @@ static void kunit_log_frag_sized_line_test(struct ku=
nit *test)
>  #endif
>  }
>
> +static void kunit_log_long_line_test(struct kunit *test)
> +{
> +#ifdef CONFIG_KUNIT_DEBUGFS
> +       struct kunit_suite suite;
> +       struct kunit_log_frag *frag;
> +       struct rnd_state rnd;
> +       char *line, *p, *pn;
> +       size_t line_buf_size, len;
> +       int num_frags, i;
> +
> +       suite.log =3D kunit_kzalloc(test, sizeof(*suite.log), GFP_KERNEL)=
;
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
> +       INIT_LIST_HEAD(suite.log);
> +       frag =3D kunit_kmalloc(test, sizeof(*frag), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, frag);
> +       kunit_init_log_frag(frag);
> +       KUNIT_EXPECT_EQ(test, frag->buf[0], '\0');
> +       list_add_tail(&frag->list, suite.log);
> +
> +       /* Create a very long string to be logged */
> +       line_buf_size =3D sizeof(frag->buf) * 6;
> +       line =3D kunit_kmalloc(test, line_buf_size, GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, line);
> +       line[0] =3D '\0';
> +
> +       prandom_seed_state(&rnd, 3141592653589793238ULL);

I was a little worried about including a randomized string but since
it does not need to be reproduced here it should be fine. I also
haven't seen any issues with the tests with the randomized strings
being nondeterministic.

> +       len =3D 0;
> +       do {
> +               static const char fill[] =3D
> +                       "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuv=
wxyz";
> +
> +               i =3D prandom_u32_state(&rnd) % (sizeof(fill) - 1);
> +               len =3D strlcat(line, &fill[i], line_buf_size);
> +       } while (len < line_buf_size);
> +
> +       kunit_log_append(suite.log, "%s\n", line);
> +
> +       p =3D get_concatenated_log(test, suite.log, &num_frags);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, p);
> +       KUNIT_EXPECT_GT(test, num_frags, 1);
> +
> +       kunit_info(test, "num_frags:%d total len:%zu\n", num_frags, strle=
n(p));
> +
> +       /* Don't compare the trailing '\n' */
> +       pn =3D strrchr(p, '\n');
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test, pn);
> +       *pn =3D '\0';
> +       KUNIT_EXPECT_EQ(test, strlen(p), strlen(line));
> +       KUNIT_EXPECT_STREQ(test, p, line);
> +#else
> +       kunit_skip(test, "only useful when debugfs is enabled");
> +#endif
> +}
> +
>  static struct kunit_case kunit_log_test_cases[] =3D {
>         KUNIT_CASE(kunit_log_init_frag_test),
>         KUNIT_CASE(kunit_log_test),
> @@ -806,6 +887,7 @@ static struct kunit_case kunit_log_test_cases[] =3D {
>         KUNIT_CASE(kunit_log_extend_test_1),
>         KUNIT_CASE(kunit_log_extend_test_2),
>         KUNIT_CASE(kunit_log_frag_sized_line_test),
> +       KUNIT_CASE(kunit_log_long_line_test),
>         {}
>  };
>
> --
> 2.30.2
>
