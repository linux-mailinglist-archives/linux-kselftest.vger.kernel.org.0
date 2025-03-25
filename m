Return-Path: <linux-kselftest+bounces-29739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E40A6EE41
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 11:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4429716CF81
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 10:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34F41F0E38;
	Tue, 25 Mar 2025 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C1Fl0Spr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EwXtgt7n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4955A1EA7E7;
	Tue, 25 Mar 2025 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900103; cv=none; b=UbpWipBzsmTdbOAm+TnxCInKskvAFtXI6b4X6M9VD1zXxqGqgIrP//Y2X0bx5wuNmzpWbGIUAjpFl+9AwqUivX7mXbkAkawtHIOKsBymDcyHJrUAajxz9Gln6L10WDqhFcecbqpP9wEYOEAcwoH6aAKfdlLZilGA/nlONkz0oIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900103; c=relaxed/simple;
	bh=P1ychP+36qjmXkdCWXhrk2xGfDgipiJ7S+cbf1cusAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqdEPlS11RH5Kgd5d+Hz6kBu+ba+THsvC+D5JX3mCMrAskKC0iujfjeU4ATk5b512H4rUPdx7SL7zcetJlJsmv2yTud4W809dG2vDqhoPArOKk5O4wLp1uPqrY62/VRrcuaOdcIZ12QrW2RE87uUKHCjMOhB8BZOuHWbvJFVtX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C1Fl0Spr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EwXtgt7n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 11:54:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742900100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65yWQ8YBB+8DDN6DCpX/9zSZQCjct9PcGo9p6rB0SL0=;
	b=C1Fl0Spr8Z2jSRNT50xhm3wK+Du5SXlyYowPLzDGgGn4orGOTyQ4WfxyFea1jrzbdHi8PX
	GqN3zz3tWaG6cDObGVdXyzfrkS4Qw26qe2fvNWYjdKBq5lCatdf0BTDGdmQlA5Si9wffEF
	JDnK5YUAteBTE2y5MJG4lDFltLGt3oyjg6enjAAeapU6F4ok4d6yLp38Xj8K+YSRjQ5hkG
	GkU065DJp2dUdvbi5p7NJhh7itPDthop8Ga9GNHtrM0ZGUTYNNIZjAkDU/2l7epTQ7ZI7w
	gGm4AK3Y0+jUFVSabsozXAFFx26UkBD3YBcsDOuomZOnPAJZeRVgwgh/owESrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742900100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65yWQ8YBB+8DDN6DCpX/9zSZQCjct9PcGo9p6rB0SL0=;
	b=EwXtgt7nrastImk24s40TB/rYZFUxBRZ3lctbVCOLhOeK4t/rK4UVKebbp6I2zu2AA6CQ4
	DLGC/XgGtx+gB4DA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 3/3] selftests: vDSO: chacha: Provide default definition
 of HWCAP_S390_VXRS
Message-ID: <20250325115127-0eaf5fcb-202d-4aaa-bfd2-fede68f8e7b4@linutronix.de>
References: <20250324-s390-vdso-hwcap-v1-0-cb9ad001ceba@linutronix.de>
 <20250324-s390-vdso-hwcap-v1-3-cb9ad001ceba@linutronix.de>
 <20250324155513.12139G44-hca@linux.ibm.com>
 <20250325074319-b478adcc-3e04-447f-81b5-c92741c91bfd@linutronix.de>
 <20250325071840.7910A12-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325071840.7910A12-hca@linux.ibm.com>

On Tue, Mar 25, 2025 at 08:18:40AM +0100, Heiko Carstens wrote:
> On Tue, Mar 25, 2025 at 07:48:48AM +0100, Thomas Weiﬂschuh wrote:
> > On Mon, Mar 24, 2025 at 04:55:13PM +0100, Heiko Carstens wrote:
> > > On Mon, Mar 24, 2025 at 03:03:17PM +0100, Thomas Weiﬂschuh wrote:
> > > > s390 does not provide a hwcap.h UAPI header.
> > > > 
> > > > Add an inline definition for the constant HWCAP_S390_VXRS until a proper
> > > > UAPI header is introduced.
> > > > 
> > > > Fixes: 210860e7f733 ("selftests: vDSO: check cpu caps before running chacha test")
> > > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > > ---
> > > >  tools/testing/selftests/vDSO/vdso_test_chacha.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> 
> ...
> 
> > > >  #elif defined(__s390x__)
> > > > +#ifndef HWCAP_S390_VXRS
> > > > +#define HWCAP_S390_VXRS	(1 << 11)
> > > > +#endif
> > > >  static bool cpu_has_capabilities(void)
> > > >  {
> > > >  	return getauxval(AT_HWCAP) & HWCAP_S390_VXRS;
> > > 
> > > How did this cause a problem?
> > > 
> > > Did you use something different than glibc(-devel) on your test
> > > system? Just wondering since glibc-devel provides the define since
> > > ages and is also required for getauxval().
> > 
> > I used nolibc (from the kernel tree at tools/include/nolibc/) to make cross
> > platform usage of the tests easier. See also [0].
> > I got confused by the existence of hwcap.h in the kernel UAPI headers for
> > various architectures and didn't check the libc headers.
> > So this isn't really a bug right now, and the hwcap changes will only really be
> > necessary once my other work goes upstream.
> 
> Thanks for explaining!
> 
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Thanks!

I'll wait for some more feedback and then resend the series with some better
explanations, and without the incorrect Fixes: tags.
If there is pushback for applying any of the patches now, I'll carry them
downstream and will resubmit them as part of the later series which integrates
more of the vDSO selftests with nolibc.

