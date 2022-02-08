Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26004AE429
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 23:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387070AbiBHWZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 17:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386484AbiBHUkk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 15:40:40 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF90C0612C1
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 12:40:38 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p15so1114923ejc.7
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 12:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=riOd2RA+5KJDbVMnXqZUdH3r+GgY7kzXJ+ElAY7cveY=;
        b=NaHB/KvNkMyt15RxGmi1HV9jBeCWRKfN/Y/J3QJmYH0O25C91xheRRN24A3kEE+PMy
         M4gmyTMFy9O490kq/FPlyMXc/lV9CSUBNMigNhTvQRhFmWan3V1t0kkD3+evnzp4LScn
         KUz4GP3txGZQU0dUO9E/jW69V1HU4TGk/XzfohtEUQJAyA8z1GwZwgOjNHLK9UoAR83Y
         SAvFbE+ZK7slEi+2HOYKtic9lzwlQ6rGO1pvv57VFsiLJfT1Vk++23lFRw80lxvAgKYe
         5sogCgzFd1DofXr9bkcLHdNB3jw5BO8P7DczQatrpGBzgOzjtkhX8Vuz5HiCKJ8+8nc/
         aBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=riOd2RA+5KJDbVMnXqZUdH3r+GgY7kzXJ+ElAY7cveY=;
        b=wliJw9WxcbBpNuiEqyeHEhHLTHUksq0ZvzTSrznsmt0o1EBujY5b3fELzgblSdce+F
         gKPPcZQm6h7uu59xoK1v4NQlfu97HgOcW2H4/yi8kNAhEJgDmSjmt4jX8TI6zzzry7Uj
         hfSp0xddAmJoHapfGhoiPLVCnT+8EtSnknDCthDEoQLVuO8adtSpO1J6/2KAwqomYlCy
         39WyO+W0r/6tD7tlW23bo7i+zdhwL6JeFvCAy+aeFK5IsAucBNTZhevH9mgmfdiCC0Gt
         k9S1HUHMim0hnoGXzCobkvjxKx/QfiMT9p/0YToXaQMSOgnA0vcxBGbrnvRlqqV2CnQ8
         zzow==
X-Gm-Message-State: AOAM5303hSA6DVcdil0apES1iakksHxGgbqcMVHsvYUYkLQ2PVPr1URj
        B+cKyNL2uY2FstgtNB9Ud0KVbx7mOhwTAQBV3Ont/A==
X-Google-Smtp-Source: ABdhPJwDL8sKlWlLmV79N7zGT7H/XWpOJzLRcbYM4AcGKmTz0A/oCJ0vaPRAiaLpIvdkIfGDKfN1O19kAyG0CUw88IQ=
X-Received: by 2002:a17:907:6d20:: with SMTP id sa32mr5259987ejc.425.1644352836393;
 Tue, 08 Feb 2022 12:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20220208040122.695258-1-davidgow@google.com> <20220208040122.695258-2-davidgow@google.com>
In-Reply-To: <20220208040122.695258-2-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 8 Feb 2022 12:40:23 -0800
Message-ID: <CAGS_qxqwb=AVyjNQKvzSAGYmQei3ChQLD383=x+RkeCwe5zS-A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] list: test: Add a test for list_is_head()
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
> list_is_head() was added recently[1], and didn't have a KUnit test. The
> implementation is trivial, so it's not a particularly exciting test, but
> it'd be nice to get back to full coverage of the list functions.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/list.h?id=0425473037db40d9e322631f2d4dc6ef51f97e88
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Daniel Latypov <dlatypov@google.com>

One very optional suggestion below.

> ---
>
> Changes since v1:
> https://lore.kernel.org/linux-kselftest/20220205061539.273330-2-davidgow@google.com/
> - Test both non-head elements of the same list and head elements of
>   different lists.
>
> ---
>  lib/list-test.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/lib/list-test.c b/lib/list-test.c
> index 976e9ae1f3c5..1960615d1a9f 100644
> --- a/lib/list-test.c
> +++ b/lib/list-test.c
> @@ -252,6 +252,23 @@ static void list_test_list_bulk_move_tail(struct kunit *test)
>         KUNIT_EXPECT_EQ(test, i, 2);
>  }
>
> +static void list_test_list_is_head(struct kunit *test)
> +{
> +       struct list_head a, b, c;
> +
> +       /* Two lists: [a] -> b, [c] */
> +       INIT_LIST_HEAD(&a);
> +       INIT_LIST_HEAD(&c);
> +       list_add_tail(&b, &a);
> +
> +       KUNIT_EXPECT_TRUE(test, list_is_head(&a, &a));
> +       /* Non-head element of same list */
> +       KUNIT_EXPECT_FALSE(test, list_is_head(&a, &b));
> +       /* Head element of different list */
> +       KUNIT_EXPECT_FALSE(test, list_is_head(&a, &c));

very optional,
  KUNIT_EXPECT_FALSE_MSG(test, list_is_head(&a, &c), "Head of a
different list");
It goes over 80 char, so probably needs to be line-wrapped, and thus
doesn't reduce # of lines.

Given the simplicity of this function (checks that its args are
equal), I highly doubt it should ever fail, and so better error
messages aren't really much of a bonus.
