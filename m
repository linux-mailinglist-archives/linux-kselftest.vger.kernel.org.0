Return-Path: <linux-kselftest+bounces-31966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED6CAA3CEE
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 01:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEDDF16AD92
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 23:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D41D7E35;
	Tue, 29 Apr 2025 23:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JWzntBJg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17D9280329;
	Tue, 29 Apr 2025 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970458; cv=none; b=EznpLix/RTiOzFHKQ2OQqu7sfNAdIRsmu1r+8f67ZO7xx5gilAwyxEbJyMc7fyYGYlqIEfuz0XQTnu2cF+R1i0mFXuEJp0rxt/TI8/873zsSmK2fLvp+93eINvy0e9orIgmCqQJmX9Bq3iyaaEEQgxSs+swa+F2qJ08IFnlL8eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970458; c=relaxed/simple;
	bh=WiN6SJk3AWab7zFnf6f8xMuf1kLWB+L7x2uNVj2xCHs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=n/s7cOVT7tU5fZn8yAY9KpfoGSAyYTqr8NyrGD+ztRjVVR37r2Y1XO+XNZ6ig7yEM8Pep9lYnGia3DApFLTtHnJdPWvZlmkHCgOl+1BwxcYFShkmrpM5WMh3MintCFh5NVwEqLEO/IA+Kg4i+K8zRm0wV9rxGzKh01rfZbqWv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JWzntBJg; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745970444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7l3FbdVPcG6RCgTPDoLsiddGdPB4VYPhMQrF7+5Tgc=;
	b=JWzntBJgWoVk0WW+sRQOYkdhJo1BkSibXhMIqapLs5CAKRRQxantYCMWFiYy+mqrYMK7zH
	CJ782uspQr5Qb/8vZdiUXhZ03/WjlxoV1w7tQDStPKMoC49ho4FqdVLNChr6CZOXWEWy0Q
	va5rUKnCEA1xuuCpGDFdkcnnx2BnSD0=
Date: Tue, 29 Apr 2025 23:47:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <6cc9ccc1339839559710efe94bbd1d61289bdaaf@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1 0/3] bpf, sockmap: Improve performance with
 CPU affinity
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Jiayuan Chen" <mrpre@163.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "John
 Fastabend" <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Jakub Sitnicki" <jakub@cloudflare.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Kuniyuki Iwashima" <kuniyu@amazon.com>,
 "Willem de Bruijn" <willemb@google.com>, "Mykola Lysenko"
 <mykolal@fb.com>, "Shuah Khan" <shuah@kernel.org>, "Jiapeng Chong"
 <jiapeng.chong@linux.alibaba.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Network Development" <netdev@vger.kernel.org>, "open list:KERNEL
 SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
In-Reply-To: <CAADnVQLiqHUVZQ7MdqAfnUK+01D5fSt6sDR5nzon83w39ZBohA@mail.gmail.com>
References: <20250428081744.52375-1-jiayuan.chen@linux.dev>
 <CAADnVQLiqHUVZQ7MdqAfnUK+01D5fSt6sDR5nzon83w39ZBohA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

April 30, 2025 at 07:26, "Alexei Starovoitov" <alexei.starovoitov@gmail.c=
om> wrote:

>=20
>=20On Mon, Apr 28, 2025 at 1:18 AM Jiayuan Chen <jiayuan.chen@linux.dev>=
 wrote:
>=20
>=20>=20
>=20> Abstract
> >=20
>=20>  =3D=3D=3D
> >=20
>=20>  This patchset improves the performance of sockmap by providing CPU=
 affinity,
> >=20
>=20>  resulting in a 1-10x increase in throughput.
> >=20
>=20>  Motivation
> >=20
>=20>  =3D=3D=3D
> >=20
>=20>  Traditional user-space reverse proxy:
> >=20
>=20>  Reserve Proxy
> >=20
>=20>  _________________
> >=20
>=20>  client -> | fd1 <-> fd2 | -> server
> >=20
>=20>  |_________________|
> >=20
>=20>  Using sockmap for reverse proxy:
> >=20
>=20>  Reserve Proxy
> >=20
>=20>  _________________
> >=20
>=20>  client -> | fd1 <-> fd2 | -> server
> >=20
>=20>  | |_________________| |
> >=20
>=20>  | | | |
> >=20
>=20>  | _________ |
> >=20
>=20>  | | sockmap | |
> >=20
>=20>  --> |_________| -->
> >=20
>=20>  By adding fds to sockmap and using a BPF program, we can quickly f=
orward
> >=20
>=20>  data and avoid data copying between user space and kernel space.
> >=20
>=20>  Mainstream multi-process reverse proxy applications, such as Nginx=
 and
> >=20
>=20>  HAProxy, support CPU affinity settings, which allow each process t=
o be
> >=20
>=20>  pinned to a specific CPU, avoiding conflicts between data plane pr=
ocesses
> >=20
>=20>  and other processes, especially in multi-tenant environments.
> >=20
>=20>  Current Issues
> >=20
>=20>  =3D=3D=3D
> >=20
>=20>  The current design of sockmap uses a workqueue to forward ingress_=
skb and
> >=20
>=20>  wakes up the workqueue without specifying a CPU
> >=20
>=20>  (by calling schedule_delayed_work()). In the current implementatio=
n of
> >=20
>=20>  schedule_delayed_work, it tends to run the workqueue on the curren=
t CPU.
> >=20
>=20>  This approach has a high probability of running on the current CPU=
, which
> >=20
>=20>  is the same CPU that handles the net rx soft interrupt, especially=
 for
> >=20
>=20>  programs that access each other using local interfaces.
> >=20
>=20>  The loopback driver's transmit interface, loopback_xmit(), directl=
y calls
> >=20
>=20>  __netif_rx() on the current CPU, which means that the CPU handling
> >=20
>=20>  sockmap's workqueue and the client's sending CPU are the same, res=
ulting
> >=20
>=20>  in contention.
> >=20
>=20>  For a TCP flow, if the request or response is very large, the
> >=20
>=20>  psock->ingress_skb queue can become very long. When the workqueue
> >=20
>=20>  traverses this queue to forward the data, it can consume a signifi=
cant
> >=20
>=20>  amount of CPU time.
> >=20
>=20>  Solution
> >=20
>=20>  =3D=3D=3D
> >=20
>=20>  Configuring RPS on a loopback interface can be useful, but it will=
 trigger
> >=20
>=20>  additional softirq, and furthermore, it fails to achieve our expec=
ted
> >=20
>=20>  effect of CPU isolation from other processes.
> >=20
>=20>  Instead, we provide a kfunc that allow users to specify the CPU on=
 which
> >=20
>=20>  the workqueue runs through a BPF program.
> >=20
>=20>  We can use the existing benchmark to test the performance, which a=
llows
> >=20
>=20>  us to evaluate the effectiveness of this optimization.
> >=20
>=20>  Because we use local interfaces for communication and the client c=
onsumes
> >=20
>=20>  a significant amount of CPU when sending data, this prevents the w=
orkqueue
> >=20
>=20>  from processing ingress_skb in a timely manner, ultimately causing=
 the
> >=20
>=20>  server to fail to read data quickly.
> >=20
>=20>  Without cpu-affinity:
> >=20
>=20>  ./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress --no-verify
> >=20
>=20>  Setting up benchmark 'sockmap'...
> >=20
>=20>  create socket fd c1:14 p1:15 c2:16 p2:17
> >=20
>=20>  Benchmark 'sockmap' started.
> >=20
>=20>  Iter 0 ( 36.031us): Send Speed 1143.693 MB/s ... Rcv Speed 109.572=
 MB/s
> >=20
>=20>  Iter 1 ( 0.608us): Send Speed 1320.550 MB/s ... Rcv Speed 48.103 M=
B/s
> >=20
>=20>  Iter 2 ( -5.448us): Send Speed 1314.790 MB/s ... Rcv Speed 47.842 =
MB/s
> >=20
>=20>  Iter 3 ( -0.613us): Send Speed 1320.158 MB/s ... Rcv Speed 46.531 =
MB/s
> >=20
>=20>  Iter 4 ( -3.441us): Send Speed 1319.375 MB/s ... Rcv Speed 46.662 =
MB/s
> >=20
>=20>  Iter 5 ( 3.764us): Send Speed 1166.667 MB/s ... Rcv Speed 42.467 M=
B/s
> >=20
>=20>  Iter 6 ( -4.404us): Send Speed 1319.508 MB/s ... Rcv Speed 47.973 =
MB/s
> >=20
>=20>  Summary: total trans 7758 MB =C2=B1 1293.506 MB/s
> >=20
>=20>  Without cpu-affinity(RPS enabled):
> >=20
>=20>  ./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress --no-verify
> >=20
>=20>  Setting up benchmark 'sockmap'...
> >=20
>=20>  create socket fd c1:14 p1:15 c2:16 p2:17
> >=20
>=20>  Benchmark 'sockmap' started.
> >=20
>=20>  Iter 0 ( 28.925us): Send Speed 1630.357 MB/s ... Rcv Speed 850.960=
 MB/s
> >=20
>=20>  Iter 1 ( -2.042us): Send Speed 1644.564 MB/s ... Rcv Speed 822.478=
 MB/s
> >=20
>=20>  Iter 2 ( 0.754us): Send Speed 1644.297 MB/s ... Rcv Speed 850.787 =
MB/s
> >=20
>=20>  Iter 3 ( 0.159us): Send Speed 1644.429 MB/s ... Rcv Speed 850.198 =
MB/s
> >=20
>=20>  Iter 4 ( -2.898us): Send Speed 1646.924 MB/s ... Rcv Speed 830.867=
 MB/s
> >=20
>=20>  Iter 5 ( -0.210us): Send Speed 1649.410 MB/s ... Rcv Speed 824.246=
 MB/s
> >=20
>=20>  Iter 6 ( -1.448us): Send Speed 1650.723 MB/s ... Rcv Speed 808.256=
 MB/s
> >=20
>=20>  With cpu-affinity(RPS disabled):
> >=20
>=20>  ./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress --no-verify --cp=
u-affinity
> >=20
>=20>  Setting up benchmark 'sockmap'...
> >=20
>=20>  create socket fd c1:14 p1:15 c2:16 p2:17
> >=20
>=20>  Benchmark 'sockmap' started.
> >=20
>=20>  Iter 0 ( 36.051us): Send Speed 1883.437 MB/s ... Rcv Speed 1865.08=
7 MB/s
> >=20
>=20>  Iter 1 ( 1.246us): Send Speed 1900.542 MB/s ... Rcv Speed 1761.737=
 MB/s
> >=20
>=20>  Iter 2 ( -8.595us): Send Speed 1883.128 MB/s ... Rcv Speed 1860.71=
4 MB/s
> >=20
>=20>  Iter 3 ( 7.033us): Send Speed 1890.831 MB/s ... Rcv Speed 1806.684=
 MB/s
> >=20
>=20>  Iter 4 ( -8.397us): Send Speed 1884.700 MB/s ... Rcv Speed 1973.56=
8 MB/s
> >=20
>=20>  Iter 5 ( -1.822us): Send Speed 1894.125 MB/s ... Rcv Speed 1775.04=
6 MB/s
> >=20
>=20>  Iter 6 ( 4.936us): Send Speed 1877.597 MB/s ... Rcv Speed 1959.320=
 MB/s
> >=20
>=20>  Summary: total trans 11328 MB =C2=B1 1888.507 MB/s
> >=20
>=20
> This looks to me like an artificial benchmark.
> Surely perf will be higher when wq is executed on free cpu.
> In production all cpus likely have work to do, so this whole
> approach 'lets ask wq to run on that cpu' isn't going to work.
> Looks like RPS helps. Use that. I think it will scale and work
> better when the whole server is loaded.
> pw-bot: cr
>

Hi Alexei, you're right for requests coming from a remote host, all CPUs
are running; in cloud-native scenarios where Sidecars are widely used,
they access each other through loopback, but for requests accessing each
other through loopback, the wq (workqueue) will definitely run on the CPU
where the client is located (based on the implementation of loopback and =
wq).
Since the Sidecar itself is bound to a CPU, which means that in actual
scenarios, the CPU bound to the gateway (reverse proxy) program using soc=
kmap
cannot be fully utilized.

Enabling RPS can alleviate the sockmap issue, but it will introduce an ex=
tra
software calculation, so from a performance perspective, we still expect =
to
have a solution that can achieve the highest performance.

Thanks.

