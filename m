Return-Path: <linux-kselftest+bounces-46840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E237C98C6A
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 19:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93D3834320A
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 18:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E522B5AC;
	Mon,  1 Dec 2025 18:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJrdc4my"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3675321C17D
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615259; cv=none; b=NrDN0YXouIssga0XqDYZhVGP5jz4BJx4Js9AAvT2L5KnW5xFJIbvIJN4cBZ+F4IIEs0vkQ+T6k2wNEPpCRE61wz2JqFoYXUmHb8uA9MPuqquDpNCevftYv0WQJimvl0dRS7nrwZl7XMuLQU6P7P9aXZqwhOnxhTv2Q99SCx3MkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615259; c=relaxed/simple;
	bh=xdQFSPwBDitJJbj4YFqv8oX69ifcmN2sMzq3HiUxFog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXazZe1GK3pt+3OKxr5EeWTF09gr0EDp/J3aMk6gsJfDlakEatYUBUjGC/QowZfSauHV9ZRcBTOzSLkgVj6RD+3CuPIq/FCEbnVPGa3p5NR8NEr7wp2WGL5kKazp74p9ciIp7DD72QRy85nz97K9uvVIp4rbvfVi9aDjV6uXs3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJrdc4my; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3436a97f092so5739552a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 10:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764615257; x=1765220057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NZR7hK5x4THTBId2vxyDYOqgCYL0BSheMqFuUmlt+Jw=;
        b=rJrdc4myLwh5sTna1PuJYPc/KOILdlLOmqy97IzQq1WNI+gRSTu77M/5mUVqJe26pv
         Vxb029p44Gag8/bWe00oXbZS+Ftp8ymQhnMHBs0Mgc0eWQR8LrXlvW2YHAB6ppq9lKwb
         IOPkaCW2XSW5iDBk2JJ9IZ6iPoGc5oHjY2G3qx45Nd5gl+h0yGZtsXoiFIZ7LnF00WyA
         gH6sz/VIsim6SU9HLb3wzF66lBxUhWTAcLkW+wVKIzwkTCJPKgaHFQ/FDahBRzZqhE8k
         2YzM19tyU6JMfTgzRM6MM41Q8wMrQbaQ+z52Glxjqs4v2dLDivW/WfQ3JViz9u7AuU3u
         wLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764615257; x=1765220057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZR7hK5x4THTBId2vxyDYOqgCYL0BSheMqFuUmlt+Jw=;
        b=Vq4wEyOFGNd9bZCvaZFFhgmU3JFnkX4OA//LsfQa1jmZAlQhLEq/+U80zyks/qqjSo
         F93U8z70RSFtKDlULdq4GNtM60uA0gO1xG70FdCWtRu0g7/Fr11b6jA9eFiw6OqLrnah
         eQtle8hZOZnAR369rhvfT+dLBjLzH4FfT7KF/6vmed6IMJnE7Q0kN/MU/wp+AkYUFxTB
         4ZoKJhAYvTNdmrdk79Ik0U9lxYRSOS/seoxv7l1AAwKheQpsiMv3Fy/UT5yziLdbpuuE
         aw/zCC0SmGzrF6IDHJpuXiNRPRNZ+yKIyxdpVmm2yK9F5O4jx5lp/n5aCSbRJ6gLXX3r
         kB/g==
X-Forwarded-Encrypted: i=1; AJvYcCX5iQ0LGgpOi+fhNiqkOoJxAgPXNOhwkUrjVMzlWMGOZzEtaWOdPbmAXCktnWTXVCzXmUSz/FjWb8bsp38x6gI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8nLUcXxwaz1g3zaYViyn0c3sX2fOCvSX1ioCzEx91ZuulI5CG
	EZn0hVEPfbb3rVJDmKnDQ+hjhhxG07qYSnR1AthlhmkBVr4LHvSjpABDirOQdG8TTQ==
X-Gm-Gg: ASbGncvu4p2dHB+59h30L79Q0C/zuhbPUqotY/QbFDERMDdkPMnmhR8+THsCTQR2Xej
	pch3TU4OFHy3Iigvw/xvG9pYGPU1o1YAZz3NYTOW/4/5+pqbQx53TdAfLbne6HzjlyKCw56a50m
	ApJt+W/r+KvI8kpR3+4Pa5QgnqjT5f4+jr54nydKTva9QnuPz0WfAFfCRcOPa8gxMBA6VsgDL7l
	WfWRKb8WdGMg0vBLFhN2MAU24B+uTNf2ma/BoSgELC0E+xnFHBIpwTyEakf3UKZT8qiCPw58h/h
	VYJjZetjAdO/i4oFbYsWl7BXpc8p+3WriUx0mvcPXiMLXGU4YWG/sphZwF/e02XLsYWXqvZsAwc
	Ck2nVgX3I+idljZEWuu9ntchCdvo90xrduKuK6ZTv+fvww/aHNMhDkyGsePhJfn/QI89/u+fZn9
	XoAOA2H9qKtMqfDmF+qCEJUqSog6c5+ynS8S5rSU95UsSzJMM=
X-Google-Smtp-Source: AGHT+IEiFxvWkfPP9po3hvukZ9ksCP0VDwl+C6gb0NjWaMPZyH9tph+K1Sdl9eUHW9tCV4/voZXr4g==
X-Received: by 2002:a17:90b:53c3:b0:33f:ebc2:634 with SMTP id 98e67ed59e1d1-3475ebe8173mr23598831a91.9.1764615256953;
        Mon, 01 Dec 2025 10:54:16 -0800 (PST)
Received: from google.com (28.29.230.35.bc.googleusercontent.com. [35.230.29.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475e952efbsm8216852a91.1.2025.12.01.10.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 10:54:16 -0800 (PST)
Date: Mon, 1 Dec 2025 18:54:11 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Lukas Wunner <lukas@wunner.de>, Alex Williamson <alex@shazbot.org>,
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
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
Message-ID: <aS3kUwlVV_WGT66w@google.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <20251126193608.2678510-3-dmatlack@google.com>
 <aSrMSRd8RJn2IKF4@wunner.de>
 <20251130005113.GB760268@nvidia.com>
 <CA+CK2bB0V9jdmrcNjgsmWHmSFQpSpxdVahf1pb3Bz2WA3rKcng@mail.gmail.com>
 <20251201132934.GA1075897@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251201132934.GA1075897@nvidia.com>

On 2025-12-01 09:29 AM, Jason Gunthorpe wrote:
> On Sat, Nov 29, 2025 at 08:20:34PM -0500, Pasha Tatashin wrote:
> > On Sat, Nov 29, 2025 at 7:51 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >
> > > On Sat, Nov 29, 2025 at 11:34:49AM +0100, Lukas Wunner wrote:
> > > > On Wed, Nov 26, 2025 at 07:35:49PM +0000, David Matlack wrote:
> > > > > Add an API to enable the PCI subsystem to track all devices that are
> > > > > preserved across a Live Update, including both incoming devices (passed
> > > > > from the previous kernel) and outgoing devices (passed to the next
> > > > > kernel).
> > > > >
> > > > > Use PCI segment number and BDF to keep track of devices across Live
> > > > > Update. This means the kernel must keep both identifiers constant across
> > > > > a Live Update for any preserved device.
> > > >
> > > > While bus numbers will *usually* stay the same across next and previous
> > > > kernel, there are exceptions.  E.g. if "pci=assign-busses" is specified
> > > > on the command line, the kernel will re-assign bus numbers on every boot.
> > >
> > > Stuff like this has to be disabled for this live update stuff, if the
> > > bus numbers are changed it will break the active use of the iommu
> > > across the kexec.
> > >
> > > So while what you say is all technically true, I'm not sure this is
> > > necessary.
> > 
> > I agree. However, Lukas's comment made me wonder about the future: if
> > we eventually need to preserve non-PCI devices (like a TPM), should we
> > be designing a common identification mechanism for all buses now? Or
> > should we settle on BDF for PCI and invent stable identifiers for
> > other bus types as they become necessary?
> 
> Well, at least PCI subsystem should use BDF..
> 
> You are probably right that the matching of preserved data to a struct
> device should be more general though.

Lukas' suggestion would also make it more reliable to detect bus numbers
changing during a Live Update. We can play whack-a-mole with things like
assign-busses, but there will be a risk that we miss something or
something changes in the future.

Perhaps it would make sense to rely on BDF in the PCI subsystem in the
short term and enforce bus number stability manually (e.g. see patch at
the bottom), and then explore stable device paths as a future
improvement to make PCI device preservation more reliable and also to
enable other bus types?

To handle pci=assign-busses, perhaps something like this? Are there any
other places where the kernel could change busses?

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0ce98e18b5a8..2e1e1aa385a8 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1331,6 +1331,20 @@ static bool pci_ea_fixed_busnrs(struct pci_dev *dev, u8 *sec, u8 *sub)
 	return true;
 }
 
+static bool pci_assign_all_busses(void)
+{
+	/*
+	 * During a Live Update, do not assign new bus numbers. Use bus numbers
+	 * assigned by the firmware and the previous kernel. Bus numbers must
+	 * remain constant so that devices preserved across the Live Update can
+	 * use the IOMMU uninterrupted.
+	 */
+	if (liveupdate_count())
+		return false;
+
+	return pcibios_assign_all_busses();
+}
+
 /*
  * pci_scan_bridge_extend() - Scan buses behind a bridge
  * @bus: Parent bus the bridge is on
@@ -1404,7 +1418,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
 			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
 
-	if ((secondary || subordinate) && !pcibios_assign_all_busses() &&
+	if ((secondary || subordinate) && !pci_assign_all_busses() &&
 	    !is_cardbus && !broken) {
 		unsigned int cmax, buses;
 
@@ -1441,13 +1455,16 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 		if (subordinate > max)
 			max = subordinate;
 	} else {
+		pci_WARN_ONCE(dev, liveupdate_count(),
+			      "Assigning new bus numbers during a Live Update! [%u %u %u %u]\n",
+			      secondary, subordinate, is_cardbus, broken);
 
 		/*
 		 * We need to assign a number to this bus which we always
 		 * do in the second pass.
 		 */
 		if (!pass) {
-			if (pcibios_assign_all_busses() || broken || is_cardbus)
+			if (pci_assign_all_busses() || broken || is_cardbus)
 
 				/*
 				 * Temporarily disable forwarding of the
@@ -1522,7 +1539,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
 							max+i+1))
 					break;
 				while (parent->parent) {
-					if ((!pcibios_assign_all_busses()) &&
+					if ((!pci_assign_all_busses()) &&
 					    (parent->busn_res.end > max) &&
 					    (parent->busn_res.end <= max+i)) {
 						j = 1;
diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index b913d63eab5f..87a4982d0eb1 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -219,6 +219,7 @@ struct liveupdate_flb {
 
 /* Return true if live update orchestrator is enabled */
 bool liveupdate_enabled(void);
+int liveupdate_count(void);
 
 /* Called during kexec to tell LUO that entered into reboot */
 int liveupdate_reboot(void);
@@ -241,6 +242,11 @@ static inline bool liveupdate_enabled(void)
 	return false;
 }
 
+static inline int liveupdate_count(void)
+{
+	return 0;
+}
+
 static inline int liveupdate_reboot(void)
 {
 	return 0;
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 69298d82f404..2f273397bd41 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -256,6 +256,13 @@ bool liveupdate_enabled(void)
 {
 	return luo_global.enabled;
 }
+EXPORT_SYMBOL_GPL(liveupdate_enabled);
+
+int liveupdate_count(void)
+{
+	return luo_global.liveupdate_num;
+}
+EXPORT_SYMBOL_GPL(liveupdate_count);
 
 /**
  * DOC: LUO ioctl Interface

