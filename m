Return-Path: <linux-kselftest+bounces-31756-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B262CA9EA77
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 10:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E642C189C6EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 08:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38F120D4E9;
	Mon, 28 Apr 2025 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XLXd+Bzg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD14818DB35
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745828294; cv=none; b=KD4E8eSzZ2yGpuDiKSyUb85eZQElWVyLCpAkmz2eCErMW0U9CYvOEdtGoecTP41B6zwYl8STnxLwLwMe7vtHZ1yceYWTsmL3MTxkDYeu01/Jjqqn9juHAGBkJxTM343gr4PyH2JJYKL6nxuezI4NQdjit9pnCtQHWNsRdK2F+70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745828294; c=relaxed/simple;
	bh=5MTSD89uQLdxjOEDGtXfl6lZjRZyJgPaZgvbDOijRMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AfDtf2Kmuz3Ftv8Hrfd5pRu02Q9hLLIfm54w5b9uTicHEc4xB2cgn85bjIx1Nbw/OFnj4A5Cz4mL3NQ519raBjO5Yuf9r3NKIoJlX/bxkVdt+tBq+rUaR2uwv+DFhqpizI8v+gO/ot/MmYrRowFYkUCb2Zac5SCA937mw5HyQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XLXd+Bzg; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745828280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zT6mOl0s4GCyENEa7GwphEh7NFPUZucu05UFLnp5u20=;
	b=XLXd+BzgGwZWzqC4NrSvNdilihWJmLSJvnIwaG7PtmMLU8kq9oWV1hmniFuqslGUpQS6LP
	ycoXbrc9s5XTHqgo4n5v3BxQtSyDSNO9dQ/i/KtkHfhvTxdgkAZJlMUigXDXYuwGr/1gF4
	nDE1YTkTuz2KTmzVLPTbcljqUehaZBg=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v1 0/3] bpf, sockmap: Improve performance with CPU affinity
Date: Mon, 28 Apr 2025 16:16:51 +0800
Message-ID: <20250428081744.52375-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Abstract
===
This patchset improves the performance of sockmap by providing CPU affinity,
resulting in a 1-10x increase in throughput.


Motivation
===
Traditional user-space reverse proxy:

              Reserve Proxy
            _________________
client  -> | fd1  <->  fd2   | -> server
           |_________________|

Using sockmap for reverse proxy:

              Reserve Proxy
            _________________
client ->  |  fd1  <->  fd2  |  -> server
         | |_________________| |
         |      |       |      |
         |      _________      |
         |     | sockmap |     |
          -->  |_________|  -->

By adding fds to sockmap and using a BPF program, we can quickly forward
data and avoid data copying between user space and kernel space.

Mainstream multi-process reverse proxy applications, such as Nginx and
HAProxy, support CPU affinity settings, which allow each process to be
pinned to a specific CPU, avoiding conflicts between data plane processes
and other processes, especially in multi-tenant environments.


Current Issues
===
The current design of sockmap uses a workqueue to forward ingress_skb and
wakes up the workqueue without specifying a CPU
(by calling schedule_delayed_work()). In the current implementation of
schedule_delayed_work, it tends to run the workqueue on the current CPU.

This approach has a high probability of running on the current CPU, which
is the same CPU that handles the net rx soft interrupt, especially for
programs that access each other using local interfaces.

The loopback driver's transmit interface, loopback_xmit(), directly calls
__netif_rx() on the current CPU, which means that the CPU handling
sockmap's workqueue and the client's sending CPU are the same, resulting
in contention.

For a TCP flow, if the request or response is very large, the
psock->ingress_skb queue can become very long. When the workqueue
traverses this queue to forward the data, it can consume a significant
amount of CPU time.


Solution
===
Configuring RPS on a loopback interface can be useful, but it will trigger
additional softirq, and furthermore, it fails to achieve our expected
effect of CPU isolation from other processes.

Instead, we provide a kfunc that allow users to specify the CPU on which
the workqueue runs through a BPF program.

We can use the existing benchmark to test the performance, which allows
us to evaluate the effectiveness of this optimization.

Because we use local interfaces for communication and the client consumes
a significant amount of CPU when sending data, this prevents the workqueue
from processing ingress_skb in a timely manner, ultimately causing the
server to fail to read data quickly.

Without cpu-affinity:
./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress --no-verify
Setting up benchmark 'sockmap'...
create socket fd c1:14 p1:15 c2:16 p2:17
Benchmark 'sockmap' started.
Iter   0 ( 36.031us): Send Speed 1143.693 MB/s ... Rcv Speed  109.572 MB/s
Iter   1 (  0.608us): Send Speed 1320.550 MB/s ... Rcv Speed   48.103 MB/s
Iter   2 ( -5.448us): Send Speed 1314.790 MB/s ... Rcv Speed   47.842 MB/s
Iter   3 ( -0.613us): Send Speed 1320.158 MB/s ... Rcv Speed   46.531 MB/s
Iter   4 ( -3.441us): Send Speed 1319.375 MB/s ... Rcv Speed   46.662 MB/s
Iter   5 (  3.764us): Send Speed 1166.667 MB/s ... Rcv Speed   42.467 MB/s
Iter   6 ( -4.404us): Send Speed 1319.508 MB/s ... Rcv Speed   47.973 MB/s
Summary: total trans     7758 MB ± 1293.506 MB/s

Without cpu-affinity(RPS enabled):
./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress --no-verify
Setting up benchmark 'sockmap'...
create socket fd c1:14 p1:15 c2:16 p2:17
Benchmark 'sockmap' started.
Iter   0 ( 28.925us): Send Speed 1630.357 MB/s ... Rcv Speed  850.960 MB/s
Iter   1 ( -2.042us): Send Speed 1644.564 MB/s ... Rcv Speed  822.478 MB/s
Iter   2 (  0.754us): Send Speed 1644.297 MB/s ... Rcv Speed  850.787 MB/s
Iter   3 (  0.159us): Send Speed 1644.429 MB/s ... Rcv Speed  850.198 MB/s
Iter   4 ( -2.898us): Send Speed 1646.924 MB/s ... Rcv Speed  830.867 MB/s
Iter   5 ( -0.210us): Send Speed 1649.410 MB/s ... Rcv Speed  824.246 MB/s
Iter   6 ( -1.448us): Send Speed 1650.723 MB/s ... Rcv Speed  808.256 MB/s

With cpu-affinity(RPS disabled):
./bench sockmap -c 2 -p 1 -a --rx-verdict-ingress --no-verify --cpu-affinity
Setting up benchmark 'sockmap'...
create socket fd c1:14 p1:15 c2:16 p2:17
Benchmark 'sockmap' started.
Iter   0 ( 36.051us): Send Speed 1883.437 MB/s ... Rcv Speed 1865.087 MB/s
Iter   1 (  1.246us): Send Speed 1900.542 MB/s ... Rcv Speed 1761.737 MB/s
Iter   2 ( -8.595us): Send Speed 1883.128 MB/s ... Rcv Speed 1860.714 MB/s
Iter   3 (  7.033us): Send Speed 1890.831 MB/s ... Rcv Speed 1806.684 MB/s
Iter   4 ( -8.397us): Send Speed 1884.700 MB/s ... Rcv Speed 1973.568 MB/s
Iter   5 ( -1.822us): Send Speed 1894.125 MB/s ... Rcv Speed 1775.046 MB/s
Iter   6 (  4.936us): Send Speed 1877.597 MB/s ... Rcv Speed 1959.320 MB/s
Summary: total trans    11328 MB ± 1888.507 MB/s


Appendix
===
Through this optimization, we discovered that sk_mem_charge()
and sk_mem_uncharge() have concurrency issues. The performance improvement
brought by this optimization has made these concurrency issues more
evident.

This concurrency issue can cause the WARN_ON_ONCE(sk->sk_forward_alloc)
check to be triggered when the socket is released. Since this patch is a
feature-type patch and does not intend to fix this bug, I will provide
additional patches to fix this issue later.

Jiayuan Chen (3):
  bpf, sockmap: Introduce a new kfunc for sockmap
  bpf, sockmap: Affinitize workqueue to a specific CPU
  selftest/bpf/benchs: Add cpu-affinity for sockmap bench

 Documentation/bpf/map_sockmap.rst             | 14 +++++++
 include/linux/skmsg.h                         | 15 +++++++
 kernel/bpf/btf.c                              |  3 ++
 net/core/skmsg.c                              | 10 +++--
 net/core/sock_map.c                           | 39 +++++++++++++++++++
 .../selftests/bpf/benchs/bench_sockmap.c      | 35 +++++++++++++++--
 tools/testing/selftests/bpf/bpf_kfuncs.h      |  6 +++
 .../selftests/bpf/progs/bench_sockmap_prog.c  |  7 ++++
 8 files changed, 122 insertions(+), 7 deletions(-)

-- 
2.47.1


