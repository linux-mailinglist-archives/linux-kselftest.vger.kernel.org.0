Return-Path: <linux-kselftest+bounces-18232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B6197EE77
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 17:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AF01F22639
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C9F199229;
	Mon, 23 Sep 2024 15:48:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8224197A9B
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106487; cv=none; b=SHU4tGkSy6L8geBA3H69UKxq/mfw0vwnQpX9D3B4JoJKZ1i87r95i8JI2hrpesAk1Vwfjwdz2ggBr61efvTFO3GS58sjtdykp4JtPS7WymPOZ7qwbus6YOsVvJmHKc0+jb4MSeQdXpP9pNF981O2EBSLF+9nj2mV3A/zfwZyJ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106487; c=relaxed/simple;
	bh=hkoieWxJ0471/Q4wgFmy+wiZ2lpn7t8bPYZ/cXRThjo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=QLnwSXU5FilJSVVRL8wKKZXg9xF6CoouzRz5htCX8Pok/u38H0A1+MHwKsXnljLEu08Dxmq0KauMgKfwO9bCzHldJMSQrcpCCprjmv+epKCdUYqhcOLxkj+vAsnwUPEFzn26dBeWH8PAqDFFpDH0Psa7rP7md55q9aIWCZ8ib98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-21-fwPuqpVfPIO66RunyFwVag-1; Mon, 23 Sep 2024 16:46:23 +0100
X-MC-Unique: fwPuqpVfPIO66RunyFwVag-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 23 Sep
 2024 16:45:27 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 23 Sep 2024 16:45:27 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jakub Sitnicki' <jakub@cloudflare.com>, Martin KaFai Lau
	<martin.lau@linux.dev>, 'Tiago Lam' <tiagolam@cloudflare.com>, Eric Dumazet
	<edumazet@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Andrii Nakryiko" <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
	<shuah@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: RE: [RFC PATCH v2 2/3] ipv6: Support setting src port in sendmsg().
Thread-Topic: [RFC PATCH v2 2/3] ipv6: Support setting src port in sendmsg().
Thread-Index: AQHbDci8OgyMoKtrJE6wBcqRmpwTjbJlgCZQ
Date: Mon, 23 Sep 2024 15:45:27 +0000
Message-ID: <29fea23839cf489488f9228a44e79d21@AcuMS.aculab.com>
References: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
	<20240920-reverse-sk-lookup-v2-2-916a48c47d56@cloudflare.com>
	<855fc71343a149479c7da96438bf9e32@AcuMS.aculab.com>
 <87r09a771t.fsf@cloudflare.com>
In-Reply-To: <87r09a771t.fsf@cloudflare.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Jakub Sitnicki
> Sent: 23 September 2024 15:56
>=20
> On Mon, Sep 23, 2024 at 01:08 PM GMT, David Laight wrote:
> > From: Tiago Lam <tiagolam@cloudflare.com>
>=20
> [...]
>=20
> >> To limit its usage, a reverse socket lookup is performed to check if t=
he
> >> configured egress source address and/or port have any ingress sk_looku=
p
> >> match. If it does, traffic is allowed to proceed, otherwise it falls
> >> back to the regular egress path.
> >
> > Is that really useful/necessary?
>=20
> We've been asking ourselves the same question during Plumbers with
> Martin.
>=20
> Unprivileges processes can already source UDP traffic from (almost) any
> IP & port by binding a socket to the desired source port and passing
> IP_PKTINFO. So perhaps having a reverse socket lookup is an overkill.

Traditionally you'd need to bind to the source port on any local IP
(or the wildcard IP) that didn't have another socket bound to that port.
Modern Linux might have more restrictions and SO_REUSADDR muddies things.

And I don't think you can do a connect() on an unbound UDP socket to
set the source port at the same time as the destination IP+port.
(That would actually be useful.)

OTOH if you just want to send a UDP message you can just use another
system on the same network.
You might need to spoof the source mac - but that isn't hard (although
it might confuse any ethernet switches).

> We should probably respect net.ipv4.ip_local_reserved_ports and
> net.ipv4.ip_unprivileged_port_start system settings, though, or check
> for relevant caps.

True.

> Open question if it is acceptable to disregard exclusive UDP port
> ownership by sockets binding to a wildcard address without SO_REUSEADDR?

We've often suffered from the opposite - a program binds to the wildcard
IP and everything works until something else binds to the same port and
a specific local IP.
I'm sure this is grief some on both TCP and UDP - especially since you
often need to set SO_REUSADDR to stop other things breaking.

=09David
=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


