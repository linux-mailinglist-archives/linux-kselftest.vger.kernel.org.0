Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301CC589A82
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Aug 2022 12:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbiHDKgW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Aug 2022 06:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiHDKgT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Aug 2022 06:36:19 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6684240BFE
        for <linux-kselftest@vger.kernel.org>; Thu,  4 Aug 2022 03:36:18 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Lz4rt6SBMzMqDHS;
        Thu,  4 Aug 2022 12:36:14 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Lz4rt1sqPzlrKcW;
        Thu,  4 Aug 2022 12:36:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1659609374;
        bh=g2rymSQG1vHFCBe1enE68xLQbZN2nl3oT5hI4acwh2A=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=XNs9eaQkVQ2v0MMthjZKwzaY8OGZAXcnWW2hcNtoyEHYo8y7kCHLLaeP1G66Ib7UY
         iV1y8AnZq0D+jlSkSTOUlhfuh1KDMpFbeQbvu4cbl2GA3LH2Rg8ur7t0HLb42wed/v
         dsSdeNGDtYvKTavZtUjKB3nL9Tmnk+VoHj/T7FoQ=
Message-ID: <f1fc4e6e-e2a6-3ec7-2d3b-215111a4b9ae@digikod.net>
Date:   Thu, 4 Aug 2022 12:36:13 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Guillaume <guillaume.tucker@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, Tim.Bird@sony.com,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: Re: [PATCH] selftests/landlock: fix broken include of
 linux/landlock.h
In-Reply-To: <a459363217b1847c0f206a5dbdf181cb21cf3d0c.1659557290.git.guillaume.tucker@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 03/08/2022 22:13, Guillaume Tucker wrote:
> Revert part of the earlier changes to fix the kselftest build when
> using a sub-directory from the top of the tree as this broke the
> landlock test build as a side-effect when building with "make -C
> tools/testing/selftests/landlock".
> 
> Reported-by: Mickaël Salaün <mic@digikod.net>
> Fixes: a917dd94b832 ("selftests/landlock: drop deprecated headers dependency")
> Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> ---
>   tools/testing/selftests/landlock/Makefile | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
> index a6959df28eb0..02868ac3bc71 100644
> --- a/tools/testing/selftests/landlock/Makefile
> +++ b/tools/testing/selftests/landlock/Makefile
> @@ -9,10 +9,13 @@ TEST_GEN_PROGS := $(src_test:.c=)
>   TEST_GEN_PROGS_EXTENDED := true
>   
>   OVERRIDE_TARGETS := 1
> +top_srcdir := ../../../..

Not sure it changes much, but most other selftests Makefiles use 
"top_srcdir = ../../../.." (without ":="). Why this change?


>   include ../lib.mk
>   
> +khdr_dir = $(top_srcdir)/usr/include
> +
>   $(OUTPUT)/true: true.c
>   	$(LINK.c) $< $(LDLIBS) -o $@ -static
>   
> -$(OUTPUT)/%_test: %_test.c ../kselftest_harness.h common.h
> -	$(LINK.c) $< $(LDLIBS) -o $@ -lcap
> +$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
> +	$(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)
