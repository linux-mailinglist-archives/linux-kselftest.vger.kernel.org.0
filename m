Return-Path: <linux-kselftest+bounces-25573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F39A6A25F91
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 17:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC0D3A6C2A
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Feb 2025 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D1320A5F1;
	Mon,  3 Feb 2025 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S5D3jBy/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dTjtlolF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D14320A5CB;
	Mon,  3 Feb 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599282; cv=none; b=hgo2Vn0u5D6qMXE2xOzoikdLuKJdmClMQgGE6Ik9aGzv5x6OKs9TcaWOKthg4r4K3X7LENH2Go17MwGlgt3kPazuwyjgHx3678xIaJQW6CgHRw9/beosswEIEAqLEPXTKggTGTt2dzPsoz4elO6l+Iw+54al5toS4Hb4NsmL7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599282; c=relaxed/simple;
	bh=EykmNP3rluS5wErrw7ovJbnACKEeoG9NBVz3oDMId4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itMMCy7LRJlXy8SnEqGx5Wu001HRltH2A7aNjU5xEJcyGfI2nd3C+V28tcRzQ+dwStVimhykW2ENa1j30Hpp2Lp0rHkMdAMug81ofVmbETsaIcil0KJvkxzfTNnHjWsZgLTB7fsUHmT2CxNk+XkvqG17GltFggo/9SXx15W4k40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S5D3jBy/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dTjtlolF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 3 Feb 2025 17:14:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738599278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=asZhdw1u+KARy/b4tMAOwMpkr8n4az3G/BP7Mu330JE=;
	b=S5D3jBy/sT0HegQpG/bxMlN7VEX+wbEsF6ffTEin8SUYVFio3vdIlffoEffOprdmQon+gD
	QVpAGlzW58fZwQvzlQnpmFyC7V6/bMy/DbY/DmLanGm+3LwasiDd8VAzhaoMhkOopwv1Lv
	sIk9tdCBWA1A1RoKhl4cMH6lejYIpCa6uR3fNuTvKOPzdrtxojqjDYojll05mUPIOApG3h
	UGYVHxJaP+3wws+XVq3e32nnz2BTRfR5WeorfiDE6/NPs8voq5JC7f8ybhPV6UJAK4YkKH
	69U6oG7/38+gfOjVQR9IrSEMAvuPcq6s/orvL7QJhA7A17Zz27IdTR+0Fg0Cjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738599278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=asZhdw1u+KARy/b4tMAOwMpkr8n4az3G/BP7Mu330JE=;
	b=dTjtlolFTco+U66XNRG7CydXJoVHM9X6HvRGSZSw8iS4SW2LtJAyH01zeWKk/ilgf/1/L4
	x7g6AVMb0aJ7zVCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH 00/16] selftests: vDSO: parse_vdso: Make compatible with
 nolibc
Message-ID: <20250203165859-8af1246b-6dd8-468a-8e05-68c7b0cad304@linutronix.de>
References: <20250203-parse_vdso-nolibc-v1-0-9cb6268d77be@linutronix.de>
 <cd1147a8-25ba-47d2-a59a-0a686469a808@csgroup.eu>
 <20250203143640-70c59c53-af45-40cb-9a52-6395b3fdd263@linutronix.de>
 <937c99b3-3837-4510-be65-4eca3b280ce2@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <937c99b3-3837-4510-be65-4eca3b280ce2@csgroup.eu>

On Mon, Feb 03, 2025 at 04:43:22PM +0100, Christophe Leroy wrote:
<snip>

> Do you have any plan to get it work with nolibc for all test programs in
> selftests/vDSO, not only the standalone x86 test ?

Not directly as next step. I am focussing on some other work which will
integrate (vDSO) selftests with nolibc slightly differently.
However if you have interest in converting the tests now, that would be
great and will also be useful for my future changes.
The current issues I see:
* Missing architecture support in nolibc (should be fairly easy to implement)
* Missing kselftest_harness.h support in nolibc (I'm working on that)
* Maybe some users want to stick with their regular libc
  (Nothing should prevent that, but the mechanism may need some discussion)


Thomas

