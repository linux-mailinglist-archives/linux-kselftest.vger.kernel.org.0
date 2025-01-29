Return-Path: <linux-kselftest+bounces-25388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AD4A22358
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D327167E09
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 17:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E24D1DFE16;
	Wed, 29 Jan 2025 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCqNayps"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1251DF744
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738172971; cv=none; b=feCXxyKxAVXjmS0IQNvzby3unQEknVo6b/Z59iTyJwYJYwipDIb0gcuHlTYnViLCUAwsni6LzXpIxHb4aF2AF39jsR+n8oUUBm1U1OK5vs0ZhpVrxcCdW/5TRja3OkNFG1/2JOEYBAvvr9BwjTAjVBN5CJyAbuXi/lOnCQ5pB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738172971; c=relaxed/simple;
	bh=SQp3BHkMy88E/WG6aAfa1dNn4Op9EZoCx4scO6iPQm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZXig39AezDyWrb7x5KOBogyya/wYARS8DhX/YBNKcLRBVfp7IwudQab0avfy/w18bLIGc1YWN+YgYIk5Rx2Kz+D1BbIQqUgUBcM1rark1nBwUq8l6b0QpqKJZ8BnrnSFrj8Yyl7ZzAEMo/IH2zwfzrX32oQQi0/Z75DfYgQ+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCqNayps; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738172968;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxbyXuurc0dvUCpLFnEXoKIL7HoI7M2OYxW0aVnbFr4=;
	b=MCqNaypsSaPTi+c3BmEtDLd4fat9cTJA4RGJgRNM80RpOSRu39OMe9meaEmtaw5Z+Z5Bf8
	KKEYM6bz9EqNPVZ6KU904unco4+yyTgeeL4vUCCCLBFnD19FaWmdADsiwwljvViXOUsZmo
	Mrqsg2VtIoILOvhc+QY+CE9xqllD0t0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-Zcx2Nb5rOMS1a3quO4tRcA-1; Wed, 29 Jan 2025 12:49:27 -0500
X-MC-Unique: Zcx2Nb5rOMS1a3quO4tRcA-1
X-Mimecast-MFC-AGG-ID: Zcx2Nb5rOMS1a3quO4tRcA
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38c24ac3706so5456913f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 09:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738172966; x=1738777766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxbyXuurc0dvUCpLFnEXoKIL7HoI7M2OYxW0aVnbFr4=;
        b=NH/t9tgLZch6WnYnLqKVMIhgbDnmiawGMedLsV4VKgIHJPmGxz2xsbK6GF22iy2rjo
         oG+dWpwrhYA9jokBC9KedNn1eqQXZyCjRsbuDKFjwmUTpfLkuZ4ybDoVJVRmhNegxlG1
         yPMXNvb9A3iqFjHds9M+IUGD7yr+IUurLcgJRA32QsvgaB0A2+/wgj6AOD5UX4EMzYgh
         9lLUXJxpd0gsTGpl451VGix0FsY83ocp80Qebq/yewvXVOGTOsuSS41Gtk+abtY6qU2E
         qcvwm0tFesKx6M41mvbqxo2IXLs3btP7ckuTPg/UMi2GbQnwf1zynudi8iGER8hQP0fZ
         Vw7g==
X-Forwarded-Encrypted: i=1; AJvYcCWi5OZ9+AbXL8AdC1Gz/NMS+UOBx316nxAbQZqwvvgqRCd/qJdj/zC7kpVZ0I2ACVcsF31T7m0unFMtevg8Y4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJCc3vOkdgvjLXK5KtZJqy3WXsyGcrvk97/6Kduy0u6YZltgK
	SZfvoO/2iewYLABrxmUr5qeRYokoOVtpd6bRSnQu3wIsiy+MIhtiuYoJUONJadKnipiq8NPmaxw
	4nld9s5PELrLDOMGAyxtL6Kwq3L6xHcruTpixf5bdgUphBOumioAzi6v/RyJF7lIiSg==
X-Gm-Gg: ASbGnctST7DiWPNRkcaRK3k4MCP0uDEP1xOmGbN9Plk/E/yE8FpgkzRacb91nDQFNTJ
	RCO8JY/L8RlXkv1/dT0kCRDNt69R2EhlLPlVioxFk7dOVRmz7dPZ6BuXOqJB2CSERN1EFCAAfRy
	R6pkn0GlhR5AflPqB9xrb1BClgVFhqSjJjAlY7C2a+oVj1s6gWckZYKXg+/t3Aa9PbnubWKai0P
	ABXa1toZJ8JD3naFiEu35xN9bWSb47ETYGYL/2xeE8nTPD+iKRdJKMImFUn5yrf8bhPVxZezJOD
	qaEdV7BUvzzB5LtniJ66IP8MEqB56lKkoKicyamGctG4w3DGC5lM
X-Received: by 2002:a05:6000:2a9:b0:385:eb85:f111 with SMTP id ffacd0b85a97d-38c51960449mr4176488f8f.14.1738172965845;
        Wed, 29 Jan 2025 09:49:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZcuNSD2hPNqWa4PCH0KoHBYwz7G9outfVdx7sBB1yVqyndStjqCH81h7BEeHjltUf96/lwQ==
X-Received: by 2002:a05:6000:2a9:b0:385:eb85:f111 with SMTP id ffacd0b85a97d-38c51960449mr4176452f8f.14.1738172965407;
        Wed, 29 Jan 2025 09:49:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438d7aa605asm39995085e9.1.2025.01.29.09.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 09:49:24 -0800 (PST)
Message-ID: <6f630a23-e1b5-48de-81a6-43cbb1e6cabd@redhat.com>
Date: Wed, 29 Jan 2025 18:49:22 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH RFCv2 09/13] iommufd: Add IOMMU_OPTION_SW_MSI_START/SIZE
 ioctls
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
 <d3cb1694e07be0e214dc44dcb2cb74f014606560.1736550979.git.nicolinc@nvidia.com>
 <0521187e-c511-4ab1-9ffa-be2be8eacd04@redhat.com>
 <20250129145800.GG5556@nvidia.com>
 <21ac88b0-fe93-4933-893c-7ffb09267e7b@redhat.com>
 <20250129173909.GI5556@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250129173909.GI5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit




On 1/29/25 6:39 PM, Jason Gunthorpe wrote:
> On Wed, Jan 29, 2025 at 06:23:33PM +0100, Eric Auger wrote:
>>>> IIUC the MSI window will then be different when using legacy VFIO
>>>> assignment and iommufd backend.
>>> ? They use the same, iommufd can have userspace override it. Then it
>>> will ignore the reserved region.
>> In current arm-smmu-v3.c you have
>>         region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
>>                                          prot, IOMMU_RESV_SW_MSI,
>> GFP_KERNEL);
>>
>> in arm_smmu_get_resv_regions()
>> If you overwrite the default region, don't you need to expose the user
>> defined resv region?
> If it was overriden inside iommufd then the user told the kernel what
> range to use to override it. I don't need to go back and report back
> to userspace information that it already gave to the kernel..

Looks strange to me because info exposed in sysfs is wrong then. What if
someone else relies on this info, either at kernel level through the
get_resv_regions callback or from user space.
>
>>> Nothing using iommufd should parse that sysfs file.
>> Right but aren't you still supposed to populate the sysfs files
>> properly. This region must be carved out from the IOVA space, right?
> The sysfs shouldn't be changed here based on how iommufd decides to
> use the iova space. The sysfs reflects the information reported from
> the driver and sw_msi should be understood as the driver's
> recommendation when you view it from sysfs.
>
> The actual reserved regions in effect for an iommufd object are
> queried directly in iommufd and do not have a sysfs representation.
>
>>>>> + * @IOMMU_OPTION_SW_MSI_START:
>>>>> + *    Change the base address of the IOMMU mapping region for MSI doorbell(s).
>>>>> + *    It must be set this before attaching a device to an IOAS/HWPT, otherwise
>>>>> + *    this option will be not effective on that IOAS/HWPT. User can choose to
>>>>> + *    let kernel pick a base address, by simply ignoring this option or setting
>>>>> + *    a value 0 to IOMMU_OPTION_SW_MSI_SIZE. Global option, object_id must be 0
>>>> I think we should document it cannot be put at a random place either.
>>> It can be put at any place a map can be placed.
>> to me It cannot overlap with guest RAM IPA so userspace needs to be
>> cautious about that
> Yes, userspace needs to manage its own VM memory map to avoid
> overlaps, but from an API perspective it can be placed anywhere that a
> map can be placed.
OK

Eric
>
> Jason
>


