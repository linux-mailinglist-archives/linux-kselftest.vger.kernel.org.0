Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F106E1733
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 00:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjDMWLb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 18:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMWLb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 18:11:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505A15B94;
        Thu, 13 Apr 2023 15:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7234641EB;
        Thu, 13 Apr 2023 22:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38B2C433D2;
        Thu, 13 Apr 2023 22:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681423888;
        bh=aOsONFIvhz77p16K57ScSUccywmvY1pixUTbUaWEPx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WDbW8vTruLrE6RmQPKU9MKU5ntrWqVKEXcZK6A0uugt1GdAhuy+oSwItihR0+47z9
         RiutRPsvzOLh7JxRjSgxWV6ad9pD9COezJdC+hjr7Eqi5wXoh0L529xMGFbRUBzasN
         m6bVCctBwGFlFd9EQ2hwj+UzjX0+xMJTlILvefgo=
Date:   Thu, 13 Apr 2023 15:11:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     <shuah@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/mm: Replace obsolete memalign() with
 posix_memalign()
Message-Id: <20230413151128.abd305c1689eeac237e4e4e7@linux-foundation.org>
In-Reply-To: <20230413012751.4445-1-wangdeming@inspur.com>
References: <20230413012751.4445-1-wangdeming@inspur.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 12 Apr 2023 21:27:51 -0400 Deming Wang <wangdeming@inspur.com> wrote:

> memalign() is obsolete according to its manpage.
> 
> Replace memalign() with posix_memalign().
> 
> As a pointer is passed into posix_memalign(),initialize *map to
> NULL,to silence a warning about the function's return value being
> used as uninitialized (which is not valid anyway because the
> error is properly checked before map is returned).
> 

The patch you sent doesn't do this?

> --- a/tools/testing/selftests/mm/soft-dirty.c
> +++ b/tools/testing/selftests/mm/soft-dirty.c
> @@ -80,9 +80,9 @@ static void test_hugepage(int pagemap_fd, int pagesize)
>  	int i, ret;
>  	size_t hpage_len = read_pmd_pagesize();
>  
> -	map = memalign(hpage_len, hpage_len);
> -	if (!map)
> -		ksft_exit_fail_msg("memalign failed\n");
> +	ret = posix_memalign((void **)(&map), hpage_len, hpage_len);
> +	if (ret < 0)
> +		ksft_exit_fail_msg("posix_memalign failed\n");
>  
>  	ret = madvise(map, hpage_len, MADV_HUGEPAGE);
>  	if (ret)

