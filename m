Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CEC2B7B97
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 11:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgKRKqC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 05:46:02 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7699 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgKRKqB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 05:46:01 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Cbfbm5mLxzkY67;
        Wed, 18 Nov 2020 18:45:40 +0800 (CST)
Received: from [10.174.179.81] (10.174.179.81) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 18 Nov 2020 18:45:58 +0800
Subject: Re: [PATCH] android/ion: fix error return code in opensocket()
From:   "wanghai (M)" <wanghai38@huawei.com>
To:     <shuah@kernel.org>, <pintu.ping@gmail.com>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201118103918.58477-1-wanghai38@huawei.com>
Message-ID: <b952e528-bf77-350f-c51a-a4e3fb22b198@huawei.com>
Date:   Wed, 18 Nov 2020 18:45:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201118103918.58477-1-wanghai38@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.81]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a syntax problem with this patch, please ignore it!

ÔÚ 2020/11/18 18:39, Wang Hai Ð´µÀ:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
>
> Fixes: 47a18c42d992 ("android/ion: userspace test utility for ion buffer sharing")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>   tools/testing/selftests/android/ion/ipcsocket.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/android/ion/ipcsocket.c b/tools/testing/selftests/android/ion/ipcsocket.c
> index 7dc521002095..268e6b610357 100644
> --- a/tools/testing/selftests/android/ion/ipcsocket.c
> +++ b/tools/testing/selftests/android/ion/ipcsocket.c
> @@ -28,8 +28,9 @@ int opensocket(int *sockfd, const char *name, int connecttype)
>   	}
>   
>   	*sockfd = ret;
> -	if (setsockopt(*sockfd, SOL_SOCKET, SO_REUSEADDR,
> -		(char *)&temp, sizeof(int)) < 0) {
> +	ret = setsockopt(*sockfd, SOL_SOCKET, SO_REUSEADDR, (char *)&temp,
> +			 sizeof(int))
> +	if (ret < 0) {
>   		fprintf(stderr, "<%s>: Failed setsockopt: <%s>\n",
>   		__func__, strerror(errno));
>   		goto err;
