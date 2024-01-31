Return-Path: <linux-kselftest+bounces-3815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA28F84345C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 04:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5236B1F251C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDA8F505;
	Wed, 31 Jan 2024 03:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cialewYm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E7FC17
	for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 03:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706670700; cv=none; b=XPULlmX+6fBauuIJSxSafPaeixhd+ejs1Gbr+iXSFAmu28o/W1i3KMW2mXuOqivWI22gB7N9od0MKWXiMYdNbytdo7tbPirzAr0Wl5O2JxS4Lei5qpn8XSk64ntolO4AXKCdxsrj5ZaQ+DdBFqeN0PLofiEP/KcCSy5W1ZLyRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706670700; c=relaxed/simple;
	bh=8A1sNTcqh/vi3qf/rn7lmh0Ujtt2fMYFqdqHx9tLGhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fdTcZhG30GGCNbVhi7pbv/TeamMgAMWEr3mm80+hi3zIurMMUkIlV0KqCp6yJkC7XTHxWnXVhL7zR59tXUvMXQbd7+yuNhPhvV0CVet1T0SmY4EMWedymevPTJ7tkJQVo/0bPDfsBG+OyrFj+LmD1sL8l8McoOkVYv9CZXPGyw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cialewYm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706670697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iu3CJL4LbQS98hB4MGDC78q9pGdj3UV5DPUVK7DzfMo=;
	b=cialewYmOI7mv2yx+FujmNkQumDXIc+/uzJuNFRWAy2FqV4EwZXQ4ucqZkpPaOtTuk/7mw
	lsVV0gbyEGezuQ2enxTPUn7RNdayhzSyDNyGpt5Ed5hxZzFjXCyru9LfwIe8kEytKeIgBq
	N7Fo2wtW4mLaZKyZ8x+pn42LqydGujg=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-NP90y9_bPvK-qpOVHPvBbA-1; Tue, 30 Jan 2024 22:11:35 -0500
X-MC-Unique: NP90y9_bPvK-qpOVHPvBbA-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3be75cab163so605005b6e.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 19:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706670695; x=1707275495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iu3CJL4LbQS98hB4MGDC78q9pGdj3UV5DPUVK7DzfMo=;
        b=WMimMrEONTnqS3Xks+c2/4lT2YKq4OVYGVA8LVHjL9FJ0CteXhBW6KO9RZukhAnTDo
         7ZmlF7D9S5HIV+02wlxTusYQaJHm9Qwg9h2oJhamRyesFw7zKy6vg0bHeb3dTEF90SGW
         jPEvyK0jx2A3dch3/mmGOOPcp7GmCtHCzMz5m/J0EbxOdPXELD/9rxS9lW1bE8sDozf5
         VtRnb4Xx39tmhu4WwwPnWNh5G62jdnThAd4pLfiS704E7xg/4+AlyoZ55eRxUWlXXLte
         sLT8C3yrZjqiRJV/eVVzO0D8BZ8k6QJladFJDwh/4FbLhTqGAduOCVcMqIC/W6QvGxcw
         T7Pw==
X-Gm-Message-State: AOJu0Yzx5qj8ClrUGSIA9nMTRQvPMk3RtwJBqCUmUYwpYdyqUSA4QYcO
	nlASBLpzQXhUfHHOfsH4z/30ykyxcNA6sjJgwx6P27XBt98+MONtAos5rJyX8pAxkiuCHiteI5Y
	e+0k+tEdgjiNT2wOvLPcRFymEaT2V6LbUZqDy0Xsbb+JY8zDSGicZ9bXDblMzwAqn0A==
X-Received: by 2002:a05:6808:329a:b0:3be:6bed:70af with SMTP id cg26-20020a056808329a00b003be6bed70afmr574531oib.3.1706670695144;
        Tue, 30 Jan 2024 19:11:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmfRksgT7QnfG2CN0xzUAVB0zgkTIWmjGTT9JZuTu7vPmTr2vpPAGzf5rzH88B+9ZKhzkzMg==
X-Received: by 2002:a05:6808:329a:b0:3be:6bed:70af with SMTP id cg26-20020a056808329a00b003be6bed70afmr574507oib.3.1706670694846;
        Tue, 30 Jan 2024 19:11:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWlTw1dye8bxzwmPtvq8UxMcKWb53stpiyLPATNR6iaQUszWm9J9ynFpckV3yNoZa1PI8CIknSnuWJsBwaO02BqdGhqrfursNiEOkio6a2UGvFqsVKpuU/H5CSPkl+Aa2kxjGVkGMiZrkfwq5bg8R52435X0a6KA1/AbSuJhoyQpkAD+OlfOvHsMt3eGTuITT3pZ5hRXf59RibQDhxuEv0FmCJIGONPRfRNZ93L0Oa8zSOPIpMBk7+pzBn8w2th2H5M99+zW5THY8QAvX/oZjnk9j0cijhnLF+LkcajdzOpCxzEneepW3w+i56pxirHQMbskARfpvCEAFw5kgClUG9W352XhNnU0gEOP6vKEt04bMNk8V7vkIhMeiBB+5sV09Y7rU8hpuw0ZumI+0dFILHnPHNahfEQXvzi9sFHpw==
Received: from [10.72.116.50] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p26-20020a62ab1a000000b006ddb85a61cfsm8564500pff.162.2024.01.30.19.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 19:11:34 -0800 (PST)
Message-ID: <d2d09269-30fa-461d-9461-16a1ffbde6b6@redhat.com>
Date: Wed, 31 Jan 2024 11:11:28 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] KVM: selftests: aarch64: Introduce
 pmu_event_filter_test
To: Eric Auger <eauger@redhat.com>, Oliver Upton <oliver.upton@linux.dev>,
 Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev
Cc: James Morse <james.morse@arm.com>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>
References: <20240116060129.55473-1-shahuang@redhat.com>
 <51ca8edc-81e6-4c6d-9c72-80fe59919868@redhat.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <51ca8edc-81e6-4c6d-9c72-80fe59919868@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Eric,

On 1/26/24 18:25, Eric Auger wrote:
> Hi Shaoqin,
> 
> On 1/16/24 07:01, Shaoqin Huang wrote:
>> The test is inspired by the pmu_event_filter_test which implemented by x86. On
>> the arm64 platform, there is the same ability to set the pmu_event_filter
>> through the KVM_ARM_VCPU_PMU_V3_FILTER attribute. So add the test for arm64.
>>
>> The series first move some pmu common code from vpmu_counter_access to
>> lib/aarch64/vpmu.c and include/aarch64/vpmu.h, which can be used by
>> pmu_event_filter_test. Then fix a bug related to the [enable|disable]_counter,
>> and at last, implement the test itself.
> which branch does it apply on? I fail to apply on top on main.
> 
> Or can you provide a branch?

This was based on v6.7.

> 
> Eric
>>
>> Changelog:
>> ----------
>> v2->v3:
>>    - Check the pmceid in guest code instead of pmu event count since different
>>    hardware may have different event count result, check pmceid makes it stable
>>    on different platform.                        [Eric]
>>    - Some typo fixed and commit message improved.
>>
>> v1->v2:
>>    - Improve the commit message.                 [Eric]
>>    - Fix the bug in [enable|disable]_counter.    [Raghavendra & Marc]
>>    - Add the check if kvm has attr KVM_ARM_VCPU_PMU_V3_FILTER.
>>    - Add if host pmu support the test event throught pmceid0.
>>    - Split the test_invalid_filter() to another patch. [Eric]
>>
>> v1: https://lore.kernel.org/all/20231123063750.2176250-1-shahuang@redhat.com/
>> v2: https://lore.kernel.org/all/20231129072712.2667337-1-shahuang@redhat.com/
>>
>> Shaoqin Huang (5):
>>    KVM: selftests: aarch64: Make the [create|destroy]_vpmu_vm() public
>>    KVM: selftests: aarch64: Move pmu helper functions into vpmu.h
>>    KVM: selftests: aarch64: Fix the buggy [enable|disable]_counter
>>    KVM: selftests: aarch64: Introduce pmu_event_filter_test
>>    KVM: selftests: aarch64: Add invalid filter test in
>>      pmu_event_filter_test
>>
>>   tools/testing/selftests/kvm/Makefile          |   2 +
>>   .../kvm/aarch64/pmu_event_filter_test.c       | 255 ++++++++++++++++++
>>   .../kvm/aarch64/vpmu_counter_access.c         | 218 ++-------------
>>   .../selftests/kvm/include/aarch64/vpmu.h      | 135 ++++++++++
>>   .../testing/selftests/kvm/lib/aarch64/vpmu.c  |  74 +++++
>>   5 files changed, 490 insertions(+), 194 deletions(-)
>>   create mode 100644 tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>>   create mode 100644 tools/testing/selftests/kvm/include/aarch64/vpmu.h
>>   create mode 100644 tools/testing/selftests/kvm/lib/aarch64/vpmu.c
>>
> 

-- 
Shaoqin


