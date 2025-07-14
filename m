Return-Path: <linux-kselftest+bounces-37224-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 838A9B03688
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 08:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBF9189B1DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 06:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99B321771C;
	Mon, 14 Jul 2025 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="aDQRSUNA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NMOIB9oI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05E17736;
	Mon, 14 Jul 2025 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473328; cv=none; b=KqN1gdTR6K3yTi8L5FqNRy786Esgr/kNBX6jpG+KMSWWCyxl2IsfqKi+uER3Jw91Icv2yHq9ynHRdpe3eNhLI8r5IxYwyepMZ7jhCckdzOO6fWD52WVIptHh8Q+yaISZRTSRhekK28gUEuQ866xOB+CXmjh9Cxaaizk3G5edVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473328; c=relaxed/simple;
	bh=IT52CMMNQVZe/JpsyeRDyVjFNpZ1hXZyOCPsnriWGuY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hQeTcZ/KiF3ujRi3wVOfAdtXCxUu78/FQqg112QL9Vngr6Fqsi4/Zyjeriw0uIRoO2wDhf0d9CAbeTKsnWvvm+1WeDaeHWRyqTJ/QztsTObAFC+d6K0a5QFHigy67n2DHx8ZuMlSTMjcVlJR5sAu6C+hLrRyzigWvbXe/fWRoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=aDQRSUNA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NMOIB9oI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 75D78EC0453;
	Mon, 14 Jul 2025 02:08:45 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 14 Jul 2025 02:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752473325;
	 x=1752559725; bh=RC+CFVWd/VWYy7402scfBHaFNOZ1+z4P3lAFBCgGdWQ=; b=
	aDQRSUNAXm+/DcRr8JHFpYax0uaM0MtbIvLQBkPE0LGP414DcT3gKnoamV8T8SEN
	xYDBlC2feBCzsPE8RIOl9gJX/ikFb2POYxKMPEA05S+M8ypfatJ8ALGNrb5cALTL
	KDCKokVRPEcA/wH7mmkvLR21BSJnfsWKsmCPIHbSqW3OM967bPW7ofJ0SSVIqSJx
	3LMnM/KApSyk04F8E1kcEeNy8Yh8Bz3/lpnj04X5uLq2XaQLMgFVQdx3k352jNpu
	6MHc13Lzk98yPzAMgNkUOlqeSsAqcThKlOyCRgE+3WdAUM9G2skt5RrdeoJrr4+v
	WcchmnE45GeMCekZhRbOAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752473325; x=
	1752559725; bh=RC+CFVWd/VWYy7402scfBHaFNOZ1+z4P3lAFBCgGdWQ=; b=N
	MOIB9oIK4aFGz/MAFD2nsL3q6bVhYxOa+1rkg2f7yWSgVHnNep35yY+c0xwQzgsP
	vMRwxeJnGvzwwxmEaQjimrah2ANgib3/waRIs7J0MBff5JWK2BuRG3V/gs48X2mH
	vlSX0MrI8YV61X2YvowWrBpkGbPwwZgKMONU56Du0DBDjQ5pvBmdCMh/Ak6cISlM
	7YxINbF6R4HK3hpbeP6adI/ZbzcjdrSk1IZzjIJr2ToCdWjW9MBjV3kknOLRcbC1
	bAbloGmDZcko0XSzOVQtxTfXl9rd+Dx5DcSZgsIirq7CM+sIpLRzc9Enub5Y6Rzk
	eo+eEwiVAq6EJ3fdKbTeg==
X-ME-Sender: <xms:6550aNISqkL_c_gKSI1GS6zwoONBMO-j0aQrHirsA-Dx9-qhip8wJw>
    <xme:6550aJLL4Ox0N4jUEaYXAg0enHEgZ0Hvj03HUlMKvtRESzvOZlCtNu5UrKmGPZXjZ
    N-Z2U0G_l8VX-cujzE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehuddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeefuddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepjhhorhhoseeksgihthgvshdrohhrghdprhgtphhtthhopehvrghsrg
    hnthdrhhgvghguvgesrghmugdrtghomhdprhgtphhtthhopehrohgsihhnrdhmuhhrphhh
    hiesrghrmhdrtghomhdprhgtphhtthhopegsrghgrghsughothhmvgesghhmrghilhdrtg
    homhdprhgtphhtthhopehthhhivghrrhihrdhrvgguihhnghesghhmrghilhdrtghomhdp
    rhgtphhtthhopehmshhhrghvihhtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprh
    grrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopeiihhgrnhhgiigvkhhunhduudes
    hhhurgifvghirdgtohhmpdhrtghpthhtohepugifmhifvdesihhnfhhrrgguvggrugdroh
    hrgh
X-ME-Proxy: <xmx:6550aCsD6On8GiPFBuhmhjg2cQ8kX7cKAjv83xfvNnNf8nYQRggg1w>
    <xmx:6550aKpYGV3_6_Cw9r9zZqL9Q_5umAHi98hyl4oNeTYJZsfFeuThwA>
    <xmx:6550aEmSWAshMXkV1Pf880BQ9xBOxPKTnOyiXYTu6frVsoV0UZLpTA>
    <xmx:6550aCT8AC-3Qk2ejJ1a-d5tfh-z3Z7Ik7HcexIq2X1piS7MnP9Efw>
    <xmx:7Z50aC55r5eujMz0Dvb8Ej99ArwfSU_zftLIRLdUgHJFaXhmzaUc6tH4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AB571700068; Mon, 14 Jul 2025 02:08:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0ce86a4a9bc2801a
Date: Mon, 14 Jul 2025 08:08:21 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nicolin Chen" <nicolinc@nvidia.com>, "Jason Gunthorpe" <jgg@nvidia.com>
Cc: "Kevin Tian" <kevin.tian@intel.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Bagas Sanjaya" <bagasdotme@gmail.com>, "Will Deacon" <will@kernel.org>,
 "Robin Murphy" <robin.murphy@arm.com>, "Joerg Roedel" <joro@8bytes.org>,
 "Thierry Reding" <thierry.reding@gmail.com>, vdumpa@nvidia.com,
 "Jon Hunter" <jonathanh@nvidia.com>, shuah <shuah@kernel.org>,
 jsnitsel@redhat.com, "Nathan Chancellor" <nathan@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Yi Liu" <yi.l.liu@intel.com>,
 mshavit@google.com, praan@google.com, zhangzekun11@huawei.com,
 iommu@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
 patches@lists.linux.dev, mochs@nvidia.com,
 "ALOK TIWARI" <alok.a.tiwari@oracle.com>, vasant.hegde@amd.com,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Baolu Lu" <baolu.lu@linux.intel.com>
Message-Id: <db221336-2694-4fcf-a2b2-8fcb46ba3c9e@app.fastmail.com>
In-Reply-To: 
 <9a888a326b12aa5fe940083eae1156304e210fe0.1752126748.git.nicolinc@nvidia.com>
References: <cover.1752126748.git.nicolinc@nvidia.com>
 <9a888a326b12aa5fe940083eae1156304e210fe0.1752126748.git.nicolinc@nvidia.com>
Subject: Re: [PATCH v9 17/29] iommufd: Add mmap interface
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 10, 2025, at 07:59, Nicolin Chen wrote:
>  EXPORT_SYMBOL_NS_GPL(_iommufd_object_undepend, "IOMMUFD");
> 
> +/*
> + * Allocate an @offset to return to user space to use for an mmap() 
> syscall
> + *
> + * Driver should use a per-structure helper in include/linux/iommufd.h
> + */
> +int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct 
> iommufd_object *owner,
> +			phys_addr_t mmio_addr, size_t length,
> +			unsigned long *offset)
> +{
...
> +
> +	/* Skip the first page to ease caller identifying the returned offset 
> */
> +	rc = mtree_alloc_range(&ictx->mt_mmap, &startp, immap, immap->length,
> +			       PAGE_SIZE, PHYS_ADDR_MAX, GFP_KERNEL);


This produces a warning on 32-bit targets with a 64-bit phys_addr_t,
in practice this would be ARM Cortex-A15 or -A17 systems:

In file included from include/linux/overflow.h:6,
                 ...
                 from drivers/iommu/iommufd/driver.c:4:
drivers/iommu/iommufd/driver.c: In function '_iommufd_alloc_mmap':
include/linux/limits.h:11:25: error: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '18446744073709551615' to '4294967295' [-Werror=overflow]
   11 | #define PHYS_ADDR_MAX   (~(phys_addr_t)0)
      |                         ^~~~~~~~~~~~~~~~~
drivers/iommu/iommufd/driver.c:61:43: note: in expansion of macro 'PHYS_ADDR_MAX'
   61 |                                PAGE_SIZE, PHYS_ADDR_MAX, GFP_KERNEL);
      |                                           ^~~~~~~~~~~~~


The mtree_alloc_range() interface explicitly operates on 'unsigned long'
address values, so I don't see an immediate workaround for this that would
make it work on these machines. On the other hand, 

At the moment, the only drivers that select CONFIG_IOMMUFD_DRIVER
on 32-bit Arm systems are CONFIG_PDS_VFIO_PCI and CONFIG_MLX5_VFIO_PCI.
It's probably fine to make all three symbols "depends on 64BIT" for
now, but I don't know if there may be more drivers like this in the
future that actually could make sense on embedded systems.

     Arnd

