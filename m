Return-Path: <linux-kselftest+bounces-36225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2300DAF06AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 00:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715CD4E1ECF
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 22:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDAF30205E;
	Tue,  1 Jul 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1G6t++y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A0228312E
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751410291; cv=none; b=gCapCU5ABtGV84c+BI9jQiBJVgRrE/He/7wczm/TaRhGMg1P6IFY2WLx97I/px4FzSVA2HWEB2fLSSgrqtSQhZiUSvSOOjLOFCZq3XMVFuGiPmJzCO7lcxigG4exZgecZ0WV7HXAXrECsgKZ1T/PScJBAF7OeZ4vOWxe7Z4ksw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751410291; c=relaxed/simple;
	bh=THyaiSK3XZpGPf2jkEiRMRg3uUKNoJcmWhjWuRS1+Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih4vNyDa9zHm3Cw9vi6SVA+wLggI20QaVz+QkA2mVuvemzpMQC9oMYhO5tIYqgmoYcBN/jqI6JD6iqyW8mVhtVEG6PZPjm7UD7KavGYAbx2DQjj1mtd0UHkM0TwQSMq1WGfBEGCkDxdnBosMlmAgW4lza70huE6G0Jgi9d1arTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1G6t++y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e389599fso350255ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 15:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751410290; x=1752015090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=31m5VALjhSZCUtaamU81Tt7LVwzdmFjl/OH4isUf0T4=;
        b=I1G6t++yD9V4C6VFrwS/Ox3IwKdstO81pMUTd+x+5nJN1PCohB5UF8K5lpeitFxLR5
         78bYzSEPQOIHj2grpze+b7urzmXMIa0Sg/gZNhxDnd8TdUnpbrvkpJ8Mp6qURIDsbWiu
         Qwkcst6EuiFEshPMUKSpIPPL3HcDSsVYHUp/BF2WkbngKJfySeT0/tYTp1jPIJtVlcGY
         nQ0TiB+lXGmAJsdNMBfS0G2Qz6ZNYu0/QdaNvLH1uACIXW7ld9z+ZreTwwIIastZdfNW
         KWPgHgZwM978OS4d7LTJQDBSXEzo1+mPuLK2svIXBbhUBdJgtM16dcfj7GudHniQ4Jbw
         Mzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751410290; x=1752015090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31m5VALjhSZCUtaamU81Tt7LVwzdmFjl/OH4isUf0T4=;
        b=jvWDu8Jq3TxQAJeQjp40+QtmusanHvJhpatRmOBc9dCZolchlh1wmWqkVGUwPLfT18
         OixHUtXF7a2z7l2d3GwECKT9v/ZiZLmAMLY5dqnfuyuEnLrTmv30OeWxfG7DkNUpiaJA
         qk0OaQUH25zx60UKxRTlJ2RL++9iEaiWEdkRBk6csi6ylc40/v5VwrZxt+tBtbrQxd4Q
         7844g4wRXKfztChaXdmXsPDI/g44BqzZQt5k8FsiCCT8RpoJFlWJAJkdkvn9jK2R1K4J
         PGr72rsAEIMl85Ve7U9VJtc1HjHJdqYMfmKlfG38IDS6vbMIxor1OAIjpehjP2XurXuo
         /PPg==
X-Forwarded-Encrypted: i=1; AJvYcCWzozaIkJFZIaHNHdlwPSPBar7WrgkhN4UBZb0nxZIIKPDIdal2SVxSD7ONeAaoBpVgUckoou1LdR2CxTa4mak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwURlPVCbzguk75wdxab7J8kgixrTZ9S76Vbs0Cy5tbDgtrrCZ3
	ovIVw9XaeMGm6znqE57aV/qbO97ajekHCJd0y1lVTT0Xf89CNy31ukBUKsqnBmar1g==
X-Gm-Gg: ASbGncvqfLvME5FYTEndpPaaIcfB5a0NT/EuQyZkAsdnnP1XFHOd3L+BP8oQckwDns9
	1TV03GaH6sgOS0qA4hrQvhz4mz7Gzx9oEHO4Kdgro7rvNFAEsTZx0I6sQ4+6f+jInlNVtgSl8LI
	EbQAhvOn4xJpdzpc0iBk/G23+cILeX8palCVb5MAxVMYHXMwqkg4KDjzeAs7I0/o8+hQ0htnnKa
	MdYa4KbhUOILm2ae2sH0QhdnH2X8kMPIGWsHTwTeEZ5eh/pXWLB+d+wZ4ojfI5zjfJ2FStVhufw
	B96YPWl2+RwFL0oR2ru8r/oIBtImoNbC3dUJmAuYooTuCkEzRcFNrhOwozUB6CfJYE25heBoWNQ
	nUwMgFOrv2+TiiUCd/83Q
X-Google-Smtp-Source: AGHT+IE2A3LONQdf5/UDXdamM9j2FEbJtnYf58bee8GseWxQ7r/tyyPKLeWd6GVOe4rd8pReDprYsg==
X-Received: by 2002:a17:903:40c6:b0:235:e1d6:5339 with SMTP id d9443c01a7336-23c601c954dmr3764925ad.26.1751410289353;
        Tue, 01 Jul 2025 15:51:29 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5384107sm17193429a91.5.2025.07.01.15.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 15:51:28 -0700 (PDT)
Date: Tue, 1 Jul 2025 22:51:20 +0000
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
Message-ID: <aGRmaOORg-YDfncY@google.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <539ee2ec112162abdba511574e2205a77b425059.1750966133.git.nicolinc@nvidia.com>
 <aGQGm1-i4M75b9Qp@google.com>
 <aGQ6KCI9OZEwHdxS@Asurada-Nvidia>
 <aGQ_F7Qx3scbbA-J@google.com>
 <aGRDtYRXFLoT+PrI@Asurada-Nvidia>
 <aGRIctg4T6cQECx4@google.com>
 <aGRcPSwaJkTeUrMx@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGRcPSwaJkTeUrMx@Asurada-Nvidia>

On Tue, Jul 01, 2025 at 03:07:57PM -0700, Nicolin Chen wrote:
> On Tue, Jul 01, 2025 at 08:43:30PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Jul 01, 2025 at 01:23:17PM -0700, Nicolin Chen wrote:
> > > Or perhaps calling them "non-accelerated commands" would be nicer.
> > 
> > Uhh okay, so there'll be a separate driver in the VM issuing invalidation
> > commands directly to the CMDQV thus we don't see any of it's part here?
> 
> That's how it works. VM must run a guest-level VCMDQ driver that
> separates accelerated and non-accelerated commands as it already
> does:
> 
>     accelerated commands => VCMDQ (HW)
> non-accelerated commands => SMMU CMDQ (SW) =iommufd=> SMMU CMDQ (HW)
> 

Right exactly what got me confused. I was assuming the same CMDQV driver
would run in the Guest kernel but seems like there's another driver for
the Guest that's not in tree yet or maybe is a purely user-space thing?

And the weird part was that "invalidation" commands are accelerated but
we use the .cache_invalidate viommu op for `non-invalidation` commands.
But I guess what you meant there could be non-accelerated invalidation 
commands (maybe something stage 2 TLBIs?) which would go through the 
.cache_invalidate op, right?

> Nicolin

Praan

