Return-Path: <linux-kselftest+bounces-7827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E158A3425
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F05B1F22A1F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 16:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747014E2EA;
	Fri, 12 Apr 2024 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3GvI9g+h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE20E14D701
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940778; cv=none; b=algqqANhbimOSLqVQv22BVtH6LmyJgKUhaR88RP0HQmmdbbWLoQAbOY83R7BUlIQX9Otssrdms51ZU6Ad2oCyBGuAV+J4qRJQV2LHn70yICF/jYoF8ZH6GQfvpEmGc39YctlDzYnkGv8QVEyJGTWGj3/RPDVirjUnsHf54hSjAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940778; c=relaxed/simple;
	bh=+WVEUy1Ek4cdfvZCpbqwqbLnPDe5YHNpESVuBAyilzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OyahdbXOd42Wc9PSJ5DOG1WOoAduFzJ127fS8uTx8WhE1tyXid09JcuKFyebmk7b5L71awbvMBxu4IUD+2spIkqoVpzRa/tGRfLqbpj0dAdPZpoyIGor9ujZ1cVbrOYe/QXXESqansBu2cM485dXXVGPE5yh/Lj7xoFdAbKkx5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3GvI9g+h; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so119317639f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712940775; x=1713545575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LckglVSYUWBQoiIhTCKOGb+dY61meuimDlAWaXqXllA=;
        b=3GvI9g+hJTq3cgroT65XiRFiG5Sk8Z2o5+hcuMRHJi42tfjlVWEfdkxJwD1zVoo7Ju
         +yJfS0sq4JLFTRzGqINxIhsvlgex/6jCj+uEpmOyB029tuXzARK1hD8EbG6itsryLVEg
         960Ff+6vYqAyNFMUG+iY90YgF0tXQDw8/J/auL+ePvhfBoPtsn7jm+K7lLHDRs4W/8Kv
         A/VuwwtT+GC+5MoQuQoY+KckbBG9EDaUvfl+dHkNR3jiYET7rogJcxJctPnsfIxafF2a
         oGROid+0lVQlWrfoWfydsGSxSq5imO5CdzR9NR5GVyDZsOYoUbxc5aybQMj1OEe2Riyk
         r/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712940775; x=1713545575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LckglVSYUWBQoiIhTCKOGb+dY61meuimDlAWaXqXllA=;
        b=n2+85SSMhIf12n2vlKPlEqgghb+bf24fpzpS+T3Hf/or5yXdbompBSe4nFdzOuWKDt
         oc1u/BSO5ZAIswWFNdDm7rN0pwUhsWNwB4d97rmPiTePmNnJWOvLL9huL1VWDMI13Yib
         ylZSSQhbXNOpHuLDnWeeztpNOmWIgatHdyWk897vbzpUrmQ4HJF3RZUUqyYMvgdGw5om
         wX9RpiF9FsYP/jibLxdyQpHOpJPJm99IsNbENheEnEHzqSXvhdVicPhdMwhd1yuWnqCw
         QoSnMdB9Sexaz9kKxXwFKtSFp3jeOS/jxNPzEEwTrG3nBxbJOMvGf/BffvtBRplYp2va
         4yWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoYEpfdF+AI2I5XUo3zzIUZO11Ytz0mypg/ZZs5aG7chHnvO2Je91+40naNs0UIkYtsUa61mXYuHGsZ0Xa60LauLcqnNv0rscZk1KwaWEP
X-Gm-Message-State: AOJu0YyyIRJd/U/Xmma8x4lUlXuHxNROeP9J4UMIT/UdN5/wlcQii63K
	tuIqfYx2A3pghuu9so/uTn34PrdxipDqpa4OBV8Xu3D9tAfNpdssPl7Kd1BTn0TruUZ1dZWcXA=
	=
X-Google-Smtp-Source: AGHT+IET2OF46HhXVM6vaqhEKeDYnBxcTDgSbKRxM6NAnUzrnxPgJfqh2xUL8HpGsSa9JSQWPwMdXISvAQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6602:14d5:b0:7d6:680:4c27 with SMTP id
 b21-20020a05660214d500b007d606804c27mr107891iow.4.1712940775155; Fri, 12 Apr
 2024 09:52:55 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:52:27 -0500
In-Reply-To: <20240412165230.2009746-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240412165230.2009746-7-jrife@google.com>
Subject: [PATCH v2 bpf-next 6/6] selftests/bpf: Add kernel socket operation tests
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This patch creates two sets of sock_ops that call out to the SYSCALL
hooks in the sock_addr_kern BPF program and uses them to construct
test cases for the range of supported operations (kernel_connect(),
kernel_bind(), kernel_sendms(), sock_sendmsg(), kernel_getsockname(),
kenel_getpeername()). This ensures that these interact with BPF sockaddr
hooks as intended.

Beyond this it also ensures that these operations do not modify their
address parameter, providing regression coverage for the issues
addressed by this set of patches:

- commit 0bdf399342c5("net: Avoid address overwrite in kernel_connect")
- commit 86a7e0b69bd5("net: prevent rewrite of msg_name in sock_sendmsg()")
- commit c889a99a21bf("net: prevent address rewrite in kernel_bind()")
- commit 01b2885d9415("net: Save and restore msg_namelen in sock_sendmsg")

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 474 ++++++++++++++++++
 1 file changed, 474 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 78bcc147f09c4..621df9b593ec8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -3,6 +3,7 @@
 
 #include "test_progs.h"
 
+#include "sock_addr_kern.skel.h"
 #include "bind4_prog.skel.h"
 #include "bind6_prog.skel.h"
 #include "connect_unix_prog.skel.h"
@@ -53,6 +54,218 @@ enum sock_addr_test_type {
 typedef void *(*load_fn)(int cgroup_fd);
 typedef void (*destroy_fn)(void *skel);
 
+static int cmp_addr(const struct sockaddr_storage *addr1, socklen_t addr1_len,
+		    const struct sockaddr_storage *addr2, socklen_t addr2_len,
+		    bool cmp_port);
+
+struct init_sock_args {
+	int af;
+	int type;
+};
+
+struct addr_args {
+	char addr[sizeof(struct sockaddr_storage)];
+	int addrlen;
+};
+
+struct sendmsg_args {
+	struct addr_args addr;
+	char msg[10];
+	int msglen;
+};
+
+static struct sock_addr_kern *skel;
+
+static int run_bpf_prog(const char *prog_name, void *ctx, int ctx_size)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	struct bpf_program *prog;
+	int prog_fd, err;
+
+	topts.ctx_in = ctx;
+	topts.ctx_size_in = ctx_size;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto err;
+
+	prog_fd = bpf_program__fd(prog);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	if (!ASSERT_OK(err, prog_name))
+		goto err;
+
+	err = topts.retval;
+	goto out;
+err:
+	err = -1;
+out:
+	return err;
+}
+
+static int kernel_init_sock(int af, int type, int protocol)
+{
+	struct init_sock_args args = {
+		.af = af,
+		.type = type,
+	};
+
+	return run_bpf_prog("init_sock", &args, sizeof(args));
+}
+
+static int kernel_close_sock(int fd)
+{
+	return run_bpf_prog("close_sock", NULL, 0);
+}
+
+static int sock_addr_op(const char *name, struct sockaddr *addr,
+			socklen_t *addrlen, bool expect_change)
+{
+	struct addr_args args;
+	int err;
+
+	if (addrlen)
+		args.addrlen = *addrlen;
+
+	if (addr)
+		memcpy(&args.addr, addr, *addrlen);
+
+	err = run_bpf_prog(name, &args, sizeof(args));
+
+	if (!expect_change && addr)
+		if (!ASSERT_EQ(cmp_addr((struct sockaddr_storage *)addr,
+					*addrlen,
+					(struct sockaddr_storage *)&args.addr,
+					args.addrlen, 1),
+			       0, "address_param_modified"))
+			return -1;
+
+	if (addrlen)
+		*addrlen = args.addrlen;
+
+	if (addr)
+		memcpy(addr, &args.addr, *addrlen);
+
+	return err;
+}
+
+static int send_msg_op(const char *name, struct sockaddr *addr,
+		       socklen_t addrlen, const char *msg, int msglen,
+		       bool expect_change)
+{
+	struct sendmsg_args args;
+	int err;
+
+	memset(&args, 0, sizeof(args));
+	memcpy(&args.addr.addr, addr, addrlen);
+	args.addr.addrlen = addrlen;
+	memcpy(args.msg, msg, msglen);
+	args.msglen = msglen;
+
+	err = run_bpf_prog(name, &args, sizeof(args));
+
+	if (!expect_change && addr)
+		if (!ASSERT_EQ(cmp_addr((struct sockaddr_storage *)addr,
+					addrlen,
+					(struct sockaddr_storage *)&args.addr.addr,
+					args.addr.addrlen, 1),
+			       0, "address_param_modified"))
+			return -1;
+
+	return err;
+}
+
+static int kernel_connect(struct sockaddr *addr, socklen_t addrlen)
+{
+	return sock_addr_op("kernel_connect", addr, &addrlen, false);
+}
+
+static int kernel_bind(int fd, struct sockaddr *addr, socklen_t addrlen)
+{
+	return sock_addr_op("kernel_bind", addr, &addrlen, false);
+}
+
+static int kernel_listen(void)
+{
+	return sock_addr_op("kernel_listen", NULL, NULL, false);
+}
+
+static int kernel_sendmsg(int fd, struct sockaddr *addr, socklen_t addrlen,
+			  char *msg, int msglen)
+{
+	return send_msg_op("kernel_sendmsg", addr, addrlen, msg, msglen, false);
+}
+
+static int sock_sendmsg(int fd, struct sockaddr *addr, socklen_t addrlen,
+			char *msg, int msglen)
+{
+	return send_msg_op("sock_sendmsg", addr, addrlen, msg, msglen, false);
+}
+
+static int kernel_getsockname(int fd, struct sockaddr *addr, socklen_t *addrlen)
+{
+	return sock_addr_op("kernel_getsockname", addr, addrlen, true);
+}
+
+static int kernel_getpeername(int fd, struct sockaddr *addr, socklen_t *addrlen)
+{
+	return sock_addr_op("kernel_getpeername", addr, addrlen, true);
+}
+
+int kernel_connect_to_addr(const struct sockaddr_storage *addr,
+			   socklen_t addrlen, int type)
+{
+	int err;
+
+	if (!ASSERT_OK(kernel_init_sock(addr->ss_family, type, 0),
+		       "kernel_init_sock"))
+		goto err;
+
+	if (!ASSERT_OK(kernel_connect((struct sockaddr *)addr, addrlen),
+		       "kernel_connect"))
+		goto err;
+
+	/* Test code expects a "file descriptor" on success. */
+	err = 1;
+	goto out;
+err:
+	err = -1;
+	ASSERT_OK(kernel_close_sock(0), "kernel_close_sock");
+out:
+	return err;
+}
+
+int kernel_start_server(int family, int type, const char *addr_str, __u16 port,
+			int timeout_ms)
+{
+	struct sockaddr_storage addr;
+	socklen_t addrlen;
+	int err;
+
+	if (!ASSERT_OK(kernel_init_sock(family, type, 0), "kernel_init_sock"))
+		goto err;
+
+	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
+		goto err;
+
+	if (!ASSERT_OK(kernel_bind(0, (struct sockaddr *)&addr, addrlen),
+		       "kernel_bind"))
+		goto err;
+
+	if (type == SOCK_STREAM) {
+		if (!ASSERT_OK(kernel_listen(), "kernel_listen"))
+			goto err;
+	}
+
+	/* Test code expects a "file descriptor" on success. */
+	err = 1;
+	goto out;
+err:
+	err = -1;
+	ASSERT_OK(kernel_close_sock(0), "kernel_close_sock");
+out:
+	return err;
+}
+
 struct sock_ops {
 	int (*connect_to_addr)(const struct sockaddr_storage *addr,
 			       socklen_t addrlen, int type);
@@ -102,6 +315,28 @@ struct sock_ops user_ops = {
 	.close = close,
 };
 
+struct sock_ops kern_ops_sock_sendmsg = {
+	.connect_to_addr = kernel_connect_to_addr,
+	.start_server = kernel_start_server,
+	.socket = kernel_init_sock,
+	.bind = kernel_bind,
+	.getsockname = kernel_getsockname,
+	.getpeername = kernel_getpeername,
+	.sendmsg = sock_sendmsg,
+	.close = kernel_close_sock,
+};
+
+struct sock_ops kern_ops_kernel_sendmsg = {
+	.connect_to_addr = kernel_connect_to_addr,
+	.start_server = kernel_start_server,
+	.socket = kernel_init_sock,
+	.bind = kernel_bind,
+	.getsockname = kernel_getsockname,
+	.getpeername = kernel_getpeername,
+	.sendmsg = kernel_sendmsg,
+	.close = kernel_close_sock,
+};
+
 struct sock_addr_test {
 	enum sock_addr_test_type type;
 	const char *name;
@@ -211,6 +446,60 @@ static struct sock_addr_test tests[] = {
 		SERV6_REWRITE_PORT,
 	},
 
+	/* bind - kernel calls */
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind4: kernel_bind (stream)",
+		bind4_prog_load,
+		bind4_prog_destroy,
+		&kern_ops_sock_sendmsg,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind4: kernel_bind (dgram)",
+		bind4_prog_load,
+		bind4_prog_destroy,
+		&kern_ops_sock_sendmsg,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind6: kernel_bind (stream)",
+		bind6_prog_load,
+		bind6_prog_destroy,
+		&kern_ops_sock_sendmsg,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind6: kernel_bind (dgram)",
+		bind6_prog_load,
+		bind6_prog_destroy,
+		&kern_ops_sock_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+	},
+
 	/* connect - system calls */
 	{
 		SOCK_ADDR_TEST_CONNECT,
@@ -283,6 +572,78 @@ static struct sock_addr_test tests[] = {
 		NULL,
 	},
 
+	/* connect - kernel calls */
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect4: kernel_connect (stream)",
+		connect4_prog_load,
+		connect4_prog_destroy,
+		&kern_ops_sock_sendmsg,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect4: kernel_connect (dgram)",
+		connect4_prog_load,
+		connect4_prog_destroy,
+		&kern_ops_sock_sendmsg,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect6: kernel_connect (stream)",
+		connect6_prog_load,
+		connect6_prog_destroy,
+		&kern_ops_sock_sendmsg,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect6: kernel_connect (dgram)",
+		connect6_prog_load,
+		connect6_prog_destroy,
+		&kern_ops_sock_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+	},
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect_unix: kernel_connect (dgram)",
+		connect_unix_prog_load,
+		connect_unix_prog_destroy,
+		&kern_ops_sock_sendmsg,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+	},
+
 	/* sendmsg - system calls */
 	{
 		SOCK_ADDR_TEST_SENDMSG,
@@ -327,6 +688,94 @@ static struct sock_addr_test tests[] = {
 		NULL,
 	},
 
+	/* sendmsg - kernel calls (sock_sendmsg) */
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg4: sock_sendmsg (dgram)",
+		sendmsg4_prog_load,
+		sendmsg4_prog_destroy,
+		&kern_ops_sock_sendmsg,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: sock_sendmsg (dgram)",
+		sendmsg6_prog_load,
+		sendmsg6_prog_destroy,
+		&kern_ops_sock_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg_unix: sock_sendmsg (dgram)",
+		sendmsg_unix_prog_load,
+		sendmsg_unix_prog_destroy,
+		&kern_ops_sock_sendmsg,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+	},
+
+	/* sendmsg - kernel calls (kernel_sendmsg) */
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg4: kernel_sendmsg (dgram)",
+		sendmsg4_prog_load,
+		sendmsg4_prog_destroy,
+		&kern_ops_kernel_sendmsg,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg6: kernel_sendmsg (dgram)",
+		sendmsg6_prog_load,
+		sendmsg6_prog_destroy,
+		&kern_ops_kernel_sendmsg,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+	},
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg_unix: sock_sendmsg (dgram)",
+		sendmsg_unix_prog_load,
+		sendmsg_unix_prog_destroy,
+		&kern_ops_kernel_sendmsg,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+	},
+
 	/* recvmsg - system calls */
 	{
 		SOCK_ADDR_TEST_RECVMSG,
@@ -468,6 +917,27 @@ static int cmp_sock_addr(info_fn fn, int sock1,
 	return cmp_addr(&addr1, len1, addr2, addr2_len, cmp_port);
 }
 
+static int load_sock_addr_kern(void)
+{
+	int err;
+
+	skel = sock_addr_kern__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		goto err;
+
+	err = 0;
+	goto out;
+err:
+	err = -1;
+out:
+	return err;
+}
+
+static void unload_sock_addr_kern(void)
+{
+	sock_addr_kern__destroy(skel);
+}
+
 static void test_bind(struct sock_addr_test *test)
 {
 	struct sockaddr_storage expected_addr;
@@ -766,6 +1236,9 @@ void test_sock_addr(void)
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
 		goto cleanup;
 
+	if (!ASSERT_OK(load_sock_addr_kern(), "load_sock_addr_kern"))
+		goto cleanup;
+
 	for (size_t i = 0; i < ARRAY_SIZE(tests); ++i) {
 		struct sock_addr_test *test = &tests[i];
 
@@ -806,6 +1279,7 @@ void test_sock_addr(void)
 	}
 
 cleanup:
+	unload_sock_addr_kern();
 	if (cgroup_fd >= 0)
 		close(cgroup_fd);
 	cleanup_test_env();
-- 
2.44.0.683.g7961c838ac-goog


