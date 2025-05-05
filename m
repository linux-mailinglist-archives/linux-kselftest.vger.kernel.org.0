Return-Path: <linux-kselftest+bounces-32430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BECAA9BDB
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 20:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A4E188E43C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A048025D53B;
	Mon,  5 May 2025 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C3y0wwI9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F52DDC3
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470834; cv=none; b=cBnUsPzvAKAhSQJ0dkLZFI4OjkOUg4e0F8efVed2WqFPGzhS6NbQMIyxKfAPFlsZQvV5jlmJWsNFLSfaGHpZNQ5ZG8cIn+HkoXRcDD1MJAoozNbUjHDnvm9OiVP+w0RSpHercaL4etlS4tyjADCD1QLObDM7jwNJ0EUEvKRr7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470834; c=relaxed/simple;
	bh=uBJ7Sa/PrR5rePngwuntuhMPWvr7I69Vj5BV8YF5Qnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvh0d61BA0Io8rTQsSPo/ZWt7JIlVqICwToYrU3oKXeBu2wYW0BzBJV8+O7c3l7T7J0P5WUfKptoM5d8egKvvrjpL45DHs+7FqvTQ0uiF+fWftdvHiLZvyHYiNaLbrGy6IIQwMaprXcr+HV/f89O0n7MCmz3ss2H6hv5xWGNysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C3y0wwI9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22e1eafa891so25765ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 05 May 2025 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746470832; x=1747075632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L+ZVcMDj6eiAq+w7fHgu0Ionz2mUULkjJy07tfVzR30=;
        b=C3y0wwI93/TzbpMNwjEDs7rn8gi6OVtMdnAqMQVutgwYizMvJuC+1iXdjIxVMDNYll
         gkUQMOhC9sIEgz8yQD9S8NWn9WYr+NUybXdloYDGTmi45kHnb3PCNbZAKs+xwku9ZBHB
         5kLqAVHnFAowBHZsENj4dkpTpV0Q0mOv90yEZX7RwdVtAzGLbSwcVrXkQ/4t1H7Ia+Hv
         j4zUQdDSzDsWU7fuH1bHzwf71Qm4UXqIhFc33zQZAZP2mpC09olKBm2xq1mehATDEzYn
         uFC2PF8NBPscgSwVjFuukn4Qh5rtYjl3sI5p5ImSai2iA0UnJ1+ZqMWfwI/JstxESJZu
         D6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746470832; x=1747075632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+ZVcMDj6eiAq+w7fHgu0Ionz2mUULkjJy07tfVzR30=;
        b=oK54NROHMJv9dCRTxnqg9PHjolzLq4JrsOENa0gcZT2/r6AX1OFNsnXOkeciLzuBzk
         0rLRaGQfDwali3przCOBWjQOhlbWzz8x37/zgqsIoH4FwVj1Gdq2l28sCkYx8nEffwmi
         itUPfP6esZ80hWkqOMtGp043BIdDq3AcUlT/vsZ4RuRHcT21ypWHKEw/FXlgcj06RD0z
         iIKqi//27HYmphM/BZZzvYhGb83d16Cla22Z9U5zNRK5G/eFGqVOh/V5BXlchwfQuy6B
         p6gt8ozUg5dn6XVfsFik7eE1FygG+H4iuI5P1N1EPJuGKGIgA95wEp8/wwQiMjp8v0du
         WWMA==
X-Forwarded-Encrypted: i=1; AJvYcCUudCV9eMcgpeuKNH3C189dqtcZkMUkFQ9NgeZuESP6BM+3GJ9Afrumu/hMVHI2Vdj4SN6OgB/auIVmYtJ5vGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycPJw/8Fn1Z3ZWHZUcjE3aY16yAQa3qWx7EfSrXcH2yrdS1XOl
	2KeR2cIj0OMzOJ5SUI0bfyYe1/+o9GvR4AKn52jxx20a1SieoodbEPjj/PY/2g==
X-Gm-Gg: ASbGncuRW64rsMRFXJ6+V6ImcQm72g4+PBvID4visuNakuuPiYsjG1xTACL4xX9Zkmt
	zXil81xmrhjHXXKeSmFre3AXNJ6ZK/V+Mgqs/1D1Jp5dWGmNPnwB8Hs66ZE//BQ5JymoE/vfCSh
	sEheEhu9uaTgGVrROFcA6NJS1ItHfpYoEM4V8mrU4kOL5KMD023zsaeRret6kSiONLCD9rgPseI
	Hj0qEdOphihdPP644pyOSXRKsKS/eBHYVIVm8XLR81ZDWyyl1G8eA45FVeCFYvlIYqXN7UPb8cP
	XqMW4u14D59eIJyKw6Qr+6jCiZN1DM9w4yPkmt3S7Y0OJJTGGpfRcuh2NJz2mSaGDJfSPCqzgJR
	/KIN2uR8=
X-Google-Smtp-Source: AGHT+IF+yI+Dgd32z62Vz4IkzG0Ih79IcbEYi6NeCGDCJdKqEO9PIlfWJBKMKIGX6EtzZ1WS3NzDOg==
X-Received: by 2002:a17:902:da2d:b0:21f:2ded:bfc5 with SMTP id d9443c01a7336-22e3508e4d0mr352355ad.28.1746470831803;
        Mon, 05 May 2025 11:47:11 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1522054esm58673755ad.118.2025.05.05.11.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 11:47:11 -0700 (PDT)
Date: Mon, 5 May 2025 18:47:00 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBkHpJIeDxJJSxeS@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <aBE1gUz9y415EuBQ@google.com>
 <aBE38GwvGBnpRNLc@google.com>
 <aBE47aySzDp2lsAz@Asurada-Nvidia>
 <aBE800DsAOOZ4ybv@google.com>
 <aBE/CD4Ilbydnmud@Asurada-Nvidia>
 <aBFGCxcTh54pecsk@google.com>
 <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
 <20250505165552.GN2260709@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505165552.GN2260709@nvidia.com>

On Mon, May 05, 2025 at 01:55:52PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 29, 2025 at 02:46:25PM -0700, Nicolin Chen wrote:
> > > > > > > > > +	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
> > > > > > > > > +	if (!immap)
> > > > > > > > > +		return -ENOMEM;
> > > > > > > > > +	immap->pfn_start = base >> PAGE_SHIFT;
> > > > > > > > > +	immap->pfn_end = immap->pfn_start + (size >> PAGE_SHIFT) - 1;
> > > > > > > > > +
> > > > > > > > > +	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
> > > > > > > > 
> > > > > > > > I believe this should be sizeof(*immap) ?
> > > > > > > 
> > > > > > > Ugh, Sorry, shouldn't this be size >> PAGE_SHIFT (num_indices to alloc) ?
> > > > > > 
> > > > > > mtree_load() returns a "struct iommufd_map *" pointer.
> > > > > 
> > > > > I'm not talking about mtree_load. I meant mtree_alloc_range takes in a
> > > > > "size" parameter, which is being passed as sizeof(imap) in this patch.
> > > > > IIUC, the mtree_alloc_range, via mas_empty_area, gets a range that is
> > > > > sufficient for the given "size". 
> > > > > 
> > > > > Now in this case, "size" would be the no. of pfns which are mmap-able.
> > > > > By passing sizeof(immap), we're simply reserving sizeof(ptr) i.e. 8 pfns
> > > > > for a 64-bit machine. Whereas we really, just want to reserve a range
> > > > > for size >> PAGE_SHIFT pfns.
> > > > 
> > > > But we are not storing pfns but the immap pointer..
> 
> That doesn't seem right, the entire point of using a maple tree is to
> manage the pfn number space, ie the pgoff argument to mmap.
> 
> So when calling mtree_alloc_range:
> 
> int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
> 		void *entry, unsigned long size, unsigned long min,
> 		unsigned long max, gfp_t gfp)
> 
> size should be the number of PFNs this mmap is going to use, which is
> not sizeof() anything
> 
> min should be 0 and max should be uh.. U32_MAX >> PAGE_SHIFT
> IIRC.. There is a different limit for pgof fon 32 bit mmap()
> 

This is what I was thinking as well.. why use a maple tree if we aren't
allocating a range to manage pfns.. I was still thinking about this in
v3 which made me hold back from acking this. I'm glad we clarified this!

> > > Ohh... so we are storing the raw pointer in the mtree.. I got confused
> > > with the `LONG_MAX >> PAGE_SHIFT`.. Sorry about the confusion!
> > 
> > Yes. We want the pointer at mtree_load(). The pfn range is for
> > validation after mtree_load(). And we are likely to stuff more
> > bits into the immap structure for other verifications.
> 
> Validation is fine, but you still have to reserve the whole pfn number
> space to get sensible non-overlapping pgoffs out of the allocator.
> 
> Jason

Thanks
Praan

