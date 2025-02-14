Return-Path: <linux-kselftest+bounces-26650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D153EA35EAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 14:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C95671897231
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 13:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCCA2641FC;
	Fri, 14 Feb 2025 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="eINETwg9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ECD23A992;
	Fri, 14 Feb 2025 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739538749; cv=none; b=tTRTWuBHrBsdZA4Iwm8m/2N3NInNBZr+ZKv5cuFyY931RoeLPnFfhGvqRF/kUX+srXpJj/qB0uYHuqrLDbapfkz8XQdgCxYK3573bL1hVgzhz3Z1HG5b9umlQptolMKzYCxwmr08G8g/Td+RlIAzkdVmhQdog2BbroVdMptnUk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739538749; c=relaxed/simple;
	bh=XIXVUyGiBY4A+dcS7TuTQ6R3Me5Pk5BILkImVMByb9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SL9psGIwgM2pkPDlnAodIPuWwWsRWaadWQ7SYcxP/8SplWu5Gdfi3a3WIEkNgacYhXbb/1OAOitP7t8GnMQf1skV6y7q6UVwjZ0OHJN4xuKFkbZv2hTQBIJOIJ9N8vwksTF0dUAQWsWUbv//Amq2ANCJ3WEGRPC5oz6v+jJqgdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=eINETwg9; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tivUB-005LuS-R9; Fri, 14 Feb 2025 14:12:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=7RKjrxSTjs2wxXMFts5+FNyeheo3/5tiUUsZ7FW5jK4=; b=eINETwg92U0S+n8qS4eibxE9fW
	Im2OTWqbq4lh7uZDHwqsnwK9VuGyA2ilWH2udCSKWsVlGsoJegkEkntsXU7BSiPJG/S11LEO7oDM1
	FN8gAlmTQPQedoMtztuuaZJEthsiTJ3hNAtleq+iS6bNt5LBI6lbkmUEMhGLgm0ZlDZHtt4omC63G
	LM7uwgGl/Rebj7z2bY74+rDOcZEygNfQGt0Jf9V1WxyKr8bsa7mcZABikeWHawL4yLV5dhH7CjKSC
	jUatECLWksTRgE9kDGo3Dwz6aNK7sdIRoBBr/TIVSiXLF/O7VF3TYAnpAr5Wd4a33pKl6qCLbLLwO
	rS3N5T5Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tivU0-0008VT-FI; Fri, 14 Feb 2025 14:11:52 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tivTy-00DGzu-KW; Fri, 14 Feb 2025 14:11:50 +0100
Message-ID: <251be392-7cd5-4c69-bc02-12c794ea18a1@rbox.co>
Date: Fri, 14 Feb 2025 14:11:48 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] sockmap, vsock: For connectible sockets allow
 only connected
To: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
 <20250213-vsock-listen-sockmap-nullptr-v1-1-994b7cd2f16b@rbox.co>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <20250213-vsock-listen-sockmap-nullptr-v1-1-994b7cd2f16b@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> ...
> Another design detail is that listening vsocks are not supposed to have any
> transport assigned at all. Which implies they are not supported by the
> sockmap. But this is complicated by the fact that a socket, before
> switching to TCP_LISTEN, may have had some transport assigned during a
> failed connect() attempt. Hence, we may end up with a listening vsock in a
> sockmap, which blows up quickly:
> 
> KASAN: null-ptr-deref in range [0x0000000000000120-0x0000000000000127]
> CPU: 7 UID: 0 PID: 56 Comm: kworker/7:0 Not tainted 6.14.0-rc1+
> Workqueue: vsock-loopback vsock_loopback_work
> RIP: 0010:vsock_read_skb+0x4b/0x90
> Call Trace:
>  sk_psock_verdict_data_ready+0xa4/0x2e0
>  virtio_transport_recv_pkt+0x1ca8/0x2acc
>  vsock_loopback_work+0x27d/0x3f0
>  process_one_work+0x846/0x1420
>  worker_thread+0x5b3/0xf80
>  kthread+0x35a/0x700
>  ret_from_fork+0x2d/0x70
>  ret_from_fork_asm+0x1a/0x30

Perhaps I should have expanded more on the null-ptr-deref itself.

The idea is: force a vsock into assigning a transport and add it to the
sockmap (with a verdict program), but keep it unconnected. Then, drop
the transport and set the vsock to TCP_LISTEN. The moment a new
connection is established:

virtio_transport_recv_pkt()
  virtio_transport_recv_listen()
    sk->sk_data_ready(sk)            i.e. sk_psock_verdict_data_ready()
      ops->read_skb()                i.e. vsock_read_skb()
        vsk->transport->read_skb()   vsk->transport is NULL, boom

Here's a stand-alone repro:

/*
 * # modprobe -a vsock_loopback vhost_vsock
 * # gcc test.c && ./a.out
 */
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <linux/bpf.h>
#include <linux/vm_sockets.h>

static void die(const char *msg)
{
	perror(msg);
	exit(-1);
}

static int sockmap_create(void)
{
	union bpf_attr attr = {
		.map_type = BPF_MAP_TYPE_SOCKMAP,
		.key_size = sizeof(int),
		.value_size = sizeof(int),
		.max_entries = 1
	};
	int map;

	map = syscall(SYS_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
	if (map < 0)
		die("map_create");

	return map;
}

static void map_update_elem(int fd, int key, int value)
{
	union bpf_attr attr = {
		.map_fd = fd,
		.key = (uint64_t)&key,
		.value = (uint64_t)&value,
		.flags = BPF_ANY
	};

	if (syscall(SYS_bpf, BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr)))
		die("map_update_elem");
}

static int prog_load(void)
{
	/* mov %r0, 1; exit */
	struct bpf_insn insns[] = {
		{ .code = BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg = 0, .imm = 1 },
		{ .code = BPF_JMP | BPF_EXIT }
	};
	union bpf_attr attr = {
		.prog_type = BPF_PROG_TYPE_SK_SKB,
		.insn_cnt = sizeof(insns)/sizeof(insns[0]),
		.insns = (long)insns,
		.license = (long)"",
	};
	
	int prog = syscall(SYS_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
	if (prog < 0)
		die("prog_load");

	return prog;
}

static void link_create(int prog_fd, int target_fd)
{
	union bpf_attr attr = {
		.link_create = {
			.prog_fd = prog_fd,
			.target_fd = target_fd,
			.attach_type = BPF_SK_SKB_VERDICT
		}
	};

	if (syscall(SYS_bpf, BPF_LINK_CREATE, &attr, sizeof(attr)) < 0)
		die("link_create");
}

int main(void)
{
	struct sockaddr_vm addr = {
		.svm_family = AF_VSOCK,
		.svm_cid = VMADDR_CID_LOCAL,
		.svm_port = VMADDR_PORT_ANY
	};
	socklen_t alen = sizeof(addr);
	int s, map, prog, c;

	s = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
	if (s < 0)
		die("socket");

	if (bind(s, (struct sockaddr *)&addr, alen))
		die("bind");

	if (!connect(s, (struct sockaddr *)&addr, alen) || errno != ECONNRESET)
		die("connect #1");

	map = sockmap_create();
	prog = prog_load();
	link_create(prog, map);
	map_update_elem(map, 0, s);

	addr.svm_cid = 0x42424242; /* non-existing */
	if (!connect(s, (struct sockaddr *)&addr, alen) || errno != ESOCKTNOSUPPORT)
		die("connect #2");

	if (listen(s, 1))
		die("listen");

	if (getsockname(s, (struct sockaddr *)&addr, &alen))
		die("getsockname");

	c = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
	if (c < 0)
		die("socket c");

	if (connect(c, (struct sockaddr *)&addr, alen))
		die("connect #3");

	return 0;
}


