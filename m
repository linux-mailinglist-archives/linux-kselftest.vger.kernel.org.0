Return-Path: <linux-kselftest+bounces-16053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6956C95B4BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 14:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3C91C22E66
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 12:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EFD1C9435;
	Thu, 22 Aug 2024 12:12:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0465B1C9429;
	Thu, 22 Aug 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328728; cv=none; b=PA4uR5ag+5q9vRR0uAr559dSMun7pdkuAqViNMb4vDWP7TiVc3dmW0rmraGGOsFY4kCleWvqdXvwYIBvNhv30j91Wa8bm7aX4mUpTGZVrZuU5ax/3EEX7gPh1ROZu+az4cftWI2W3Kt34Q3MLS+m8guj0kj0IuebMkRyuIw8x1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328728; c=relaxed/simple;
	bh=dpdpQAm2xKfZEjOuJi5GVmZKvtffbCe/670e1VzEAE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSx4srHJ7WN2AfeQlXrMYZGVRoIrokNC11PeL722ZNLOqF1Z/2Fwp/ywNoy0zUHWsHwX4HIj1O1uRa2NTLqpXu7b9ld4a+WUQXBH26BDwcmvfqCbVWW0e4Jl1NUfu91Q7F2gn0xkRDLW5N16o55QNYxR0jhfBt5egozJqflAocU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90931DA7;
	Thu, 22 Aug 2024 05:12:32 -0700 (PDT)
Received: from [10.163.87.181] (unknown [10.163.87.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 758FC3F66E;
	Thu, 22 Aug 2024 05:12:01 -0700 (PDT)
Message-ID: <73aa91ba-fe1c-4c5f-8b81-f1a13dc9151a@arm.com>
Date: Thu, 22 Aug 2024 17:41:57 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
To: shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240822120915.3584731-1-dev.jain@arm.com>
 <20240822120915.3584731-2-dev.jain@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240822120915.3584731-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/22/24 17:39, Dev Jain wrote:
> Rename sigaltstack to signal, and rename the existing test to
> sigaltstack.c.


Sorry, hastily copied the commit message from the previous
iteration :) will send again, kindly ignore this.

>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/Makefile                                | 2 +-
>   tools/testing/selftests/{sigaltstack => signal}/.gitignore      | 0
>   tools/testing/selftests/{sigaltstack => signal}/Makefile        | 0
>   .../selftests/{sigaltstack => signal}/current_stack_pointer.h   | 0
>   tools/testing/selftests/{sigaltstack => signal}/sas.c           | 0
>   5 files changed, 1 insertion(+), 1 deletion(-)
>   rename tools/testing/selftests/{sigaltstack => signal}/.gitignore (100%)
>   rename tools/testing/selftests/{sigaltstack => signal}/Makefile (100%)
>   rename tools/testing/selftests/{sigaltstack => signal}/current_stack_pointer.h (100%)
>   rename tools/testing/selftests/{sigaltstack => signal}/sas.c (100%)
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index bc8fe9e8f7f2..edbe30fb3304 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -87,7 +87,7 @@ TARGETS += rtc
>   TARGETS += rust
>   TARGETS += seccomp
>   TARGETS += sgx
> -TARGETS += sigaltstack
> +TARGETS += signal
>   TARGETS += size
>   TARGETS += sparc64
>   TARGETS += splice
> diff --git a/tools/testing/selftests/sigaltstack/.gitignore b/tools/testing/selftests/signal/.gitignore
> similarity index 100%
> rename from tools/testing/selftests/sigaltstack/.gitignore
> rename to tools/testing/selftests/signal/.gitignore
> diff --git a/tools/testing/selftests/sigaltstack/Makefile b/tools/testing/selftests/signal/Makefile
> similarity index 100%
> rename from tools/testing/selftests/sigaltstack/Makefile
> rename to tools/testing/selftests/signal/Makefile
> diff --git a/tools/testing/selftests/sigaltstack/current_stack_pointer.h b/tools/testing/selftests/signal/current_stack_pointer.h
> similarity index 100%
> rename from tools/testing/selftests/sigaltstack/current_stack_pointer.h
> rename to tools/testing/selftests/signal/current_stack_pointer.h
> diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/signal/sas.c
> similarity index 100%
> rename from tools/testing/selftests/sigaltstack/sas.c
> rename to tools/testing/selftests/signal/sas.c

