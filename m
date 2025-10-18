Return-Path: <linux-kselftest+bounces-43482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D529BEC942
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 09:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D07F24E3B92
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 07:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534F828507B;
	Sat, 18 Oct 2025 07:25:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ABD21638D;
	Sat, 18 Oct 2025 07:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760772334; cv=none; b=Uhsl3ud44Wva4tyO+2VksR/sCndUQgpk+qiYwnl5eFsifpwMS9QVqV8ouOzvQePHZE47QWk4OjOdfFEtD5D0wYzyuHQTBqN86Nw0wGya5u+w+qNtGeUWD2p4svNQMMjHA87GN6KrdLCNdey9thM0s0Ga89O/WDORWYq3ofQGAqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760772334; c=relaxed/simple;
	bh=XDiBP8Fuj3d5Tfbxqxx+Fleg1DmKibLl/hZGEiRDXCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro1/JYI7kAfyrEc2856bamtvMRzfBN4GzskgLy7AI2U4WrAF8z1FxSSMlJOk/Z0u3cMOh1W9dZ2Es35E2h4C6d49aWOmih+1D8RvFmxq0xJETioohrr4X4mHMj4hK8pEdsZJ8lB0tKBmhoht7PBGwwBruK8IJtTxHKFOgOtfkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id BCB6F200C2CC;
	Sat, 18 Oct 2025 09:25:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A6D4B4A12; Sat, 18 Oct 2025 09:25:30 +0200 (CEST)
Date: Sat, 18 Oct 2025 09:25:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
	pasha.tatashin@soleen.com, dmatlack@google.com, jgg@ziepe.ca,
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org,
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com,
	parav@nvidia.com, saeedm@nvidia.com, kevin.tian@intel.com,
	jrhilke@google.com, david@redhat.com, jgowans@amazon.com,
	dwmw2@infradead.org, epetron@amazon.de, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 16/21] vfio/pci: Save and restore the PCI state of
 the VFIO device
Message-ID: <aPNA6q-i2GWTl0-A@wunner.de>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-17-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000713.677779-17-vipinsh@google.com>

On Fri, Oct 17, 2025 at 05:07:08PM -0700, Vipin Sharma wrote:
> Save and restore the PCI state of the VFIO device which in the normal
> flow is recorded by VFIO when the device FD is opened for the first time
> and then reapplied to PCI device when the last opened device FD is
> closed.
> 
> Introduce "_ser" version of the struct pci_saved_state{} and struct
> pci_cap_saved_data{} to serialized saved PCI state for liveupdate. Store
> PCI state in VFIO in a separate folio as the size is indeterministic at
> build time to reserve space in struct vfio_pci_core_device_ser{}.

Unfortunately this commit message is of the type "summarize the code
changes without explaining the reason for these changes".

Comparing the pci_saved_state_ser and pci_cap_saved_data_ser structs
which you're introducing here with the existing pci_saved_state and
pci_cap_saved_data structs, the only difference seems to be that
you're adding __packed to your new structs.  Is that all?  Is that
the only reason why these structs need to be duplicated?  Maybe
it would make more sense to add __packed to the existing structs,
though the gain seems minimal.

Thanks,

Lukas

