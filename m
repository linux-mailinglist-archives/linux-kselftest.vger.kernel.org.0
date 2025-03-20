Return-Path: <linux-kselftest+bounces-29500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8415BA6A657
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 13:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680833AF758
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BB21DF259;
	Thu, 20 Mar 2025 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MPaOo1Zs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE351EB3D
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742474233; cv=none; b=ljFOaByi5DMnbCKkhgo39aj2/5O+wqsXynCvEx1P0d2QS6wmAMoVv6dryZrPYHrEVhXk+rP4Ubqm6E/0ZllCw+VbR0SDskQmSf4xxw4fHffj/GJGpjrA808a4qWVARSA6jnIB/VCHPX31OFYw8YCO6ITJn+hpz/H9wkF+Vetghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742474233; c=relaxed/simple;
	bh=qe76n7w8WG2/vcG8sw7IiSgCXf7eBBkZ60h0gIOTUNU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=aokKKuICONdpsfljnU5XYepSZRtROIZYQ1qtuCWEJY4wTzlMFnOyyDzIzgh3ojNTKlVyM84xNC55nLlCDlwQ9LkE5zO3eO5Fkf6RIfWndN1lwRApM5UQ+S1Criju/zFKTDYhiWu434+q4evvrsA1MvYPvwd8Z49Xj1N5lGjZ8C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MPaOo1Zs; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742474219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rw6wMIYMJ1AHQenbcEv56UwG8Bnbs4a/rZ4UNrxeeV8=;
	b=MPaOo1ZsDBnhct6Qww0pUpr15rn8LiP3QJx1nKQ0zU/QdWuhVM8+FVRdqYV67YBjZBSTeV
	o2wW4MDvUBkgTVF5B1tFIwjobCU/PXmWM5wV2or+Qio27JfXbbZLA6HM0AbJy7NWVyrORv
	nI4ICnNjWxD7HmEplggQ4hDYzOQW29I=
Date: Thu, 20 Mar 2025 12:36:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <b403d53317c0bd8125cecbc0651e54338ca11bfd@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v3 2/3] bpf, sockmap: avoid using sk_socket
 after free when reading
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 mhal@rbox.co, sgarzare@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 syzbot+dd90a702f518e0eac072@syzkaller.appspotmail.com
In-Reply-To: <Z9tiqkSOH9vuOOJL@pop-os.localdomain>
References: <20250317092257.68760-1-jiayuan.chen@linux.dev>
 <20250317092257.68760-3-jiayuan.chen@linux.dev>
 <Z9tiqkSOH9vuOOJL@pop-os.localdomain>
X-Migadu-Flow: FLOW_OUT

March 20, 2025 at 08:34, "Cong Wang" <xiyou.wangcong@gmail.com> wrote:

>=20
>=20On Mon, Mar 17, 2025 at 05:22:55PM +0800, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> There are potential concurrency issues, as shown below.
> >=20
>=20>  '''
> >=20
>=20>  CPU0 CPU1
> >=20
>=20>  sk_psock_verdict_data_ready:
> >=20
>=20>  socket *sock =3D sk->sk_socket
> >=20
>=20>  if (!sock) return
> >=20
>=20>  close(fd):
> >=20
>=20>  ...
> >=20
>=20>  ops->release()
> >=20
>=20>  if (!sock->ops) return
> >=20
>=20>  sock->ops =3D NULL
> >=20
>=20>  rcu_call(sock)
> >=20
>=20>  free(sock)
> >=20
>=20>  READ_ONCE(sock->ops)
> >=20
>=20>  ^
> >=20
>=20>  use 'sock' after free
> >=20
>=20>  '''
> >=20
>=20>=20=20
>=20>=20
>=20>  RCU is not applicable to Unix sockets read path, because the Unix =
socket
> >=20
>=20>  implementation itself assumes it's always in process context and h=
eavily
> >=20
>=20>  uses mutex_lock, so, we can't call read_skb within rcu lock.
> >=20
>=20
> Hm, I guess the RCU work in sk_psock_drop() does not work for Unix
>=20
>=20domain sockets either?
>=20
>=20Thanks.
>

Although the Unix domain socket framework does not use RCU locks, the
entire sockmap process protects access to psock via RCU:
'''
rcu_read_lock();
psock =3D sk_psock(sk_other);
if (psock) {
 ...
}
rcu_read_unlock(); // `sk_psock_drop` will not execute until the unlock
'''

Therefore, I believe there are no issues with the psock operations here.

Thanks~

