Return-Path: <linux-kselftest+bounces-4937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6026385AA88
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 19:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFA91F25396
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 18:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EA6481A4;
	Mon, 19 Feb 2024 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dt/inMRm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D3C47F7E
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708365873; cv=none; b=aGHFFAMSO8RuzrddssqhMaPqTfnr7jG/uaKd6bhEreDEJhtMwhq9k1womx1WUAuPgvquf/akolzbboYzkN4ei/dj7ky4jE78Lsh8gj39g6pX16wt+2HHSY62HjN0VIrDIJSTmiTtRfZX/F3ww47ZnyLnMC9ebrGlO2gozKXhuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708365873; c=relaxed/simple;
	bh=UEPLrGsnD4vv+KWzGVUqKC9P3Ismxwk1aSAAgDmpy8Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AE/xirpKx/l9Lz4Mgx2d09SYMhavMi9pWTcnNeH4m+BojOqnUHSgA2kKsR8vpBfta9DlxEz7qsTEUvOR/O7WoUuJTENQgjFa0JxdblYHRVVcQ7g2/CWfCdnih1YlplzLXq2n57afnMqRLzgJbEFFNpn89yi6M5XSitHTQkSLWCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dt/inMRm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708365871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a+iNeAxtauOM0aYmunbW9EYuTi28TQyi/g0k6ndzmN8=;
	b=dt/inMRm1eJNkYA1hh22+XNmNzqUC00hpU5EOWSa2B4r/42vo38HDysffIICEMtQcbCH4y
	xc+FZBZgcN4I/rFMMbJKEL4XZzGrR5FPToXZLbkVZdfbRpxlOifnKamIIQCE+zer7DOJrT
	OYKUsFjdjqcW2Cz1t4ah5WJ3oF0OupQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-xM5SPVugMgWftwmVRGTFjQ-1; Mon, 19 Feb 2024 13:04:29 -0500
X-MC-Unique: xM5SPVugMgWftwmVRGTFjQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4125f4468a2so3513205e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 10:04:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708365868; x=1708970668;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+iNeAxtauOM0aYmunbW9EYuTi28TQyi/g0k6ndzmN8=;
        b=r8oP5DC+/owi9U7+/T6Sdp3/sjCx6hJfnYgDOB/wW5dhNZVNEgSu/zQxCac6Lr6Csw
         rvT+Us0+BzIfy1HXqjsNoH2YlB0NdNKKzNV6Ya1yKeVh27I4+joVRrd1GFPnOUYq/rTC
         GoUg0mJpO7um2iCZUUsbj53Mzz0yoXKbcOGXi598JMb6rxI+A+aecXY9JELQSghmakdA
         Fj273aK/fcSqV9Cu5WlQuEWIFX8NBSY7nhzmYlNv1Yw5ESYWUAyezMPWeWznPtASsGVt
         3ouqOreNT3VZ1DL2jC2S7thQEc5prh9t+gIc/1zKhTP4330PcpEHrLeHC3gwzTeRF2K+
         PKQg==
X-Forwarded-Encrypted: i=1; AJvYcCUNvC65K+mQa5gkSMXl+2mYpzL5wcyLH3zrAluwlM//v7BqkCiKPtg3oqJroPLR579HXZQ0VJ1tA9srRLx7UsEzSRdwGhShZxYZN+UzMHP9
X-Gm-Message-State: AOJu0YyEZf9r1cMrv3n4plLPYu27lfdiA0jgFBxumDQILjgsDti9ucwV
	/xShY5vzGQPaEweoUcGSptMciRcnjh7x4c1lamltOFRFFZ4yrBfFiIeL76DkueX5IhYLILLgJfV
	aLBzBwZJ9t+/nj78v+KUbVg6Zk+MsF7gyvOZw9hdXi72p2SXBCrh/3BBYCNpfrWc3RA==
X-Received: by 2002:a05:600c:3b94:b0:412:5f44:65b0 with SMTP id n20-20020a05600c3b9400b004125f4465b0mr4086953wms.4.1708365868594;
        Mon, 19 Feb 2024 10:04:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhBynsVEr8EGdASzTTZmllJJJe1pH2ebWEf7qyHZrRX+07yHK4aauCU45lP+tKzputr5MnNA==
X-Received: by 2002:a05:600c:3b94:b0:412:5f44:65b0 with SMTP id n20-20020a05600c3b9400b004125f4465b0mr4086936wms.4.1708365868176;
        Mon, 19 Feb 2024 10:04:28 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-227-135.dyn.eolo.it. [146.241.227.135])
        by smtp.gmail.com with ESMTPSA id ch17-20020a5d5d11000000b0033d2ae84fafsm8346747wrb.52.2024.02.19.10.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 10:04:27 -0800 (PST)
Message-ID: <278c26d6f4042dc6dadb9742afe11b7fa610f0b2.camel@redhat.com>
Subject: Re: [PATCH net 03/13] mptcp: fix lockless access in subflow ULP diag
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "Matthieu Baerts (NGI0)"
	 <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, Geliang
 Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Davide Caratti <dcaratti@redhat.com>, Shuah
 Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>
Date: Mon, 19 Feb 2024 19:04:15 +0100
In-Reply-To: <CANn89iJDypRXX-8S-UdqWgw73eOgt0+D74qUCLDkb0cRpFFXkg@mail.gmail.com>
References: 
	<20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
	 <20240215-upstream-net-20240215-misc-fixes-v1-3-8c01a55d8f6a@kernel.org>
	 <CANn89iJ=Oecw6OZDwmSYc9HJKQ_G32uN11L+oUcMu+TOD5Xiaw@mail.gmail.com>
	 <CANn89iJDypRXX-8S-UdqWgw73eOgt0+D74qUCLDkb0cRpFFXkg@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-19 at 18:35 +0100, Eric Dumazet wrote:
> On Mon, Feb 19, 2024 at 6:21=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >=20
> > On Thu, Feb 15, 2024 at 7:25=E2=80=AFPM Matthieu Baerts (NGI0)
> > <matttbe@kernel.org> wrote:
> > >=20
> > > From: Paolo Abeni <pabeni@redhat.com>
> > >=20
> > > Since the introduction of the subflow ULP diag interface, the
> > > dump callback accessed all the subflow data with lockless.
> > >=20
> > > We need either to annotate all the read and write operation according=
ly,
> > > or acquire the subflow socket lock. Let's do latter, even if slower, =
to
> > > avoid a diffstat havoc.
> > >=20
> > > Fixes: 5147dfb50832 ("mptcp: allow dumping subflow context to userspa=
ce")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > ---
> > > Notes:
> > >   - This patch modifies the existing ULP API. No better solutions hav=
e
> > >     been found for -net, and there is some similar prior art, see
> > >     commit 0df48c26d841 ("tcp: add tcpi_bytes_acked to tcp_info").
> > >=20
> > >     Please also note that TLS ULP Diag has likely the same issue.
> > > To: Boris Pismenny <borisp@nvidia.com>
> > > To: John Fastabend <john.fastabend@gmail.com>
> > > ---
> > >  include/net/tcp.h  | 2 +-
> > >  net/mptcp/diag.c   | 6 +++++-
> > >  net/tls/tls_main.c | 2 +-
> > >  3 files changed, 7 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > index dd78a1181031..f6eba9652d01 100644
> > > --- a/include/net/tcp.h
> > > +++ b/include/net/tcp.h
> > > @@ -2506,7 +2506,7 @@ struct tcp_ulp_ops {
> > >         /* cleanup ulp */
> > >         void (*release)(struct sock *sk);
> > >         /* diagnostic */
> > > -       int (*get_info)(const struct sock *sk, struct sk_buff *skb);
> > > +       int (*get_info)(struct sock *sk, struct sk_buff *skb);
> > >         size_t (*get_info_size)(const struct sock *sk);
> > >         /* clone ulp */
> > >         void (*clone)(const struct request_sock *req, struct sock *ne=
wsk,
> > > diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> > > index a536586742f2..e57c5f47f035 100644
> > > --- a/net/mptcp/diag.c
> > > +++ b/net/mptcp/diag.c
> > > @@ -13,17 +13,19 @@
> > >  #include <uapi/linux/mptcp.h>
> > >  #include "protocol.h"
> > >=20
> > > -static int subflow_get_info(const struct sock *sk, struct sk_buff *s=
kb)
> > > +static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
> > >  {
> > >         struct mptcp_subflow_context *sf;
> > >         struct nlattr *start;
> > >         u32 flags =3D 0;
> > > +       bool slow;
> > >         int err;
> > >=20
> > >         start =3D nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
> > >         if (!start)
> > >                 return -EMSGSIZE;
> > >=20
> > > +       slow =3D lock_sock_fast(sk);
> > >         rcu_read_lock();
> >=20
> > I am afraid lockdep is not happy with this change.
> >=20
> > Paolo, we probably need the READ_ONCE() annotations after all.
>=20
> Or perhaps something like the following would be enough.
>=20
> diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> index 6ff6f14674aa2941bc04c680bacd9f79fc65060d..7017dd60659dc7133318c1c82=
e3f429bea3a5d57
> 100644
> --- a/net/mptcp/diag.c
> +++ b/net/mptcp/diag.c
> @@ -21,6 +21,9 @@ static int subflow_get_info(struct sock *sk, struct
> sk_buff *skb)
>         bool slow;
>         int err;
>=20
> +       if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN)
> +               return 0;
> +
>         start =3D nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
>         if (!start)
>                 return -EMSGSIZE;

Thanks for the head-up. This later option looks preferable, to avoid
quit a bit of noise with _ONCE annotation. Is there a syzkaller splat I
could look at? if it landed on the ML, I missed it.

Thanks!

Paolo


