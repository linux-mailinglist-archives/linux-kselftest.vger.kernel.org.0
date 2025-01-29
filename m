Return-Path: <linux-kselftest+bounces-25357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C92C1A21B22
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 11:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A27FD7A0844
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 10:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A581B4153;
	Wed, 29 Jan 2025 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8aSIe41"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5520F1B3952
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738147460; cv=none; b=Icbo4slteypviM3U2y2GjCJkzPGcLx0B86Z8MkMFh3+NPtYHqMVWwQ8l5QOG+iNiazFqijtbbk/pHK+wOtmUACXGhlFRm2CCQon+i94vz6usJib6q8Ge9nK4ppv/Ll7EV/4nQmrhTaOcXqM5y+BnyEeMsvPKrVD2LoUIfF2hqVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738147460; c=relaxed/simple;
	bh=nv4VuGjSok28KFpMvnhhes+J9LZ2fUvq+BQK0GUr/X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPfoJLpNVRMgLPqtdHWuYLVxDoAGY3lvcvJrc4VFa8YAGRnC6F+07+Zdgrszia3CgMiD1qqk/XnrZ7ffVAm6t5oSOIbIB08rpqxdU4AEXOLiOE7V1a1XBh5HCIJFV2o3cpUJTGPwnCGjzqx80lOD1h5TkivbglfHvqqlOmisqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8aSIe41; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738147458;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yWrkOMQp0EgA1n2/2fll/3eIYbXZEI0l3kIseupr1do=;
	b=V8aSIe41dGsPhJtptsjo/K0tIKrszJDE3rGpR8UaHHAwdugkbr0p83d/y7xOlc/M7ASsxz
	mpFS0KGAJy6hsDWnMmnUEQb5BQfgfl+RmKaJbM0ibz+piLN5DljjONBWJl498+3nZ5dUr1
	9p/u0kiSizuU+VfHAIfo6zxXAvWOlHU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ppU1hSQoPFSBUiMNqCh-XA-1; Wed, 29 Jan 2025 05:44:16 -0500
X-MC-Unique: ppU1hSQoPFSBUiMNqCh-XA-1
X-Mimecast-MFC-AGG-ID: ppU1hSQoPFSBUiMNqCh-XA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-436219070b4so31446795e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 02:44:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738147455; x=1738752255;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWrkOMQp0EgA1n2/2fll/3eIYbXZEI0l3kIseupr1do=;
        b=JQeQ/11DnVM376dlBbwcStwYrC5tLXlQ7HZhiEVzkGppTND2TfSNqtB7dCzNCuSSd/
         eXk5eiHBMhuuQScXRC0wgEJB0TckHFHdcPQlo3kuS+ZEfDbXpzzECDMs84MOxAz3uHSm
         AynbBDLdEUWmdPe4kefSEYaNAHfbGTzWBlbP6LqhVR5n3QFyJm3Bj01Oj52irFRdFtUk
         yYrlIiA+vQpf/srLLxTt6l7w/NTHykGSNbtgGtD793xptV6FeNI1BgSLDVpLLnNy6NlX
         w/UXZsmVpEhwV7gxPxQ0IgfH18QEe9vw68foxNCR6Js7aidrB5/GJm8JV64HIbGYGu+H
         1cQg==
X-Forwarded-Encrypted: i=1; AJvYcCWILtQhU3/slEtwR/+ncM5KPnWszXfAvy8zAcZ+t5uMX1MG0Z+2dQx9tu30NZCHszHvxaiqbHUyG6E5l/zF1H8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi0z6gCYSNdiMrtAU+mYJypzTRQIZYgdVOFh4RuzW2pxzkvPoD
	dnnqCiPeMQGwu9VEiUtbjI2dqJUdG/CFZY8TelIxk0AK94xGEoaCwDDikYTINZ9tu0OsGGM8nNr
	IZBNLHIyKqcZ78pHa4rXkWuVrYjJ89s47OHCX0MNpG8MCFShK2o88gVJiVHSF42cuZQ==
X-Gm-Gg: ASbGnctFvH7ojmoseiGZAmrc7SZWpu5B5xS1VokrRAqumvyWrSDUmGOJqY2f8lHYgWb
	UdE5qiTyPauCtbA4seP1REV06cAn6JExEd60rhC8QP9P8butB/uSM/qUUHj56AQbR+BNsqcOTEO
	r8GsObn4YMah+FhssqIuUq7yLdkvFOajR0WKbHKygOaJijoy6PZn2N7BVuGZhmBVsPc0ir8fhSb
	xD+afxsrZy0hkuxWGzOQ0F6RCIMRwGFsUDfuT63VD7n7v2eYNjAKgRBjM15jk7hJhhRX087qAmg
	eLkn8KCENT5DdRkFpWRPPavRQE5QsgIGZs1qlMsS1a96N5/5NiC0
X-Received: by 2002:a05:600c:3d9b:b0:434:ff08:202b with SMTP id 5b1f17b1804b1-438dc3c360dmr20853795e9.12.1738147454885;
        Wed, 29 Jan 2025 02:44:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzPWEOLliL6813Vkt1ndANuVcfYh0Tyo6krKSjX7AbgdnEUM8NRt3/67xnxrixA9ILfXf4Jg==
X-Received: by 2002:a05:600c:3d9b:b0:434:ff08:202b with SMTP id 5b1f17b1804b1-438dc3c360dmr20853365e9.12.1738147454482;
        Wed, 29 Jan 2025 02:44:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc2f73asm18251195e9.24.2025.01.29.02.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 02:44:13 -0800 (PST)
Message-ID: <840e41b8-15c7-4c4f-a503-818fb4729913@redhat.com>
Date: Wed, 29 Jan 2025 11:44:11 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH RFCv2 02/13] genirq/msi: Rename
 iommu_dma_compose_msi_msg() to msi_msg_set_msi_addr()
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
 <242034456c0bfcd7ecf75cb29d8e5c99db0675d6.1736550979.git.nicolinc@nvidia.com>
 <fa9b443d-e068-41bc-ad03-9f04818c72e0@redhat.com>
 <20250123185002.GV5556@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250123185002.GV5556@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jason,


On 1/23/25 7:50 PM, Jason Gunthorpe wrote:
> On Thu, Jan 23, 2025 at 06:10:54PM +0100, Eric Auger wrote:
>
>>> -/**
>>> - * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
>>> - * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
>>> - * @msg: MSI message containing target physical address
>>> - */
>>> -static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>>> -					     struct msi_msg *msg)
>>> +static inline void msi_msg_set_msi_addr(struct msi_desc *desc,
>>> +					struct msi_msg *msg, u64 msi_addr)
>> nit: msi_msg_set_addr(ess) may be enough as the populated fields are
>> address_lo/hi
> Not sure I follow, you suggest to use msi_msg_set_addr() as the
> function name? Seems Ok
Yes my minor point was just about removing the "msi" redundancy

Eric
>
> Jason
>


