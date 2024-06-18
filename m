Return-Path: <linux-kselftest+bounces-12130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2A090C47A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 09:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B401281214
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 07:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA53D13A417;
	Tue, 18 Jun 2024 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+J5XUH0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A15A13A3E2
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695237; cv=none; b=RNkoqSExsGRhysBAUaLAhHYwpjEgVkntz3mIDMpLwX6iklIEMofQT3pDMP6ozBN5hpvYk8Y+NVCULrTJV+a+/qRP+GWSgkVsnk7g9TcHs6/8EmuxfoDuWZnbVJwCl2pCF2TbHghARW+h3V3f8RZoNEm87UKEFsRNaWK0LKojNFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695237; c=relaxed/simple;
	bh=7+n3kW2jaX5vi3EV2n3+TXiAkc91JFM8ynm4fYCf7SU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ubn9IBhKW0QqdHshCFxMx+WbjtBdBCl0I75segB42ecDjfMV15BRwZRihmi+Dirb55KTwvOaPKGQR30G75srhVQix3zytyvSI54mdzPe5Vg+ZjCqXmQRwBgFJJz5ngq/u0NPCtl4o/rIAE5zbiZnj8kTY9Zz/U0VyhgtHANnHTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+J5XUH0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718695234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+MZvD0c6jZAbOwtBsBdVea8BAt9Pk1x19oYnj2/Pfs=;
	b=S+J5XUH0rqu38cbNXIf8IwgBF1G3UvMlsQcV9wh36ioRaPeVdqyJ/DoQfTUXmco/jrgLyg
	AWBFwxlRBeZ0yNgrYKNDfdLaChkxBO0L8qJvh0VbmKATuuEMHdiVLs7y31vjDGyJF+pFNN
	cQGkPe0XuGi6owXW8rZrD6sRcAggcw0=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-IWwArEGqMxWrTeaohg_CKg-1; Tue, 18 Jun 2024 03:20:33 -0400
X-MC-Unique: IWwArEGqMxWrTeaohg_CKg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-25989a3969dso7556fac.1
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 00:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718695233; x=1719300033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+MZvD0c6jZAbOwtBsBdVea8BAt9Pk1x19oYnj2/Pfs=;
        b=FFRi0dWVhaW+cVypRIgiECXZqa2r+8YLhvsqEjNBtREueGK+bsMsTtHhqcE/pGMMdv
         I5znNYFvDhaSq19XuNwXH84ne0whG1j/8q2sPb1arYjYXt9A6CR7yq7oa4Zo0KhoqPHj
         9hfUnUCrvw0Jy8OvhDvw3+qB37Fyw7y38t6WnhwEOJt2IQ5N1S42uNKK/NJYjUOgjihq
         SB7z6ja1iLP4n85jne5sgHfwwbetfj13Pu0MXpW1foVRJR+5cd3NAzdlJZHIeFMOOfdJ
         2Yzd3o4HHkFJ0eF6uE4pXyKA4NmwAck9bHGP0Cj+xu3JVWh2L+8Bu3P/dQA/QtoQllIR
         OLiA==
X-Forwarded-Encrypted: i=1; AJvYcCWKWlIpuiqFZFFuwIlysPFzkjeab3oormQZiNs30T7SNJPgUsaUyHActUU/TI3/Prmc5ad/1jL6oOhOkKo5rTLYKQM70LJ0NxBwYZGuqY3G
X-Gm-Message-State: AOJu0YxxRNCdCIgiwsQ+RNQpmPR6dRuCuEa6ZQEIEBxC4pfRZ6UAY4EV
	WWNKvqFs5P95pREothLTeTOLXnDAynD4hhZWnLhycZzoEYvCYX/WMxQaA4QNO7HnA4Iryf42VVg
	/Rep3f+FCdiBNrkkx0TeYJLWFx6JFJHWhzbIawt4YYDV5DKYjTY5rUAjskH+25Ax5Iw==
X-Received: by 2002:a05:6870:472c:b0:254:abd6:1a3d with SMTP id 586e51a60fabf-25842c4d336mr12855720fac.4.1718695232657;
        Tue, 18 Jun 2024 00:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOPqkcgbIKP9DQkszgI9BP4bpi27+YzHI5LkL7RDuPvbhH5VsAbpRdW0WQgV71WAmyOeyUHw==
X-Received: by 2002:a05:6870:472c:b0:254:abd6:1a3d with SMTP id 586e51a60fabf-25842c4d336mr12855697fac.4.1718695232295;
        Tue, 18 Jun 2024 00:20:32 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91dd11sm8363871b3a.43.2024.06.18.00.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:20:31 -0700 (PDT)
Message-ID: <7617ca12-6538-4638-a2ab-a90d06a3a7f0@redhat.com>
Date: Tue, 18 Jun 2024 15:20:27 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] KVM: selftests: aarch64: Introduce
 pmu_event_filter_test
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
 kvmarm@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
 Shuah Khan <shuah@kernel.org>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240613082345.132336-1-shahuang@redhat.com>
 <20240613082345.132336-3-shahuang@redhat.com>
 <CAJHc60y67Be=XcJuy__2RN43WyN6YgukSAb0=T6TGwYHw+YpHg@mail.gmail.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <CAJHc60y67Be=XcJuy__2RN43WyN6YgukSAb0=T6TGwYHw+YpHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Raghavendra,

Thanks for helping review this series.

On 6/18/24 08:01, Raghavendra Rao Ananta wrote:
> Hi Shaoqin
> 
> 
> On Thu, Jun 13, 2024 at 1:28 AM Shaoqin Huang <shahuang@redhat.com> wrote:
> 
>> +static void prepare_expected_pmce(struct kvm_pmu_event_filter *filter)
>> +{
>> +       struct pmu_common_event_ids pmce_mask = { ~0, ~0 };
>> +       bool first_filter = true;
>> +       int i;
>> +
>> +       while (filter && filter->nevents != 0) {
> Do you also want to add a check to ensure we aren't running over
> FILTER_NR (I'd expect a compiler warning/error though)?

The FILTER_NR is only used to assign the length of the filter array, if 
the defined filter array length is larger than the FILTER_NR, I believe 
there will be a compiling warning.

> 
>> +               if (first_filter) {
>> +                       if (filter->action == KVM_PMU_EVENT_ALLOW)
>> +                               memset(&pmce_mask, 0, sizeof(pmce_mask));
>> +                       first_filter = false;
>> +               }
> nit: Probably we can make the 'first_filter' part a little cleaner by
> checking this outside the loop.
> 
> if (filter && filter->action == KVM_PMU_EVENT_ALLOW)
>          memset(&pmce_mask, 0, sizeof(pmce_mask));
> 
> while (filter && filter->nevents != 0) {
>      ...
> }

Thanks, this looks much better and I will change the code to it.

> 
>> +static struct test_desc tests[] = {
>> +       {
>> +               .name = "without_filter",
>> +               .filter = {
>> +                       { 0 }
>> +               },
>> +       },
>> +       {
>> +               .name = "member_allow_filter",
>> +               .filter = {
>> +                       DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_SW_INCR, 0),
> In terms of readability, do you think it's better to use
> KVM_PMU_EVENT_{ALLOW|DENY}, instead of 0 and 1?
> 
> Or, if that's coming out to be too long, may be create another wrapper
> over DEFINE_FILTER, and simply use that in the array:
> 
> #define EVENT_ALLOW(event) DEFINE_FILTER(event, KVM_PMU_EVENT_ALLOW)
> #define EVENT_DENY(event) DEFINE_FILTER(event, KVM_PMU_EVENT_DENY)
> 
> .filter = {
>      EVENT_ALLOW(ARMV8_PMUV3_PERFCTR_SW_INCR),
> 

Pretty good idea. I will take your code which looks much clean.

>> +                       DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_INST_RETIRED, 0),
>> +                       DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_BR_RETIRED, 0),
>> +                       { 0 },
>> +               },
>> +       },
> 
>> +       {
>> +               .name = "cancel_filter",
>> +               .filter = {
>> +                       DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 0),
>> +                       DEFINE_FILTER(ARMV8_PMUV3_PERFCTR_CPU_CYCLES, 1),
>> +               },
> Since the initial filter map depends on the event being allowed or
> denied, do you think another "cancel_filter" case to first deny and
> then allow would also be better?

Yes. That would be better, I will add another test which first deny and 
then allow it.

> 
>> +       },
>> +       {
>> +               .name = "multiple_filter",
>> +               .filter = {
>> +                       __DEFINE_FILTER(0x0, 0x10, 0),
>> +                       __DEFINE_FILTER(0x6, 0x3, 1),
>> +               },
>> +       },
>> +       { 0 }
>> +};
>> +
>> +static void run_tests(void)
>> +{
>> +       struct test_desc *t;
>> +
>> +       for (t = &tests[0]; t->name; t++)
>> +               run_test(t);
>> +}
>> +
>> +int used_pmu_events[] = {
> nit: static int used_pmu_events[] = {
> 

Got it.

Thanks,
Shaoqin

> Thank you.
> Raghavendra
> 
> 
>> +       ARMV8_PMUV3_PERFCTR_BR_RETIRED,
>> +       ARMV8_PMUV3_PERFCTR_INST_RETIRED,
>> +       ARMV8_PMUV3_PERFCTR_CHAIN,
>> +};
>> +
>> +static bool kvm_pmu_support_events(void)
>> +{
>> +       struct pmu_common_event_ids used_pmce = { 0, 0 };
>> +
>> +       create_vpmu_vm(guest_get_pmceid);
>> +
>> +       memset(&max_pmce, 0, sizeof(max_pmce));
>> +       sync_global_to_guest(vpmu_vm.vm, max_pmce);
>> +       run_vcpu(vpmu_vm.vcpu);
>> +       sync_global_from_guest(vpmu_vm.vm, max_pmce);
>> +       destroy_vpmu_vm();
>> +
>> +       for (int i = 0; i < ARRAY_SIZE(used_pmu_events); i++)
>> +               set_pmce(&used_pmce, KVM_PMU_EVENT_ALLOW, used_pmu_events[i]);
>> +
>> +       return ((max_pmce.pmceid0 & used_pmce.pmceid0) == used_pmce.pmceid0) &&
>> +              ((max_pmce.pmceid1 & used_pmce.pmceid1) == used_pmce.pmceid1);
>> +}
>> +
>> +int main(void)
>> +{
>> +       TEST_REQUIRE(kvm_has_cap(KVM_CAP_ARM_PMU_V3));
>> +       TEST_REQUIRE(kvm_pmu_support_events());
>> +
>> +       run_tests();
>> +}
>> --
>> 2.40.1
>>
>>
> 

-- 
Shaoqin


