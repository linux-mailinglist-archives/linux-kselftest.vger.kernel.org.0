Return-Path: <linux-kselftest+bounces-27939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2026A4A045
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 18:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5893B3AF6B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 17:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2C91F4CB4;
	Fri, 28 Feb 2025 17:25:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBF31F4C81;
	Fri, 28 Feb 2025 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763513; cv=none; b=Hz78+m3UZQWNN6I6bRbc3nxYzIjAChlzw9zqh/oxJoIz9E8t/MneJqOcOmCjtXIPe3GS9SvQe6g4+rukorPU/CF1FcEQ3h9ZpbaeXb+Zx8ptxb2GN49xO8A107tAZ8AjmG/o9PewzgLWn33tGbzLY2aA9AMIV/MTIy/d/ku6QrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763513; c=relaxed/simple;
	bh=59P4PjKsazG+VmnvAzFyUDGv25I1DnQgpRMK/D8+zxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reiKr0CIL/P5Jqlv3J0F1zDXJwNu9bdB4Qis41lojWMjBWa9JbOcLzuovxLb+OcbHSo1MAYkMEpyvYn3237akrR1KqWy2YmfHaqhcB8575N77tdOBaBPtep6oqjgFaeoAK2+FBD323XrDOcNjsp08zxwpHj+U1k+ra2sMaO88bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA9C4150C;
	Fri, 28 Feb 2025 09:25:23 -0800 (PST)
Received: from [10.163.40.175] (unknown [10.163.40.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 412E83F6A8;
	Fri, 28 Feb 2025 09:25:03 -0800 (PST)
Message-ID: <99739a23-9843-4c96-a614-ce2d48431a5c@arm.com>
Date: Fri, 28 Feb 2025 22:55:00 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] selftests/mm: Skip uffd-wp-mremap if userfaultfd
 not available
To: Brendan Jackman <jackmanb@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-3-958e3b6f0203@google.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250228-mm-selftests-v3-3-958e3b6f0203@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/02/25 10:24 pm, Brendan Jackman wrote:
> It's obvious that this should fail in that case, but still, save the
> reader the effort of figuring out that they've run into this by just
> SKIPping
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   tools/testing/selftests/mm/uffd-wp-mremap.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-wp-mremap.c b/tools/testing/selftests/mm/uffd-wp-mremap.c
> index 2c4f984bd73caa17e12b9f4a5bb71e7fdf5d8554..c2ba7d46c7b4581a3c32a6b6acd148e3e89c2172 100644
> --- a/tools/testing/selftests/mm/uffd-wp-mremap.c
> +++ b/tools/testing/selftests/mm/uffd-wp-mremap.c
> @@ -182,7 +182,10 @@ static void test_one_folio(size_t size, bool private, bool swapout, bool hugetlb
>   
>   	/* Register range for uffd-wp. */
>   	if (userfaultfd_open(&features)) {
> -		ksft_test_result_fail("userfaultfd_open() failed\n");
> +		if (errno == ENOENT)
> +			ksft_test_result_skip("userfaultfd not available\n");
> +		else
> +			ksft_test_result_fail("userfaultfd_open() failed\n");
>   		goto out;
>   	}
>   	if (uffd_register(uffd, mem, size, false, true, false)) {
> 

I think you are correct, just want to confirm whether "uffd not 
available" if and only if "errno == ENOENT" is true. That is,
is it possible that errno can be something else and uffd is still not 
available, or errno can be ENOENT even if uffd is available.

