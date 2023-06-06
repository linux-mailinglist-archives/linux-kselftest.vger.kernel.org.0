Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555FB723AEA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 10:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjFFIEc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 04:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjFFIER (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 04:04:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB22B1
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 01:04:12 -0700 (PDT)
Received: from [192.168.10.48] (unknown [119.152.150.198])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E39C46606E98;
        Tue,  6 Jun 2023 09:04:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686038650;
        bh=5i7oE0lZsDAiYFieNzZpjejAjmfRrNytx05MgsC5BsY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=N8H8724N29TdFvFyx91UzPiy4iAH+Czsv3iM9XiddGIUkwkHJ/eCWDdmleBjPqV3b
         FkmT9JXIq4fKZ+O0PWfZv2gm2GGCDIVrysKw9lqJzwcCh3aWYqpmdW9DYsECqLwBxz
         ZxtHrVw02mSozuTlDXT2pAxTLjfn7hHlHhwzzGt6/FcuqXtvsUkzb2/3qUfvLjUPRW
         7buP/rd/TETa426TCMS7DaqgAooTVcGJHczo4FfocFsPeB3jNpveH33DFjSVv5z0CT
         aTGjE4Ee2tYcBH5jewQTumYpZ966M2BpUtvOaaA9heKyA9TKr3s/2jsmiugKLYwHLg
         6FKZ/l8Rwm3+g==
Message-ID: <9ef625e1-eb00-535f-8cec-5291e71ef913@collabora.com>
Date:   Tue, 6 Jun 2023 13:04:05 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kselftest@vger.kernel.org, kernel@collabora.com,
        naresh.kamboju@linaro.org, dan.carpenter@linaro.org
Subject: Re: [PATCH] selftests/mincore: fix skip condition for
 check_huge_pages test
Content-Language: en-US
To:     =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>,
        shuah@kernel.org
References: <20230515132643.119809-1-ricardo.canuelo@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230515132643.119809-1-ricardo.canuelo@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/15/23 6:26 PM, Ricardo Cañuelo wrote:
> The check_huge_pages test was failing instead of skipping on qemu-armv7
> because the skip condition wasn't handled properly. Add an additional
> check to fix it.
> 
> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/all/CA+G9fYuoB8Ug8PcTU-YGmemL7_eeEksXFihvxWF6OikD7sK7pA@mail.gmail.com
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mincore/mincore_selftest.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
> index 4c88238fc8f0..6fb3eea5b6ee 100644
> --- a/tools/testing/selftests/mincore/mincore_selftest.c
> +++ b/tools/testing/selftests/mincore/mincore_selftest.c
> @@ -150,8 +149,8 @@ TEST(check_huge_pages)
>  		MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB,
>  		-1, 0);
>  	if (addr == MAP_FAILED) {
> -		if (errno == ENOMEM)
> -			SKIP(return, "No huge pages available.");
> +		if (errno == ENOMEM || errno == EINVAL)
> +			SKIP(return, "No huge pages available or CONFIG_HUGETLB_PAGE disabled.");
>  		else
>  			TH_LOG("mmap error: %s", strerror(errno));
>  	}

-- 
BR,
Muhammad Usama Anjum
