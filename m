Return-Path: <linux-kselftest+bounces-45317-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B284C4E44B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 14:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDCF3B3692
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E610D359710;
	Tue, 11 Nov 2025 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AqRPcRmT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kgw44OjO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58439359713;
	Tue, 11 Nov 2025 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869333; cv=none; b=LSLYAMsxvongw8R2cO4S4QxAGFdoi65PaeSk9Oqd6Xp0JmdfaVLe7PfqJmkmPnH2uDJCyMkEgq0jdGmDDNCY34wIOxfb3NMGTxtzK88DyIxTHpqAeD2NyMDXSbPO5SqdO8C85fmrum760M3ag7yYL5uSUkQ9iTcNSsYHLka5Ang=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869333; c=relaxed/simple;
	bh=py6CFBoy2M7OzF/rfzW71e05tRe08SSvbUmqxvQJHlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7egThSZz3aqWCAEoYJ4BFW9ELcIQGoTKKSjrnZVpw8/77iP9SuPR5pBwgogBCJFtNceWUm3xWB1oD6/lrdYLWX1BY1soP2mvbJtMs0EhTjgJFaNL2IiFcIURdeKWnSniNgvNP3MDTp97zisH6Yzvh7l26lM5jVn4d9CY0GzTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AqRPcRmT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kgw44OjO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 14:55:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762869330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CXL7lUHnq5dAWWan3vscO19pCllA3WFlN5CqXXNwmBk=;
	b=AqRPcRmTvbMeKbWYUnBtdhiDlAmEyLRNkysDVnqbpS/GjrcUzgqMoW1D42utIJ6wqQUXKL
	raQyzOXBIVHk97pyVDBydS8pky6dndHxSIxPumw4cofU3pVSD3esen9TRM90Aw6bt7uG7s
	7uSel9GXc+bmPYaNr4Iknz0Fj9XA2DZ1ePvFO7wDU3QDiI1EgAb6qkV/g8WUxoN4IGbGW6
	83H5xCuya7BguAXblkHCX+SorjIwKa159l7rKYI6xG5AF0EEYtH1FajYVGkJNZ8Grq2P/f
	ARBBNEhMx+axUqOxX2spKTcNwKpgTHc4Xc0764z5VkTgqowZGUc1V5E0Ma2xYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762869330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CXL7lUHnq5dAWWan3vscO19pCllA3WFlN5CqXXNwmBk=;
	b=kgw44OjOm5xmFjlzL4ukALppxVJAa0ZDLmvvFSJ5970O50A75AHCHTcpzgOWW8GHcPDCTR
	t/JSh6+ZQJ4qmjAw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	shuah <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 04/10] selftests: vDSO: vdso_test_abi: Provide
 compatibility with 32-bit musl
Message-ID: <20251111144805-ab2781fe-5424-492b-9cb3-55ebaaedc199@linutronix.de>
References: <20251111-vdso-test-types-v1-0-03b31f88c659@linutronix.de>
 <20251111-vdso-test-types-v1-4-03b31f88c659@linutronix.de>
 <29dd9e11-9ae8-415a-acb3-b96af56550b0@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29dd9e11-9ae8-415a-acb3-b96af56550b0@app.fastmail.com>

On Tue, Nov 11, 2025 at 01:59:02PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 11, 2025, at 11:49, Thomas Weiﬂschuh wrote:
> > The 32-bit time variants on musl have different names, provide a fallback.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  tools/testing/selftests/vDSO/vdso_test_abi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c 
> > b/tools/testing/selftests/vDSO/vdso_test_abi.c
> > index 
> > bb5a5534ae7e8a46d7e68a561684c29a752b866d..0a6b16a21369642384d43b0efd1bca227a2a4298 
> > 100644
> > --- a/tools/testing/selftests/vDSO/vdso_test_abi.c
> > +++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
> > @@ -166,7 +166,11 @@ static void 
> > vdso_test_clock_getres(__kernel_clockid_t clk_id)
> >  		clock_getres_fail++;
> >  	}
> > 
> > +#ifdef SYS_clock_getres
> >  	ret = syscall(SYS_clock_getres, clk_id, &sys_ts);
> > +#else
> > +	ret = syscall(SYS_clock_getres_time32, clk_id, &sys_ts);
> > +#endif
> > 
> 
> I think this #ifdef check is not reliable enough and may hide
> bugs. As with the other syscalls, the best way to call these
> is to either use __NR_clock_getres_time64 on __kernel_timespec, or
> to use __NR_clock_getres on __kernel_old_timespec.

Could you give an example for such a bug?

> If we are trying to validate the interface here, we should probably
> call both if available. If we just want to know the result and
> trust that both work correctly, I'd always use __NR_clock_getres_time64
> on 32-bit systems and __NR_clock_getres on 64-bit systems.

As these are vDSO and not timer selftests I think we trust the syscalls.
But how do we detect a native 64-bit time system? The preprocessor builtins
won't work as a 32-bit pointer system may use 64-bit time syscalls. I am not
aware of the UAPI #define, beyond the absence of __NR_clock_getres_time64.


Thomas

