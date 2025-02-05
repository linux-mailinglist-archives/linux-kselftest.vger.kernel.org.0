Return-Path: <linux-kselftest+bounces-25828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDEBA28B3B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 14:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC75163CCF
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61B3282FA;
	Wed,  5 Feb 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="fInFzqJQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA2ABA2E;
	Wed,  5 Feb 2025 13:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738761014; cv=none; b=SgvMi5GDaWTDpGfuXO0Bq6xsNOt+/BSfW6ro0neBk3AXgbHVODHG8WqrRVG8Y5/sUI1tMgyt8COufJ9Wj/1caB1S4CeDYi053ll+2tm/t6EpUugveQIkYW/jehpMFE4YXEB8ILd1neCupqTbhurl+3/i0G/VMuy4rDr7x+6QE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738761014; c=relaxed/simple;
	bh=vP7sRrLpj41lawYtrZLY+Fj27TIPlHVNPuj56Uh0acg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMqhb6N8MmUPFaMxSDBD4ejjL3RQf75fQuoz6uhGdVbfE6BFvhN4BDIyLCF/OARKNsMJeZW5Fe1BXFQsMgcrYXXi8wDANzHOGHivks0PQez8bpVHT11yk5ikeUX7xHY6Vc3JWF8PXT2mqDnAS7FtQL1Yjd6yNmZ9515nKiP8qJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=fInFzqJQ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738760991; x=1739365791; i=ps.report@gmx.net;
	bh=zK0CIvh2VCWpMSQgtk80bK0aRtIxPNeDOGHf2uy/QL4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fInFzqJQhTL2fPw5JmiqAjUYuWFXTh7fo0YwC35U1Tb+cehRlkj3iG+bTr2TGhAq
	 M5Tz0oc4sGM9vkFtwvrW5wTWZrYRNQTK3ohI3YCIa8TSrZzT/ZXLWVHAac24Iy7a3
	 XjUFv/pA/7Q7bFTMsHXBUz1DpBlq2vpxYbYS8I7QeFVicwBJVKNuUBVON1GOe5xL7
	 j36gMNJoCF0Y6+QSykDZnhaDRxRJUYai7FyG1waT9fRaZHuKxYIN6xLbHnF4NSjWV
	 Nc8Ws92qkF60xcknyzX4haklzBesvrcT1HP+LUQrgLlyS0hJwXNQZVD4KMiO35s7q
	 7JEMHSQF+D59PoaUOg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.162]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1thay73Dar-007uDI; Wed, 05
 Feb 2025 14:09:50 +0100
Date: Wed, 5 Feb 2025 14:09:50 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Nam Cao
 <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Frederic
 Weisbecker <frederic@kernel.org>, Artem Chernyshev
 <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH net-next v3 08/10] net: pktgen: fix access outside of
 user given buffer in pktgen_if_write()
Message-ID: <20250205140950.12408311@gmx.net>
In-Reply-To: <914e488e-af7d-4301-8be2-410db5325f14@redhat.com>
References: <20250203170201.1661703-1-ps.report@gmx.net>
	<20250203170201.1661703-9-ps.report@gmx.net>
	<914e488e-af7d-4301-8be2-410db5325f14@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kR5rFf1JCRth4wJipHJMrwrpORrllzA9qdCXcBYZhJKKJiwiWEh
 P6aeLfhDvcbsTfPKe2IR3R8O0R94uTcDJvQsqjbmZU8LISbiu8yVjD/WT7b3jlYC4DYjoG+
 t3C/PMI15B9bbOpTgUwSWZ3ShAbHdm3PbmTQKTc6UPtQKfYwuNcJJv6bBrL6Cn4ydZLd0BQ
 +qF9w2/Xu6gVEkrMWsykA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9fFu9GiEj2g=;ZmF143jywp5SfHraonSpJvDP2DB
 j3nSavETqVCOu32XebhM8X1Dv8b6OeUFYt9VlaAejqNBQ2DrWYE6GCJSVa5OWKepQyf33Zx+O
 3FxtozUZgc72Sy3HmYde/nzRWr+DmyF/MFQYeiHjuwufkPXwC8Mk0/kGhtIlID4N/o6o5AoJy
 YDtaMs06yAwyJ2a3NNSLs8yBec5uTtNMPphmW1TeeMbilb0dWeMJdXjc+QfLHeB5gE+MtRnwJ
 V7Vln7Sk++LUfko3DWxwQ1GNtKOdTp+Gidxzgqkk7jgPgCex8ym8J+HsGSXGYdUCHuIgyJig6
 93EKo2gpNDYIIB9PTNo4fmp/6Ql22Ypczo4ZhagJ5frY0iMNDZaoETlr6KMx73Z5iTzuKFik7
 rBv4HgbuTQvxyMR6dV7uBH9SxaHhZLaPEH+J8Hz2TP7SFTJ+iJcSED4aVCzQ7b8j/uTzD1wbL
 2yLanQd1kHoUWuXbeVHZKF+c6OPOCQshO0tPrGUhapSC5NkErFkwNBcPLbxzLmlB3KdOtDoYR
 XSKB0VkBSJTGXsNa+Myc/zketEyOFKqrmyOJmX1jpdDvSp1ZMv0XVk49kjpuUDn0ToT6QifJ2
 z+cmuSEUnZEx195tnEbUWlhGapS+N01soo/BvyHs1RfrXkltvDbJ/hLmxN0zszb64FSHg4i/L
 aX0Rbud9IBmdmCnqXpIAeBaBKFHJStYZfu+9ZrEHVnc9xyxtJut4XVm6LKj5u7VVfYegkSR65
 Xtj0GsrG3wunH2jCCpAULna+cInjnv0wegNdQBT581G4x39wPDpOvSDZZxRK0qR/G4f2kCgl0
 7OrrtNBiw5TB8jFrXpdP+4jS1igDwPXOAiEr+ws0geucZQC1pF/sbbHe3mL7jmJvJh9YJfops
 G+fpvL7h4KjdEifDafjXy5tzCegLI1QWgk+JrhbfO25pOik9Kj7Pon7VkiImTdI0u282m2rng
 inMh9ngLy5JIHvnJ2JxsGHhmklwf77p61dWIi92z/0dsEuvl08rAqq0pEupyyr8iJSpFuiRzJ
 LH/o8WzVZosNUqZj8K74evONltU2oEpLeEmDITpWgo922ewQIXE4vEk+8ZiZ+wCsI8IjsDSZk
 zvm+kKDD2nqOlCZj+14Y0GShhKfg+L7XHAKAxo7CtTDpR1Z11lGjpuI/D39WgL31+1S+uf1wG
 nk96FgMeQjlKsAdHovyEEy4Deydcjs7V0p2kVHrCmXO7sKimA+71qbIyn188RbjiEgKbl3oau
 43wZbn8zX/mbdMzh+pYWYuwDenc9zeuU9y9IkcKcZcHuc5zYhiWuDOePsWZHjphgwpfBRT8tI
 sgY0j8nIqE9NeBlkEVGeSNqO+HCf8Xz5PmcOEJ9inH+1Ls=

Hello Paolo,

On Tue, 4 Feb 2025 11:40:21 +0100, Paolo Abeni <pabeni@redhat.com> wrote:

> Hi,
>
> On 2/3/25 6:01 PM, Peter Seiderer wrote:
> > @@ -806,6 +812,9 @@ static long num_arg(const char __user *user_buffer=
, unsigned long maxlen,
> >  		if ((c >=3D '0') && (c <=3D '9')) {
> >  			*num *=3D 10;
> >  			*num +=3D c - '0';
> > +		} else if (i =3D=3D 0) {
> > +			// no valid character parsed, error out
>
> Minor nit: please don't use C99 comments, even for single line one.

Fixed...

>
> > +			return -EINVAL;
> >  		} else
> >  			break;
> >  	}
> > @@ -816,6 +825,9 @@ static int strn_len(const char __user * user_buffe=
r, unsigned int maxlen)
> >  {
> >  	int i;
> >
> > +	if (!maxlen)
> > +		return -EINVAL;
>
> It looks like this check is not needed? strn_len() will return 0 and the
> caller will read 0 bytes from the user_buffer.

Checked all call sites, your are right, fixed in next patch iteration...

>
> > @@ -882,39 +897,45 @@ static ssize_t get_imix_entries(const char __use=
r *buffer,
> >  		pkt_dev->imix_entries[pkt_dev->n_imix_entries].weight =3D weight;
> >
> >  		i +=3D len;
> > +		pkt_dev->n_imix_entries++;
> > +
> > +		if (i >=3D maxlen)
> > +			break;
> >  		if (get_user(c, &buffer[i]))
> >  			return -EFAULT;
> > -
> >  		i++;
> > -		pkt_dev->n_imix_entries++;
> >  	} while (c =3D=3D ' ');
> >
> >  	return i;
> >  }
> >
> > -static ssize_t get_labels(const char __user *buffer, struct pktgen_de=
v *pkt_dev)
> > +static ssize_t get_labels(const char __user *buffer, int maxlen, stru=
ct pktgen_dev *pkt_dev)
> >  {
> >  	unsigned int n =3D 0;
> >  	char c;
> > -	ssize_t i =3D 0;
> > -	int len;
> > +	int i =3D 0, max, len;
>
> Minor nit: since you are touching the variables declaration, please fix
> them to respect the reverse christmas tree order.

Fixed...

>
> This patch is quite large and mixes several things. I'll split out at
> least the strn_len() caller fixes (possibly even the num_arg() and
> hex32_arg() ones) and the refactoring in pktgen_if_write().

Done in the next patch iteration....

Thanks for review!

Regards,
Peter

>
> /P
>


