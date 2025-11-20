Return-Path: <linux-kselftest+bounces-46051-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE30C71E4A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 03:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16A4E34C6D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 02:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95672F3C19;
	Thu, 20 Nov 2025 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r6p8/rba"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E02F39B0
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 02:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763606997; cv=none; b=RlnCDjFeumQgrmHEfdtZqlZ4uj3KJm1W/pHsDN2GVzSbq1Lvz9ljg0V4B1Xd4sFrxNpZURL9BrFRe3Wh0WVtpnN6ERFDHO0dz74eyjvb1sInjxMqf9m+2lXa3e2RnySlnvhyzL7sz3YjglIzjOieu6TLtdC0vgGUFh1dCzxT/EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763606997; c=relaxed/simple;
	bh=lcrVwZLgR5ItAg4hTqw5DCPtnAFmviQlQW6jyyCm6AQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Pr2Vp2wIWKJVRJhBKT0U+OJQNxqKG+y2Nq32HaCUPsV7bkRd6x04ngTq1a3BRiXQFEoZrxMZfDo23OsK7HN4mHGfhjH91QYsHBkx/1LDJlV6XMQ5ir/VN+akSqc1cSOvKBHUffcRbuxdi0CxeEal4D/oCWMg+XV9/Jy6h4RJLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r6p8/rba; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763606993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAmlZ19Q2ySJYciDDAnJfVxjnGiyaxmJEvZmZ5AC8SI=;
	b=r6p8/rbaNJADRrVWiyUBHjV59EDhYdGHQ8MwKzVPpuSpMjcXvSmkRJ4hdHg56OEzMq5dc3
	Do6Sp1UXC91GFdgK+4vDbM0WonDRKHr1YWnC57sSxMh2USyoD69HX5fih5kOabSc/w3rla
	o/vnqs2uFFH5whbmB7SP1GxXLOLzk0Q=
Date: Thu, 20 Nov 2025 02:49:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <5a66955891ef8db94b7288bbb296efcc0ac357cf@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, "John Fastabend" <john.fastabend@gmail.com>, "David 
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Neal Cardwell"
 <ncardwell@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "David
 Ahern" <dsahern@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin  KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP  Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao  Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Michal
 Luczaj" <mhal@rbox.co>, "Stefano Garzarella" <sgarzare@redhat.com>, "Cong
 Wang" <cong.wang@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <87zf8h6bpd.fsf@cloudflare.com>
References: <20251117110736.293040-1-jiayuan.chen@linux.dev>
 <20251117110736.293040-2-jiayuan.chen@linux.dev>
 <87zf8h6bpd.fsf@cloudflare.com>
X-Migadu-Flow: FLOW_OUT

November 20, 2025 at 03:53, "Jakub Sitnicki" <jakub@cloudflare.com mailto=
:jakub@cloudflare.com?to=3D%22Jakub%20Sitnicki%22%20%3Cjakub%40cloudflare=
.com%3E > wrote:

[...]
> >  +/* The BPF program sets BPF_F_INGRESS on sk_msg to indicate data ne=
eds to be
> >  + * redirected to the ingress queue of a specified socket. Since BPF=
_F_INGRESS is
> >  + * defined in UAPI so that we can't extend this enum for our intern=
al flags. We
> >  + * define some internal flags here while inheriting BPF_F_INGRESS.
> >  + */
> >  +enum {
> >  + SK_MSG_F_INGRESS =3D BPF_F_INGRESS, /* (1ULL << 0) */
> >  + /* internal flag */
> >  + SK_MSG_F_INGRESS_SELF =3D (1ULL << 1)
> >  +};
> >  +
> >=20
>=20I'm wondering if we need additional state to track this.
> Can we track sk_msg's construted from skb's that were not redirected by
> setting `sk_msg.sk =3D sk` to indicate that the source socket is us in
> sk_psock_skb_ingress_self()?

Functionally, that would work. However, in that case, we would have to ho=
ld
a reference to sk until the sk_msg is read, which would delay the release=
 of
sk. One concern is that if there is a bug in the read-side application, s=
k
might never be released.


> If not, then I'd just offset the internal flags like we do in
> net/core/filter.c, BPF_F_REDIRECT_INTERNAL.

I think we can try offsetting the internal flags.

