Return-Path: <linux-kselftest+bounces-31942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7F4AA3988
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 23:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33FB4E1219
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 21:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945026F44C;
	Tue, 29 Apr 2025 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+Q9eO8x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E928E25E47D
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 21:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745962521; cv=none; b=dwiOWkNBt08D1due18vhMYEmF9vMsR/nNHK8P7uIdJ05GH1ocC8O5v5zRsDRKLigmzIktGvbVzdhDJf4nNXtrwnpg3d6hvdzXO85ZO+p7v0EyLUm/xNknoM4ywL+cgc01RyUxfjOO6mtCmx6PYlHduwuWJDXXa43Gl1q1J9mF5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745962521; c=relaxed/simple;
	bh=JFtp/04AN6971ALn40g4bC8CVWUHKgt3AbR5wojCJVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3LNrHe4+EcV4Qrsj1L7ijwAjZVFMqu3b4jdvJ7h2+DA0GAf/Ss5VT6oPrlLyZ4rJ/JLUjbgE24w0xydArRysWxyFcy/9KV6jDnOCcO9eJeaUbyALbsRqYtUOjnUcOvc4cQ88Xq6uHA7aLWGnq46nxKKHwkwJs1zRlNQHqViKwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+Q9eO8x; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2242ac37caeso74695ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 14:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745962519; x=1746567319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpYoUff4tpb7ZnYnv11tnvX2uEPBYr9ascXUqkCwOTE=;
        b=Z+Q9eO8xeLCUuo/zkudd1dLWzxcNVjezyNiWJnWo5t2NBqP2/gndruzvGck4whmIpf
         3F7EWJq3FFBl9hBOUZ6HKWb/W5eYowm7m9AfwjHzAIjH8J7WYRkOf8ga8xJEJ1B48knM
         2oBZ4gSsPJkWa2hDYd/D6lHKh+M6zVIiPBOQAyFMM2Ckqjg0vonp0JuxudO6qK064UmE
         rrDC29NTut3AJvmXvbOdvOxVwz2dwZkVaim0E6I5vqI4ORZjMVeeN3Su0AMd/XreXuc9
         33o0z31VlRCe1zcCHkLbgmelIsrI17mvFsQmbkFTH/8lfJzaJvs8i3jS6DFXNGR9vG9/
         /9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745962519; x=1746567319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpYoUff4tpb7ZnYnv11tnvX2uEPBYr9ascXUqkCwOTE=;
        b=RsGy8X9BXHt8d0fet5gqhv/tCZWFBLiNRI2nrLj7Wo7zz6a9OZVVIH6Nq0QOUDMZvp
         3WKtP69d+DRsnPPLXoQ9oTer9MFZCeX6M20GxXWbSJ6D+BXaisXDL9z2sX91p8yffJa8
         wz3wB+9PC8RROrkDESw7DF2Qe1w/pj1c1GlA3YZPVXyxUQAgHKrU+euhcMTJ+nl4L6ns
         +8occ16XwvDq/YKZ4nI7oR3plktnZQyd665LvbpVsGkpFRpg/hcLKeICjh+kXTPzvuwX
         RlN8kS8eox6VGZMnMaGhkGUAl2qSJctWE830jPq0gWgAuaWDA7QjYyG+MuzKozYzwN7n
         H0KQ==
X-Forwarded-Encrypted: i=1; AJvYcCURMkL7svSy+YReu+GtAukW75Ib5xH1LPjawTGEn1AUowOdUkqjxnujztbYbBuZbHltv7goMh0qmHJJDF2OEEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEiv2v3fsTR7BYPgAb6cIahLCjNf650uT0VyMUehsqK4UXpILS
	IBefyCaNi5RCZVM09NVvhge0fv8xNAbRYFi6QErJhJWm/2EGnbCpB+LG53BeZg==
X-Gm-Gg: ASbGncs2sNJwGtK6VrnuA5B62r2CXk2zzHB/k4HR0RvrJ+nBYS3JF+bhol5+2o4D2OP
	6OYNs5Qv2iDbrnG1tx3oO1r93YBL6MIat+kJIfSfswOf3Uez9zGyzwdjVUrtxapb3pThZXyqYgF
	8RhvD5kfuPQ5YmDttgkPdHSW2C9payVylykeiA7S2hPrwuD6UcjHbRjCoEOlHlqpVZqfsXGlwhf
	kHEo6QDXFaqHBI+lPVDZth3I/Sz99X9/TXNmZ7IiJN8w1a65njRzriRYh9JgAnblpp+uJNXVRum
	C3YeOVMJCXyj104blZne0FWvhV7waiSDNeSTRcLmbuDRj+/5aqKourkYVXc5GbPA4NllL7KC
X-Google-Smtp-Source: AGHT+IEiAc8Ows6C4iR4kgPCFAlWxuerupIBpLK64UuYqayp18C/qOLe733Vqo0YiAcQG8JFaBI7KQ==
X-Received: by 2002:a17:902:f681:b0:200:97b5:dc2b with SMTP id d9443c01a7336-22df54469b2mr228275ad.15.1745962518918;
        Tue, 29 Apr 2025 14:35:18 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3480f08csm42489a91.39.2025.04.29.14.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 14:35:18 -0700 (PDT)
Date: Tue, 29 Apr 2025 21:35:07 +0000
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
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBFGCxcTh54pecsk@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <aBE1gUz9y415EuBQ@google.com>
 <aBE38GwvGBnpRNLc@google.com>
 <aBE47aySzDp2lsAz@Asurada-Nvidia>
 <aBE800DsAOOZ4ybv@google.com>
 <aBE/CD4Ilbydnmud@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBE/CD4Ilbydnmud@Asurada-Nvidia>

On Tue, Apr 29, 2025 at 02:05:12PM -0700, Nicolin Chen wrote:
> On Tue, Apr 29, 2025 at 08:55:47PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Apr 29, 2025 at 01:39:09PM -0700, Nicolin Chen wrote:
> > > On Tue, Apr 29, 2025 at 08:34:56PM +0000, Pranjal Shrivastava wrote:
> > > > On Tue, Apr 29, 2025 at 08:24:33PM +0000, Pranjal Shrivastava wrote:
> > > > > On Fri, Apr 25, 2025 at 10:58:08PM -0700, Nicolin Chen wrote:
> > > > > > +	struct iommufd_mmap *immap;
> > > > > > +	int rc;
> > > > > > +
> > > > > > +	if (WARN_ON_ONCE(!immap_id))
> > > > > > +		return -EINVAL;
> > > > > > +	if (base & ~PAGE_MASK)
> > > > > > +		return -EINVAL;
> > > > > > +	if (!size || size & ~PAGE_MASK)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
> > > > > > +	if (!immap)
> > > > > > +		return -ENOMEM;
> > > > > > +	immap->pfn_start = base >> PAGE_SHIFT;
> > > > > > +	immap->pfn_end = immap->pfn_start + (size >> PAGE_SHIFT) - 1;
> > > > > > +
> > > > > > +	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
> > > > > 
> > > > > I believe this should be sizeof(*immap) ?
> > > > 
> > > > Ugh, Sorry, shouldn't this be size >> PAGE_SHIFT (num_indices to alloc) ?
> > > 
> > > mtree_load() returns a "struct iommufd_map *" pointer.
> > 
> > I'm not talking about mtree_load. I meant mtree_alloc_range takes in a
> > "size" parameter, which is being passed as sizeof(imap) in this patch.
> > IIUC, the mtree_alloc_range, via mas_empty_area, gets a range that is
> > sufficient for the given "size". 
> > 
> > Now in this case, "size" would be the no. of pfns which are mmap-able.
> > By passing sizeof(immap), we're simply reserving sizeof(ptr) i.e. 8 pfns
> > for a 64-bit machine. Whereas we really, just want to reserve a range
> > for size >> PAGE_SHIFT pfns.
> 
> But we are not storing pfns but the immap pointer..

Ohh... so we are storing the raw pointer in the mtree.. I got confused
with the `LONG_MAX >> PAGE_SHIFT`.. Sorry about the confusion!

> 
> Nicolin

