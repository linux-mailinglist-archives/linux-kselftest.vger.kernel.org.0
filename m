Return-Path: <linux-kselftest+bounces-48564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 083DAD06793
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 23:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC8D13020C7F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 22:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79D7331A4C;
	Thu,  8 Jan 2026 22:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EazdywGP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7283382CB
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912616; cv=pass; b=rVrYXLh3D5hjVgrKbfWVTrd4K8YzZzBms3Neu8n3DGmefih5Dk+DhxVCiHYwktsx7qjyQaFymeCIM13PceVgpcAaqalRUd1uScXUgxMq6E9J760sC/HeM1R7Zb7kaKT/zGJzmo6+pzEYpVpfLYrZqzLMjKCCBHz0EIpx71XxtjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912616; c=relaxed/simple;
	bh=0Kg9b2/WsUIMEqmGuRHA5a4yLHhV5XKlV8sTuaMp9aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4gfD/nriEPx1/CDuePvHMmgzilVX7dgXZBer6RyHpEIldDzx0oczRrbz6S924ccqTEBdIwt2dCLpIE3Qzjh4LsFQRWP1yqQwOYKkP4KDihfutWBnztYwqsTwV9xrFL+iXmi7bfDGGRx+DO+x6dUpQHGDscPgB9ONlX4sOeYxpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EazdywGP; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4edb8d6e98aso182071cf.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 14:50:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767912613; cv=none;
        d=google.com; s=arc-20240605;
        b=Vxs25s0s3NqFXr0zGRe55sQvVJKGn0XQUO614baowCE63aMtwzVAeQnczvTWY1BZkV
         GA6dDJfDlYIrYcDA8+JeemOVcTD+3O6W93A1k3MA1lUg9AcQhU0H6LlN7GBIa+NRYoo9
         ZQBTd0p4t3cK8eUN9h6A39JaRYauyDfHGUzZZYTszcAREvJ5Q5Ew00x4SpOcEUILA/gq
         6A1G4OMkuWmEVpjrQ+3EwyKN3yZVhKDEhWPNMrmKYbZRMcoTPiXDmGQ2+c85L13AlwNI
         z0gaZ/pr80gy7htltRJiSTCotOqtwd7/+fz7+d+WEu1A9+Hc0NXjjOjVlhuptpyIB8y2
         rLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wseu+RuUn8NgZwFWIiGhlQzFjB8QZcJo0bXjL+h71eo=;
        fh=1E0jbn+ZFIJmOXpafAYbz0i7ctLLgxybXAQ+w9KnOfo=;
        b=E8xmdNCqThRqL2PZE7YBDYmjhl6AkW/QYePdc5nkpQs2tdhDZZyx3YDe3IFJCKD4zQ
         7l77Wo/gYXgfVRj7ZRF+vUUpM9RNP6d+uul1IjRahKbLhYQJ0Z4PaP3u1qlwhMZ0nsY5
         oCvQT0qBzrINfwkheK3TO7SsNtJG9FdL/O3YSmTJ+KdekS0LvvZ0+p4Oq4ey3Qd9GJEz
         E1iYp1hlPDFX8LNT3MNH7UcyCEkICfJ8Tz6UEkZIrSzsawkIBWppYZPBpxefsv/6EGQx
         shTqjK+Ezyuln/xKm1LnvaqcOI1u+2bv9xuftjIfwyEqT3ECH4WRSs1qvA4Wm3tyBAGr
         Nisw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767912613; x=1768517413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wseu+RuUn8NgZwFWIiGhlQzFjB8QZcJo0bXjL+h71eo=;
        b=EazdywGPZDCXH3Fx5TCKx8lRPKR1YFKi2rVdJxp5TFEc9FPXgCHy4+KFLFNwGHIJJs
         MgHNdzGU30XBZ1gHL6jcB8RAcVWXfiGdoYbJDPT/CqaP2NI/yiTrIV1SNx0tyaZO4YXV
         zvkYL3UjcM9Z9Qf10f2eJdWOWTVNoySi2LyTw7UCfjNZxlGwaKLj4LgUzShVswoDMInM
         iDMUOmfSYe5ThtQoc6lXI5oOjrmKRbLm67kAwNWAZMg1esDPV1Al+Q0DnAb5EOEt7B1Z
         n2z9uIEFnyRVShloZtvQXCgoTvhZt3foz20FPgvtnC4XkJyMcEA6USyg1aQv2WE8QqnS
         bLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912613; x=1768517413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wseu+RuUn8NgZwFWIiGhlQzFjB8QZcJo0bXjL+h71eo=;
        b=B6fVWuX/xaxYc3kK59/mD1e0YA8MLq1JsVlFf5bNeWoTSLUmM1599ikqHJRlWjaF4A
         90UpDpShqXNwhA9sPizjuhipDthPLqcfhUNF0RpwXU5YwCFIToymfRuR+/E4pBy88ht3
         Dn/9b41tIVEdfiZW32ebXfnPxDzVxraBJAEmfNL+ZiZ/7Q3FvT4HsaME6KU+48XL5eYY
         zJxnBORqxQxDDFYuQP1UNjUwe16OdJ6H/LrSoQR5n0d9RVhnFMAfsPuh8+c3FJFIBd5U
         WNVCWZ3BJG5o9yTXP2BDlSOQgyXfLRg2+db2IhWP6x31TkJRx6Seh4JFbLigV02HoWSg
         j0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUuRsoE0mCNoJnPU2WpKvmawXcOfUTqS5i6KVyLf0Q8OgYn24vrQzl3cloGnV9oynpGrwtPG4hE1YKBFjgWmZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxY6B12i/lj+6tQ4KvRLalOgFEkClN2Z8IU8xVE4lr6xnURksz
	hk5aUuIvXKkPCBJffG15PDTLTUEdTxK7GpqHv8mBg9lX+LktSEAtBICLYZjOMEKhSAtvTbWRwqc
	zjFln7vGKrV7yNhrdQosz6wXXT/uWacTodCjpCc/X
X-Gm-Gg: AY/fxX73xbScUax8R+npgGaftwjQvLr9nr4zUxxlyEeBEUgAXYIg/qyS5/YbiNA7gnX
	OYxqmMraAiBjNYTfAWPqzKF51OuwXLztf13BJKdCNccwWBGrYOgcLgtP2BnLKdBiv5OuHVnTZqm
	8s2yXAwCb/fp8ZkDTwDepQuaPB9xSJQ94SRyh3ekveEJkcOnCtWhNvRYsdLIMCkRW+VREdbNSlq
	RqPIwv8mmrgtzjC5r5veyqu/u5Ku44bFORE/AsgyUR5LiZXJKhqEg3ARCr1dbvvyqH9heMOQ75O
	FNUxi5Q7RiKeY+88MHCN/2WnPv5s+MBRLgC7DbTzupXJ4lq9zJMIhYARdq0=
X-Received: by 2002:ac8:725a:0:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-4ffcbd0a84emr528911cf.3.1767912612694; Thu, 08 Jan 2026
 14:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com> <CADVnQykyiM=qDoa_7zFhrZ4Q_D8FPN0_FhUn+k16cLHM9WBOCw@mail.gmail.com>
In-Reply-To: <CADVnQykyiM=qDoa_7zFhrZ4Q_D8FPN0_FhUn+k16cLHM9WBOCw@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 8 Jan 2026 17:49:55 -0500
X-Gm-Features: AQt7F2o6WroRcnLZsfsh5rQuai7Ltrdaj81MBXbeb_Nn4Vs-CAUHJkiKVn3RRPk
Message-ID: <CADVnQymHK0y_ALJ6obg60j+oUgjgpA8daaazin9hzO+-O6oRdA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill cases
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, edumazet@google.com, parav@nvidia.com, 
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:47=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Thu, Jan 8, 2026 at 5:46=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
> >
> > On Thu, Jan 8, 2026 at 10:58=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.=
com> wrote:
> > >
> > > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > >
> > > Linux Accurate ECN test sets using ACE counters and AccECN options to
> > > cover several scenarios: Connection teardown, different ACK condition=
s,
> > > counter wrapping, SACK space grabbing, fallback schemes, negotiation
> > > retransmission/reorder/loss, AccECN option drop/loss, different
> > > handshake reflectors, data with marking, and different sysctl values.
> > >
> > > Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Co-developed-by: Neal Cardwell <ncardwell@google.com>
> > > Signed-off-by: Neal Cardwell <ncardwell@google.com>
> > > ---

[apologies for the premature send due to accidental shift-of-focus...]

A third note:

(3) the patch title seems to have a typo; it is currently:
  selftests/net: Add packetdrill packetdrill cases

I would suggest something like:
  selftests/net: packetdrill: add TCP Accurate ECN cases

Thanks!
neal

