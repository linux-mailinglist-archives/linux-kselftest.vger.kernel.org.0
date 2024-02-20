Return-Path: <linux-kselftest+bounces-5049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AC685C2BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 18:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D97D1F21B16
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 17:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A55A7764B;
	Tue, 20 Feb 2024 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQ/4wivE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFFD77647
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450408; cv=none; b=mLs4ezxytKhYNYgBuZxo++bJApYVegA493NFBsXvcnyH6ZWux++Qmkv6uHj0Hg8It2PN9gqjJ3PwZJSV+FjgzmlcEUqnjq2uVmuaJZ1zTvipRadm10ZtlO3d+FlnQyROdjmxSeJTbFvrMO9QAUl2XkpcPE5LkSseB17l/nUOjjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450408; c=relaxed/simple;
	bh=ApaYUklv/cRMXANEx9oSoxNWrMLZy0a0uiWwVrNfunA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y/3cbFQVupRKmkEzfss+dLFIILSTDVwcbXCjJhokYPfCuvZkRUYUG4UxV1mBwNAouhnL0qWcf0EQ4WhVcNyDbT8srjN9vH6p3niilCzDyhnuC38pYdD0t/6N4Wcw8dqokWIozRSZSqwiHefIngWKXZ5FTi0g8+ysmcbT546SiOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQ/4wivE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708450405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ApaYUklv/cRMXANEx9oSoxNWrMLZy0a0uiWwVrNfunA=;
	b=iQ/4wivEO9K+eKxgscWo9Q+EWGTvCqTU0vPmbbMJauUYUZq+woeu5qrR3nVqb98Yc8EK9r
	ixTxyy5EqB5e4/ny2fEqpnoL+ncdfdYNaQ9oNDOnQuOp7371KTWSZQc+VEKZs6Kw8u1yvV
	4a3+7CuZt36F6mprKx5tW5p/cGAjwPk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-bZ9DzQ6wPX2DV90H9pciJw-1; Tue, 20 Feb 2024 12:33:24 -0500
X-MC-Unique: bZ9DzQ6wPX2DV90H9pciJw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d4961412bso414907f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Feb 2024 09:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450403; x=1709055203;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApaYUklv/cRMXANEx9oSoxNWrMLZy0a0uiWwVrNfunA=;
        b=nyygRKvARBU0pYkcTcn8gbjxXlYSnlFyQzloHhCAdbjPV7BYKq+BSTz9EtqzuCBF98
         /U1olBeK3uAqbkfLl7aKMo4Jpr3SHzlLutiM7/YHzzomX0KttRwq3iEjKaCq0ETqatlM
         19jpAi5RnonpymTFf2KicPNc6OXzWuUDoFkoAuJAM15qFG7qJonrAGFYG1Y2NSsLAeHV
         4lYEU4AeJoDvw4ufA5G/z1b0HlpGCPn0VlETr9ZvLFiY4+H1KSXKwz7odiJFdXl66XTR
         jHYf/SBuVxpIo6i7P4gms4pTbvgpyJMgyteC/DMiiVhqVeaIRvyrgiCz063YWcsGovZ3
         PDMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6OkcCHgT1PHSXNbcZWYg/nrlVRXU/0jn7LlBiRyq49pyhlROsbkXdqZPgcLOB97l8eJwz24exFOqQ22ppwAa1QLvqvWbsGfpyd+IWiRBI
X-Gm-Message-State: AOJu0YzoUsthsbmylra0shtGfzo5zti7Vah9YhrIcTGVeXbCQuoFGheE
	n7B55eBVZgcp9tU5Fohzs7kesZ3uoVXKaDBQO1I73Imp4IqdszctxpKE3TjX7wkRG39T9dncg6V
	RmwtVFIr1+72V7/VJ2X/npcqIPHOZ+jzQT/Aq1o5XJQOpCut8kaJqEW0HcAsbp6ODdQ==
X-Received: by 2002:a05:600c:198f:b0:412:6d76:1733 with SMTP id t15-20020a05600c198f00b004126d761733mr1972641wmq.3.1708450403040;
        Tue, 20 Feb 2024 09:33:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFq6YjQBx+SQJaXKVH7RtA5LtCzCx8M+hNieW/E8vqJziZ6ksCuwQX7/vLbccTUtQ/ixvDF8g==
X-Received: by 2002:a05:600c:198f:b0:412:6d76:1733 with SMTP id t15-20020a05600c198f00b004126d761733mr1972630wmq.3.1708450402690;
        Tue, 20 Feb 2024 09:33:22 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-79.dyn.eolo.it. [146.241.230.79])
        by smtp.gmail.com with ESMTPSA id z19-20020a7bc7d3000000b00411e1574f7fsm15140883wmk.44.2024.02.20.09.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:33:22 -0800 (PST)
Message-ID: <28a1a98c757e4a15b7eecdeae563a17fa5cb45cf.camel@redhat.com>
Subject: Re: [PATCH net 03/13] mptcp: fix lockless access in subflow ULP diag
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,
 Davide Caratti <dcaratti@redhat.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, Boris Pismenny
 <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>
Date: Tue, 20 Feb 2024 18:33:20 +0100
In-Reply-To: <CANn89iK72hE16sQcGPUFG6Am_V-77PNJOYHgeAA6M+SD5UO13A@mail.gmail.com>
References: 
	<20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
	 <20240215-upstream-net-20240215-misc-fixes-v1-3-8c01a55d8f6a@kernel.org>
	 <CANn89iJ=Oecw6OZDwmSYc9HJKQ_G32uN11L+oUcMu+TOD5Xiaw@mail.gmail.com>
	 <CANn89iJDypRXX-8S-UdqWgw73eOgt0+D74qUCLDkb0cRpFFXkg@mail.gmail.com>
	 <278c26d6f4042dc6dadb9742afe11b7fa610f0b2.camel@redhat.com>
	 <CANn89iK72hE16sQcGPUFG6Am_V-77PNJOYHgeAA6M+SD5UO13A@mail.gmail.com>
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

On Mon, 2024-02-19 at 19:33 +0100, Eric Dumazet wrote:
> On Mon, Feb 19, 2024 at 7:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> > Thanks for the head-up. This later option looks preferable, to avoid
> > quit a bit of noise with _ONCE annotation. Is there a syzkaller splat I
> > could look at? if it landed on the ML, I missed it.
> >=20
>=20
> Not landed yet, here is the splat :
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.8.0-rc4-syzkaller-00212-g40b9385dd8e6 #0 Not tainted
> ------------------------------------------------------
> syz-executor.2/24141 is trying to acquire lock:
> ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
> tcp_diag_put_ulp net/ipv4/tcp_diag.c:100 [inline]
> ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
> tcp_diag_get_aux+0x738/0x830 net/ipv4/tcp_diag.c:137
>=20
> but task is already holding lock:
> ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at: spin_lock
> include/linux/spinlock.h:351 [inline]
> ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at:
> inet_diag_dump_icsk+0x39f/0x1f80 net/ipv4/inet_diag.c:1038

[Sorry for the latency]. Yes it looks like that checking the listener
status will work. I can test and send the formal patch - with the due
credits! - or do you prefer otherwise?

Thanks!

Paolo


