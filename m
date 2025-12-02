Return-Path: <linux-kselftest+bounces-46867-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB88DC9A3F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 07:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9449534587C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 06:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835FF301033;
	Tue,  2 Dec 2025 06:26:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870DB2FFFB5;
	Tue,  2 Dec 2025 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764656764; cv=none; b=bvyLOxNWtRAGIChwfXs+a2/lBpqbOfD6A9/xYcITOmS5VUKhCIKy7tcJLs51aCGBH+g9MvDyl5uC4D5+zIpM1CXE1ty7VBnxWNhS/QO7aFuJ+NNax0QQsRAxXcIlVztWswZdMPmufZFoqrxBxKScXv3lm0w4IO7HUPckaqDmNek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764656764; c=relaxed/simple;
	bh=aQTKNlLrS6sBh+ULcE7sNUYYJuTlGIWn6fq6APmTvNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSOcCAKDfeaV9nS6TPtPIM0l0hePP/1CJna3OhFIY/tbA/mVn6gfdSSB0xz0DN4l/d97PcjalIYX+2tcMxYhKKWwdxMlb9xD1bTEo6Iozp/vo9rBK86sI2ORJYV42cVgD6vt2n3lRIFCOaBmumqtL6icVZ/iEfezME9GQ077SvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 348442009D2F;
	Tue,  2 Dec 2025 07:20:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1754D1F008; Tue,  2 Dec 2025 07:20:23 +0100 (CET)
Date: Tue, 2 Dec 2025 07:20:23 +0100
From: Lukas Wunner <lukas@wunner.de>
To: David Matlack <dmatlack@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
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
Message-ID: <aS6FJz0725VRLF00@wunner.de>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-3-dmatlack@google.com>
 <aSrMSRd8RJn2IKF4@wunner.de>
 <20251130005113.GB760268@nvidia.com>
 <CA+CK2bB0V9jdmrcNjgsmWHmSFQpSpxdVahf1pb3Bz2WA3rKcng@mail.gmail.com>
 <20251201132934.GA1075897@nvidia.com>
 <aS3kUwlVV_WGT66w@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS3kUwlVV_WGT66w@google.com>

On Mon, Dec 01, 2025 at 06:54:11PM +0000, David Matlack wrote:
> To handle pci=assign-busses, perhaps something like this? Are there any
> other places where the kernel could change busses?

In theory the algorithm to assign bus numbers could change from
one kernel version to the next.  Ilpo (+cc) is currently reworking
the resource allocation algorithm.  That work primarily covers
MMIO window sizing, but bus numbers are resources as well and
could be affected by changes.  Resource allocation code is
already quite convoluted and sprinkling liveupdate special cases
all over it may not be received with enthusiasm. ;)

Of course in practice, changes to the algorithm do not happen often
and the kernel will preserve bus numbers as set by BIOS.  Only if it
detects incorrect bus assignments or if forced via the command line
will the kernel re-assign bus numbers.

But you do gain a bit of reliability if you don't assume bus numbers
to stay the same and instead use the "path from root" approach to
identify devices.

Thanks,

Lukas

