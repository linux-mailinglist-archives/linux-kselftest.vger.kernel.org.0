Return-Path: <linux-kselftest+bounces-16233-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E22095EA30
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 09:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614271C211E6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 07:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9762131E4B;
	Mon, 26 Aug 2024 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Q1iWPIlM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AD012CDA5
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 07:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656615; cv=none; b=N5VL8Vcaj9eH5g90/qjXXaSdpiwcw7r1YIXLf/zJIKLuA1Xe3ny3AySaonYpYN7I+d4kAOdGiCVm70Oe/5/PPal8DE6VO8J2Tfa57JmWSiC1IaDl1Aptqo/LRlP6rOEoVsGq90KugeCDtNLsO9amNvLCXFj+kEZgn75qCwIFYm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656615; c=relaxed/simple;
	bh=OdtUGVhpx5M9y8N8iLV3hzW0LRa018NJAkPTUnUGzAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLh4q6s4mDv46b/cQZQpqZKMII7dcUDnkOVL5LFVJuK3btFo4DSX7O6gucG4/EQyqbcA4wMKDOCR8jcVL5pM9Xz4Ke0MTvjqcp79DnB6EF6CIcpgGRT0yWb6vPZ3QtnRfHHurxiMP6we+D7lzuUFYnpbyByHrhn8ebOZsZNk4kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Q1iWPIlM; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (pd9fe9dd8.dip0.t-ipconnect.de [217.254.157.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0B758283CE3;
	Mon, 26 Aug 2024 09:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1724656613;
	bh=OdtUGVhpx5M9y8N8iLV3hzW0LRa018NJAkPTUnUGzAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1iWPIlM6obLxXHFvwVsZqU24B2th6swxIzVu7rse2h0JfgXXu/Wb8TJFI6Z+cCTu
	 CD0z1zp/M49ExylTF880h4E+I1gM2+I18fNSWmbJaXWE5mFrrDAZ8uT89RzfDKRBMc
	 UTjq3m9jY2LwVA3Z8e4W49DY2nn9zww/JSn82S21bBxhqvbQUVYIBNzZb9tnOahFod
	 JR2EnXDe1lZSpN5P5WXMIyuXKRQE1GLmWsvAxTJkullYLE3YfDzNUoEKtH00Davb6G
	 dUQ2Vw/PC/92eAl/V1+j7p3bBWLgi8D9sTnpwjNn6JLOjLhjoLxMn6sNZpXDQpDkPH
	 MZboeyceKnKWQ==
Date: Mon, 26 Aug 2024 09:16:51 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>,
	Janne Grunau <j@jannau.net>, Joerg Roedel <jroedel@suse.de>,
	Kevin Tian <kevin.tian@intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Hector Martin <marcan@marcan.st>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Sven Peter <sven@svenpeter.dev>, Will Deacon <will.deacon@arm.com>,
	Yi Liu <yi.l.liu@intel.com>, Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH rc 0/2] Fix maps created without READ or WRITE
Message-ID: <Zswr4-fRLI2lHX_Q@8bytes.org>
References: <0-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>

On Thu, Aug 22, 2024 at 11:45:53AM -0300, Jason Gunthorpe wrote:
> I noticed some bugs here while working on iommupt. Fix them up.
> 
> Joerg, can you pick this both for your -rc branch?

Dones, applied to fixes branch, thanks.

