Return-Path: <linux-kselftest+bounces-7215-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11C7898CB5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 18:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0FCB26311
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 16:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD55712D75D;
	Thu,  4 Apr 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F0X3Aebe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F512D1EA
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712249655; cv=none; b=ahQv4T5TDtW9ai3CnWlLOqtZVmpL4ldd6E9pRc39XbY2XeR8DVaYbFfaO6p993O3WenrIG9i5CZwyohpX+KAEfDwmf1RTJy5k51SDeQBiqkNuCtEVEp68cYTm4V21jZYXIq3P4aQDb5jXHq3rORzxLskxK8QL+cMb0XF0rD8rVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712249655; c=relaxed/simple;
	bh=lQXxyaAh1yfepGvWX1Dxa3BYz89/8nOI90HRYgFhJjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzAhbQoTR6UcngJ6Om6dxDfU4wlgCHAPoKSapEbUzqUVzNVBHn9xsdzpPByxmG+JY8wluWXuPdi+pKIkFviUwTi5P9GUHq9GPUBTDhrVfe6KIUbjZ6Sbr0nbUmV1KlrejNf8m3J8glAwLBmZPEHz4Z9fZn8XGVGETMbBQHRMcUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F0X3Aebe; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36990f24098so37605ab.0
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 09:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712249653; x=1712854453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mbKbff6IZcMe7tMchG80ujSCo/40juHuTAkwW5EuY0s=;
        b=F0X3Aebe9NyQCOC/I4YAA4IVCOMFwL+tyiSU4HIy03qTwfxTQlc65pKNF7IBbQJ5JF
         +XpYJ5XHseqtB7RUvsTfeFQTeUeZkcJwmN9uv3XlBN4nfOsSbhPdrsu/uKfemAIz6EBq
         UKhUSzotn5VVmSiGxqSLD5Ck9tWE+1WEzQfyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712249653; x=1712854453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbKbff6IZcMe7tMchG80ujSCo/40juHuTAkwW5EuY0s=;
        b=VgUad62lE9g0vhbRAbo/vk4sN2XL+UhTRMQacQbpaIOniWgrcGbAn/0JGOJvnr8TB4
         8RGGmBgSzTUP0jPK+RMmG9TlnpdEvf+ejzVyFxta1GglXfY4di3o3NmfKbo/98yPm3fN
         InXUmTz/WBo7S+OCQv9NoERk+AOoDtiIkDoNrZj421GQ87GXytTQfpD90MDnWuMbIO3L
         16Eo+o4WkNDrRboyPFcbcWxgDKfKio3iWKbv8xi6MLLcUgEbT9k3Y/OaeLX2c79JUIQG
         jx4lDiBLXv8460iIaLNUNPRpxbOhxxpi+Mzmuuz2mdiRvftajl0hR5CVhtmHIgPxl1hj
         gw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrGp3trs3pbvNtSQpbOUFykchc+goIAhGMH4OVVYy3Fm5wfTQDhHSc+soIeiSyTSOm7OYxvLpqV2udbXxEXcFhixoXX1rp5//orGA/t37h
X-Gm-Message-State: AOJu0Yz0fE6iXCKIZBrZzQXtAd1dMhSV9PdxscSta/dToQbHOGxXNTPv
	ke0zn+deP8mnZCVC20DDdSRbJv8seMNXPkU/C3K9fIT5diMIUfcb7cvN/cbxOmc=
X-Google-Smtp-Source: AGHT+IFIoeSIptPcK/ZIht/gxDhBth3YhYHyf8Hmsc8CO9peKgWubokh48VKo1WOettsk1NRD6I0ng==
X-Received: by 2002:a05:6e02:541:b0:368:efa4:be12 with SMTP id i1-20020a056e02054100b00368efa4be12mr3434944ils.3.1712249653087;
        Thu, 04 Apr 2024 09:54:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id j3-20020a92c203000000b00369bb06ae5dsm1081324ilo.25.2024.04.04.09.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 09:54:12 -0700 (PDT)
Message-ID: <e565670b-d31e-48fa-a873-6c68dba5b04b@linuxfoundation.org>
Date: Thu, 4 Apr 2024 10:54:12 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] seltests/iommu: runaway ./iommufd consuming 99% CPU after a
 failed assert()
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
 Joao Martins <joao.m.martins@oracle.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <0d5c3b29-fc5b-41d9-9556-5ce94262dac8@alu.unizg.hr>
 <20240319135852.GA393211@nvidia.com>
 <a692d5d7-11d5-4c1b-9abc-208d2194ccde@alu.unizg.hr>
 <cdc9c46b-1bad-41cd-8f98-38cc2171186a@oracle.com>
 <20240325135207.GC6245@nvidia.com>
 <f8e03425-98cf-4076-8959-d85eda846bab@oracle.com>
 <08a13b79-e94a-4f80-96e9-ce223d928b3e@alu.unizg.hr>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <08a13b79-e94a-4f80-96e9-ce223d928b3e@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/27/24 14:04, Mirsad Todorovac wrote:
> 
> 
> On 3/27/24 11:41, Joao Martins wrote:
>> On 25/03/2024 13:52, Jason Gunthorpe wrote:
>>> On Mon, Mar 25, 2024 at 12:17:28PM +0000, Joao Martins wrote:
>>>>> However, I am not smart enough to figure out why ...
>>>>>
>>>>> Apparently, from the source, mmap() fails to allocate pages on the desired address:
>>>>>
>>>>>    1746         assert((uintptr_t)self->buffer % HUGEPAGE_SIZE == 0);
>>>>>    1747         vrc = mmap(self->buffer, variant->buffer_size, PROT_READ |
>>>>> PROT_WRITE,
>>>>>    1748                    mmap_flags, -1, 0);
>>>>> → 1749         assert(vrc == self->buffer);
>>>>>    1750
>>>>>
>>>>> But I am not that deep into the source to figure our what was intended and what
>>>>> went
>>>>> wrong :-/
>>>>
>>>> I can SKIP() the test rather assert() in here if it helps. Though there are
>>>> other tests that fail if no hugetlb pages are reserved.
>>>>
>>>> But I am not sure if this is problem here as the initial bug email had an
>>>> enterily different set of failures? Maybe all you need is an assert() and it
>>>> gets into this state?
>>>
>>> I feel like there is something wrong with the kselftest framework,
>>> there should be some way to fail the setup/teardown operations without
>>> triggering an infinite loop :(
>>
>> I am now wondering if the problem is the fact that we have an assert() in the
>> middle of FIXTURE_{TEST,SETUP} whereby we should be having ASSERT_TRUE() (or any
>> other kselftest macro that). The expect/assert macros from kselftest() don't do
>> asserts and it looks like we are failing mid tests in the assert().
>>
>> Maybe it is OK for setup_sizes(), but maybe not OK for the rest (i.e. during the
>> actual setup / tests). I can throw a patch there to see if this helps Mirsad.
> 
> Well, we are in the job of making the kernel better and as bug free as we can.
> 
> Maybe we should not delve too much into detail: is this a kernel bug, or the kselftest
> program bug?
> 
> Some people already mentioned that I might have sysctl variable problems. I don't see
> what the mmap() HUGEPAGE allocation at fixed address was meant to prove?
> 

I applied fix to this problem to linux-kselftest fixes branch for next rc.
Please give it a try.

thanks,
-- Shuah


