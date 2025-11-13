Return-Path: <linux-kselftest+bounces-45537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F46C57465
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 12:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5410D34F847
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 11:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071C34D4F2;
	Thu, 13 Nov 2025 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="H84eqA2t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic305-46.consmr.mail.gq1.yahoo.com (sonic305-46.consmr.mail.gq1.yahoo.com [98.137.64.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15134A3AE
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 11:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034631; cv=none; b=GzJEMEnyz6wnV+0FkWHFqccvVCUJ4x/q+dIGyXiCzFGehBhJc022rSPLtZSJJwvIbJWDUNwsXPmsnYwd0p95c1yyESIsvnV2ZoQlBYTPKer9pGNb3wvfmm6fmOsZ14zESg5Aap41vjWgE8KsTBCrTEapRhPZKEvJbbT2gCBkqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034631; c=relaxed/simple;
	bh=BjyrwqxvG3mHuQruUr8TYV34YQVp1pw+ETUGTRsNRYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=GHz47tMoYrcpR3NZO4V9uph6+aXqGFuVvtaZROYtEVbJ29j44ONC55zlXGgDOjl8l8nV7dBKuw1cjYHUdA7s91LlHuKI1YBH0gaGo/x0zaCGMIKDjpflwLryydSlXIYz9kt3HSyoRg4Ujc/OITAwSeOXqJQDm1exzv5cRoCmbic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=H84eqA2t; arc=none smtp.client-ip=98.137.64.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763034628; bh=vsc2zIDV9/l3N6sMLht900KIugzNpcZMNEAIUVyatoY=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=H84eqA2thyMX7P/iyoviAbcRtDA97SVHQ1k7JBI2bO9S/XGzGgVY97eHqXcfV+LWh52RQxLQviG6blFJvjjXloGSH07gyo6pLU1sMlkwhMkxfFYzBeIX0jklK6OFlwbzgYjp3TOQ+s68MDsgKjIvXQvQEdxIm0b/aY5Giqxc46X3nlWjMgHK5zKg+ADDRbBPEq0v1VDmlTdwVHPOkQ5x9N5VK1yphe80C4OV0FGKUkcXBc1sxz9FkxqOLg7VN6LQ7nFCeVtIWNEchQUcx7Z+DnL9Q5CSG6b7OhHsktkmD2XVOAQ3Ux9iU/wbtEX1GJ1yekD9NHtnmpEcDzkpXvedPw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763034628; bh=CSHCEv2a8PYdCS85NUi9ayaIu8g3uxfo5qyU5WuMSXf=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VvNWDoSJ8IWcgdQ2K2Gk9VnpestJiN12It6LcahszuwdLz+wbvHLDzMui4hHHd01IMwMgTWl64s8pa//rr2YAsJhugja0cMuavqUtUe9w4153tObGcOou/IqxiakNXQxUlFFFtZEmMUW587T1Bbn6hSy2tjx3PGYfMS17nrgfLotseDZSewwASnXun0T1uQoFtXfs1wlVMdM7frpnJ35KKSxnnffXF0x0Kl3NxkvKcjPOgcvkMo0+gs49wk6WmRet49SnzZ/4UdCursKL8oQRHxU8mJIjShtJAs2bgdVGIPbpoIXYccPK3JNVv/fbkciYHHuqS39KXyWCkS4uFY7Wg==
X-YMail-OSG: dA_3nAAVM1l97D_TcyfqvQxByU5P9szVHOMMJytNlkSr85CIQuWGD8W.Y8.Of92
 IjOuwTTwO33CMQrNK9uEitiCeahppCd6zd1jxub6JcmT8JnB5RREVIP6Ye75lhkkpl6q9.wxjfSn
 6o4ayjHZ6wKgf83ZQ1BUSpPd5sTNYnZfiJW2Nz6yg0.n8Z0VGUdZE9UUeusjl86.6KyXQlKEOJhp
 PPceS3B_9JOUBshZfm1T3sFjNYaN5XQylCFnKHl4xg48UvgrB2Oe57vaz7YmBdo05BCL.E.t.zV0
 JAj_hf2ePEOBWovW6rmNeQPIVuiWiKsaucN6FnK2F0b04WJR6R4Wpotbezi1fbqr.cwsBittPVs0
 hN_fJhW1.bOR2Wz.MUYoj_KC0PuxSZvLzbtcDKY3N1Q5mRXjXAe9QmCRPeYC6yG4LDp7jfywrGpj
 tO5VYpAXj_1GqxR9eijRNO88S1wEI1iFMqG_p_nqBMXzk6cBCYu7Mfp3OED1DGSSRI7vYM3aGlnG
 5OT52.AeWVqSn2pN6vKQUGOsyWjjYJlKSnAbMVil37McN9O71iT_7W8bUYayCQzWMsDi3sJKhznH
 SwAYew42YD2dIX7F2eOybEJHL.TB9wbWb4lZYxqeKl6v23qhXg2fyXqfuH4Gck1bdzBKHVjbV.vH
 BSdzHx2r8043yf7q6LASoZY6QmEPY2M0MhSK5fStbEMDqu6ZOFYjAXPDyIBMzZnG43.1maxapbw8
 ne7xdUkV1pHp3.noh3pmjR04_ukrPhbBzuTFYYJI_.M078AKGBON8SacmoVVUrw8_PI9rZlILik1
 o1Lr3reAghVxYGVlEX5STrhzfV8_EHAwu1Gc5p_mxcSqqe.ud0OiM4pl4veM8AxD8gQXN_wO.TYt
 D7U4AUwV1GWWf5vjcnUowJrZhtzgEBEKp5WrX0xdFKS8.4425T4.SzDgEMwJnfmoWglrM42UUVqg
 3MgA_5A8RdloKYwbU67YachEVr4YdPs_X8RABs1rfUMI88IwRirtF7hVeY6RSzy9jFxW1SX2LSlX
 bVVDDcO7_WXP_E1KNmWjD7S6gleIUDHC3wV.ruklf8puvOtHeHklr93mTya8Rcrhgx55oSiBq_5g
 bWTtlTySxbEm3luRp1HP4DbNmxXs77caNCtwtY0RwBM8drR8EtyhjCLPUcUob_EqQrBfhXNgEvQ4
 oBNmxFZue0wrG8xnAkDDrF8q7Em2yLWXmq_dD2I8IvuHf3U43AzqG1yW.V8bqwesjF.2uTLPsCi6
 qCnnQ.jw4tPnPeFS8.p1hwZiXuZ7M8M..rLPR0JoF1t34VhswH1hWriBy8a5sq_64WrhWt1wYhpk
 pFVNPeBGQ3T1ANzL3Dvnw4osJjnSeG5Chxb9r96vg08hXAhyAUxnN_.r7u4iFxNgxacG8VeGpI.w
 n7NbX7VyYc25lfosfL9IG9hu348xkzQdVg9Cg72kiQ6lO0iubIFX6PjoUW44b5kiqyF0df3Oqm9J
 33gNZ8ckkfdnh7qFyOB5Y1oASFwfRI9wHmtzUyO8Brg3JNOHmoovgIF1lXfW9O36bKPBZAgY.xEK
 .eoNNNU8nB_uXj_m_P_3P7GdJg2QIJn6FQ2U54qYmd0DNMt.cDuhNAG9dSXRsu2JDzhtc0QsJDzD
 7u7J5tITRM36rEQiS4UhbQGaXVyEzetk9AqRE2rj2__oIV4CSJ52szPAqSuU10x.zU1Zfu1WhMxA
 2427HrznLsrlH9vGIa37UTl6DeULbyt8xn1xno8Cz3Lrs8HY2XcG18tRf0qXxU57EnlB2ZQ5Tzwx
 V6NtW9_MBQNPn5fPOey8FOC_mZcljwaTXjans.0g6Byjo7l7Akv3jmyEcMT4gG3Ab1LvOjvSRTUd
 9BEvjMKdxMShheJ1sWqbXaS5KmZylL9BItL1XzLEYMhWvbLo3n43WULED7_N7YdHhTg2gi_6b4G_
 xtCqUh7OEoVm.jLjJmfjqhggricEgsO8M.qe6fSoF7a2gJXtod06hHIbUXUSC2knBVCiJ4wYUd48
 nQXECehhcRWmn1.iD.3PKoXIyZhTfZDrs_1PceGA_NcKq9jy4BmR8H29bv0ITe43HEqPsclpi07t
 ddh9CnHAvYMao.uV6X1eRADxzSBixnhYyViGtGyRv3EJfWPeOSphLXAxspl08TUHJM4eYm0VpsrI
 Z39ccwBTe18T2T4onojpu1OQpMWize5IzpGL4gAGLrGEu8gLeozxzg9pwbrqzEYVFCLYtQmgY_AX
 CNaMb9qyzog3Ip2bgeZ63TxxzXeANqfWjIIiJwoWybWMHOiQj9MLDQaUYMiLDoq0gJYCN9A3zF4S
 Wzwm1H0MveSJMU1K31r3mUe6DSQN7sR_rAoKDyPMjgixVgcZau73dSWU4H2rfT1dJaMUdmlfIyvt
 ef8Ujm_0ZLinqQaNQajYOXQc-
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 23f27373-26d7-4c58-b550-da61e8faefbd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Thu, 13 Nov 2025 11:50:28 +0000
Received: by hermes--production-bf1-58477f5468-wnnm5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e2ddb9b3ed0e230064ffd349fd918855;
          Thu, 13 Nov 2025 11:28:11 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH v6] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
Date: Thu, 13 Nov 2025 12:28:02 +0100
Message-ID: <20251113112802.44657-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <20251113112802.44657-1-adelodunolaoluwa.ref@yahoo.com>

Add selftests to verify and document Linux’s intended behaviour for
UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
The tests verify that:

 1. SOCK_STREAM returns EOF when the peer closes normally.
 2. SOCK_STREAM returns ECONNRESET if the peer closes with unread data.
 3. SOCK_SEQPACKET returns EOF when the peer closes normally.
 4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data.
 5. SOCK_DGRAM does not return ECONNRESET when the peer closes.

This follows up on review feedback suggesting a selftest to clarify
Linux’s semantics.

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
changelog:

changes from v5 to v6
- Remove the not-needed check for self->child > 0 in the
  FIXTURE_TEARDOWN

changes from v4 to v5:
1. Moved the send() call before the socket type check in Test 2 to ensure
  the unread data behavior is tested for SOCK_DGRAM as well.

2. Removed the misleading commend about accept() for clarity.

3. Applied indentation fixes for style consistency
  (alignment with open parenthesis).

4. Minor comment and formatting cleanups for clarity and adherence
  to kernel coding style.

 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   1 +
 .../selftests/net/af_unix/unix_connreset.c    | 177 ++++++++++++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 439101b518ee..e89a60581a13 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -65,3 +65,4 @@ udpgso
 udpgso_bench_rx
 udpgso_bench_tx
 unix_connect
+unix_connreset
diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index de805cbbdf69..5826a8372451 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -7,6 +7,7 @@ TEST_GEN_PROGS := \
 	scm_pidfd \
 	scm_rights \
 	unix_connect \
+	unix_connreset \
 # end of TEST_GEN_PROGS
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools/testing/selftests/net/af_unix/unix_connreset.c
new file mode 100644
index 000000000000..bffef2b54bfd
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
+ *
+ * This test verifies:
+ *  1. SOCK_STREAM returns EOF when the peer closes normally.
+ *  2. SOCK_STREAM returns ECONNRESET if peer closes with unread data.
+ *  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
+ *  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data.
+ *  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
+ *
+ * These tests document the intended Linux behaviour.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include "../../kselftest_harness.h"
+
+#define SOCK_PATH "/tmp/af_unix_connreset.sock"
+
+static void remove_socket_file(void)
+{
+	unlink(SOCK_PATH);
+}
+
+FIXTURE(unix_sock)
+{
+	int server;
+	int client;
+	int child;
+};
+
+FIXTURE_VARIANT(unix_sock)
+{
+	int socket_type;
+	const char *name;
+};
+
+FIXTURE_VARIANT_ADD(unix_sock, stream) {
+	.socket_type = SOCK_STREAM,
+	.name = "SOCK_STREAM",
+};
+
+FIXTURE_VARIANT_ADD(unix_sock, dgram) {
+	.socket_type = SOCK_DGRAM,
+	.name = "SOCK_DGRAM",
+};
+
+FIXTURE_VARIANT_ADD(unix_sock, seqpacket) {
+	.socket_type = SOCK_SEQPACKET,
+	.name = "SOCK_SEQPACKET",
+};
+
+FIXTURE_SETUP(unix_sock)
+{
+	struct sockaddr_un addr = {};
+	int err;
+
+	addr.sun_family = AF_UNIX;
+	strcpy(addr.sun_path, SOCK_PATH);
+	remove_socket_file();
+
+	self->server = socket(AF_UNIX, variant->socket_type, 0);
+	ASSERT_LT(-1, self->server);
+
+	err = bind(self->server, (struct sockaddr *)&addr, sizeof(addr));
+	ASSERT_EQ(0, err);
+
+	if (variant->socket_type == SOCK_STREAM ||
+	    variant->socket_type == SOCK_SEQPACKET) {
+		err = listen(self->server, 1);
+		ASSERT_EQ(0, err);
+	}
+
+	self->client = socket(AF_UNIX, variant->socket_type | SOCK_NONBLOCK, 0);
+	ASSERT_LT(-1, self->client);
+
+	err = connect(self->client, (struct sockaddr *)&addr, sizeof(addr));
+	ASSERT_EQ(0, err);
+}
+
+FIXTURE_TEARDOWN(unix_sock)
+{
+	if (variant->socket_type == SOCK_STREAM ||
+	    variant->socket_type == SOCK_SEQPACKET)
+		close(self->child);
+
+	close(self->client);
+	close(self->server);
+	remove_socket_file();
+}
+
+/* Test 1: peer closes normally */
+TEST_F(unix_sock, eof)
+{
+	char buf[16] = {};
+	ssize_t n;
+
+	if (variant->socket_type == SOCK_STREAM ||
+	    variant->socket_type == SOCK_SEQPACKET) {
+		self->child = accept(self->server, NULL, NULL);
+		ASSERT_LT(-1, self->child);
+
+		close(self->child);
+	} else {
+		close(self->server);
+	}
+
+	n = recv(self->client, buf, sizeof(buf), 0);
+
+	if (variant->socket_type == SOCK_STREAM ||
+	    variant->socket_type == SOCK_SEQPACKET) {
+		ASSERT_EQ(0, n);
+	} else {
+		ASSERT_EQ(-1, n);
+		ASSERT_EQ(EAGAIN, errno);
+	}
+}
+
+/* Test 2: peer closes with unread data */
+TEST_F(unix_sock, reset_unread_behavior)
+{
+	char buf[16] = {};
+	ssize_t n;
+
+	/* Send data that will remain unread */
+	send(self->client, "hello", 5, 0);
+
+	if (variant->socket_type == SOCK_DGRAM) {
+		/* No real connection, just close the server */
+		close(self->server);
+	} else {
+		self->child = accept(self->server, NULL, NULL);
+		ASSERT_LT(-1, self->child);
+
+		/* Peer closes before client reads */
+		close(self->child);
+	}
+
+	n = recv(self->client, buf, sizeof(buf), 0);
+	ASSERT_EQ(-1, n);
+
+	if (variant->socket_type == SOCK_STREAM ||
+	    variant->socket_type == SOCK_SEQPACKET) {
+		ASSERT_EQ(ECONNRESET, errno);
+	} else {
+		ASSERT_EQ(EAGAIN, errno);
+	}
+}
+
+/* Test 3: closing unaccepted (embryo) server socket should reset client. */
+TEST_F(unix_sock, reset_closed_embryo)
+{
+	char buf[16] = {};
+	ssize_t n;
+
+	if (variant->socket_type == SOCK_DGRAM)
+		SKIP(return, "This test only applies to SOCK_STREAM and SOCK_SEQPACKET");
+
+	/* Close server without accept()ing */
+	close(self->server);
+
+	n = recv(self->client, buf, sizeof(buf), 0);
+
+	ASSERT_EQ(-1, n);
+	ASSERT_EQ(ECONNRESET, errno);
+}
+
+TEST_HARNESS_MAIN
+
-- 
2.43.0


