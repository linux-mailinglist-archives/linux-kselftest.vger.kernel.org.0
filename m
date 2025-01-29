Return-Path: <linux-kselftest+bounces-25358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2A0A21CF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 13:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2075618875E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 12:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2511D9346;
	Wed, 29 Jan 2025 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ir5WDZu1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F81D63CE
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738152674; cv=none; b=W9xaIZc1jCDAvfVoTeaSF1jZdClkzZhBePPCtfAcODxs84g0aFVl/dCyqfAD5W2SgKIxXoJh4IKhdndZcYFgx6prIC/dpPWY3SvOCCO89RxD6eNgGFqOp9y0vEABm/k91S01Rg092jTcmzIKXWqErs0WDv/bP85tqAoJ8pwNPNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738152674; c=relaxed/simple;
	bh=6IdA7SqmTNXeAUkejuPdnOPZIQXSzN75bEY9k/EhdgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bzh+4uD0Ml06RfTMyfs8RpDUrhQUwS/DIeEtcXKOEv0O9VEfx4zKPSP1F0Sje0e1Tx95t7LyAz4z0uSEDWVQKypGcnlKh8Oiz6aGouTaQwoYEl1kWEfFUPhW9BhhB0NimFdzFC9aNdKsiotoqvk6nwQhEIFjYsTR7XQVaq1v3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ir5WDZu1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738152671;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FfYT43qInjD7+NE+73mPjG28PGMRFzMEZ6xoue/ST5Q=;
	b=ir5WDZu1E2XC2kFyD1y6DjnX5k67KU3J8HPHwoYg9O0jwLQLkp82fskNYFQix6sE7wHUoV
	sDiZKCbdY5WdLxxKjTF5+Rhk4qwAL72yswApb7hYz957UEo7omf5N1OY11sGnG12p+H2CM
	Rr/NMfqN2eVhoS5vMYbW3K3A/W0iEVM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-Jt8xKNfqPxK8YXgdPoAYCg-1; Wed, 29 Jan 2025 07:11:10 -0500
X-MC-Unique: Jt8xKNfqPxK8YXgdPoAYCg-1
X-Mimecast-MFC-AGG-ID: Jt8xKNfqPxK8YXgdPoAYCg
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d9e4d33f04so6101080a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 04:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738152669; x=1738757469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfYT43qInjD7+NE+73mPjG28PGMRFzMEZ6xoue/ST5Q=;
        b=wFZEvDXjvNmMj0+oKvlB3FMqIh/jQ/0A52cbUkSNvAUXEZHs0NxGQ4ZYTyWMf7NF3l
         YpeoG9IBhi4RULVx+JyBNjeUQYFZzwQRRLLj1xVFFtvL4EmPv9E0ue4KTWnHAOOxw08T
         R2a9dP3L4xrvWHHELzP4SEoRhqJGCznbufmxvQ82uELfu40EvaCwCFPq9+MQlE8KTYPV
         GF8r+0n8IdEH6u+tOkgp5h0ys1S81J59tQoqoKRS0gJ+YKyrtvLYQurYHsHvzDiJR1Pf
         Bkq+BPbHbTD79tIZ9L2pCQzpThZ8Frrjxlq6jziMjbrspynmHhNydTOyR1JqhhkNXQji
         0EnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX29NkLwrdSBdah3u7rQmgnAxo9trAXcQ9AgpfnBcGSvwHMqYsNYCUgwVUzDwoOzCz3+GtS9mtqHy7tsp4v0Lc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+DCogp8AXhgpfui/x02fiZtvv1EjuOHVI2wFIOTFovOG/kbKK
	H6T5/XAQIcxirdqOcmvqGnqM1Al3LaB+L+eKSBCwrLrsKKuoutuSm7t4wH2Vo2n0Y/i1qj7VFGW
	VL9zpZwa/cPFl6qiP8h2ecxk6Gtbwltg/hU2fkv95sYVBa+86l/gS6FTZ0OraDUCsSQ==
X-Gm-Gg: ASbGncuzIkazTXBvKksi76ckPPUwaUiZY5fmDZjzYt8jE72xPMM2/dNlXz2f6kK41Up
	4D98kngw4p8+td2roPfGm3l0WaBlNkaYBhoL7ES9oQdnc8EOlK+Nmy9nq7qpz4IO/lOwLG6hDXs
	a73OEJN2zix9q0hW62985vJ6hLqSv3rqLYTz73Q7btOnmW5Pvngk9DxZ0gmAwVwTt7tTiq39ZLl
	fBz1V93cruEVqEzzXMl1B9eV6F52PhjeZ0OMiSSeJ0kS1gWcJAvHBLTEfpln1LJgb1UbWM+lP0g
	AeDVTZYw4ET20ORfG0ILOYMXbOVps8JIoYzrzfhaLYucH+BVQlP8
X-Received: by 2002:a05:6402:42d4:b0:5d9:a54:f8b4 with SMTP id 4fb4d7f45d1cf-5dc5efbf5bamr2757082a12.11.1738152669152;
        Wed, 29 Jan 2025 04:11:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWwGofFlveJZZ8Y8RCQ261keTvS+w2IGgafzQLJiEPoI+LUqDstLACEsFV9aVwDeaatRYmZg==
X-Received: by 2002:a05:6402:42d4:b0:5d9:a54:f8b4 with SMTP id 4fb4d7f45d1cf-5dc5efbf5bamr2757022a12.11.1738152668668;
        Wed, 29 Jan 2025 04:11:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc1863978asm8680072a12.33.2025.01.29.04.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 04:11:06 -0800 (PST)
Message-ID: <38896dfc-b5d9-4efd-8aff-bbe8cdb47c6e@redhat.com>
Date: Wed, 29 Jan 2025 13:11:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH RFCv2 01/13] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com, tglx@linutronix.de,
 maz@kernel.org, alex.williamson@redhat.com, joro@8bytes.org,
 shuah@kernel.org, reinette.chatre@intel.com, yebin10@huawei.com,
 apatel@ventanamicro.com, shivamurthy.shastri@linutronix.de,
 bhelgaas@google.com, anna-maria@linutronix.de, yury.norov@gmail.com,
 nipun.gupta@amd.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
 jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
 shameerali.kolothum.thodi@huawei.com, smostafa@google.com, ddutile@redhat.com
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <671b2128c193fc9ac9af0f4add96f85a785f513a.1736550979.git.nicolinc@nvidia.com>
 <1b48e138-3134-442a-9796-e3a33b106221@redhat.com>
 <20250123184855.GU5556@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250123184855.GU5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,


On 1/23/25 7:48 PM, Jason Gunthorpe wrote:
> On Thu, Jan 23, 2025 at 06:10:48PM +0100, Eric Auger wrote:
>
>>> However iommufd now permits the domain to change while the driver is
>>> probed and VFIO userspace can create races with IRQ changes calling
>>> iommu_dma_prepare/compose_msi_msg() and changing/freeing the iommu_domain.
>> and is it safe in iommu_dma_prepare_msi()?
> iommu_dma_prepare_msi() takes the group mutex:
>
> int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
> {
> 	struct device *dev = msi_desc_to_dev(desc);
> 	struct iommu_group *group = dev->iommu_group;
>
> 	mutex_lock(&group->mutex);
> 	if (group->domain && group->domain->sw_msi)
> 		ret = group->domain->sw_msi(group->domain, desc, msi_addr);
>
> Which prevents changing domain attachments during execution.
>
> For iommufd, if the domain attachment changes immediately after
> iommu_dma_prepare_msi() unlocks, then the information given to
> msi_desc_set_iommu_msi_iova() is still valid on the new domain.
>
> This is because the iommufd implementation of sw_msi keeps the same
> IOVA for the same ITS page globally across all domains. Any racing
> change of domain will attach a new domain with the right ITS IOVA
> already mapped and populated.
> It is why this series stops using the domain pointer as a cookie
> inside the msi_desc, immediately after the group->mutex is unlocked
> a new domain can be attached and the old domain can be freed, which
> would UAF the domain pointer in the cookie.
OK thank you for the clarification
>
>>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>>> index b10093c4d00e..d442b4a69d56 100644
>>> --- a/include/linux/msi.h
>>> +++ b/include/linux/msi.h
>>> @@ -184,7 +184,8 @@ struct msi_desc {
>>>  	struct msi_msg			msg;
>>>  	struct irq_affinity_desc	*affinity;
>>>  #ifdef CONFIG_IRQ_MSI_IOMMU
>>> -	const void			*iommu_cookie;
>> you may add kernel doc comments above
> I wondered if internal stuff was not being documented as the old
> iommu_cookie didn't have a comment..
>
> But sure:
>
>  * @iommu_msi_iova: Optional IOVA from the IOMMU to overide the msi_addr.
>  *                  Only used if iommu_msi_page_shift != 0
>  * @iommu_msi_page_shift: Indicates how many bits of the original address
>  *                        should be preserved when using iommu_msi_iova.
Sounds good

Eric
>
> Jason
>


