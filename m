Return-Path: <linux-kselftest+bounces-25360-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5960A21D44
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 13:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E401886E00
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C975A23;
	Wed, 29 Jan 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Otj0gGdD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348333EC
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738154463; cv=none; b=Qo5EAnoNTGtQamaERhJk4WIrf9Fd7ptMigTENIbdJVEibQSYICtAu0FA9U/CYPeFvFeDDLmLtaweT7SbXevmjeHpgasn/xrzssSvms++o0dPgKHNHr3GKtkIbm/hT10EyLvcVKaKwlgMvbD2bn7wqnJPmiq2mSmoTLmoLuirpDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738154463; c=relaxed/simple;
	bh=oqyL0SVIx0IHIJUrvAsPEYQScRuB2QNTKtaW34bcnyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mes70MaIwMjkWPmntZ/PrT5c5Kbown1RdtxuD96fLt9IohuVR/MPFUy6wNXJ3DUBi7/kfZ36IPYC1e5UfcNvWk3jdUTQCiVRp/pZXExvky8hPDv+Jpap766yWSBmjkKI6j2h0c6Fs3xoKh56wB3EsHfHRRa56ku18FXSpQ9vg+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Otj0gGdD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738154460;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1IHY9dSHJw552myqEIIBi0r2yle1SPObfgdh6fdw+s=;
	b=Otj0gGdD7+bo/6VxA4/56moPK6NIZ6hvZfULWYOo0UogzIRamLJQhbnE9MOBb7HFFVQ0Xk
	w7qQv192b1wivxaXpJwKIVpJEQTyJ2uU9Gf0u/cRYddhJdowSgYxLsCB+26pqruXh9b2qi
	Nk+aj5nhi4YDT7RQd7NcsEOjXynCtx4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-xbiH1rQtNGW174fNeI7aUw-1; Wed, 29 Jan 2025 07:40:59 -0500
X-MC-Unique: xbiH1rQtNGW174fNeI7aUw-1
X-Mimecast-MFC-AGG-ID: xbiH1rQtNGW174fNeI7aUw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385d52591d6so310132f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 04:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738154458; x=1738759258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o1IHY9dSHJw552myqEIIBi0r2yle1SPObfgdh6fdw+s=;
        b=urvEFrdP5FMp4tvdbCiGoabJYheQc19u32jRboxkUWk8ANmg5ah42Ez77LmA2zEvcU
         mgJ3fn7dWgDLs31ww0uZd+XTo/MTBGzgUOqQwaUGe5AD9vGMQZkkDVDKGJrlMW+UeBdn
         N52T0q6I6WdmicGaUDF4e8A8YJz6sdBGTA5Jiifh6ZgiKFLgzilK8JPKgNFTJXuMZdJd
         bDoVapI7PBWH3mePJxDzD+sl0Ae+bIPly65gnMzafplaWi94djoaICZQruDt/ICCJbt+
         gaRCnj+gZzC0jRmuFbNT7Z4f2wRbFmlTVZbhKeTKYUjd8KIsqDytt/NTsEOQ6BXsEz6F
         cwjg==
X-Forwarded-Encrypted: i=1; AJvYcCVNkeifsApOfb59ww7Dy2BBaqISMgcE1ggVPpI+a8E/p7D3x69UI9nxHHFX3VZJlH4iWmMP6QzPVOVjfXM9q24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyal93Y40kTP1q90LbHzoRxRorF1TBdGPR+WEeSVGGgJQKa3fn9
	ecVc/8QuwfTVUJOpnkPTLH6It1mvW4BUX/WfK5BeD70ws92McqdFesIHI+rjIChFkorIVwiGpIf
	Zwd034jQWKUcMeuXN9AoPVxZT2Gbe821Z++TnnkSRDyUY5n+S/PpTtp/NpdYiqIwAaA==
X-Gm-Gg: ASbGncsu4vleRekPF7UtFi9709DP0rSkk+XTapc6qRgkbgZSYHPMDS4c6w3v8Sk/dtG
	Z0cIq2VK8wG7oqX9ueBl+3CgcIb8PGs2pHuj4IBwaAR/t5YNcBmMqX8xFoER2RtBh/MIp/kMM5s
	kanDqbzHE7hVntj0fW5z/1DNnz62zB6f/kUEFadyTF6P1shffdpI+/ZtMYjjUCB5ZXL0QCNw1a6
	8C55X2c5Hcs4C0J8+VYH3Anm6Fd7fPG/5PaxWvZGFqZPGbKXoC9G+G+kkr/Tlg5f4JXfjr/ZUYS
	/RtFqzFxYiu0CJzC5illDfJO+NtgalER6UOCZc6IYRGBq5+Repba
X-Received: by 2002:a5d:6481:0:b0:386:34af:9bae with SMTP id ffacd0b85a97d-38c49a051c8mr6025097f8f.4.1738154458356;
        Wed, 29 Jan 2025 04:40:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPImj5mHPLCO6tRj8e3YjFQx2gbmUE76baovajKNeTFowKfkm4iVE7BpqlFB2vM0krIkmApg==
X-Received: by 2002:a5d:6481:0:b0:386:34af:9bae with SMTP id ffacd0b85a97d-38c49a051c8mr6025054f8f.4.1738154457927;
        Wed, 29 Jan 2025 04:40:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1baf3esm17214328f8f.75.2025.01.29.04.40.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 04:40:57 -0800 (PST)
Message-ID: <fd878b3a-ea02-49e0-9b5f-524e7fa1ecdf@redhat.com>
Date: Wed, 29 Jan 2025 13:40:54 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH RFCv2 05/13] iommu: Turn fault_data to iommufd private
 pointer
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, jgg@nvidia.com, kevin.tian@intel.com,
 tglx@linutronix.de, maz@kernel.org, alex.williamson@redhat.com
Cc: joro@8bytes.org, shuah@kernel.org, reinette.chatre@intel.com,
 yebin10@huawei.com, apatel@ventanamicro.com,
 shivamurthy.shastri@linutronix.de, bhelgaas@google.com,
 anna-maria@linutronix.de, yury.norov@gmail.com, nipun.gupta@amd.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
 jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
 shameerali.kolothum.thodi@huawei.com, smostafa@google.com, ddutile@redhat.com
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <3b26ce04e8ecb5e47f028fe5cae48e5235e68420.1736550979.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <3b26ce04e8ecb5e47f028fe5cae48e5235e68420.1736550979.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit




On 1/11/25 4:32 AM, Nicolin Chen wrote:
> A "fault_data" was added exclusively for the iommufd_fault_iopf_handler()
> used by IOPF/PRI use cases, along with the attach_handle. Now, the iommufd
> version of sw_msi function will resue the attach_handle and fault_data for
reuse
> a non-fault case.
>
> Rename "fault_data" to "iommufd_hwpt" so as not to confine it to a "fault"
> case. Move it into a union to be the iommufd private pointer. A following
> patch will move the iova_cookie to the union for dma-iommu too, after the
> iommufd_sw_msi implementation is added.
>
> Since we have two unions now, add some simple comments for readability.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h                | 6 ++++--
>  drivers/iommu/iommufd/fault.c        | 2 +-
>  drivers/iommu/iommufd/hw_pagetable.c | 2 +-
>  3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 423fdfa6b3bb..b6526d734f30 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -224,8 +224,10 @@ struct iommu_domain {
>  		      phys_addr_t msi_addr);
>  #endif
>  
> -	void *fault_data;
> -	union {
> +	union { /* Pointer usable by owner of the domain */
> +		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
> +	};
> +	union { /* Fault handler */
>  		struct {
>  			iommu_fault_handler_t handler;
>  			void *handler_token;
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index 1fe804e28a86..06aa83a75e94 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -431,7 +431,7 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
>  	struct iommufd_hw_pagetable *hwpt;
>  	struct iommufd_fault *fault;
>  
> -	hwpt = group->attach_handle->domain->fault_data;
> +	hwpt = group->attach_handle->domain->iommufd_hwpt;
>  	fault = hwpt->fault;
>  
>  	mutex_lock(&fault->mutex);
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index ce03c3804651..f7c0d7b214b6 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -402,10 +402,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>  		}
>  		hwpt->fault = fault;
>  		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> -		hwpt->domain->fault_data = hwpt;
>  		refcount_inc(&fault->obj.users);
>  		iommufd_put_object(ucmd->ictx, &fault->obj);
>  	}
> +	hwpt->domain->iommufd_hwpt = hwpt;
don't we want to reset this somewhere on release path?

Eric
>  
>  	cmd->out_hwpt_id = hwpt->obj.id;
>  	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));


