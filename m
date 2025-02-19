Return-Path: <linux-kselftest+bounces-26939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E86B7A3B3D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 09:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEB81684C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6CA1CAA81;
	Wed, 19 Feb 2025 08:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="ZmckBGFJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8551C3C1E;
	Wed, 19 Feb 2025 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739953841; cv=none; b=qrrAVmdaHENgmIJjI8I19cmjNIzedQ2csTsXEnDLDWT3oafRYeE3HMQL9bQMMrqbdrda5GUrhe6ZNOb1Y3hbJWHUS6rXaU79DVSf04Hwx80WoM3c543UZPtoT4L5odOdkpbUoKuOQh0+tQ8UJjm3dOGU4DAjeUF1vsgm91OHUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739953841; c=relaxed/simple;
	bh=ycMmntT6RYiK5scQQyQ1vBE7RgIc+pBQA6KccXjAD54=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9DKQs9cyManOmNfCBcMuMUhLMHP0oByiZtnPcFQLixsu2bUjSdDR3mxR2NYkV5QGXH+mLsgfSZiU30qoOj6KoAxQNeO8KtiCdKJLq6g6wUr0a7JuE2ByP7jolo3/3vnxIBPoZRbeEAF4izj7Tw4gVvqisAZoZVe1zDKlu9dJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=ZmckBGFJ; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739953820; x=1740558620; i=ps.report@gmx.net;
	bh=x5EWN2R4z/1IwzTQftryyia0iXMKaHI0maPKka1LwOI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZmckBGFJ6zPUEs34K+sQ40Fq9X3B+xzw28RAzMv28Nw1Kx0A03TJYLFsyJZsIE/9
	 pPk3onq40RglhOvGBHAu7IfGgIGKMW3txQ+Cujatm4KGRQNP5o6VqRsznU0oLGDIE
	 xMobx+o9kJISN40PYSTTdJcnlAYN60znc3JF8eFPnrzDtl6spFM9u05EGCAOWCAgF
	 pIZpUFv7m9P+qNEwM9ymPf401Dsc/BZ8yIZl3UggCWhE0QTUllLQpDOeT13o4AiJi
	 rN1PjoUiYcDdxJXnGNygb4SA14tKUBMyR4rDglyCG7CAx96ec2ITGSXNhZz9tMgKR
	 9a5ivBExdabZxWZWIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.84]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryT9-1swlvl2X13-00mKHH; Wed, 19
 Feb 2025 09:30:20 +0100
Date: Wed, 19 Feb 2025 09:30:18 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Artem Chernyshev
 <artem.chernyshev@red-soft.ru>, Nam Cao <namcao@linutronix.de>, Frederic
 Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net-next v5 8/8] net: pktgen: use defines for the
 various dec/hex number parsing digits lengths
Message-ID: <20250219093018.7907296f@gmx.net>
In-Reply-To: <20250218132905.GV1615191@kernel.org>
References: <20250213110025.1436160-1-ps.report@gmx.net>
	<20250213110025.1436160-9-ps.report@gmx.net>
	<20250214201145.2f824428@kernel.org>
	<20250216091739.GW1615191@kernel.org>
	<20250217094740.76a25671@kernel.org>
	<20250218132905.GV1615191@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Cgs668cn6wrF97BfN2bVd3FAJhAjX1x1hv67Apab+yN/2Xlj4EO
 mef5eh5Kd7VsBqkNXd5cbAlZCKWlXcrVXFG3rHLbPfEteI23i1HrENP3ISEPUfPCg2ODGL9
 eXkpjgjK9cyWHV39XY0BPw/85sqAG7OkDjrWCK9g0vGt2n1IhKc8OV6WQqbN4Zbwc1/ragU
 jqnKyM18leFYLSbBW23+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:51Tm+bc4Q+4=;lhQlaUuDjbQzR1uRxmJN9iL/w4I
 8Jm5L01C1lD9qstmj8SDuZXKAw0RDkNU7LGexQnH4ut4PBPSAeDSpfBeWzFk2P0uq+IHMhyoo
 Ke23Xg/1s+8K02QH4ZCbC8HTWu3hljHHsjd60JOoUvnVcpUoLw3LPqoyhGv1ihaCzunPRH0E4
 tbqkvtr0TehDyRglhU7xYzxgHPzUL0CUNdhjJvQ3CeGvr20EszHEfWDHuGOqLt7noTVqMffax
 icKa6SgWbfEE2HXLkaszw5ih0mK6WLdhLsdDBbDnKV72Cp4HEckJfymSdnMt6L2F980We0NXl
 didZcCPZ9HXQYaM/lfvueHiCPcolSto1eTWOSveISbuQpoYZg2C8aTPhlGSlvPSk9wkSjQE5w
 BgqD6NgHxd9yQMqUuD1pFtz33QS1v+de2J2J4SeV3g9Od7wC3GO6lJ7Fm+35e8gtFALDMYOoR
 UM5jQX7ifiQvHPnLXtqJIuoodwRBsSt1WkMVyeDxXRtx2YV1vcgo4Dtk4q7Ij2zPkyXG0Jopd
 zFp6msWMegpWmyxtN6H79YS8ivC1z9EgsiQ32P1hIjrHZ/46kT15XNLHDxBfMNuLyTEYZrJSb
 zoZ9IhzPI9yCJ8jkdOoJvwdlOTDL0cI/ZFpghYfSprDV0R+KQFNFVXZpF+fOhUUsuNpuGXC6Y
 kWlVWNbwMAst9yNVrPZKvnadKozOGAV6s1kT0/lFPtNXfuI9Pl0Q2S4bD/1bgR8/xY+Sw9MYD
 z5Xeq2L+MuLiNYAE+eR5rmVmdL5CPzwI0+zdRZ5aMZapahA2jdj/G3GNgIsviPihehMJmqBDH
 ci4AXI4gFaFbI5vvMLMrzJaN+wgcp4AIuvplsURDxCF27h41P6o+0Fvfu8DEFhe349K+ZkkZ+
 8L3nrLVn7MH6ZNZaZEY3jE5PDhPDdA5jrRsAV+3vuQCuW32uBCnUaLS3ne9iXmpEd+ptkMa8x
 JfkS70BAwli4WP/qn5lvVPGWfZG2EshbKEkejYnzmEACuu6NFn+MMNs0rzqNG+MVH3478W5is
 kOnurVMjuCXlrirtZ5Qp0+Do/pYYTtUZ2SnMy7XN/zKMWuGpoQOXWwqHG1DmxEvEg7yYIXbKM
 ykQnSZTvtPfyPWJK9m65Q2iTbc4SYWOkVuqqNOwU06PpnHzD74oWbEqY18Qinh75/3zaFXoLI
 Yw7JaknoRrwdCkmavzH3QTQsl7XvhwbBtjFlKrLqytAjSrVqRr7ibeXYug+OautwS2f8xEx7L
 Ahqhmm1dpSF/wN5c+KBTqiuUYW1yNzcU6lnPHmd+yAhgqS4RVLfnwkfMgTO8Et0BLQVKXSU5D
 MtRealvLBrwthbdvlw3ZDSxxzC5Oj9ZrE74l1DvIWpokXGFkWzmjkRD38H+yYIBMX9nZMHWcz
 u1YTdQ0r+0CgMogx93kAse2djnQCMheovyfb4EXB1LRBAjSS47EcTaEV62

Hello *,

On Tue, 18 Feb 2025 13:29:05 +0000, Simon Horman <horms@kernel.org> wrote:

> On Mon, Feb 17, 2025 at 09:47:40AM -0800, Jakub Kicinski wrote:
> > On Sun, 16 Feb 2025 09:17:39 +0000 Simon Horman wrote:
> > > On Fri, Feb 14, 2025 at 08:11:45PM -0800, Jakub Kicinski wrote:
> > > > On Thu, 13 Feb 2025 12:00:25 +0100 Peter Seiderer wrote:
> > > > > Use defines for the various dec/hex number parsing digits length=
s
> > > > > (hex32_arg/num_arg calls).
> > > >
> > > > I don't understand the value of this patch, TBH.
> > > >
> > > > Example:
> > > >
> > > > +#define HEX_2_DIGITS 2
> > > >
> > > > -		len =3D hex32_arg(&user_buffer[i], 2, &tmp_value);
> > > > +		len =3D hex32_arg(&user_buffer[i], HEX_2_DIGITS, &tmp_value);
> > > >
> > > > The word hex is already there.
> > > > There is still a two.
> > > > I don't think the new define has any explanatory power?
> > > >
> > > > Previous 7 patches look ready indeed.
> > >
> > > This one is on me. I felt the magic number 2 and so on
> > > was unclear. But if you prefer the code as-is that is fine by me too=
.
> >
> > I agree that it's a bit hard to guess what the call does and what
> > the arguments are. To me at least, the constants as named don't help.
> > We can get a third opinion, or if none is provided skip the patch for
> > now?
>
> Yes, I see your point.
> No objections from me to skipping this patch.

O.k., will re-send the patch set without this one and the
rev-by for patch 2 added...

Regards,
Peter



