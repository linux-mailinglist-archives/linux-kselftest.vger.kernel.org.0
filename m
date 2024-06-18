Return-Path: <linux-kselftest+bounces-12131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AD290C51F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 11:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB3501F21227
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68695155340;
	Tue, 18 Jun 2024 07:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E032c5qG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F95C13B583
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695435; cv=none; b=KRf3Nna92VsCNyMQHZf2QCVXY03u54Qr8TdcCs0szmeL2ZBgiA8QO366rUSNlYrZGXvJuPX//yoOdRCjvRpOebsK4y4N8sp7210N+ZYeQ6dT8tKN1i3q5AZ8HfGAjAaZmWzW+0OTlGzUC6SwN/hUz6/e4o5vROSywQNZE8Ndkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695435; c=relaxed/simple;
	bh=jtutfQ/YnGXYiZoliavf4txQTcAFOGOJa0KhiybXy94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpWoeOdecUIVD78CJTl0HAaN5mRS9FYIYTcK9Cy6q1psZBEF4nWhO57ceOnOCVhvcGc+sgkwsBDitAyGVsfvhAdIAtycaZpbwohMl1Hvfkrl3q/pkrezI2LjvfWuHfXaR7SHzhRzx51R5D7I3q58ka0G7pLtSGQThU4jiazOp6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E032c5qG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718695432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ektUs2o9ZwmGp4QGKP67xVqU+KCA2sw3x/s+8mFOJyU=;
	b=E032c5qG2LFD1yEBJwiOUNtLfKM3IjgLZZWWAAZxO4gAIGiOPMHJT46I1Qmj1LfNnRZdvX
	kvg3S9BxlN8HbzuOjsPmFfwRobCSFqmwkVuQpBLI+TxN1RrtawHQwUiv+PxeWwVzB4P2Av
	WOT8OvrTQC6pXwb35AlV6Ex40tmj/rw=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-gkDe2NkTOxiNlm0wzmPMng-1; Tue, 18 Jun 2024 03:23:50 -0400
X-MC-Unique: gkDe2NkTOxiNlm0wzmPMng-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2502a80477bso109265fac.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 00:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718695429; x=1719300229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ektUs2o9ZwmGp4QGKP67xVqU+KCA2sw3x/s+8mFOJyU=;
        b=jkZ1zDzLnBD2REX3RGfCIiqYfpsV5QaiMAGH0kSWK7mLOGc/tmS22R8RSGyHu7tFdD
         xV/liTyK99tawXArCxP7pcASJYKea7qQ30V0Wy/j41X9WCE/lnIPJRkgtj1Y5KE99l/y
         SEXb84bUNeJj8z8HKMUWZyaDk1IAOBQDEkJU0M6MZnEo/v7R8KmlVKoH/tSUFpoE7X4s
         85oYnxrf0ghbTULn4zJN12RWpVl2kW6vhcbLJbZmcwN7X1SOMmE9zPqLsLYkb8Is4sbr
         ztuMvK8H2Wc9NjtuHxFHPa0mPYIoIZfAFL+bSzIBijeNCgnOufLU1WBt8B15V5VqCqe7
         LtAg==
X-Forwarded-Encrypted: i=1; AJvYcCV1y/5szafeC2ncmzqVWFJYqZgSdodO9ElmA9rE0tbKUMsfGAEh7HWsRARjFsCeB9DIihPWF9C68fDp8h4yQLmQY50/SibprHjzYkT4nkd1
X-Gm-Message-State: AOJu0YztHiC0tPc9vLO/ntMQO2my/b3hbk/FHojOnSPuWPex6ur0IQdL
	qltZGHHt46BltI0P5GUftoRtGG9KZ8Ib1km6wc9tsHSZcMityqBLQKf3jFiOkY/NJVwlBJA3ZfF
	p2YMSKZr0fCbKAD3wEkyCSEAm+WbyS7HpfYyyxScZUJ9JiQ7f4M3qBSoQ+fHePcuEFQ==
X-Received: by 2002:a05:6870:9a25:b0:254:a7df:721b with SMTP id 586e51a60fabf-25842cfc466mr12492776fac.5.1718695428978;
        Tue, 18 Jun 2024 00:23:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGzh9F+irOsR5lWcnREhTCTKn/pzQg2Hw7QKb2g0z70Pr0m1XAmIppde3Pf/VUtv48DRUNuQ==
X-Received: by 2002:a05:6870:9a25:b0:254:a7df:721b with SMTP id 586e51a60fabf-25842cfc466mr12492771fac.5.1718695428566;
        Tue, 18 Jun 2024 00:23:48 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3cda1sm8387767b3a.117.2024.06.18.00.23.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:23:48 -0700 (PDT)
Message-ID: <25df0c92-8c02-4804-b4a0-7ec7a6790a89@redhat.com>
Date: Tue, 18 Jun 2024 15:23:43 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] KVM: selftests: aarch64: Add invalid filter test
 in pmu_event_filter_test
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.linux.dev, Eric Auger <eric.auger@redhat.com>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240613082345.132336-1-shahuang@redhat.com>
 <20240613082345.132336-4-shahuang@redhat.com>
 <CAJHc60xpGAA1pmz0ad_Fq3a5M-pQMiyxQ4hdNhc6vQrgpSjGww@mail.gmail.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <CAJHc60xpGAA1pmz0ad_Fq3a5M-pQMiyxQ4hdNhc6vQrgpSjGww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6/18/24 08:01, Raghavendra Rao Ananta wrote:
> Hi Shaoqin,
> 
> On Thu, Jun 13, 2024 at 1:27 AM Shaoqin Huang <shahuang@redhat.com> wrote:
>>
>> Add the invalid filter test which sets the filter beyond the event
>> space and sets the invalid action to double check if the
>> KVM_ARM_VCPU_PMU_V3_FILTER will return the expected error.
>>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
>> ---
>>   .../kvm/aarch64/pmu_event_filter_test.c       | 37 +++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>> index fb0fde1ed436..13b2f354c39b 100644
>> --- a/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>> +++ b/tools/testing/selftests/kvm/aarch64/pmu_event_filter_test.c
>> @@ -8,6 +8,7 @@
>>    * This test checks if the guest only see the limited pmu event that userspace
>>    * sets, if the guest can use those events which user allow, and if the guest
>>    * can't use those events which user deny.
>> + * It also checks that setting invalid filter ranges return the expected error.
>>    * This test runs only when KVM_CAP_ARM_PMU_V3, KVM_ARM_VCPU_PMU_V3_FILTER
>>    * is supported on the host.
>>    */
>> @@ -178,6 +179,40 @@ static void destroy_vpmu_vm(void)
>>          kvm_vm_free(vpmu_vm.vm);
>>   }
>>
>> +static void test_invalid_filter(void)
>> +{
>> +       struct kvm_pmu_event_filter invalid;
>> +       int ret;
>> +
>> +       pr_info("Test: test_invalid_filter\n");
>> +
>> +       memset(&vpmu_vm, 0, sizeof(vpmu_vm));
>> +
>> +       vpmu_vm.vm = vm_create(1);
>> +       vpmu_vm.vcpu = vm_vcpu_add_with_vpmu(vpmu_vm.vm, 0, guest_code);
>> +       vpmu_vm.gic_fd = vgic_v3_setup(vpmu_vm.vm, 1, 64);
>> +       __TEST_REQUIRE(vpmu_vm.gic_fd >= 0,
>> +                      "Failed to create vgic-v3, skipping");
>> +
>> +       /* The max event number is (1 << 16), set a range largeer than it. */
> nit: s/largeer/larger
> 
> Also, perhaps not in this series, but we can also check for -EBUSY
> situations such as setting a (valid) filter after
> KVM_ARM_VCPU_PMU_V3_INIT and after the vCPUs have started.
> 

That's also a great test, we can add it in the future.

> Besides that, Reviewed-by: Raghavendra Rao Ananta <rananta@google.com>

Thanks a lot for your reviewing.

> 
> - Raghavendra
> 
> 
> 
>> +       invalid = __DEFINE_FILTER(BIT(15), BIT(15) + 1, 0);
>> +       ret = __kvm_device_attr_set(vpmu_vm.vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
>> +                                   KVM_ARM_VCPU_PMU_V3_FILTER, &invalid);
>> +       TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter range "
>> +                   "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
>> +                   ret, errno);
>> +
>> +       /* Set the Invalid action. */
>> +       invalid = __DEFINE_FILTER(0, 1, 3);
>> +       ret = __kvm_device_attr_set(vpmu_vm.vcpu->fd, KVM_ARM_VCPU_PMU_V3_CTRL,
>> +                                   KVM_ARM_VCPU_PMU_V3_FILTER, &invalid);
>> +       TEST_ASSERT(ret && errno == EINVAL, "Set Invalid filter action "
>> +                   "ret = %d, errno = %d (expected ret = -1, errno = EINVAL)",
>> +                   ret, errno);
>> +
>> +       destroy_vpmu_vm();
>> +}
>> +
>>   static void run_test(struct test_desc *t)
>>   {
>>          pr_info("Test: %s\n", t->name);
>> @@ -300,4 +335,6 @@ int main(void)
>>          TEST_REQUIRE(kvm_pmu_support_events());
>>
>>          run_tests();
>> +
>> +       test_invalid_filter();
>>   }
>> --
>> 2.40.1
>>
>>
> 

-- 
Shaoqin


