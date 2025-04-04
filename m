Return-Path: <linux-kselftest+bounces-30088-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76408A7B45C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 02:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC351741EE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 00:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5B5199230;
	Fri,  4 Apr 2025 00:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o0pYuFHS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230BF8F66
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Apr 2025 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743726481; cv=none; b=J+NVT4ALYTkMAu6LP2V5u/ke1X7UizaqvvWNFkgb+fuzoXcAICdHZg8mKa4xnaHbOn4tEemq+XAsHPQ+VcHEN65WIegJKhmywvY3XnbZuvNT2g4aL+K34Q1OsskYjBMZS8gs+zMMeSnY4uR54+RXiR7xOpcBUR/FTJZgbMD8yq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743726481; c=relaxed/simple;
	bh=sZCuFd4nf1NVtLGFqso9PSbFQ53jt5gd2JBpo8x0AYk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=E0qRlcRV39tFmEY+udT/9kl2GwZl/9huHfTElhA4+zwuw/l8U6HZl+CqyXurHKnVa+2p0m/SfPJergad7KjTiIzzNxZbJS4VQgiF0Egx2jHiPMCJYPvXxYxOe7FAptSJqWtlkur04B67ZK2Abdj/bV+kKlliE4P+DmoMIK8Y/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o0pYuFHS; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743726466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xBkmuETqkFanCorV9XII3T38OpLgK/5FcDlEGxS6XPw=;
	b=o0pYuFHS4a16tKKp9qPixsi8OkmZfIh/VoQNM467L8R0c/GR+tYyqm5x2K/ZHU2ZArSZ0M
	EpIEZ+nb7humYj32cSPTWpEq8Uat13ol/fFWrg0y8UVvTfBPWLDD713oUl/Hf3NPpULtDL
	aYvRGeZ7p9Pt3qbOd8TXVpYiVsAUulQ=
Date: Fri, 04 Apr 2025 00:27:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <ce4a0aacecb2db7d232e94a324150dc5936c803a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf v2 1/2] bpf, xdp: clean head/meta when expanding it
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Jiayuan Chen" <mrpre@163.com>,
 syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "John
 Fastabend" <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, "Mykola Lysenko"
 <mykolal@fb.com>, "Shuah Khan" <shuah@kernel.org>, "Willem de Bruijn"
 <willemb@google.com>, "Jason Xing" <kerneljasonxing@gmail.com>, "Anton
 Protopopov" <aspsk@isovalent.com>, "Abhishek Chauhan"
 <quic_abchauha@quicinc.com>, "Jordan Rome" <linux@jordanrome.com>,
 "Martin Kelly" <martin.kelly@crowdstrike.com>, "David Lechner"
 <dlechner@baylibre.com>, "LKML" <linux-kernel@vger.kernel.org>, "Network
 Development" <netdev@vger.kernel.org>, "open list:KERNEL SELFTEST
 FRAMEWORK" <linux-kselftest@vger.kernel.org>
In-Reply-To: <CAADnVQJ6NPGuY=c8kbpX_nLYq4oOxOBAxbDPFLuw+yr4WrQQOQ@mail.gmail.com>
References: <20250331032354.75808-1-jiayuan.chen@linux.dev>
 <20250331032354.75808-2-jiayuan.chen@linux.dev>
 <CAADnVQJ6NPGuY=c8kbpX_nLYq4oOxOBAxbDPFLuw+yr4WrQQOQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

April 3, 2025 at 22:24, "Alexei Starovoitov" <alexei.starovoitov@gmail.co=
m> wrote:



>=20
>=20On Sun, Mar 30, 2025 at 8:27 PM Jiayuan Chen <jiayuan.chen@linux.dev>=
 wrote:
>=20
>=20>=20
>=20> The device allocates an skb, it additionally allocates a prepad siz=
e
> >=20
>=20>  (usually equal to NET_SKB_PAD or XDP_PACKET_HEADROOM) but leaves i=
t
> >=20
>=20>  uninitialized.
> >=20
>=20>  The bpf_xdp_adjust_head function moves skb->data forward, which al=
lows
> >=20
>=20>  users to access data belonging to other programs, posing a securit=
y risk.
> >=20
>=20>  Reported-by: syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com
> >=20
>=20>  Closes: https://lore.kernel.org/all/00000000000067f65105edbd295d@g=
oogle.com/T/
> >=20
>=20>  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  include/uapi/linux/bpf.h | 8 +++++---
> >=20
>=20>  net/core/filter.c | 5 ++++-
> >=20
>=20>  tools/include/uapi/linux/bpf.h | 6 ++++--
> >=20
>=20>  3 files changed, 13 insertions(+), 6 deletions(-)
> >=20
>=20>  diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >=20
>=20>  index defa5bb881f4..be01a848cbbf 100644
> >=20
>=20>  --- a/include/uapi/linux/bpf.h
> >=20
>=20>  +++ b/include/uapi/linux/bpf.h
> >=20
>=20>  @@ -2760,8 +2760,9 @@ union bpf_attr {
> >=20
>=20>  *
> >=20
>=20>  * long bpf_xdp_adjust_head(struct xdp_buff *xdp_md, int delta)
> >=20
>=20>  * Description
> >=20
>=20>  - * Adjust (move) *xdp_md*\ **->data** by *delta* bytes. Note that
> >=20
>=20>  - * it is possible to use a negative value for *delta*. This helpe=
r
> >=20
>=20>  + * Adjust (move) *xdp_md*\ **->data** by *delta* bytes. Note that
> >=20
>=20>  + * it is possible to use a negative value for *delta*. If *delta*
> >=20
>=20>  + * is negative, the new header will be memset to zero. This helpe=
r
> >=20
>=20>  * can be used to prepare the packet for pushing or popping
> >=20
>=20>  * headers.
> >=20
>=20>  *
> >=20
>=20>  @@ -2989,7 +2990,8 @@ union bpf_attr {
> >=20
>=20>  * long bpf_xdp_adjust_meta(struct xdp_buff *xdp_md, int delta)
> >=20
>=20>  * Description
> >=20
>=20>  * Adjust the address pointed by *xdp_md*\ **->data_meta** by
> >=20
>=20>  - * *delta* (which can be positive or negative). Note that this
> >=20
>=20>  + * *delta* (which can be positive or negative). If *delta* is
> >=20
>=20>  + * negative, the new meta will be memset to zero. Note that this
> >=20
>=20>  * operation modifies the address stored in *xdp_md*\ **->data**,
> >=20
>=20>  * so the latter must be loaded only after the helper has been
> >=20
>=20>  * called.
> >=20
>=20>  diff --git a/net/core/filter.c b/net/core/filter.c
> >=20
>=20>  index 46ae8eb7a03c..5f01d373b719 100644
> >=20
>=20>  --- a/net/core/filter.c
> >=20
>=20>  +++ b/net/core/filter.c
> >=20
>=20>  @@ -3947,6 +3947,8 @@ BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_b=
uff *, xdp, int, offset)
> >=20
>=20>  if (metalen)
> >=20
>=20>  memmove(xdp->data_meta + offset,
> >=20
>=20>  xdp->data_meta, metalen);
> >=20
>=20>  + if (offset < 0)
> >=20
>=20>  + memset(data, 0, -offset);
> >=20
>=20>  xdp->data_meta +=3D offset;
> >=20
>=20>  xdp->data =3D data;
> >=20
>=20>  @@ -4239,7 +4241,8 @@ BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_b=
uff *, xdp, int, offset)
> >=20
>=20>  return -EINVAL;
> >=20
>=20>  if (unlikely(xdp_metalen_invalid(metalen)))
> >=20
>=20>  return -EACCES;
> >=20
>=20>  -
> >=20
>=20>  + if (offset < 0)
> >=20
>=20>  + memset(meta, 0, -offset);
> >=20
>=20
> Let's make everyone pay a performance penalty to silence
> KMSAN warning?
> I don't think it's a good trade off.
> Soft nack.
>

It's not just about simply suppressing KMSAN warnings, but for security
considerations.

So I'd like to confirm: currently, loading an XDP program only requires
CAP_NET_ADMIN and CAP_BPF permissions. If we consider this as a super
privilege, then even if uninitialized memory is exposed, I think it's oka=
y,
as it's the developer's responsibility, for example, like the CVE in meta
https://vuldb.com/?id.246309.

Or I'm thinking, can we rely on the verifier to force the initialization
of the newly added packet boundary behavior, specifically for this specia=
l
case (although it won't be easy to implement).

