Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61B3626B0B
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Nov 2022 19:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiKLSa6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Nov 2022 13:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234695AbiKLSa5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Nov 2022 13:30:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640CEBC0B;
        Sat, 12 Nov 2022 10:30:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD7BCB80B07;
        Sat, 12 Nov 2022 18:30:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9ACC433C1;
        Sat, 12 Nov 2022 18:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668277853;
        bh=/O+GXvyUlwkoQhcBoaV09K+QsmakJb5S/2ONHq+t7Jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Br4izro987cQjAoGQRGCTgisgnFw1EXBhvx2+wdFNeoeHslvo9J0M0AdPzpui4d1A
         VhfPjnDUSkHw7ZLYnBiWq7uiJZzdQxbnM1Y5D4yzZ4oMeeCk4/BNYlJpv1svFLmiMJ
         UVmXJAauxTs5OIL+2XAa452iqXJTu5cOwmxY4o43dgdXqye5uurs5+gsStCTu/VO9m
         Hrcr8p45NWRdqLDUCBAqBWxhRfRrZBalmczMbpsOT3i8rvP59cwxJQYWrfFt6JeZUJ
         5f15KooDvRp6abDdhvbK9ufl+QtsGFimRK/8/iVgPsEQ5Xq5NS+N6MbwyT+3hG8cpl
         LBud28qkOQ8rg==
From:   SeongJae Park <sj@kernel.org>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     sj@kernel.org, damon@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        rongtao@cestc.cn, shuah@kernel.org, yuanchu@google.com
Subject: Re: Re: [PATCH] selftests/damon: Fix unnecessary compilation warnings
Date:   Sat, 12 Nov 2022 18:30:50 +0000
Message-Id: <20221112183050.85200-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_5695C257F3D13F4417034BA1FBAC95CB3B07@qq.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Rong,

On Sat, 12 Nov 2022 13:01:04 +0800 Rong Tao <rtoax@foxmail.com> wrote:

> Hi, Park, I just search on GCC source code, found GCC support
> "-Wstringop-overread" at least gcc-11.1.0, commit d14c547abd48("Add
> -Wstringop-overread for reading past the end by string functions.").
> 
> AND found a testsuite gcc/gcc/testsuite/gcc.dg/pragma-diag-10.c
> 
>  10 #pragma GCC diagnostic push
>  11 #pragma GCC diagnostic ignored "-Wstringop-overflow"
>  12 #pragma GCC diagnostic ignored "-Wstringop-overread"
>  13   if (c != 0)
>  14     return __builtin_memchr (s, c, (unsigned long)-1);
>  15 #pragma GCC diagnostic pop
> 
> it's totally same as this PATCH.
> 
> I think the motivation for this patch is to eliminate the compilation
> warning, maybe one day we will compile the kernel with "-Werror -Wall",
> at which point this compilation warning will turn into a compilation
> error, and in case we already know it, we should fix this error in
> advance.
> 
> For old gcc, we can add this?
> 
>  #pragma GCC diagnostic push
> +#if __GNUC__ >= 11 && __GNUC_MINOR__ >= 1
>  /* Ignore read(2) overflow and write(2) overread compile warnings */
>  #pragma GCC diagnostic ignored "-Wstringop-overread"
>  #pragma GCC diagnostic ignored "-Wstringop-overflow"
> +#endif
> 
> What do you think?

I think it looks great!  Looking forward to your v3 patch!


Thanks,
SJ

> 
> Good day!
> Rong Tao
