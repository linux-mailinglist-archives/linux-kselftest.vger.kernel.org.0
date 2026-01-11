Return-Path: <linux-kselftest+bounces-48681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EFAD0F6CE
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 17:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 840D530210F2
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Jan 2026 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96356346AE3;
	Sun, 11 Jan 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="U7n8J9l9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD3E346AE8;
	Sun, 11 Jan 2026 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768148361; cv=none; b=YR2SFiJvZUxGKO/+oPLorCVMCOi3v3Of1me0BiE5OsKB0AOoBYKuWg5ms6PTSufUupiDKwqgSVNSPhw9sCMflkGR7mC9OcCsXLBN8R9WTsO71q4tXyKKLB8w/FPd4s/MDUbcf0f01/HGrFPYSuFFp1/guZy0L2q2sVRX9AFzfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768148361; c=relaxed/simple;
	bh=hkmy4ce+2GBB/0wRfTgzZym0iQ/UALIdUVQ7hdDJVn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKaLSB/xRirk/1nWGxmNc9Nj6qQKXM4+89vt2hovueDmXSrmTbMOcZrI6WQ9IZwfaoHPyKdNHiS4P5vk01FHBWtG3RYtXRW2eDAJFZXagOL4dPYc21epKdJx2b7lCxS34j1pVQC6ogdkfGv7E5EsZOPhW3Dv2WFsVCXyCNJXTvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=U7n8J9l9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E665B40E01BB;
	Sun, 11 Jan 2026 16:19:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3n3jK2u_3lZI; Sun, 11 Jan 2026 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768148351; bh=usNVIStM/ChEDrz+Q7gs1Vhhs+9850l67vBJDk2/ybQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7n8J9l9dcwypNpjcm60eggG9eeNd+V410Zsl+QSs+GrZmIOHZv8r2sZuCQzIU93N
	 zB+1V8qrbJ5Jmnqtw6aBdZx/N6OLXaDa/7dfULo+xjcUavxn+u9CN+8+RJWQVM2xC2
	 xC4DC9CgO9Kk18nfvHhUvi3J/DZpPhr8PXMQPJ6x/Z0DfiE/6HnrEUKh0PxO5SBoz8
	 CeQYHdqnKgciM8fvYVQdfkYCbHXmivzAdNAiaYSTXa3OHIMY3G2JOqxLaqOSlWOUpu
	 70OrsUX96xxyMVCvBp1fKCw4BOXsiQRLFEqtAOm20c+aQ83eSELP80VeH/ydbTE/aN
	 xOoRHNkfNN2aFtEvpiqhrKTB5wUPmlz++AgkrLwKijtvy53Hh1X66PUGgpax/TZ/2A
	 oFk8OiWD7tqYP3jrQLckADQpu4mvELgtTLcuCIk9XR3Z5dewAZSA/NHecTsIghlxFU
	 Sl5S6KlKeH9rexuPfGTNYoyz4wk7cH/c/qYCX8GyANRYOdDrpqCw+p6eSlRz+WlM3n
	 rk8Qq/Jw+r8A26FRFYie6t+IH/Jc5hJM4cDn40Ip3qqbdVd9IGsyHxVWSbWN5mOhy/
	 qCT/9E1nKHf8tzTA7kVmK1aWiN/O54gtNYGM9gyaIII4QwHIopLAy5Gj7/WjRKL3zN
	 k5r3KkiizYJeFrF0SrDcO3ig=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E45CD40E0194;
	Sun, 11 Jan 2026 16:19:02 +0000 (UTC)
Date: Sun, 11 Jan 2026 17:18:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: neogulmanpassingby <jouyeol8739@gmail.com>
Cc: x86@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, hpa@zytor.com
Subject: Re: [PATCH] selftests/x86: clean up sysret_rip coding style
Message-ID: <20260111161855.GBaWPNb8_EiUnwAlJw@fat_crate.local>
References: <20260111143956.70422-1-jouyeol8739@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260111143956.70422-1-jouyeol8739@gmail.com>

On Sun, Jan 11, 2026 at 11:39:56PM +0900, neogulmanpassingby wrote:
> Tidy up sysret_rip style (cast spacing, main(void), const placement).
> No functional change intended.
> 
> Signed-off-by: neogulmanpassingby <jouyeol8739@gmail.com>

https://kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

"then you just add a line saying:

Signed-off-by: Random J Developer <random@developer.example.org>

using a known identity (sorry, no anonymous contributions.)"
	^^^^^^^^^^^^^^

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

