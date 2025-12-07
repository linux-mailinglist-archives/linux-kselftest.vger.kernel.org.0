Return-Path: <linux-kselftest+bounces-47239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AF6CABA00
	for <lists+linux-kselftest@lfdr.de>; Sun, 07 Dec 2025 22:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F015630022E0
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Dec 2025 21:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2772E1F0E;
	Sun,  7 Dec 2025 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onw71yiY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1C3AC39;
	Sun,  7 Dec 2025 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765141616; cv=none; b=hv0ROzx01sLv7eu2IYvVzrYfehLS+02HUMqxNL6MU0WKu5XTf02150Bef/SD01/At6S64mh95dNHTwUvNz0D8nzCQMrrWe+E2lmFWOjdKDfW52aM8beDzScmQv/ASo46dvGc7GsOlvkUwk4zUkstHQo5ReK3FxAdBxyNnnxsmNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765141616; c=relaxed/simple;
	bh=r4NgPahmcOTzIETcRecBHsVh1zTD1d6VmVVHg6A9HTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAprLFjf9/auxtNz7U32TJtd3R2xaksXpoCwv9MGxLY3KbmDlg2QoDRODh3UQuS3PShJ7GPUTkONTZoxKU/2nx++EWi7fCw7LDpUGmemXqyU4SUYA58i3Vneo9dvTMWbsjd9egGyNGaUJsZtV7uoidsIBHt2gbxV4Vp9N6kRX8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onw71yiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7280EC4CEFB;
	Sun,  7 Dec 2025 21:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765141616;
	bh=r4NgPahmcOTzIETcRecBHsVh1zTD1d6VmVVHg6A9HTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Onw71yiYB5jILOB0QZYHiEVNU8j39yPWiDIc7NVVmgQGla8Y5XzGqV3HdDiq2Nujy
	 YkyxRiUxHJQo/HTNjy/p7SW1Avcsy2zDrpkLG9IzgPlrDc85VRWob0ajkMCVE7vLjh
	 SPIDzil1Y91lZUaQC41Xvb1OZ1tEaWrjeZq38X+JfzMN0cXkfmLEI25a4pqwYnq3zl
	 g3gzzomAMdG5e2nH7/mpLFCEVMU1ruke+JvgMAzQFj/5mHJpWtttjIkZD6+A+2+4hF
	 SOVxsK8Uua9L+2rskZYOMFTRxllS2SWZpOfX0f00myiH95UwgmTHDvFSKJSWDWMAu5
	 ANHx0I6V2nGTA==
Date: Sun, 7 Dec 2025 13:06:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik
 <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter
 <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Shuah Khan
 <shuah@kernel.org>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH nf-next 0/5] Add IP6IP6 flowtable SW acceleration
Message-ID: <20251207130654.698001f3@kernel.org>
In-Reply-To: <20251207-b4-flowtable-offload-ip6ip6-v1-0-18e3ab7f748c@kernel.org>
References: <20251207-b4-flowtable-offload-ip6ip6-v1-0-18e3ab7f748c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 07 Dec 2025 17:06:40 +0100 Lorenzo Bianconi wrote:
> Introduce SW acceleration for IP6IP6 tunnels in the netfilter flowtable
> infrastructure.

tc-testing build fails with this:

net/netfilter/nf_flow_table_ip.c: In function =E2=80=98nf_flow_ip6_tunnel_p=
roto=E2=80=99:
net/netfilter/nf_flow_table_ip.c:370:42: error: =E2=80=98inet6_protos=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98inet_pro=
tos=E2=80=99?
  370 |                 ipprot =3D rcu_dereference(inet6_protos[nexthdr]);
      |                                          ^~~~~~~~~~~~
./include/linux/rcupdate.h:532:17: note: in definition of macro =E2=80=98__=
rcu_dereference_check=E2=80=99
  532 |         typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
      |                 ^
./include/linux/rcupdate.h:770:28: note: in expansion of macro =E2=80=98rcu=
_dereference_check=E2=80=99
  770 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
      |                            ^~~~~~~~~~~~~~~~~~~~~
net/netfilter/nf_flow_table_ip.c:370:26: note: in expansion of macro =E2=80=
=98rcu_dereference=E2=80=99
  370 |                 ipprot =3D rcu_dereference(inet6_protos[nexthdr]);
      |                          ^~~~~~~~~~~~~~~
net/netfilter/nf_flow_table_ip.c:370:42: note: each undeclared identifier i=
s reported only once for each function it appears in
  370 |                 ipprot =3D rcu_dereference(inet6_protos[nexthdr]);
      |                                          ^~~~~~~~~~~~
./include/linux/rcupdate.h:532:17: note: in definition of macro =E2=80=98__=
rcu_dereference_check=E2=80=99
  532 |         typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
      |                 ^
./include/linux/rcupdate.h:770:28: note: in expansion of macro =E2=80=98rcu=
_dereference_check=E2=80=99
  770 | #define rcu_dereference(p) rcu_dereference_check(p, 0)
      |                            ^~~~~~~~~~~~~~~~~~~~~
net/netfilter/nf_flow_table_ip.c:370:26: note: in expansion of macro =E2=80=
=98rcu_dereference=E2=80=99
  370 |                 ipprot =3D rcu_dereference(inet6_protos[nexthdr]);
      |                          ^~~~~~~~~~~~~~~
net/netfilter/nf_flow_table_ip.c:374:27: error: invalid use of undefined ty=
pe =E2=80=98const struct inet6_protocol=E2=80=99
  374 |                 if (ipprot->flags & INET6_PROTO_FINAL) {
      |                           ^~
net/netfilter/nf_flow_table_ip.c:374:37: error: =E2=80=98INET6_PROTO_FINAL=
=E2=80=99 undeclared (first use in this function)
  374 |                 if (ipprot->flags & INET6_PROTO_FINAL) {
      |                                     ^~~~~~~~~~~~~~~~~
net/netfilter/nf_flow_table_ip.c:383:29: error: invalid use of undefined ty=
pe =E2=80=98const struct inet6_protocol=E2=80=99
  383 |                 ret =3D ipprot->handler(skb);
      |                             ^~

