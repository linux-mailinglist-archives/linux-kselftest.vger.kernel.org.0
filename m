Return-Path: <linux-kselftest+bounces-36229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2499AF072B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 02:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB59C4A0073
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 00:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBDB195;
	Wed,  2 Jul 2025 00:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cxzn6tqP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3790710F9
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Jul 2025 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751415280; cv=none; b=e9LaKdkrUYkR7f917KtYPjiLP+AVKE+/52Ei5jgJWBmUrKw49SMhz0PUhMLtWFqhK7EnTYBsgeJrIon+8o1admAiSytCUmXeBCjhOJkBmTHfL8tTHGRE+lgYlc25MwMYrLzmvZvHETdQzK5r/ojb7G3VUPHwk8XBkFRgL5PiqEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751415280; c=relaxed/simple;
	bh=269QJMUMdHzfHuz4jq/gGMWfgE3bohbbwQ/J8DDsB00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwr0K7sJlRdClV2quVs9KnJAyL2VZM0SfkpEUbazbH5VE8dTnbS3K8EL44AvUnRePyKteLGAKK8FAQKZuq+/F3CDguUXYv/+Y3mT/zH6E8Hhcp2D3R2V4XEiybcDUWcdGghsFpt50Ks53mhcxZlktprT1PfrHi2ESIcCnAu/hWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cxzn6tqP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235e389599fso364415ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 17:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751415277; x=1752020077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWta2RBHdNOuAiG72RgunT5XM70BX2r3Pve9teJEvWA=;
        b=Cxzn6tqPvRE9UvbZT/57SywjenE6nqLEHezJYHok7YZh0Wvy/3AwmhujdyMZG3yefM
         TkBJAZMSc0LVc+0OLFFr6NqehXZ5mPtdMhoBW++WQI5/a2N5xIpIWjFv5R9svGBOatmv
         f/CQyvTb19Y4VP65NJPTv5ki0dndcb8NOP9Idf59aC1fHpQgGG/QkUTcpiLBV/fCr4RF
         j6iHlsJAbbnwl7NCqbVPGZSwLQU4Q1SxO0UBKgVOlg+Utf+xIiCtVs4f4Sg6DHrUaXCr
         ju7ahl+omqInUz9QA3ThFC9aOB6DxQcvfsnWq8KSfKu0/XANKcBWJ7x0OGMLnZN333Me
         0PGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751415277; x=1752020077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWta2RBHdNOuAiG72RgunT5XM70BX2r3Pve9teJEvWA=;
        b=o7TyIGzCdpIXZ4uJfE/w4qBb8pg/4mPjKGnyKlZrQHqvAWUr0RFPZPSRrzrFURdUtT
         hIGQAuFeB65uNNgsOdsGXCHPLReo8e1pt03ZB47xIflFHltaHcXbgKTVhBU9CDsdYSxV
         YdZr9Sx55h4ppTslWFbkLX5LpnRQSYW9BPHIsHBYWjKzuvyjR+wyuOl69wBEKgiUdB2f
         TPhqVeE9TN4bWwshGEKKKpmh/48xShTcQ6L+NGpSOgBcAgijHugV0GqaRlM5aRyINkGT
         EUX2EBZQ6OJCix0EAi/rpfRXqeX37qVd7SxratW1HlFjd+2a/Z0ZYoLpWwvkGydebB0/
         5SqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCZ1H84WhFzdDtdoP8ywidtF3D203lyJ4njhuuzQmjtdkcsL34xViilQ6ZdHHO7C6mJs/xcXmMEj1KB8uwFyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/I0TWbBJJG5hTHQMvLyd6kU41NLiY6opma2bxJhhn6GxZz8yY
	N4+a2zFKg9+NuERXvPwH8FbB2JNcOeD1/kRjB9avoor0x2iuGt6QJiJinZhdDWK5Lw==
X-Gm-Gg: ASbGnctn5Qlm7qicjQU+qrxxuDLBGO77Z0Hn4Se70G1dTTu1kqAJZaF5lviwSD+5ZES
	jXghiz39135wk2X/02RQsmpHohsICdk9MULHeAyd5+tu8uwhhf4568AEFxTEAX1deESs4H4/s+I
	A6QH9tuXusXo5Udgm0cDu8OVYe5OJXUFwnlcvO4MV/v4HlH7apLwcn4JQo/aGfss/3W8wgG7Ibd
	U28DZyIPON+Gs1BNOkbyG1apVIvqJtxtGGvOjEmkbPqCQ9DEggSm0VOom8WDpv4n9a41QBkFIv/
	rXvnIKDHvBHx1hWOBg57n2AKhK7pVaFtg93ictzVUSI2BRs5Sr7xTUeVaYumijWL5HhaRdu4ln6
	bcaQ2R+udh0ztfouMSheJ
X-Google-Smtp-Source: AGHT+IGvJMG8/hp+2Ct3jUaU9SAz7W5inwlVAS3AX7hVe0NTLM1n/six7+4FqNJbQ+qt9+fMTBDOTg==
X-Received: by 2002:a17:902:f70b:b0:234:bca7:2934 with SMTP id d9443c01a7336-23c5fef098cmr4092395ad.6.1751415277107;
        Tue, 01 Jul 2025 17:14:37 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b7986sm121732375ad.164.2025.07.01.17.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 17:14:36 -0700 (PDT)
Date: Wed, 2 Jul 2025 00:14:28 +0000
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
Message-ID: <aGR55PUBnwb8qT8U@google.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <539ee2ec112162abdba511574e2205a77b425059.1750966133.git.nicolinc@nvidia.com>
 <aGQGm1-i4M75b9Qp@google.com>
 <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>
 <aGQ_F7Qx3scbbA-J@google.com>
 <aGRDtYRXFLoT+PrI@Asurada-Nvidia>
 <aGRIctg4T6cQECx4@google.com>
 <aGRcPSwaJkTeUrMx@Asurada-Nvidia>
 <aGRmaOORg-YDfncY@google.com>
 <aGRozoIDIlgl9H9x@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGRozoIDIlgl9H9x@Asurada-Nvidia>

On Tue, Jul 01, 2025 at 04:01:34PM -0700, Nicolin Chen wrote:
> On Tue, Jul 01, 2025 at 10:51:20PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Jul 01, 2025 at 03:07:57PM -0700, Nicolin Chen wrote:
> > > On Tue, Jul 01, 2025 at 08:43:30PM +0000, Pranjal Shrivastava wrote:
> > > > On Tue, Jul 01, 2025 at 01:23:17PM -0700, Nicolin Chen wrote:
> > > > > Or perhaps calling them "non-accelerated commands" would be nicer.
> > > > 
> > > > Uhh okay, so there'll be a separate driver in the VM issuing invalidation
> > > > commands directly to the CMDQV thus we don't see any of it's part here?
> > > 
> > > That's how it works. VM must run a guest-level VCMDQ driver that
> > > separates accelerated and non-accelerated commands as it already
> > > does:
> > > 
> > >     accelerated commands => VCMDQ (HW)
> > > non-accelerated commands => SMMU CMDQ (SW) =iommufd=> SMMU CMDQ (HW)
> > > 
> > 
> > Right exactly what got me confused. I was assuming the same CMDQV driver
> > would run in the Guest kernel but seems like there's another driver for
> > the Guest that's not in tree yet or maybe is a purely user-space thing?
> 
> It's the same tegra241-cmdqv.c in the kernel, which is already
> a part of mainline Linux. Both host and guest run the same copy
> of software. The host kernel just has the user VINTF part (via
> iommufd) additional to what the guest already has.
> 
> > And the weird part was that "invalidation" commands are accelerated but
> > we use the .cache_invalidate viommu op for `non-invalidation` commands.
> > But I guess what you meant there could be non-accelerated invalidation 
> > commands (maybe something stage 2 TLBIs?) which would go through the 
> > .cache_invalidate op, right?
> 
> I am talking about this:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c?h=v6.16-rc4#n305
> 
> Those commands returned "false" will be issued to smmu->cmdq in a
> guest VM, which will be trapped by VMM as a standard SMMU nesting
> and will be further forwarded via iommufd to the host kernel that
> will invoke this cache_invalidate op in the arm-smmu-v3 driver.
> 
> Those commands returned "true" will be issued to vcmdq->cmdq that
> is HW-accelerated queue (setup by VMM via iommufd's hw_queue/mmap).


Right, this brings me back to my original understanding, the arm-smmu-v3
driver checks for "supported commands" and figures out which queue shall
they be issued to.. now there are commands which are "non-invalidation"
commands which are non-acclerated like CMD_PRI_RESP, which would be
issued through the trap => .cache_invalidate path. 

Thus, coming back to the two initial points:

1) Issuing "non-invalidation" commands through .cache_invalidate could
   be confusing, I'm not asking to change the op name here, but if we
   plan to label it, let's label them as "Trapped commands" OR
   "non-accelerated" commands as you suggested.

2) The "FIXME" confusion: The comment in arm_vsmmu_cache_invalidate
   mentions we'd like to "fix" the issuing of commands through the main
   cmdq and instead like to group by "type", if that "type" is the queue
   type (which I assume it is because IOMMU_TYPE has to be arm-smmu-v3),
   what do we plan to do differently there, given that the op is only
   for trapped commands *have* to go through the main CMDQ?

   If we were planning to do something based on the queue type, I was
   hoping for it to be addressed in this series as we've introduced the
   Tegra CMDQ type. 

That's all I wanted to say, sorry for if this was confusing.

> 
> Nicolin

Thanks,
Praan

