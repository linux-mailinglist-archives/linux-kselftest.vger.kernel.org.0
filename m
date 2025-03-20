Return-Path: <linux-kselftest+bounces-29474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B444FA69D3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 01:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D80846224F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 00:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1813EA83;
	Thu, 20 Mar 2025 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tA8adVxN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6D339A1;
	Thu, 20 Mar 2025 00:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742430447; cv=none; b=G281yvNBPybPie/dF8Z7U98ZKQfKqKsBaUmHuiefESBAZdeXFlamFk25NAWKBoepUMjyxBJN1G10g8DkxM0staznMKQUcelbZl3k4xpATVMP1HUKGOio3Le0xprfmjlH0H+VjWtKsY+nQ8VgmuzzO0TH5oMyZcxcNiVBAese44o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742430447; c=relaxed/simple;
	bh=dBFihtx+aUosS11KVtMSGBCfwqH+7BZSM3YMPE3xRcc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=VXE6JndBOo6P7shF7Jt6LTO9okaRe0ATiJTMNBny8VPYBMKfh5/ASSxZObdn6HUkW2kKHp5P3Tpv5Ndw2ysUqjYpiWTXMI85K9AlGjc2OL29w+8EHYxQ2fMyRB4zfiO7kwVLt88n6YYrU9is6ac/8nhj7KWCAc/1tUCdGRlypnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tA8adVxN; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742430442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrzwlcOYjgAKtwASEPU+B3fs6Fqo8r091yuueSJ3aqU=;
	b=tA8adVxNRTq5KjV/4GxyipP/cqREMQ43TJ0WeVQeM+7CCy7ReVlPboTAeNGTSdY/10Ud1I
	lSIMEq80JvnyRjeWeCHMvU5XMY2dfS1F1zTwK3J4FUil0iJ2grL2xu3awqrlEZjarb1gMM
	zR0FjFhJVU8+8A94dbz7NI3kXWhwsYU=
Date: Thu, 20 Mar 2025 00:27:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <635aadb281fa68964c943026096610501434f674@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v3 1/3] bpf, sockmap: avoid using sk_socket
 after free when sending
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 mhal@rbox.co, sgarzare@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
In-Reply-To: <Z9tb+Y+w/gcqSnCo@pop-os.localdomain>
References: <20250317092257.68760-1-jiayuan.chen@linux.dev>
 <20250317092257.68760-2-jiayuan.chen@linux.dev>
 <Z9tNAhMV1Y5znONo@pop-os.localdomain>
 <48068a86ea99dffe1e7849fb544eac1746364afb@linux.dev>
 <Z9tb+Y+w/gcqSnCo@pop-os.localdomain>
X-Migadu-Flow: FLOW_OUT

March 20, 2025 at 08:06, "Cong Wang" <xiyou.wangcong@gmail.com> wrote:

>=20
>=20On Wed, Mar 19, 2025 at 11:36:13PM +0000, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> 2025/3/20 07:02, "Cong Wang" <xiyou.wangcong@gmail.com> wrote:
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  On Mon, Mar 17, 2025 at 05:22:54PM +0800, Jiayuan Chen wrote:
> >=20
>=20>=20=20
>=20>=20
>=20>  >=20
>=20>=20
>=20>  > The sk->sk_socket is not locked or referenced, and during the ca=
ll to
> >=20
>=20>  >=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  Hm? We should have a reference in socket map, whether directly or
> >=20
>=20>=20=20
>=20>=20
>=20>  indirectly, right? When we add a socket to a socket map, we do cal=
l
> >=20
>=20>=20=20
>=20>=20
>=20>  sock_map_psock_get_checked() to obtain a reference.
> >=20
>=20>=20=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  Yes, but we remove psock from sockmap when sock_map_close() was ca=
lled
> >=20
>=20>  '''
> >=20
>=20>  sock_map_close
> >=20
>=20>  lock_sock(sk);
> >=20
>=20>  rcu_read_lock();
> >=20
>=20>  psock =3D sk_psock(sk);
> >=20
>=20>  // here we remove psock and the reference of psock become 0
> >=20
>=20>  sock_map_remove_links(sk, psock)
> >=20
>=20
> sk_psock_drop() also calls cancel_delayed_work_sync(&psock->work),
>=20
>=20althrough in yet another work. Is this also a contribution to this bu=
g?
>

Maybe it's related. Calling cancel_delayed_work_sync() in sk_psock_drop()
is too late for our scenario.

To be more precise, the core goal of this patch is to prevent sock_map_cl=
ose()
from executing until the backlog work completes. This is because sock_map=
_close()
resides in the close(fd) path, once it finishes, subsequent steps will re=
lease
the sk_socket. Therefore, performing cancellation in sk_psock_drop() is t=
oo late.

Upon reviewing historical commits, I found that the backlog work original=
ly held
lock_sk, which naturally synchronized with lock_sk in sock_map_close. How=
ever,
when the backlog work later removed lock_sk, an alternative synchronizati=
on
mechanism(just hold psock reference like this patch) became necessary.
> >=20
>=20> psock =3D sk_psock_get(sk);
> >=20
>=20>  if (unlikely(!psock))
> >=20
>=20>  goto no_psock; <=3D=3D=3D jmp to no_psock
> >=20
>=20>  rcu_read_unlock();
> >=20
>=20>  release_sock(sk);
> >=20
>=20>  cancel_delayed_work_sync(&psock->work); <=3D=3D no chance to run c=
ancel
> >=20
>=20>  '''
> >=20
>=20
> I have to say sock_map_close() becomes harder and harder to understand
>=20
>=20now. And I am feeling we may have more bugs since we have two flying
>=20
>=20work's here: psock->rwork and psock->work.
>=20
>=20Thanks.

Yes, this patch prevent sock_map_close() from executing
until the backlog work completes. This likely makes the
cancel_delayed_work in sk_psock_destroy redundant.

The code has undergone too many iterations. While sk_psock_destroy certai=
nly
contains redundant operations, we should retain it for now. There may be
hidden dependencies we haven't fully untangled.

Thanks.

