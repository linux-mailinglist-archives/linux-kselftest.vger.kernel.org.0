Return-Path: <linux-kselftest+bounces-4982-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BACC85AF9B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 00:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333AD1F228AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8155C36;
	Mon, 19 Feb 2024 23:11:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4883B55E74
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708384276; cv=none; b=WD5I/fVjS6w47iKtxGaKRnQwyg2n4wijO3ZkxDiTIhwUtAS0kNXf+WmYi5Mt/NNQobVUymo7W7ggrRkhyt62eeDq9oaRBOj0Nbu3568U277GbbpRWiXH596ldjsGhIaMAxmKs4rz3DrlOK7lD/bEoVYgOp0bL/e1ikkDg3iJVA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708384276; c=relaxed/simple;
	bh=Zz5GeEQCJVVnh7nQiPJXRws4ybNTID6P1AtkKEXvxzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uLj4PMm4ia5kAHxf9VjKoXN7xkjWx2+YpQFJnt1mq0o938hCqMnXjOOibE/cUJIyw3StcW+IySIehkJrmSNJxQPi6ewpSheUvuzd8dONI+fkwtesVW1fy4V4OLH+d2GUfL4zLSuQqsl2C7zxSI769TPMy14SnH0Cfnz4rP6EMq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-BPaGb2v4NlWvsUkXrhuG6Q-1; Mon,
 19 Feb 2024 18:11:02 -0500
X-MC-Unique: BPaGb2v4NlWvsUkXrhuG6Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A7391C0CCB1;
	Mon, 19 Feb 2024 23:11:01 +0000 (UTC)
Received: from hog (unknown [10.39.192.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 23E228BCC;
	Mon, 19 Feb 2024 23:10:59 +0000 (UTC)
Date: Tue, 20 Feb 2024 00:10:58 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Vakul Garg <vakul.garg@nxp.com>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/5] tls: don't skip over different type records from
 the rx_list
Message-ID: <ZdPgAjFobWzrg_qY@hog>
References: <cover.1708007371.git.sd@queasysnail.net>
 <f00c0c0afa080c60f016df1471158c1caf983c34.1708007371.git.sd@queasysnail.net>
 <20240219120703.219ad3b2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240219120703.219ad3b2@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-02-19, 12:07:03 -0800, Jakub Kicinski wrote:
> On Thu, 15 Feb 2024 17:17:31 +0100 Sabrina Dubroca wrote:
> > @@ -1772,7 +1772,8 @@ static int process_rx_list(struct tls_sw_context_=
rx *ctx,
> >  =09=09=09   u8 *control,
> >  =09=09=09   size_t skip,
> >  =09=09=09   size_t len,
> > -=09=09=09   bool is_peek)
> > +=09=09=09   bool is_peek,
> > +=09=09=09   bool *more)
> >  {
> >  =09struct sk_buff *skb =3D skb_peek(&ctx->rx_list);
> >  =09struct tls_msg *tlm;
>=20
>=20
> > @@ -1844,6 +1845,10 @@ static int process_rx_list(struct tls_sw_context=
_rx *ctx,
> > =20
> >  out:
> >  =09return copied ? : err;
> > +more:
> > +=09if (more)
> > +=09=09*more =3D true;
> > +=09goto out;
>=20
> Patches look correct, one small nit here -
>=20
> I don't have great ideas how to avoid the 7th argument completely but=20

I hesitated between this patch and a variant combining is_peek and
more into a single u8 *flags, but that felt a bit messy (or does that
fall into what you describe as "not [having] great ideas"? :))

@@ -1772,9 +1777,10 @@ static int process_rx_list(struct tls_sw_context_rx =
*ctx,
 =09=09=09   u8 *control,
 =09=09=09   size_t skip,
 =09=09=09   size_t len,
-=09=09=09   bool is_peek)
+=09=09=09   u8 *flags)
 {
 =09struct sk_buff *skb =3D skb_peek(&ctx->rx_list);
+=09bool is_peek =3D *flags & RXLIST_PEEK;
 =09struct tls_msg *tlm;
 =09ssize_t copied =3D 0;
 =09int err;
[...]
@@ -1844,6 +1850,9 @@ static int process_rx_list(struct tls_sw_context_rx *=
ctx,
=20
 out:
 =09return copied ? : err;
+more:
+=09*flags |=3D RXLIST_MORE;
+=09goto out;
 }


and then in tls_sw_recvmsg:
u8 rxlist_flags =3D is_peek ? RXLIST_PEEK : 0;
err =3D process_rx_list(ctx, msg, &control, 0, len, &rxlist_flags);


> I think it'd be a little cleaner if we either:
>  - passed in err as an output argument (some datagram code does that
>    IIRC), then function can always return copied directly, or=20

(yes, __skb_wait_for_more_packets, __skb_try_recv_datagram, and their
variants)

>  - passed copied as an output argument, and then we can always return
>    err?

Aren't those 2 options adding an 8th argument?

I tend to find ">=3D 0 on success, otherwise errno" more readable,
probably because that's a very common pattern (either for recvmsg
style of cases, or all the ERR_PTR type situations).

> I like the former a little better because we won't have to special case
> NULL for the "after async decryption" call sites.

We could also pass &rx_more every time and not check for NULL.

What do you want to clean up more specifically? The number of
arguments, the backwards goto, the NULL check before setting *more,
something else/all of the above?

--=20
Sabrina


