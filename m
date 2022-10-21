Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48817607B9D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Oct 2022 17:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJUP5A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Oct 2022 11:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiJUP44 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Oct 2022 11:56:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE0727E2E6;
        Fri, 21 Oct 2022 08:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE2A661ED3;
        Fri, 21 Oct 2022 15:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30777C433C1;
        Fri, 21 Oct 2022 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666367806;
        bh=TFG+gvUdfVSbanzWOma5HXdIW4zrIQyBYY84L7UCYbE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MB8Yaemo6wmCjbJ2Vvp3EcjIpwZLsjJNs7V+DAMG1iKXJ5LszsjQ75FeOK5g3Yl5q
         gDl9VnTfSIXTu2kBPdApoqpQ8awcBYPmXYpWqVMVJMQaDqxw/LhsB3V6CETEVm3asz
         iKuFAxSSfYwrA8ViIPlvh10sxGiXXoQAPebZiKJHWGZq54vkICd3vfhObqbVXzw7D4
         mA4goRsnLJxoUJIPxMpFLkCHAuypwGkk7r/Mz/voZQHyDqpq6ZMnIxCEEZLaXiFKGG
         ji72iZsfPoxV97d2B1keLiv53qWGJ4TPVAVg28TTjfpVeQEji11FkxG/KQ6SigML+A
         IKte+fvA4w36A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D08925C0543; Fri, 21 Oct 2022 08:56:45 -0700 (PDT)
Date:   Fri, 21 Oct 2022 08:56:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add 7 tests for memcmp()
Message-ID: <20221021155645.GK5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221021060340.7515-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021060340.7515-1-w@1wt.eu>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 21, 2022 at 08:03:40AM +0200, Willy Tarreau wrote:
> This adds 7 combinations of input values for memcmp() using signed and
> unsigned bytes, which will trigger on the original code before Rasmus'
> fix. This is mostly aimed at helping backporters verify their work, and
> showing how tests for corner cases can be added to the selftests suite.
> 
> Before the fix it reports:
>   12 memcmp_20_20 = 0                      [OK]
>   13 memcmp_20_60 = -64                    [OK]
>   14 memcmp_60_20 = 64                     [OK]
>   15 memcmp_20_e0 = 64                    [FAIL]
>   16 memcmp_e0_20 = -64                   [FAIL]
>   17 memcmp_80_e0 = -96                    [OK]
>   18 memcmp_e0_80 = 96                     [OK]
> 
> And after:
>   12 memcmp_20_20 = 0                      [OK]
>   13 memcmp_20_60 = -64                    [OK]
>   14 memcmp_60_20 = 64                     [OK]
>   15 memcmp_20_e0 = -192                   [OK]
>   16 memcmp_e0_20 = 192                    [OK]
>   17 memcmp_80_e0 = -96                    [OK]
>   18 memcmp_e0_80 = 96                     [OK]
> 
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

I have pulled both of these in, thank you!

One thing, though...  I had to do "make clean" in both tools/include/nolibc
and tools/testing/selftests/nolibc to make those two "[FAIL]" indications
go away.  Does this mean that I am doing something wrong?

It would be good to know before I send the pull request containing these,
so that we can let Linus know of anything special he needs to do to
ensure a valid test result.

							Thanx, Paul

> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 78bced95ac63..f14f5076fb6d 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -565,6 +565,13 @@ int run_stdlib(int min, int max)
>  		CASE_TEST(strchr_foobar_z);    EXPECT_STRZR(1, strchr("foobar", 'z')); break;
>  		CASE_TEST(strrchr_foobar_o);   EXPECT_STREQ(1, strrchr("foobar", 'o'), "obar"); break;
>  		CASE_TEST(strrchr_foobar_z);   EXPECT_STRZR(1, strrchr("foobar", 'z')); break;
> +		CASE_TEST(memcmp_20_20);       EXPECT_EQ(1, memcmp("aaa\x20", "aaa\x20", 4), 0); break;
> +		CASE_TEST(memcmp_20_60);       EXPECT_LT(1, memcmp("aaa\x20", "aaa\x60", 4), 0); break;
> +		CASE_TEST(memcmp_60_20);       EXPECT_GT(1, memcmp("aaa\x60", "aaa\x20", 4), 0); break;
> +		CASE_TEST(memcmp_20_e0);       EXPECT_LT(1, memcmp("aaa\x20", "aaa\xe0", 4), 0); break;
> +		CASE_TEST(memcmp_e0_20);       EXPECT_GT(1, memcmp("aaa\xe0", "aaa\x20", 4), 0); break;
> +		CASE_TEST(memcmp_80_e0);       EXPECT_LT(1, memcmp("aaa\x80", "aaa\xe0", 4), 0); break;
> +		CASE_TEST(memcmp_e0_80);       EXPECT_GT(1, memcmp("aaa\xe0", "aaa\x80", 4), 0); break;
>  		case __LINE__:
>  			return ret; /* must be last */
>  		/* note: do not set any defaults so as to permit holes above */
> -- 
> 2.17.5
> 
