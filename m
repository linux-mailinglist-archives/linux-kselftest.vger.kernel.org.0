Return-Path: <linux-kselftest+bounces-10032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138688C2A37
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 21:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEAC628695F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 19:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9E04436C;
	Fri, 10 May 2024 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="whH9p4KJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f73.google.com (mail-io1-f73.google.com [209.85.166.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA0944C64
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 19:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367779; cv=none; b=TS4XBSLsZXAjIOCLS4EC3ykV6rcxS7zIFImyRduBYVwFIXCB0vsB2b+o8i9czPc4LjDE190Atv8PLxEKKIiHEcPsoVPU40W2rakKiInJGL16H5Q3hmfGQm77QbZGD/rjOsgv8N+5HAzaIkSJZ78gTSO2SiqVATHTdpgeY8PvJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367779; c=relaxed/simple;
	bh=Q+W7w6jbWqTidenY4MPkZGNwUkeTs/EGWzXTI1iPbwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nk/2BUVbpQoOTTZNaVSqbFlO1yFmKN4oQ/s6o1Rtty1qmqrCvFKlhJU4FR5egz1SOxfCBLFe7yOV5uqrLUXnhHwzjqf74O9wO2I64mXjw327FoFCVXehqCJnZKj3anorD/Q3zzj9V+WQVAsacFgnhQfZEXLs4uoOfqJNXg9i1bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=whH9p4KJ; arc=none smtp.client-ip=209.85.166.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-io1-f73.google.com with SMTP id ca18e2360f4ac-7ddf0219685so251644739f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715367777; x=1715972577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u4RXpPUmiZ7lVHR+RSSj4BtJBK9I+cPlzYrfL79hERg=;
        b=whH9p4KJQN51xf+gwKpOUiUKgx828ZWyuoJdX3RR300+caS/Ca8xGVe7cv9Cxq4tnR
         zgMmnRZIukMa/ILKL28bsJy1r58CJur6xgw1/iiHBwC1aPTwau9h8OxAO6SKlFMwPcv2
         DesMeZOGGjzu1XckLs85ijJeIgl/d9n4sQvF5vmzD0zPOA3dmLJQbYFmViPZVvBInOwi
         zuz49EdbORv11koB2XwkoHLJkucUPOVdwtZ8+D7hr4rm/i/qRK3TuL/uSyX+a8O8lNN+
         zzaPAo7l0Cns7xi8xQaPgbaUNvu7eTYPEPavV2ASO5WNVa3+4jy2Zj32+cOMfQ/Phw8T
         aIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715367777; x=1715972577;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4RXpPUmiZ7lVHR+RSSj4BtJBK9I+cPlzYrfL79hERg=;
        b=CZiHnpC+Ae89AMzpAFKjUlmfyBuQWrpg4gWA6npZ0ifPVXjHGZ3JsSd7QY/zJHacDs
         2L2F9sGzdHaf97Dk4/POHX+1k4DZ4NsGDOQUo8IbeiQclPyXBoReTWArHwGASPqV+4ea
         lg7mINWL1J28UmzRDQVoYtfBoPdzqQsXG2O5nIo6nShJ2kNwSPKwa4gAJVJpesrpAXT8
         Xv+Ruko0deEb9vkEVui4NpoaY3GmMyRRJjWoXCw27mJKqKsDEejOUvI0HaP4Ub3dCg+A
         Tb2WEW1YQhESEn5x5Dl5LxV/bh+oIXoQeh+tJkeb9tAGoFi1AxyZWtvCussxleczmV6P
         OfYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOa2otKkxmSlPZFzrrs4Lz8gY2HKyyhWs8I4kZSC7YVRcB7Ui0Np83/LgyCKFnOaPMcnAwRqRrnQmkdADl8N/EfGWAclaK4WhYhJ8JCcCN
X-Gm-Message-State: AOJu0Ywv5/Kx8wAtWFK+cOwOHMsyVlvNmGNkISvxC/UAShsp3xIGCCXo
	IhanOsJJCpopmak90onyxkLjPi9WmlpSOGDiGC+9bFnw1nZWuD4EsUJS16Sutu5QEFtWA/9WAA=
	=
X-Google-Smtp-Source: AGHT+IF1dnApAaUq/G5y/hc7IEj8eb1mWES65vk/ZygziY3BsaV+soeV2/P8VmerEBdMReYnDSJCdHWtLw==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a92:1e0c:0:b0:36c:830d:8af9 with SMTP id
 e9e14a558f8ab-36cc14dc3f7mr1587645ab.4.1715367776989; Fri, 10 May 2024
 12:02:56 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:22 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-6-jrife@google.com>
Subject: [PATCH v1 bpf-next 05/17] selftests/bpf: Handle SYSCALL_EPERM and
 SYSCALL_ENOTSUPP test cases
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In preparation to move test cases from bpf/test_sock_addr.c that expect
system calls to return ENOTSUPP or EPERM, this patch propagates errno
from relevant system calls up to test_sock_addr() where the result can
be checked.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 78 ++++++++++++++-----
 1 file changed, 58 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 53440458f365e..626be900a8fdf 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -19,6 +19,10 @@
 #include "getpeername_unix_prog.skel.h"
 #include "network_helpers.h"
 
+#ifndef ENOTSUPP
+# define ENOTSUPP 524
+#endif
+
 #define TEST_NS                 "sock_addr"
 #define TEST_IF_PREFIX          "test_sock_addr"
 #define TEST_IPV4               "127.0.0.4"
@@ -43,6 +47,8 @@
 #define SERVUN_REWRITE_ADDRESS "bpf_cgroup_unix_test_rewrite"
 #define SRCUN_ADDRESS          "bpf_cgroup_unix_test_src"
 
+#define save_errno_do(op) ({ int __save = errno; op; errno = __save; })
+
 enum sock_addr_test_type {
 	SOCK_ADDR_TEST_BIND,
 	SOCK_ADDR_TEST_CONNECT,
@@ -98,6 +104,7 @@ static int run_bpf_prog(const char *prog_name, void *ctx, int ctx_size)
 		goto err;
 
 	err = topts.retval;
+	errno = -topts.retval;
 	goto out;
 err:
 	err = -1;
@@ -221,8 +228,7 @@ int kernel_connect_to_addr(int type, const struct sockaddr_storage *addr, sockle
 		       "kernel_init_sock"))
 		goto err;
 
-	if (!ASSERT_OK(kernel_connect((struct sockaddr *)addr, addrlen),
-		       "kernel_connect"))
+	if (kernel_connect((struct sockaddr *)addr, addrlen) < 0)
 		goto err;
 
 	/* Test code expects a "file descriptor" on success. */
@@ -230,7 +236,7 @@ int kernel_connect_to_addr(int type, const struct sockaddr_storage *addr, sockle
 	goto out;
 err:
 	err = -1;
-	ASSERT_OK(kernel_close_sock(0), "kernel_close_sock");
+	save_errno_do(ASSERT_OK(kernel_close_sock(0), "kernel_close_sock"));
 out:
 	return err;
 }
@@ -248,8 +254,7 @@ int kernel_start_server(int family, int type, const char *addr_str, __u16 port,
 	if (make_sockaddr(family, addr_str, port, &addr, &addrlen))
 		goto err;
 
-	if (!ASSERT_OK(kernel_bind(0, (struct sockaddr *)&addr, addrlen),
-		       "kernel_bind"))
+	if (kernel_bind(0, (struct sockaddr *)&addr, addrlen) < 0)
 		goto err;
 
 	if (type == SOCK_STREAM) {
@@ -262,7 +267,7 @@ int kernel_start_server(int family, int type, const char *addr_str, __u16 port,
 	goto out;
 err:
 	err = -1;
-	ASSERT_OK(kernel_close_sock(0), "kernel_close_sock");
+	save_errno_do(ASSERT_OK(kernel_close_sock(0), "kernel_close_sock"));
 out:
 	return err;
 }
@@ -1066,7 +1071,7 @@ static void unload_sock_addr_kern(void)
 	sock_addr_kern__destroy(skel);
 }
 
-static void test_bind(struct sock_addr_test *test)
+static int test_bind(struct sock_addr_test *test)
 {
 	struct sockaddr_storage expected_addr;
 	socklen_t expected_addr_len = sizeof(struct sockaddr_storage);
@@ -1075,8 +1080,10 @@ static void test_bind(struct sock_addr_test *test)
 	serv = test->ops->start_server(test->socket_family, test->socket_type,
 				       test->requested_addr,
 				       test->requested_port, 0);
-	if (!ASSERT_GE(serv, 0, "start_server"))
-		goto cleanup;
+	if (serv < 0) {
+		err = errno;
+		goto err;
+	}
 
 	err = make_sockaddr(test->socket_family,
 			    test->expected_addr, test->expected_port,
@@ -1095,13 +1102,17 @@ static void test_bind(struct sock_addr_test *test)
 		goto cleanup;
 
 cleanup:
+	err = 0;
+err:
 	if (client != -1)
 		close(client);
 	if (serv != -1)
 		test->ops->close(serv);
+
+	return err;
 }
 
-static void test_connect(struct sock_addr_test *test)
+static int test_connect(struct sock_addr_test *test)
 {
 	struct sockaddr_storage addr, expected_addr, expected_src_addr;
 	socklen_t addr_len = sizeof(struct sockaddr_storage),
@@ -1121,8 +1132,10 @@ static void test_connect(struct sock_addr_test *test)
 
 	client = test->ops->connect_to_addr(test->socket_type, &addr, addr_len,
 					    NULL);
-	if (!ASSERT_GE(client, 0, "connect_to_addr"))
-		goto cleanup;
+	if (client < 0) {
+		err = errno;
+		goto err;
+	}
 
 	err = make_sockaddr(test->socket_family, test->expected_addr, test->expected_port,
 			    &expected_addr, &expected_addr_len);
@@ -1149,13 +1162,17 @@ static void test_connect(struct sock_addr_test *test)
 			goto cleanup;
 	}
 cleanup:
+	err = 0;
+err:
 	if (client != -1)
 		test->ops->close(client);
 	if (serv != -1)
 		close(serv);
+
+	return err;
 }
 
-static void test_xmsg(struct sock_addr_test *test)
+static int test_xmsg(struct sock_addr_test *test)
 {
 	struct sockaddr_storage addr, src_addr;
 	socklen_t addr_len = sizeof(struct sockaddr_storage),
@@ -1196,6 +1213,11 @@ static void test_xmsg(struct sock_addr_test *test)
 	if (test->socket_type == SOCK_DGRAM) {
 		err = test->ops->sendmsg(client, (struct sockaddr *)&addr,
 					 addr_len, &data, sizeof(data));
+		if (err < 0) {
+			err = errno;
+			goto err;
+		}
+
 		if (!ASSERT_EQ(err, sizeof(data), "sendmsg"))
 			goto cleanup;
 	} else {
@@ -1245,13 +1267,17 @@ static void test_xmsg(struct sock_addr_test *test)
 	}
 
 cleanup:
+	err = 0;
+err:
 	if (client != -1)
 		test->ops->close(client);
 	if (serv != -1)
 		close(serv);
+
+	return err;
 }
 
-static void test_getsockname(struct sock_addr_test *test)
+static int test_getsockname(struct sock_addr_test *test)
 {
 	struct sockaddr_storage expected_addr;
 	socklen_t expected_addr_len = sizeof(struct sockaddr_storage);
@@ -1275,9 +1301,11 @@ static void test_getsockname(struct sock_addr_test *test)
 cleanup:
 	if (serv != -1)
 		test->ops->close(serv);
+
+	return 0;
 }
 
-static void test_getpeername(struct sock_addr_test *test)
+static int test_getpeername(struct sock_addr_test *test)
 {
 	struct sockaddr_storage addr, expected_addr;
 	socklen_t addr_len = sizeof(struct sockaddr_storage),
@@ -1314,6 +1342,8 @@ static void test_getpeername(struct sock_addr_test *test)
 		test->ops->close(client);
 	if (serv != -1)
 		close(serv);
+
+	return 0;
 }
 
 static int setup_test_env(struct nstoken **tok)
@@ -1369,6 +1399,7 @@ void test_sock_addr(void)
 
 	for (size_t i = 0; i < ARRAY_SIZE(tests); ++i) {
 		struct sock_addr_test *test = &tests[i];
+		int err;
 
 		if (!test__start_subtest(test->name))
 			continue;
@@ -1385,26 +1416,33 @@ void test_sock_addr(void)
 		 * the future.
 		 */
 		case SOCK_ADDR_TEST_BIND:
-			test_bind(test);
+			err = test_bind(test);
 			break;
 		case SOCK_ADDR_TEST_CONNECT:
-			test_connect(test);
+			err = test_connect(test);
 			break;
 		case SOCK_ADDR_TEST_SENDMSG:
 		case SOCK_ADDR_TEST_RECVMSG:
-			test_xmsg(test);
+			err = test_xmsg(test);
 			break;
 		case SOCK_ADDR_TEST_GETSOCKNAME:
-			test_getsockname(test);
+			err = test_getsockname(test);
 			break;
 		case SOCK_ADDR_TEST_GETPEERNAME:
-			test_getpeername(test);
+			err = test_getpeername(test);
 			break;
 		default:
 			ASSERT_TRUE(false, "Unknown sock addr test type");
 			break;
 		}
 
+		if (test->expected_result == SYSCALL_EPERM)
+			ASSERT_EQ(err, EPERM, "socket operation returns EPERM");
+		else if (test->expected_result == SYSCALL_ENOTSUPP)
+			ASSERT_EQ(err, ENOTSUPP, "socket operation returns ENOTSUPP");
+		else if (test->expected_result == SUCCESS)
+			ASSERT_OK(err, "socket operation succeeds");
+
 		test->destroyfn(skel);
 	}
 
-- 
2.45.0.118.g7fe29c98d7-goog


