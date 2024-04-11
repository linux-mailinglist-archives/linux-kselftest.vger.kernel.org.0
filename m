Return-Path: <linux-kselftest+bounces-7673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BF18A0783
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 07:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A254528361B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 05:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A573D13C67E;
	Thu, 11 Apr 2024 05:15:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378E213C676;
	Thu, 11 Apr 2024 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712812547; cv=none; b=CjXrXSMHhBVODDoUkZ5xakkMLssy+UfyftR3sIgh0d/Ve41QF5m3TQybsl7/v2qZ3ozYhqISTLzQuwHuI9PQ8fD6s06sgmuHWGm19na81HMV+o8MWlBOMsFQoZddoYd4kVzk7JSiwpaSHEWrpti8vkXsphd9bfJxei6Pl0wcS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712812547; c=relaxed/simple;
	bh=vGGn1x3zfr9FmcUqGhn+U0mfHphCcmAa+VU8GSwpW/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBK2RFZ8wDBpjoGyQhPd7OOz/prbLU7I2d64vLg/a+hQe9lyaybgbP1lIt9qfCu+NHwp4CbwyhDNsXV2ywcLSqIo3t6uSx6LWo6nBtnNEwNJWX/1+TnzOQ2dLc2KyAFaXm1jVVV8MxCfdSK8kRgMr+wprsXdwaHwpIyABTn/jfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4FB4113E;
	Wed, 10 Apr 2024 22:16:13 -0700 (PDT)
Received: from [192.168.0.102] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E20593F64C;
	Wed, 10 Apr 2024 22:15:39 -0700 (PDT)
Message-ID: <d37fd97b-4af1-4585-85ed-6253a4f74132@arm.com>
Date: Thu, 11 Apr 2024 10:45:33 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests: Add build infrastructure along with README
To: Muhammad Usama Anjum <usama.anjum@collabora.com>, shuah@kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anshuman.Khandual@arm.com, suzuki.poulose@arm.com, ryan.roberts@arm.com,
 rob.herring@arm.com, Catalin.Marinas@arm.com, broonie@kernel.org,
 will@kernel.org, mark.rutland@arm.com
References: <20240405084410.256788-1-dev.jain@arm.com>
 <20240405084410.256788-5-dev.jain@arm.com>
 <ab271c32-dca8-413f-b97e-c8ceb6d7924c@collabora.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ab271c32-dca8-413f-b97e-c8ceb6d7924c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/7/24 02:45, Muhammad Usama Anjum wrote:
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 15b6a111c3be..8478d94cda4c 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -1,6 +1,7 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   TARGETS += alsa
>>   TARGETS += amd-pstate
>> +TARGETS += arm
>>   TARGETS += arm64
>>   TARGETS += bpf
>>   TARGETS += breakpoints
>> diff --git a/tools/testing/selftests/arm/Makefile b/tools/testing/selftests/arm/Makefile
>> new file mode 100644
>> index 000000000000..039224bc006e
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm/Makefile
>> @@ -0,0 +1,57 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +# When ARCH not overridden for crosscompiling, lookup machine
>> +ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>> +
>> +ifneq (,$(filter $(ARCH),aarch64 arm64 arm armv7l armv8l))
>> +ARM_SUBTARGETS ?= mm signal elf
>> +else
>> +ARM_SUBTARGETS :=
>> +endif
>> +
>> +CFLAGS := -Wall -O2 -g -static
>> +
>> +# A proper top_srcdir is needed by KSFT(lib.mk)
>> +top_srcdir = $(realpath ../../../../)
>> +
>> +# Additional include paths needed by kselftest.h and local headers
>> +CFLAGS += -I$(top_srcdir)/tools/testing/selftests/
>> +
>> +CFLAGS += -I$(top_srcdir)/tools/include
> Please use KHDR_INCLUDE instead of using absolute path


The reason I had excluded it was that the signal tests won't

build then. What probably happens is that the kernel headers

collide with the headers included by the compiler.


