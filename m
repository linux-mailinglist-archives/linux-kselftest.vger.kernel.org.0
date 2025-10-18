Return-Path: <linux-kselftest+bounces-43479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DC8BEC8F3
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 09:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F11E44E1B11
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 07:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7653D284690;
	Sat, 18 Oct 2025 07:09:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6106FBF;
	Sat, 18 Oct 2025 07:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760771358; cv=none; b=pabmeOZPSdi3tVSxYO9lyAQRpafCllGyuCQolXlyO+0XFKDsgr69Q3boa+1W3Zunii9tCkqJofzXlqlKnRJLGG85fcJXnOwYF7iqUirZMa721SCS43nkUTxwjzJBo8W0lkKd3IGGcO+lsJAHdv0sZ1yGoAb94OYA+GlaI7Ys338=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760771358; c=relaxed/simple;
	bh=mNXCjNL595H+U94hFRhIGLFyV97FKG5CtRSjePw7biQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdrtlCJ+n+v67CTrAaa2x+3o0UONObiJcqbphxH3gwOyrs4Iu1t937Nu+RSBHA/+7TWMAnhhSTeJNkXlYJJytcZAcm1vVRpphQ0DTRNpm+O+yvWGP0kniGTiyLoH/WRBlD8ENieMJOrmdlJ2pnIcZMBfAun4olGpq8bKID1oevc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 5A859200C2CC;
	Sat, 18 Oct 2025 09:09:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 43B574A12; Sat, 18 Oct 2025 09:09:06 +0200 (CEST)
Date: Sat, 18 Oct 2025 09:09:06 +0200
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
Subject: Re: [RFC PATCH 11/21] vfio/pci: Skip clearing bus master on live
 update device during kexec
Message-ID: <aPM9Eie71YsJKdak@wunner.de>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-12-vipinsh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251018000713.677779-12-vipinsh@google.com>

On Fri, Oct 17, 2025 at 05:07:03PM -0700, Vipin Sharma wrote:
> Set skip_kexec_clear_master on live update prepare() so that the device
> participating in live update can continue to perform DMA during kexec
> phase.

Instead of introducing the skip_kexec_clear_master flag,
could you introduce a function to check whether a device
participates in live update and call that in pci_device_shutdown()?

I think that would be cleaner.  Otherwise someone reading
the code has to chase down the meaning of skip_kexec_clear_master,
i.e. search for places where the bit is set.

When the device is unbound from vfio-pci, don't you have to
clear the skip_kexec_clear_master flag?  I'm not seeing this
in your patches but maybe I'm missing something.  That problem
would solve itself if you follow the suggestion above.

Thanks,

Lukas

