Return-Path: <linux-kselftest+bounces-37025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A087B0091F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD0F580961
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364752EFDBD;
	Thu, 10 Jul 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFQf7GuZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CCD279DB6
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 16:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752165807; cv=none; b=nnBcHfYULEr6Z8g/meepn/iJBxA1CQjILj5dhRsAavZM1WxK2MHb2xoctp53ENBoG9MLlwOXrDx1FPnHpaTj7Cl/dIe4Mo0GAIE3IIaXh3WJ4XybaJvgg2lU57hwFLeitvf8ala+hlZXpiJtHPmIBavtQCLsJUJ61vmBOPK4gac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752165807; c=relaxed/simple;
	bh=FL1g7AAqZse2G2GgfyKga3py6hCil3qJCjBWU6lZuGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BScnswGOqCVvFW7+UVK2i4KqjGfrJ10FOSEzHjb7UhzNrAp8MFdoQjUU++1dBxYYgGrWfQZADiWJFKveVZMTBhkJbF+jjn/fUVL3Gd45YEDUz0ulTYs9mQGNyQnbHAMj3IesexNIPR/YbdCggGAbq4iwJ9yA5BdemFFO76+3kK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XFQf7GuZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-237f18108d2so4125ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752165805; x=1752770605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C2eyvzlKuLCQH5Cuh9KFE8Y+QAaptwkDzMvAXLYmk8E=;
        b=XFQf7GuZbH1KyIoa57BV4TqJy6E92mnVa8uCzbQi52+CqIbMF9GJg+nAKGmJaN/kB9
         0x+spIswJlEDX993B+KfSuhQ6+K/UXj7bWa1/MLWgO9WDVF5OmCNHVU9ItZZGk57tEx0
         LM68M/IgJ4EWpUw5GFd8WY2jqYZ6W7p7RGvshlCRSWrNVxhZPFaxj8/GrkuiTdsdhzm1
         jywxosfleSczsdivfTwNzQmDtTbWtKehXrKn9WUFQurz97HmUQRELExM8pKzLiYocFrw
         2Z8Prs66R+Stc3awXY4/oLPKcruaBXjsguJJ3VODwduN5B+X2nplfUeSLOoT7HN5rf6X
         ptXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752165805; x=1752770605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2eyvzlKuLCQH5Cuh9KFE8Y+QAaptwkDzMvAXLYmk8E=;
        b=cxr3TIDaTBJj1hPt+f14TrsqFzcoj8yeDZEGWPnvhnoa+9a1TB8kkP0aeNhLm7L2oX
         MBMxy821uPvSXGg43z/fAupVzUVQrWz5IypKQxYu1Jp8oaXg0olFrfbwBBeuYNuH6s0v
         Hobvy5puV9ksu1DH4Q3gYjy1o6kqzNEGVoqkPDeouOFlrXCYgGh1AODHvw/CiAptLkS8
         la+BpXwvoJ1CusHWeX3KkteCnhiq+IHCUdb2bmtpbLjjOrwS0PIfj55/CkoFwymJBm/d
         xGGsfHN8lKElmbiIfXnFN50tgkeunsYEM/vfKBeoDHp55NFW5luT0XCkRlwbv9TAOHhV
         Jm3w==
X-Forwarded-Encrypted: i=1; AJvYcCUSlxSbRF/NwWEiox4onhhJbUh3Td1GAztCESQPo/O9JGGyiv8n5omeE4/2rPRgFuIdy7RFOHm12R9FOYOPAwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVzYt1QAnRveE9qR1pmvia7W9DJ1tePmz8PW3UZg8CHbKCQ3is
	kx9ou+mk+Vgy+Nm2Agg8//li9BZhTv2UvlDe24it9hI0JdKsDQhZDvoIzbZVmjy3Aw==
X-Gm-Gg: ASbGncvLw2Ijj5+nXtlZfY1CXgQY4lHZjAjN+hqjXjE4zFLrQZzX10pkYceonb1x6NI
	ke0nSeZ9UxuqxLTjOM9g4b2lvW5A0CwYw0jorogzdkh6QuNiDUWFdCS7yAPI68toKDo9GNQJydH
	1QkswH1k8TvQ8fGB4z2div1Lu0qh+g4FuCR0Kw5Hr9O5Ii8VWQrambwMMhMhCvUnCNWTOkg3uB5
	QmpHgAAVXPDatv8BFEb3h68RXRUPIZ2F0bd5fXqgeO7TrHWzzl6VZPD1LY0e8j7+lvXxr9hjUxb
	X3e+8USRVLs8gVQb6XHa1tYQ3Cwv/rA9Ob0Sl9M7Rxy2ZNHB1P4IEppeGSc14FM+MX/0t17nOsz
	qxViJYnx1RWKaPa/dTGadGGTp/BzNeFk=
X-Google-Smtp-Source: AGHT+IEFm5EK2K+aFRgM2luBkKYZSMINjT3NZbf79E/WEwhVEuFkFUby27jaM+gbx9d+ftRkB3XZMQ==
X-Received: by 2002:a17:902:e94c:b0:234:9fd6:9796 with SMTP id d9443c01a7336-23de43702c4mr3052595ad.19.1752165804369;
        Thu, 10 Jul 2025 09:43:24 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de435c2e3sm24897415ad.226.2025.07.10.09.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:43:23 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:43:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, bagasdotme@gmail.com, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v9 22/29] iommufd/selftest: Update hw_info coverage for
 an input data_type
Message-ID: <aG_togvop53dLSZM@google.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <f01a1e50cd7366f217cbf192ad0b2b79e0eb89f0.1752126748.git.nicolinc@nvidia.com>
 <aG-fZv39ci6yip3z@google.com>
 <20250710153202.GO1599700@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710153202.GO1599700@nvidia.com>

On Thu, Jul 10, 2025 at 12:32:02PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 10, 2025 at 11:09:26AM +0000, Pranjal Shrivastava wrote:
> > On Wed, Jul 09, 2025 at 10:59:14PM -0700, Nicolin Chen wrote:
> > > Test both IOMMU_HW_INFO_TYPE_DEFAULT and IOMMU_HW_INFO_TYPE_SELFTEST, and
> > > add a negative test for an unsupported type.
> > > 
> > > Also drop the unused mask in test_cmd_get_hw_capabilities() as checkpatch
> > > is complaining.
> > > 
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > Reviewed-by: Pranjal Shrivastava <praan@google.com>
> > 
> > Note: I see a couple of warnings while building the selftests on Jason's
> > tree, but these seem unrelated to this series:
> 
> This is fixed in v6.16-rc5
> 

Alright, this was on the `for-next` branch when the head was at:
3e2a9811f6a9cefd310cc33cab73d5435b4a4caa
iommufd: Apply the new iommufd_object_alloc_ucmd helper

But I see that on `for-rc` [1] the fixes are merged.

> Jason

Thanks
Praan

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?h=for-rc

