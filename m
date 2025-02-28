Return-Path: <linux-kselftest+bounces-27938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCEBA4A02B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 18:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9FFD1751E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235F26B976;
	Fri, 28 Feb 2025 17:20:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F5E1F4CAC;
	Fri, 28 Feb 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763220; cv=none; b=TgZDx6JzUtOQELDyc0jiabxBBl1LuV7SJI1QSu6XomxwUJAFRsdtb6J/egY5QBF1phbv+BuTYiV+fzmEub5+7qLOOdRqhxkF1jRV2DKNTqNnFkKyjVwhxUm5KeRTh1L0PUEHMCgnjJZ2/Q69fWyDG2ZkMFkbG07o+1xT0lDYoJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763220; c=relaxed/simple;
	bh=sFS7Ugua49zQyIjZ9xVqeoqFFMMFPAmbSjue2XRZvWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3yEQwxYTdLNYSYiM3rT3tjRp6l+A1fvZHQAS30QxT4UtlfQkieFZvkhiklRVz48VaD9+UdsecDZqQSbq6/UmOSp2dslGuy3pNs1YBp4o2/SPSSCr5zQyTfeUg3rHNgQjwvYPKjXsW9K09+mVnBHYYtgKmFKtnTrHRt3okKeDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4223E150C;
	Fri, 28 Feb 2025 09:20:31 -0800 (PST)
Received: from [10.163.40.175] (unknown [10.163.40.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D8DE3F6A8;
	Fri, 28 Feb 2025 09:20:11 -0800 (PST)
Message-ID: <931caf2f-4404-4d7f-ba81-df237cf53d6f@arm.com>
Date: Fri, 28 Feb 2025 22:50:07 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] selftests/mm: Skip uffd-stress if userfaultfd
 not available
To: Brendan Jackman <jackmanb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-2-958e3b6f0203@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250228-mm-selftests-v3-2-958e3b6f0203@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/02/25 10:24 pm, Brendan Jackman wrote:
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
> index a4b83280998ab7ce8d31e91d8f9fbb47ef11d742..ed68436fac62c76e2ca7060c661487f2f8a6ab45 100644
> --- a/tools/testing/selftests/mm/uffd-stress.c
> +++ b/tools/testing/selftests/mm/uffd-stress.c
> @@ -411,8 +411,8 @@ static void parse_test_type_arg(const char *raw_type)
>   	 * feature.
>   	 */
>   
> -	if (uffd_get_features(&features))
> -		err("failed to get available features");
> +	if (uffd_get_features(&features) && errno == ENOENT)
> +		ksft_exit_skip("failed to get available features (%d)\n", errno);

Is it possible that uffd_get_features(&features) returns non-zero 
without errno == ENOENT?


