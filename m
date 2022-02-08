Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB8F4AE42C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 23:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387628AbiBHWZ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 17:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386507AbiBHUpK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 15:45:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30807C0612C0
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 12:45:10 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id y3so1274112ejf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 12:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yPEklzd5P3RvDStq1HrBugkoI/k1o+Zh5jpZZLMH+bc=;
        b=MISdIeXN8vS4hXJZFD3ifq6xpn6+5l5cEbOpVUZOae3tUVCpt4xujvtPOjKx+SYQVj
         LLUbcO0NWxqBOQCV4exGLxzkqnf6UruORYwMYbJrxNABkDGeVpWE0/GtaZBwH2QKfHIN
         m4urBU1VGgaH2n5+ys45uO/8DUCL23s6aXLMlhaOL00af+xYQG6EuT7fQC3E7SxKVM+J
         3M3BrcQelTKTpdcrYjNc8X2ZZFmP1ou1On01GjAduKKXsGgH6TPYq2dO+xU1ZvDM7Vhv
         r4XaXGFFDNjqDbOZ6PeCNUej2a6Gy/Isth8XLFiHTT6NuefmKdrrFDwjDcXFU54YzQ6r
         us/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPEklzd5P3RvDStq1HrBugkoI/k1o+Zh5jpZZLMH+bc=;
        b=RNaYcb1bW0S1VULGtuZ0rGAQ4cTCGdcHpTpB4e1MZK3Q263hKApmESE4sZxHXeIx6s
         336T6Ep0dbc7xJuBZCSxYVvBUXbCKmzBqx2BgT8OsPSfRIgwI/Gcgx1MmYSzpOWVu/4f
         5Ayp899lorf3bLLXP+fTX61rABGgPZXQcjErND7OL6q+cr3anfFuWi0DjXfJtpRkDcoy
         zlCRk0SigR8Ev+NXFBRJkxTfxlvnfcGy4wcgJ+DFdWZvX9gMAoEsaf5/u/RRhvZzxGv/
         j/icf72biDotP1EgD+mDhT+4YUfp4of57wEJbrf26cTe9o0QCusiMIyAPtvwM6t1g+2G
         cWeQ==
X-Gm-Message-State: AOAM532OVBY0pY7eEayJtgjTFbbIaktBEXB8+22bA7ksVWm6f1yWuM84
        roC2JFL+nhBqukjqxZe4DjDmHpNcEOnsbJBczgK0/A==
X-Google-Smtp-Source: ABdhPJwz6DVNjSJBQJcz/MfXdqazjduX1T6GflwHxz4x2LiT9OoQhFW2OCbliaH3FAwjdnQc1NyZAjzGEpIw1Yg3SZc=
X-Received: by 2002:a17:907:6d20:: with SMTP id sa32mr5271477ejc.425.1644353107911;
 Tue, 08 Feb 2022 12:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20220208040122.695258-1-davidgow@google.com> <20220208040122.695258-3-davidgow@google.com>
In-Reply-To: <20220208040122.695258-3-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 8 Feb 2022 12:44:56 -0800
Message-ID: <CAGS_qxpYuXPavOVOvp07UUhBcrPYH7P5EZKrVOP5WN2s8t3mSA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] list: test: Add a test for list_entry_is_head()
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 7, 2022 at 8:02 PM David Gow <davidgow@google.com> wrote:
>
> The list_entry_is_head() macro was added[1] after the list KUnit tests,
> so wasn't tested. Add a new KUnit test to complete the set.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e130816164e244b692921de49771eeb28205152d
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Daniel Latypov <dlatypov@google.com>

Similar to the previous patch, we can maybe consider using the _MSG
variants here

> ---
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20220205061539.273330-3-davidgow@google.com/
> - Rework the test entirely to better match the improved list_is_head()
>   test.
>
> ---
>  lib/list-test.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/lib/list-test.c b/lib/list-test.c
> index 1960615d1a9f..80dd14c4ca1f 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -546,6 +546,22 @@ static void list_test_list_entry(struct kunit *test)
>                                 struct list_test_struct, list));
>  }
>
> +static void list_test_list_entry_is_head(struct kunit *test)
> +{
> +       struct list_test_struct test_struct1, test_struct2, test_struct3;
> +
> +       INIT_LIST_HEAD(&test_struct1.list);
> +       INIT_LIST_HEAD(&test_struct3.list);
> +
> +       list_add_tail(&test_struct2.list, &test_struct1.list);
> +
> +       KUNIT_EXPECT_TRUE(test, list_entry_is_head((&test_struct1), &test_struct1.list, list));
> +       /* Non-head element of same list */
> +       KUNIT_EXPECT_FALSE(test, list_entry_is_head((&test_struct2), &test_struct1.list, list));
> +       /* Head element of different list */
> +       KUNIT_EXPECT_FALSE(test, list_entry_is_head((&test_struct3), &test_struct1.list, list));

Unlike the list_is_head()
* this macro is marginally more complicated (barely).
* these lines already go over 80 chars.
* macros in EXPECT's get printed out in expanded form (less legible on
their own than a func call is)

So perhaps

KUNIT_EXPECT_FALSE_MSG(test, ..., "Head element of different list")

?

> +}
> +
>  static void list_test_list_first_entry(struct kunit *test)
>  {
>         struct list_test_struct test_struct1, test_struct2;
> @@ -761,6 +777,7 @@ static struct kunit_case list_test_cases[] = {
>         KUNIT_CASE(list_test_list_splice_init),
>         KUNIT_CASE(list_test_list_splice_tail_init),
>         KUNIT_CASE(list_test_list_entry),
> +       KUNIT_CASE(list_test_list_entry_is_head),
>         KUNIT_CASE(list_test_list_first_entry),
>         KUNIT_CASE(list_test_list_last_entry),
>         KUNIT_CASE(list_test_list_first_entry_or_null),
> --
> 2.35.0.263.gb82422642f-goog
>
