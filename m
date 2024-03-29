Return-Path: <linux-kselftest+bounces-6889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3478D89241C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 20:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577A01C224A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 19:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187E013B59E;
	Fri, 29 Mar 2024 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QU3NJwRy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11EF13B288
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740009; cv=none; b=eLKlgqj5ozWLvB+EbKtkufdSGdpSbJOwy3ospde1Tk+T5/28N2p3MSXmQ/YzdYpQDbFRdcDfET1c4MYzWqrMl47EBY2EWWLBZ9I4hv29xbmhWoYyDnDo7VneeAf+r2qzAEDrAzvrXTg0nlTePtmoWLet3XuTrm/6SzKMXH9BZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740009; c=relaxed/simple;
	bh=lq+VHZ/6SliQ0l8D/03cbanG9rZRe9h1jG9pu+GwWnE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q0whMrcdiK9haqqB8RRMof87Rr0L5GDl2fKBYJdoQ29L+w9Al/iK1kq9MnOFGORZRhYUhf9APf0vPlbIqmh4YmfcmFmfnctPZI4XHmkEaLPWWK/cSywZq32yyY39JRxfItV8tC8h4lYdt+E2laDQepRKmaRSHpVGuGH/hP4euDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QU3NJwRy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-610b96c8ca2so41887597b3.2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 12:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711740006; x=1712344806; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FkSWwqGbj+QCOVR1P3G4xOB1/rPb4gIDmJKvBOGCrXA=;
        b=QU3NJwRybjqXzCYezjqWnaN+t0fdxlBMgCpZjJUEuNelQa84pxBvM58beFG7K2WSn0
         4854hiO4P04GhtpV5iFfwBhYeHBgmjetpKfQ2sl2LubyR8hkRxZVv1PpgHyL+QTbOXl2
         b366+47OrM4Z5i38y11VueaEdrDJqNFPQh2dpx3hWotWEXwUKiuHyXr7bYwJWkEp87cN
         Iog8FopDeJCfTzGOChmWvczWCmApcvZI5CsX8rrOz8afy9+gZI8bIeqdTnNlq39xvJlP
         /M7ahqjAZ5vgqWHWp3mbJi/jRHIL0ZkJU/gSqR5TSeEI3N7cLIZ1BcjlxWEKHpCoH5Zl
         9jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740006; x=1712344806;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkSWwqGbj+QCOVR1P3G4xOB1/rPb4gIDmJKvBOGCrXA=;
        b=YrtqYH1Q/S7nUNTnJlyrhyFgvXOIFXp7K+7do4BpjMeZzK9IxEmCYoRnAmsSohL6vP
         6P1anIRy9TSuIc72lxZSEF88TQN9nmHz2cgcfabknKx+2yLlKXn6LxwMxMf6D5QKExn8
         pxQsbUbJtkx9gMp5k1kmz1InFbHqEBFuwZEvEMwwvuKhEcom7xX3xia62ECnVo741+1K
         2zAnxuHzlumzXkGUt4Btz5ttkRB5kr/hfS+MLFkezVJIR9ivyyY+joHnGXWK5vIzlVJJ
         OV9xF7S3raPPz2xsSB6TeSU9QPUcvNacl4OlO3dtp1dmcdWoAL68SOJYmxnGrmhYJXPv
         dfPg==
X-Forwarded-Encrypted: i=1; AJvYcCVo1jdgzTF1Ng/DPZ7lbGucDwVS0C1tW1V18PxwbuFVUz0of8Typ/mcKQsYccST8PQEADBK4ECqnhuVlSN1Mw+e45XtQ/+6w9q1T7eLHTgm
X-Gm-Message-State: AOJu0YyTohr3jyV3erSYAd9ebNW6dX5dXd9MPcNO6jKcVge3SyqqhwOr
	jgDPWR6yGw51vdDdWdC8TYy+fkCUVJPGiK9lQZBYMDF5DpToup0uIYgTK6hO5JGOwOOimB6Lzg=
	=
X-Google-Smtp-Source: AGHT+IF/GfMFUr6lTZdhS+GecnaHBHcrL3gjPRHllZpNaVHqr//EV6xxrTUrUCkJIiy3YFWYNB9OV+hYhQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:690c:6306:b0:614:edb:ac22 with SMTP id
 ho6-20020a05690c630600b006140edbac22mr866644ywb.2.1711740006076; Fri, 29 Mar
 2024 12:20:06 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:18:52 -0500
In-Reply-To: <20240329191907.1808635-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329191907.1808635-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329191907.1808635-8-jrife@google.com>
Subject: [PATCH v1 bpf-next 7/8] selftests/bpf: Add sock_addr_kern prog_test
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The sock_addr_kern test program leverages the sock_addr_testmod kernel
module to test the interaction between kernel socket operations and BPF
sockaddr hooks. It focuses on operations that may modify an input
address, namely connect, bind, and sendmsg to add regression test
coverage for

- commit 0bdf399342c5("net: Avoid address overwrite in kernel_connect")
- commit 86a7e0b69bd5("net: prevent rewrite of msg_name in sock_sendmsg()")
- commit c889a99a21bf("net: prevent address rewrite in kernel_bind()")

with some additional sanity checks in place to make sure
kernel_getpeername() and kernel_getsockname() work as expected. It
provides coverage for IPv4, IPv6, and the recently added Unix sockaddr
hooks.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/prog_tests/sock_addr_kern.c | 631 ++++++++++++++++++
 2 files changed, 632 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/sock_addr_kern.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index ccc1c11559a45..58c9ba6eb4e7f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -654,6 +654,7 @@ TRUNNER_EXTRA_FILES := $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko	\
 		       $(OUTPUT)/uprobe_multi				\
 		       ima_setup.sh 					\
 		       verify_sig_setup.sh				\
+		       test_sock_addr.sh				\
 		       $(wildcard progs/btf_dump_test_case_*.c)		\
 		       $(wildcard progs/*.bpf.o)
 TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr_kern.c b/tools/testing/selftests/bpf/prog_tests/sock_addr_kern.c
new file mode 100644
index 0000000000000..50959b142c8eb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr_kern.c
@@ -0,0 +1,631 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2023 Google LLC. */
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include <arpa/inet.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+
+#include "test_progs.h"
+
+#include "cgroup_helpers.h"
+#include "testing_helpers.h"
+#include "bpf_util.h"
+#include "network_helpers.h"
+#include "sock_addr_helpers.h"
+
+#define BIND    0
+#define CONNECT 1
+#define SENDMSG 2
+
+struct sock_addr_kern_test;
+
+typedef int (*load_fn)(const struct sock_addr_kern_test *test);
+
+struct sock_addr_kern_test {
+	const char *descr;
+	/* BPF prog properties */
+	load_fn loadfn;
+	enum bpf_attach_type attach_type;
+	/* Socket properties */
+	int socket_family;
+	int socket_type;
+	/* IP:port pairs for BPF prog to override */
+	const char *requested_ip;
+	unsigned short requested_port;
+	const char *expected_ip;
+	unsigned short expected_port;
+	const char *expected_src_ip;
+};
+
+static int ld_path(const struct sock_addr_kern_test *test, const char *path)
+{
+	return load_path(path, test->attach_type, false);
+}
+
+static int bind4_prog_load(const struct sock_addr_kern_test *test)
+{
+	return ld_path(test, BIND4_PROG_PATH);
+}
+
+static int bind6_prog_load(const struct sock_addr_kern_test *test)
+{
+	return ld_path(test, BIND6_PROG_PATH);
+}
+
+static int connect4_prog_load(const struct sock_addr_kern_test *test)
+{
+	return ld_path(test, CONNECT4_PROG_PATH);
+}
+
+static int connect6_prog_load(const struct sock_addr_kern_test *test)
+{
+	return ld_path(test, CONNECT6_PROG_PATH);
+}
+
+static int connect_unix_prog_load(const struct sock_addr_kern_test *test)
+{
+	return ld_path(test, CONNECTUN_PROG_PATH);
+}
+
+static int sendmsg4_rw_c_prog_load(const struct sock_addr_kern_test *test)
+{
+	return ld_path(test, SENDMSG4_PROG_PATH);
+}
+
+static int sendmsg6_rw_c_prog_load(const struct sock_addr_kern_test *test)
+{
+	return ld_path(test, SENDMSG6_PROG_PATH);
+}
+
+static struct sock_addr_kern_test tests[] = {
+	/* bind */
+	{
+		"bind4: ensure that kernel_bind does not overwrite the address (TCP)",
+		bind4_prog_load,
+		BPF_CGROUP_INET4_BIND,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+	},
+	{
+		"bind4: ensure that kernel_bind does not overwrite the address (UDP)",
+		bind4_prog_load,
+		BPF_CGROUP_INET4_BIND,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+	},
+	{
+		"bind6: ensure that kernel_bind does not overwrite the address (TCP)",
+		bind6_prog_load,
+		BPF_CGROUP_INET6_BIND,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+	},
+	{
+		"bind6: ensure that kernel_bind does not overwrite the address (UDP)",
+		bind6_prog_load,
+		BPF_CGROUP_INET6_BIND,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+	},
+
+	/* connect */
+	{
+		"connect4: ensure that kernel_connect does not overwrite the address (TCP)",
+		connect4_prog_load,
+		BPF_CGROUP_INET4_CONNECT,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+	},
+	{
+		"connect4: ensure that kernel_connect does not overwrite the address (UDP)",
+		connect4_prog_load,
+		BPF_CGROUP_INET4_CONNECT,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+	},
+	{
+		"connect6: ensure that kernel_connect does not overwrite the address (TCP)",
+		connect6_prog_load,
+		BPF_CGROUP_INET6_CONNECT,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+	},
+	{
+		"connect6: ensure that kernel_connect does not overwrite the address (UDP)",
+		connect6_prog_load,
+		BPF_CGROUP_INET6_CONNECT,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+	},
+	{
+		"connect_unix: ensure that kernel_connect does not overwrite the address",
+		connect_unix_prog_load,
+		BPF_CGROUP_UNIX_CONNECT,
+		AF_UNIX,
+		SOCK_STREAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+	},
+
+	/* sendmsg */
+	{
+		"sendmsg4: ensure that kernel_sendmsg does not overwrite the address (UDP)",
+		sendmsg4_rw_c_prog_load,
+		BPF_CGROUP_UDP4_SENDMSG,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SRC4_REWRITE_IP,
+	},
+	{
+		"sendmsg6: ensure that kernel_sendmsg does not overwrite the address (UDP)",
+		sendmsg6_rw_c_prog_load,
+		BPF_CGROUP_UDP6_SENDMSG,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+	},
+	{
+		"sendmsg_unix: ensure that kernel_sendmsg does not overwrite the address",
+		connect_unix_prog_load,
+		BPF_CGROUP_UNIX_SENDMSG,
+		AF_UNIX,
+		SOCK_DGRAM,
+		SERVUN_ADDRESS,
+		0,
+		SERVUN_REWRITE_ADDRESS,
+		0,
+		NULL,
+	},
+};
+
+struct sock_addr_testmod_results {
+	bool success;
+	struct sockaddr_storage addr;
+	struct sockaddr_storage sock_name;
+	struct sockaddr_storage peer_name;
+};
+
+static int load_mod(const struct sock_addr_kern_test *test, int op)
+{
+	char params_str[512];
+
+	if (sprintf(params_str, "ip=%s port=%hu af=%d type=%d op=%d",
+		    test->requested_ip, test->requested_port,
+		    test->socket_family, test->socket_type, op) < 0)
+		return -1;
+
+	if (load_bpf_sock_addr_testmod(params_str, false))
+		return -1;
+
+	return 0;
+}
+
+static int unload_mod(void)
+{
+	return unload_bpf_sock_addr_testmod(false);
+}
+
+static int read_result(const char *path, void *val, size_t len)
+{
+	FILE *f;
+	int err;
+
+	f = fopen(path, "r");
+	if (!f)
+		goto err;
+
+	err = fread(val, 1, len, f);
+	if (err != len)
+		goto err;
+
+	err = 0;
+	goto out;
+
+err:
+	err = -1;
+out:
+	if (f)
+		fclose(f);
+
+	return err;
+}
+
+static int read_mod_results(struct sock_addr_testmod_results *results)
+{
+	char success[2];
+	int err;
+
+	if (read_result("/sys/kernel/debug/sock_addr_testmod/success", success,
+			sizeof(success)))
+		goto err;
+
+	switch (success[0]) {
+	case 'N':
+		results->success = false;
+		break;
+	case 'Y':
+		results->success = true;
+		break;
+	default:
+		goto err;
+	}
+
+	if (read_result("/sys/kernel/debug/sock_addr_testmod/addr",
+			&results->addr, sizeof(results->addr)))
+		goto err;
+
+	if (read_result("/sys/kernel/debug/sock_addr_testmod/sock_name",
+			&results->sock_name, sizeof(results->sock_name)))
+		goto err;
+
+	if (read_result("/sys/kernel/debug/sock_addr_testmod/peer_name",
+			&results->peer_name, sizeof(results->peer_name)))
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
+static int run_mod_test(const struct sock_addr_kern_test *test, int op,
+			struct sock_addr_testmod_results *results)
+{
+	int err;
+
+	if (!ASSERT_OK(load_mod(test, op), "load_mod"))
+		goto err;
+
+	if (!ASSERT_OK(read_mod_results(results), "read_mod_results"))
+		goto err;
+
+	err = 0;
+	goto out;
+err:
+	err = -1;
+out:
+	if (!ASSERT_OK(unload_mod(), "unload_mod"))
+		err = -1;
+
+	return err;
+}
+
+static const char *ntop(int af, const struct sockaddr_storage *addr, char *buf,
+			size_t buf_len)
+{
+	char ip_buf[256];
+	struct sockaddr_in6 *sin6;
+	struct sockaddr_in *sin;
+	unsigned short port;
+
+	switch (af) {
+	case AF_INET:
+		sin = (struct sockaddr_in *)addr;
+		port = ntohs(sin->sin_port);
+
+		if (!inet_ntop(AF_INET, &sin->sin_addr, ip_buf, sizeof(ip_buf)))
+			goto err;
+
+		break;
+	case AF_INET6:
+		sin6 = (struct sockaddr_in6 *)addr;
+		port = ntohs(sin6->sin6_port);
+
+		if (!inet_ntop(AF_INET6, &sin6->sin6_addr, ip_buf,
+			       sizeof(ip_buf)))
+			goto err;
+
+		break;
+	case AF_UNIX:
+		strcpy(buf, ((struct sockaddr_un *)addr)->sun_path + 1);
+		goto out;
+	default:
+		goto err;
+	}
+
+	sprintf(buf, "%s:%d", ip_buf, port);
+
+	goto out;
+err:
+	buf = NULL;
+out:
+	return buf;
+}
+
+static void assert_addr_eq(const char *name, int af,
+			   const struct sockaddr_storage *expected,
+			   const struct sockaddr_storage *got, int cmp_port)
+{
+	int ret = cmp_addr(expected, 0, got, 0, cmp_port);
+	char expected_buf[100];
+	char got_buf[100];
+	int duration = 0;
+
+	CHECK(ret, name, "(expected=%s, got=%s)\n",
+	      ntop(af, expected, expected_buf, sizeof(expected_buf)),
+	      ntop(af, got, got_buf, sizeof(got_buf)));
+}
+
+static void test_kernel_bind(const struct sock_addr_kern_test *test)
+{
+	struct sock_addr_testmod_results results;
+	struct sockaddr_storage requested_addr;
+	struct sockaddr_storage expected_addr;
+	socklen_t addr_len;
+	int clientfd = -1;
+
+	if (!ASSERT_OK(make_sockaddr(test->socket_family, test->requested_ip,
+				     test->requested_port,
+				     &requested_addr, NULL),
+				     "make_requested_addr"))
+		goto cleanup;
+
+	if (!ASSERT_OK(make_sockaddr(test->socket_family, test->expected_ip,
+				     test->expected_port,
+				     &expected_addr, &addr_len),
+				     "make_expected_addr"))
+		goto cleanup;
+
+	if (!ASSERT_OK(load_mod(test, BIND), "load_mod"))
+		goto cleanup;
+
+	/* Try to connect to server just in case */
+	clientfd = connect_to_addr(&expected_addr, addr_len, test->socket_type);
+	if (!ASSERT_GT(clientfd, 0, "connect_to_addr"))
+		goto cleanup;
+
+	if (!ASSERT_OK(read_mod_results(&results), "read_mod_results"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(results.success, "results_success"))
+		goto cleanup;
+
+	assert_addr_eq("addr", test->socket_family, &requested_addr,
+		       &results.addr, 1);
+	assert_addr_eq("sock_name", test->socket_family, &expected_addr,
+		       &results.sock_name, 1);
+
+cleanup:
+	ASSERT_OK(unload_mod(), "unload_mod");
+}
+
+static void test_kernel_connect(const struct sock_addr_kern_test *test)
+{
+	struct sockaddr_storage expected_src_addr;
+	struct sock_addr_testmod_results results;
+	struct sockaddr_storage requested_addr;
+	struct sockaddr_storage expected_addr;
+	int servfd = -1;
+
+	if (!ASSERT_OK(make_sockaddr(test->socket_family, test->requested_ip,
+				     test->requested_port,
+				     &requested_addr, NULL),
+				     "make_requested_addr"))
+		goto cleanup;
+
+	if (!ASSERT_OK(make_sockaddr(test->socket_family, test->expected_ip,
+				     test->expected_port,
+				     &expected_addr, NULL),
+				     "make_expected_addr"))
+		goto cleanup;
+
+	if (test->expected_src_ip)
+		if (!ASSERT_OK(make_sockaddr(test->socket_family,
+					     test->expected_src_ip, 0,
+					     &expected_src_addr, NULL),
+					     "make_expected_src_addr"))
+			goto cleanup;
+
+	/* Prepare server to connect to */
+	servfd = start_server(test->socket_family, test->socket_type,
+			      test->expected_ip, test->expected_port, 0);
+	if (!ASSERT_GT(servfd, 0, "start_server"))
+		goto cleanup;
+
+	if (!ASSERT_OK(run_mod_test(test, CONNECT, &results), "run_mod_test"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(results.success, "results_success"))
+		goto cleanup;
+
+	assert_addr_eq("addr", test->socket_family, &requested_addr,
+		       &results.addr, 1);
+	if (test->expected_src_ip)
+		assert_addr_eq("source_addr", test->socket_family, &expected_src_addr,
+			       &results.sock_name, 0);
+	assert_addr_eq("peer_name", test->socket_family, &expected_addr,
+		       &results.peer_name, 1);
+
+cleanup:
+	if (servfd > 0)
+		close(servfd);
+}
+
+static void test_kernel_sendmsg(const struct sock_addr_kern_test *test)
+{
+	struct sock_addr_testmod_results results;
+	struct sockaddr_storage expected_addr;
+	struct sockaddr_storage sendmsg_addr;
+	struct sockaddr_storage recvmsg_addr;
+	int servfd = -1;
+
+	if (!ASSERT_OK(make_sockaddr(test->socket_family, test->requested_ip,
+				     test->requested_port,
+				     &sendmsg_addr, NULL),
+				     "make_requested_addr"))
+		goto cleanup;
+
+	if (test->expected_src_ip)
+		if (!ASSERT_OK(make_sockaddr(test->socket_family, test->expected_src_ip,
+					     0, &expected_addr, NULL),
+					     "make_expected_src_addr"))
+			goto cleanup;
+
+	/* Prepare server to sendmsg to */
+	servfd = start_server(test->socket_family, test->socket_type,
+			      test->expected_ip, test->expected_port, 0);
+	if (!ASSERT_GT(servfd, 0, "start_server"))
+		goto cleanup;
+
+	if (!ASSERT_OK(run_mod_test(test, SENDMSG, &results), "run_mod_test"))
+		goto cleanup;
+
+	if (!ASSERT_TRUE(results.success, "results_success"))
+		goto cleanup;
+
+	assert_addr_eq("msg_name", test->socket_family, &sendmsg_addr,
+		       &results.addr, 1);
+
+	if (!ASSERT_GT(recvmsg_from_client(servfd, &recvmsg_addr), 0,
+		       "recvmsg_from_client"))
+		goto cleanup;
+
+	if (test->expected_src_ip)
+		assert_addr_eq("source_addr", test->socket_family, &recvmsg_addr,
+			       &expected_addr, 0);
+
+cleanup:
+	if (servfd > 0)
+		close(servfd);
+}
+
+static void run_test_case(int cgfd, const struct sock_addr_kern_test *test)
+{
+	int progfd = -1;
+
+	progfd = test->loadfn(test);
+	if (!ASSERT_GE(progfd, 0, "loadfn"))
+		goto cleanup;
+
+	if (!ASSERT_OK(bpf_prog_attach(progfd, cgfd, test->attach_type,
+				       BPF_F_ALLOW_OVERRIDE), "bpf_prog_attach"))
+		goto cleanup;
+
+	switch (test->attach_type) {
+	case BPF_CGROUP_INET4_BIND:
+	case BPF_CGROUP_INET6_BIND:
+		test_kernel_bind(test);
+		break;
+	case BPF_CGROUP_INET4_CONNECT:
+	case BPF_CGROUP_INET6_CONNECT:
+	case BPF_CGROUP_UNIX_CONNECT:
+		test_kernel_connect(test);
+		break;
+	case BPF_CGROUP_UDP4_SENDMSG:
+	case BPF_CGROUP_UDP6_SENDMSG:
+	case BPF_CGROUP_UNIX_SENDMSG:
+		test_kernel_sendmsg(test);
+		break;
+	default:
+		ASSERT_FAIL("attach_type not valid: %d", test->attach_type);
+	}
+
+cleanup:
+	/* Detaching w/o checking return code: best effort attempt. */
+	if (progfd != -1) {
+		bpf_prog_detach(cgfd, test->attach_type);
+		close(progfd);
+	}
+}
+
+static void run_tests(int cgfd)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i) {
+		if (!test__start_subtest(tests[i].descr))
+			continue;
+
+		run_test_case(cgfd, &tests[i]);
+	}
+}
+
+static int setup_test_env(void)
+{
+	return system("./test_sock_addr.sh setup");
+}
+
+static int cleanup_test_env(void)
+{
+	return system("./test_sock_addr.sh cleanup");
+}
+
+void test_sock_addr_kern(void)
+{
+	int cgfd = -1;
+
+	if (!ASSERT_OK(setup_cgroup_environment(), "setup_cgroup_environment"))
+		goto cleanup;
+
+	if (!ASSERT_OK(setup_test_env(), "setup_test_env"))
+		goto cleanup;
+
+	/* Attach programs to root cgroup so they interact with kernel socket
+	 * operations.
+	 */
+	cgfd = get_root_cgroup();
+	if (!ASSERT_GE(cgfd, 0, "get_root_cgroup"))
+		goto cleanup;
+
+	run_tests(cgfd);
+cleanup:
+	if (cgfd >= 0)
+		close(cgfd);
+	cleanup_cgroup_environment();
+	cleanup_test_env();
+}
-- 
2.44.0.478.gd926399ef9-goog


