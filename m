Return-Path: <linux-kselftest+bounces-44646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8EFC2BE24
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 13:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 081094F483E
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1309730BF67;
	Mon,  3 Nov 2025 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nyGhwC/k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F15630B524
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174347; cv=none; b=lkkYDsYBKPYrO9TKI+jbRTetZNXT6RM8WSPPydzV61q12KX0IPUCTU7awxKQEdLKljLwEVTcFi0q/yP/s9mH4dZlRzxj1LyGxjYWXuriit4eJSdlYoDMoZUIKgUQmahlAQ1L/PoGNaGWh1WqsH0UN8YzRDY8FJHRHnz90ydHBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174347; c=relaxed/simple;
	bh=zknbNUMqtehApA9rsCKAcUn2eRCCK8ipSC6uMSED0SI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=bKWgf46J3bawyQ18bYQhtwgU1tBoWtD716OllQ9M5z+m3L9JBYYAxWr8sUSR6SJMQkQnZ+6BbCfI1URMYrJIDw7Bysof3JAs6kXZVEcSocondq6pUOW/6R4RsS4d8dSqx57T5YKOwEWceeDOEc2JrtT2i3q0hQhtQpVscyKobD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nyGhwC/k; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762174333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m8V6AyaUjluKuvk/onmZHfKTs0gZnfKFW4ogFQGfP/c=;
	b=nyGhwC/k4oeCg1b62hJqV8LpEsaBbAdryrVmYKVaC+KORBU1Wu+WEdWrt58TjK63ahz8qF
	hpzvBCqvdDaafx68ZxAgCRjg8z4FRfPi1bQvGjawhJVa5Drx7JgbFDfLfLn0IANpF+tJFq
	epg6X+7y+zHfzxPLfrWAWYLapNHJ9yo=
Date: Mon, 03 Nov 2025 12:52:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <154ce327ae50ea1e3ebde8a1b73c83ac0b547f61@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v3 2/3] bpf,sockmap: disallow MPTCP sockets from
 sockmap
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, "Jakub Sitnicki" <jakub@cloudflare.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Eric Dumazet"
 <edumazet@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "Willem
 de Bruijn" <willemb@google.com>, "David S. Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>,
 "Matthieu Baerts" <matttbe@kernel.org>, "Mat Martineau"
 <martineau@kernel.org>, "Geliang Tang" <geliang@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Florian Westphal" <fw@strlen.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <c5021188-593c-431c-bf01-6775f5b2b2ed@redhat.com>
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-3-jiayuan.chen@linux.dev>
 <c5021188-593c-431c-bf01-6775f5b2b2ed@redhat.com>
X-Migadu-Flow: FLOW_OUT

October 28, 2025 at 20:03, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni=
@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 10/23/25 2:54 PM, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> MPTCP creates subflows for data transmission, and these sockets sho=
uld not
> >  be added to sockmap because MPTCP sets specialized data_ready handle=
rs
> >  that would be overridden by sockmap.
> >=20=20
>=20>  Additionally, for the parent socket of MPTCP subflows (plain TCP s=
ocket),
> >  MPTCP sk requires specific protocol handling that conflicts with soc=
kmap's
> >  operation(mptcp_prot).
> >=20=20
>=20>  This patch adds proper checks to reject MPTCP subflows and their p=
arent
> >  sockets from being added to sockmap, while preserving compatibility =
with
> >  reuseport functionality for listening MPTCP sockets.
> >=20
>=20It's unclear to me why that is safe. sockmap is going to change the
> listener msk proto ops.
>=20
>=20The listener could disconnect and create an egress connection, still
> using the wrong ops.

sockmap only replaces read/write handler of a sk and keeps another handle=
r.

But I agree with you; I also don't think sockmap should replace the handl=
ers of
the listen socket. Because for a listen socket, sockmap is merely used as=
 a container,=20
just=20like hash map or array map. But in reality, that's exactly what it=
 does...

> I think sockmap should always be prevented for mptcp socket, or at leas=
t
> a solid explanation of why such exception is safe should be included in
> the commit message.
>=20
>=20Note that the first option allows for solving the issue entirely in t=
he
> mptcp code, setting dummy/noop psock_update_sk_prot for mptcp sockets
> and mptcp subflows.

I will do it.

