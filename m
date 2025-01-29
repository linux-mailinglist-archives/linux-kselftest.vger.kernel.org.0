Return-Path: <linux-kselftest+bounces-25370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE22A21FC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 15:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EB43A5586
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 14:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646C51B4250;
	Wed, 29 Jan 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhSQsRfX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73B0167DAC
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738162502; cv=none; b=epMn/SGTFdB9du5+fhhOcmRB1t7RL83/+0Dee5m27KvcPzBaPneqMyRk86D/XFlS5dlaUZKnyJNO4NAHiIvg7iT3I33Y/CN7IEEm8PJP/4fbIuNQypQo5LtGh6blDmMjHL6VDxjYEqb3isBrA2BmqjpGxTsGGVsbYzagmn0TPUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738162502; c=relaxed/simple;
	bh=6+OO8Q3b3zt1nWaEORWp4Hfs0gfS/N+UGYsLrltBN2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLDXhi29BJpMKpOsieUqxQbpB31T9KRPQ7etMPLYstYOytQFQZ+tezoGCoVm1bUvyYwEVZxgca/CTQPH5sxHuUnqRdFgx9axlEWxgH6zAUBKS0MTMeGt5wv9cWKqyt7+U43o+kZb5W4qXhXRgIlDexSROONDV6WiwEUizo8ZK3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhSQsRfX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738162499;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=41DS6NhU0zxHo0sjvBCG7EzuBprQ0MM39VMITq82vi0=;
	b=fhSQsRfXzTx3tcRba6MG5SylUtN2vWjf07LfQ7VO4iJfePH0NSSniEhe0gY5bQ1aQ/zdFm
	wzjCioeUosKnXi5GF1GorNf1xbmvDychdPuUESSlc95MeGUXKhM22e7Zp8ySEhv77Mm5Sl
	wxuz59K7nso6HcEBf+pNDEGs2UcyRB0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-aTiFwsfxNBKE3AfYC36QMg-1; Wed, 29 Jan 2025 09:54:58 -0500
X-MC-Unique: aTiFwsfxNBKE3AfYC36QMg-1
X-Mimecast-MFC-AGG-ID: aTiFwsfxNBKE3AfYC36QMg
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6f3b93f5cso171736085a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 06:54:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738162498; x=1738767298;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41DS6NhU0zxHo0sjvBCG7EzuBprQ0MM39VMITq82vi0=;
        b=q4sZrzIMO/RA+OXEricADMRWN4MJa5L8OVVl+Q5q0nCShDi00+qYUuIyLEVFxHTv7E
         Tn2+QW04P/wjkcC80Ec95j5bibM81dh7Va4/N7hD03k1Rb9gB5OPzN9IV10V/Vk/vvQm
         zHOwfx4bQ0UClgzRVL027aW4O24R5nvmLb48qwgsnyFmSlHbd5ExF/57n0qSlJ770/lx
         MPvOHgiJGX5KgowTsuNtGFpg7TIJ2xhYUF63umus2ifro5SGeriPDrgyQBgVjmoOgy/1
         IbDXxqO+0dxdP1cjgbSx7DF/Zx4Z3lnUnDjzg5jzBSKhwAnFUwOx5VwGYqw/2pwz8X4J
         +8EA==
X-Forwarded-Encrypted: i=1; AJvYcCU7Ej/msuv0AHlEjY3RYx4Jn+fGlZsKgw8mOKU8/+zXFvY4AAEoDMqB/7WjBrIrZAc0/BjZAs5IB554ndXSpt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuILWr9Yj9+lp1MXSBgpTHH+cQHVd0YCfN+vPcrMoPfRcHsA23
	H2WiVqJ/4ozmlRtHqLhftdutOPyZ73g8AJhfhgKl1QqE1HiTmoHb2PEv94t1aKWNSgSzw7wNv/Q
	8sfQ239Y9Bp0Jhjjn0cBU5iErmhkyC1da3YSLAyopaQlYy+zOGL279QzyOgfwKm7o5A==
X-Gm-Gg: ASbGncsiLoyg6VK0UlyOSOj3mfpkYs1lybcTT/09D1Nkv1cGY/XqNxLr4bd/UEKmQrj
	LNpvIJfM4EEAb8AAu9JwdBEGOz8dMkLfty4MTmqtzWFZovCbfEe1caZB4QNZo1d1Wvxt1geyk+Y
	fM/NyHWVrV5wZNTbj2pK3PNYx9p/FIkMjKx1SXkWA/cGLgmL7T4EsxRrT/izlOiCVSuTs58f48f
	ZpXfJx5SGDdux/I5LM8iis5Cn8v5O+PVnPg10SzNwtTkEV02Jt+6MqagZfva3PRoPPXOeQn2Rvh
	u/4Ei228By7flbMQw0SCzxUfJ98Rf9NZZTyDGSnQrU3oFQb1KOdt
X-Received: by 2002:a05:620a:3951:b0:7b6:d710:22ad with SMTP id af79cd13be357-7bffc653717mr574629085a.27.1738162497773;
        Wed, 29 Jan 2025 06:54:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPWgJozhXbMPe2UuS+N7int1mBv1T30ENqy//KBekCyuXuA7cZhOllIHHQgTzUZoQnKd9qwQ==
X-Received: by 2002:a05:620a:3951:b0:7b6:d710:22ad with SMTP id af79cd13be357-7bffc653717mr574623385a.27.1738162497407;
        Wed, 29 Jan 2025 06:54:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9af0d281sm629855985a.99.2025.01.29.06.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 06:54:56 -0800 (PST)
Message-ID: <de6b9dc1-dedd-4a3d-9db7-cb4b8e281697@redhat.com>
Date: Wed, 29 Jan 2025 15:54:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH RFCv2 00/13] iommu: Add MSI mapping support with nested
 SMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "maz@kernel.org"
 <maz@kernel.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "shuah@kernel.org" <shuah@kernel.org>,
 "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
 "yebin (H)" <yebin10@huawei.com>,
 "apatel@ventanamicro.com" <apatel@ventanamicro.com>,
 "shivamurthy.shastri@linutronix.de" <shivamurthy.shastri@linutronix.de>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
 "yury.norov@gmail.com" <yury.norov@gmail.com>,
 "nipun.gupta@amd.com" <nipun.gupta@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "patches@lists.linux.dev" <patches@lists.linux.dev>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "mdf@kernel.org" <mdf@kernel.org>, "mshavit@google.com"
 <mshavit@google.com>, "smostafa@google.com" <smostafa@google.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <4946ea266bdc4b1e8796dee1b228bd8f@huawei.com>
 <20250123132432.GJ5556@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250123132432.GJ5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi Jason,

On 1/23/25 2:24 PM, Jason Gunthorpe wrote:
> On Thu, Jan 23, 2025 at 09:06:49AM +0000, Shameerali Kolothum Thodi wrote:
>
>> One confusion I have about the above text is, do we still plan to support the
>> approach -1( Using RMR in Qemu)
> Yes, it remains an option. The VMM would use the
> IOMMU_OPTION_SW_MSI_START/SIZE ioctls to tell the kernel where it
> wants to put the RMR region then it would send the RMR into the VM
> through ACPI.
>
> The kernel side promises that the RMR region will have a consistent
> (but unpredictable!) layout of ITS pages (however many are required)
> within that RMR space, regardless of what devices/domain are attached.
>
> I would like to start with patches up to #10 for this part as it
> solves two of the three problems here.
>
>> or you are just mentioning it here because
>> it is still possible to make use of that. I think from previous discussions the
>> argument was to adopt a more dedicated MSI pass-through model which I
>> think is  approach-2 here.  
> The basic flow of the pass through model is shown in the last two
> patches, it is not fully complete but is testable. It assumes a single
> ITS page. The VM would use IOMMU_OPTION_SW_MSI_START/SIZE to put the
> ITS page at the correct S2 location and then describe it in the ACPI
> as an ITS page not a RMR.
This is a nice to have feature but not mandated in the first place, is it?
>
> The VMM will capture the MSI writes and use
> VFIO_IRQ_SET_ACTION_PREPARE to convey the guests's S1 translation to
> the IRQ subsystem.
>
> This missing peice is cleaning up the ITS mapping to allow for
> multiple ITS pages. I've imagined that kvm would someone give iommufd
> a FD that holds the specific ITS pages instead of the
> IOMMU_OPTION_SW_MSI_START/SIZE flow.
That's what I don't get: at the moment you only pass the gIOVA. With
technique 2, how can you build the nested mapping, ie.

         S1           S2
gIOVA    ->    gDB    ->    hDB

without passing the full gIOVA/gDB S1 mapping to the host?

Eric


>
> Jason
>


