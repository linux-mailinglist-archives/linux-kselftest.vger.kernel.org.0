Return-Path: <linux-kselftest+bounces-45518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D65C56074
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 08:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0331343B5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 07:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D056320CBA;
	Thu, 13 Nov 2025 07:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jWgTbNkx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic310-20.consmr.mail.gq1.yahoo.com (sonic310-20.consmr.mail.gq1.yahoo.com [98.137.69.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE042C0293
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018356; cv=none; b=Dei/81+Xp9uR8D14iBtVYh4JQV3X+L4dVOygCmivZ5+9NofusgDl55dt57G5PrCwRUI2gbTVppLkzpP6N2Eh2L4+/rNGRXWTzZECTRcq5S0bKxAxyrRV7jLPqFqPbtmjq3TSTrHEmxaNhslMcLBELDOjGKSFSRlJMHhjoPhhSqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018356; c=relaxed/simple;
	bh=DLr9toDY83cCfjt++2H6Oq80YZjEbfV5ZwT1kwcmvp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=QGswK6Xwyt3/OkKSm6Yg4JgHjflAbledobwud/uOInQBVpItOu0TJvcxXTj7ZDSv+fnQljKNVxp9ism9uBIWKqGaRelQpap/ofs0id2HEdpT4MLmuBuH0WjAsRNe/x0oxiHnBsfqjZq5pwbWJy+OnTzt5OdLO5ffXfP0JuU35zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=jWgTbNkx; arc=none smtp.client-ip=98.137.69.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763018354; bh=6RgDM1j6x8tVvRJ08rdzLDOVbTDAJCCXf7p9mQsikiI=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=jWgTbNkxzSTgloXmtANvD+CYJt+mj6BJ2YbhMnYItdKIpwEqsq0dXxWd7DHykJL+vLwG0sU2gqdxUFdSHDQXKD4Elx4PqAU8IL4GnPDPFJHY+PkjaA6pRwaXy4J2W3SXyMf78LWjF+HnUX/1NSqpQF0dgpDYy5VUyBIqyO2Ve0dAW7gVMLUidSpKhuTwXmh5OD4+tkNv500wWjzctcO6RSHn+ULpBY0MHHXIvTvi1sapA6g8sHv16NaC2Uy98VR7WwHIwSfd+F62j8EASDuzxAoRKguylFJN6cpS7mPx3pCqIByj40Tc0qmuIVPgX0jbMFGv8GY1xJRAunz2yOjJlg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763018354; bh=JVRB2W2Zmm4QTx3sda9ffIBgmu2GZ2DSFIosBVX1ujg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=VmhdY2VTLsyB6VwaX51ixux3bt4X4QKkWOAodS1N4a0DVSltS6mjsJe1frqlin0Qb60fiXEGm0S/6jkdstcpaY0XrUeByypFpWqT0tzr4M0xWQ5IIRkaOKfzU98zA9vL4vNxK0J0dq+3CgLoA42vM86CXjhBg31TxZQloaBpcUAP3S2cpKMtnOTE73zSjtDQY0he7L1Mp9fM6FgYYYet1PSN3weDSQZqL1KpNd/ChbCsnun+6gtUQTBQGJIXzi2CrouF6GXGq1t/kxuaZe6/lK0JRvDE6kxffeu8J1TFUUi2+CwB2ls0Io3CGgRwmNXLZcqSjxQnLvWHxRoDCcJL5Q==
X-YMail-OSG: l._rA3gVM1kkvMkYfM1DyqJ4cJSXGqkZY3_1_ywIrxgczI9bZ3jO4krfc_Akp14
 r9K5Z98oMrSnXYDA8tupZAnNgms2tnrFjJ5r44k0Ug27h6VWiWD6USKQKeWyURD7mYhmJ0zeyMRi
 5V6SACpjmMkaq_HkxMx6Xatj5rOWuwvQRs4b_KM0x6JzySp_wl3xWTJOyv045X8G9zkatEvyJaim
 y_V8BucNA1yj1hv8gqyT1a0RLfkEG2G2jtldiJb9bCpIv56vFWuk5vfno3JXlPNSn4XYZF79SLgV
 LYDa8I8yT8jZk1Fd_3HfkvoFLG31yN.TdLLtoBzCzdTFepinKgrbR0uVAbujJSa21StLvPYZ6.7k
 UB3j.K.FGfHU6wW_1uzrlTu4owj5b5AVBJhf0ZD.M_WfLfVzgCDKN0FY_kRhc9dMQHaQPa3aUKzG
 BjHQ_0YYU8sTWHNa0N5E3uYHpBRQgMTJsceGWeX3w30PlYCQNR7spH1.kp5rmM8DOmzuslViWDpk
 szM2YdvLjT1EzHL8J_Nx63v6PgjkzRscyspm5fAnIQClwc3mEoq1MnOYm_PU4cmL2UkuBOp0Afwv
 aY2wdFWLoVbqdy8cABJibCqcaO8FiJgVBlIXFXRR.Wp4GUTzpWdP5PRBD7qL54gPI7A1rNxgz7Db
 H6_stCOK2ynmt38leFNQ5Lb1uKzeZ.ucZLTEBS.dci5CeE6wWTWZbnKOgCYKu5xAwOQjP1UHhQ0c
 g69PYZcx1xAivyR.sQ8a8tk8ECrm1Ay9e73MT5qoCsy0cLid88eoVKvJJm2thLmibf4bs0QTDul1
 _zs6TZFY1FbuQG_oR_IszV7HQbkP0mK8IjGcGgzZ32.9WY8nEU2F7sfqEmMruLmL4v7AISjvyarb
 Sa4aIy3Mp8GoHRX_GBnOtGdO95pCuoDYuYUNPjgszbyX8KymMSHBvXusCqAD5JM74eRMbnlMMZMD
 ZNYjwENaQhkfB5IXJw7LFoSxd59wS5M2MMUrF_ddyG71vgHTUOtqCetVKzZCNU4dtJ5fifMUIRlD
 Y5TEmzo3y.j.0.tPCrlOQR6pqcB1fvAKm_GzSVybJG2Fv.8yF4b1lQrLB8afWPvepOKAHWmsTfMs
 uhoq.V2K7TzWJuKCthMXLC4MCGX3EU_ftJTjEJwkQ8KrpWJsLi6iglFPhq0ZNP41p.8PHRfRfbw1
 R3evCEHmV_XLZzycSef68I6JfW8TchI4UkkwSrdepWSoBUO7KtUnT_7i0DY_cg9vfUKLZHestgGv
 Y3hXpgkhtZMmtHUxxuhga5D35EJ4CvQ7hEO3cjcmWsB.S40tAtyQp0xfLQJtbp_aFruL_sJ9OIG2
 qGccXD3ia_KztqbC7O5Kw_YcII3AAhZ7O7OPDfymXc4YFj3TShwIUFNSCBskDOqC5gRR0OkhXFgg
 SZxPS0kwIRq9XT85nsU_O1RBPWVr4DHwLRE56ONsh.riQByKNDGyeR4xa.JlHgxPeGNjISIJyvQ7
 qdeNCSgCgzRIgDiDjHw3IsFSPRfjZeS_LMDhd8UUyHYGVTpUZOoP_oUARJczeTMIiuI57IT_JSr3
 e3YSJYuvaeG4JsSNk2xpqIg9xPKojPJ0xV0J7m..Tu7D_GHHcAyn82.IevSkiwm8jX0z6nbtzRjW
 r84tOg2yMos2BmIgK0louNWvIilbC4sbMDYDjC4sUA.3N1FvEdCEL01ravcm1XHUGjCVzQbrsc6t
 B407k_Z1d5yZZfXAIk.eoHqX7IC_owiWBKsqPz9f1Lj8BvW99c3seCuU_D2bTSqwSQY1J70mIHr3
 .xsGjQBJzYGywZ.0pmGyoH68A7WBTGpIhwnTER_hRr9RHTv5yD3yafsC219xsy_vnzpnyOuM9Btn
 jjRxCoQVHbi0SSTx03FeyK8sYUthzXZjJjlw7Jjo0ojbfoM3Tkt17XcwfA36k4_ohZfketwEOUru
 WS9vYmEjc7RtknLpOJT5ttl0v0abDHvpx6Pf8C2GY0hgYQMOTmh8Swp0BiqjdIqtPE1kAtrkwmbp
 Jw49PPxuTHRrC0TB6ZJiqa3cdEfCqmEL.nWrX5tp6Aj2WuiIYQdsvF2nN0jz9S4vU1qniJEqonym
 .b4w71FqWVlQXA8Zp0jOxWfGMOdxmkTQ0qPVHEm6Mb8RVEBj6PBU97YZEZFv7rVY6HYpRPtmg6Tv
 WfDmJ97SyZ9.OWCZdzHVgQ_DzbtpA8NK9z6D.Qx66tX3y42ekzG.kaf6b6wNVReq4VzrAsjfQtZA
 u797fwacLNq0OGSa8v5CpLKYhHRp2OF8k77EUiUTgecvGL0Tg9.yvadv4g5u5GXshe9t3_268E0J
 Qo6FTymdIzt_VPhWhPfT79cXDCA55te4ImN_P
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 28799e42-f718-4a0b-9c70-1bb863c9345c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Thu, 13 Nov 2025 07:19:14 +0000
Received: by hermes--production-bf1-58477f5468-5cz64 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e17cd425b8ad63cf024c60d82cf60d04;
          Thu, 13 Nov 2025 07:19:12 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH v5] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
Date: Thu, 13 Nov 2025 08:17:56 +0100
Message-ID: <20251113071756.40118-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <20251113071756.40118-1-adelodunolaoluwa.ref@yahoo.com>

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
Changelog:

changes made in v4 to v5:
1. Moved the send() call before the socket type check in Test 2 to ensure
   the unread data behavior is tested for SOCK_DGRAM as well.

2. Removed the misleading commend about accept() for clarity.

3. Applied indentation fixes for style consistency
   (alignment with open parenthesis).

4. Minor comment and formatting cleanups for clarity and adherence
   to kernel coding style.

 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   1 +
 .../selftests/net/af_unix/unix_connreset.c    | 178 ++++++++++++++++++
 3 files changed, 180 insertions(+)
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
index 000000000000..9cb0f48597eb
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
@@ -0,0 +1,178 @@
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
+	if ((variant->socket_type == SOCK_STREAM ||
+	     variant->socket_type == SOCK_SEQPACKET) & self->child > 0)
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
+		/* Accept client connection */
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


