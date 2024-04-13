Return-Path: <linux-kselftest+bounces-7899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAC18A3A2C
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 03:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05F3283D04
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17639D272;
	Sat, 13 Apr 2024 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs89Ysm6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4F7492;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712972584; cv=none; b=NZoYfBHs4YByH11dOAH1PgPNSq7XM9LRZwx6v5fvmVzXJ6o+cuiaLP78M7WD4vprOdnAM3RrSWzqGJ5vX3TpeZ3fZ6Ax0ZMmzoL9jRbBpwdlOD0bM3+WEOBr/eziZXenTYdylC61AJEYDnkEN/LwDund9NBr4Qky/BbjJUEvoWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712972584; c=relaxed/simple;
	bh=tvGa1RDSYHvI02nHuHPX+BD+1F1uJG9F/D3Zv650p0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cz1ywEdXxifd/xTck1wOHuS/fBhI7Yg14HNYxdRPzSiVdW+AvgR8NQuXgq9hMLhVIBztH73ZbPiEOzXRDMrmOVRZg4QxTptpq5NfQv+7aOggts2DvEj7dSjoaS1DMIvOp56Cv3mrlq58B4yyoRduLWEKul3rw26Spp1f+1q0cxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs89Ysm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68011C2BD11;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712972584;
	bh=tvGa1RDSYHvI02nHuHPX+BD+1F1uJG9F/D3Zv650p0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Vs89Ysm6Eq6GyH7Erh2wAgEBXOtwbQsc6i4A+2O21cGpbZO8fEKMTenXKzqsXx+bG
	 SoN0FNIKee2t8YjC9UmZgpM6HWpMtOiVEO1WVQ0WHAZSZ7yytceQryTiA+73AAQBnz
	 /4PRBp1ETUKvUSkjX1j2Ffc5zsbM6kzAWiab+kKjnLyw45GSkYmaxobHIZN0QSaKtb
	 hi3qZemRjiifBWn9pDEOeCTQn2dLAorItZqNNlhqmg4r1uuQFpnh4HNV9r7gbdz/o3
	 gHjbSgAfFTBXDjXaBkZoDhgvf7B+eX1B388Fh5SGB4hGFahivOl/fLKGxu+ksBCfP+
	 c9Z+N/KkJspSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506A0C00A94;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Sat, 13 Apr 2024 02:42:52 +0100
Subject: [PATCH net 1/4] selftests/tcp_ao: Make RST tests less flaky
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240413-tcp-ao-selftests-fixes-v1-1-f9c41c96949d@gmail.com>
References: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
In-Reply-To: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712972582; l=3102;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=M06UR6shNbxtrWai0TpYoMLXyAZTaGGEZv0XA0Xj5PY=;
 b=3va35F/mXlgdzh4og0lSK3APn3dow8vd3RX7hV6FJZKkqOHaKzkUaSBVDLVqV13KEESoEVRwIJt1
 St/bbfmHDE5G6xTenLVkdp79QtRqUMLirepzGOgub8zEZ3hdVpl3
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Currently, "active reset" cases are flaky, because select() is called
for 3 sockets, while only 2 are expected to receive RST.
The idea of the third socket was to get into request_sock_queue,
but the test mistakenly attempted to connect() after the listener
socket was shut down.

Repair this test, it's important to check the different kernel
code-paths for signing RST TCP-AO segments.

Fixes: c6df7b2361d7 ("selftests/net: Add TCP-AO RST test")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/rst.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/rst.c b/tools/testing/selftests/net/tcp_ao/rst.c
index 7df8b8700e39..a2fe88d35ac0 100644
--- a/tools/testing/selftests/net/tcp_ao/rst.c
+++ b/tools/testing/selftests/net/tcp_ao/rst.c
@@ -256,8 +256,6 @@ static int test_wait_fds(int sk[], size_t nr, bool is_writable[],
 
 static void test_client_active_rst(unsigned int port)
 {
-	/* one in queue, another accept()ed */
-	unsigned int wait_for = backlog + 2;
 	int i, sk[3], err;
 	bool is_writable[ARRAY_SIZE(sk)] = {false};
 	unsigned int last = ARRAY_SIZE(sk) - 1;
@@ -275,16 +273,20 @@ static void test_client_active_rst(unsigned int port)
 	for (i = 0; i < last; i++) {
 		err = _test_connect_socket(sk[i], this_ip_dest, port,
 					       (i == 0) ? TEST_TIMEOUT_SEC : -1);
-
 		if (err < 0)
 			test_error("failed to connect()");
 	}
 
-	synchronize_threads(); /* 2: connection accept()ed, another queued */
-	err = test_wait_fds(sk, last, is_writable, wait_for, TEST_TIMEOUT_SEC);
+	synchronize_threads(); /* 2: two connections: one accept()ed, another queued */
+	err = test_wait_fds(sk, last, is_writable, last, TEST_TIMEOUT_SEC);
 	if (err < 0)
 		test_error("test_wait_fds(): %d", err);
 
+	/* async connect() with third sk to get into request_sock_queue */
+	err = _test_connect_socket(sk[last], this_ip_dest, port, -1);
+	if (err < 0)
+		test_error("failed to connect()");
+
 	synchronize_threads(); /* 3: close listen socket */
 	if (test_client_verify(sk[0], packet_sz, quota / packet_sz, TEST_TIMEOUT_SEC))
 		test_fail("Failed to send data on connected socket");
@@ -292,13 +294,14 @@ static void test_client_active_rst(unsigned int port)
 		test_ok("Verified established tcp connection");
 
 	synchronize_threads(); /* 4: finishing up */
-	err = _test_connect_socket(sk[last], this_ip_dest, port, -1);
-	if (err < 0)
-		test_error("failed to connect()");
 
 	synchronize_threads(); /* 5: closed active sk */
-	err = test_wait_fds(sk, ARRAY_SIZE(sk), NULL,
-			    wait_for, TEST_TIMEOUT_SEC);
+	/*
+	 * Wait for 2 connections: one accepted, another in the accept queue,
+	 * the one in request_sock_queue won't get fully established, so
+	 * doesn't receive an active RST, see inet_csk_listen_stop().
+	 */
+	err = test_wait_fds(sk, last, NULL, last, TEST_TIMEOUT_SEC);
 	if (err < 0)
 		test_error("select(): %d", err);
 

-- 
2.42.0



