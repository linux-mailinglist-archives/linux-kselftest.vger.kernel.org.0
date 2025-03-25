Return-Path: <linux-kselftest+bounces-29731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF7FA6E9BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 07:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0CD16B7E1
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC01F4C83;
	Tue, 25 Mar 2025 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="trAkFVE0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XcoXRdzl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C5114D433;
	Tue, 25 Mar 2025 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742885334; cv=none; b=gemJDSrHFd1tCQUr1cyIRi7NFyfFT6xEDbMug143Js2YMwrtUndztV7gztaAcCJ7+LIG0UZSQvlJwobw9DaILpgPGvqchIDF4r1TVQdtYHwxhGwBUsu1dq1RuZMK0Qgazz2T+P9tIMk/xqRG6L4QOjnJiLSEv9PaQyvVqDOxGR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742885334; c=relaxed/simple;
	bh=1OnlDqBmO57Cp4YGRkemYySB4zQGEonh2Y7NCjHl4VU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgxBsfLuuKl42PWWcM+mEaOsl/W5ees6CJKxgYfIoIDgYT59GrLFl+c3Ghe+3uzHYWvS2jvNeWVQVfqcyH86ioNNSDuviH+v4xIFTpab1nygSmQLGiUXeh5BNCTvFZPKTJ3h662mW8CTnihoGCM/evZaA2m1VDyMV2L8FfEkFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=trAkFVE0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XcoXRdzl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:48:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742885330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eD22Bl4WihDJUGBwqi9EBChpUu1aLIV1RPElgqzdwzA=;
	b=trAkFVE0hQ+aKXYP6QE5EDHGipSnzBfsZ4QmW0/hgTG7Ao6BOuYnrblX+vbbEMST5NYScV
	cLBsfOfRiH14VbLy2y0ncmxHnOWGy9lAQoWEBEXCTjio/RLTB2B52vK1V+U4xyXtCnQhF5
	vASmgxdA7GTs+Pvree90KGMLl9HVVJj9f2u96bUJ/QCdU93ZAae5dI5RwQBu3reLLigjLH
	jHFt93tSZXfNawjqFJC19d0d0IxtyQi+nibZ/j4Ra+8Kq7fabrSGvdzri5f7l7I6agYURI
	9j3tLsnfftRDKNnU6MsP/ScWAORF/UAZdUPer/ygDqoD/OEPfo39XpnCu5cN8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742885330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eD22Bl4WihDJUGBwqi9EBChpUu1aLIV1RPElgqzdwzA=;
	b=XcoXRdzldi88NcijSdCoFoD7LQ2bGsA4Qi3RiLxs7WLxvf3z/ppKZO+iuOLw5hh8TjtxYi
	t2RI8LnwIXcpMkAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 3/3] selftests: vDSO: chacha: Provide default definition
 of HWCAP_S390_VXRS
Message-ID: <20250325074319-b478adcc-3e04-447f-81b5-c92741c91bfd@linutronix.de>
References: <20250324-s390-vdso-hwcap-v1-0-cb9ad001ceba@linutronix.de>
 <20250324-s390-vdso-hwcap-v1-3-cb9ad001ceba@linutronix.de>
 <20250324155513.12139G44-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324155513.12139G44-hca@linux.ibm.com>

On Mon, Mar 24, 2025 at 04:55:13PM +0100, Heiko Carstens wrote:
> On Mon, Mar 24, 2025 at 03:03:17PM +0100, Thomas Weiﬂschuh wrote:
> > s390 does not provide a hwcap.h UAPI header.
> > 
> > Add an inline definition for the constant HWCAP_S390_VXRS until a proper
> > UAPI header is introduced.
> > 
> > Fixes: 210860e7f733 ("selftests: vDSO: check cpu caps before running chacha test")
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  tools/testing/selftests/vDSO/vdso_test_chacha.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
> > index fd5c5108b42f04ec459d39b74f33edc2ceafbba1..0ce5189718ce35b0a4d69b71559db8379b598b93 100644
> > --- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
> > +++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
> > @@ -19,6 +19,9 @@ static bool cpu_has_capabilities(void)
> >  	return getauxval(AT_HWCAP) & HWCAP_ASIMD;
> >  }
> >  #elif defined(__s390x__)
> > +#ifndef HWCAP_S390_VXRS
> > +#define HWCAP_S390_VXRS	(1 << 11)
> > +#endif
> >  static bool cpu_has_capabilities(void)
> >  {
> >  	return getauxval(AT_HWCAP) & HWCAP_S390_VXRS;
> 
> How did this cause a problem?
> 
> Did you use something different than glibc(-devel) on your test
> system? Just wondering since glibc-devel provides the define since
> ages and is also required for getauxval().

I used nolibc (from the kernel tree at tools/include/nolibc/) to make cross
platform usage of the tests easier. See also [0].
I got confused by the existence of hwcap.h in the kernel UAPI headers for
various architectures and didn't check the libc headers.
So this isn't really a bug right now, and the hwcap changes will only really be
necessary once my other work goes upstream.

[0] https://lore.kernel.org/lkml/20250217-kunit-kselftests-v1-0-42b4524c3b0a@linutronix.de/

