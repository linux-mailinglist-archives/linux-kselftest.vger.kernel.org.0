Return-Path: <linux-kselftest+bounces-3193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF13D831813
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 12:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E79E28BFE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE57A22F0B;
	Thu, 18 Jan 2024 11:04:53 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from wp716.webpack.hosteurope.de (wp716.webpack.hosteurope.de [80.237.130.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3486BE7F;
	Thu, 18 Jan 2024 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575893; cv=none; b=h0JjjPjB4G4UH9pj9CJZbx5LtqXZrbxPizg1prGCFOtpqeST4nBrDObPr6CtBjcRxe0lWBFgLPNoOM0+vJYaz6iBYZH9ZISOCuG5hNPM1f4AVVSm1YeLOZED5Z01YtP5OaXNkk48eePg1CumM5u7JvE0mXvapLkc2hfWwrBvm7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575893; c=relaxed/simple;
	bh=oRoy9VL0TOg/kIEHuPEg7HuqMMm0cPIFZLvMKX+hsE0=;
	h=Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-bounce-key:X-HE-SMSGID; b=WsgrtvmPwBlEn2Uh/HyBJTw23xqeEEHi5f+HfjjppYxEMxKZ04yc5hAGbrfRTij/DtM8Sesl6SuVnD4gmjKb1zmL9F+/ocETSPWUig+h+mZK4Kb5XdzX+6vFvCwxw3jM1ArMwbRGkkF1SqsIlpFN/Kr+Xj+nVIKgx71hAOI3KHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=alumni.tu-berlin.de; spf=none smtp.mailfrom=alumni.tu-berlin.de; arc=none smtp.client-ip=80.237.130.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=alumni.tu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=alumni.tu-berlin.de
Received: from dynamic-2a01-0c22-ac44-ff00-7b4e-548d-a441-0836.c22.pool.telefonica.de ([2a01:c22:ac44:ff00:7b4e:548d:a441:836] helo=jt.fritz.box); authenticated
	by wp716.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rQQCP-0007Mz-OR; Thu, 18 Jan 2024 12:04:41 +0100
Message-ID: <f4e27abc6741c175b4b1baf1331c30aaedeab290.camel@alumni.tu-berlin.de>
Subject: Re: [PATCH bpf-next] bpf: Allow setting SO_TIMESTAMPING* with
 bpf_setsockopt()
From: =?ISO-8859-1?Q?J=F6rn-Thorben?= Hinz <j-t.hinz@alumni.tu-berlin.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, bpf@vger.kernel.org,
  linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,  Arnd Bergmann
 <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>
Date: Thu, 18 Jan 2024 12:04:41 +0100
In-Reply-To: <65a69e1be51ef_380df0294d9@willemb.c.googlers.com.notmuch>
References: <20240115134110.11624-1-j-t.hinz@alumni.tu-berlin.de>
	 <65a69e1be51ef_380df0294d9@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-bounce-key: webpack.hosteurope.de;j-t.hinz@alumni.tu-berlin.de;1705575891;c74c2469;
X-HE-SMSGID: 1rQQCP-0007Mz-OR

On Tue, 2024-01-16 at 10:17 -0500, Willem de Bruijn wrote:
> J=C3=B6rn-Thorben Hinz wrote:
> > A BPF application, e.g., a TCP congestion control, might benefit
> > from or
> > even require precise (=3Dhardware) packet timestamps. These
> > timestamps are
> > already available through __sk_buff.hwtstamp and
> > bpf_sock_ops.skb_hwtstamp, but could not be requested: BPF programs
> > were
> > not allowed to set SO_TIMESTAMPING* on sockets.
> >=20
> > Enable BPF programs to actively request the generation of
> > timestamps
> > from a stream socket. The also required ioctl(SIOCSHWTSTAMP) on the
> > network device must still be done separately, in user space.
> >=20
> > This patch had previously been submitted in a two-part series
> > (first
> > link below). The second patch has been independently applied in
> > commit
> > 7f6ca95d16b9 ("net: Implement missing
> > getsockopt(SO_TIMESTAMPING_NEW)")
> > (second link below).
> >=20
> > On the earlier submission, there was the open question whether to
> > only
> > allow, thus enforce, SO_TIMESTAMPING_NEW in this patch:
> >=20
> > For a BPF program, this won't make a difference: A timestamp, when
> > accessed through the fields mentioned above, is directly read from
> > skb_shared_info.hwtstamps, independent of the places where NEW/OLD
> > is
> > relevant. See bpf_convert_ctx_access() besides others.
> >=20
> > I am unsure, though, when it comes to the interconnection of user
> > space
> > and BPF "space", when both are interested in the timestamps. I
> > think it
> > would cause an unsolvable conflict when user space is bound to use
> > SO_TIMESTAMPING_OLD with a BPF program only allowed to set
> > SO_TIMESTAMPING_NEW *on the same socket*? Please correct me if I'm
> > mistaken.
>=20
> The difference between OLD and NEW only affects the system calls. It
> is not reflected in how the data is stored in the skb, or how BPF can
> read the data. A process setting SO_TIMESTAMPING_OLD will still allow
> BPF to read data using SO_TIMESTAMPING_NEW.
>=20
> But, he one place where I see a conflict is in setting sock_flag
> SOCK_TSTAMP_NEW. That affects what getsockopt returns and which cmsg
> is written:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (sock_flag(sk, SOCK_TSTAMP_NEW))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_cmsg=
_scm_timestamping64(msg, tss);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 put_cmsg=
_scm_timestamping(msg, tss);
>=20
> So a process could issue setsockopt SO_TIMESTAMPING_OLD followed by
> a BPF program that issues setsockopt SO_TIMESTAMPING_NEW and this
> would flip SOCK_TSTAMP_NEW.
>=20
> Just allowing BPF to set SO_TIMESTAMPING_OLD does not fix it, as it
> just adds the inverse case.
Thanks for elaborating on this. I see I only thought of half the
possible conflicting situations.

>=20
> A related problem is how does the BPF program know which of the two
> variants to set. The BPF program is usually compiled and loaded
> independently of the running process.
True, that is an additional challenge. And with respect to CO-RE, I
think a really portable BPF program could (or at least should) not even
decide on NEW or OLD at compile time.

>=20
> Perhaps one option is to fail the setsockop if it would flip
> sock_flag SOCK_TSTAMP_NEW. But only if called from BPF, as else it
> changes existing ABI.
>=20
> Then a BPF program can attempt to set SO_TIMESTAMPING NEW, be
> prepared to handle a particular errno, and retry with
> SO_TIMESTAMPING_OLD.
Hmm, would be possible, yes. But sounds like a weird and unexpected
special-case behavior to the occasional BPF user.

>=20
>=20
>=20
> =C2=A0
> > Link:
> > https://lore.kernel.org/lkml/20230703175048.151683-1-jthinz@mailbox.tu-=
berlin.de/
> > Link:
> > https://lore.kernel.org/all/20231221231901.67003-1-jthinz@mailbox.tu-be=
rlin.de/
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Deepa Dinamani <deepa.kernel@gmail.com>
> > Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: J=C3=B6rn-Thorben Hinz <j-t.hinz@alumni.tu-berlin.de>
>=20
>=20


