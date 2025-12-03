Return-Path: <linux-kselftest+bounces-46930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CD5C9DD01
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 06:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8194F4E06DD
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 05:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43571284B36;
	Wed,  3 Dec 2025 05:44:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D86D2765C0;
	Wed,  3 Dec 2025 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764740680; cv=none; b=FI0jQVHWZjUjNtaPLCRSF/z7mqFhwrRXft/Vi0uBreqGQ08YWeLT2N89CemQswyvOAE5z+jopdZoFyl/n5SRb1ZxrEhSB6DW/pBFEsWpQwjJqr1cdVCZnIijsNaOIkPXGVj5D9d0xtGoHkGK7YKmjqHDGDkL6snfS98oUWkH5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764740680; c=relaxed/simple;
	bh=i8GA9MGKyu5KlGw7/hRpTII7Pz2+m+XaC8ABn6+xGkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K71KPoBwC2HA3xq8b0+TzgjMTkzQ7hJq72M8M6rkvjJj7hXJhashZYs5jbtkuqG8bj1m4DMySlAifLmhpIujBC/BerLJwomfAcHU0zINSI8SYzK+1wW/WBTyN7/MInbbDzmGAfhcPuMjI1+W7NFOHEAx5puYtPPqTf40/PPiZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id E10B42007F8C;
	Wed,  3 Dec 2025 06:44:34 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BF3A61E6E2; Wed,  3 Dec 2025 06:44:34 +0100 (CET)
Date: Wed, 3 Dec 2025 06:44:34 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Chris Li <chrisl@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
	Parav Pandit <parav@nvidia.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
Message-ID: <aS_OQoYKmFBaOHSx@wunner.de>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-3-dmatlack@google.com>
 <aSrMSRd8RJn2IKF4@wunner.de>
 <20251130005113.GB760268@nvidia.com>
 <CA+CK2bB0V9jdmrcNjgsmWHmSFQpSpxdVahf1pb3Bz2WA3rKcng@mail.gmail.com>
 <20251201132934.GA1075897@nvidia.com>
 <aS3kUwlVV_WGT66w@google.com>
 <aS6FJz0725VRLF00@wunner.de>
 <20251202145925.GC1075897@nvidia.com>
 <CACePvbVDqc+DN+=9m1qScw6vYEMYbLvfBPwFVsZwMhd71Db2=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbVDqc+DN+=9m1qScw6vYEMYbLvfBPwFVsZwMhd71Db2=A@mail.gmail.com>

On Tue, Dec 02, 2025 at 08:36:53PM +0400, Chris Li wrote:
> On Tue, Dec 2, 2025 at 6:59 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > The device is active
> > during KHO, you CAN NOT do any resource reassignment, not bus numbers,
> > not mmio. It must be fully disabled.
> 
> I agree with Jason. The bus number is used in the low level hardware
> to do the DMA transfer. The bus number can not change for a device
> during livedupate with pending DMA transfer. The BDF MUST remain the
> same as the liveupdate with DMA transfer requirement.

Thank you both for the explanation.

> Another point is that, on the same machine it can have multiple PCI
> host bridges. Each PCI host bridge bus number is acquired from the
> ACPI table walk. I am not aware of any way to get the slot number of
> the PCI host bridge. Lukas, do you know how to get the PCI host bridge
> slot number to form a path?

Host bridges are identified by the segment number.  On ACPI-based systems,
it's retrieved by acpi_pci_root_add() through invocation of the _SEG method.

Thanks,

Lukas

