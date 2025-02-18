Return-Path: <linux-kselftest+bounces-26841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8DCA39619
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 09:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA901886829
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 08:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6EB22F381;
	Tue, 18 Feb 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inZgeTAE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192A122D7BA
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868735; cv=none; b=p/oBF5Lh9EL1pjMNn3ltC/YNcnUqLKXMa5SBWsiFGbCEL52fWCH+UXUSsvHd1nQpseII7xztAzb2iZh9oH6Umy+LLs7FRhS+xuTmdxZ8S8ybnroUNSERfpQmJMSYC6KhQj71AHJRuaFwvrN8ZwJldtgsh/+46ArgntWqSKX4TOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868735; c=relaxed/simple;
	bh=qImDM2Aoz3Snnaan8A7pazPLk5kgxVW4GXVujSQsLH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zjam717uwzKDDd795fnQBcF6Q5Bo32U7odG0OEmnTxmh/3u5aDNb7qNe281wUGzcfcH8ddqJIUmkMjGdwu3/cetizY2f3ws+VxZFigN+vKWZGPUwu/xl0kPw12DBhY0bre4ZMnHazIKDNoWWEknGm/ks70+JXtrdilaeogEmiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inZgeTAE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739868731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/40cidM9GqDVrc7T4DzVHlbImaecKAWNvPg5rw21iA8=;
	b=inZgeTAEkAgB3k+Nq6TemODsnVHFOqFJWDfwqldJeVmF/0zE0abz0PqhwRjlCNbhstr2uk
	rO91FF9yGC3TwPlgucl6c0TMlIDn3eeAgMccBZIU92pbzqItXDgG9uG8gRgQ/mwt0juqce
	C8/hga2CD4sNAs6WB79fionVU0MeMv8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-vnVSsN2COciwQhzc9dY3ug-1; Tue, 18 Feb 2025 03:52:09 -0500
X-MC-Unique: vnVSsN2COciwQhzc9dY3ug-1
X-Mimecast-MFC-AGG-ID: vnVSsN2COciwQhzc9dY3ug_1739868728
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4399304b329so2544215e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 00:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868728; x=1740473528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/40cidM9GqDVrc7T4DzVHlbImaecKAWNvPg5rw21iA8=;
        b=usTt6o+2Lszs4ajYa7xyxlsTQTrUTBzA57BXz0lHXSu1wFcxmuFEF4A5pxQWlVqYM/
         IlRkHvEojOIQPYgdAeV5IhEqx0nbDHhnh2gEYoDd+eZAwX8Ezqs0xavKwmsvSW4bMKk3
         KLdv9SRVMikZbQpj9I/ikLh8GkG1mWcebZcM/QOvKoMWharO7kaLnXEaOqlozcxKsSmY
         /tmlvpttcTlSWy2p8Pl1vwAynKQyG2HVub4nzWEwUvEriOZXWpWVJRiE1Hn1FtDuRdTz
         PftLA4vj7UEVk70wi9xDH73gEKCjcTvr46JOXP9252T3TePR2a5IB+8Kgqn34wqLOm+n
         +7wA==
X-Forwarded-Encrypted: i=1; AJvYcCWy78pGqE0BPDP2lQkrMXfwZSiyPPhxYzU7NjAO3FJCnR/uT92RL2HGbBYGOL7YZI6uY+YJcjvT3+AijrDeKkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2SxFC/DonMNAKoGI/7NFKqUT2/zAMtXyhfHThNws2JKCsIknL
	cuiURf+xsfD62L1eGwWjVJQ6O8PeW2SrqSLBOcEsLpMlk7O/jlDm4J/erVlwhl6NeB3TnUI/xf2
	DYABWWDzR/CZJJyBYFZbrgsZCTxSlFxK8k8/N76hKkO86qAxEtUEYX5CH0kvHFvC1mw==
X-Gm-Gg: ASbGnctGba7SG0aYJXZwhGy0cZDpoB/4kHce2uK43j2M+yE1oxPBDfXVGTSP0RoWyaI
	0L5kShjV8OxB6gZv6kJi3nBtVDhbzG2iiM8sG56Kw8SrpSbhayvQpfLOkuvC4I4Icg6ebUCV2uO
	fgknfzkIvBJrvsnHL+hAdIujzcCf5it/2PgUUc+IsHsOe1prEp0uOyRcbl/bN4Js8SobVAgVRnM
	hChgTNRePFqAO705/5kvqf0D629LML42+lFg167JAK28ORIlz8nUsI7py1rzfFo9E/V2jmQ2Lkb
	ishKs/74quvQ+yqdI3m110rrIm80bhuipPosrssGOFcYEFvTb0cxDg==
X-Received: by 2002:a05:6000:4023:b0:38f:483f:8319 with SMTP id ffacd0b85a97d-38f483f873emr5435467f8f.51.1739868728420;
        Tue, 18 Feb 2025 00:52:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFC8X151MW+xEw5lnrOeLO/RfeyoGSXgW9uEKgZVTfGtKVJttz9myB5BqQJ3iioFx+lN1s7Ag==
X-Received: by 2002:a05:6000:4023:b0:38f:483f:8319 with SMTP id ffacd0b85a97d-38f483f873emr5435418f8f.51.1739868727721;
        Tue, 18 Feb 2025 00:52:07 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d65bcsm14463188f8f.65.2025.02.18.00.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:52:07 -0800 (PST)
Date: Tue, 18 Feb 2025 09:52:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 1/4] sockmap, vsock: For connectible sockets allow
 only connected
Message-ID: <yc5vdkuwpyrr7mfjp6ohqf4fzq4avgjh5pwrmox7rhipwnh7nk@26cyegopbks2>
References: <20250213-vsock-listen-sockmap-nullptr-v1-0-994b7cd2f16b@rbox.co>
 <20250213-vsock-listen-sockmap-nullptr-v1-1-994b7cd2f16b@rbox.co>
 <251be392-7cd5-4c69-bc02-12c794ea18a1@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <251be392-7cd5-4c69-bc02-12c794ea18a1@rbox.co>

On Fri, Feb 14, 2025 at 02:11:48PM +0100, Michal Luczaj wrote:
>> ...
>> Another design detail is that listening vsocks are not supposed to have any
>> transport assigned at all. Which implies they are not supported by the
>> sockmap. But this is complicated by the fact that a socket, before
>> switching to TCP_LISTEN, may have had some transport assigned during a
>> failed connect() attempt. Hence, we may end up with a listening vsock in a
>> sockmap, which blows up quickly:
>>
>> KASAN: null-ptr-deref in range [0x0000000000000120-0x0000000000000127]
>> CPU: 7 UID: 0 PID: 56 Comm: kworker/7:0 Not tainted 6.14.0-rc1+
>> Workqueue: vsock-loopback vsock_loopback_work
>> RIP: 0010:vsock_read_skb+0x4b/0x90
>> Call Trace:
>>  sk_psock_verdict_data_ready+0xa4/0x2e0
>>  virtio_transport_recv_pkt+0x1ca8/0x2acc
>>  vsock_loopback_work+0x27d/0x3f0
>>  process_one_work+0x846/0x1420
>>  worker_thread+0x5b3/0xf80
>>  kthread+0x35a/0x700
>>  ret_from_fork+0x2d/0x70
>>  ret_from_fork_asm+0x1a/0x30
>
>Perhaps I should have expanded more on the null-ptr-deref itself.
>
>The idea is: force a vsock into assigning a transport and add it to the
>sockmap (with a verdict program), but keep it unconnected. Then, drop
>the transport and set the vsock to TCP_LISTEN. The moment a new
>connection is established:
>
>virtio_transport_recv_pkt()
>  virtio_transport_recv_listen()
>    sk->sk_data_ready(sk)            i.e. sk_psock_verdict_data_ready()
>      ops->read_skb()                i.e. vsock_read_skb()
>        vsk->transport->read_skb()   vsk->transport is NULL, boom
>

Yes I agree, it's a little clearer with this, but I think it was also 
clear the concept before. So with or without:

Acked-by: Stefano Garzarella <sgarzare@redhat.com>


>Here's a stand-alone repro:
>
>/*
> * # modprobe -a vsock_loopback vhost_vsock
> * # gcc test.c && ./a.out
> */
>#include <stdio.h>
>#include <stdint.h>
>#include <stdlib.h>
>#include <unistd.h>
>#include <errno.h>
>#include <sys/socket.h>
>#include <sys/syscall.h>
>#include <linux/bpf.h>
>#include <linux/vm_sockets.h>
>
>static void die(const char *msg)
>{
>	perror(msg);
>	exit(-1);
>}
>
>static int sockmap_create(void)
>{
>	union bpf_attr attr = {
>		.map_type = BPF_MAP_TYPE_SOCKMAP,
>		.key_size = sizeof(int),
>		.value_size = sizeof(int),
>		.max_entries = 1
>	};
>	int map;
>
>	map = syscall(SYS_bpf, BPF_MAP_CREATE, &attr, sizeof(attr));
>	if (map < 0)
>		die("map_create");
>
>	return map;
>}
>
>static void map_update_elem(int fd, int key, int value)
>{
>	union bpf_attr attr = {
>		.map_fd = fd,
>		.key = (uint64_t)&key,
>		.value = (uint64_t)&value,
>		.flags = BPF_ANY
>	};
>
>	if (syscall(SYS_bpf, BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr)))
>		die("map_update_elem");
>}
>
>static int prog_load(void)
>{
>	/* mov %r0, 1; exit */
>	struct bpf_insn insns[] = {
>		{ .code = BPF_ALU64 | BPF_MOV | BPF_K, .dst_reg = 0, .imm = 1 },
>		{ .code = BPF_JMP | BPF_EXIT }
>	};
>	union bpf_attr attr = {
>		.prog_type = BPF_PROG_TYPE_SK_SKB,
>		.insn_cnt = sizeof(insns)/sizeof(insns[0]),
>		.insns = (long)insns,
>		.license = (long)"",
>	};
>	
>	int prog = syscall(SYS_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
>	if (prog < 0)
>		die("prog_load");
>
>	return prog;
>}
>
>static void link_create(int prog_fd, int target_fd)
>{
>	union bpf_attr attr = {
>		.link_create = {
>			.prog_fd = prog_fd,
>			.target_fd = target_fd,
>			.attach_type = BPF_SK_SKB_VERDICT
>		}
>	};
>
>	if (syscall(SYS_bpf, BPF_LINK_CREATE, &attr, sizeof(attr)) < 0)
>		die("link_create");
>}
>
>int main(void)
>{
>	struct sockaddr_vm addr = {
>		.svm_family = AF_VSOCK,
>		.svm_cid = VMADDR_CID_LOCAL,
>		.svm_port = VMADDR_PORT_ANY
>	};
>	socklen_t alen = sizeof(addr);
>	int s, map, prog, c;
>
>	s = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
>	if (s < 0)
>		die("socket");
>
>	if (bind(s, (struct sockaddr *)&addr, alen))
>		die("bind");
>
>	if (!connect(s, (struct sockaddr *)&addr, alen) || errno != ECONNRESET)
>		die("connect #1");
>
>	map = sockmap_create();
>	prog = prog_load();
>	link_create(prog, map);
>	map_update_elem(map, 0, s);
>
>	addr.svm_cid = 0x42424242; /* non-existing */
>	if (!connect(s, (struct sockaddr *)&addr, alen) || errno != ESOCKTNOSUPPORT)
>		die("connect #2");
>
>	if (listen(s, 1))
>		die("listen");
>
>	if (getsockname(s, (struct sockaddr *)&addr, &alen))
>		die("getsockname");
>
>	c = socket(AF_VSOCK, SOCK_SEQPACKET, 0);
>	if (c < 0)
>		die("socket c");
>
>	if (connect(c, (struct sockaddr *)&addr, alen))
>		die("connect #3");
>
>	return 0;
>}
>


