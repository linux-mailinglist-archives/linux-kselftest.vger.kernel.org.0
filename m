Return-Path: <linux-kselftest+bounces-46725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BE7C93C0F
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 11:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6B2904E0440
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B00D267B92;
	Sat, 29 Nov 2025 10:34:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C409823DD;
	Sat, 29 Nov 2025 10:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764412496; cv=none; b=N1TLyk8ID2dJ9Mr5wPFgLNOLJQVd/FGE4oCu/i242j3jAQSTs/JW1tsFthv4erW9SUM4Q3nt72gj3lHJY5cYyhCPd8qGf3g/kuzAXALHSfGCclXhjgSisw3L3Jc18hn2c1rpjpP1ihnNs1M2UKUGpQjIJYD2h0cL7Ty6aytIa5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764412496; c=relaxed/simple;
	bh=4VBKIZuWXDx1MDvdRM8G7YkqDLM6/dRzHL3lX6iqbzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJOzY4ei5kST/MtG0fnPFbdvbMdx1jCLd85ov/qlQq613ZTmGCOBE4YkxUDesQO67jrLlmiZIE0ihXJ7VqFn95lXi84L0ife4npdzRH3U+SsSM7mSg+wFB6M5aW3uEW719Wf7W606uRkWMWJmwBD5VpYZWprmn5EFTMhBLA3Bf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 9320E2C0759F;
	Sat, 29 Nov 2025 11:34:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 778E01E09F; Sat, 29 Nov 2025 11:34:49 +0100 (CET)
Date: Sat, 29 Nov 2025 11:34:49 +0100
From: Lukas Wunner <lukas@wunner.de>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>,
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-pci@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
	Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
Message-ID: <aSrMSRd8RJn2IKF4@wunner.de>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-3-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251126193608.2678510-3-dmatlack@google.com>

On Wed, Nov 26, 2025 at 07:35:49PM +0000, David Matlack wrote:
> Add an API to enable the PCI subsystem to track all devices that are
> preserved across a Live Update, including both incoming devices (passed
> from the previous kernel) and outgoing devices (passed to the next
> kernel).
> 
> Use PCI segment number and BDF to keep track of devices across Live
> Update. This means the kernel must keep both identifiers constant across
> a Live Update for any preserved device.

While bus numbers will *usually* stay the same across next and previous
kernel, there are exceptions.  E.g. if "pci=assign-busses" is specified
on the command line, the kernel will re-assign bus numbers on every boot.

The most portable way to identify PCI devices across kernels is to
store their path from the root down the hierarchy.  Because the bus
number might change but the device/function number on each bus stays
the same.

This is what EFI does with device paths:
https://uefi.org/specs/UEFI/2.10/10_Protocols_Device_Path_Protocol.html

Example:
Acpi(PNP0A03,0)/Pci(1E|0)/Pci(0|0)

Source:
https://raw.githubusercontent.com/tianocore-docs/edk2-UefiDriverWritersGuide/main/3_foundation/39_uefi_device_paths/README.9.md

We've got a device path *parser* in drivers/firmware/efi/dev-path-parser.c,
but we don't have a *generator* for device paths in the kernel yet.

Thanks,

Lukas

