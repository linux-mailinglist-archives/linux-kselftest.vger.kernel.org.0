Return-Path: <linux-kselftest+bounces-19920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB7F9A1B37
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582AA1C20B8A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 07:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09966194A4B;
	Thu, 17 Oct 2024 07:01:46 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E0C1514FE;
	Thu, 17 Oct 2024 07:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148505; cv=none; b=a9Ua6mP4P1f2zk/FUTZzoGIBZAc9gwzIdsgX2S5DjMZQoVy+mGhYVola0KYr0Z7Sv1AOOsPA/kNidU8pWM7WHGMiplcgI/nQE3VqoAcf2KAemjQpYNxJ553jcGMiqXaUuCe/RR4z91x72yHgfKPFvNgx3KjDek4SsBG4d/pqjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148505; c=relaxed/simple;
	bh=ZAu9ymc454DUdOn3SOxs14PBr95ZNBumkojZZl5hPLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mumqAAxfKBdlysWx2V07+nrxY5GeGTmvCu9MqZD48n8QDNkrvayqYTcrUM0cKJk6ogrqpE1YhUjdOCqfbYA1EURWdCwJXVG32qgl3KQIoiy3nVllNJdOeSo7janSbHTJJTv5GwzZZVIic4AIeXRZlbQRtHNjvWV0uPu/mNbKUFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFCADFEC;
	Thu, 17 Oct 2024 00:02:05 -0700 (PDT)
Received: from [10.163.39.37] (unknown [10.163.39.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D69E3F528;
	Thu, 17 Oct 2024 00:01:33 -0700 (PDT)
Message-ID: <37ce9dfa-3193-4e11-bfd1-d2c8b60b0090@arm.com>
Date: Thu, 17 Oct 2024 12:31:31 +0530
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
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20241015020257.139235-1-sunnanyong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/15/24 07:32, Nanyong Sun wrote:
> The mount option of tmpfs should be huge=advise, not madvise
> which is not supported and may mislead the users.

Agreed.

> 
> Fixes: 1b03d0d558a2 ("selftests/vm: add thp collapse file and tmpfs testing")

But nothing is really broken here. This just fixes usage information.
Please drop the "Fixes:".

> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>  tools/testing/selftests/mm/khugepaged.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
> index 56d4480e8d3c..8a4d34cce36b 100644
> --- a/tools/testing/selftests/mm/khugepaged.c
> +++ b/tools/testing/selftests/mm/khugepaged.c
> @@ -1091,7 +1091,7 @@ static void usage(void)
>  	fprintf(stderr, "\n\t\"file,all\" mem_type requires kernel built with\n");
>  	fprintf(stderr,	"\tCONFIG_READ_ONLY_THP_FOR_FS=y\n");
>  	fprintf(stderr, "\n\tif [dir] is a (sub)directory of a tmpfs mount, tmpfs must be\n");
> -	fprintf(stderr,	"\tmounted with huge=madvise option for khugepaged tests to work\n");
> +	fprintf(stderr,	"\tmounted with huge=advise option for khugepaged tests to work\n");
>  	fprintf(stderr,	"\n\tSupported Options:\n");
>  	fprintf(stderr,	"\t\t-h: This help message.\n");
>  	fprintf(stderr,	"\t\t-s: mTHP size, expressed as page order.\n");

Without the above "Fixes:" tag,

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

