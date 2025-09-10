Return-Path: <linux-kselftest+bounces-41085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DC4B50A2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 03:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0028C56497D
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 01:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EC71EF36E;
	Wed, 10 Sep 2025 01:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SqYRlq6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E681EB5E3;
	Wed, 10 Sep 2025 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757467416; cv=none; b=aV23aMBTTvUZPozMpUZ3Ra8hwhwuUM5Sqazoa2oZljup4FfzENe1LQKJmHDohfBlR9i0xTZNWZP+JQBvqD+tX6kj5PQN74D4MHfgo1iHAXbZMbK9vv+1pHizdJfh3/YvYfFDs2EHauYM+qyHmc+sGZl9HxS2R6TNQFREGTxzdJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757467416; c=relaxed/simple;
	bh=IH5BvaC5Gcab7Nl2e5r8t+42BjuaxZeLzuTy3FjoX2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OXk1XshKCkTONfG6gqRLyddc/vqx+jFY3JdR+lsHrS/+2a8V0T8SnC+6XOFC11DMURwNXxGxJwp1KJ9QqhJPkDyQbQbzIR9j49MEjjlT6HfbGDma7NeJLZMA/4EKYKtxt1tBfxUGrNAHTJfzN7qDi7BDa7Pt/ldfYRCuZzPEdRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SqYRlq6F; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757467405; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ETfF3nXwktUoBLCMUHpmxOuNXOkjj20h9ToOxP0Cp2M=;
	b=SqYRlq6FBKO1/MT3inJUSAmB4plbaA7Y7gN0chTR8szcfG/Enpl9WS7dQKCdQWhnhuGcyq++LEXp4jtC1+8BWLlFDKwds/53nMz2f1aMS1dv4v51NKw3IGeqGQWiKDl8N5M0doF1khU/+/4fJh5fD4dp5OqVSQqz4SCFIIHFsQU=
Received: from 30.74.144.128(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wng1uuh_1757467404 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 09:23:24 +0800
Message-ID: <b9f26954-fea6-44f8-b71a-44e5b4b070e9@linux.alibaba.com>
Date: Wed, 10 Sep 2025 09:23:23 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: remove PROT_EXEC req from file-collapse
 tests
To: Zach O'Keefe <zokeefe@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250909190534.512801-1-zokeefe@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250909190534.512801-1-zokeefe@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/10 03:05, Zach O'Keefe wrote:
> As of v6.8 commit 7fbb5e188248 ("mm: remove VM_EXEC requirement for THP eligibility")
> thp collapse no longer requires file-backed mappings be created with
> PROT_EXEC.
> 
> Remove the overly-strict dependency from thp collapse tests so we test
> the least-strict requirement for success.
> 
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   tools/testing/selftests/mm/khugepaged.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index a18c50d51141..3fe7ef04ac62 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -394,7 +394,7 @@ static void *file_setup_area(int nr_hpages)
>   		perror("open()");
>   		exit(EXIT_FAILURE);
>   	}
> -	p = mmap(BASE_ADDR, size, PROT_READ | PROT_EXEC,
> +	p = mmap(BASE_ADDR, size, PROT_READ,
>   		 MAP_PRIVATE, finfo.fd, 0);
>   	if (p == MAP_FAILED || p != BASE_ADDR) {
>   		perror("mmap()");


