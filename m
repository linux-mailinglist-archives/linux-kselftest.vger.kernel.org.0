Return-Path: <linux-kselftest+bounces-25378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EDEA222D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D101F3A5CB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 17:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3498E1E25FA;
	Wed, 29 Jan 2025 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/0a9ygS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D9B1E1C36
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738171424; cv=none; b=VymZJuj9qKTddUvO+tXnuZavc8nNG54BPM8V5SD7wS7IxqwaAXdpUZiWCVsdFCezmfAFZUE8cIDzcaK6CvVvt+fCREp0eQ4Eym3G3VUzo6TAVHwkzIgrmtX0Z5I7iK6rNPtivpB47i8+nD9WvU3n6SmRaHvV31JCB6ZuCwN+Hmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738171424; c=relaxed/simple;
	bh=lTP2WZGK7rl5hpI7hR7S+twULR2cKHG1SjFFxN33iF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gooedLI0n84zq7lD7VgpThrDVrzoiGqGPILSpRXk4xIk9Gujn3PDr2daM/OS5LlO/YhO6irJ/c+RbGs34V7bEpXqOzNl75yJUFoQvKTypSOQ4uX9lokegVlu46uD/a7Z7him6xkv6DMiZlzpDewIuNaC0UH3T9V1f2v7aWeHMKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/0a9ygS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738171421;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUinW45xP5e5WNhMH3KfMBEndfX+Wq9Gq0wkIWuPQkM=;
	b=T/0a9ygSWX2tuI9m8q3Og5WmGvVHUwzIqHi8lzUq+PVvu39KnaxoK2axZzApdtkd7hembH
	ZEfyHMngFiN+VMjdMhI8ANeYXOef2pPzxesic/Bp2bhYFn8BjcA6AS4OeEdJsU78QEem2O
	PPDCf+uhepBBHbD8ny0T3QbK+0bLrBE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-dMN1tS52OR2dVK23Pra2Hw-1; Wed, 29 Jan 2025 12:23:39 -0500
X-MC-Unique: dMN1tS52OR2dVK23Pra2Hw-1
X-Mimecast-MFC-AGG-ID: dMN1tS52OR2dVK23Pra2Hw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4362153dcd6so36386335e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 09:23:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738171418; x=1738776218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUinW45xP5e5WNhMH3KfMBEndfX+Wq9Gq0wkIWuPQkM=;
        b=PM5oitpS0KnzL0TjsNuKt8g20qm/0jYF/2pT8n2neDRqLhV8+JTfksz/ZLFCQKPuJy
         cm46K5R/ELfxhd8L19qBNc9/x9LxBjzXDWEt7k5yWqwdzvOAlxjbe0uw2W3PXCnsEkJC
         bNKbaMdi4kyInjCNt7kqLIKbYwsgkN8toTfTvKY8V/FA+17gwG/xEMa/Ki4ZttJSqI1n
         NzDpxdHfoGYyctpso/44wZOmrs4Tl7qpVAdkPdkll12k47yKmqpVVbwnQzQ0EwE7wwby
         dnwyIpDKnGSnIerREgHXcfiLpl1F6azR6yutOmXzoxDwJcrtihFTr/qhSVWYqaCubvOY
         rNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8WVSNeEgi0KOCExTWOpw2mjuPkiH1AQu82j8NILIJ9tRwiXBQCAYM4DPUxUv5NajI72cBEp7TYcao3GtTtgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbZhNqVnPBQXWHs+DFdTxcmQCxqFoFZhnoq2wQ7GLwGrvgzWFw
	enltTqteBa0xVK+Nd2towNgKSWj69ed2PZ4b1oQnn3WfzgF++VUZD6LB0JeLl33QmhsgfDQPPPM
	aH1MQqVAnRfVbiAsiXt7xfZ1NHZGO3dZn4ykkTmxQPXhxc82B8qGcdLuCoId5psCx3w==
X-Gm-Gg: ASbGncvdBvFkuNIUGle05TGsv1QI0hj0gEA+7+FzT4K28WPqhcBRSqsQdtrr+p+LEma
	4EFsOG7lF27CxVMFsGy4Fl8UszPg7/66HU7RlVtfheQpJYlEIzUgaP9NUTjvqa9LJJv0TNtuI/x
	PPJ4frafETtfnF0JzNOyxon5CJjdmRbr1G0Y4hboCVKaAxd9q1LWxac/flNxq+gVtWCct25+zwD
	76smiA66fmHdIYV9C341z1qHBBTSsW60BYjx/WizEnrysLaM4101S4065niY6zGWYmj9ZMSb8kO
	ICthCrDNLp4V1aWMq3McDi1Y7tx7vaBa3pbFXBCjeXtj48MT2T6Y
X-Received: by 2002:a05:600c:468d:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-438dc429eb0mr37292795e9.29.1738171418193;
        Wed, 29 Jan 2025 09:23:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpj2GyirYUousb08KORRhwwxL2nA/aWckunw7W2c2Pu3YOW2k9PIs9cw16oemlKH4tI9rx+g==
X-Received: by 2002:a05:600c:468d:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-438dc429eb0mr37292495e9.29.1738171417820;
        Wed, 29 Jan 2025 09:23:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc24cefsm29536565e9.15.2025.01.29.09.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 09:23:36 -0800 (PST)
Message-ID: <21ac88b0-fe93-4933-893c-7ffb09267e7b@redhat.com>
Date: Wed, 29 Jan 2025 18:23:33 +0100
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250129145800.GG5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit




On 1/29/25 3:58 PM, Jason Gunthorpe wrote:
> On Wed, Jan 29, 2025 at 02:44:12PM +0100, Eric Auger wrote:
>> Hi,
>>
>>
>> On 1/11/25 4:32 AM, Nicolin Chen wrote:
>>> For systems that require MSI pages to be mapped into the IOMMU translation
>>> the IOMMU driver provides an IOMMU_RESV_SW_MSI range, which is the default
>>> recommended IOVA window to place these mappings. However, there is nothing
>>> special about this address. And to support the RMR trick in VMM for nested
>> well at least it shall not overlap VMM's RAM. So it was not random either.
>>> translation, the VMM needs to know what sw_msi window the kernel is using.
>>> As there is no particular reason to force VMM to adopt the kernel default,
>>> provide a simple IOMMU_OPTION_SW_MSI_START/SIZE ioctl that the VMM can use
>>> to directly specify the sw_msi window that it wants to use, which replaces
>>> and disables the default IOMMU_RESV_SW_MSI from the driver to avoid having
>>> to build an API to discover the default IOMMU_RESV_SW_MSI.
>> IIUC the MSI window will then be different when using legacy VFIO
>> assignment and iommufd backend.
> ? They use the same, iommufd can have userspace override it. Then it
> will ignore the reserved region.
In current arm-smmu-v3.c you have
        region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
                                         prot, IOMMU_RESV_SW_MSI,
GFP_KERNEL);

in arm_smmu_get_resv_regions()
If you overwrite the default region, don't you need to expose the user
defined resv region?

>
>> MSI reserved regions are exposed in
>> /sys/kernel/iommu_groups/<n>/reserved_regions
>> 0x0000000008000000 0x00000000080fffff msi
>  
>> Is that configurability reflected accordingly?
> ?
>
> Nothing using iommufd should parse that sysfs file.
Right but aren't you still supposed to populate the sysfs files
properly. This region must be carved out from the IOVA space, right?
>  
>> How do you make sure it does not collide with other resv regions? I
>> don't see any check here.
> Yes this does need to be checked, it does look missing. It still needs
> to create a reserved region in the ioas when attaching to keep the
> areas safe and it has to intersect with the incoming reserved
> regions from the driver.
>
>>> + * @IOMMU_OPTION_SW_MSI_START:
>>> + *    Change the base address of the IOMMU mapping region for MSI doorbell(s).
>>> + *    It must be set this before attaching a device to an IOAS/HWPT, otherwise
>>> + *    this option will be not effective on that IOAS/HWPT. User can choose to
>>> + *    let kernel pick a base address, by simply ignoring this option or setting
>>> + *    a value 0 to IOMMU_OPTION_SW_MSI_SIZE. Global option, object_id must be 0
>> I think we should document it cannot be put at a random place either.
> It can be put at any place a map can be placed.
to me It cannot overlap with guest RAM IPA so userspace needs to be
cautious about that

Eric
>
> That also needs to be checked when creating a domain, it can't be
> outside the geometry.
>
> Jason
>


