Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE565B61DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Sep 2022 21:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiILTsY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Sep 2022 15:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiILTsX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Sep 2022 15:48:23 -0400
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fae])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D01648C9C
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Sep 2022 12:48:20 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MRHFt3FvmzMsc6b;
        Mon, 12 Sep 2022 21:48:18 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MRHFs5MtKzx2;
        Mon, 12 Sep 2022 21:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1663012098;
        bh=IwU3+VamkRAy7BQ3AohS/iTXiC76aZ0wOsi6jhNo5sI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WjytErI/AM0bBqF8z2+jmgh5xX8hmi/gDyUS4wCuuMXSo2Mao8QEJNAoWxdldKAI3
         STgWeJsbzQ7A29AGHzLApBHmXAeLJeznGW12iV8QKgN9woPENcfRbYIRUtN/3Y1IgM
         G1/wkzzGlKpOMPzDUJPXkq9b/Q/8aZc0hbW0hFes=
Message-ID: <5e288153-ca6b-a91d-a3fd-cd2b1e102b3e@digikod.net>
Date:   Mon, 12 Sep 2022 21:48:17 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v1] selftests/landlock: Fix out-of-tree builds
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20220909103402.1501802-1-mic@digikod.net>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220909103402.1501802-1-mic@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Shuah, could you please merge this patch (and the USERCFLAGS/USERLDFLAGS 
one if that's OK) to -next? This is fixing an issue in the current 6.0-rc5 .

Anders, can you please check that this fixes your issue? 
https://lore.kernel.org/r/CADYN=9JM1nnjC9LypHqrz7JJjbZLpm8rArDUy4zgYYrajErBnA@mail.gmail.com


On 09/09/2022 12:34, Mickaël Salaün wrote:
> These changes simplify the Makefile and handle these 5 ways to build
> Landlock tests:
> - make -C tools/testing/selftests/landlock
> - make -C tools/testing/selftests TARGETS=landlock gen_tar
> - make TARGETS=landlock kselftest-gen_tar
> - make TARGETS=landlock O=build kselftest-gen_tar
> - make -C /tmp/linux TARGETS=landlock O=/tmp/build kselftest-gen_tar
> 
> This also makes $(KHDR_INCLUDES) available to other test collections
> when building in their directory.
> 
> Fixes: f1227dc7d041 ("selftests/landlock: fix broken include of linux/landlock.h")
> Fixes: 3bb267a36185 ("selftests: drop khdr make target")
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Cc: Guillaume Tucker <guillaume.tucker@collabora.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20220909103402.1501802-1-mic@digikod.net
> ---
>   tools/testing/selftests/landlock/Makefile | 19 ++++++++++---------
>   tools/testing/selftests/lib.mk            |  4 ++++
>   2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
> index 02868ac3bc71..6632bfff486b 100644
> --- a/tools/testing/selftests/landlock/Makefile
> +++ b/tools/testing/selftests/landlock/Makefile
> @@ -1,6 +1,11 @@
>   # SPDX-License-Identifier: GPL-2.0
> +#
> +# First run: make -C ../../../.. headers_install
>   
>   CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
> +LDLIBS += -lcap
> +
> +LOCAL_HDRS += common.h
>   
>   src_test := $(wildcard *_test.c)
>   
> @@ -8,14 +13,10 @@ TEST_GEN_PROGS := $(src_test:.c=)
>   
>   TEST_GEN_PROGS_EXTENDED := true
>   
> -OVERRIDE_TARGETS := 1
> -top_srcdir := ../../../..
> -include ../lib.mk
> -
> -khdr_dir = $(top_srcdir)/usr/include
> +# Static linking for short targets:
> +$(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
>   
> -$(OUTPUT)/true: true.c
> -	$(LINK.c) $< $(LDLIBS) -o $@ -static
> +include ../lib.mk
>   
> -$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
> -	$(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)
> +# Static linking for targets with $(OUTPUT)/ prefix:
> +$(TEST_GEN_PROGS_EXTENDED): LDFLAGS += -static
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index d44c72b3abe3..9d4cb94cf437 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -42,6 +42,10 @@ endif
>   selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
>   top_srcdir = $(selfdir)/../../..
>   
> +ifeq ($(KHDR_INCLUDES),)
> +KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
> +endif
> +
>   # The following are built by lib.mk common compile rules.
>   # TEST_CUSTOM_PROGS should be used by tests that require
>   # custom build rule and prevent common build rule use.
> 
> base-commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
