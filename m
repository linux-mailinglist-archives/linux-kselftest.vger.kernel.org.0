Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC24ACD0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 02:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343532AbiBHBGQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 20:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbiBHASS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 19:18:18 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145B9C061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 16:18:18 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id s21so18814548ejx.12
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 16:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIx1vqQAPUu8LMm53/zUpJw9Sxu1UeMfE4UVerJwTWM=;
        b=HsUaZkqHlbY0DP5/dB+NOk+XHLKcXhDIyHMBohmCekOEo6Mxyaz1Ka26ef7+UKfs+k
         bUSlvpRm7TI91q+LYmkBCf4MqATj5MwZ+LM8tR4ZTDxX/x8M8VxsQfydSrug3bGb+SW6
         qeOa7XHUvHglzw4cWLerqCeRRwh+FwmU8YgP0lm0ZUB3BEGByKGqlJgEmqDGlx+qOgRM
         J5bxn8nsy+rs0Sv+4Q8E4vuEPvXls5QfkOAWphZ+aud5Yic3SvR1GGM83iL4o26R93du
         7AFnc0EnQpgBgBNXhU8RzG5FjOAX360BxirnhSe7W2faNUBoPcRQjXebhp4qMPUsPn79
         Mkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIx1vqQAPUu8LMm53/zUpJw9Sxu1UeMfE4UVerJwTWM=;
        b=doIhpQooSASAH6u9K5d+xFHF+LUFA2OrFP8sMFCUs6E2N2ZVf/g+hDTTzzCHmjcQUs
         qOdMWXvDE/iv0oZ5eh9aT+lFvfn5bbPYb8b7CO1mQUYbNcvJIVD0oZjMe4Rfu+d5Uxnu
         2IKP3FYo9Y2KErLsng4G6qggXmZuTIU5ho//ySm99H+wpJYcLFqj+rpijGEuZ+HBClsd
         IECyMboYq/ZT83I31sJAqfX1vd0pznbdbSISRobNkqaad9g2cGkhvO+fvw8KDcI+nLzq
         TnKes3EtOj+DeeZQDP/dLyzRrHznBRVwYi/DWk00o+l93s7gUJYfHc1P3YV2+pU30jXS
         iH1Q==
X-Gm-Message-State: AOAM531yeaTY3WrtC4G8kSMcoGk0HVW91wm72IrFKnaUmEl0Q7IT2aT2
        3kNZIiWIfzQcwyTY1KBCwXg46z2CGlFpHpHJ6Ugh/A==
X-Google-Smtp-Source: ABdhPJw3RJc1UuNBtJgY/8WVZgtoAXhmWS9Jt1B5egJZFIhAn9akJOuzK3xWA2sHJktX7U4mTMt72DVYaotARbKvlx0=
X-Received: by 2002:a17:907:6e28:: with SMTP id sd40mr1599073ejc.170.1644279496489;
 Mon, 07 Feb 2022 16:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20220207211144.1948690-1-ribalda@chromium.org> <20220207211144.1948690-6-ribalda@chromium.org>
In-Reply-To: <20220207211144.1948690-6-ribalda@chromium.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 7 Feb 2022 16:18:05 -0800
Message-ID: <CAGS_qxrK7TBLkoi9ztSJXcoQ+_Z0YC_HWmrp++2C1mc9ierOEg@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] apparmor: test: Use NULL macros
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
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

On Mon, Feb 7, 2022 at 1:11 PM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Replace the PTR_EQ NULL checks with the more idiomatic and specific NULL
> macros.
>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Acked-by: Daniel Latypov <dlatypov@google.com>

> ---
>  security/apparmor/policy_unpack_test.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
> index 533137f45361..5c18d2f19862 100644
> --- a/security/apparmor/policy_unpack_test.c
> +++ b/security/apparmor/policy_unpack_test.c
> @@ -313,7 +313,7 @@ static void policy_unpack_test_unpack_strdup_out_of_bounds(struct kunit *test)
>         size = unpack_strdup(puf->e, &string, TEST_STRING_NAME);
>
>         KUNIT_EXPECT_EQ(test, size, 0);
> -       KUNIT_EXPECT_PTR_EQ(test, string, (char *)NULL);
> +       KUNIT_EXPECT_NULL(test, string);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
>  }
>
> @@ -409,7 +409,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
>         size = unpack_u16_chunk(puf->e, &chunk);
>
>         KUNIT_EXPECT_EQ(test, size, (size_t)0);
> -       KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
> +       KUNIT_EXPECT_NULL(test, chunk);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
>  }
>
> @@ -431,7 +431,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_2(
>         size = unpack_u16_chunk(puf->e, &chunk);
>
>         KUNIT_EXPECT_EQ(test, size, (size_t)0);
> -       KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
> +       KUNIT_EXPECT_NULL(test, chunk);
>         KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
>  }
>
> --
> 2.35.0.263.gb82422642f-goog
>
