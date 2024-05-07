Return-Path: <linux-kselftest+bounces-9583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5AD8BDD7E
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 10:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249601C21C2F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F04614D44D;
	Tue,  7 May 2024 08:52:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD6313C9A6
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715071936; cv=none; b=fGITqPxXFxg5Er6zfCbZg4fvK1kpFTf8fAORacJFUXP0Win5oqI7yppYAYzdbi3qzVEINsQoPFrerx3qIgp83MJXzw0JWrhKzaG4iftdg48hsdNJY/dOqei9ke8Dj1csLjMoZxxNTS/OgUP/ZOYLSyKcIBsICFnc1H/uxr7rX7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715071936; c=relaxed/simple;
	bh=PcC6gv/Xh6AX9bpLAJzrtC5YtnizlAobd29EGBRTI8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=k35dlcErTi3mlEdknmTWvDVEEkH6abukLKfeSIy09W2y4mNWWcNoYcsarP5SYFlJvl5uqOGbOxsSxX3d16igND/ppBo/5gdUgufgFoRmqlNHv/SfXKAJzgEJPu7zyQC3Uqnk06b3qhdyKSwECLBkoaao7x/kyzzUnieMJjjA3TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-EKjwsSalOS-woX3gmevNcQ-1; Tue,
 07 May 2024 04:52:09 -0400
X-MC-Unique: EKjwsSalOS-woX3gmevNcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA6DD3800BA4;
	Tue,  7 May 2024 08:52:08 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 151DC40C6CB6;
	Tue,  7 May 2024 08:52:06 +0000 (UTC)
Date: Tue, 7 May 2024 10:52:05 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony@phenome.org>
Cc: Antony Antony <antony.antony@secunet.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <shuah@kernel.org>, devel@linux-ipsec.org
Subject: Re: [PATCH net-next v3 0/2] fix icmp error source address over xfrm
 tunnel
Message-ID: <ZjnrtWZeVgsHyNhm@hog>
References: <cover.1714982035.git.antony.antony@secunet.com>
 <ZjjczzsSz6wwUHd5@hog>
 <Zjj94y2JW4uPg_Iz@Antony2201.local>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zjj94y2JW4uPg_Iz@Antony2201.local>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 17:57:23 +0200, Antony Antony wrote:
> Hi Sabrina,
>=20
> On Mon, May 06, 2024 at 03:36:15PM +0200, Sabrina Dubroca via Devel wrote=
:
> > 2024-05-06, 09:58:26 +0200, Antony Antony wrote:
> > > Hi,
> > > This fix, originally intended for XFRM/IPsec, has been recommended by
> > > Steffen Klassert to submit to the net tree.
> > >=20
> > > The patch addresses a minor issue related to the IPv4 source address =
of
> > > ICMP error messages, which originated from an old 2011 commit:
> > >=20
> > > 415b3334a21a ("icmp: Fix regression in nexthop resolution during repl=
ies.")
> > >=20
> > > The omission of a "Fixes" tag  in the following commit is deliberate
> > > to prevent potential test failures and subsequent regression issues
> > > that may arise from backporting this patch all stable kerenels.
> >=20
> > What kind of regression do you expect? If there's a risk of
>=20
> For example, an old testing scripts with hardcoded source IP address assu=
me
> that the "Unreachable response" will have the previous behavior. Such=20
> testing script may trigger regression when this patch is backported. =20
> Consequently, there may be discussions on whether this patch has broken t=
he=20
> 10-year-old test scripts, which may be hard to fix.

Ok, that seems like an acceptable level of "regression" to me. Thanks
for explaining.

> > regression, I'm not sure net-next is that much "better" than net or
> > stable. If a user complains about the new behavior breaking their
> > setup, my understanding is that you would likely have to revert the
> > patch anyway, or at least add some way to toggle the behavior.
>=20
> My hope is that if this patch is applied to net-next without a "Fixes" ta=
g,
> users would fix their testing scripts properly.

I don't think the lack of a fixes tag will make people fix broken test
scripts, but maybe I'm too pessimistic.

--=20
Sabrina


