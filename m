Return-Path: <linux-kselftest+bounces-31860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F687AA05CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 10:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C27647B2E27
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D38927C150;
	Tue, 29 Apr 2025 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oAodT9uA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4262144A1
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745915483; cv=none; b=RTL7uoJms26jt9qn0sHRH4EGfUTu2ciP72vucMRMb4Wk5LrseXxVFyINURVahyO4jPNhzwDFcppQF9JgLhUUUWW8wJViMGS+qpO9OA43RxVEJasptdqu0/jRRIhmB9uqJN86PmLSCuLbrFi7mzJ00QMZPQELiiuzxbbEumf8tME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745915483; c=relaxed/simple;
	bh=85qKaVraS+9MNdskLBxSjS9ktFkx0yQSDGXvIR/OvQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ2kGIIiiESu7dlzIu7zgIk5NGZf/zZhwI1Venxd1uUyvbB/x5YVI1Owf3epMPbTE1U9yzgRkc6jHMcBIgOuyCEqXaGxKwxjtIRfu73azReXfQAGfKAT0Fht8VcJwo/akpBwV2de4bM2kPIWN5UvAN2ZMCVoD+DoRnH+0WY8+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oAodT9uA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2242ac37caeso52895ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 01:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745915481; x=1746520281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNi2KjTVYx94VsJLpl+aLzT0MDWDcyauEZBdUwqWejg=;
        b=oAodT9uAJPpRkgB3B/eY+TMN04Fr3Putxl7q1c9Y+evLoj9i/ms+hT5HWJDs1hTnOK
         d7wuMLxYD/czi7XXAIs+5pmHtC0hnxx1y7ekzhsOrYHXspWK5JDSm8bujYtOQCQCtbkH
         ap5kE5qJ4qsOjatA9vGFq+a6r52hqDc30+i8/EJ8Be3kEd4cDaQqDtFP8PszYpaOe6HZ
         cLf3ZMz2D3E1t04HD8iyhPcOoCCUa/G926U42LrA5DQ7CJbB0PV4Vz9j5y6WvWwQ+4Bh
         Xjs1lABiyE0wzToxARN4fCJLQ42WCqAwRTwVF31zt9jxP3EfB7LidjyQAmwW6wMQEpKD
         ZQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745915481; x=1746520281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNi2KjTVYx94VsJLpl+aLzT0MDWDcyauEZBdUwqWejg=;
        b=hLUEZPRBRYCRIEscpj+fWo+/RSh5qOgRTVeHgVk5vRPdEGcLisE27jWfeDXJYVq1t8
         TT/fsWBYfHD29qRcBqjy/TSWGjxz6mn8pngQ3aP0b9urC6BmMwKWfKWSUlOh4XKKvWGp
         q0Ex/9YWHwP+r7TIupMezPciCVlPlxm8Iu1NNWuHPUeZvsJr04dnr9UL8wWIErYt5Gd/
         XQQKfxK670xZklAwAt5d3jX/W/LjoHliuBSIda4vVenkwKNkYTmOt9LF1OXui+EbIwmY
         UkcMIoy2BLTOjgfMYukZ4Y00rJwlmf7RZi4On7DrMcrQlRqkTBiWU9b3G0mGgDwRoHvG
         Zfug==
X-Forwarded-Encrypted: i=1; AJvYcCVMwk15yFGf0oCw4nVU02vLpDuIKG1Fv2IJ2l8wEDF5Ql+fSpzXFycyC0EsUEdx4B5EC81LDgp8b3VMUqYCn78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjn4hxYCUX+gzCdHk291ZtiD/z11PVHXdzwsnQN17ghvpcdz2s
	w799DAuug4IVzXUcCGSpreCRpzHDpfFxCDJ1hdvg2n28Aj+j9rSdMwUHSsP+8g==
X-Gm-Gg: ASbGncupmdDVCQL8pAq7pPxAK9ppMg/05MM1h7dAvUS5RFrFXRiGBxPp0oFk5viW5bL
	byZZBCj7anF4D36U2HrQR+MSOyqvz2t5vBG2Oim3uF4201y+gtdF+b3szCdLbHayrzpFmnwgY/q
	Jk+X1a2Y6hWAZ1mUuxAn61Byvf4qf4DntPGZtiZmJsG89RJyMcWC2m6igaNyNy+ZRSg0ls4u4aV
	9rKWHmeRF/1QWPflL+DqzL8uYfF2uEfZf+zNhLcFNIBwldk3UXnkbhHY+A/uUYtC8zRRiB/4Up+
	8paE9PTC/VaRfS3V8fKHcAeAEnHu81IIAzJ/kcY3EGeyezMP9BOTTHrHp2ur2EnqoyuSRZKC
X-Google-Smtp-Source: AGHT+IEuwEN6Vz0nl2aEx/jObUHE3H07L74jGS/5bsNXpJR+QacDK6nh9jI6VmQObGdH+OZv4saKuQ==
X-Received: by 2002:a17:903:1cd:b0:21f:465d:c588 with SMTP id d9443c01a7336-22de6c52c70mr2586365ad.14.1745915480493;
        Tue, 29 Apr 2025 01:31:20 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef124ce9sm10440195a91.34.2025.04.29.01.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:31:19 -0700 (PDT)
Date: Tue, 29 Apr 2025 08:31:08 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 04/22] iommu: Add iommu_copy_struct_to_user helper
Message-ID: <aBCOTDDC8--age-V@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <ca032e90c0241fe0653023fcb655185dba763f5f.1745646960.git.nicolinc@nvidia.com>
 <aA-_5FQK0uZPdGVA@google.com>
 <aA/HN2CV+0UQ4S9j@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA/HN2CV+0UQ4S9j@Asurada-Nvidia>

On Mon, Apr 28, 2025 at 11:21:43AM -0700, Nicolin Chen wrote:
> On Mon, Apr 28, 2025 at 05:50:28PM +0000, Pranjal Shrivastava wrote:
> > On Fri, Apr 25, 2025 at 10:57:59PM -0700, Nicolin Chen wrote:
> > > Similar to the iommu_copy_struct_from_user helper receiving data from the
> > > user space, add an iommu_copy_struct_to_user helper to report output data
> > > back to the user space data pointer.
> > > 
> > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > >  include/linux/iommu.h | 40 ++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > > 
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index ba7add27e9a0..634ff647888d 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -562,6 +562,46 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
> > >  	return 0;
> > >  }
> > >  
> > > +/**
> > > + * __iommu_copy_struct_to_user - Report iommu driver specific user space data
> > > + * @dst_data: Pointer to a struct iommu_user_data for user space data location
> > > + * @src_data: Pointer to an iommu driver specific user data that is defined in
> > > + *            include/uapi/linux/iommufd.h
> > > + * @data_type: The data type of the @dst_data. Must match with @src_data.type
> > 								   ^
> > Nit: Must match with @dst_data type.
> 
> Oh, that's a copy-n-paste mistake. It should be:
>   * @data_type: The data type of the @src_data. Must match with @dst_data.type

Ack, yes that's what I meant!

> 
> Thanks!
> Nicolin

Thanks,
Praan

