Return-Path: <linux-kselftest+bounces-27750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 566FFA47FCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1E018975E8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 13:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF15230D2B;
	Thu, 27 Feb 2025 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="LwEUZPKp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88EC22F177;
	Thu, 27 Feb 2025 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663777; cv=none; b=rt1DhlsuSq6b4hLTeRRqlxEvoP5fDLytrqR0r5Ugg4Nuwm7QRAlX8sx1NLeBtz/AU3O82OlGSrULfPORPjvt6Wct/zwAjTu534/5vRds75LyXZsSdLAt6S/5+Qgs+lCw4dsgvQ/zPaiveaX9VDrQkbr16Z3QLJhJGB+GPQ5W7SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663777; c=relaxed/simple;
	bh=riiiXkoDRvE48j0agmwVCiNuVc3bnAzwfJ9sDlQrhkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ioz5DftqLcjqoYzYFGYsQSiJrw4rLF/SHy0P99xsP+n4sYeW5503yTYeMRPG8X11UB4lEnNRFXsvySLQ212Hq+Ro7OPJPIc0mFW+558m7ACMcj09UqNoWI8pk27Ct0xzKIFKc2Ip3nntMCXxvbF0oSeoTOb5aa+9coc6/9QlEG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=LwEUZPKp; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1740663766; x=1741268566; i=ps.report@gmx.net;
	bh=riiiXkoDRvE48j0agmwVCiNuVc3bnAzwfJ9sDlQrhkU=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LwEUZPKp16ey/JhfbdX7rVNG7RevUp/6qrJVf432XaarOiRZQ255NBOdmHM5NPyd
	 h6izrnTNBNg7iIuMTjAfm/vkGe0y9juO4R3GEds7TAGnolT766gOFwdLKqxKEgxeR
	 KiSmUTreUp+ckjVaYAy6QUojFQSRiE/5uOEirH4UelrwdhkrX1keHaiCvtK9peVEU
	 bK78uYRudK3EBBNBmauzCGE98E5fWS/G51TTSr6cu9rMx5bKZ/nw3KGQAZstULjJI
	 Zp5i5LHuvNO6YdIhTK+Ph7LjM99Ms9/4Gxz1fDAg9wFR+irNu37VFlqzeFrBPAZak
	 k48VJfKPa2cUmTjIWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.151]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGW7-1tdxtr04Hl-00S1SZ; Thu, 27
 Feb 2025 14:42:46 +0100
Date: Thu, 27 Feb 2025 14:42:43 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Artem Chernyshev <artem.chernyshev@red-soft.ru>,
 Frederic Weisbecker <frederic@kernel.org>, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH net-next v7 4/8] net: pktgen: fix mpls maximum labels
 list parsing
Message-ID: <20250227144243.6953f14e@gmx.net>
In-Reply-To: <ec8fbe36-138f-4a0b-a8d3-95e49187a47a@redhat.com>
References: <20250224092242.13192-1-ps.report@gmx.net>
	<20250224092242.13192-5-ps.report@gmx.net>
	<ec8fbe36-138f-4a0b-a8d3-95e49187a47a@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yCmN0tzwMYCyh7IloeH9BsWmZLeaCd3Y/OD8EmO4xS7g/1Lfquc
 2jeVNSAp88WQ+zWU4BxTm7NWN7q+WTF8k04bPVDhrOTH3y795Sv5DiEDa72N2xyqaQttYwC
 DNL0WNBayo1+b3gonTLecBA7oplVGnIgV1r4nSnIIaG1+9z8MKLj2PJD7/FIkwViV52Z/sN
 rKKm/1oKgrtGZZrPEhHOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NwqR4tfaEww=;hKi3n6DMSwzCKMS2pz22cXcYYJE
 gT+PrLJ4MpmU4BUsqQIkBQvKEAZ70I+w2l1YKtdezisbMckEK/FQ97fTFUqES/+o6LcVbOXxs
 VTo9dzDEhtlkK71FIGpv+YH0oqJ1eZOnpATPifNSftiWD95HPVq7ALbpl5xX336dBe1kVHesD
 crZynMAdAeXxtzGDjZ92Aa7o4112AyOSUR/63W5eBm4Iqh4VkwARw+gT36XlKjW+As0jssQsp
 9uCGIRD95CEoil+f3sH3H0pKoEJbrezV0xSXYIDUg6yGvhULsrsTRaUSxAeFqPmplbKr37bDI
 oX89fPgyZEdaVRnN3ccpnHurzTFerTCCQ7pqZjmhEO6zlG1a0z2oSmFKVTJsO/jpOsaARcTUF
 EAdDTif4iIRcZX6ha+RNHakEy3Bm0BvYjjebUc1PXPWZoQm9xCt9fQifhl5UZEMtqyGk1gZu5
 5PRUXEQ+dJMbmIejlnM55LwWrtAK8clcCwLS7AJFQOmKTSa7yjhz8RquaAQqKp1oMl2AZFjaK
 GJYW1E4mBLoJ76yZ0kw8i4zsQXk2NG8/zaUahW5nnEkU2zzZ3wQAMp+C1tOj0nnXczV+9l+Hh
 2OQhWN8lQkS8HD/yZFfYDPSlKaFlU68RsegfSH+VgIJATa2KI88fdK6OwgnwzyjGhMBBwSVZ2
 UJdurc3HWxhlhWty4zBwRLQnEOd59du9uO5af7AbPvlGF71ODKRSOJ0it3LnIedHfXt/tzkYF
 76jFCkVP5C2lpDmslT9hecq8Vo1ZfhJDsMteW6PnAXOg7XUpZx35LcflFfY4XSFrxLAZifl2y
 NuwnhwAmQho/MUbOLe1j3y729OFFKo5TsY9maTc3jn4d3KxbI3VkO+hH7Z/H2uHUgEfbCUw0r
 MjkoNyJUWqjPIGMnsck24/sUmo+rRluwuhK+hhqW4WsqAA93wrLcpsAP96GgnmBAdfFaEBUKr
 7wNaMfYKmdK/yXfK6asq979tv+PF0rf4eLnpjG58wo21bDD4Ubdgu86fKh/JJrvVcjQBA2bRF
 HoCQnla89N1cLXPGFNgm5he71JNy73Edq0euomOaEXjEOWnK87lC97TlmWVDiO0IW+dTqhs0O
 keSulSnDkgl+Vd+dlnRhrenXyemkwDF5K2QmBMuTd0ymbqdU2sIAM9L3a1UW7r2UBOBA3p6Fi
 m3mv5I6hDXErX+2jYECAv29w969uG/UcXUN8zdNoQ4kxormDeRIdGC5NHXnhXaciF5NnjPQld
 P0hWKl/L/OYO42aTGckYdnDLKH7LjpKy8bN036DUcsIzYb+fk80+BaQIxmDpxlbCvAKg2hXVF
 vb88SxNBnFAh1acmhT8VgE5wA1vRo+xuj8HTLokSjpdXwjNoESKHXbhQr0dXr3sf124Qq2/iC
 p3Bp0xnfhZseTQh4/L4VExNEu88HlmSLuTWSyGBcJ8ossYN+WGGLDjm8ai

Hello Paolo,

On Thu, 27 Feb 2025 11:24:48 +0100, Paolo Abeni <pabeni@redhat.com> wrote:

> On 2/24/25 10:22 AM, Peter Seiderer wrote:
> > Fix mpls maximum labels list parsing up to MAX_MPLS_LABELS/16 entries
> > (instead of up to MAX_MPLS_LABELS - 1).
>
> Very minor nit...
>
> The above comments sounds misleading to me. I read it as the new limit
> is MAX_MPLS_LABELS divided by 16, that is 1.

O.k, will rephrase on next patch iteration, thanks for review!

Regards,
Peter

>
> Thanks,
>
> Paolo
>


