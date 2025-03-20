Return-Path: <linux-kselftest+bounces-29504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1E6A6A8FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 15:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27DFD7A3CAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4351DED60;
	Thu, 20 Mar 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EnkjezDc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB871DED46
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Mar 2025 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482101; cv=none; b=oMPcqxwAdBoUtJ0ErghuKnZQ9JVB5dbrvpz98kD0gyy1o7LGXEUmBlYGGUiJu+WdTTBrkt35xaPmTsSLhTkkjIyWyDGU5cUaTn01BbaQZoiXJVVvdHL+mqkWhHs8ok4THQN4cMGKZ8bRxU5hHiQDbJoo7/vtuOo7GuKscJy5vH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482101; c=relaxed/simple;
	bh=WJ070vkc9pvl3EedyR6k/ajws5zd59U5a2Diu/Qubms=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=FXhsSznpHAV1JpuAOrDXNhv87r4YFZmiZkN7gK+5OZhzf3Cjooy6aetKTDKcN26E60xtvFsRFHNxlLH/1k4nAE2TO11IGZjD8wwBZSO9pJM1PNnzyzMYNSFdKUK6/nyqg81j6zNdt93Ybht90HwFcdmU3fzUxodDqS5oY30Lkz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EnkjezDc; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742482087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AGPSkGX7UwV9BGhBv1TQ2kKav1LFAHSe1DoGva65c3k=;
	b=EnkjezDcXHj/gATbfqdkfs25Bqrpm0w00SWpQzToKkB4R+pmXe62IEvrSERDZmi86mUHUn
	exFoKK55wTEgBC9iRtE+ze8P7M5xQ/FhZ5y5dqCt//NBP3oFTc6utcbXDLwd96IpNU1M5h
	Ky06AvtFqzAiTwt7e2uGvczUcIgMSVg=
Date: Thu, 20 Mar 2025 14:48:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <f2bd7e45b327d7b190edef4916d5b9e6dc83e87a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v3 1/3] bpf, sockmap: avoid using sk_socket
 after free when sending
To: "Michal Luczaj" <mhal@rbox.co>, xiyou.wangcong@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, andrii@kernel.org,
 eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, sgarzare@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
In-Reply-To: <1e8c8e7a-23d9-4ed3-902a-8a4ba06f1f69@rbox.co>
References: <20250317092257.68760-1-jiayuan.chen@linux.dev>
 <20250317092257.68760-2-jiayuan.chen@linux.dev>
 <1e8c8e7a-23d9-4ed3-902a-8a4ba06f1f69@rbox.co>
X-Migadu-Flow: FLOW_OUT

March 20, 2025 at 20:32, "Michal Luczaj" <mhal@rbox.co> wrote:

>=20
>=20On 3/17/25 10:22, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> The sk->sk_socket is not locked or referenced, and during the call =
to
> >=20
>=20>  skb_send_sock(), there is a race condition with the release of sk_=
socket.
> >=20
>=20>  All types of sockets(tcp/udp/unix/vsock) will be affected.
> >=20
>=20>  ...
> >=20
>=20>  Some approach I tried
> >=20
>=20>  ...
> >=20
>=20>  2. Increased the reference of sk_socket->file:
> >=20
>=20>  - If the user calls close(fd), we will do nothing because the refe=
rence
> >=20
>=20>  count is not set to 0. It's unexpected.
> >=20
>=20
> Have you considered bumping file's refcnt only for the time of
>=20
>=20send/callback? Along the lines of:
>=20
>=20static struct file *sock_get_file(struct sock *sk)
>=20
>=20{
>=20
>=20 struct file *file =3D NULL;
>=20
>=20 struct socket *sock;
>=20
>=20 rcu_read_lock();
>=20
>=20 sock =3D sk->sk_socket;
>=20
>=20 if (sock)
>=20
>=20 file =3D get_file_active(&sock->file);
>=20
>=20 rcu_read_unlock();
>=20
>=20 return file;
>=20
>=20}
>=20
>=20static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff=
 *skb,
>=20
>=20 u32 off, u32 len, bool ingress)
>=20
>=20{
>=20
>=20 int err;
>=20
>=20 if (!ingress) {
>=20
>=20 struct sock *sk =3D psock->sk;
>=20
>=20 struct file *file;
>=20
>=20 ...
>=20
>=20 file =3D sock_get_file(sk);
>=20
>=20 if (!file)
>=20
>=20 return -EIO;
>=20
>=20 err =3D skb_send_sock(sk, skb, off, len);
>=20
>=20 fput(file);
>=20
>=20 return err;
>=20
>=20 }
>=20
>=20 ...
>=20
>=20}
>=20
>=20static void sk_psock_verdict_data_ready(struct sock *sk)
>=20
>=20{
>=20
>=20 struct file *file;
>=20
>=20 ...
>=20
>=20 file =3D sock_get_file(sk);
>=20
>=20 if (!file)
>=20
>=20 return;
>=20
>=20 copied =3D sk->sk_socket->ops->read_skb(sk, sk_psock_verdict_recv);
>=20
>=20 fput(file);
>=20
>=20 ...
>=20
>=20}
>

Thank you for your suggestions.

I previously attempted a similar approach in another version, but
felt that manipulating the file layer within sockmap was quite odd.

Moreover, the actual process flow is more complex than we initially
imagined.

The current overall close process looks roughly like this:
'''
close(fd):
    file_ref_put(file):
        __sock_release(sock)
            sock_map_close()
            saved_close()
               sk->sk_socket =3D NULL
            sock->ops =3D NULL
            sock->file =3D NULL
'''

We can observe that while sk->sk_socket might not be NULL, it doesn=E2=80=
=99t
guarantee that sock->file is not NULL. This means the following code
is problematic:
'''
sock =3D sk->sk_socket;
if (sock)
    sock->file->xx <=3D=3D sock->file may be set to NULL
'''

Of course, we might try something like:
'''
try_hold_sock() {
    rcu_read_lock();
=20=20=20=20
=20   sock =3D sk->sk_socket;
    if (!sock)
        unlock_return;
=20=20=20=20
=20   file =3D sock->file;
    if (!file)
        unlock_return;
=20=20=20=20
=20   file =3D get_file_active(&file);
    rcu_read_unlock();
    return file;
}
'''

Acquiring the socket's reference count requires significant effort,
and we need to pay special attention to the socket's own release
process to ensure correctness. Ultimately, this led me to decide to
operate on psock instead of directly manipulating the file layer to
avoid this issue.

