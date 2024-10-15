Return-Path: <linux-kselftest+bounces-19700-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D096099DC4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 04:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E082F1C20E83
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 02:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BA1249F9;
	Tue, 15 Oct 2024 02:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JmvGcGlb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900C51F61C;
	Tue, 15 Oct 2024 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728959652; cv=none; b=mY/eUpe3cW+mDc47iGg8DrTta83aG0r9ys6hXiWSwpHXKYbKP7w/+26UTicYbjkQ75k3HZSnEyd1a8RDHQhc1Me+8kE0iM42X1GuelIcQ+jsMISlcQ+2DkTXIsSm6f+NIPGuld4y/rOiov0k//7Q4B0a5YIyvbtjvf6ysg+eEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728959652; c=relaxed/simple;
	bh=TBwO0AyTAVcfkeQ2eryFWXgTRaeM2PEuNXkVNhBfU7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dW8qVTfNh/O3sjNdvp0ZaIBxTvzD4oQUoYEtKGVlszzrZBhCkj0x0dClUPlZQN6CybRMBnrKxhDunYxwrz37Gc91SGyxHKREg+0PJ5wrXyHZfSvYd1xKm/hgjLUnlnaiCYOITyW2hBXU0SnAhE3Pc9M2FL6qHqDht9qowC5XmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JmvGcGlb; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728959647; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=5SWTPrpRWV5oTpc4vCe8QJknxozDoWmECEzjBVIQIOY=;
	b=JmvGcGlbw9o+Nj3AipRl9y01L3kla3aVZoXJuy8nTGD5V/ZRZLfwFQXu7Tenc4Ia9G7QY6XgN9FBLRUAfq/KLHHefQ2MCXUWjfnCfqrigS8ogkYisTuYZo1FG6slCy9KCQxEq5og84jz2O7HMZK9e7gttXuv0sM1dLMxZ/ShbaE=
Received: from 30.74.144.137(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WHBZZRf_1728959646 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 15 Oct 2024 10:34:06 +0800
Message-ID: <87af6d7a-3a55-4f7d-979d-820cc390e855@linux.alibaba.com>
Date: Tue, 15 Oct 2024 10:34:05 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: mm: fix the incorrect usage() info of
 khugepaged
To: Nanyong Sun <sunnanyong@huawei.com>, akpm@linux-foundation.org,
 shuah@kernel.org, zokeefe@google.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
References: <20241015020257.139235-1-sunnanyong@huawei.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20241015020257.139235-1-sunnanyong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/15 10:02, Nanyong Sun wrote:
> The mount option of tmpfs should be huge=advise, not madvise
> which is not supported and may mislead the users.
> 
> Fixes: 1b03d0d558a2 ("selftests/vm: add thp collapse file and tmpfs testing")
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   tools/testing/selftests/mm/khugepaged.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index 56d4480e8d3c..8a4d34cce36b 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -1091,7 +1091,7 @@ static void usage(void)
>   	fprintf(stderr, "\n\t\"file,all\" mem_type requires kernel built with\n");
>   	fprintf(stderr,	"\tCONFIG_READ_ONLY_THP_FOR_FS=y\n");
>   	fprintf(stderr, "\n\tif [dir] is a (sub)directory of a tmpfs mount, tmpfs must be\n");
> -	fprintf(stderr,	"\tmounted with huge=madvise option for khugepaged tests to work\n");
> +	fprintf(stderr,	"\tmounted with huge=advise option for khugepaged tests to work\n");
>   	fprintf(stderr,	"\n\tSupported Options:\n");
>   	fprintf(stderr,	"\t\t-h: This help message.\n");
>   	fprintf(stderr,	"\t\t-s: mTHP size, expressed as page order.\n");

