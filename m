Return-Path: <linux-kselftest+bounces-28805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B73A5D8F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 10:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AC73B66DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7751223957C;
	Wed, 12 Mar 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl9F5CRF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B40238D5B;
	Wed, 12 Mar 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770688; cv=none; b=fQvXlQFircTK7x9Jc78zny5zLKkzOBFe2wIPqigLXhMRiDlnJVoqyFYjE1YfihW9RHSGO6mlRWOnZz3kYyyZ2AyZc0X6XVF2gevT9iWFqi0qcKHMAFIZyQIP4McH073WFgZMVaUwV/EZoeonqfPZCCugva8MPNrWdsYshUUEXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770688; c=relaxed/simple;
	bh=BHRxAwc14aF/QlBgey+3QIGNxNdHpd/edoNEcX2+aIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KbfJBwznQkReSD9PWDwolLKZUPpR9kg47wmj37gsIYLnTh5bBfGxtciJw67/bGhvhQ2RfLLjnIWzcHFMDknckUsWxBwydYfNXwFG6MAc/2cu0D1JPBVbXaSwBPlxQrq4KREit5N1AXcnlcVprVniIz2Unj/VmhDTKeM2cfU5ZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl9F5CRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DED3EC4CEF9;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741770687;
	bh=BHRxAwc14aF/QlBgey+3QIGNxNdHpd/edoNEcX2+aIE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Bl9F5CRFw+bKg6fFEkIoqkYguFKb5I/xxbEs4Xpbg0+OWARjuZTzrVJqWgl2OTxLR
	 HfDU6n/GdesTGwIlKHElfbVRb3t0KNiYNGtidm2njRhfbS+uFA0hv8j3HeyzV4fpa5
	 JCgTJr4RY7+uGaNZgm32coHVxPwuGZ4mZZAU8f5MVFR9F3asBZssseqsQyoBLhRWcb
	 Zz91oKYrD4I7ROiW17ZganOKFn8zIW+ObROqNC9gO37mjlC08vjTOMXRoYy1VeZEOp
	 8SZuqf1oy95q/2QWgDUKW3uDyx6VcxAiHAa/b5R5CwMDdopnO80RNIcTPHHb34jE37
	 XQMyVpEOH/SOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41FFC28B28;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 12 Mar 2025 09:11:00 +0000
Subject: [PATCH net 6/7] selftests/net: Delete timeout from
 test_connect_socket()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-tcp-ao-selftests-polling-v1-6-72a642b855d5@gmail.com>
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
In-Reply-To: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741770685; l=5727;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=ALMVvlTrm1gvr8aNFWvAU1f6luL58dhhCBbfYPACl7Y=;
 b=XQspQfeR7LNzu7sqXnQ33tKp8x2l94hnPF/GSsIok2NkxtNAAgOjGMA621sPux6S2R2lILmph
 G5If+M+WEErCyTIylllTtOKBGEhNsPsnneBnUWLtw+R/m+5A+b1RAKx
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Unused: it's always either the default timeout or asynchronous
connect().

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/lib/aolib.h    |  8 ++++----
 tools/testing/selftests/net/tcp_ao/lib/sock.c     | 19 ++++++-------------
 tools/testing/selftests/net/tcp_ao/rst.c          |  5 ++---
 tools/testing/selftests/net/tcp_ao/self-connect.c |  2 +-
 4 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/aolib.h b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
index 3c8c5ac2a878a7a4f5949055bdc2a9f05f3d1de5..e4d3d5016b619ef30362bc03802a2455b6aee99c 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/aolib.h
+++ b/tools/testing/selftests/net/tcp_ao/lib/aolib.h
@@ -289,7 +289,7 @@ extern int link_set_up(const char *intf);
 extern const unsigned int test_server_port;
 extern int test_wait_fd(int sk, time_t sec, bool write);
 extern int __test_connect_socket(int sk, const char *device,
-				 void *addr, size_t addr_sz, time_t timeout);
+				 void *addr, size_t addr_sz, bool async);
 extern int __test_listen_socket(int backlog, void *addr, size_t addr_sz);
 
 static inline int test_listen_socket(const union tcp_addr taddr,
@@ -338,19 +338,19 @@ static inline int test_listen_socket(const union tcp_addr taddr,
 #endif
 
 static inline int _test_connect_socket(int sk, const union tcp_addr taddr,
-				       unsigned int port, time_t timeout)
+				       unsigned int port, bool async)
 {
 	sockaddr_af addr;
 
 	tcp_addr_to_sockaddr_in(&addr, &taddr, htons(port));
 	return __test_connect_socket(sk, veth_name,
-				     (void *)&addr, sizeof(addr), timeout);
+				     (void *)&addr, sizeof(addr), async);
 }
 
 static inline int test_connect_socket(int sk, const union tcp_addr taddr,
 				      unsigned int port)
 {
-	return _test_connect_socket(sk, taddr, port, TEST_TIMEOUT_SEC);
+	return _test_connect_socket(sk, taddr, port, false);
 }
 
 extern int __test_set_md5(int sk, void *addr, size_t addr_sz,
diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
index 1befaf0aa98f9de83fa466cd68a24f467c541a2d..7863ebc36f3c6ced463bd3c8d2c082d5ad152e01 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/sock.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
@@ -111,7 +111,7 @@ static int __test_skpair_poll(int sk, bool write, uint64_t timeout,
 }
 
 int __test_connect_socket(int sk, const char *device,
-			  void *addr, size_t addr_sz, time_t timeout)
+			  void *addr, size_t addr_sz, bool async)
 {
 	long flags;
 	int err;
@@ -123,15 +123,6 @@ int __test_connect_socket(int sk, const char *device,
 			test_error("setsockopt(SO_BINDTODEVICE, %s)", device);
 	}
 
-	if (!timeout) {
-		err = connect(sk, addr, addr_sz);
-		if (err) {
-			err = -errno;
-			goto out;
-		}
-		return 0;
-	}
-
 	flags = fcntl(sk, F_GETFL);
 	if ((flags < 0) || (fcntl(sk, F_SETFL, flags | O_NONBLOCK) < 0))
 		test_error("fcntl()");
@@ -141,9 +132,9 @@ int __test_connect_socket(int sk, const char *device,
 			err = -errno;
 			goto out;
 		}
-		if (timeout < 0)
+		if (async)
 			return sk;
-		err = test_wait_fd(sk, timeout, 1);
+		err = test_wait_fd(sk, TEST_TIMEOUT_SEC, 1);
 		if (err)
 			goto out;
 	}
@@ -181,12 +172,14 @@ int _test_skpair_connect_poll(int sk, const char *device,
 	if (test_get_tcp_counters(sk, &c))
 		test_error("test_get_tcp_counters()");
 	synchronize_threads(); /* 1: init skpair & read nscounters */
-	ret = __test_connect_socket(sk, device, addr, addr_sz, -1);
+	ret = __test_connect_socket(sk, device, addr, addr_sz, true);
 	if (ret < 0) {
 		test_tcp_counters_free(&c);
 		return (*err = ret);
 	}
 	ret = __test_skpair_poll(sk, 1, TEST_TIMEOUT_SEC, &c, condition, err);
+	if (ret < 0)
+		close(sk);
 	test_tcp_counters_free(&c);
 	return ret;
 }
diff --git a/tools/testing/selftests/net/tcp_ao/rst.c b/tools/testing/selftests/net/tcp_ao/rst.c
index f752df511ba2e646384cf02ccae3c2f807ebaed1..e51be747e2b4f5e0a02f413afd011168a8554302 100644
--- a/tools/testing/selftests/net/tcp_ao/rst.c
+++ b/tools/testing/selftests/net/tcp_ao/rst.c
@@ -271,8 +271,7 @@ static void test_client_active_rst(unsigned int port)
 
 	synchronize_threads(); /* 1: MKT added */
 	for (i = 0; i < last; i++) {
-		err = _test_connect_socket(sk[i], this_ip_dest, port,
-					       (i == 0) ? TEST_TIMEOUT_SEC : -1);
+		err = _test_connect_socket(sk[i], this_ip_dest, port, i != 0);
 		if (err < 0)
 			test_error("failed to connect()");
 	}
@@ -283,7 +282,7 @@ static void test_client_active_rst(unsigned int port)
 		test_error("test_wait_fds(): %d", err);
 
 	/* async connect() with third sk to get into request_sock_queue */
-	err = _test_connect_socket(sk[last], this_ip_dest, port, -1);
+	err = _test_connect_socket(sk[last], this_ip_dest, port, 1);
 	if (err < 0)
 		test_error("failed to connect()");
 
diff --git a/tools/testing/selftests/net/tcp_ao/self-connect.c b/tools/testing/selftests/net/tcp_ao/self-connect.c
index 93732732c60c03ccdec093de4964cf9f8caa7b0d..10927cfa23840d31a67e4de34fa2211f9b54cf4b 100644
--- a/tools/testing/selftests/net/tcp_ao/self-connect.c
+++ b/tools/testing/selftests/net/tcp_ao/self-connect.c
@@ -64,7 +64,7 @@ static void tcp_self_connect(const char *tst, unsigned int port,
 		test_error("test_get_tcp_counters()");
 
 	if (__test_connect_socket(sk, "lo", (struct sockaddr *)&addr,
-				  sizeof(addr), TEST_TIMEOUT_SEC) < 0) {
+				  sizeof(addr), 0) < 0) {
 		ns_after = netstat_read();
 		netstat_print_diff(ns_before, ns_after);
 		test_error("failed to connect()");

-- 
2.42.2



