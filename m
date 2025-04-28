Return-Path: <linux-kselftest+bounces-31794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 678A3A9F751
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 19:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1039916D653
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47292918D4;
	Mon, 28 Apr 2025 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5JB1327"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2306D29115D
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745861341; cv=none; b=cVmTYoka4tYuVZHHWsMLI8NH7gLoRta2y7Xh6ktutMZSjI49lVVZMhxst5AzEG95x3qCEIwm+nMjj91DeJES0sLrOILLvU/Q+BZ8cdIzkfr8Z/g4b8Ay61RU9Q3AWVgKvkrXlQE9EMZkq9BuOcK0SLv/b/uZwToveV+Doc6oR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745861341; c=relaxed/simple;
	bh=hvj8x3HVmp9P+1p1D0eDo1pbK3RjBLaMP05027S3Y0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsLzJ3o6TRTf3w9VNIBp8PYINhV4TnDFxiLdkFpRuhmGYO1YoRZLkje1zOG/lkxaLEp3rexnUGeKOrD0X/cmUDB8vzsKFXtzH2zkrW3+0rBuJQmahbE6AaW3XjEs2pArphag5Ym7Plr1D5ZRXOzqwIHgl1TwX63StqswBs0LGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5JB1327; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240aad70f2so15625ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745861338; x=1746466138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0r7+wCllJmaKxCe01hHV/d2aOrZfvhrAsuNMyHCgYc=;
        b=S5JB1327JpJxaMmLXm5NYrTJfpPRRsFYe8t1MsMX+g9eo/hWOYhsJFIDjGpiGZJ+Tw
         Z5dOGM/O/RADOG5X2JnhKBjkp0dsG9DGbAVqPHVHkFZhJKwtYegN9ReqK7kU9QZG75tu
         83RGNj8AxSp5xemBFUBeylMeuO8FbMzw8SHAvfNleUz2CUA1uSXsco4Bzli/va3N77Rm
         vCAxyo2xUHI2E9OwLe3x8Fd5KSIhnoqYslZAxFrLq1qFxEZ0sVXl2vZ5EQWdB2lrqMuf
         dGTNrcUACF9khh3UA/XeSQrMsh5hPyPrlP/HUceBlX7dOJmj0WR06R5K/OpdcPmqx7KQ
         uXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745861338; x=1746466138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0r7+wCllJmaKxCe01hHV/d2aOrZfvhrAsuNMyHCgYc=;
        b=NJnza2kKjm67YiYCS2xbus1BUjznV1Nq9CKmt6czovNDyoSRqs32NnIlMkZtVZhhvW
         vwB2nnxnz0UW+2Dtnd5QfZb8CufywAuTb2rzl9Jta/zNL3tntSmcAoauWRiwBWirkw5V
         l+nbgGS+p4iCuAU8XH1I9tpIpALEEx+3y08J/2ZboFB2wsyU1aD+kLfxwOPtfa26OLhq
         lboRQXkmgbcK7/NzHmNdsNQtjXyo3uzUjjBLXJFmtBaGPw8xwuPDB3cQL165vaUtY2pd
         K6eAuNWiE/SvAnhoDkGwicQpDwgReG1ZbllUtFIZw6sl4lIqhshsR96cn+ST8qB3KVfj
         2XcA==
X-Forwarded-Encrypted: i=1; AJvYcCVCxe4zpYJ7we1ffnD0l7UTR04ZI9WZNYTHwbA5++glydkWXdE7qFV2gwxt4RyENX7qSYJ5U7updnHQ35CFBk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI/5AQTlG9YngXcQMRarUJpBf/Ossj+7Fk/BxGNlG7sg7i0MpL
	z2S1szCMIY7z8CWTfOxFAeUgnrVvpmHtucmsNCKoxu8RCXBU8NsYNMhO1/72pg==
X-Gm-Gg: ASbGnctfRXxZxnJAe8nx30+qm11HjTgTkv4ca5VZ7UGVpb1qsQpmgzKzHEaSwuo7j0K
	c7ZriJpzpBkc4EDLALO/pYv8kGaGYMEkLsN+5NMP9nlhcfoVo5lsW8i8ps+O/+ImRO3UGWCowox
	AkvdVDDe88ONFzetGcGTH9M4EhbqblOiq4KS0e7CqjtwYzua1l0eB8SxNrThiS2WKrUJkVEoCbE
	GVgtcAQtLTT9rJkkeFQzaCiQ0QT4DQK4cr33rpXySKlK2i3k1LbFtLQP8ek+Hxn62yU0IIztKTH
	GWselm9Ab+vbx3mY0A8fEUmgIsa+bVzbb4EqVcX31iIaiJ4J80wDMiIF9T+iMiFx5BRw44Qc
X-Google-Smtp-Source: AGHT+IFvvbXqVLW7M7K4eTP2s1tq5nZj/xJsE94cw7osWMiH1XhKOhdmN98bqT0YcPcDS66bSCITtg==
X-Received: by 2002:a17:902:ea01:b0:21f:2ded:bfa0 with SMTP id d9443c01a7336-22de586f035mr708455ad.25.1745861337961;
        Mon, 28 Apr 2025 10:28:57 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef061bccsm9296497a91.18.2025.04.28.10.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 10:28:57 -0700 (PDT)
Date: Mon, 28 Apr 2025 17:28:46 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, jgg@nvidia.com,
	kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 02/22] iommu: Pass in a driver-level user data
 structure to viommu_alloc op
Message-ID: <aA-6zlZNQ6NsrUqw@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <f985e2802a50b5867c9d4d3182ae7b4944a989c5.1745646960.git.nicolinc@nvidia.com>
 <e569c927-65ff-4c0f-8922-45e404fefc5e@linux.intel.com>
 <aA+4mRrGuUnpG/dB@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA+4mRrGuUnpG/dB@Asurada-Nvidia>

On Mon, Apr 28, 2025 at 10:19:21AM -0700, Nicolin Chen wrote:
> On Sun, Apr 27, 2025 at 02:31:54PM +0800, Baolu Lu wrote:
> > On 4/26/25 13:57, Nicolin Chen wrote:
> > > The new type of vIOMMU for tegra241-cmdqv needs to pass in a driver-level
> > > data structure from user space via iommufd, so add a user_data to the op.
> > > 
> > > Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> > > Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> > 
> > It would be better to add some words explaining what kind of user data
> > can be passed when allocating a vIOMMU object and the reason why this
> > might be necessary.
> > 
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Sure. Will do something like this:
> 
> The new type of vIOMMU for tegra241-cmdqv allows user space VM to use one
> of its virtual command queue HW resources exclusively. This requires user
> space to mmap the corresponding MMIO page from kernel space for direct HW
> control.
> 
> To forward the mmap info (vm_pgoff and size), iommufd should add a driver
> specific data structure to the IOMMUFD_CMD_VIOMMU_ALLOC ioctl, for driver
> to output the info (during the allocation) back to user space.
> 
> Similar to the existing ioctls and their IOMMU handlers, add a user_data
> to viommu_alloc op to bridge between iommufd and drivers.
> 

Ack, with this change (addressing Lu's nit).

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> Thanks
> Nicolin

