Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6530B774CD8
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 23:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbjHHVSx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 17:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbjHHVSo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 17:18:44 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D8449CE
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 14:16:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so10415e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Aug 2023 14:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691529382; x=1692134182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBdvRieiB8dFFT8uavZWsfJqKc+2lRPExOCUtNLgaBw=;
        b=Mgpa25MNfI0MQEyzTW2SGw5hCallSXKKOBEgRFwKQ9K8BpRfTQjMGiH4zgKV1UzotL
         pes26JYXGS3kBm7+gHLNEaErV1uM5T6vke19Y0a6mCKBzSUw0tE5sVqIVf9LOtYxd5Fd
         QaVT02QLqic9i+hEVSL5R01EBVpru9BqWdJKuZciKx9Z4cI7VElKR7Lxv2q3ZWqtHNGk
         NrXxZcRT78Mi/lkQxYd+iFcWeAgbh1h8mJZFiazrLUhO+Al1aWZNkW7MT45H5IPrQRE2
         upNoWAHDgWiP1C6iAMdUW+ijN7Cmj+0F6+SZaeLn+D8NBkoSyglo3pqKGAeQLgbvkJG5
         dJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691529382; x=1692134182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBdvRieiB8dFFT8uavZWsfJqKc+2lRPExOCUtNLgaBw=;
        b=VPZ2hakE0XdP8/xPYKywtkmnerubVbUZ4+0uyoL8Od6/GhvP5Tvosj5PaqI4Ldp2S1
         UfvGHRLspbT+YkM+q72g82NcxSlYaAxYh76BQV5WCSaMpUkuHdmDRVsvim4NAFXeXOBM
         1O1ilfp2TN15//pVjZgnQ/p1Je6cMsdiwzoc0lQQ/h1bNqdEF9AEmN9d3VjDQRVSHuRu
         VBGs5QEt4Oa0orbDFTl3nSjB4QU7QDl4qgeKyWGYDqvJC2ifUf8tzv0hNak0ryFDl0uk
         m/3qWyLwv+v6YgrPVCBXfclt9wL4U5OTDUYXHyQmyIcLyoZaKXuzLh3WUxggemhtmz8d
         YzqQ==
X-Gm-Message-State: AOJu0Yz5n5GzYMSKg4/aSiFSkCzs5RDZxwZwlBv420nvyi/Z2bcDWLIt
        lA+t7PXNeqmuo3nlZru5kIO5doE7VqNzcANxAbrn4g==
X-Google-Smtp-Source: AGHT+IFMvidr0Y453JFit3OPdEG9OaGVnlUt5kE+YPKrUlrcVhzvv3TnV+Frkbsb/U+SJ9s9qEGSVgN62ildHbgMQrc=
X-Received: by 2002:a05:600c:1c1f:b0:3f4:fb7:48d4 with SMTP id
 j31-20020a05600c1c1f00b003f40fb748d4mr2180wms.3.1691529382353; Tue, 08 Aug
 2023 14:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230808123529.4725-1-rf@opensource.cirrus.com> <20230808123529.4725-3-rf@opensource.cirrus.com>
In-Reply-To: <20230808123529.4725-3-rf@opensource.cirrus.com>
From:   Rae Moar <rmoar@google.com>
Date:   Tue, 8 Aug 2023 17:16:11 -0400
Message-ID: <CA+GJov79EJLbdptX+hhTqa90C7A0aJ-wzjxF1LDn++jWHeNXFA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] kunit: kunit-test: Add test cases for extending
 log buffer
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
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

On Tue, Aug 8, 2023 at 8:35=E2=80=AFAM Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:
>
> Add test cases for the dynamically-extending log buffer.
>
> kunit_log_extend_test_1() logs a series of numbered lines then tests
> that the resulting log contains all the lines.
>
> kunit_log_extend_test_2() logs a large number of lines of varying length
> to create many fragments, then tests that all lines are present.
>
> kunit_log_frag_sized_line_test() logs a line that exactly fills a
> fragment. This should not cause an extension of the log or truncation
> of the line.
>
> kunit_log_newline_test() has a new test to append a line that is exactly
> the length of the available space in the current fragment and check that
> the resulting log has a trailing '\n'.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Hello!

I am happy to see so many tests in this patch series. I've been
working with these patches and the debugfs logs seem to be working
well.

However, when I ran the new kunit-log-test tests three of the tests
failed: kunit_log_extend_test_1(), kunit_log_extend_test_2(), and
kunit_log_newline_test().

The diagnostic info for kunit_log_extend_test_1() reports:

[20:55:27] # kunit_log_extend_test_1: EXPECTATION FAILED at
lib/kunit/kunit-test.c:705
[20:55:27] Expected p =3D=3D line, but
[20:55:27]     p =3D=3D "xxxxxx=E2=80=A6xxxx12345678"
[20:55:27]     line =3D=3D "The quick brown fox jumps over the lazy penguin=
 0"
=E2=80=A6
[20:55:27] # kunit_log_extend_test_1: EXPECTATION FAILED at
lib/kunit/kunit-test.c:705
[20:55:27] Expected p =3D=3D line, but
[20:55:27]     p =3D=3D "The quick brown fox jumps over the lazy penguin 1"
[20:55:27]     line =3D=3D "The quick brown fox jumps over the lazy penguin=
 4"
[20:55:27] # kunit_log_extend_test_1: EXPECTATION FAILED at
lib/kunit/kunit-test.c:705
[20:55:27] Expected p =3D=3D line, but
[20:55:27]     p =3D=3D "The quick brown fox jumps over the lazy penguin 2"
[20:55:27]     line =3D=3D "The quick brown fox jumps over the lazy penguin=
 5"
=E2=80=A6
[20:55:27] # kunit_log_extend_test_1: EXPECTATION FAILED at
lib/kunit/kunit-test.c:709
[20:55:27] Expected i =3D=3D num_lines, but
[20:55:27]     i =3D=3D 64 (0x40)
[20:55:27]     num_lines =3D=3D 141 (0x8d)

So it looks like the log contains a different number of lines than
expected which is causing the difference of 3 between expected and
what was obtained. Potentially the log is not getting cleared/freed
properly in between test cases?

The diagnostic info for kunit_log_extend_test_2() reports:

[20:55:27]     # kunit_log_extend_test_2: EXPECTATION FAILED at
lib/kunit/kunit-test.c:776
[20:55:27]     Expected p =3D=3D &line[i], but
[20:55:27]         p =3D=3D
"xxxxx...xxxxx123456780123456789abcdef101112131415161718191a1b1c1d1e1f20212=
2232425262728292a2b2c2d2e2f30313233343536373839"
[20:55:27]         &line[i] =3D=3D
"0123456789abcdef101112131415161718191a1b1c1d1e1f202122232425262728292a2b2c=
2d2e2f30313233343536373839"
[20:55:27]     # kunit_log_extend_test_2: EXPECTATION FAILED at
lib/kunit/kunit-test.c:781
[20:55:27]     Expected n =3D=3D num_lines, but
[20:55:27]         n =3D=3D 147 (0x93)
[20:55:27]         num_lines =3D=3D 155 (0x9b)
[20:55:27] Not enough lines.

Similar difference in the number of lines here.

The diagnostic info for kunit_log_newline_test() reports that the test
fails on this line:

KUNIT_EXPECT_EQ(test, p[strlen(p) - 1], '\n');

Let me know if you are seeing similar errors. I can post the full log
if that would be helpful.

-Rae

> ---
>  lib/kunit/kunit-test.c | 204 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 204 insertions(+)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 54dc011c8980..48967d12e053 100644
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
> @@ -530,6 +531,31 @@ static struct kunit_suite kunit_resource_test_suite =
=3D {
>         .test_cases =3D kunit_resource_test_cases,
>  };
>
> +static char *get_concatenated_log(struct kunit *test, const struct list_=
head *log,
> +                                 int *num_frags)
> +{
> +       struct kunit_log_frag *frag;
> +       size_t len =3D 0;
> +       int frag_count =3D 0;
> +       char *p;
> +
> +       list_for_each_entry(frag, log, list)
> +               len +=3D strlen(frag->buf);
> +
> +       len++; /* for terminating '\0' */
> +       p =3D kunit_kmalloc(test, len, GFP_KERNEL);
> +
> +       list_for_each_entry(frag, log, list) {
> +               strlcat(p, frag->buf, len);
> +               ++frag_count;
> +       }
> +
> +       if (num_frags)
> +               *num_frags =3D frag_count;
> +
> +       return p;
> +}
> +
>  static void kunit_log_test(struct kunit *test)
>  {
>         struct kunit_suite suite;
> @@ -568,7 +594,9 @@ static void kunit_log_test(struct kunit *test)
>
>  static void kunit_log_newline_test(struct kunit *test)
>  {
> +       struct kunit_suite suite;
>         struct kunit_log_frag *frag;
> +       char *p;
>
>         kunit_info(test, "Add newline\n");
>         if (test->log) {
> @@ -576,14 +604,190 @@ static void kunit_log_newline_test(struct kunit *t=
est)
>                 KUNIT_ASSERT_NOT_NULL_MSG(test, strstr(frag->buf, "Add ne=
wline\n"),
>                         "Missing log line, full log:\n%s", frag->buf);
>                 KUNIT_EXPECT_NULL(test, strstr(frag->buf, "Add newline\n\=
n"));
> +
> +               suite.log =3D kunit_kzalloc(test, sizeof(*suite.log), GFP=
_KERNEL);
> +               KUNIT_ASSERT_NOT_ERR_OR_NULL(test, suite.log);
> +               INIT_LIST_HEAD(suite.log);
> +               frag =3D kunit_kmalloc(test, sizeof(*frag), GFP_KERNEL);
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
> +{
> +#ifdef CONFIG_KUNIT_DEBUGFS
> +       struct kunit_suite suite;
> +       struct kunit_log_frag *frag;
> +       char line[60];
> +       char *p, *pn;
> +       size_t len, n;
> +       int num_lines, num_frags, i;
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
> +       size_t len;
> +       int num_lines, num_frags, n, i;
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
> +       /* Build log line of varying content */
> +       line[0] =3D '\0';
> +       i =3D 0;
> +       do {
> +               char tmp[9];
> +
> +               snprintf(tmp, sizeof(tmp), "%x", i++);
> +               len =3D strlcat(line, tmp, sizeof(line));
> +       } while (len < sizeof(line) - 1);
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
> +#else
> +       kunit_skip(test, "only useful when debugfs is enabled");
> +#endif
> +}
> +
> +static void kunit_log_frag_sized_line_test(struct kunit *test)
> +{
> +#ifdef CONFIG_KUNIT_DEBUGFS
> +       struct kunit_suite suite;
> +       struct kunit_log_frag *frag, *src;
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
> +       src =3D kunit_kzalloc(test, sizeof(*src), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, src);
> +       memset(src->buf, 'x', sizeof(src->buf) - 2);
> +       KUNIT_ASSERT_EQ(test, strlen(src->buf), sizeof(src->buf) - 2);
> +
> +       /* Log a string that exactly fills the fragment */
> +       kunit_log_append(suite.log, "%s\n", src->buf);
> +       KUNIT_EXPECT_TRUE(test, list_is_singular(suite.log));
> +       KUNIT_EXPECT_EQ(test, strlen(frag->buf), sizeof(frag->buf) - 1);
> +       strlcat(src->buf, "\n", sizeof(src->buf));
> +       KUNIT_EXPECT_STREQ(test, frag->buf, src->buf);
> +#else
> +       kunit_skip(test, "only useful when debugfs is enabled");
> +#endif
> +}
> +
>  static struct kunit_case kunit_log_test_cases[] =3D {
>         KUNIT_CASE(kunit_log_test),
>         KUNIT_CASE(kunit_log_newline_test),
> +       KUNIT_CASE(kunit_log_extend_test_1),
> +       KUNIT_CASE(kunit_log_extend_test_2),
> +       KUNIT_CASE(kunit_log_frag_sized_line_test),
>         {}
>  };
>
> --
> 2.30.2
>
