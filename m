Return-Path: <linux-kselftest+bounces-32064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E527AA5AC3
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 08:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8BF4668AE
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 06:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5E7262FEA;
	Thu,  1 May 2025 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F2enR2Ph"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258C2309BD
	for <linux-kselftest@vger.kernel.org>; Thu,  1 May 2025 06:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746080557; cv=none; b=g2EeBHJvmIxOxtqj85gQu0aCscvBEByj+t8C5lgYsCv9ywKUtQBF6tomgV2V/ucpml/D4GIWqaMz3AqDaKhPZihnP8bJIqzMYw0t5jqaHP0sIcBq3cE+fesLzgXzYUvkJ3F6EBsTcL6axof3IpIX78999GJftfUsycRJuZXx7Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746080557; c=relaxed/simple;
	bh=D4LMMZVUvWgTthgOdYiEWmA7Ak8ZBcN3AHcfBQngo3A=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=GLAjY/2i0uyl7mLCyZLDtOk3Sd0wlDwmACkJRPyQPRICJ/mjs6vOsr4IKGmMhGHL+6xpqSpcmpnjp15oM9B6HqbsLfqze/AU2FhPy3d1RReSBH1Rlmx6GRE84N3ItzRSZMZOhhuM2mVtZa6+Kay9VzrV64QJTI0trI+J5d9sEjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F2enR2Ph; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746080543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjChiQ9PgUc2a1/7cJEmrsrWFH7Apodvn16ltR0juPY=;
	b=F2enR2Ph/xphEnIbT/WgtKidoT3a8MaDaJsGQGsuhwKH19ULsfSOZicpGsTIiN52Ton9O6
	uTZyAs29HxDUmGNGeYAqDRGkJ/3bhkaoiYEbj7INOJmZGO/5Gyz2yZb8tnpLEhC7zy+PzD
	T9TlFBYKT0i3u4tsSSVfyh5t1HcuoOw=
Date: Thu, 01 May 2025 06:22:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <1f4d3fb4eed397e346efb3ef597e29204e5a2f4b@linux.dev>
TLS-Required: No
Subject: Re: [RFC net-next v1 1/2] udp: Introduce UDP_STOP_RCV option for UDP
To: "Kuniyuki Iwashima" <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, shuah@kernel.org, willemdebruijn.kernel@gmail.com
In-Reply-To: <20250501044321.83028-1-kuniyu@amazon.com>
References: <20250501035116.69391-1-jiayuan.chen@linux.dev>
 <20250501044321.83028-1-kuniyu@amazon.com>
X-Migadu-Flow: FLOW_OUT

2025/5/1 12:42, "Kuniyuki Iwashima" <kuniyu@amazon.com> wrote:

>=20
>=20From: Jiayuan Chen <jiayuan.chen@linux.dev>
>=20
>=20Date: Thu, 1 May 2025 11:51:08 +0800
>=20
>=20>=20
>=20> For some services we are using "established-over-unconnected" model=
.
> >=20
>=20>=20=20
>=20>=20
>=20>  '''
> >=20
>=20>  // create unconnected socket and 'listen()'
> >=20
>=20>  srv_fd =3D socket(AF_INET, SOCK_DGRAM)
> >=20
>=20>  setsockopt(srv_fd, SO_REUSEPORT)
> >=20
>=20>  bind(srv_fd, SERVER_ADDR, SERVER_PORT)
> >=20
>=20>=20=20
>=20>=20
>=20>  // 'accept()'
> >=20
>=20>  data, client_addr =3D recvmsg(srv_fd)
> >=20
>=20>=20=20
>=20>=20
>=20>  // create a connected socket for this request
> >=20
>=20>  cli_fd =3D socket(AF_INET, SOCK_DGRAM)
> >=20
>=20>  setsockopt(cli_fd, SO_REUSEPORT)
> >=20
>=20>  bind(cli_fd, SERVER_ADDR, SERVER_PORT)
> >=20
>=20>  connect(cli, client_addr)
> >=20
>=20>  ...
> >=20
>=20>  // do handshake with cli_fd
> >=20
>=20>  '''
> >=20
>=20>=20=20
>=20>=20
>=20>  This programming pattern simulates accept() using UDP, creating a =
new
> >=20
>=20>  socket for each client request. The server can then use separate s=
ockets
> >=20
>=20>  to handle client requests, avoiding the need to use a single UDP s=
ocket
> >=20
>=20>  for I/O transmission.
> >=20
>=20>=20=20
>=20>=20
>=20>  But there is a race condition between the bind() and connect() of =
the
> >=20
>=20>  connected socket:
> >=20
>=20>  We might receive unexpected packets belonging to the unconnected s=
ocket
> >=20
>=20>  before connect() is executed, which is not what we need.
> >=20
>=20>  (Of course, before connect(), the unconnected socket will also rec=
eive
> >=20
>=20>  packets from the connected socket, which is easily resolved becaus=
e
> >=20
>=20>  upper-layer protocols typically require explicit boundaries, and w=
e
> >=20
>=20>  receive a complete packet before creating a connected socket.)
> >=20
>=20>=20=20
>=20>=20
>=20>  Before this patch, the connected socket had to filter requests at =
recvmsg
> >=20
>=20>  time, acting as a dispatcher to some extent. With this patch, we c=
an
> >=20
>=20>  consider the bind and connect operations to be atomic.
> >=20
>=20
> SO_ATTACH_REUSEPORT_EBPF is what you want.
>=20
>=20The socket won't receive any packets until the socket is added to
>=20
>=20the BPF map.
>=20
>=20No need to reinvent a subset of BPF functionalities.
>

I think this feature is for selecting one socket, not filtering out certa=
in
sockets.

Does this mean that I need to first capture all sockets bound to the same
port, and then if the kernel selects a socket that I don't want to receiv=
e
packets on, I'll need to implement an algorithm in the BPF program to
choose another socket from the ones I've captured, in order to avoid
returning that socket?

This looks like it completely bypasses the kernel's built-in scoring
logic. Or is expanding BPF_PROG_TYPE_SK_REUSEPORT to have filtering
capabilities also an acceptable solution?

