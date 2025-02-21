Return-Path: <linux-kselftest+bounces-27172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DE8A3F6A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 15:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FD93B3D40
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 14:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EFF20E70B;
	Fri, 21 Feb 2025 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="PUDVv62e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FAB20E334;
	Fri, 21 Feb 2025 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146412; cv=none; b=Bn25J+CIbpsuqaVwy/B2duWZPQrCsYSvw+aTSTKu8KK86l2md3c8zYr80T/rS/fplifgyVjIr0KcK76+zefFQidJzxjdGFK3QatsFCIFgZj/vllYffcaqUMu6QQzl/29EX62sW0KxRf4EZ4MijtYSxMGgsIAO9lVTQf4vqlMpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146412; c=relaxed/simple;
	bh=58xAn4U0wInTpg79aVG+cwEwl25B8pi/XQxIUWwayXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8IiukZDV7reH7suVqlkrZ3IYyuG6IoamkhXYjDTaEpuSEMUGVXVAZk0vfUC+PIsiejDkMZhwsMuXytRhioyN6lWbUJ+IgiWCqoQ6ZZhJWGEm34U6p3xpmIDGqAtuqxE0pPGRO/fJrWqJE+z5pSbCakAfyvwd28wupjp2lLVmGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=PUDVv62e; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4D8A942B10;
	Fri, 21 Feb 2025 15:00:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1740146409;
	bh=58xAn4U0wInTpg79aVG+cwEwl25B8pi/XQxIUWwayXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PUDVv62eIVNURun6OWy6vI5skGuAuixbLdu/u89o+onhQTeQ7AZDi4md+LEAOcvnm
	 MmIpk/JAieySNjsSCJ7xL2wu+NUxrBf+GXr/I1wPiqKPnP+3eEtyHUB6K02Knx4qBX
	 +OdkBD8PrVInIzE5B2c0zq1GZ5lVI5MjnZ6zbMWpXfqNQO+WsLxIAp2GNWZgX5//oh
	 mwDjWWfxZLyDcX+bRKmDPLkOokWU31147S7wTF7ryvdSsX2YIwzEW2frHpN4I3Q6dg
	 SZLCa98nmwYQWBotri91Rt9sz4kK6nUDEFJGKv95Yfw4+k4txqEgbSDhsVHx1Yj/zi
	 aLma1KTCZLOvw==
Date: Fri, 21 Feb 2025 15:00:08 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>, kevin.tian@intel.com,
	maz@kernel.org, will@kernel.org, robin.murphy@arm.com,
	shuah@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	baolu.lu@linux.intel.com, yi.l.liu@intel.com, yury.norov@gmail.com,
	jacob.pan@linux.microsoft.com, patches@lists.linux.dev
Subject: Re: [PATCH v2 1/7] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
Message-ID: <Z7iG6NArgozXFZJ5@8bytes.org>
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <a4f2cd76b9dc1833ee6c1cf325cba57def22231c.1740014950.git.nicolinc@nvidia.com>
 <87ldtzhcjv.ffs@tglx>
 <Z7hfNlnSj8BI6C7l@8bytes.org>
 <20250221134112.GK50639@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221134112.GK50639@nvidia.com>

Hi Jason,

On Fri, Feb 21, 2025 at 09:41:12AM -0400, Jason Gunthorpe wrote:
> Can I send you a PR instead? I'd like it on a branch so we can work on
> the iommufd specific bits that where in v1.

Yes, that works as well.

Thanks,

	Joerg

