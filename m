Return-Path: <linux-kselftest+bounces-28596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1DDA592D0
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 12:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5F816B4C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 11:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D60221576;
	Mon, 10 Mar 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JfCtcZ40"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B8B22156E
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 11:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741606621; cv=none; b=lnOQcB/mP3ImWpRpkRHkYryEjECDJ76LYR5pG5BFBgTO7551qt48hF29k1RUaWoWFKNmGx2UEQHtGqJMH6Wqkfw0UHVYotpeWkdlUI/sX1UUcrOn7mpl6gACJ74zhOEw3JPyWVyia2uyn7PwtcoKseq0nI3MtNDn1FeZFTby2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741606621; c=relaxed/simple;
	bh=JaApZ7d/+Ggz2krnVT3vjrpaonIRlghHFizWVFRNLkQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=flcKlyDinxk1RB2RhnkSMjdkVf9N8gdPn5bYXc5gS/6O3rdCwbWk82vMd6AZtGPNy/McLqrHu5JLR2/qjB5gnNJtp2LqN44+8k2bicpZyMOKuTV+FE4Fkhz/hWg+Ay8UrajN4YD6nLj124XKoziO64znq4886GQfErjnB+G2RE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JfCtcZ40; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741606607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLn3thOLc+VOfKHEltzpNOv/oUESIWK0aGZgVBXpS9g=;
	b=JfCtcZ40G8NAGBVTYfKtZMCkqctg29fSlsTpEKq0K19h1yqX9qJAQSBSXkrtqusCPMPCmR
	M4kbtzO/BR1Azsg8Y/n42rgEcUZNono4emHKB0bj4EkSBKGBRoComjlNFEgwYo4LbbvNGZ
	dJZrZIFA/MyzEHs2Wmxv29knOKuC7Hg=
Date: Mon, 10 Mar 2025 11:36:44 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <78ee737400721758fa67b4f285e8ba61dc6b893b@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v2 1/3] bpf, sockmap: avoid using sk_socket
 after free
To: "Michal Luczaj" <mhal@rbox.co>, xiyou.wangcong@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, martin.lau@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 sgarzare@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 mrpre@163.com, cong.wang@bytedance.com,
 syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
In-Reply-To: <baeca627-e6f1-4d0a-aea5-fa31689edc4d@rbox.co>
References: <20250228055106.58071-1-jiayuan.chen@linux.dev>
 <20250228055106.58071-2-jiayuan.chen@linux.dev>
 <baeca627-e6f1-4d0a-aea5-fa31689edc4d@rbox.co>
X-Migadu-Flow: FLOW_OUT

March 7, 2025 at 5:45 PM, "Michal Luczaj" <mhal@rbox.co> wrote:

>=20
>=20On 2/28/25 06:51, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> ...
> >=20
>=20>  static void sk_psock_verdict_data_ready(struct sock *sk)
> >=20
>=20>  {
> >=20
>=20>  - struct socket *sock =3D sk->sk_socket;
> >=20
>=20>  + struct socket *sock;
> >=20
>=20>  const struct proto_ops *ops;
> >=20
>=20>  int copied;
> >=20
>=20>=20=20
>=20>=20
>=20>  trace_sk_data_ready(sk);
> >=20
>=20>=20=20
>=20>=20
>=20>  + /* We need RCU to prevent the sk_socket from being released.
> >=20
>=20>  + * Especially for Unix sockets, we are currently in the process
> >=20
>=20>  + * context and do not have RCU protection.
> >=20
>=20>  + */
> >=20
>=20>  + rcu_read_lock();
> >=20
>=20>  + sock =3D sk->sk_socket;
> >=20
>=20>  if (unlikely(!sock))
> >=20
>=20>  - return;
> >=20
>=20>  + goto unlock;
> >=20
>=20>  +
> >=20
>=20>  ops =3D READ_ONCE(sock->ops);
> >=20
>=20>  if (!ops || !ops->read_skb)
> >=20
>=20>  - return;
> >=20
>=20>  + goto unlock;
> >=20
>=20>  +
> >=20
>=20>  copied =3D ops->read_skb(sk, sk_psock_verdict_recv);
> >=20
>=20>  if (copied >=3D 0) {
> >=20
>=20>  struct sk_psock *psock;
> >=20
>=20>=20=20
>=20>=20
>=20>  - rcu_read_lock();
> >=20
>=20>  psock =3D sk_psock(sk);
> >=20
>=20>  if (psock)
> >=20
>=20>  sk_psock_data_ready(sk, psock);
> >=20
>=20>  - rcu_read_unlock();
> >=20
>=20>  }
> >=20
>=20>  +unlock:
> >=20
>=20>  + rcu_read_unlock();
> >=20
>=20>  }
> >=20
>=20
> Hi,
>=20
>=20Doesn't sk_psock_handle_skb() (!ingress path) have the same `struct s=
ocket`
>=20
>=20release race issue? Any plans on fixing that one, too?

Yes, the send path logic also has similar issues, and after some hacking,
I was able to reproduce it. Thanks for providing this information.
I can fix these together in the next revision of this patchset, anyway,
this patchset still needs further confirmation from the maintainer.

>=20
>=20BTW, lockdep (CONFIG_LOCKDEP=3Dy) complains about calling AF_UNIX's
>=20
>=20read_skb() under RCU read lock.
>=20
>=20Thanks,
>=20
>=20Michal
>
My environment also has LOCKDEP enabled, but I didn't see similar
warnings.
Moreover, RCU assertions are typically written as:

WARN_ON_ONCE(!rcu_read_lock_held())

And when LOCKDEP is not enabled, rcu_read_lock_held() defaults to
returning 1. So, it's unlikely to trigger a warning due to an RCU lock
being held.

Could you provide more of the call stack?

Thanks.

