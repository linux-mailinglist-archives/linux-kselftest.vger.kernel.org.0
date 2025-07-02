Return-Path: <linux-kselftest+bounces-36241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBA2AF0814
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 03:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB323B333A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 01:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F261624EA;
	Wed,  2 Jul 2025 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t8IqLnjY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281B134CB
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Jul 2025 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751420325; cv=none; b=g3DnXRC3wDEoqliFH7M7YeXrWWkJQJugt/71mmfnxt7GVqjYC3gv/l87lRoxoTTGOxdWynpgA9JF3Ro93TD/6AYaXlGzD8E0czpXmKBxX/zn0nLYFMblnCUZ0TQ3/KOdGyvQyuMLMyBzgQpCt6vjwNx+/CPzC4A/bD5EgjeDdoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751420325; c=relaxed/simple;
	bh=vPktWFba1CaphVOiurjNVMsrvjbgo6h4NsplM3lBGxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWVjqfq6M/Z9B7KmulWowmYPRSWrh2Jc8HAeTshiMRcWcBGCHIyLEE5WzLLll9W58NnNRGVjPWYAoUJyc+mzufoXWSAtGuqifQ/Wdu6fB/6Nawf+XQkByP+6LbIMX56ducH3dsNyT0U7fgVH5pqY6KeeevAKc00puB2Jsah2zMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t8IqLnjY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-237f18108d2so319295ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 18:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751420323; x=1752025123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kp2cPDX2Gx1yqqbKf91cIrL6zATVqvS/PN2+ecRrrmc=;
        b=t8IqLnjYPzVIKJvLqEcu5L4RelzvpZlXd5WVV1p0NW72QL3BDNku6DZAAQndt51A5R
         R8E1uck1wsiTur+DaeswyeSy9Km91e/QwM5r6kZZDGD1Pmq2pE2mMiq5DvirzfwaziMi
         OxgVlvj7VLisQdOAUMlv8jF9kBu7qVTvKhPdbAFdOlZhEI9vvGeeVdIlmMbWUSsyu5C6
         fci+24DChMbsS4ptDZu6qy4BZ0XWcQ6om44Cp5knQ6hf18TkAQF4uifLwFKEX5oLhwDD
         TVb2GU8dNxtpbFG8ouYw/NrGgMUIpKVyn8I6oDNLXVJ3qg9aAi04Oi67FPx6Bzs2X4W+
         NYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751420323; x=1752025123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp2cPDX2Gx1yqqbKf91cIrL6zATVqvS/PN2+ecRrrmc=;
        b=ofTay1gfyUQaGVT+4j61qPYDaf8i0c9uiR8+Bq9rcCu3k4z01C8/hXvbikl3ZCavr8
         rMCTe5wKQG0YFKqDUro2hA3AeFAFSwO0IjY1FIS82ChS+3m5Bhqno0zLF/plheXJyaVU
         Ev1W2oY3fmnGwHFRQHhxgC8Fn8Ri1CIWxYIQXVYePj6mgLLH8ffiuLCDAGA7YF8GGeri
         IDyR1MxCuGBqUgG2GTXclnfwTx9ur/ODzUA6/A1OFsrJzCvlmyjmY/khPY2uqW1sgZI4
         1oczS1jqPn/W/iKgrLh9Ml2JuyOeUcYatyLN5wJ+7OjLN9d7QemeXon6HRLqLK1Gjk+v
         /Xtw==
X-Forwarded-Encrypted: i=1; AJvYcCVpdRQTSI5lBU+LHSFrj2Vz828wcX0YyR6x07BeM69GY5W4NdUULfQADFAQEmXpBNL5R6Wgd1WCme1F1SdqAW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/fBY2l2OT7YVXpUM4Y0If45dg/GvF7WANwdktP2Po93d+W+qL
	FHzRcrhu9ieN4h8l3NhzW7LKFSO093lSzIilspMcJQXGeIE9/xsnKbfR5ANrcOywnA==
X-Gm-Gg: ASbGnctraLTV/mkc4ckHeks0V0YxZh4qQ6aLGZlxeFmL/MQJhSCy+DvH92T+8nGTJ9c
	hjsWKHOI8+CFZi2IBFYVMUowAtHTAbipg78RPKK7UL0SS1EjZoCe3pw/mS/rlJeqcO4xVtycOmx
	DT4vOu8KD82N+HncsEALfgQoRZNd/vV+ouFTieRv8M/slsoC5EFTjzL/ZUNourTEuwY1W/yoZuc
	uOSBfne17rETOiQ6+ipTMhQP1B/CgJqEqbss4p5/utF+i05UoD3LZhedELfkYa+bFiAetO5MeBo
	ooeMpD+yVtqE14G8g9nlJ6h7tb6Co10z4CV++efY+2vC0cE0wLR86sXd+TmWjp/UAzLBWTjVA9N
	cqN5eU4SyYeqOcjzw9ddy
X-Google-Smtp-Source: AGHT+IGlz2Z9E445R3idcc5ZRjEaWuytfr7E4KLC8vSsZvwO+Dw22SVfjYoD7L1quVzpUqXy09mcbA==
X-Received: by 2002:a17:902:c401:b0:235:e1fa:1fbc with SMTP id d9443c01a7336-23c5fd70ee8mr4718365ad.0.1751420322911;
        Tue, 01 Jul 2025 18:38:42 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540b394sm13073470b3a.36.2025.07.01.18.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 18:38:42 -0700 (PDT)
Date: Wed, 2 Jul 2025 01:38:33 +0000
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
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aGSNmf5Q82xEbDpX@google.com>
References: <aGQGm1-i4M75b9Qp@google.com>
 <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>
 <aGQ_F7Qx3scbbA-J@google.com>
 <aGRDtYRXFLoT+PrI@Asurada-Nvidia>
 <aGRIctg4T6cQECx4@google.com>
 <aGRcPSwaJkTeUrMx@Asurada-Nvidia>
 <aGRmaOORg-YDfncY@google.com>
 <aGRozoIDIlgl9H9x@Asurada-Nvidia>
 <aGR55PUBnwb8qT8U@google.com>
 <aGSBTpY0nkdp2TTL@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGSBTpY0nkdp2TTL@Asurada-Nvidia>

On Tue, Jul 01, 2025 at 05:46:06PM -0700, Nicolin Chen wrote:
> On Wed, Jul 02, 2025 at 12:14:28AM +0000, Pranjal Shrivastava wrote:
> > Thus, coming back to the two initial points:
> > 
> > 1) Issuing "non-invalidation" commands through .cache_invalidate could
> >    be confusing, I'm not asking to change the op name here, but if we
> >    plan to label it, let's label them as "Trapped commands" OR
> >    "non-accelerated" commands as you suggested.
> 
> VCMDQ only accelerates limited invalidation commands, not all of
> them: STE cache invalidation and CD cache invalidation commands
> still go down to that op.
> 

Right, I'm just saying the "other" non-accelerated commands that are
NOT invalidations also go down that op. So, if we add a comment, let's 
not call them "non-invalidation" commands.

> > 2) The "FIXME" confusion: The comment in arm_vsmmu_cache_invalidate
> >    mentions we'd like to "fix" the issuing of commands through the main
> >    cmdq and instead like to group by "type", if that "type" is the queue
> >    type (which I assume it is because IOMMU_TYPE has to be arm-smmu-v3),
> 
> I recall that FIXME is noted by Jason at that time. And it should
> be interpreted as "group by opcode", IIUIC.

I see.. I misunderstood that..

> 
> The thing is that for a host kernel that enabled in-kernel VCMDQs,
> those trapped user commands can be just issued to the smmu->cmdq
> or a vcmdq (picked via the get_secondary_cmdq impl_op).
> 

Ohh.. so maybe some sort of a load balancing thing?

> >    what do we plan to do differently there, given that the op is only
> >    for trapped commands *have* to go through the main CMDQ?
> 
> If we do something differently there, it could just do a one-time
> get_secondary_cmdq call to pick a in-kernel vcmdq over smmu->cmdq
> to fill in all the trapped commands.
> 

Alright.

> And this is not related to this series at all.

Agreed, sorry for the confusion then.. I thought that the "type" meant
the queue type.. I guess it's all done then. I have no further questions

Thanks for the clarification!

> 
> Nicolin

Praan

