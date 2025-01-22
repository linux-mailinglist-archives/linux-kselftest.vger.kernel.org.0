Return-Path: <linux-kselftest+bounces-24936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5E9A19423
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 15:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D40C31637D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53006214213;
	Wed, 22 Jan 2025 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="mRrSeJap"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B09F145A18;
	Wed, 22 Jan 2025 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737556862; cv=none; b=sTEvHbduICjRrSDVT5rSr20qIzoPivqWDXm+mCR7F50dzgSoLD4PBykU9CynWcdP0/WJFXM1Uci05jLKdbLrLKT2gDeXnWO1ADQfaJ0xkuxPlNkJZuSgUKHMr5JpQYDhNrycBGjzH4sZA8BfFC3CdvHpxyCOTSVHlKM6Q2iQ63A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737556862; c=relaxed/simple;
	bh=Nokc1dhJGSOrENw8A4LCZ3r/+mwWCxC2KxBLzd+3uW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1S4ucAVw/QVOxWBaXbTo+K1rWjemyL7UOE7K1ix6iQWZcAt+KdxV5FgZ7oU81iNBIpaXxAtstHLuQ0Zdr+8EVskEOguDua7dVThxswpXB5/JShqAPd6yYJau6l1SQDK63CHLNMbgq0mkfXR71juiHSy34xI47st6j3mqP/BxDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=mRrSeJap; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1737556857; x=1738161657; i=ps.report@gmx.net;
	bh=zHOFrdFr5x4yf59pS4XUzoVzQh5NuMEXUwZrqT6WuzI=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mRrSeJapTEgPRlJKAS5FqEdDTHPHHozUnMyUQdZjRTc+7ES3JhxAdmju5qz3Zbby
	 axudDfGn/PF6znNpuPBR2S5K0wuHCK5cJhTuQin9hrWvXMYieFKwNtf7FQA2IWwqP
	 jPEGmpjvDQ+XZdpRaaR3nYnhPMkecejOTn5QPWo21NS3gmFOfximy8ke/mOJwwHyk
	 RWIs/K050+wgcyIIZ0gEpddeLTuAAfe8GUYsGkLaMhDwsfZs8JQxCo3ExEcpGKA20
	 rVY0s2V0Iu2QGsKdF+jmyRjzwkIG/GyeuT41OTm4sOfPemSSTW9Br68C5afFadVjH
	 sbOoSVT+9+Xut6Fyjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost ([82.135.81.9]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvrB-1t0Cl21NgT-00fyOw; Wed, 22
 Jan 2025 15:40:57 +0100
Date: Wed, 22 Jan 2025 15:40:55 +0100
From: Peter Seiderer <ps.report@gmx.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Frederic
 Weisbecker <frederic@kernel.org>, Artem Chernyshev
 <artem.chernyshev@red-soft.ru>, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH net-next v1 5/5] selftest: net: add proc_net_pktgen
Message-ID: <20250122154055.04eb490c@gmx.net>
In-Reply-To: <20250117131154.0f3d2057@kernel.org>
References: <20250117141613.691452-1-ps.report@gmx.net>
	<20250117141613.691452-6-ps.report@gmx.net>
	<20250117131154.0f3d2057@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:01+cQZpkgVE6SYNivB3HwadtyhOk2tflhZJCAr7088kWJG6uFO1
 X2PLQIsoAaeHGQGDQ1YiSWfkPA7SZexUiM1ZKt9wudiXLdQORjJ1J0hQ/kKEr2bgUaYsXbR
 GWdVrox/3LGiClIa4JKbVsAcztupg71vIkcvRJV4RaZUqkmNeNy25RB3q8TNRYOxy45nGL3
 Qui08cYDDx1WIem2z3UjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v4g1awnqSD4=;T/dOyQN24p0qy3qc4G4UU4l+hv+
 xUyeAyilt1bgxL9Wvtb5ttQ6G6g2VOWUujNB9uJ87lWMNpCGYmoZ7GyIYt/ZDl5o/2FiFhdMt
 oG4/WbES0TJogT4xd92wXg2hxlpbWiBbMN3APpRT48L/Msgaoy2ZqR0JH0cCv4djyQNlE7l8t
 OssjdtmaLfWuQ/wsUgyZuu0oGSd9U4gaP9wzNjsYGcVSkhb54NpS04SArob2jqACh7CQgJcXN
 HhWb6B5tMpzublZ3/I1emT68ZGdbFlpMUeqI+IRRCGdzJACAApbT6BQuXbxSLclXAhd/LgQHl
 NJhOmn37L99DEaZ5KclpjCcOGfeZh60U1C2UKMsICu8+kLcYtitfphe6ojKBicBGOyUJQc7QL
 LphEOOgRYVviHG9jxR079OPKreqO6GvL/G1r41Ois0Zp7MW3ZNqlOe4N+OMIDTo0DnX2+yzqS
 Cuqfma9oiKRd9DVcl0h2IxqxRo3+SaAo9juk2YRqnHWIGBPpqwVsu1FqjXOG1dQJyEUgo13Ic
 8EYqLzUX3pJhPV6R349VvrTKLlstwZQmqW5/UJ5UZwNO088Tz4G6JIDDWyATcnSkDi5plB8rs
 KUngW/0v+53bkwkqzH37+5Q8MU+HvUAZUI0/NtJd9Bg6TfGrDGVuQR9utbcWW/5K6fjlXRNYa
 9ac8PXINnBKVJmuYVV1D/HD9AVTXfROe6cIZcO6bZB9trKON8RjBdGcY4jyADxHUV6TTxUBj8
 tApzzMUdvWGe4vAc6ta9uRS7IKbhiXQhZExqQg5M9B94E+nQL4B7mZpVDE0sdy61sKMpwGVQW
 blucLzojXtjMjzFiEGotr8Jjc8wdact+E2MrBETFs5wgHB3Z2b4l4lXxGUKb6c20uTv8wAsO3
 qX1An/JNWQjriEuEumi22BdgQS073ZMGEhYt7ngEse29AbAiDeGMNsMZZ3tC/n0ZNX0poNoB9
 X2RAo60wtoVvNFp3XmwKqHEyGjmvBxZ8UXur7Qp6DENmu1gGkvqqD7Xqz2jw20P4emG/HePz7
 AhWP7PnivKEcPx9CInwprJdF7YB72uxSHVm9r0B6vzB3H9R19w6XvIrkDrvyJtpQWDZ72V+JT
 r6nEQctHnv25ZJ2ZKiETeS1+4dGzCqxzf2gyHnkf81fn8xsFojtx0vffBuzlSQLSfoF9yfZh7
 PKtogRMX8tWHlT0968TlypnZDUKedv/ywx8wrKMjms5Ekn5kR84hHNm8G9rDA8kSDDgRwWDC2
 0VzYsX+1CfDM

Hello Jakub,

On Fri, 17 Jan 2025 13:11:54 -0800, Jakub Kicinski <kuba@kernel.org> wrote=
:

> On Fri, 17 Jan 2025 15:16:13 +0100 Peter Seiderer wrote:
> > +FIXTURE_SETUP(proc_net_pktgen) {
> > +	ssize_t len;
> > +
> > +	self->ctrl_fd =3D open("/proc/net/pktgen/kpktgend_0", O_RDWR);
> > +	ASSERT_GE(self->ctrl_fd, 0) TH_LOG("CONFIG_NET_PKTGEN not enabled, m=
odule pktgen nod loaded?");
>
> nod -> not?

Fixed...

>
> Please take a look at the instructions here:
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI=
-style
> the test currently fails in our CI, you need to add it to
> tools/testing/selftests/net/config, and perhaps try to call
> modprobe in the test?

Thanks for the hint, fixed (modprobe and CONFIG_NET_PKTGEN enabeled)...

>
> > +	len =3D write(self->ctrl_fd, add_loopback_0, sizeof(add_loopback_0))=
;
> > +	ASSERT_EQ(len, sizeof(add_loopback_0)) TH_LOG("device lo@0 already r=
egistered?");
>
> FWIW we prefer to stick to 80 char line width in networking,
> but it's not a big deal for a test, up to you.
>
> > +			// complete command string without/with trailing '\0'
> > +			 EXPECT_EQ(len, i);

Fixed...

>
> Run this patch thru checkpatch, please. This looks misaligned.

O.k.

>
> > +		}
> > +	}
> > +}
>
> > +#if 0 // needs CONFIG_XFRM
>
> Add it to the config, too, then?
>
> > +TEST_F(proc_net_pktgen, device_command_spi) {
> > +	ssize_t len;
> > +
> > +	len =3D write(self->device_fd, device_command_spi_0, sizeof(device_c=
ommand_spi_0));
> > +	EXPECT_EQ(len, sizeof(device_command_spi_0));
> > +}
> > +#endif

'#if' removed as as CONFIG_XFRM is already enabled via tools/testing/selft=
ests/net/config
CONFIG_XFRM_INTERFACE/CONFIG_XFRM_USER...

Thanks for review!

New patch iteration is on the way...

Regards,
Peter

>
> Thanks for working on a test!


