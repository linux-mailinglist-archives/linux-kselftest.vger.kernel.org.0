Return-Path: <linux-kselftest+bounces-43480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23472BEC916
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 09:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9098119A6261
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 07:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287072777E0;
	Sat, 18 Oct 2025 07:17:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461AA208D0;
	Sat, 18 Oct 2025 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760771858; cv=none; b=bf33l8JuY7EaJoNXp/8Im2G5iLy8kzn3hOhuLjZCHkCeNIV5oFvke0mZShTFdMsUr9n4BEOAelDcofxyvPszFOFclhdbvZGC1OrZt+ZwJWmP+3+KAn05lvKC2aS3nAraF+R0LVc1uhymNXpBsXeT3UChwU7egrF4G5H5LXp0fBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760771858; c=relaxed/simple;
	bh=1MOfBRHdignkMg8DmwHGBZTfV50Sxp7xsjmSXPeUrQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoaA4R6DE0pN9/nMaA3+tGoxhGGfreSJjyeg1ELR1frZKTPkBRaHRBneY4GQJ9N8LcwKxdw/ogRDyfX02SGRK22rhSsiqAkWUvYir4fme/C2+VoaNGJKyTYgtm1ey/kwy2gLHYYqK4QOYBNSjpjnpto8hDOIe6mN3jDvmYD9PfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 902302006F45;
	Sat, 18 Oct 2025 09:17:33 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 88C6C4A12; Sat, 18 Oct 2025 09:17:33 +0200 (CEST)
Date: Sat, 18 Oct 2025 09:17:33 +0200
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
Message-ID: <aPM_DUyyH1KaOerU@wunner.de>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-16-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000713.677779-16-vipinsh@google.com>

On Fri, Oct 17, 2025 at 05:07:07PM -0700, Vipin Sharma wrote:
> Move struct pci_saved_state{} and struct pci_cap_saved_data{} to
> linux/pci.h so that they are available to code outside of the PCI core.
> 
> These structs will be used in subsequent commits to serialize and
> deserialize PCI state across Live Update.

That's not sufficient as a justification to make these public in my view.

There are already pci_store_saved_state() and pci_load_saved_state()
helpers to serialize PCI state.  Why do you need anything more?
(Honest question.)

Thanks,

Lukas

