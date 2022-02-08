Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0451B4AE418
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 23:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386571AbiBHWZt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 17:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386431AbiBHUcQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 15:32:16 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C9FC0612C0
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 12:32:14 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id st12so1144575ejc.4
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 12:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtsDfpCrFsnfisbUPJhBruwT+fgEbgdfMntNnmidtvM=;
        b=OgouE37mlONXTn5boL+/fmyvPcIbs4YGlNMohOcrJSJvZTWscTei0nRrlBlR9sRaU1
         o+ETGcoKZIRIy5tNRm874mJI2WJBAR2VFhJPclA+G6fbtYgbWRqrR3OGD+Q4ToeWJXlb
         KZUxeKagOPnpDSBAGcXHUoTBPzK1WOY/8J+NnrsmH7YuGcdOpFu5ENh4JZjnwy0kSIWH
         iwQPyodsMlEy2e28ISFyrdzj7cfYB3S6JCUyFI1cOT2wCY81pkDnrE9iEB0J7zs1myN8
         hhLglJfFPBiDBT9ua1Jfm5H7ODAZWluunQCTH4LFMLQhL00YmWRaEtU7nYkPJd6sC4AU
         jheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtsDfpCrFsnfisbUPJhBruwT+fgEbgdfMntNnmidtvM=;
        b=qct7SnfErAAavGEVIS4VuaTPG95b+LqxqZVfaN8dHD8u8HXVL7VYtMb2pI0a8L0gIv
         78H1RkI/3AJbaEfZItEIg662dbqf7HHxZFDGAUk/745FXglu9H100fwR5V6VAmPMHHKP
         sMwBq3rqg4s5mHs35WIz+64Sw/4UATIkqeQzjaW1vCO0lv5XLcnuBPqoEMjHWPWTq9SM
         dKJO5sZc/3Wn2oudYyZBrU6iEJE/1689y/q56FWOSW9T6AAeRzP4J2QsaPQNGwzU8aA0
         GtN17fAlQ/eTOfA41YbSZkMIj5Bz8eLp1dKIjU+R3Iz7+8xWs14X83ryYW4nLKb1GDuF
         Prfw==
X-Gm-Message-State: AOAM531wcHPjNn7PXqsTgcOWpbcyZG1cdH7EXhiWTqXjMHq+A6Dih2M6
        VkFW4G4sfPSGW8YFkfV+hNgVSk4IX+ea4frl53T1vQ==
X-Google-Smtp-Source: ABdhPJyKX2QCjePrd78NKzT7Vs0ZKfpBWbGmmdWVdIe7lQvwiKYAbFCZ2zFkA5UPbCuFPWzwLZ8OwhUUUp+1Jgv18ZE=
X-Received: by 2002:a17:906:4fca:: with SMTP id i10mr4866638ejw.542.1644352332735;
 Tue, 08 Feb 2022 12:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20220208040122.695258-1-davidgow@google.com>
In-Reply-To: <20220208040122.695258-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 8 Feb 2022 12:32:01 -0800
Message-ID: <CAGS_qxrrgq0v3pXGv+33KkH2NZMhx-Yt_0XEq8P2NAag4DkgLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] list: test: Add test for list_del_init_careful()
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 7, 2022 at 8:01 PM David Gow <davidgow@google.com> wrote:
>
> The list_del_init_careful() function was added[1] after the list KUnit
> test. Add a very basic test to cover it.
>
> Note that this test only covers the single-threaded behaviour (which
> matches list_del_init()), as is already the case with the test for
> list_empty_careful().
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c6fe44d96fc1536af5b11cd859686453d1b7bfd1
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20220205061539.273330-1-davidgow@google.com/
> - Patch 1/3 unchanged
>
> ---
>  lib/list-test.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/lib/list-test.c b/lib/list-test.c
> index ee09505df16f..976e9ae1f3c5 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -161,6 +161,24 @@ static void list_test_list_del_init(struct kunit *test)
>         KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
>  }
>
> +static void list_test_list_del_init_careful(struct kunit *test)
> +{
> +       /* This test doesn't check correctness under concurrent access */

nit: I personally didn't read this comment in the intended way at first.
I'd personally find something like

NOTE: this doesn't test for concurrency/memory
ordering/however-you-want-to-word-it issues

a bit more readable.

> +       struct list_head a, b;
> +       LIST_HEAD(list);
> +
> +       list_add_tail(&a, &list);
> +       list_add_tail(&b, &list);
> +
> +       /* before: [list] -> a -> b */
> +       list_del_init(&a);

Is this supposed to use list_del_init_careful(&a)?
That would make it match the name of the test case.

> +       /* after: [list] -> b, a initialised */
> +
> +       KUNIT_EXPECT_PTR_EQ(test, list.next, &b);
> +       KUNIT_EXPECT_PTR_EQ(test, b.prev, &list);
> +       KUNIT_EXPECT_TRUE(test, list_empty_careful(&a));
> +}
> +
>  static void list_test_list_move(struct kunit *test)
>  {
>         struct list_head a, b;
> @@ -707,6 +725,7 @@ static struct kunit_case list_test_cases[] = {
>         KUNIT_CASE(list_test_list_replace_init),
>         KUNIT_CASE(list_test_list_swap),
>         KUNIT_CASE(list_test_list_del_init),
> +       KUNIT_CASE(list_test_list_del_init_careful),
>         KUNIT_CASE(list_test_list_move),
>         KUNIT_CASE(list_test_list_move_tail),
>         KUNIT_CASE(list_test_list_bulk_move_tail),
> --
> 2.35.0.263.gb82422642f-goog
>
