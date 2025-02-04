Return-Path: <linux-kselftest+bounces-25693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E19A2758C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 16:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BF23A6207
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF7421423C;
	Tue,  4 Feb 2025 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iNGyp3pk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xOlqyZ0t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC4214228;
	Tue,  4 Feb 2025 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738682230; cv=none; b=fTDi1guWNxTQT2zgw0Y0v+aOBUjtsciQ8XrvZcKxQKFwH07dBk2DgcQxiiVC5xMroduPJjMSp4I9NTbNEGY5AWKawj6uXH7n7O+AB3exK9gPTGSBbvk+BSbJ7CQckqln0xJG7Do0CnE54KIK7NqbLwpWRq983K5VI8opkqo6li0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738682230; c=relaxed/simple;
	bh=HZST+I4clllEpnFcdIeNwwO8hJlljh75MXFwylPNzZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8+L0z5odBp7fT/inIkvspKlapgl2DmcbHWgHAcKHgjDDcuoDWO/kbx1nnI+m3qNkKSReshZ57BdlMo6WgILZieFcvObmtO2+k2D7caYMRIsA/YJY1OSJWdjH00+6hGha3dJFvxCDuZ7D0JVPo/eL4pisj03P0eN9AWb2bEeuUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iNGyp3pk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xOlqyZ0t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 4 Feb 2025 16:17:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738682226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQ90/s5/L5n9DHA8Znts0YftmEUY0HwKZk1j+bODf+U=;
	b=iNGyp3pkdzS/NdDnIfv/2kHoQsIwsK/6cvGhLBmekh0rOLGid+hiMYK30XQzZJ3GLp1TlC
	zqw7VYVUBdrsQkmh5Pcw6SgDSEwVXeKhAGTJZPxPLc5dDnGwgADsz7Aw1HVTbKqUvl89/F
	D6gF5ToIBidSVEgrYUVI25nuI93Qkew0lR9+4QjZkgE9mve6TwicWHwrxtnosz2GKGIS3B
	tDJPS+qU28RahEj4TROuwcP0WruIMjL1c7cj5A2wZeSSArA/eatOhGONI2+NSXS4LJwBtO
	8+tg7qTgzsSIMvTMPVtp+kM4sR1gX3eFQdHpfC6Ly3FTixZv5A7m8v1KNUInNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738682226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQ90/s5/L5n9DHA8Znts0YftmEUY0HwKZk1j+bODf+U=;
	b=xOlqyZ0tj1IUFVmgc2T1w6Y1lzwHQbeSc+tGzONxP4+KvOkGHHhxd5F59LIvckwrhGJ/Dd
	Uj5g3C4Qzdjth7Dg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Kees Cook <kees@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 04/16] elf, uapi: Add definitions for VER_FLG_BASE and
 VER_FLG_WEAK
Message-ID: <20250204161210-b788ff6b-9c77-4a9c-8ab8-8b727b0b2003@linutronix.de>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
 <20250203-parse_vdso-nolibc-v1-4-9cb6268d77be@linutronix.de>
 <202502040708.6E9CF77@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202502040708.6E9CF77@keescook>

On Tue, Feb 04, 2025 at 07:10:00AM -0800, Kees Cook wrote:
> On Mon, Feb 03, 2025 at 10:05:05AM +0100, Thomas Weißschuh wrote:
> > The definitions are used by tools/testing/selftests/vDSO/parse_vdso.c.
> > To be able to build the vDSO selftests without a libc dependency,
> > add the definitions to the kernels own UAPI headers.
> 
> For all the UAPI changes, where are the defines "normally" found? i.e.
> how does adding these to UAPI not break something that already has them?
> Or have these never been defined before? I'm confused about how removing
> the libc dependency exposes the lack of these defines. Are they defined
> in a non-exported libc header somewhere?

They are normally defined directly in libc <elf.h>, which does not use
UAPI headers. Libc elf.h and Linux UAPI elf.h can not be used at the
same time because they define the same symbols.
In theory some user of UAPI elf.h could have defined these new symbols
on their own without ifdef guards. However UAPI elf.h is regularly
updated with new symbols.

