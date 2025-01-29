Return-Path: <linux-kselftest+bounces-25387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE36A2234E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 18:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1150C167A23
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 17:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9F1DFE16;
	Wed, 29 Jan 2025 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnDv9gis"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D761922D3
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738172791; cv=none; b=g/w+zUHFTrrXKJxPqRRsEBYpjULB4bhUFYQidIv0zATC17xj/57H8yd4UP6SEUFZxf35TR9/5AZ14fW7SUmTkPSJFobXR5WIoYVCuLEnBpdp/hXJZuMvr6flHHmloUZh/bXQj4T11/4gHhzapxZKl9pNDCff+2jqwnRwhQTiB6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738172791; c=relaxed/simple;
	bh=GVBVPQXK+YOVlYYHwZtT5FW5o6eoUI4q99NTvpI44+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+CeY4QiRZgfCNuH4iqd8NlipoDcNlBg+GV76QLCdVVrB+e52i3XzElPjLz96bGKxqEa6DxpPARfIjrSGnwyCEv4PFrqX2e8RzaVigdObHNkZ9zIWD7KjOri4K5NIUt7F92/+cO3V3UbhlI7fzq1/QfMxxYkqdcoAz85rKlxa5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnDv9gis; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738172788;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7C39AcP479z7PaOLmWGBMx2cDdXkmF+MZl53H1pFh10=;
	b=cnDv9gis7KChwlEq7tACnjBMcuShun73QtuYhz2ZIBdgSkhPx5nbnM/kdPIG3Xlvoatn4n
	kDbKk2Zd0HtdcwC/CMPdIIAcqVTN832OiaL2S00pN9b+4rxyL+VB/+QmFpaFpbxvxQMShg
	2W9/6wNYCt3bHKNptCh8vfeKdfsM3t4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-h2ubUBlAM4CExP4_pR1mSQ-1; Wed, 29 Jan 2025 12:46:27 -0500
X-MC-Unique: h2ubUBlAM4CExP4_pR1mSQ-1
X-Mimecast-MFC-AGG-ID: h2ubUBlAM4CExP4_pR1mSQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-436225d4389so4812505e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 09:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738172785; x=1738777585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7C39AcP479z7PaOLmWGBMx2cDdXkmF+MZl53H1pFh10=;
        b=aFhB2fhnUSz/UAEn3r84SioacscZIs5zvljhtc0O2MHokPD2jk1e21U1qiAcz5OI/d
         Ta5C/BWsDTGAJpnenKjYVneP2dxN9oels/bjoI/a8H5BUR8bCgVew1yL8P36BreQXDdC
         IqpPxZozr0rxKu2mFasNBmiLalhSDY/zErjELZm6CsIWNLRovnh8Jcho4W5LDR8Q87Ev
         ZpgXG9pYa5/l8qPsU8x3wosAxaQXqO/e7MczgnX8NTDpGKDglgLmeUY73YiQeZpJI5N3
         kmFDTlcncI4xxNxRC2gFh69YDkHDLO88d8Qvk/58uj2tgWPMMSFlMNvQ1upQJUsSm5YU
         VpQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEPf0FnBGTNSPHU6bUxBAhiU58fTlwWjCHgfTvU71AmkckfWczONJay7VfQUEOpQc97hR49UFJ4ZhUkPdBCaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1aUFVj+Hh/Q1FafBeiDmZB5La4ZS4rxWuYouLCaRlmf+UoVWU
	CaO0uPGMPaqoIuGFPfMWLCb7AL2rUNRmoV1frhO+TrmO3dSlrOJw2jDWbCwjcO9+PyINPTdlH0t
	Y/x3d/Ib9IwNOT5RTqSVSCvCqhGGtaMsUdfnW3SfQdY+C1miQkNwnQjtcdPRVzcrgfkn96snXxw
	==
X-Gm-Gg: ASbGncv+kgUVC7e5ziuq/stv+0h3BCB5ahSJII7cy5MjWuCBwX7xqx+Wo8dHnE99v2r
	dEwWQYSGHaUw2xWTKPqI5l4S1NHBX9Ty+JrOzPBDgSpBwQnO8qKZP+6bCkzTlihn0V6v4uMuxTx
	p2Pez+C+Hac6OA57OnFzj7OruQD1ML2TIoyjbVpLQv7WKUrCiUHc9/T/27bxrQyoE0bsrKIDVTi
	ZFGavfFcqbuHkCu8IqlCygFUuPKLTvwI6BoOa4FP6EE+iMUdAIUYQdV3+pe1mjW/J++3iEmYe3s
	OaEr96PbSOoTJvo2pE/+rcrzo9CHKt6CT4dI2I3SWXpb1eZl9WoJ
X-Received: by 2002:a05:600c:6555:b0:436:fdac:26eb with SMTP id 5b1f17b1804b1-438e15e7fdamr1934935e9.7.1738172785122;
        Wed, 29 Jan 2025 09:46:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQmQmuNWdwXKR1WA8YUMR0neWSl2UDPcJoTIpWOkS9ogRoZv55tiuXIIRNpwuKJUpW+TAzXQ==
X-Received: by 2002:a05:600c:6555:b0:436:fdac:26eb with SMTP id 5b1f17b1804b1-438e15e7fdamr1934415e9.7.1738172784724;
        Wed, 29 Jan 2025 09:46:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc13151sm30025435e9.1.2025.01.29.09.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 09:46:22 -0800 (PST)
Message-ID: <8e4c21b5-3b79-4f0b-b920-59b825c2fb81@redhat.com>
Date: Wed, 29 Jan 2025 18:46:20 +0100
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
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
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
 <de6b9dc1-dedd-4a3d-9db7-cb4b8e281697@redhat.com>
 <20250129150454.GH5556@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250129150454.GH5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




On 1/29/25 4:04 PM, Jason Gunthorpe wrote:
> On Wed, Jan 29, 2025 at 03:54:48PM +0100, Eric Auger wrote:
>>>> or you are just mentioning it here because
>>>> it is still possible to make use of that. I think from previous discussions the
>>>> argument was to adopt a more dedicated MSI pass-through model which I
>>>> think is  approach-2 here.  
>>> The basic flow of the pass through model is shown in the last two
>>> patches, it is not fully complete but is testable. It assumes a single
>>> ITS page. The VM would use IOMMU_OPTION_SW_MSI_START/SIZE to put the
>>> ITS page at the correct S2 location and then describe it in the ACPI
>>> as an ITS page not a RMR.
>> This is a nice to have feature but not mandated in the first place,
>> is it?
> Not mandated. It just sort of happens because of the design. IMHO
> nothing should use it because there is no way for userspace to
> discover how many ITS pages there may be.
>
>>> This missing peice is cleaning up the ITS mapping to allow for
>>> multiple ITS pages. I've imagined that kvm would someone give iommufd
>>> a FD that holds the specific ITS pages instead of the
>>> IOMMU_OPTION_SW_MSI_START/SIZE flow.
>> That's what I don't get: at the moment you only pass the gIOVA. With
>> technique 2, how can you build the nested mapping, ie.
>>
>>          S1           S2
>> gIOVA    ->    gDB    ->    hDB
>>
>> without passing the full gIOVA/gDB S1 mapping to the host?
> The nested S2 mapping is already setup before the VM boots:
>
>  - The VMM puts the ITS page (hDB) into the S2 at a fixed address (gDB)
Ah OK. Your gDB has nothing to do with the actual S1 guest gDB, right?
It is computed in iommufd_sw_msi_get_map() from the sw_msi_start pool.
Is that correct? In
https://lore.kernel.org/all/20210411111228.14386-9-eric.auger@redhat.com/
I was passing both the gIOVA and the "true" gDB Eric
>  - The ACPI tells the VM that the GIC has an ITS page at the S2's
>    address (hDB)
>  - The VM sets up its S1 with a gIOVA that points to the S2's ITS 
>    page (gDB). The S2 already has gDB -> hDB.
>  - The VMM traps the gIOVA write to the MSI-X table. Both the S1 and
>    S2 are populated at this moment.
>
> If you have multiple ITS pages then the ACPI has to tell the guest GIC
> about them, what their gDB address is, and what devices use which ITS.
>
> Jason
>


