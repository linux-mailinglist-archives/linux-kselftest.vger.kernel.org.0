Return-Path: <linux-kselftest+bounces-31854-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 476BCAA01BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 07:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA2A841272
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 05:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5E62741D3;
	Tue, 29 Apr 2025 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nBjiG5rj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279322371B
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 05:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745904204; cv=none; b=rAkaQbIY+LgU5E1D+TpmshhfrpyDaPpzJGO8ls/uoAYjWNzBilBSmazRKqd63q9LjfiypuODpQZOZxLS2FikynsOJTqG5WxLuR8Uo5ZlR2/HVaV9I3F/d9F+zCLDm6D7vVXEJrogUwB/R7wvpCwpMkB9zCtWhEH7xL2nKzkwQiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745904204; c=relaxed/simple;
	bh=HHmgpEroABzp2ffx9Nlts99YbN0fSxzHKeZhG8cZWbI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=AVK2l8dvXrmh1qMd4sc7iUDHYw6F5jBgQD2g75ha2d7VdMdthTtKy7XSp/lKn6CvdPrlIFfGRpaVhHHbtQiI1zPyumbod1R6Xf5zeBVBhE5N5e+uSQBCgXvIjMhSJEn3GN4T8DaP08Na6K+Avr3tcBwJhyFUTGxZcmG80257eb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nBjiG5rj; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745904197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzKVHcxUNgUZ3k5cuqFhdfyUp6ng16+RrHnkO59Dl68=;
	b=nBjiG5rjSc42h9jBukLq9YEhF0bdYT/OukI1198vedefrPnmNqYaAJZjGJTPc+UjnqyxFU
	0fZyQJFULfRypaSlU4GL1GSyxSRMSJr0LuWMLeU/DW8g4Ydwp14DSXJeYwGQYHAxYzv2ZZ
	FWpIcyzWRE+8oPy14JNIo2vJy3LMqPs=
Date: Tue, 29 Apr 2025 05:23:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <8a5d5b162a1462568c4d342c93896c919950cbe9@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1 1/3] bpf, sockmap: Introduce a new kfunc for
 sockmap
To: "Cong Wang" <xiyou.wangcong@gmail.com>
Cc: bpf@vger.kernel.org, mrpre@163.com, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Kuniyuki Iwashima" <kuniyu@amazon.com>, "Willem de Bruijn"
 <willemb@google.com>, "Mykola Lysenko" <mykolal@fb.com>, "Shuah Khan"
 <shuah@kernel.org>, "Jiapeng Chong" <jiapeng.chong@linux.alibaba.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <aBAjtATRrVNegYjm@pop-os.localdomain>
References: <20250428081744.52375-1-jiayuan.chen@linux.dev>
 <20250428081744.52375-2-jiayuan.chen@linux.dev>
 <aBAjtATRrVNegYjm@pop-os.localdomain>
X-Migadu-Flow: FLOW_OUT

2025/4/29 08:56, "Cong Wang" <xiyou.wangcong@gmail.com> wrote:

>=20
>=20On Mon, Apr 28, 2025 at 04:16:52PM +0800, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> +bpf_sk_skb_set_redirect_cpu()
> >=20
>=20>  +^^^^^^^^^^^^^^^^^^^^^^
> >=20
>=20>  +.. code-block:: c
> >=20
>=20>  +
> >=20
>=20>  + int bpf_sk_skb_set_redirect_cpu(struct __sk_buff *s, int redir_c=
pu)
> >=20
>=20>  +
> >=20
>=20>  +This kfunc ``bpf_sk_skb_set_redirect_cpu()`` is available to
> >=20
>=20>  +``BPF_PROG_TYPE_SK_SKB`` BPF programs. It sets the CPU affinity, =
allowing the
> >=20
>=20>  +sockmap packet redirecting process to run on the specified CPU as=
 much as
> >=20
>=20>  +possible, helping users reduce the interference between the sockm=
ap redirecting
> >=20
>=20>  +background thread and other threads.
> >=20
>=20>  +
> >=20
>=20
> I am wondering if it is a better idea to use BPF_MAP_TYPE_CPUMAP for
>=20
>=20redirection here instead? Like we did for bpf_redirect_map(). At leas=
t
>=20
>=20we would not need to store CPU in psock with this approach.
>=20
>=20Thanks.
>

You mean to use BPF_MAP_TYPE_CPUMAP with XDP to redirect packets to a
specific CPU?

I tested and found such overhead:
1=E3=80=81Needing to parse the L4 header from the L2 header to obtain the=
 5-tuple,
  and then maintaining an additional map to store the relationship betwee=
n
  each five-tuple and process/CPU. Compared to multi-process scenario, wi=
th
  one process binding to one CPU and one map, I can directly use a global
  variable to let the BPF program know which thread it should use, especi=
ally
  for programs that enable reuseport.


2=E3=80=81Furthermore, regarding performance, I tested with cpumap and th=
e results
   were lower than expected. This is because loopback only has xdp_generi=
c
   mode and the problem I described in cover letter is actually occurred
   on loopback...

Code:
'''
struct {
      __uint(type, BPF_MAP_TYPE_CPUMAP);
      __uint(key_size, sizeof(__u32));
      __uint(value_size, sizeof(struct bpf_cpumap_val));
      __uint(max_entries, 64);
} cpu_map SEC(".maps");


SEC("xdp")
int  xdp_stats1_func(struct xdp_md *ctx)
{
      /* Real world:
       * 1. get 5-tuple from ctx
       * 2. get corresponding cpu of current skb through XX_MAP
       */
      int ret =3D bpf_redirect_map(&cpu_map, 3, 0); // redirct to 3
      return ret;
}
'''

Result:
'''
./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress --no-verify
Setting up benchmark 'sockmap'...
create socket fd c1:14 p1:15 c2:16 p2:17
Benchmark 'sockmap' started.
Iter   0 ( 36.439us): Send Speed  561.496 MB/s ... Rcv Speed   33.264 MB/=
s
Iter   1 ( -7.448us): Send Speed  558.443 MB/s ... Rcv Speed   32.611 MB/=
s
Iter   2 ( -2.245us): Send Speed  557.131 MB/s ... Rcv Speed   33.004 MB/=
s
Iter   3 ( -2.845us): Send Speed  547.374 MB/s ... Rcv Speed   33.331 MB/=
s
Iter   4 (  0.745us): Send Speed  562.891 MB/s ... Rcv Speed   34.117 MB/=
s
Iter   5 ( -2.056us): Send Speed  560.994 MB/s ... Rcv Speed   33.069 MB/=
s
Iter   6 (  5.343us): Send Speed  562.038 MB/s ... Rcv Speed   33.200 MB/=
s
'''

Instead, we can introduce a new kfunc to specify the CPU used by the
backlog running thread, which can avoid using XDP. After all, this is a
"problem" brought by the BPF L7 framework itself, and it's better to solv=
e
it ourselves.

