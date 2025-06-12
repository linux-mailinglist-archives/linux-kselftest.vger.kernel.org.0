Return-Path: <linux-kselftest+bounces-34825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B36AD7631
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 17:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13183B2670
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E1D2BFC74;
	Thu, 12 Jun 2025 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hPliXOhA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+BgbbrzB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF952BF3FC;
	Thu, 12 Jun 2025 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741786; cv=none; b=SHZ6JOKmwwx6H09aXAfU1ErZrN6cahnEp2QjZt52eXyyXtTGo9CPTXPlhHUx2O0YWFv9EBF7oKXAzFBCY0JzdZdGdNvoBhV/Mo87r6gCZX5Kv2Ea4ipnRF6XJnsqk10gSw2U2oYwK+xt/nj8fxWH2Um+2pOoY+ps+jiomgXON2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741786; c=relaxed/simple;
	bh=109r9m51nhbXd4XW9VK8INeIft9FNq31oPO5TLsUxVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESb7Ujt8qEmvrCqz/MX8LLTUaZpi+bscbcjPM1UUibjSvmWIR5rY2r41/MZmOuq4q2Kn2MkrTxxpgHUeDHciwzIsl0lykoePCcXMMnJrnJwpBMlYATtOkg85IyvvQkzwNfBydTBTh3ui86HvZWZyowgg7L4ImY456Uz81EzPOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hPliXOhA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+BgbbrzB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Jun 2025 17:23:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749741782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxodMvHky9N8TaH3XwaudPITft4aNZE+idcZWUcu2a0=;
	b=hPliXOhA8PdYV+bAZbJ5jLSXHK0yB7nnwnKeyZjpyco4LAXIz/oG85h+pDN03l6jUHmr43
	/Sd0EUocstOkmm2IoLoFNFMPboFXb3hQq9nVFt+F61Sv/ETvf6liEpFw36goAysAwDyIf+
	Jigravn+lyI/s33UGFdWK18njs+f0/HnxVgK8HgbbnoubDSJlMgpa1zovCukSi5ScsrV9P
	QuChAkAVpSwxlkP4+oOXpZYpetVfG18pkcjFkbSCgYq+yMY0cum4Fed02NeP3usV1x9DXK
	E6MUM4Vk8HHP9NEpNaWSu3qLYUT3ksnv5Af8zgAFbXoAUS4xgDrdwYCuk6orcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749741782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxodMvHky9N8TaH3XwaudPITft4aNZE+idcZWUcu2a0=;
	b=+BgbbrzByV4uDL66Swwva8QAo1HaXmAcK1d6VUxDySAMkkzndIVZwLYJMiIjxURE4M+pHE
	gidAP1ExrK78RDDw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Willy Tarreau <w@1wt.eu>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, Mark Brown <broonie@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 09/14] selftests: harness: Move teardown conditional
 into test metadata
Message-ID: <20250612171437-450fb7d6-c73a-47e3-9e1c-5c009cba7fe1@linutronix.de>
References: <aEkqtfcOJDrxAAcs@nvidia.com>
 <20250611093942-f6c65a06-c72a-4451-aa1e-8cb8de0d69cb@linutronix.de>
 <aEm6tuzy7WK12sMh@nvidia.com>
 <aEn5jmXZbC5hARGv@nvidia.com>
 <aEoUhPYIAizTLADq@nvidia.com>
 <20250611235117.GR543171@nvidia.com>
 <aEp6tGUEFCQz1prh@nvidia.com>
 <20250612135802.GU543171@nvidia.com>
 <20250612162151-1fc97a6c-a1c9-4656-997e-fd02f5f9418b@linutronix.de>
 <20250612145801.GV543171@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250612145801.GV543171@nvidia.com>

On Thu, Jun 12, 2025 at 11:58:01AM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 12, 2025 at 04:27:41PM +0200, Thomas Weißschuh wrote:
> 
> > If the assumption is that this is most likely a kernel bug,
> > shouldn't it be fixed properly rather than worked around?
> > After all the job of a selftest is to detect bugs to be fixed.
> 
> I investigated the history for a bit and it seems likely we cannot
> change the kernel here. Call it an undocumented "feature".

I looked a bit and it seems to be mentioned in mmap(2):

	For mmap(), offset must be a multiple of the underlying huge page size.
	The system automatically aligns length to be a multiple of the underlying huge page size.

And MAP_FIXED is documented to wipe away whichever mapping was there before.

> MAP_HUGETLBFS rounds up the length to some value, userspace has to
> figure that out and not pass incorrect lengths.  The selftest is doing
> that wrong.

The selftest would be more robust if MAP_FIXED is replaced by
MAP_FIXED_NOREPLACE. Even with the new explicit skip logic it should
make debugging easier if something goes wrong.

> > If the test is broken on ARM64 64k in general then I am also wondering how
> > it didn't fail before my change to the selftest harness.
> 
> It got lucky and didn't overmap something important.

Oh, okay.

