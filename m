Return-Path: <linux-kselftest+bounces-25829-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62BAA28B40
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02951164D4A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0944D8C8;
	Wed,  5 Feb 2025 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="qfrYA9H9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A42195;
	Wed,  5 Feb 2025 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761066; cv=none; b=Gw/zU0d1/OCNgwD/eh8t/i4zkxlDUV4gpxij/CaO6+jP3CSdpaRB79XrJIg95hs2Xy+9nErNU4o2e/wS1TjKFdGxqdP+issrk4c/0m4nE1KxdkmWxTubVCfur+hZMp6SIJD4Vb+Qsdr9So+IcO3BTDj0WhtSq0rmGIlMtlCb4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761066; c=relaxed/simple;
	bh=corM3VHX1qru4oVXoYeXWyeQz8hXHcVfi5zDWEag+xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4oloc+SBHBM6WRK7kvjqZ+4ulTn7yTke4r7a0Fr2Hfl2iWWxb5uHeDG+cC/WrSuWU7/5Hy7s57+2yyjtePm2VvZVef8sZRZspGJRInTupxSUlmr5Bbpt+q/9bAV0r2nDxHfNvlHMiMDlssZvDrV7c0bjTXjcvkT6dge+xG/RPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=qfrYA9H9; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738761051; x=1739365851; i=ps.report@gmx.net;
	bh=SZdZ42vpXXffJOGHRoCIKYObvdfvemGW06NA0WlYtJQ=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qfrYA9H9LjKOQ9t/ud1ZhvOqw2eOTiSUoGGWaFgJXzSBUW5B2sOeNogaMe8DqPDr
	 U+wyNgPqeYpV4OBgzOnbP5zqQfXR51DzFZPnHFIKWUq+PXYdBWpP19wsbMBY4zoKs
	 q0jctnkJuv3qbj/l0A2m7Y5yg5+gTNddWKp0I+q3vnLtd2vBTLeXaFRsSatqyixQy
	 RF1HOshh8b77IsOX9BcSjXjNbEX6PlqxVU+0THttTqLjQZcZopwtU/hhr+K+WrMJH
	 oI7GhiWbAIy9pU4jZl4H72cfU5jcVv0PkXmj7ms/Pj7qw8mlXlxeNp8fmeYYz6Ute
	 jNvAirmtkiZCJ9D7vw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FjR-1tkM8b3a6h-004NZU; Wed, 05
 Feb 2025 14:10:50 +0100
Date: Wed, 5 Feb 2025 14:10:49 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Nam Cao
 <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Frederic
 Weisbecker <frederic@kernel.org>, Artem Chernyshev
 <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH net-next v3 08/10] net: pktgen: fix access outside of
 user given buffer in pktgen_if_write()
Message-ID: <20250205141049.6f10168e@gmx.net>
In-Reply-To: <20250204105251.GO234677@kernel.org>
References: <20250203170201.1661703-1-ps.report@gmx.net>
	<20250203170201.1661703-9-ps.report@gmx.net>
	<20250204105251.GO234677@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jT0Nv29OurXT9e9e5p/BRMiHbAiM2YW5paPWb4zpNkM+ZhNSi86
 banbZC2o3jnjFpLJM8R7P796k3DMHDnK+XCTXWmY327jSk2ej+scjvDwe8RqU+hRge2GYE4
 e50C3czspshxYb4gv6gpAYNvWSGMf8OfbRriIUMaqnBwk1Qo6aRtAlVVf35mejFZQwXNq1+
 XGJ7w04fWefvb2SAvliuw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HLBicFi5c/Y=;78jaOoJIgmjVzumEMC5zB32lvip
 qBR4bv9+6sXQHUnepMwxAKxSvJSBML692/RdKivkgKqcNmlwobirVxz/qCFC1QuLVXJ4kWOS4
 mkm/2Jh2IRjPaadxnr/pUQ1lxFnLrElMRrP/5DQMmuhedd9A7wTFFDjj9xH8WTwew9vPj3yDM
 ONdE62hkNRkn861Lnq37woYyaULGBXUpHq4A+romXOWVeUSM8TPbj1mlq+5RrbAg4fSbSL3/3
 xoTCPv0x4HKysvmDusWYnaQl554zMFyyUbFH+sHxM2SzBNOnKpFyFdLty02iHfPhaNlCa2abp
 /JFmnulfMscBC2nfzNcr0/jFDqpe8HB0FSL73TnGNlA/TMrowpUHn7szpBj6wNig0tiSmDELy
 qX81P/YIQlgC4mneWQEMkLvH+nNAXJdPDDx0V1noMosEmvkuwQ48CxWr44mXgVON5yhrSAV+E
 y5ewr5Czgs1Ebhoh53oBGzWcQkWvizwkD5g53/+vBGvZusKUT03/NoaUvV97d96Vsr1HxcIOR
 EsNNcn5oCkEOue/cI8qD01KLb2HBVHhWfIaVuVd/aDRMgPmKmu+JGD/vy0UzGJ+ULuRK3Z8HL
 4hK7rKiSzrr5ozXZZgYf/F98B3bSz2XBzcyYjKhDI0g5LOi7f0wxP1ElI1+wab34/RY/wUTQI
 7xhghKwXMG+/a0lQU/hHIwOh5gDpOesPVUxfXRwzfja9mXb1QwbXzbAbNoq2x/CI3Cjol7nU6
 q/rjGHmzF1D0eharvVS/YijzJRJliCho/E/1NyAsmg/5FjA/8YlDn+0wESAcKZoVTh0njawzI
 HxXfFV0nMZsyOTQOXCVIdlU5mS1WN5yDlorLNBmGmK9oX2TMhloEZssm18rqBM1ieaS3YrSMp
 s83vPTaXcvfJK3RH9CPOe4TW8JfhSC7xqImxfB3czGt2cx94kM6th5FdO7mt9qBA5ftGAdh/u
 YviVyU6ARNR6UGatjWCoTWg5W3FPVOToy+V3PA7/keLjRsSTKmEAJSvzE+1+n7075Gjihmrva
 wx66grZeJ3GW5mopOgf2TyXSpoosqGaZbak5+fyUGYjY3eev99vViG4wQEXVcqgsUmBw0kX/X
 YhYLYmPDItFPr6J/uzHw/aj4Nt18wQRvWdDirwIxip43B/wW5/+CTFADqvxJrZpwbNHQy7aSz
 LUVdoLgt4tC7Rzo29VJsrUF5bRZKJOxJpstvIx8/6QtPbA+3Nqa5BnEvhEu7vd9IQvJA0/wIb
 xUZtq1/SkxynncFUhJu3A61odSRujV3sBsntr6L8v99DvjLolvNP/N6YiNtZl8QoN4hEinNqb
 W2B/3yBpZBwPptj96duHUGS1hSf+l0eI7ZUuiUeqpWX9khf1theWBdJaUUbMgsM2ngAvzjdIP
 2hxYiou+2FhB7FgXXpxUd03UmXc2QLfUvFU13UyUyCehqtbwxyMd4cihpW

Hello Simon,

On Tue, 4 Feb 2025 10:52:51 +0000, Simon Horman <horms@kernel.org> wrote:

> On Mon, Feb 03, 2025 at 06:01:59PM +0100, Peter Seiderer wrote:
> > Honour the user given buffer size for the hex32_arg(), num_arg(),
> > strn_len(), get_imix_entries() and get_labels() calls (otherwise they =
will
> > access memory outside of the user given buffer).
> >
> > In hex32_arg(), num_arg(), strn_len() error out in case no characters =
are
> > available (maxlen =3D 0), in num_arg() additional error out in case no=
 valid
> > character is parsed.
> >
> > In get_labels() additional enable parsing labels up to MAX_IMIX_ENTRIE=
S
> > instead of (MAX_IMIX_ENTRIES - 1).
> >
> > Additional remove some superfluous variable initializing and align som=
e
> > variable declarations to the most common pattern.
> >
> > Signed-off-by: Peter Seiderer <ps.report@gmx.net>
>
> ...
>
> > diff --git a/net/core/pktgen.c b/net/core/pktgen.c
>
> ...
>
> > @@ -872,7 +886,8 @@ static ssize_t get_imix_entries(const char __user =
*buffer,
> >  		if (size < 14 + 20 + 8)
> >  			size =3D 14 + 20 + 8;
> >
> > -		len =3D num_arg(&buffer[i], max_digits, &weight);
> > +		max =3D min(10, maxlen - i);
>
> Hi Peter,
>
> 10 is used as a magic value here. I think it would be best if
> it were a #define so it has a name. Likewise for other constants
> used as arguments to min() in this patch.
>
> ...

O.k, done in the next patch iteration...

Thanks for review!

Regards,
Peter


