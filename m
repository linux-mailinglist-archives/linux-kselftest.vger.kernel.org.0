Return-Path: <linux-kselftest+bounces-9087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352F98B64D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 23:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D161C21AF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 21:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13934190670;
	Mon, 29 Apr 2024 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x/qRUDG0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0219066C
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427146; cv=none; b=lvjcUFMvDnKJb8iMHdqwf/TYh40n08782QzMbTVINlTPmbk8I1SUgZCufoFNxnz191bHJpBjQ0lr/dnk0e/fDts5myTaikleQbXm5wY8Gl7u1eoevwmMm3sDEEKTo2QggZWGXLVvaiZDJ4iPbG9A1ZZ6XhLtBc/3LxFMC2F13Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427146; c=relaxed/simple;
	bh=KOCH37PgpnlWrcNrP/exObpyun/s36u7PaezJ7ivK2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S63QRvmUnlgaGlMy9jM3QypelOTzzJgBiCyI5EtsTKouYZ6SM9bSLUPEzMNAlv6qu4Wc51b7crZoxe1H11Oo67t87D6RKpjgyVNL9KjpoBdTWDZYnQuFpOkxWfDIzRycPddUUBmLAJJuz+oisndBs1va0plP+cMitYAr4+U21v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x/qRUDG0; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7decf9533a3so117470539f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714427143; x=1715031943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OecsAcZt+Rc2JJBB92WVyuBwIoMD9liNC3th6k/r62M=;
        b=x/qRUDG0a0lzpstBbkMwnQnfexdVKuwYlrggqjHl4N1xxXmcKAnywfn/6PwAbvTnKE
         5EfVkDhymmbQi73gk7skUn5YwZNuEpTjx32t6SPhP8KGO4+BqIvESXWzBLQKeySke/xe
         cvA5yIY7vqdnhVLu4y58x7Z5UxRJaLyKd4uibWbFe5a33BmJmm1t+zQ41iEGbAaMmDh+
         tP7oXbsIg6iQcTllEyqiZ48llaeKTKIQ+S5EGa04PC+3SIClqtLV9Iz8ulGS98yHNprF
         Yia0TgxnEcplv4M5KpQB9TLWutO8pUkky/NUo3Q8MqHaaukX9Tnm02nYLp8WjPvm5HVJ
         Z95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427143; x=1715031943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OecsAcZt+Rc2JJBB92WVyuBwIoMD9liNC3th6k/r62M=;
        b=BOfB6d/tjnKXPA5oGDPZGi0tGa8DIXOIk253fvuq0+8TkKAsegc8ajyDHZseexC9ST
         4eCGehMSo1e584Iif+kyGdw69OiKvwZqQKVnVmeKwtcX3x6LJ2TwNXFyeTqlhY0R2CIl
         +J8FZswjWq8SDYtU+SZ3J7WMSn70pdpAyDkDmOHO3x7nu03WNJHu0tVQwF+xpFgrMuk9
         aL4VPrdArZv+K/qNi84CHmLiR9cwYUNz3WqAKzCzQpmPfU9Myz1KHAsDqVDzNJhIJ3uy
         KtbKgkXJgmMceiVILdKmDy1IBiO281/wJU7I0P2hQka2z95I6/LXvqguNgJbbET/Rys3
         fAlw==
X-Forwarded-Encrypted: i=1; AJvYcCVeW8ye0qs0imC9Wz4wFZPc0Pg6EmoNOYMUEkIUYvX6jxlOYgdnMl3oPjlTTqr9nRHnrhhQzLYstymnGRJVA1F6yk5rkhU3eyHVoHvjaCSA
X-Gm-Message-State: AOJu0YykBOhLRTrLFCDGlZRWkUhL3mpXJGKZEdK+L6VaX1LZUkZwkNt0
	lBTDWws0DXF96gRS3TluHUoYZXEvCAJ4pbJRfYYERPqk89d28Fh7bOgijnwfjOURgi49FokM+Q=
	=
X-Google-Smtp-Source: AGHT+IEiI9YNrzZa3wm1mQXLVebIfW0A9wb5QvhnfSVzzDmER+si3X4DjT2XB7/ZDdKHBrYs7PNOxeYrQQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6638:4391:b0:487:591e:6e04 with SMTP id
 bo17-20020a056638439100b00487591e6e04mr53599jab.3.1714427143343; Mon, 29 Apr
 2024 14:45:43 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:45:21 -0500
In-Reply-To: <20240429214529.2644801-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429214529.2644801-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429214529.2644801-5-jrife@google.com>
Subject: [PATCH v3 bpf-next 4/6] selftests/bpf: Move IPv4 and IPv6 sockaddr
 test cases
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
	Benjamin Tissoires <bentiss@kernel.org>, Hou Tao <houtao1@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This patch lays the groundwork for testing IPv4 and IPv6 sockaddr hooks
and their interaction with both socket syscalls and kernel functions
(e.g. kernel_connect, kernel_bind, etc.). It moves some of the test
cases from the old-style bpf/test_sock_addr.c self test into the
sock_addr prog_test in a step towards fully retiring
bpf/test_sock_addr.c. We will expand the test dimensions in the
sock_addr prog_test in a later patch series in order to migrate the
remaining test cases.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 389 ++++++++++++------
 tools/testing/selftests/bpf/test_sock_addr.c  | 192 ---------
 2 files changed, 267 insertions(+), 314 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 61668e0f11b06..f3ab154c869b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -3,16 +3,44 @@
 
 #include "test_progs.h"
 
+#include "bind4_prog.skel.h"
+#include "bind6_prog.skel.h"
 #include "connect_unix_prog.skel.h"
+#include "connect4_prog.skel.h"
+#include "connect6_prog.skel.h"
+#include "sendmsg4_prog.skel.h"
+#include "sendmsg6_prog.skel.h"
+#include "recvmsg4_prog.skel.h"
+#include "recvmsg6_prog.skel.h"
 #include "sendmsg_unix_prog.skel.h"
 #include "recvmsg_unix_prog.skel.h"
 #include "getsockname_unix_prog.skel.h"
 #include "getpeername_unix_prog.skel.h"
 #include "network_helpers.h"
 
+#define TEST_NS                 "sock_addr"
+#define TEST_IF_PREFIX          "test_sock_addr"
+#define TEST_IPV4               "127.0.0.4"
+#define TEST_IPV6               "::6"
+
+#define SERV4_IP                "192.168.1.254"
+#define SERV4_REWRITE_IP        "127.0.0.1"
+#define SRC4_IP                 "172.16.0.1"
+#define SRC4_REWRITE_IP         TEST_IPV4
+#define SERV4_PORT              4040
+#define SERV4_REWRITE_PORT      4444
+
+#define SERV6_IP                "face:b00c:1234:5678::abcd"
+#define SERV6_REWRITE_IP        "::1"
+#define SERV6_V4MAPPED_IP       "::ffff:192.168.0.4"
+#define SRC6_IP                 "::1"
+#define SRC6_REWRITE_IP         TEST_IPV6
+#define SERV6_PORT              6060
+#define SERV6_REWRITE_PORT      6666
+
 #define SERVUN_ADDRESS         "bpf_cgroup_unix_test"
 #define SERVUN_REWRITE_ADDRESS "bpf_cgroup_unix_test_rewrite"
-#define SRCUN_ADDRESS	       "bpf_cgroup_unix_test_src"
+#define SRCUN_ADDRESS          "bpf_cgroup_unix_test_src"
 
 enum sock_addr_test_type {
 	SOCK_ADDR_TEST_BIND,
@@ -43,130 +71,148 @@ struct sock_addr_test {
 	const char *expected_src_addr;
 };
 
-static void *connect_unix_prog_load(int cgroup_fd)
-{
-	struct connect_unix_prog *skel;
-
-	skel = connect_unix_prog__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_open"))
-		goto cleanup;
-
-	skel->links.connect_unix_prog = bpf_program__attach_cgroup(
-		skel->progs.connect_unix_prog, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.connect_unix_prog, "prog_attach"))
-		goto cleanup;
-
-	return skel;
-cleanup:
-	connect_unix_prog__destroy(skel);
-	return NULL;
-}
-
-static void connect_unix_prog_destroy(void *skel)
-{
-	connect_unix_prog__destroy(skel);
-}
-
-static void *sendmsg_unix_prog_load(int cgroup_fd)
-{
-	struct sendmsg_unix_prog *skel;
-
-	skel = sendmsg_unix_prog__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_open"))
-		goto cleanup;
-
-	skel->links.sendmsg_unix_prog = bpf_program__attach_cgroup(
-		skel->progs.sendmsg_unix_prog, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.sendmsg_unix_prog, "prog_attach"))
-		goto cleanup;
-
-	return skel;
-cleanup:
-	sendmsg_unix_prog__destroy(skel);
-	return NULL;
-}
-
-static void sendmsg_unix_prog_destroy(void *skel)
-{
-	sendmsg_unix_prog__destroy(skel);
-}
-
-static void *recvmsg_unix_prog_load(int cgroup_fd)
-{
-	struct recvmsg_unix_prog *skel;
-
-	skel = recvmsg_unix_prog__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_open"))
-		goto cleanup;
-
-	skel->links.recvmsg_unix_prog = bpf_program__attach_cgroup(
-		skel->progs.recvmsg_unix_prog, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.recvmsg_unix_prog, "prog_attach"))
-		goto cleanup;
-
-	return skel;
-cleanup:
-	recvmsg_unix_prog__destroy(skel);
-	return NULL;
-}
-
-static void recvmsg_unix_prog_destroy(void *skel)
-{
-	recvmsg_unix_prog__destroy(skel);
-}
-
-static void *getsockname_unix_prog_load(int cgroup_fd)
-{
-	struct getsockname_unix_prog *skel;
-
-	skel = getsockname_unix_prog__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_open"))
-		goto cleanup;
-
-	skel->links.getsockname_unix_prog = bpf_program__attach_cgroup(
-		skel->progs.getsockname_unix_prog, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.getsockname_unix_prog, "prog_attach"))
-		goto cleanup;
-
-	return skel;
-cleanup:
-	getsockname_unix_prog__destroy(skel);
-	return NULL;
+#define BPF_SKEL_FUNCS(skel_name, prog_name) \
+static void *skel_name##_load(int cgroup_fd) \
+{ \
+	struct skel_name *skel; \
+	skel = skel_name##__open_and_load(); \
+	if (!ASSERT_OK_PTR(skel, "skel_open")) \
+		goto cleanup; \
+	skel->links.prog_name = bpf_program__attach_cgroup( \
+		skel->progs.prog_name, cgroup_fd); \
+	if (!ASSERT_OK_PTR(skel->links.prog_name, "prog_attach")) \
+		goto cleanup; \
+	return skel; \
+cleanup: \
+	skel_name##__destroy(skel); \
+	return NULL; \
+} \
+static void skel_name##_destroy(void *skel) \
+{ \
+	skel_name##__destroy(skel); \
 }
 
-static void getsockname_unix_prog_destroy(void *skel)
-{
-	getsockname_unix_prog__destroy(skel);
-}
-
-static void *getpeername_unix_prog_load(int cgroup_fd)
-{
-	struct getpeername_unix_prog *skel;
-
-	skel = getpeername_unix_prog__open_and_load();
-	if (!ASSERT_OK_PTR(skel, "skel_open"))
-		goto cleanup;
-
-	skel->links.getpeername_unix_prog = bpf_program__attach_cgroup(
-		skel->progs.getpeername_unix_prog, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.getpeername_unix_prog, "prog_attach"))
-		goto cleanup;
-
-	return skel;
-cleanup:
-	getpeername_unix_prog__destroy(skel);
-	return NULL;
-}
-
-static void getpeername_unix_prog_destroy(void *skel)
-{
-	getpeername_unix_prog__destroy(skel);
-}
+BPF_SKEL_FUNCS(bind4_prog, bind_v4_prog);
+BPF_SKEL_FUNCS(bind6_prog, bind_v6_prog);
+BPF_SKEL_FUNCS(connect4_prog, connect_v4_prog);
+BPF_SKEL_FUNCS(connect6_prog, connect_v6_prog);
+BPF_SKEL_FUNCS(connect_unix_prog, connect_unix_prog);
+BPF_SKEL_FUNCS(sendmsg4_prog, sendmsg_v4_prog);
+BPF_SKEL_FUNCS(sendmsg6_prog, sendmsg_v6_prog);
+BPF_SKEL_FUNCS(sendmsg_unix_prog, sendmsg_unix_prog);
+BPF_SKEL_FUNCS(recvmsg4_prog, recvmsg4_prog);
+BPF_SKEL_FUNCS(recvmsg6_prog, recvmsg6_prog);
+BPF_SKEL_FUNCS(recvmsg_unix_prog, recvmsg_unix_prog);
+BPF_SKEL_FUNCS(getsockname_unix_prog, getsockname_unix_prog);
+BPF_SKEL_FUNCS(getpeername_unix_prog, getpeername_unix_prog);
 
 static struct sock_addr_test tests[] = {
+	/* bind - system calls */
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind4: bind (stream)",
+		bind4_prog_load,
+		bind4_prog_destroy,
+		AF_INET,
+		SOCK_STREAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind4: bind (dgram)",
+		bind4_prog_load,
+		bind4_prog_destroy,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_IP,
+		SERV4_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind6: bind (stream)",
+		bind6_prog_load,
+		bind6_prog_destroy,
+		AF_INET6,
+		SOCK_STREAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+	},
+	{
+		SOCK_ADDR_TEST_BIND,
+		"bind6: bind (dgram)",
+		bind6_prog_load,
+		bind6_prog_destroy,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+	},
+
+	/* connect - system calls */
+	{
+		SOCK_ADDR_TEST_CONNECT,
+		"connect4: connect (stream)",
+		connect4_prog_load,
+		connect4_prog_destroy,
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
+		"connect4: connect (dgram)",
+		connect4_prog_load,
+		connect4_prog_destroy,
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
+		"connect6: connect (stream)",
+		connect6_prog_load,
+		connect6_prog_destroy,
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
+		"connect6: connect (dgram)",
+		connect6_prog_load,
+		connect6_prog_destroy,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+	},
 	{
 		SOCK_ADDR_TEST_CONNECT,
-		"connect_unix",
+		"connect_unix: connect (stream)",
 		connect_unix_prog_load,
 		connect_unix_prog_destroy,
 		AF_UNIX,
@@ -177,9 +223,37 @@ static struct sock_addr_test tests[] = {
 		0,
 		NULL,
 	},
+
+	/* sendmsg - system calls */
+	{
+		SOCK_ADDR_TEST_SENDMSG,
+		"sendmsg4: sendmsg (dgram)",
+		sendmsg4_prog_load,
+		sendmsg4_prog_destroy,
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
+		"sendmsg6: sendmsg (dgram)",
+		sendmsg6_prog_load,
+		sendmsg6_prog_destroy,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_IP,
+		SERV6_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SRC6_REWRITE_IP,
+	},
 	{
 		SOCK_ADDR_TEST_SENDMSG,
-		"sendmsg_unix",
+		"sendmsg_unix: sendmsg (dgram)",
 		sendmsg_unix_prog_load,
 		sendmsg_unix_prog_destroy,
 		AF_UNIX,
@@ -190,9 +264,37 @@ static struct sock_addr_test tests[] = {
 		0,
 		NULL,
 	},
+
+	/* recvmsg - system calls */
+	{
+		SOCK_ADDR_TEST_RECVMSG,
+		"recvmsg4: recvfrom (dgram)",
+		recvmsg4_prog_load,
+		recvmsg4_prog_destroy,
+		AF_INET,
+		SOCK_DGRAM,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_REWRITE_IP,
+		SERV4_REWRITE_PORT,
+		SERV4_IP,
+	},
 	{
 		SOCK_ADDR_TEST_RECVMSG,
-		"recvmsg_unix-dgram",
+		"recvmsg6: recvfrom (dgram)",
+		recvmsg6_prog_load,
+		recvmsg6_prog_destroy,
+		AF_INET6,
+		SOCK_DGRAM,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_REWRITE_IP,
+		SERV6_REWRITE_PORT,
+		SERV6_IP,
+	},
+	{
+		SOCK_ADDR_TEST_RECVMSG,
+		"recvmsg_unix: recvfrom (dgram)",
 		recvmsg_unix_prog_load,
 		recvmsg_unix_prog_destroy,
 		AF_UNIX,
@@ -205,7 +307,7 @@ static struct sock_addr_test tests[] = {
 	},
 	{
 		SOCK_ADDR_TEST_RECVMSG,
-		"recvmsg_unix-stream",
+		"recvmsg_unix: recvfrom (stream)",
 		recvmsg_unix_prog_load,
 		recvmsg_unix_prog_destroy,
 		AF_UNIX,
@@ -216,6 +318,8 @@ static struct sock_addr_test tests[] = {
 		0,
 		SERVUN_ADDRESS,
 	},
+
+	/* getsockname - system calls */
 	{
 		SOCK_ADDR_TEST_GETSOCKNAME,
 		"getsockname_unix",
@@ -229,6 +333,8 @@ static struct sock_addr_test tests[] = {
 		0,
 		NULL,
 	},
+
+	/* getpeername - system calls */
 	{
 		SOCK_ADDR_TEST_GETPEERNAME,
 		"getpeername_unix",
@@ -558,11 +664,49 @@ static void test_getpeername(struct sock_addr_test *test)
 		close(serv);
 }
 
+static int setup_test_env(struct nstoken **tok)
+{
+	int err;
+
+	SYS(fail, "ip netns add %s", TEST_NS);
+	*tok = open_netns(TEST_NS);
+	if (!ASSERT_OK_PTR(tok, "netns token"))
+		goto fail;
+
+	SYS(fail, "ip link add dev %s1 type veth peer name %s2", TEST_IF_PREFIX,
+	    TEST_IF_PREFIX);
+	SYS(fail, "ip link set lo up");
+	SYS(fail, "ip link set %s1 up", TEST_IF_PREFIX);
+	SYS(fail, "ip link set %s2 up", TEST_IF_PREFIX);
+	SYS(fail, "ip -4 addr add %s/8 dev %s1", TEST_IPV4, TEST_IF_PREFIX);
+	SYS(fail, "ip -6 addr add %s/128 nodad dev %s1", TEST_IPV6, TEST_IF_PREFIX);
+
+	err = 0;
+	goto out;
+fail:
+	err = -1;
+	close_netns(*tok);
+	*tok = NULL;
+	SYS_NOFAIL("ip netns delete %s", TEST_NS);
+out:
+	return err;
+}
+
+static void cleanup_test_env(struct nstoken *tok)
+{
+	close_netns(tok);
+	SYS_NOFAIL("ip netns delete %s", TEST_NS);
+}
+
 void test_sock_addr(void)
 {
+	struct nstoken *tok = NULL;
 	int cgroup_fd = -1;
 	void *skel;
 
+	if (!ASSERT_OK(setup_test_env(&tok), "setup_test_env"))
+		goto cleanup;
+
 	cgroup_fd = test__join_cgroup("/sock_addr");
 	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup"))
 		goto cleanup;
@@ -609,4 +753,5 @@ void test_sock_addr(void)
 cleanup:
 	if (cgroup_fd >= 0)
 		close(cgroup_fd);
+	cleanup_test_env(tok);
 }
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/selftests/bpf/test_sock_addr.c
index c412de84b88f0..aa2198a0f24dd 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -97,11 +97,7 @@ static int sendmsg_deny_prog_load(const struct sock_addr_test *test);
 static int recvmsg_allow_prog_load(const struct sock_addr_test *test);
 static int recvmsg_deny_prog_load(const struct sock_addr_test *test);
 static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test);
-static int recvmsg4_rw_c_prog_load(const struct sock_addr_test *test);
-static int sendmsg4_rw_c_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test);
-static int recvmsg6_rw_c_prog_load(const struct sock_addr_test *test);
-static int sendmsg6_rw_c_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_v4mapped_prog_load(const struct sock_addr_test *test);
 static int sendmsg6_rw_wildcard_prog_load(const struct sock_addr_test *test);
 
@@ -135,34 +131,6 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		ATTACH_REJECT,
 	},
-	{
-		"bind4: rewrite IP & TCP port in",
-		bind4_prog_load,
-		BPF_CGROUP_INET4_BIND,
-		BPF_CGROUP_INET4_BIND,
-		AF_INET,
-		SOCK_STREAM,
-		SERV4_IP,
-		SERV4_PORT,
-		SERV4_REWRITE_IP,
-		SERV4_REWRITE_PORT,
-		NULL,
-		SUCCESS,
-	},
-	{
-		"bind4: rewrite IP & UDP port in",
-		bind4_prog_load,
-		BPF_CGROUP_INET4_BIND,
-		BPF_CGROUP_INET4_BIND,
-		AF_INET,
-		SOCK_DGRAM,
-		SERV4_IP,
-		SERV4_PORT,
-		SERV4_REWRITE_IP,
-		SERV4_REWRITE_PORT,
-		NULL,
-		SUCCESS,
-	},
 	{
 		"bind6: load prog with wrong expected attach type",
 		bind6_prog_load,
@@ -191,34 +159,6 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		ATTACH_REJECT,
 	},
-	{
-		"bind6: rewrite IP & TCP port in",
-		bind6_prog_load,
-		BPF_CGROUP_INET6_BIND,
-		BPF_CGROUP_INET6_BIND,
-		AF_INET6,
-		SOCK_STREAM,
-		SERV6_IP,
-		SERV6_PORT,
-		SERV6_REWRITE_IP,
-		SERV6_REWRITE_PORT,
-		NULL,
-		SUCCESS,
-	},
-	{
-		"bind6: rewrite IP & UDP port in",
-		bind6_prog_load,
-		BPF_CGROUP_INET6_BIND,
-		BPF_CGROUP_INET6_BIND,
-		AF_INET6,
-		SOCK_DGRAM,
-		SERV6_IP,
-		SERV6_PORT,
-		SERV6_REWRITE_IP,
-		SERV6_REWRITE_PORT,
-		NULL,
-		SUCCESS,
-	},
 
 	/* connect */
 	{
@@ -249,34 +189,6 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		ATTACH_REJECT,
 	},
-	{
-		"connect4: rewrite IP & TCP port",
-		connect4_prog_load,
-		BPF_CGROUP_INET4_CONNECT,
-		BPF_CGROUP_INET4_CONNECT,
-		AF_INET,
-		SOCK_STREAM,
-		SERV4_IP,
-		SERV4_PORT,
-		SERV4_REWRITE_IP,
-		SERV4_REWRITE_PORT,
-		SRC4_REWRITE_IP,
-		SUCCESS,
-	},
-	{
-		"connect4: rewrite IP & UDP port",
-		connect4_prog_load,
-		BPF_CGROUP_INET4_CONNECT,
-		BPF_CGROUP_INET4_CONNECT,
-		AF_INET,
-		SOCK_DGRAM,
-		SERV4_IP,
-		SERV4_PORT,
-		SERV4_REWRITE_IP,
-		SERV4_REWRITE_PORT,
-		SRC4_REWRITE_IP,
-		SUCCESS,
-	},
 	{
 		"connect6: load prog with wrong expected attach type",
 		connect6_prog_load,
@@ -305,34 +217,6 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		ATTACH_REJECT,
 	},
-	{
-		"connect6: rewrite IP & TCP port",
-		connect6_prog_load,
-		BPF_CGROUP_INET6_CONNECT,
-		BPF_CGROUP_INET6_CONNECT,
-		AF_INET6,
-		SOCK_STREAM,
-		SERV6_IP,
-		SERV6_PORT,
-		SERV6_REWRITE_IP,
-		SERV6_REWRITE_PORT,
-		SRC6_REWRITE_IP,
-		SUCCESS,
-	},
-	{
-		"connect6: rewrite IP & UDP port",
-		connect6_prog_load,
-		BPF_CGROUP_INET6_CONNECT,
-		BPF_CGROUP_INET6_CONNECT,
-		AF_INET6,
-		SOCK_DGRAM,
-		SERV6_IP,
-		SERV6_PORT,
-		SERV6_REWRITE_IP,
-		SERV6_REWRITE_PORT,
-		SRC6_REWRITE_IP,
-		SUCCESS,
-	},
 
 	/* sendmsg */
 	{
@@ -377,20 +261,6 @@ static struct sock_addr_test tests[] = {
 		SRC4_REWRITE_IP,
 		SUCCESS,
 	},
-	{
-		"sendmsg4: rewrite IP & port (C)",
-		sendmsg4_rw_c_prog_load,
-		BPF_CGROUP_UDP4_SENDMSG,
-		BPF_CGROUP_UDP4_SENDMSG,
-		AF_INET,
-		SOCK_DGRAM,
-		SERV4_IP,
-		SERV4_PORT,
-		SERV4_REWRITE_IP,
-		SERV4_REWRITE_PORT,
-		SRC4_REWRITE_IP,
-		SUCCESS,
-	},
 	{
 		"sendmsg4: deny call",
 		sendmsg_deny_prog_load,
@@ -447,20 +317,6 @@ static struct sock_addr_test tests[] = {
 		SRC6_REWRITE_IP,
 		SUCCESS,
 	},
-	{
-		"sendmsg6: rewrite IP & port (C)",
-		sendmsg6_rw_c_prog_load,
-		BPF_CGROUP_UDP6_SENDMSG,
-		BPF_CGROUP_UDP6_SENDMSG,
-		AF_INET6,
-		SOCK_DGRAM,
-		SERV6_IP,
-		SERV6_PORT,
-		SERV6_REWRITE_IP,
-		SERV6_REWRITE_PORT,
-		SRC6_REWRITE_IP,
-		SUCCESS,
-	},
 	{
 		"sendmsg6: IPv4-mapped IPv6",
 		sendmsg6_rw_v4mapped_prog_load,
@@ -575,34 +431,6 @@ static struct sock_addr_test tests[] = {
 		NULL,
 		LOAD_REJECT,
 	},
-	{
-		"recvmsg4: rewrite IP & port (C)",
-		recvmsg4_rw_c_prog_load,
-		BPF_CGROUP_UDP4_RECVMSG,
-		BPF_CGROUP_UDP4_RECVMSG,
-		AF_INET,
-		SOCK_DGRAM,
-		SERV4_REWRITE_IP,
-		SERV4_REWRITE_PORT,
-		SERV4_REWRITE_IP,
-		SERV4_REWRITE_PORT,
-		SERV4_IP,
-		SUCCESS,
-	},
-	{
-		"recvmsg6: rewrite IP & port (C)",
-		recvmsg6_rw_c_prog_load,
-		BPF_CGROUP_UDP6_RECVMSG,
-		BPF_CGROUP_UDP6_RECVMSG,
-		AF_INET6,
-		SOCK_DGRAM,
-		SERV6_REWRITE_IP,
-		SERV6_REWRITE_PORT,
-		SERV6_REWRITE_IP,
-		SERV6_REWRITE_PORT,
-		SERV6_IP,
-		SUCCESS,
-	},
 };
 
 static int load_insns(const struct sock_addr_test *test,
@@ -761,16 +589,6 @@ static int sendmsg4_rw_asm_prog_load(const struct sock_addr_test *test)
 	return load_insns(test, insns, ARRAY_SIZE(insns));
 }
 
-static int recvmsg4_rw_c_prog_load(const struct sock_addr_test *test)
-{
-	return load_path(test, RECVMSG4_PROG_PATH);
-}
-
-static int sendmsg4_rw_c_prog_load(const struct sock_addr_test *test)
-{
-	return load_path(test, SENDMSG4_PROG_PATH);
-}
-
 static int sendmsg6_rw_dst_asm_prog_load(const struct sock_addr_test *test,
 					 const char *rw_dst_ip)
 {
@@ -829,11 +647,6 @@ static int sendmsg6_rw_asm_prog_load(const struct sock_addr_test *test)
 	return sendmsg6_rw_dst_asm_prog_load(test, SERV6_REWRITE_IP);
 }
 
-static int recvmsg6_rw_c_prog_load(const struct sock_addr_test *test)
-{
-	return load_path(test, RECVMSG6_PROG_PATH);
-}
-
 static int sendmsg6_rw_v4mapped_prog_load(const struct sock_addr_test *test)
 {
 	return sendmsg6_rw_dst_asm_prog_load(test, SERV6_V4MAPPED_IP);
@@ -844,11 +657,6 @@ static int sendmsg6_rw_wildcard_prog_load(const struct sock_addr_test *test)
 	return sendmsg6_rw_dst_asm_prog_load(test, WILDCARD6_IP);
 }
 
-static int sendmsg6_rw_c_prog_load(const struct sock_addr_test *test)
-{
-	return load_path(test, SENDMSG6_PROG_PATH);
-}
-
 static int cmp_addr(const struct sockaddr_storage *addr1,
 		    const struct sockaddr_storage *addr2, int cmp_port)
 {
-- 
2.44.0.769.g3c40516874-goog


