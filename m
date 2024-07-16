Return-Path: <linux-kselftest+bounces-13763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7762931FA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 06:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5757C1F21EB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 04:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464C317C8B;
	Tue, 16 Jul 2024 04:19:30 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7469715EA6;
	Tue, 16 Jul 2024 04:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721103570; cv=none; b=Nli8wZZYqhA6D7+DnUZ2u6/8qtoSstQabYbXIwnkYsbQXFCXBZ7zmJEzatJywQwGSPTeHK56APnyTV9vUucJ6STWgLzPtiraGMviKaTj0UfrnZKoT6rIQKye/taJ1jpgpzHx21QH85e9stBLrRRrZ/6TPE0uHo743pJ6fLO/fws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721103570; c=relaxed/simple;
	bh=4I3XhDSgPabyxHA758Oiv0TD2YqWE0BjcaQb+oxczCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDI0t1Httq+yy9bXZbfnr9kSHp+Cz8fO9Ts+rv/zvNN91hDt9A89wJdRBXzqubH72dD74XHd/X0kX3l73FHCzAorLNUjZCD2Y6H0u7ySNJFwByfnCb6hNAmAAWNucdVZWLRenGIV29BKX8ThfugAoA8m+DWW9GMug5COqEM2rdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0309C1063;
	Mon, 15 Jul 2024 21:19:53 -0700 (PDT)
Received: from [10.162.43.23] (e116581.arm.com [10.162.43.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 057113F762;
	Mon, 15 Jul 2024 21:19:23 -0700 (PDT)
Message-ID: <f7383c8c-83f3-45da-a8c4-2cfcfa497936@arm.com>
Date: Tue, 16 Jul 2024 09:49:12 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest: missing arg in ptrace.c
To: Remington Brasga <rbrasga@uci.edu>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, Anshuman.Khandual@arm.com,
 Mark Brown <broonie@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>
References: <20240712231730.2794-1-rbrasga@uci.edu>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240712231730.2794-1-rbrasga@uci.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/13/24 04:47, Remington Brasga wrote:
> The string passed to ksft_test_result_skip is missing the `type_name`
>
> Signed-off-by: Remington Brasga <rbrasga@uci.edu>
> ---
> clang-tidy reported clang-diagnostic-format-insufficient-args warning
> on this line, so I am fixing it.
>
>   tools/testing/selftests/arm64/abi/ptrace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
> index abe4d58d731d..6144f83f8ab4 100644
> --- a/tools/testing/selftests/arm64/abi/ptrace.c
> +++ b/tools/testing/selftests/arm64/abi/ptrace.c
> @@ -156,7 +156,7 @@ static void test_hw_debug(pid_t child, int type, const char *type_name)
>   		/* Zero is not currently architecturally valid */
>   		ksft_test_result(arch, "%s_arch_set\n", type_name);
>   	} else {
> -		ksft_test_result_skip("%s_arch_set\n");
> +		ksft_test_result_skip("%s_arch_set\n", type_name);
>   	}
>   }

Okay, I almost forgot that I had a patch fixing this as part of another series:
https://lore.kernel.org/all/20240625122408.1439097-6-dev.jain@arm.com/
If that is OK, Will, can you please pull that? Or should I send that as a
separate patch?


