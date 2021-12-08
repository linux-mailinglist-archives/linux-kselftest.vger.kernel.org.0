Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA09246CDC2
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 07:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbhLHGdR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 01:33:17 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:55684 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239648AbhLHGdP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 01:33:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UzquZvA_1638944981;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UzquZvA_1638944981)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Dec 2021 14:29:42 +0800
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH 02/11] mm/damon/dbgfs: Remove an unnecessary error message
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc:     shuah@kernel.org, brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211201150440.1088-1-sj@kernel.org>
 <20211201150440.1088-3-sj@kernel.org>
From:   Xin Hao <xhao@linux.alibaba.com>
Message-ID: <71535f68-4086-45df-2d4b-36a1802c9475@linux.alibaba.com>
Date:   Wed, 8 Dec 2021 14:29:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211201150440.1088-3-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Hi park:

On 12/1/21 11:04 PM, SeongJae Park wrote:
> When wrong scheme action is requested via the debugfs interface, DAMON
> prints an error message.  Because the function returns error code, this
> is not really needed.  Because the code path is triggered by the user
> specified input, this can result in kernel log mistakenly being messy.

Completely correct, but there will also be a problem that users can’t 
quickly locate where the problem is,

Especially too many parameters need to be written into the interface.

I think it is necessary to add some debugging methods to help users find 
the error without polluting the kernel log.

And i have an idea, like this:

in dbgfs, add a last_cmd_stat interface.

     # echo "1 2 1 2 1 2  1 2 1 2 100 ..."  > schemes

     #  cat last_cmd_stat

     #  wrong action 100

In this way, on the one hand, it will not pollute the kernel log, on the 
other hand, it will help users find  the cause of the operation 
interface error.

Park, how do you think of about this idea, if ok, i will send a patch.

> To avoid the case, this commit removes the message
>
> Fixes: af122dd8f3c0 ("mm/damon/dbgfs: support DAMON-based Operation Schemes")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/damon/dbgfs.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index 4bf4204444ab..5b628990ae6e 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -210,10 +210,8 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
>   				&wmarks.low, &parsed);
>   		if (ret != 18)
>   			break;
> -		if (!damos_action_valid(action)) {
> -			pr_err("wrong action %d\n", action);
> +		if (!damos_action_valid(action))
>   			goto fail;
> -		}
>   
>   		if (min_sz > max_sz || min_nr_a > max_nr_a || min_age > max_age)
>   			goto fail;

-- 
Best Regards!
Xin Hao

