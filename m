Return-Path: <linux-kselftest+bounces-27479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C03EA446FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937A4161C63
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B98194A6B;
	Tue, 25 Feb 2025 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3OXbNl0F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEF6440C
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740501962; cv=none; b=sl3G7e/kUmLDmFSpVdH9vyo4KrySfUWmm1QBqIdzsHIwtePJBv3NoMeeSLXXob6FHwtMBXYn5bEbAT3LwcD4XIX3XBoAo5DQOJjhcx/xukiiKjB0U01wXuidCCDU0WG2O+5E4KH+KUYQ3/QHVXkcTp2aOLC4FAlwQ6RW9VIsvfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740501962; c=relaxed/simple;
	bh=3pkC9Zan/5soR9iiYT3dS1raXOelzZooR8jSMhW1DW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDj6pu7Wur09PT9B3V4b5Vuw4BIcgOzZmjYvXAS9M6B7uxlSwgB+4Nyz0uBTmqU+dvLszw0642jAcbVl39PJ0M3HLTakEMjhx6SFuTB4pds6DhSMH+4XLn5uz1uX5KQByRUkvkJneFr1CHoZG58Gai/7nEkxDmPHehn0gwVc1zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3OXbNl0F; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22117c396baso194595ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 08:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740501960; x=1741106760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvJy2eU2NKOX06+H5Vs2S45nqKcJ32b1n8dkLQorqiw=;
        b=3OXbNl0FmQhnBdz6jgjsTg84gcwmwcN6RiQ27ezIdnf8Nz5HO+Nn7DcT4dmzHynpQj
         hD5uoexR93icrEKisIiCIv/KqCF4XOXl2KBM6LlptZyPFF6lo0alxk82Kf2Goyvo7Wn9
         YB6nln/odKfL8J6Z2hJRj1XKWXJHlLaOp4K6O7PHU17cqtgljSSK5F+x/6URpbZb5Vff
         fIOR7Th/kIaiki3fgE6k7N68M4wmwW0e/GxovKAm5l4H94VDngJ+XJz7Ww6fjH0bQ7Eo
         KL+HhDxeZbutkWDyXQsXq22JQ0Qs/2qc5IypJEyk1aMc/HZekjS5J/bgS7QEhXJ9u5ff
         yIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740501960; x=1741106760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvJy2eU2NKOX06+H5Vs2S45nqKcJ32b1n8dkLQorqiw=;
        b=dmDikjVwFWdY296C2tR5xmRsOE+KE4eUDldarUEglBLKydGRMod8mqVbMHmfWlsio4
         ai5t2KAi+z82iAzYXxUZvhBtlTlkCn0UeIJGB5Hy7gXXnM9OxZZjX0tO+n3tWZnNOF8r
         pNEpQ8TZRvW7yMkUMhCCWbk2GRQchPVcC5cvr28/P9E8+CnK+RwlVpDYY1smamP9BcPW
         BMiznf/MfZFZCXRYhdAtnFlk47yapJCcgDlSGbc4GNOjn2ntCoLUiTw00v8biuX+4PrW
         ccFP/eqkjZzL0hWzgyOI5uypGFR+KM2SSug+TZNmF3BAkb5DBPtGhXnmkNOnvLwkgGrp
         Wq1w==
X-Forwarded-Encrypted: i=1; AJvYcCVCy1BKHsWqz4OTLAkx3dVCv04ELf9VNHXbmCOxuzqwWRAI5sDbs9VDLGRlEiYSaY9Drvt9/iteiMVv74c7bA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrPzqAQZwyQR6vslR6AwGJoEzdO+UMNZDEl0pshjbLoLOJGAQO
	QoMMXy4QBx1CGK326KDBP3Z7pqYcoNyzCXOQHdtN9xn87ActG+UfemQV2+4aoQ==
X-Gm-Gg: ASbGncvXZrV+kZaxGPrOpPFIL1X2FDPFJKtOdeJwCBVHv6c6LKoSyNoKyyjiIH4n9Yg
	zY18pNtAJc1PmT6paYxfR0ri6pgaqyzA/f22r0x5zCyPAZotSZ8I3MErmH+lJm/WLsuXWP4HWdE
	xQJ3jm0vvuFa/AZyg723l7i8AJJwB5XdzEh92AFWLekagLnWlWNoUNQB2CY6B4k1V2llhrQSZ89
	Nv1gniYtLlHYChJt1EBmrSAo+81aJUnbTcvU/VAJRPcfR3KK4vvaLa8UYKbEKSNNCd8A1UBiGc3
	JaaIv2H9eVxbXuPcPZc/kGmaB3QoKDxD2OkGXv/ULMahWj4ZL2rbFFN5c3mSUGA=
X-Google-Smtp-Source: AGHT+IEN5DYqq3Kc3cWdCDht37pR+ox7Pyn1fNUO9eOSCsjsyhHHqegeAVtSYgiTkCHpwG2cFWbA4w==
X-Received: by 2002:a17:903:2445:b0:215:9ab0:402 with SMTP id d9443c01a7336-22307a98a03mr3458305ad.18.1740501959581;
        Tue, 25 Feb 2025 08:45:59 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6fa230sm1709220b3a.70.2025.02.25.08.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:45:58 -0800 (PST)
Date: Tue, 25 Feb 2025 16:45:48 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <Z73zvIbsXzJMCaNt@google.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
 <Z7zYLBLZGKim-5UL@google.com>
 <Z7zlH74/orq9HF7Q@Asurada-Nvidia>
 <Z7zqdrQn7Q8yXfcn@google.com>
 <Z7zxsbJsOFp41Dzd@Asurada-Nvidia>
 <Z70EnQ5CXacc4ysT@Asurada-Nvidia>
 <20250225160225.GA593877@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225160225.GA593877@nvidia.com>

On Tue, Feb 25, 2025 at 12:02:25PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 24, 2025 at 03:45:33PM -0800, Nicolin Chen wrote:
> 
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > @@ -95,8 +95,6 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> >  
> >  	iommu_group_mutex_assert(state->master->dev);
> >  
> > -	if (domain->type != IOMMU_DOMAIN_NESTED)
> > -		return 0;
> >  	nested_domain = to_smmu_nested_domain(domain);
> >  
> >  	/* Skip invalid vSTE */
> > @@ -122,19 +120,9 @@ void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
> >  {
> >  	struct arm_smmu_master *master = state->master;
> >  
> > -	mutex_lock(&master->smmu->streams_mutex);
> > -	if (state->vmaster != master->vmaster) {
> > -		kfree(master->vmaster);
> > -		master->vmaster = state->vmaster;
> > -	}
> > -	mutex_unlock(&master->smmu->streams_mutex);
> > -}
> > -
> > -void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
> > -{
> >  	mutex_lock(&master->smmu->streams_mutex);
> >  	kfree(master->vmaster);
> > -	master->vmaster = NULL;
> > +	master->vmaster = state->vmaster;
> >  	mutex_unlock(&master->smmu->streams_mutex);
> >  }
> 
> I'd leave the clear_vmaster just for clarity. Commit should not be
> unpaired with prepare in the other functions.
> 

Ack. I'd like to pair prepare and commit as well. I'm just confused
about the check if (state->vmaster != master->vmaster). Maybe a helpful
comment about what are we checking for would make things cleaner.

With this nit:

Reviewed-by: Pranjal Shrivastavat <praan@google.com>

Thanks,
Praan


