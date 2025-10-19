Return-Path: <linux-kselftest+bounces-43513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA84ABEE07F
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 10:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E35AB4E3DF1
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Oct 2025 08:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CB220C023;
	Sun, 19 Oct 2025 08:15:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C0715278E;
	Sun, 19 Oct 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760861731; cv=none; b=GFvTopzionBHHGJV9ltapW63H369fqFxuSeaq91vOM1hQmznkFdHTlZb9jSxYSfqv74EUEJ2AlShg6uYiXGUVgSlOlkeSkPYX4w9M58WFQeBZVbFwcpHdUTr92QknKzxFRN2z7iphkbfLDvCcOUVX46MLFluPH3JvPyVvkWecQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760861731; c=relaxed/simple;
	bh=aX/H9n97rQbaScCyEvKZw1ydUai9eBgQOEtmq1PJbiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEHjF+FR2NNHg72D55ndyL1dvu+qMMqhoIL3SCs/L7CnixfRq7+sFknGEeMlGLUKBCNuR8SWs97UJb/jLZQvXnUzR8NfwAlxmgcqRPD6JyhSyMzisiBRIFvOnoHX2y9rxFecs4+pUFzmAe3o1Fnxcl8ZKwUNY3D8p+s3FpSnA28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id E146F2009194;
	Sun, 19 Oct 2025 10:15:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C3FB74A12; Sun, 19 Oct 2025 10:15:19 +0200 (CEST)
Date: Sun, 19 Oct 2025 10:15:19 +0200
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
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
Message-ID: <aPSeF_QiUWnhKIma@wunner.de>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de>
 <20251018223620.GD1034710.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018223620.GD1034710.vipinsh@google.com>

On Sat, Oct 18, 2025 at 03:36:20PM -0700, Vipin Sharma wrote:
> On 2025-10-18 09:17:33, Lukas Wunner wrote:
> > On Fri, Oct 17, 2025 at 05:07:07PM -0700, Vipin Sharma wrote:
> > > Move struct pci_saved_state{} and struct pci_cap_saved_data{} to
> > > linux/pci.h so that they are available to code outside of the PCI core.
> > > 
> > > These structs will be used in subsequent commits to serialize and
> > > deserialize PCI state across Live Update.
> > 
> > That's not sufficient as a justification to make these public in my view.
> > 
> > There are already pci_store_saved_state() and pci_load_saved_state()
> > helpers to serialize PCI state.  Why do you need anything more?
> > (Honest question.)
> 
> In LUO ecosystem, currently,  we do not have a solid solution to do
> proper serialization/deserialization of structs along with versioning
> between different kernel versions. This work is still being discussed.
> 
> Here, I created separate structs (exactly same as the original one) to
> have little bit control on what gets saved in serialized state and
> correctly gets deserialized after kexec.
> 
> For example, if I am using existing structs and not creating my own
> structs then I cannot just do a blind memcpy() between whole of the PCI state
> prior to kexec to PCI state after the kexec. In the new kernel
> layout might have changed like addition or removal of a field.

The last time we changed those structs was in 2013 by fd0f7f73ca96.
So changes are extremely rare.

What could change in theory is the layout of the individual
capabilities (the data[] in struct pci_cap_saved_data).
E.g. maybe we decide that we need to save an additional register.
But that's also rare.  Normally we add all the mutable registers
when a new capability is supported and have no need to amend that
afterwards.

So I think you're preparing for an eventuality that's very unlikely
to happen.  Question is whether that justifies the additional
complexity and duplication.  (Probably not.)

Note that struct pci_cap_saved_state was made private in 2021 by
f0ab00174eb7.  We try to prevent other subsystems or drivers fiddling
with structures internal to the PCI core.  For LUO to find acceptance,
it needs to respect subsystems' desire to keep private what's private
and it needs to be as non-intrusive as possible.  If necessary,
helpers needed by LUO (e.g. to determine the size of saved PCI state)
should probably live in the PCI core and be #ifdef'ed to LUO being enabled.

Thanks,

Lukas

