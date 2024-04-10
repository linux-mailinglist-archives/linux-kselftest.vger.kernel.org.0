Return-Path: <linux-kselftest+bounces-7520-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0432789E927
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 06:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DB11F215A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 04:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA1C132;
	Wed, 10 Apr 2024 04:43:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360B9BA41;
	Wed, 10 Apr 2024 04:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712724227; cv=none; b=S+MRpkcpF1FkpxtXTHnG8NcOzxDIyhpyRfvOtymXDXBAERmXKJiyuahAxRlO7ieKCTqsvJedPLXcO6IXKvw0tla6H+Fmhy0QIi4hDTYW8i5Hr69qxVIr5AtRFuvQwHaMkwiicVF6/ZTvmkK4UBtacM471zj9V2HW7/TVLUhxADI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712724227; c=relaxed/simple;
	bh=ctwNWLt5eK8H01qTqfDPZ3c/0ckslIEzhyrzJS8sZNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOM8WzEDFLMSznn72us9CljZgI5kcn7gQyxrBULGGJFdCjcCVhdSp+EFzsYxfALuscB6dIeeD4lcj7hm9TzrPJdBf+LSGPfG+sFGAYH/Mew4qnbl51fpf+FjOCGoeZjRbuiLTqRXAMN6itNNvlVyfKL3eXAc5mue9SsP3xAnaCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67BDF139F;
	Tue,  9 Apr 2024 21:44:15 -0700 (PDT)
Received: from [10.162.40.22] (e116581.arm.com [10.162.40.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38E593F6C4;
	Tue,  9 Apr 2024 21:43:40 -0700 (PDT)
Message-ID: <60db8c70-323b-4e28-8869-6f8166515aec@arm.com>
Date: Wed, 10 Apr 2024 10:13:16 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] selftests/arm: Add signal tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anshuman.Khandual@arm.com, suzuki.poulose@arm.com, ryan.roberts@arm.com,
 rob.herring@arm.com, Catalin.Marinas@arm.com, broonie@kernel.org,
 will@kernel.org, mark.rutland@arm.com
References: <20240405084410.256788-1-dev.jain@arm.com>
 <20240405084410.256788-3-dev.jain@arm.com>
 <1ce0e9c7-0bd3-47c1-893c-3ea5aa95fef5@collabora.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <1ce0e9c7-0bd3-47c1-893c-3ea5aa95fef5@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/7/24 02:58, Muhammad Usama Anjum wrote:
> On 4/5/24 1:44 PM, Dev Jain wrote:
>> This patch introduces two signal tests, and generic test wrappers similar to
>> selftests/arm64/signal directory, along with the mangling testcases found
>> therein. arm_cpsr, dumped by the kernel to user space in the ucontext structure
>> to the signal handler, is mangled with. The kernel must spot this illegal
>> attempt and the testcases are expected to terminate via SEGV.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   .../selftests/arm/signal/test_signals.c       |  27 ++
>>   .../selftests/arm/signal/test_signals.h       |  74 +++++
>>   .../selftests/arm/signal/test_signals_utils.c | 257 ++++++++++++++++++
>>   .../selftests/arm/signal/test_signals_utils.h | 128 +++++++++
>>   .../signal/testcases/mangle_cpsr_aif_bits.c   |  33 +++
>>   .../mangle_cpsr_invalid_compat_toggle.c       |  29 ++
> Too many files/tests in one patch. Break this patch logically into multiple
> tests for easy to review and follow.


In this particular case, I am not sure about the utility of doing that.

My idea was to put the wrapper infrastructure and the individual testcases

into a single patch for ease of comparison with selftests/arm64; this will

actually help in pointing out mistakes or suggesting improvements.

>
>>   6 files changed, 548 insertions(+)
>>   create mode 100644 tools/testing/selftests/arm/signal/test_signals.c
>>   create mode 100644 tools/testing/selftests/arm/signal/test_signals.h
>>   create mode 100644 tools/testing/selftests/arm/signal/test_signals_utils.c
>>   create mode 100644 tools/testing/selftests/arm/signal/test_signals_utils.h
>>   create mode 100644 tools/testing/selftests/arm/signal/testcases/mangle_cpsr_aif_bits.c
>>   create mode 100644 tools/testing/selftests/arm/signal/testcases/mangle_cpsr_invalid_compat_toggle.c

