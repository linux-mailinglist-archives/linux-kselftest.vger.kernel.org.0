Return-Path: <linux-kselftest+bounces-31841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 977AAA9FF44
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 03:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7977046226E
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 01:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A744520CCD6;
	Tue, 29 Apr 2025 01:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IY3D7215"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1D020C48F
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 01:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745891769; cv=none; b=FsXYT/uY4p8g2poDDdo7/1T0vfe0XIm5qtxsoQldgPERPPWHPzJ8mt3gXUpszwV6SaEWpq7JRkS14c3pJvvYkgoZf7L1VLas5fuGXVjHE121JUOyzA1xfqdYyJUmt5xZPUXG4eRPyy9V4pBXQLjQ+o/XdMNdEGEWpp2WA/fJm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745891769; c=relaxed/simple;
	bh=6Tu7WNCa4Qgna5rlBXusXoEpPxhH8rKaEChLAmKivzM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=F0Aqy269+IA91dH1KHQb8EUfhdPKsllgLx3fS9TQukCCOCiWgfoYIePoIMEOg/2YhWxE8q4Ry4Q1ONNuaQ+05SGcibZxUGEM5XkyQx3ZEuJofbUN6wngU9xdsJHcu5ZeUP1N6yyklQKzsW2+9o+rXE7e/f8drc1D8n9MPM6EJiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IY3D7215; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745891755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s891RcXunIyhE6HG0MbHyrZLTrEoNr5m9Jf8E67m/jg=;
	b=IY3D7215uNFs8V8YUuxjhBJsRs6/S9CWYKdeZbdqzVG30390GQRfxU3n8+JdetU1gRPpMK
	ODVAY8u5UdD+UF/4Fps/2NIoXQx7fP74czU8eLsOU4+0DB9YWDJXnBn5wyB0omN8tH9bfk
	45zdzBuUNpUtCjo+sMzty6jcqicwAzg=
Date: Tue, 29 Apr 2025 01:55:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <048b968d1993ca84e3442da936bc8e4be07d98f4@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1 1/2] ktls, sockmap: Fix missing uncharge
 operation
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org, mrpre@163.com, "Boris Pismenny" <borisp@nvidia.com>,
 "John Fastabend" <john.fastabend@gmail.com>, "Jakub Kicinski"
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Mykola Lysenko" <mykolal@fb.com>, "Shuah
 Khan" <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <aBAZ/p0Yj2kFGHhg@pop-os.localdomain>
References: <20250425060015.6968-1-jiayuan.chen@linux.dev>
 <20250425060015.6968-2-jiayuan.chen@linux.dev>
 <aBAZ/p0Yj2kFGHhg@pop-os.localdomain>
X-Migadu-Flow: FLOW_OUT

2025/4/29 08:14, "Cong Wang" <xiyou.wangcong@gmail.com> wrote:

>=20
>=20On Fri, Apr 25, 2025 at 01:59:57PM +0800, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> net/tls/tls_sw.c | 7 +++++++
> >=20
>=20>  1 file changed, 7 insertions(+)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> >=20
>=20>  index f3d7d19482da..fc88e34b7f33 100644
> >=20
>=20>  --- a/net/tls/tls_sw.c
> >=20
>=20>  +++ b/net/tls/tls_sw.c
> >=20
>=20>  @@ -908,6 +908,13 @@ static int bpf_exec_tx_verdict(struct sk_msg =
*msg, struct sock *sk,
> >=20
>=20>  &msg_redir, send, flags);
> >=20
>=20>  lock_sock(sk);
> >=20
>=20>  if (err < 0) {
> >=20
>=20>  + /* Regardless of whether the data represented by
> >=20
>=20>  + * msg_redir is sent successfully, we have already
> >=20
>=20>  + * uncharged it via sk_msg_return_zero(). The
> >=20
>=20>  + * msg->sg.size represents the remaining unprocessed
> >=20
>=20>  + * data, which needs to be uncharged here.
> >=20
>=20>  + */
> >=20
>=20>  + sk_mem_uncharge(sk, msg->sg.size);
> >=20
>=20>  *copied -=3D sk_msg_free_nocharge(sk, &msg_redir);
> >=20
>=20
> Equivalent to sk_msg_free() ?
>=20
>=20Thanks.
>

Before calling tcp_bpf_sendmsg_redir(), we have already uncharged some
memory using sk_msg_return_zero(). If we perform sk_msg_free(msg_redir),
it will cause the duplicate uncharge of this part of data. If we perform
sk_msg_free(msg), since tcp_bpf_sendmsg_redir() may not have sent any dat=
a
and msg->sg.start no longer points to this part of data, it will lead to
memoryleak.

So, directly calling sk_msg_free is not a good idea.

