Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5BB5FF85F
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Oct 2022 06:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJOEE4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Oct 2022 00:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJOEEy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Oct 2022 00:04:54 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18B325C9
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Oct 2022 21:04:45 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a8so2593259uaj.11
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Oct 2022 21:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gaRuIOy5mipxC/DcG4OUxK58zUai1nT9d4WWV0cqyO8=;
        b=IszlE+nsJk2T1FzF4PpZXEdi2LN8qHNRhvPsuS12/3ruJQ23aBGF/V8KITeyrHkY9X
         Tzkie3tfTYo7X1JXlsKbzRpRsXTnfgha+GpWtbkIt1Ps9Lj0634OCqEBAwO+l15G732A
         e2Zi0S6hVyUbSZP/5P68DfpgFs+pYBjjvaQmB1yG2gwU0iBE/pbNFD481RAnRmBjNseA
         /lpY2DERASTvoFUrVEdSnAmOZHz3eEeIzgSNrE3RhD56vUzvJuflRO9hm1wNnu34jG16
         IP74UVFKUar3t/Z9w7l1K3+dd1zZCgMVCvclxFkZe0KC5hlR6qU/mwhLR7cEtvJ3F9Pl
         tcxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaRuIOy5mipxC/DcG4OUxK58zUai1nT9d4WWV0cqyO8=;
        b=b4XSpywkwVrtR+Jl/P9IXJCUT+Lhh5x6jDr+O/8T5yLUptooThJfeTDjhU6BGtL7WP
         AAgswyzU51SXZyQD2tEiH2O1/H1MKSplNQvg0inuk542HdQA8drhge/b8KMgVVX/paeL
         pA7z5vQrKNn+3TMzYU76itfsat8Q5RsU6TK03AczoRcLgJNsmKZVrvzEqfy9sHnTQjt7
         iyVppE0nmt5aJyHcsGbqC/Sd8y+GPqrJv68Qm5tchboI1/0fOPHuXOe15+91AHIsmthK
         bHULMQ0WFKhABLM9G7FRXo0q9whbGG1DSVcm9wyRZh+yEg8ggdFC7YoDM41VT4ztm5XR
         /YjQ==
X-Gm-Message-State: ACrzQf3wU0eacDOnvJjjIGM9b5Af4CU/yMgNeLF7ZqZOyLysn6US3qNO
        0B2/nbWmamgJdTUHpZJDo0005AqtfZ42hY6JRbu3UA==
X-Google-Smtp-Source: AMsMyM7hRmdyeIhbI6VaevYf0uTIoRSecIosJKChDWbOj0yxPl7Gy6TyTDB/xFC68FLvzTCiqzfQ5/kJUV3egu1oUBs=
X-Received: by 2002:ab0:628a:0:b0:3e3:651f:a07d with SMTP id
 z10-20020ab0628a000000b003e3651fa07dmr330706uao.52.1665806684727; Fri, 14 Oct
 2022 21:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221005175149.611068-1-mark.rutland@arm.com>
In-Reply-To: <20221005175149.611068-1-mark.rutland@arm.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 15 Oct 2022 12:04:33 +0800
Message-ID: <CABVgOSmgkxb6U1S1Ww3dZ6M3i6asmXF-4MtEzn7O+GiA0SLPaA@mail.gmail.com>
Subject: Re: [PATCH] kunit: log numbers in decimal and hex
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, brendan.higgins@linux.dev,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 6, 2022 at 1:52 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> When KUNIT_EXPECT_EQ() or KUNIT_ASSERT_EQ() log a failure, they log the
> two values being compared, with numerical values logged in decimal.
>
> In some cases, decimal output is painful to consume, and hexadecimal
> output would be more helpful. For example, this is the case for tests
> I'm currently developing for the arm64 insn encoding/decoding code,
> where comparing two 32-bit instruction opcodes results in output such
> as:
>
> |  # test_insn_add_shifted_reg: EXPECTATION FAILED at arch/arm64/lib/test_insn.c:2791
> |  Expected obj_insn == gen_insn, but
> |      obj_insn == 2332164128
> |      gen_insn == 1258422304
>
> To make this easier to consume, this patch logs the values in both
> decimal and hexadecimal:
>
> |  # test_insn_add_shifted_reg: EXPECTATION FAILED at arch/arm64/lib/test_insn.c:2791
> |  Expected obj_insn == gen_insn, but
> |      obj_insn == 2332164128 (0x8b020020)
> |      gen_insn == 1258422304 (0x4b020020)
>
> As can be seen from the example, having hexadecimal makes it
> significantly easier for a human to spot which specific bits are
> incorrect.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Brendan Higgins <brendan.higgins@linux.dev>
> Cc: David Gow <davidgow@google.com>
> Cc: linux-kselftest@vger.kernel.org
> Cc: kunit-dev@googlegroups.com
> ---

Thanks very much: this will definitely be useful. I tend to agree with
Daniel that this could clutter things up a bit, but I think the other
options (a separate ASSERT_EQ_HEX() macro, or a heuristic to remove it
for, e.g., values <= 9) add more complexity than benefit there.

So let's go with this as-is.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  lib/kunit/assert.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> index d00d6d181ee8..24dec5b48722 100644
> --- a/lib/kunit/assert.c
> +++ b/lib/kunit/assert.c
> @@ -127,13 +127,15 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
>                           binary_assert->text->right_text);
>         if (!is_literal(stream->test, binary_assert->text->left_text,
>                         binary_assert->left_value, stream->gfp))
> -               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld\n",
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)\n",
>                                   binary_assert->text->left_text,
> +                                 binary_assert->left_value,
>                                   binary_assert->left_value);
>         if (!is_literal(stream->test, binary_assert->text->right_text,
>                         binary_assert->right_value, stream->gfp))
> -               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld",
> +               string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s == %lld (0x%llx)",
>                                   binary_assert->text->right_text,
> +                                 binary_assert->right_value,
>                                   binary_assert->right_value);
>         kunit_assert_print_msg(message, stream);
>  }
> --
> 2.30.2
>
