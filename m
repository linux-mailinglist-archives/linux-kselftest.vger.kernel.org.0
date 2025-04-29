Return-Path: <linux-kselftest+bounces-31947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A04AA3AAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 23:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55FB51BC3F38
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 21:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2734F22A7ED;
	Tue, 29 Apr 2025 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1a2S72/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A826982C
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745963879; cv=none; b=PHe1PDzS0l/lpHAolLM7n2CcY4q1y8nUwuvN1hFNd2SEr7CWP+uIY2CxQSbpR2nkVvg3dEBjiaxty4Ga7BVXxTd6XjGlNszNPJG1GzAALHsoHSf1+lGkkqYdze4n54B7MU+QZ0pfqBtZhHVdgIt4Gq/R9plwtY23KuR2K9XzzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745963879; c=relaxed/simple;
	bh=JxqDFFtO3S8kK/E3hLQE8+QiBq8AOwa6PH5SwIKxxXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rV+IMIQj5ZwYeIe/zbontuiBXee1fBxQpPFZLkJ8xnHFpP+Ay8yzHpsrITOQRw/dVFwXV4u5bbkpQLjFRhIRzdByV5CVnQOkqPy5FbHorgCEwvSYhKxKPrlnJIetU2nsVw5P2jI/fPuZInc4peIIlZ1e4Y7v5d7TxsMhRiY/ygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g1a2S72/; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240aad70f2so244045ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 14:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745963876; x=1746568676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dRuE0k+DaKR+dFrI7c28XxIZx1ZsULnIcimVdzgk9ZA=;
        b=g1a2S72/cymW8kXsuX2UJmpNGyOr7BOSEhUThSr76hs+EfSG4XfDT+hLAlQIFIy56D
         y9WXL+RqV29Yz48FYRPUDCQh8BQ71rX2JAnxk2LzEvWartDfX9+W3m8cMDh3q6zB1DHw
         BtrSsdujbmr8EbQK9UCAjaF01304FkIIVKXU7BxibhSLDvnUCXCfs4AflNYgjOv/uwx+
         0JCxZPacY7IZ8rdj4c7eoKvjxBisGQTy4p9vUgM8O6KZWTGFO2OennRqhed4iuagUPmt
         v/6GcqrdFRsqN9kXEz0sI00V6iQOT8xPTT4dAuUYoa2PFIAX7baVUBLz/V2pesxQm1/J
         cC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745963876; x=1746568676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRuE0k+DaKR+dFrI7c28XxIZx1ZsULnIcimVdzgk9ZA=;
        b=elHK0fCmQwSZo6nqfodpzlboayNIn3CaOHA9BMvA2MEcat33qLqsYycDDTungjbOVd
         Z3ez831eavPfV7BHTl/cjUkQvbBkKPSKJgxC9ctS7HBeJ6stDXc+8yR/fWAUZtAtMbqa
         izk026FUOfj5hHCFdwRTSYv/tsWL/BFLSejRSbqjQkMchGsIQJ+ztllT79TMC7gIWfKm
         7IN0tA+EskOFbujXlDwsSv6UM6GklG61tmVFh+UtNxB8TMHLZilo1IpqPeJxdCUU+OOa
         V1BA1ESx2CxoAnRZzRUDNzi37U0khv1OZn2eH3GfhUJKT5+9UHpLd9uHDD1iOelI848F
         TJMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb0lQxlDDqU7MOyJpYz5uBx6LpKYbO3N9wxG3tEExFh7R1XlqK7JHiFT6ZxKP5IvcRBgcgoxVggcRzK0eHP6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2+Q7INuJEaZ1LGWOD192Ru5Zt5Bo78HiralxMEYCBJVgFGOE
	FOEdXz39T4uxSbgVs5yBK/ADyR6QbTHyNBn2SnKs/OwdHkYUFwoBD3QskIGpAA==
X-Gm-Gg: ASbGncsZQkVGSNBWiLV2INJKT5e5urhK41nwdoP2QMLAsB2LwrevzDFJ2F7zwh2ZlsW
	MS2rSo4wlvvcQFRi7zuGrVf7MJerQByQKsySz82qd1jlmFJ/1ZelIdb3DH4eglmWcThSQijkEUS
	JjYHTHcKeeJl8O8aqJmblq/AsChaetuKxP2+JUT0hgMwlX1U4AHtz6Wcd9qOxCqu9fJvXJocVht
	MeZAjCl34J/cN4YmHkGJAnG93b9IL4ZMa9hEkODHRtDMWTswpmTej4pKyX1GY25cPyfdqsewSb8
	PeD9+Y+Du3t4GRC0QV5pju7/sl0q1qe5K66DM8l/zGXzT7czeYHXow5V1y/MzV+PM9u9AIiFP8m
	G+38eJEk=
X-Google-Smtp-Source: AGHT+IG2GQrBKEV0sAuQTzjtnWFNlTLvqHxPy8UFJFeAPu3X8NPH7IbodXwNU55E95G96pW683QFuA==
X-Received: by 2002:a17:902:d489:b0:220:c905:68a2 with SMTP id d9443c01a7336-22df53e1f95mr331695ad.5.1745963876294;
        Tue, 29 Apr 2025 14:57:56 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5104ec7sm107543895ad.175.2025.04.29.14.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 14:57:55 -0700 (PDT)
Date: Tue, 29 Apr 2025 21:57:45 +0000
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
Message-ID: <aBFLWUvzvwtFXK5z@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <aBE1gUz9y415EuBQ@google.com>
 <aBE38GwvGBnpRNLc@google.com>
 <aBE47aySzDp2lsAz@Asurada-Nvidia>
 <aBE800DsAOOZ4ybv@google.com>
 <aBE/CD4Ilbydnmud@Asurada-Nvidia>
 <aBFGCxcTh54pecsk@google.com>
 <aBFIsYg+ITU8RvTT@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBFIsYg+ITU8RvTT@Asurada-Nvidia>

On Tue, Apr 29, 2025 at 02:46:25PM -0700, Nicolin Chen wrote:
> On Tue, Apr 29, 2025 at 09:35:07PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Apr 29, 2025 at 02:05:12PM -0700, Nicolin Chen wrote:
> > > On Tue, Apr 29, 2025 at 08:55:47PM +0000, Pranjal Shrivastava wrote:
> > > > On Tue, Apr 29, 2025 at 01:39:09PM -0700, Nicolin Chen wrote:
> > > > > On Tue, Apr 29, 2025 at 08:34:56PM +0000, Pranjal Shrivastava wrote:
> > > > > > On Tue, Apr 29, 2025 at 08:24:33PM +0000, Pranjal Shrivastava wrote:
> > > > > > > On Fri, Apr 25, 2025 at 10:58:08PM -0700, Nicolin Chen wrote:
> > > > > > > > +	struct iommufd_mmap *immap;
> > > > > > > > +	int rc;
> > > > > > > > +
> > > > > > > > +	if (WARN_ON_ONCE(!immap_id))
> > > > > > > > +		return -EINVAL;
> > > > > > > > +	if (base & ~PAGE_MASK)
> > > > > > > > +		return -EINVAL;
> > > > > > > > +	if (!size || size & ~PAGE_MASK)
> > > > > > > > +		return -EINVAL;
> > > > > > > > +
> > > > > > > > +	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
> > > > > > > > +	if (!immap)
> > > > > > > > +		return -ENOMEM;
> > > > > > > > +	immap->pfn_start = base >> PAGE_SHIFT;
> > > > > > > > +	immap->pfn_end = immap->pfn_start + (size >> PAGE_SHIFT) - 1;
> > > > > > > > +
> > > > > > > > +	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
> > > > > > > 
> > > > > > > I believe this should be sizeof(*immap) ?
> > > > > > 
> > > > > > Ugh, Sorry, shouldn't this be size >> PAGE_SHIFT (num_indices to alloc) ?
> > > > > 
> > > > > mtree_load() returns a "struct iommufd_map *" pointer.
> > > > 
> > > > I'm not talking about mtree_load. I meant mtree_alloc_range takes in a
> > > > "size" parameter, which is being passed as sizeof(imap) in this patch.
> > > > IIUC, the mtree_alloc_range, via mas_empty_area, gets a range that is
> > > > sufficient for the given "size". 
> > > > 
> > > > Now in this case, "size" would be the no. of pfns which are mmap-able.
> > > > By passing sizeof(immap), we're simply reserving sizeof(ptr) i.e. 8 pfns
> > > > for a 64-bit machine. Whereas we really, just want to reserve a range
> > > > for size >> PAGE_SHIFT pfns.
> > > 
> > > But we are not storing pfns but the immap pointer..
> > 
> > Ohh... so we are storing the raw pointer in the mtree.. I got confused
> > with the `LONG_MAX >> PAGE_SHIFT`.. Sorry about the confusion!
> 
> Yes. We want the pointer at mtree_load(). The pfn range is for
> validation after mtree_load(). And we are likely to stuff more
> bits into the immap structure for other verifications.

Ack. Got it.

> 
> Thanks
> Nicolin

Thanks
Praan

