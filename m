Return-Path: <linux-kselftest+bounces-31963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20988AA3C0C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 01:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACE73BBD20
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 23:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899CE2DAF82;
	Tue, 29 Apr 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df0Qa7N8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B64526C3A7;
	Tue, 29 Apr 2025 23:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745969183; cv=none; b=q36zD1I9aj2JJlbJVTiSumtEfzLLdMmuYMx0Zv/BUpFn+v9iCi87/2ZpYPp4VgNuVleYlI/4hPVv+9vH1m0AVDwElDqZDAW/bpl7fye2sK52wo+WULPItR/8xYc58xu3d3eSLIwieoZXjAHBHBoqBcZ1KzKeJT+vLPEt9Go25Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745969183; c=relaxed/simple;
	bh=iF6loME2ZLBGG3+YvUeYD+42FUs152smdHPJZFZov0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sic4jN/NvlNF7X6oDN+W/6wwiO+NHcZVHUjGQPOpov5e3nwUH3/zPjV2GIo/1z6e4wl4F+9jWeCzJDSLhLbG/jm+XF2aqT9M7QDLCes/Vm6iJxBkvrePuPHTvo4AIt+cbI0S7UHRts5UismhQf0KcmKILPwZNc271ZaTs/YB2Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Df0Qa7N8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso214446f8f.1;
        Tue, 29 Apr 2025 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745969179; x=1746573979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0we/AEJtjZm5+90EsrdiZ3dpzmSTHMb9lTxlVDQ2Nw=;
        b=Df0Qa7N81V8yfRPyQyHAVC7RmmO2HHESfBwl00wFTmjG9/ZGsr29RM0yMRteXWEkjI
         5PbQ420BRHst/36CWRsnQd4a0S+kdA2SxcOugOwNYOj/yoV/8/qUhoET+ecNS9nsFEnO
         mT52MSFe2J1HoeSfE1Sny+YbsIF7nqqldQyf30k1nbtvvZvcoqSKyWuVyUOzq1695cOY
         ejtyz0rHjciSRnFvW7RUDlkcsExLLxJ1FArx4FmcwgzDa5qVIiHXyQ1ScR/YlMOV5SKW
         sgWe1T55moIdTPoTUHtFRVXkDdYoYRKBM2PIGJbFvoAcEsnKD7DJvncIWcJznFz55uV0
         J7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745969179; x=1746573979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0we/AEJtjZm5+90EsrdiZ3dpzmSTHMb9lTxlVDQ2Nw=;
        b=xF8l6ISzKxbdTavigGL3l8mPl4DX3yF7jK6tZriVhUT0/LxzK8dYVKLAr86SMgEQZf
         aUrmHI9ANtY1HfF7xiwyJdSEpK3jKIADVeu6P84sjImSKM6RkJ356WK84gmwQTi3WrTs
         tM48EcO4jPOrt37sHfhnYTZlQ9ED/DOsUGVLI/t+qtRTVtXoRwnJibL9RpxiDgPCnUpA
         8m2hohuwSuHq+ChFZHGae+08jLHo7OQbuFX2xcjhxNOaA2yGItTE/XmUMyJU2cfb0xyn
         HHs4yvY7DhIL8xTJVUgrs7wOfhJlz7d/+UAbyYWdJ89K1Ml96umfg3+Shx82/5ZdFNRl
         NFig==
X-Forwarded-Encrypted: i=1; AJvYcCU8TmD9umxSaxmHTSf6h3dIN+GlbPhYmaCqwwS2hwx2XYRgQ9fbLU7eY/alx1UNA+zLm+d1d4Jwk/s=@vger.kernel.org, AJvYcCUzDShUeTEhXo/6PeKRYXweKvy236kQR6fZZjiJX1v1ccFZmZDXdj7GPbwyD76nxC4SoMKQGiba+CJHMqTo@vger.kernel.org, AJvYcCWlPvAVZYxhRNz3xy9qv/fAADR3JLCpwUHyV6HRZuI1OcnTdapCjEXF2qy5aICxlpHEBTy359ndP0Dtwe5duHkC@vger.kernel.org, AJvYcCXFEi35pnNWZ/yyeB9WBunu1hVI5/vebz2rROnKyNiGo73qfaPVoi++YbzyXsjdxnZaKyclz+aB@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQXPdeeIs/u2k6AZDUfMFa1pEABEuYCAfmfDkzAV4e58XNY58
	IbQX963wEoETUVJ+qX158mnlHYPFrDPmrmxKCMrGW3xJzcccjsUAtO0W4i0krqChpWVBhj7KhT1
	gMi4ptPnF7KqdZyEZ0MbV5pm0J08=
X-Gm-Gg: ASbGnctgowZ/VwaBDSVlXUQKcHsSZYrt09S8vn5xtsc2rx0Y9OYCWbOfiX/STTG/Daq
	uViy+STD8qsTVSn884KFJQ9FBto86wjaRTL2iYQzv5v3KKhVKVQ1/OxXwXshavEc9NT2POdSCVJ
	bF/J/c+bHLhbreb/DGkzPUXWxyg4JLGw2Tdf0NT2c/Ji4Mtuzl
X-Google-Smtp-Source: AGHT+IHC4RF6IquLLXwW07MDoOtMHQgHJ/76ZeeEJ2RUpLRa2wAkmWTwry8y77Zlj9mDjCYihA0xP3KrRQyfY7+3JrQ=
X-Received: by 2002:a05:6000:2c8:b0:38d:ae1e:2f3c with SMTP id
 ffacd0b85a97d-3a08fb72fb0mr456433f8f.25.1745969178549; Tue, 29 Apr 2025
 16:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428081744.52375-1-jiayuan.chen@linux.dev>
In-Reply-To: <20250428081744.52375-1-jiayuan.chen@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Apr 2025 16:26:07 -0700
X-Gm-Features: ATxdqUHUrjmW7ZCF5YfZvI1xRYgrZflpXq2FqWLtacC7lTXq25BXtRtTCial-yU
Message-ID: <CAADnVQLiqHUVZQ7MdqAfnUK+01D5fSt6sDR5nzon83w39ZBohA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] bpf, sockmap: Improve performance with
 CPU affinity
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Jiayuan Chen <mrpre@163.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 1:18=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> Abstract
> =3D=3D=3D
> This patchset improves the performance of sockmap by providing CPU affini=
ty,
> resulting in a 1-10x increase in throughput.
>
>
> Motivation
> =3D=3D=3D
> Traditional user-space reverse proxy:
>
>               Reserve Proxy
>             _________________
> client  -> | fd1  <->  fd2   | -> server
>            |_________________|
>
> Using sockmap for reverse proxy:
>
>               Reserve Proxy
>             _________________
> client ->  |  fd1  <->  fd2  |  -> server
>          | |_________________| |
>          |      |       |      |
>          |      _________      |
>          |     | sockmap |     |
>           -->  |_________|  -->
>
> By adding fds to sockmap and using a BPF program, we can quickly forward
> data and avoid data copying between user space and kernel space.
>
> Mainstream multi-process reverse proxy applications, such as Nginx and
> HAProxy, support CPU affinity settings, which allow each process to be
> pinned to a specific CPU, avoiding conflicts between data plane processes
> and other processes, especially in multi-tenant environments.
>
>
> Current Issues
> =3D=3D=3D
> The current design of sockmap uses a workqueue to forward ingress_skb and
> wakes up the workqueue without specifying a CPU
> (by calling schedule_delayed_work()). In the current implementation of
> schedule_delayed_work, it tends to run the workqueue on the current CPU.
>
> This approach has a high probability of running on the current CPU, which
> is the same CPU that handles the net rx soft interrupt, especially for
> programs that access each other using local interfaces.
>
> The loopback driver's transmit interface, loopback_xmit(), directly calls
> __netif_rx() on the current CPU, which means that the CPU handling
> sockmap's workqueue and the client's sending CPU are the same, resulting
> in contention.
>
> For a TCP flow, if the request or response is very large, the
> psock->ingress_skb queue can become very long. When the workqueue
> traverses this queue to forward the data, it can consume a significant
> amount of CPU time.
>
>
> Solution
> =3D=3D=3D
> Configuring RPS on a loopback interface can be useful, but it will trigge=
r
> additional softirq, and furthermore, it fails to achieve our expected
> effect of CPU isolation from other processes.
>
> Instead, we provide a kfunc that allow users to specify the CPU on which
> the workqueue runs through a BPF program.
>
> We can use the existing benchmark to test the performance, which allows
> us to evaluate the effectiveness of this optimization.
>
> Because we use local interfaces for communication and the client consumes
> a significant amount of CPU when sending data, this prevents the workqueu=
e
> from processing ingress_skb in a timely manner, ultimately causing the
> server to fail to read data quickly.
>
> Without cpu-affinity:
> ./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress --no-verify
> Setting up benchmark 'sockmap'...
> create socket fd c1:14 p1:15 c2:16 p2:17
> Benchmark 'sockmap' started.
> Iter   0 ( 36.031us): Send Speed 1143.693 MB/s ... Rcv Speed  109.572 MB/=
s
> Iter   1 (  0.608us): Send Speed 1320.550 MB/s ... Rcv Speed   48.103 MB/=
s
> Iter   2 ( -5.448us): Send Speed 1314.790 MB/s ... Rcv Speed   47.842 MB/=
s
> Iter   3 ( -0.613us): Send Speed 1320.158 MB/s ... Rcv Speed   46.531 MB/=
s
> Iter   4 ( -3.441us): Send Speed 1319.375 MB/s ... Rcv Speed   46.662 MB/=
s
> Iter   5 (  3.764us): Send Speed 1166.667 MB/s ... Rcv Speed   42.467 MB/=
s
> Iter   6 ( -4.404us): Send Speed 1319.508 MB/s ... Rcv Speed   47.973 MB/=
s
> Summary: total trans     7758 MB =C2=B1 1293.506 MB/s
>
> Without cpu-affinity(RPS enabled):
> ./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress --no-verify
> Setting up benchmark 'sockmap'...
> create socket fd c1:14 p1:15 c2:16 p2:17
> Benchmark 'sockmap' started.
> Iter   0 ( 28.925us): Send Speed 1630.357 MB/s ... Rcv Speed  850.960 MB/=
s
> Iter   1 ( -2.042us): Send Speed 1644.564 MB/s ... Rcv Speed  822.478 MB/=
s
> Iter   2 (  0.754us): Send Speed 1644.297 MB/s ... Rcv Speed  850.787 MB/=
s
> Iter   3 (  0.159us): Send Speed 1644.429 MB/s ... Rcv Speed  850.198 MB/=
s
> Iter   4 ( -2.898us): Send Speed 1646.924 MB/s ... Rcv Speed  830.867 MB/=
s
> Iter   5 ( -0.210us): Send Speed 1649.410 MB/s ... Rcv Speed  824.246 MB/=
s
> Iter   6 ( -1.448us): Send Speed 1650.723 MB/s ... Rcv Speed  808.256 MB/=
s
>
> With cpu-affinity(RPS disabled):
> ./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress --no-verify --cpu-affin=
ity
> Setting up benchmark 'sockmap'...
> create socket fd c1:14 p1:15 c2:16 p2:17
> Benchmark 'sockmap' started.
> Iter   0 ( 36.051us): Send Speed 1883.437 MB/s ... Rcv Speed 1865.087 MB/=
s
> Iter   1 (  1.246us): Send Speed 1900.542 MB/s ... Rcv Speed 1761.737 MB/=
s
> Iter   2 ( -8.595us): Send Speed 1883.128 MB/s ... Rcv Speed 1860.714 MB/=
s
> Iter   3 (  7.033us): Send Speed 1890.831 MB/s ... Rcv Speed 1806.684 MB/=
s
> Iter   4 ( -8.397us): Send Speed 1884.700 MB/s ... Rcv Speed 1973.568 MB/=
s
> Iter   5 ( -1.822us): Send Speed 1894.125 MB/s ... Rcv Speed 1775.046 MB/=
s
> Iter   6 (  4.936us): Send Speed 1877.597 MB/s ... Rcv Speed 1959.320 MB/=
s
> Summary: total trans    11328 MB =C2=B1 1888.507 MB/s

This looks to me like an artificial benchmark.
Surely perf will be higher when wq is executed on free cpu.
In production all cpus likely have work to do, so this whole
approach 'lets ask wq to run on that cpu' isn't going to work.
Looks like RPS helps. Use that. I think it will scale and work
better when the whole server is loaded.

pw-bot: cr

