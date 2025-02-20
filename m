Return-Path: <linux-kselftest+bounces-27098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4CFA3E360
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 19:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C312A19C2491
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B9C21420F;
	Thu, 20 Feb 2025 18:06:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425CA214201;
	Thu, 20 Feb 2025 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074818; cv=none; b=E0fNv6HDDdcjA39dN1/cRFjTC3rQBwqVffBkGJHvKJfy3Wy93kBfgV1L2vwsR0IkHOOrH7DcJkxrBWD4Ag4NX08xEHM8YKEitwoFL+nu11LqT8GI7QiNVFVg2ZVTDPzrKIEgj5el77tDpUk68So+7uZU5g25U+cHh0wVtUpcOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074818; c=relaxed/simple;
	bh=C833roobNSYGaXZ/k7U5VkdmU+nZ5/B3t9xz3ClihP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H75i6HH0J0s+0Gf/36yY9NQKDU66FumrU4G5H5WAlA8NNAFwaSQb3Nt6MMhxa9ygeiOYHjNWgg2s32JjFt5YhL668PPTaz4qewrDtudbbOY4fmozk4zpvNbx6hcXrDq7FA10magzYPzkRhGLACLU0ZXDz0VQqu1i0tjxfEWqpYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFB8216F3;
	Thu, 20 Feb 2025 10:07:14 -0800 (PST)
Received: from [10.163.39.71] (unknown [10.163.39.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F5D23F59E;
	Thu, 20 Feb 2025 10:06:54 -0800 (PST)
Message-ID: <d22b6cec-0688-49a6-a42a-decb2632aa79@arm.com>
Date: Thu, 20 Feb 2025 23:36:50 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] selftests/mm: Skip uffd-stress if userfaultfd not
 available
To: Brendan Jackman <jackmanb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250220-mm-selftests-v1-0-9bbf57d64463@google.com>
 <20250220-mm-selftests-v1-3-9bbf57d64463@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250220-mm-selftests-v1-3-9bbf57d64463@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/02/25 8:33 pm, Brendan Jackman wrote:
> It's pretty obvious that the test wouldn't work if you don't have the
> feature enabled. But, it's still useful to SKIP instead of failing so
> the reader can immediately tell that this is the reason why.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   tools/testing/selftests/mm/uffd-stress.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
> index a4b83280998ab7ce8d31e91d8f9fbb47ef11d742..db5366b4766e5bfa2d1150d2f3c2d32469a6e28b 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -411,8 +411,8 @@ static void parse_test_type_arg(const char *raw_type)
>   	 * feature.
>   	 */
>   
> -	if (uffd_get_features(&features))
> -		err("failed to get available features");
> +	if (uffd_get_features(&features) && errno == ENOENT)
> +		ksft_exit_skip("failed to get avialable features (%d)\n", errno);
>   

s/avialable/available

>   	test_uffdio_wp = test_uffdio_wp &&
>   		(features & UFFD_FEATURE_PAGEFAULT_FLAG_WP);
> 


