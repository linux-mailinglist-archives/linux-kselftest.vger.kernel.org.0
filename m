Return-Path: <linux-kselftest+bounces-29423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5454FA687B5
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 10:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A8317E6D6
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECCB251786;
	Wed, 19 Mar 2025 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZoyM8FRV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9471DDC34
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375848; cv=none; b=W33zxy0t9W5yulqm0dVMhsnJ/MWXH9o/TxdMG4aEfvwqo/z/kQQpPy1mIz7ZLR/jImL/rA2XD0dY6gunPc7gyqzQA8dAbmWYfYTtXLXvz6WU7RVSbO0UJSDKicNLMfTIsAXQXcXn4mbUE5ebsOdoGTSOA808Hp6JKJLkoIIpIQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375848; c=relaxed/simple;
	bh=NzMd+cZZ4AuMOKsWgqjQ2wWoCskTOv5VZM4sRUzG9xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlHGRpB5q6dpG3waDeyI6KtuIhiAx038rnSDAyMOpGK36UM0Dzm4HLcnKC/QGXK4wob6cNBXRFOe5up9Qo9554+SXuC0HfyLGVhSR8/aZ4Fy14vFDUGY9Fd1cFZUKN1yPSfexYcngb2PX78c0Rjfm3O7FBIg1qqcwhUaeeGCYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZoyM8FRV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742375845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GpuGE8jwydSTtf5vqaCaaq5V296av9hmHXy0jgwtvI0=;
	b=ZoyM8FRVYuajEwEGxqEzAjZaodUVX/2ZT2baz2aTlp/DGwwjo4/B12SJUcXYevXjFOsFl+
	ih9FJCsGhWXvMh/+WN/qjAGs7nkjgTPFYOcxF6A6MBKtOlwvnfk6pLd9VAmXaxyR/Nr9Fz
	08VoNZtw9Qc8Nusq7m6kiJ88f+d20cs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-Wvvl8V4IN3-sdPSuGDCzRA-1; Wed, 19 Mar 2025 05:17:24 -0400
X-MC-Unique: Wvvl8V4IN3-sdPSuGDCzRA-1
X-Mimecast-MFC-AGG-ID: Wvvl8V4IN3-sdPSuGDCzRA_1742375843
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d01024089so34245565e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 02:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742375843; x=1742980643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpuGE8jwydSTtf5vqaCaaq5V296av9hmHXy0jgwtvI0=;
        b=pS+artDohmFkJokfhl+LbUszU/dYPVHZVghafjOPvQj6/TxktOPLluiVs0QAyrQFTq
         fBwAA/73DYJELoSiSusfX75UBakI9F5PSxugbgPXHNkjly5GfG8aKhQNpjUuWu92JMcn
         w1FzPcdxWiPXm05aRx8LBLuUkfUsezPHVRdIp2kmNykL8thNyDV9q/JKVG/UOem5wzAm
         bFDgnO8KumiUcLr39YhWFVXA1gBGoiOlvUHeMeBgWC+LWr0Caw8CFuh38TN2xBhLLYAg
         pxbzbEa0Tdip961xo9n/yAf+6avI5Nlvp2HkHsxJdfNUFGaPDI3hhHd+dkNRtsf6UJkK
         fSYA==
X-Forwarded-Encrypted: i=1; AJvYcCUYJc0+s4U5SOy2OaiLSVtbof83PO16vRL+TnI8YOqGl9R2XT5Fk/3kHW25DkCFYkKPJRJzcpNhfIYd77yBLEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn99/KMhRaZhJRQGM2fsM6dxda8NFbtecT2Vl4YkaieQbKt6dY
	zuc5D6x1MvnRIKF3wxAO4jNxMeuaEBlU2woALkUo/Mv+tUmYCB/1uCPMvhOsXJ4G0MRUCoY7seP
	WneDFfEguRXieLhXLAzLjyGBQdgzFH0LIirbRV/0iXQYOZh972VPH5CF6W2nEYgGDzg==
X-Gm-Gg: ASbGncupULpIUfY1V+XDhq9WnBamQsA7TUxNe4nxZor6WsVs+0YlepZKe8WeGdmdiHj
	1wCmKEP4sEORCNZTuwR19SVtNrycTDxVRp9zBNStsR9aAIx3sqkxeM7HHBpqeO7Ds6Mp/cA3BOi
	aKzqfePEJWep92wdS0H06qbAjf4n8ElTBH/dwFHompAagD+38OtLqA1J+rHliJuCyJTIKXX9oCK
	j8fCFAK7GvFW5PtaGUhVdTPnpTubpYl3P96WyoTWBY+pVF8+rY2OI0JC3vKeyCqczfKTuLEyv2y
	Gu7GWSjtTmyvcL3pAl95U5vDnr7NVIfFHfgjrDkMYxoQvUfawKYrz1YrKY06Ig==
X-Received: by 2002:a05:600c:3845:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-43d438a66afmr15766625e9.29.1742375843191;
        Wed, 19 Mar 2025 02:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4AK1/6C4o6ihOcsyzkBG0ZkSaNoGqJBe8vr/NeUglQARpjCQ9rSgLBRWhjQdmkOJ/XhVmJg==
X-Received: by 2002:a05:600c:3845:b0:43c:f969:13c0 with SMTP id 5b1f17b1804b1-43d438a66afmr15766005e9.29.1742375842419;
        Wed, 19 Mar 2025 02:17:22 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-53.retail.telecomitalia.it. [79.53.30.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4743dd13sm2275855e9.1.2025.03.19.02.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:17:21 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:17:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 2/3] selftest/bpf: Add test for AF_VSOCK connect()
 racing sockmap update
Message-ID: <hlfjllms6ih53rdw45apgajek6fp4ljnfxlwkr2efyqcuf6fqo@rj6yjmj4fjem>
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
 <20250317-vsock-trans-signal-race-v4-2-fc8837f3f1d4@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250317-vsock-trans-signal-race-v4-2-fc8837f3f1d4@rbox.co>

On Mon, Mar 17, 2025 at 10:52:24AM +0100, Michal Luczaj wrote:
>Racing signal-interrupted connect() and sockmap update may result in an
>unconnected (and missing vsock transport) socket in a sockmap.
>
>Test spends 2 seconds attempting to reach WARN_ON_ONCE().
>
>connect
>  / state = SS_CONNECTED /
>                                sock_map_update_elem
>  if signal_pending
>    state = SS_UNCONNECTED
>
>connect
>  transport = NULL
>                                vsock_bpf_recvmsg
>                                  WARN_ON_ONCE(!vsk->transport)
>
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> .../selftests/bpf/prog_tests/sockmap_basic.c       | 99 ++++++++++++++++++++++
> 1 file changed, 99 insertions(+)

LGTM for the vsock part!

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>index 1e3e4392dcca0e1722c1982ecc649a80c27443b2..2f8bba27866354848f1e30b5473cedb6a85244ff 100644
>--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
>@@ -3,6 +3,7 @@
> #include <error.h>
> #include <netinet/tcp.h>
> #include <sys/epoll.h>
>+#include <linux/time64.h>
>
> #include "test_progs.h"
> #include "test_skmsg_load_helpers.skel.h"
>@@ -1042,6 +1043,102 @@ static void test_sockmap_vsock_unconnected(void)
> 	xclose(map);
> }
>
>+#define CONNECT_SIGNAL_RACE_TIMEOUT 2 /* seconds */
>+
>+static void sig_handler(int signum)
>+{
>+	/* nop */
>+}
>+
>+static void connect_signal_racer_cleanup(void *map)
>+{
>+	xclose(*(int *)map);
>+}
>+
>+static void *connect_signal_racer(void *arg)
>+{
>+	pid_t pid;
>+	int map;
>+
>+	map = bpf_map_create(BPF_MAP_TYPE_SOCKMAP, NULL, sizeof(int),
>+			     sizeof(int), 1, NULL);
>+	if (!ASSERT_OK_FD(map, "bpf_map_create"))
>+		return NULL;
>+
>+	pthread_cleanup_push(connect_signal_racer_cleanup, &map);
>+	pid = getpid();
>+
>+	for (;;) {
>+		int c = *(int *)arg;
>+		int zero = 0;
>+
>+		(void)bpf_map_update_elem(map, &zero, &c, BPF_ANY);
>+
>+		if (kill(pid, SIGUSR1)) {
>+			FAIL_ERRNO("kill");
>+			break;
>+		}
>+
>+		if ((recv(c, NULL, 0, MSG_DONTWAIT) < 0) && errno == ENODEV) {
>+			FAIL_ERRNO("recv");
>+			break;
>+		}
>+	}
>+
>+	pthread_cleanup_pop(1);
>+
>+	return NULL;
>+}
>+
>+static void test_sockmap_vsock_connect_signal_race(void)
>+{
>+	struct sockaddr_vm addr, bad_addr;
>+	socklen_t alen = sizeof(addr);
>+	sighandler_t orig_handler;
>+	pthread_t thread;
>+	int s, c, p;
>+	__u64 tout;
>+
>+	orig_handler = signal(SIGUSR1, sig_handler);
>+	if (!ASSERT_NEQ(orig_handler, SIG_ERR, "signal handler setup"))
>+		return;
>+
>+	s = socket_loopback(AF_VSOCK, SOCK_SEQPACKET | SOCK_NONBLOCK);
>+	if (s < 0)
>+		goto restore;
>+
>+	if (xgetsockname(s, (struct sockaddr *)&addr, &alen))
>+		goto close;
>+
>+	bad_addr = addr;
>+	bad_addr.svm_cid = 0x42424242; /* non-existing */
>+
>+	if (xpthread_create(&thread, 0, connect_signal_racer, &c))
>+		goto close;
>+
>+	tout = get_time_ns() + CONNECT_SIGNAL_RACE_TIMEOUT * NSEC_PER_SEC;
>+	do {
>+		c = xsocket(AF_VSOCK, SOCK_SEQPACKET, 0);
>+		if (c < 0)
>+			break;
>+
>+		if (connect(c, (struct sockaddr *)&addr, alen) && errno == EINTR)
>+			(void)connect(c, (struct sockaddr *)&bad_addr, alen);
>+
>+		xclose(c);
>+		p = accept(s, NULL, NULL);
>+		if (p >= 0)
>+			xclose(p);
>+	} while (get_time_ns() < tout);
>+
>+	ASSERT_OK(pthread_cancel(thread), "pthread_cancel");
>+	xpthread_join(thread, NULL);
>+close:
>+	xclose(s);
>+restore:
>+	ASSERT_NEQ(signal(SIGUSR1, orig_handler), SIG_ERR, "handler restore");
>+}
>+
> void test_sockmap_basic(void)
> {
> 	if (test__start_subtest("sockmap create_update_free"))
>@@ -1108,4 +1205,6 @@ void test_sockmap_basic(void)
> 		test_sockmap_skb_verdict_vsock_poll();
> 	if (test__start_subtest("sockmap vsock unconnected"))
> 		test_sockmap_vsock_unconnected();
>+	if (test__start_subtest("sockmap vsock connect signal race"))
>+		test_sockmap_vsock_connect_signal_race();
> }
>
>-- 
>2.48.1
>


