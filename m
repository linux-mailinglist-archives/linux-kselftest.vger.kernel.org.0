Return-Path: <linux-kselftest+bounces-27319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA14A4147C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 05:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B97C165224
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 04:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A611AAE2E;
	Mon, 24 Feb 2025 04:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kizl+SjV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602AD1A3160
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740371912; cv=none; b=VNv0NVc856swFw942YotLEHHfdwTdBhbbADpe5cbJqCqDl5GeLzsGCHzFcd/RLCgrcm5f9RDuAfF2nAmoymgzPVWCzZwZXixJde8gD0zGWt8XYZyq3DUxcND8VEJ3+BcHz4CCvhWEY/Ba5Ow62dUxcrxGHAUA4iUju1ds06QTVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740371912; c=relaxed/simple;
	bh=Kxoqux8ig1bneZc8TPbOtwtdCXGrWd1siptghYniyZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKF/pLECdDnVJM88qIogWq60+Vw10iUYUOOgWaRG7HedtLDyOlngMv5z2dmNdA5kNwfiJnOltkl5XNlBKYubgpLTA+a6Y7p6cVjUzOjpS/Tfq/3RL21+exJcvtfKfxzTZ8DM4diyEuotbSt0137HheDG1DlVEv/UAw89VeARj7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kizl+SjV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e0575f5bso256115ad.0
        for <linux-kselftest@vger.kernel.org>; Sun, 23 Feb 2025 20:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740371911; x=1740976711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QXOPbjowj6Hzwuap/XS84BFQBW4l8rdr65xne9mv6JE=;
        b=kizl+SjVEdYyYRBc+wlQ40LGSLSjwyo74CUKXBJYTdQLSFnF1eF2ElZxbaI8cyiv2H
         iKXCmR1sc2skCyXMiEs3MdQookieYK7/EBInHWlvPT5C6w9HvfnA2bjVRfpcm2dB/PlC
         jqusrzMadkjxeehlc49pXSVi2cgRs92EY+VeMpFYaQ3PqgXCAzyx4GeD0kTbfVG+FcEC
         IFbIxzFqvCW/+BUyLaXZPemWIpWDcDlqyrJFIRMj0HKUQmNJdFXdafx1TUHwhGlRiEco
         GXutFi16dxX625XC5c2xILjip9Vdci3aL2bkBEaM95A0f/E1sSVDhu3PPoiAnFWGjxc6
         tS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740371911; x=1740976711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXOPbjowj6Hzwuap/XS84BFQBW4l8rdr65xne9mv6JE=;
        b=TZ3FqaDzlFlJOo1+2Pn9WsYAd52IGawPla+CLaxm/TzZTlxY4ScuQyGfnK+H2N3Pzc
         zh8H+djqwKB5tdtrFWAcdRYeUd2VgblWIH/5LMKwRViMa2F009ObS7AGjJ58+5h0sceA
         I1wm8E55wTXbF5GUZFW/el+AmojjzHSzTLpeq4UzbLU4F0ivExTtGlV39xl+NsQ61CQH
         NJ6vB4FNZy6s6PTnLloU2xxaprKTmD4TReKm6QJC903ts6v5PPtQA6+AIedezJiCkAQ4
         IzJ36YeFN4sCrrBYrWnqy+0cqNR1u1pFrw7mPopj/KTF0V3iHV5amWJUHMx33HZ/A72l
         4tZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdX1xAVe3ZhiJr/u9qzFQaYkZoJOQ64mxvmEASkLWVuaQpDDSSwDWeyOXOECaIdu5SyqZ2LXHlhh7hEwCi3So=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr9OjPJT4G/D9T+ZH3Cz7faCiTupvFYYBikKp21PWLkpC9i1/c
	MjDgqZlE5I+VpTwpaFsG1pCJmV7zcn0dy0GXEc606ShN5ZTAbUkTAqURZBWk7Q==
X-Gm-Gg: ASbGncvEQHOBd9PxlURn2jyxA9fa38AQVTZrdhYun5BJ41B9PjlBcAsXBXcbzY3m3VJ
	cCmxY0nJxY8m8c+/Wr9qryFupbOP+YtYCUECC6N5HLFkMXF87ikkRvbw8CQAvuymZrq6YdConUU
	LJtJLqcftIYdN/szpsCVT1NT/O6CYANJIb+nOy5mrZJS8pmKibn84dUaGBEplc9SoKEqhuRiZNG
	bMG42hXCtJEpWk4oPRKZGlll7VRWZL6gypuqIOJ0BlUXXAT0EpEMWvddO7CFOnbTQNKXfMtUXlX
	6Ru7BMh+Cn2g1ZpnTfm5PQ889VnB36rOH0XtJlb6hbvISj14FH6xjT0hv0BVum8=
X-Google-Smtp-Source: AGHT+IEdLGzG2X3YEfsIyog+f9j0aXsArsFeUuMcB+n8G7DuxjBKyqLer9ZGTISS6pMA8Im0wRP9Ug==
X-Received: by 2002:a17:902:da8c:b0:216:21cb:2e14 with SMTP id d9443c01a7336-2226cc46c3amr2333105ad.21.1740371910429;
        Sun, 23 Feb 2025 20:38:30 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add540f75f7sm15349070a12.46.2025.02.23.20.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 20:38:29 -0800 (PST)
Date: Mon, 24 Feb 2025 04:38:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 14/14] iommu/arm-smmu-v3: Set MEV bit in nested STE
 for DoS mitigations
Message-ID: <Z7v3u55JNDqveAuD@google.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <2b088fe8d2c7e692426b0d1f58d4f2c12ecb907e.1740238876.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b088fe8d2c7e692426b0d1f58d4f2c12ecb907e.1740238876.git.nicolinc@nvidia.com>

On Sat, Feb 22, 2025 at 07:54:11AM -0800, Nicolin Chen wrote:
> There is a DoS concern on the shared hardware event queue among devices
> passed through to VMs, that too many translation failures that belong to
> VMs could overflow the shared hardware event queue if those VMs or their
> VMMs don't handle/recover the devices properly.
> 
> The MEV bit in the STE allows to configure the SMMU HW to merge similar
> event records, though there is no guarantee. Set it in a nested STE for
> DoS mitigations.
> 
> In the future, we might want to enable the MEV for non-nested cases too
> such as domain->type == IOMMU_DOMAIN_UNMANAGED or even IOMMU_DOMAIN_DMA.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 1 +
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 2 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c         | 4 ++--
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

