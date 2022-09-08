Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE5E5B1FA8
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 15:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiIHNxG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 09:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiIHNxE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 09:53:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C2EBFC57;
        Thu,  8 Sep 2022 06:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=b3NFkfppRZobo8xoKriBYse3KmRxLd7jAty1YkyS81c=; b=i4IM6V+NtVfo3v3I0a4ptJkjZx
        p/hCMXcKziCml5l/XMWq9v6YoKp/oIXwIpnPcx/qa9LlgwGdqawIgNBV8mClMWgrofoZS98P7McAR
        CwiN4snfvLE2T8vmeKn8pXyuBE0AjtUbLndfpWQsuLI/gXYu2xv5W7r6Ltq/1xub1QZncbVyG8nCP
        AWvVbA5ik+jJPx4zxsdGtFoEqDYf/mw8OOD7sogTk06L+QSDltB8x4IpQj6jfnyy5ajhQOyH5QfvJ
        YqB6u/el6uWKHNwzmhtBhW2bWIXyRP+LaHJcAugfP25CylcXJV6Yv7quRa6ZI+9reX1CYUy/Z9nwQ
        S8Ki58mg==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oWHxi-0049vh-33; Thu, 08 Sep 2022 13:52:58 +0000
Message-ID: <5fd375c6-1bad-b937-634b-7efc4391c0e3@infradead.org>
Date:   Thu, 8 Sep 2022 06:52:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] selftests/cgroup: fix repeated words in comments
Content-Language: en-US
To:     wangjianli <wangjianli@cdjrlc.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, shuah@kernel.org
Cc:     cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220908121107.4814-1-wangjianli@cdjrlc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220908121107.4814-1-wangjianli@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 9/8/22 05:11, wangjianli wrote:
> Delete the redundant word 'in'.
> 
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  tools/testing/selftests/cgroup/test_freezer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
> index ff519029f6f4..b479434e87b7 100644
> --- a/tools/testing/selftests/cgroup/test_freezer.c
> +++ b/tools/testing/selftests/cgroup/test_freezer.c
> @@ -740,7 +740,7 @@ static int test_cgfreezer_ptraced(const char *root)
>  
>  	/*
>  	 * cg_check_frozen(cgroup, true) will fail here,
> -	 * because the task in in the TRACEd state.

	                    is in

> +	 * because the task in the TRACEd state.
>  	 */
>  	if (cg_freeze_wait(cgroup, false))
>  		goto cleanup;

-- 
~Randy
