Return-Path: <linux-kselftest+bounces-36780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2850AFDB34
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 00:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306194E0675
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 22:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20C9265282;
	Tue,  8 Jul 2025 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NOoMQBZv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA87E23B633
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Jul 2025 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752014294; cv=none; b=qwOmxKNzI+mhXkLLW/xQLVvYB4UtgeMqSQFBkdJpOb0d4QaYY7q1yq2tFjo+dYREZztpBcyS77at9tPf6AiUX8hbxrB9x+M9EA56Ywfj4whjxf/rqZPEV1HzL9QzGWdqq+ACY8NhbU2eZhSWYm37HTZq3BYoJFWTYnkVfZuVGhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752014294; c=relaxed/simple;
	bh=fPrGUiRoPzaB7mbeVkRZV0xHB6hD4FQCBeg/4YZtRxU=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=r8OHiqCtmn6DCCQTuCmxycal/FjBdLyT+tyzkv132C2PbfNCYE/0NamJJA2OCh3JTfhFnpD35SaBNx6txRhr5E+M7xr2svJEriaTuBFvE9cewWQPfh5++C0t3EYbZHlLnVLBAsyK3ab4vMrMKzJ3YnEez8pr1roJGmfuDeI7qHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NOoMQBZv; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-86cfea700daso426147639f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Jul 2025 15:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752014291; x=1752619091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sSGE81kG8MSU1EuzRA4Ju+fw25jrq48Z8DcwNvLiEVI=;
        b=NOoMQBZvyPL8G2o1Q01BcEIqUdi9SVZJA5YgfW2LSPEuyJQmZyM7Cb7onFHqgOHCaZ
         8+qK73J5vGXy80X0UQs9G5YKqi4WQkej6+Dl5r7keHxP1AQKirhZLfrMt45TW742AW5u
         eWfE715RwjN0z0nOvFUnAmFe4Zfd0lvgtQrA1kwNRsf/bla1XzZ6hx4XGmpxhjeQqhkE
         cN4T2VmFxUQxYWK/X4KFflL8wJY0QHKGWjXWv5vZ3/QzmdD1eZwvh/WYKzjPTCiyqd+W
         A2j3llprfIjJcugnA9gnyuUCVvN+WJr/RsuKjIFfT7RFLKuZoWBLtjSuYwhtfbivG+MW
         hVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752014291; x=1752619091;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSGE81kG8MSU1EuzRA4Ju+fw25jrq48Z8DcwNvLiEVI=;
        b=kfV6cJtBXudFZHX8smjttGdNl6kSxfto71HsLuWcSfdGjwXFtjhfp3lVKhOJCKGJsW
         FSDQkx0+rtJ5L0/9+4uwLQ9NKI000d0uemU3vh5AByF127F1/nEiJuNxGGBc9kekkNYQ
         jnKjJopQIqwtmzNa/fdr1DVyI4WmgZKcMubEFDRVQftEs+/jqydMxW650xH97GvdtNih
         E9IBMqPE/oWUXHsIoprqZMxIMxSIRZ0g+puYe4ZP95/FscsMwrvG5dZ+qRu95oFEF2mI
         c4jXKiH+8fQyWdbNkS8dDVx+CrKnJofyBcUQhAsWM80GtmdrNMUOgHblGjHCTfMPkYdI
         woQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR5gTU/WO39jNDzkpFlHAieAqBnGOy+3kYTcNnRzLA1/4mGVHqga+YLravq/PSxJaJhAlPm7OTSHCRQ6DCKAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwJJm8abYlhu+3D/hTPY/DBxL+uVqjWYtNZtBOVoZ39QSE8GV8
	sRiRFZ0EsywJOgSgXk2CB7wEyxyFPqprUTC+ukJVaqn7o6avki/4wlQcBQB3gkfcD1H7dt9R4yg
	ZtUZBGjX4oMYkQCu9b4NbYJiowg==
X-Google-Smtp-Source: AGHT+IElZSU1mvIYmkS4wS1+niCRVTirXhRKz2Czs2rKpnrIyPxUWzZESy39W+5ywF5yW6YiMbWYADPEahU+1UGQ7Q==
X-Received: from ilbea23-n1.prod.google.com ([2002:a05:6e02:4517:10b0:3df:34b7:24e5])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:1a8d:b0:3df:2f47:dc21 with SMTP id e9e14a558f8ab-3e16711a372mr4583915ab.22.1752014291170;
 Tue, 08 Jul 2025 15:38:11 -0700 (PDT)
Date: Tue, 08 Jul 2025 22:38:10 +0000
In-Reply-To: <aGv8vgrZTET0aXjQ@J2N7QTR9R3> (message from Mark Rutland on Mon,
 7 Jul 2025 17:58:38 +0100)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntzfdez4tp.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v3 07/22] perf: arm_pmuv3: Generalize counter bitmasks
From: Colton Lewis <coltonlewis@google.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, mizhang@google.com, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	shuah@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Mark Rutland <mark.rutland@arm.com> writes:

> On Thu, Jun 26, 2025 at 08:04:43PM +0000, Colton Lewis wrote:
>> The OVSR bitmasks are valid for enable and interrupt registers as well as
>> overflow registers. Generalize the names.

>> Signed-off-by: Colton Lewis <coltonlewis@google.com>

> FWIW, this looks fine to me, so:

> Acked-by: Mark Rutland <mark.rutland@arm.com>

> Mark.

Thanks.
>> ---
>>   drivers/perf/arm_pmuv3.c       |  4 ++--
>>   include/linux/perf/arm_pmuv3.h | 14 +++++++-------
>>   2 files changed, 9 insertions(+), 9 deletions(-)

>> diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
>> index 6358de6c9fab..3bc016afea34 100644
>> --- a/drivers/perf/arm_pmuv3.c
>> +++ b/drivers/perf/arm_pmuv3.c
>> @@ -513,7 +513,7 @@ static u64 armv8pmu_pmcr_n_read(void)

>>   static int armv8pmu_has_overflowed(u64 pmovsr)
>>   {
>> -	return !!(pmovsr & ARMV8_PMU_OVERFLOWED_MASK);
>> +	return !!(pmovsr & ARMV8_PMU_CNT_MASK_ALL);
>>   }

>>   static int armv8pmu_counter_has_overflowed(u64 pmnc, int idx)
>> @@ -749,7 +749,7 @@ static u64 armv8pmu_getreset_flags(void)
>>   	value = read_pmovsclr();

>>   	/* Write to clear flags */
>> -	value &= ARMV8_PMU_OVERFLOWED_MASK;
>> +	value &= ARMV8_PMU_CNT_MASK_ALL;
>>   	write_pmovsclr(value);

>>   	return value;
>> diff --git a/include/linux/perf/arm_pmuv3.h  
>> b/include/linux/perf/arm_pmuv3.h
>> index d698efba28a2..fd2a34b4a64d 100644
>> --- a/include/linux/perf/arm_pmuv3.h
>> +++ b/include/linux/perf/arm_pmuv3.h
>> @@ -224,14 +224,14 @@
>>   				 ARMV8_PMU_PMCR_LC | ARMV8_PMU_PMCR_LP)

>>   /*
>> - * PMOVSR: counters overflow flag status reg
>> + * Counter bitmask layouts for overflow, enable, and interrupts
>>    */
>> -#define ARMV8_PMU_OVSR_P		GENMASK(30, 0)
>> -#define ARMV8_PMU_OVSR_C		BIT(31)
>> -#define ARMV8_PMU_OVSR_F		BIT_ULL(32) /* arm64 only */
>> -/* Mask for writable bits is both P and C fields */
>> -#define ARMV8_PMU_OVERFLOWED_MASK	(ARMV8_PMU_OVSR_P | ARMV8_PMU_OVSR_C  
>> | \
>> -					ARMV8_PMU_OVSR_F)
>> +#define ARMV8_PMU_CNT_MASK_P		GENMASK(30, 0)
>> +#define ARMV8_PMU_CNT_MASK_C		BIT(31)
>> +#define ARMV8_PMU_CNT_MASK_F		BIT_ULL(32) /* arm64 only */
>> +#define ARMV8_PMU_CNT_MASK_ALL		(ARMV8_PMU_CNT_MASK_P | \
>> +					 ARMV8_PMU_CNT_MASK_C | \
>> +					 ARMV8_PMU_CNT_MASK_F)

>>   /*
>>    * PMXEVTYPER: Event selection reg
>> --
>> 2.50.0.727.gbf7dc18ff4-goog


