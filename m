Return-Path: <linux-kselftest+bounces-27082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AF1A3DF49
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 16:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AE0B1888A36
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 15:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F5D1FECA3;
	Thu, 20 Feb 2025 15:48:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC531DE4CE;
	Thu, 20 Feb 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066531; cv=none; b=Nb4gv4HwwLjVgwdu8SALm2lulpw8SmiFpQ0Mk7a48keJFccHEz/AMLQAVcg7c5G/QzyH1Vy+D5du7VAaKNnCxQXVOWFLrYK72ECyQccvCAqBjxSvbZtkCjeVBSPwE3TVt3iyTJh7d2/c8RdDO4aKzbCFrJw8T0e2m9sDIKRgqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066531; c=relaxed/simple;
	bh=7zw7Yq6Ak+GDuRkuhfa5b5YJDzjQ4/nzjuQ5ddi+8qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3/Y0wrtFuL6W7Dn46M7g5cdoEke3xhp9dT0xd3yH4C8eKs5q6Y3NJchsYX32dqHPCi6uQ2hH3O2OmnMz9RoJWe8TbcHhBCARRaBzybdY7pOywrCiT8mux5rMHeeeh+fFk6hX48reANFJjzJ6d69P2SxHSa27CW5QF+d5WVhjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E820C16F3;
	Thu, 20 Feb 2025 07:49:06 -0800 (PST)
Received: from [10.163.39.71] (unknown [10.163.39.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 278DF3F59E;
	Thu, 20 Feb 2025 07:48:45 -0800 (PST)
Message-ID: <da1c3dcb-5296-47bd-b5ed-9cb8833377cf@arm.com>
Date: Thu, 20 Feb 2025 21:18:42 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] selftests/mm: Don't fail uffd-stress if too many CPUs
To: Brendan Jackman <jackmanb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
 <20250220-mm-selftests-v1-6-9bbf57d64463@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250220-mm-selftests-v1-6-9bbf57d64463@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/02/25 8:33 pm, Brendan Jackman wrote:
> This calculation divides a fixed parameter by an environment-dependent
> parameter i.e. the number of CPUs.
> 
> The simple way to avoid machine-specific failures here is to just put a
> cap on the max value of the latter.

I haven't read the test, but if nr_cpus is being computed, then this 
value must be important to the test somehow? Would it potentially be 
wrong to let the test run for nr_cpus != actual number of cpus?

Also, if the patch is correct then will it be better to also print a 
diagnostic telling the user that the number of cpus is going to be 
capped for the test to run?

> 
> Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   tools/testing/selftests/mm/uffd-stress.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index 1facfb79e09aa4113e344d7d90dec06a37264058..f306accbef255c79bc3eeba8b9e42161a88fc10e 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -453,6 +453,10 @@ int main(int argc, char **argv)
>   	}
>   
>   	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +	if (nr_cpus > 32) {
> +		/* Don't let calculation below go to zero. */
> +		nr_cpus = 32;
> +	}
>   
>   	nr_pages_per_cpu = bytes / page_size / nr_cpus;
>   	if (!nr_pages_per_cpu) {
> 


