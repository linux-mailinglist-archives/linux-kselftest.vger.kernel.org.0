Return-Path: <linux-kselftest+bounces-25359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A212BA21D1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 13:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C336D3A617F
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 12:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999881DB14C;
	Wed, 29 Jan 2025 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGV4Qk8e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1A41D9329
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738153759; cv=none; b=cz/wOr4Mmv9klr7U/Wk9+TE4n6HEomtu07dhb5Nc3kwCbT1fwW73y5AP+RbZ+2DM4Yma8Xrnb3CVtuF82S/zwwI11xfMHF6mR4utVQvYGdXJP8VuzoNmpwqlqqGnH2vNG3FdnXnvv/LVGSJPk0ldnuLXMyDop4mNVT9wiMiEZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738153759; c=relaxed/simple;
	bh=aGlAAuEIVLY1trq7D4Y9/0tyfynruVWNn7IwhthU0vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZX4682JxTtZKKRIfDG5lRBECk9T3U9SeEpYRgeOLbfFyWiWG3piDv2moidAeCQrKD5J+pVSa11yyKP6iHh5FsPCJ7Tg2a/YgGamgyMQZrOiEphHD836WfM2ydVhvBmJmyoeY76+04yI1/HJqWiIUMi4aybMU+nt8m0GYSBYIt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGV4Qk8e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738153756;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z2rZzWmBPUWvjcNF+Tp2W7jWB2lbA7lN2MnSH0V5dqM=;
	b=EGV4Qk8ehTO8IFvb0O0pkB81nogWzMaZkdxmm0XPSBSxZXk9ceZFp4rHBSwOc9NSfrCvkW
	adM6Z4dZ5q3kEDHkG1QWFe6woBB5wQoEuhG7Ku5Ts5hpzc0Z39bmvYTf9ednnAN7VCeHrY
	4SiqWmQ87YJJlnZlKCfNLHktetU/4OM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-SN88-x9SOTOE2ofQUEiGqw-1; Wed, 29 Jan 2025 07:29:15 -0500
X-MC-Unique: SN88-x9SOTOE2ofQUEiGqw-1
X-Mimecast-MFC-AGG-ID: SN88-x9SOTOE2ofQUEiGqw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385f0829430so4258907f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 04:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738153754; x=1738758554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2rZzWmBPUWvjcNF+Tp2W7jWB2lbA7lN2MnSH0V5dqM=;
        b=DL0tBF/I+LpSkuaPEZDl4PJ3KCMZzeGR2gojywgfZfVLUHeW3M8jV4G7iGwyUeUECW
         GGh2BYXAp00AGJqj2EcKbDqFGDL0nh3Kih8gn+gKOg3c1eYgbA/tSj0aZuqRyEBKPvvC
         WuAIwGmXR6MerwZT1ETCdv6CjOmBu8hOMliqoC4WKpxY0+1bj7D39UUzvROTrvRe9laR
         WqUoPepEPJW+oZG5/WUh8bPCmKOuGusm+x6mDX5H0dxjXi2RarEPaYRur0IksOSFyU00
         8HG48CbszuZIJOfqlnIlEmUgX1ZVIihuJ7dGPDJG7sUmWWpx0it2gWBSWLWmqe7Nn3Od
         p0jA==
X-Forwarded-Encrypted: i=1; AJvYcCVwuMrsw2VbhmBuy2zlqCpiCmQd39YqmanBBchV0YPOOJWyjSOzDAFjYsjRCcG6egCuzDY1hIsvtq85DGHO/jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyABDCriP1pGMOK1i5sPfad310beq05XRVi8zEn+iKIiFw/s5uY
	6yPGZteFHE6cFWItOXNGx46crn0HRlPbYl/KRl9tvP1tYwGBtJJk7jK6XeySX+/FKyfhZZjsfQF
	9DgnwMUPOZ7m+A30f4KL+AiIMMReawE9udHLL/6P4+HZlD+k7p6xbvmE73WpiUq0d6Q==
X-Gm-Gg: ASbGnctjvAk6J3HgBebIy40wI1cxWk1Nqwct1c+7/3fSBjBB5GzFqiN/VTy+ovQNldh
	NeqMnQcqphKzs79OFQPuiabLhJeCiOTjiBral8lC0/HTlbDK6C1s/SiILaLUThRqMLNfnWm/+Ux
	wGSNBsmZ8XikM941T6k9Pg7Xaas4LGUuLNlpb6C7KPQkKoaYekyhesEJyFlSmbxyGGbDgmdKCpo
	V8p+jvRGkCMG/cAM6opOCodTlbob85n8CF1OoY1qFbYEwy86CgMVvBrONPct660imL3souFFLzx
	V8rLh92U9OMKB6s0kXb2zXyjnP4MHMcz9oyHbuKJfRjnY6WjEH1P
X-Received: by 2002:a05:6000:2a6:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-38c51e95dc8mr2661424f8f.37.1738153754432;
        Wed, 29 Jan 2025 04:29:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd8a98Fk4FsyLzo/fsw4POBiKHb+ykWAZ+mPPkOyJLd/auzYk5opYB2Di0YY/K4rHi8Qvhrw==
X-Received: by 2002:a05:6000:2a6:b0:38c:2745:2df3 with SMTP id ffacd0b85a97d-38c51e95dc8mr2661397f8f.37.1738153754034;
        Wed, 29 Jan 2025 04:29:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438d7aa296esm34288705e9.1.2025.01.29.04.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 04:29:13 -0800 (PST)
Message-ID: <94a6414e-d047-41c7-b740-4b57fae0ebbb@redhat.com>
Date: Wed, 29 Jan 2025 13:29:10 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH RFCv2 03/13] iommu: Make iommu_dma_prepare_msi() into a
 generic operation
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
 <9914f9e6b32d49f74ace2200fd50583def9f15f6.1736550979.git.nicolinc@nvidia.com>
 <787fd89b-fbc0-4fd5-a1af-63dfddf13435@redhat.com>
 <20250123181657.GT5556@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250123181657.GT5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,


On 1/23/25 7:16 PM, Jason Gunthorpe wrote:
> On Thu, Jan 23, 2025 at 06:10:47PM +0100, Eric Auger wrote:
>> Hi,
>>
>>
>> On 1/11/25 4:32 AM, Nicolin Chen wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>
>>> SW_MSI supports IOMMU to translate an MSI message before the MSI message
>>> is delivered to the interrupt controller. On such systems the iommu_domain
>>> must have a translation for the MSI message for interrupts to work.
>>>
>>> The IRQ subsystem will call into IOMMU to request that a physical page be
>>> setup to receive MSI message, and the IOMMU then sets an IOVA that maps to
>>> that physical page. Ultimately the IOVA is programmed into the device via
>>> the msi_msg.
>>>
>>> Generalize this to allow the iommu_domain owner to provide its own
>>> implementation of this mapping. Add a function pointer to struct
>>> iommu_domain to allow the domain owner to provide an implementation.
>>>
>>> Have dma-iommu supply its implementation for IOMMU_DOMAIN_DMA types during
>>> the iommu_get_dma_cookie() path. For IOMMU_DOMAIN_UNMANAGED types used by
>>> VFIO (and iommufd for now), have the same iommu_dma_sw_msi set as well in
>>> the iommu_get_msi_cookie() path.
>>>
>>> Hold the group mutex while in iommu_dma_prepare_msi() to ensure the domain
>>> doesn't change or become freed while running. Races with IRQ operations
>>> from VFIO and domain changes from iommufd are possible here.
>> this was my question in previous comments
> Ah, well there is the answer :)
>
>>> Rreplace the msi_prepare_lock with a lockdep assertion for the group mutex
>> Replace
>>> as documentation. For the dma_iommu.c each iommu_domain unique to a
>> is?
>>> group.
> Yes
>
> Replace the msi_prepare_lock with a lockdep assertion for the group mutex
> as documentation. For the dmau_iommu.c each iommu_domain is unique to a
> group.
>
>>> @@ -443,6 +449,9 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>>>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>>>  	struct iommu_dma_msi_page *msi, *tmp;
>>>  
>>> +	if (domain->sw_msi != iommu_dma_sw_msi)
>>> +		return;
>>> +
>> I don't get the above check.
> It is because of this:
>
> void iommu_domain_free(struct iommu_domain *domain)
> {
> 	if (domain->type == IOMMU_DOMAIN_SVA)
> 		mmdrop(domain->mm);
> 	iommu_put_dma_cookie(domain);
>
> iommufd may be using domain->sw_msi so iommu_put_dma_cookie() needs to
> be a NOP. Also, later we move cookie into a union so it is not
> reliably NULL anymore.
OK
>
>> The comment says this is also called for a
>> cookie prepared with iommu_get_dma_cookie(). Don't you need to do some
>> cleanup for this latter?
> That seems seems OK, only two places set domain->iova_cookie:
>
> int iommu_get_dma_cookie(struct iommu_domain *domain)
> {
> 	domain->iova_cookie = cookie_alloc(IOMMU_DMA_IOVA_COOKIE);
> 	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
>
> and
>
> int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
> {
> 	domain->iova_cookie = cookie;
> 	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
>
> So (domain->sw_msi == iommu_dma_sw_msi) in iommu_put_dma_cookie() for
> both cases..
makes sense.

Thanks

Eric
>
> Jason
>


