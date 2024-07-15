Return-Path: <linux-kselftest+bounces-13714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AC8930CD4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 04:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595E81C2037E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 02:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592A279F3;
	Mon, 15 Jul 2024 02:50:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57613A94F;
	Mon, 15 Jul 2024 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721011811; cv=none; b=mz0+4vcDW0hoVqzHEF2CzKh4mvADe2Ou+vH9fPeKehlqmf/AJueDLdHwmzqb6R+j/p+3MhyJU3kG2uP9uvgMABaGJErZtpX4+7BWCgANb9oVE252ktFjMRo/jsdN/Vi462H1O/tZN+KBlu1jwHErIL67ZaJZWdMgOe247QeBUu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721011811; c=relaxed/simple;
	bh=YNBNPKTKiDGdFNzPXR/m2MDjlIsS9ABD1GqgCq/Y6v4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpOSggiHyQO6LfDo3dA4gJ7Bj14sBfAyXxhLOHV5DDtAyh8vo7gUfbM4THf+8HRSUHwzx6xMpn9ARzi1VwDSF/BuVEsKzxKdiINMxKnrXKRUYSTmQtD9BEpg1cOwqO5QVNd6mwYwJaA0QJfsco5AZjmHPjoGvaCjktqRlPjx19I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C590DFEC;
	Sun, 14 Jul 2024 19:50:33 -0700 (PDT)
Received: from [10.162.16.42] (unknown [10.162.16.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E9493F762;
	Sun, 14 Jul 2024 19:50:05 -0700 (PDT)
Message-ID: <321d4481-256c-41d9-9f64-f7e04e8d21be@arm.com>
Date: Mon, 15 Jul 2024 08:20:02 +0530
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
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20240712231730.2794-1-rbrasga@uci.edu>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240712231730.2794-1-rbrasga@uci.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/13/24 04:47, Remington Brasga wrote:
> The string passed to ksft_test_result_skip is missing the `type_name`
> 
> Signed-off-by: Remington Brasga <rbrasga@uci.edu>
> ---
> clang-tidy reported clang-diagnostic-format-insufficient-args warning
> on this line, so I am fixing it.
> 
>  tools/testing/selftests/arm64/abi/ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
> index abe4d58d731d..6144f83f8ab4 100644
> --- a/tools/testing/selftests/arm64/abi/ptrace.c
> +++ b/tools/testing/selftests/arm64/abi/ptrace.c
> @@ -156,7 +156,7 @@ static void test_hw_debug(pid_t child, int type, const char *type_name)
>  		/* Zero is not currently architecturally valid */
>  		ksft_test_result(arch, "%s_arch_set\n", type_name);
>  	} else {
> -		ksft_test_result_skip("%s_arch_set\n");
> +		ksft_test_result_skip("%s_arch_set\n", type_name);
>  	}
>  }
>  

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

