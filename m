Return-Path: <linux-kselftest+bounces-37077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19349B018E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 11:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270191CA65F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1634727EFF5;
	Fri, 11 Jul 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SsrFIhsZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7170027E1AC
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227831; cv=none; b=O8ct0TIPrfV3zjj4DL4leV3yhv+apsWiHyVTi+G4v3Bt7jdsI0W9dLLoDihDEYbTdjXmT8Uhzh3WAnO0pA+eCwGB0G/fvTDBEoZIQ/taeucyY8FXH63UjDYEh05V1cBMN0EYMHrWDoMy8VZjHc7mIPhjNixLODmiHJkvAdV8Dq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227831; c=relaxed/simple;
	bh=CcCFu81EIf/YY/BJutLKyo09SLthVV/6DIU00FEEjUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4ont4S5PrcetKSKL/DjSW9GDXxaz6pXcQZkM2va+1Fus4msR0vkyrnbP+gpmaGaFcMpLVBkcGwDCCfPbSkkXzIe5+2r4eONvH7hABJZDA1GWL6SQ5i0gz/KTjm1v1bES1KzCyZXaeju+bXI8Rg+iTfQjOAwkUJa7YoDsvsWsf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SsrFIhsZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23dd9ae5aacso105365ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 02:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752227829; x=1752832629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=034zD2t8+j7QVlHQTTa3rHmzt0sqsL2Mdd151xEc278=;
        b=SsrFIhsZcmjYKiuhtqGdElOvp4l+++ZSKFHZ4k8VTWpB3d3JZvGAilwD3laej5tM0Y
         r8QjfSb7vTqSlWINRVzpRw5XhLREMXFYsC7YLTNmDZqBwX+MywyIz8UuGrf1w//LUs0/
         xWbWoacN/KMtpTBwjjrU2ygKmU90yjfKEB+fbkXVprbm7UXDawjIPP6DOah0odSj+VNm
         R4eoHYcS7+MmX2vDQM8tfZ8e9mZrnRGOoTALbzFdiU7JkLMOMDP1teFgCCD45MhcohOS
         BpohdkprnVEMQeLOeZzoNhv2K3m2/ZJsiFvcAXwsbgG/8MLTavEHeWCFPS67/J/B5xTo
         2eYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227829; x=1752832629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=034zD2t8+j7QVlHQTTa3rHmzt0sqsL2Mdd151xEc278=;
        b=hFfa/vBvDj5kqIHeZipCQYk4QzPuncNTus8liuSY60mu3x/PiPMJmIme5jJrWPLgO7
         yM2CZSViw1rhhYCY81e7TGYC3GgRmuXcoC8RoansrP2jceF8pP3cWbUHfhzHSLNl3Lnq
         FoDOHNJyYCHrPR3TP4PpigFcd28byW8QOq3npw9NV0rq9mDEGtsGodW9KFzZ7Hwa/1lo
         7YIz/OzcrB/WnkQ7GaOP/EV5cVRujVL+mrSkqLq48XojHf7B10UcQz8SMc19i6hA4TsH
         p8e+spzpJ4DCoU9/CR696YhCmk7WJ9Y8BqvvHcmlnDrburoSMxVW9OPZGJpkxXSi9xuU
         AMFg==
X-Forwarded-Encrypted: i=1; AJvYcCXxnYT26Uh+aaZtQ/WpRNsHJV+A1eys+pmH9PUkNxkF0rk5nOalyf2dsgdUt1d1GULXfm8dzw5xhDLf5MgObdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0jChV1f/4XhEoOD0KyXWw1Z5/uvC0S4Xfnba85vKiZ4rQGAuQ
	/ICato90K1xCkgI/AQUzTt5BdB45apoG9Gx52EQoMT1edOf3mD9sLBtxJTBIsfkFjA==
X-Gm-Gg: ASbGncu7wJTXLDkZRMhvwAgNazYuBdJYtPaCfJRbYH9S13TLuYwwKc/f89tQ0sRqq8P
	dog0Ns8Wp6NUxbWH6dVWns0KIHmy96XVsL/lZIz3LKQIEiXuUrzqlGfChC5vvWq791a70swDcGa
	mekov9sUrucZVf3A19M6Y1ypQFCVSqAq3cd0F9UQ9LIROlaULPWHxJOc2mMaxdJsoi08q/PLhqI
	y9wZ1N3Ph1PTz87DM7eDQkjHlKLxZrWy3kB/xckhrN0Wp8CcUt+ArvtiTEKbMG9F4sqbbHXYUx5
	lhRA23fsP9YZA2eL/OcHxVda2SETCCf7hUTnBQDtDzR848tjdWIIyvsSTTpC1OetMXRLN63Qg14
	7uDCLn79nObA0YM3tBdvqv+qTjdIKupkaGJvMJ+r05VQ+oSPpzawD1D+P
X-Google-Smtp-Source: AGHT+IG6OJdkdwVAu17LyTkPAnvBK7l4yng4G46N/h54a/NCPDtWUMAP3Y1SEP2980Km3pvxW+HZDg==
X-Received: by 2002:a17:903:fad:b0:235:e1d6:5343 with SMTP id d9443c01a7336-23dee273e89mr2500075ad.20.1752227828514;
        Fri, 11 Jul 2025 02:57:08 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3008a610sm7731211a91.20.2025.07.11.02.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 02:57:07 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:56:59 +0000
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
Message-ID: <aHDf6w1gFcNKNtGc@google.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <f01a1e50cd7366f217cbf192ad0b2b79e0eb89f0.1752126748.git.nicolinc@nvidia.com>
 <aG-fZv39ci6yip3z@google.com>
 <20250710153202.GO1599700@nvidia.com>
 <aG_togvop53dLSZM@google.com>
 <20250710171216.GR1599700@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710171216.GR1599700@nvidia.com>

On Thu, Jul 10, 2025 at 02:12:16PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 10, 2025 at 04:43:14PM +0000, Pranjal Shrivastava wrote:
> > On Thu, Jul 10, 2025 at 12:32:02PM -0300, Jason Gunthorpe wrote:
> > Alright, this was on the `for-next` branch when the head was at:
> > 3e2a9811f6a9cefd310cc33cab73d5435b4a4caa
> > iommufd: Apply the new iommufd_object_alloc_ucmd helper
> > 
> > But I see that on `for-rc` [1] the fixes are merged.
> 
> Yes, Linus discourages back merging rc without a going forward
> justification, like following patches need the rc patches. Fixes some
> bug is not a justification...
> 

Ack. Thanks for the clarifying!

> Jason

Praan

