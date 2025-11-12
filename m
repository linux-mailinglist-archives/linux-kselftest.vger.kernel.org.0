Return-Path: <linux-kselftest+bounces-45464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D119C549EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 22:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C317E348EBE
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 21:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E1D2E1726;
	Wed, 12 Nov 2025 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="CIdljqdH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic313-20.consmr.mail.gq1.yahoo.com (sonic313-20.consmr.mail.gq1.yahoo.com [98.137.65.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3FF2E1744
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983052; cv=none; b=MxG/XkAYRvhgdWsM5spmE0rrtvgP2C7Dx7tvo1wVW7GKippQQto8R0VFEkmVVfMPFPqjhhkfssQdC3iEwCBBil1zTpmtXRXa1ScFuASsLYxmsvSbC5vzSxXM4eQE1gQIw5ExqpaHEK9eyR9j0GV2mrW/ooc4JNit2YRQXBdJgr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983052; c=relaxed/simple;
	bh=mRDN71IyYugANkwKAWQn2IRDfPJK6+khLjRHl4tVJ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=CNFIUWMIe+boDi7NC+76ySnCkeW/HwV2T1TTAB8iPrHJFU3eqFdyrZsAoTWCk9q5QtY2tQUsfNjGuSm7lmXWHi9IxI4OKgsKmyc90asx2K7x/Lrag686Zgi0l3fJQutBlk/MRiJ6RAkKzSqN7aGFwawrboXFICR2QzOX/tGqxvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=CIdljqdH; arc=none smtp.client-ip=98.137.65.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762983047; bh=8Ji2M92zqwuu+KBy+vvEyjj8iMcTktjY20tYWDdF7Aw=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=CIdljqdHeZLwHZnYBa/fBv7ynrgAT0ttnY9Z+n90gDmOEnICYtZWrVRQ7dfbx2GJkYvwez0SndilY7PbS8NIxd/2HLxcbo0oKZNqVLDAP039in8+CV3t1W2HZerLG5KBgCmDFusrNVEMsk0WF39usKpepgIlNy2XNYmNysDNcIljt3wBR6PNiawMEzS3RdBeSxMxTbG7ZxcjEtAh2Nm/y16lrh6VoZCbm8wWV2PEq9xrzhGRuzaFU7xWlKjiH+WZiQxw3hEcR1/CpO6dFeRvpQNJ0fk5NX4sP+rpEwF25rXf6v5kdFmKAS4BddWen6T7qywMM/lJ2qGlrYH6K6c5Xg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762983047; bh=6b0wXGqap3+YAyv6wQgnc+h664FIUwUqe3O8K6CFiSX=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=sPmpa9bkXdGQQZRcrFW2egjQgRxfzIS8oeybtFX9zCgHvhMKf5pz4i+m89cQUUVxtzRJnZGal11lQGqThejjKqbOBlmWEee7bFqkthAmLAS7PVW6MqYZeUMy7OMZ0a/iF/Fl3NYthDjU7YsIG2pnZ1aWqHQqerR/PFL8h+dphrX9wxeXR2txEw/b4tTqDcANn8C4grH3tWw5RPVlT8xd3qoAgNPH/q7SdAqszhbg5PSRrebp7joNtoVi/aSVZa5KjpBBDYCUNxMKrkfOscWyVdZer7lOhd0lX9GNhJeiCLw3cyG8T3JsWZKmnPhA2VeUi/zY2w6427hAJ1FS3LguAw==
X-YMail-OSG: sI8spuYVM1nTpc3jP1VJYO4iG1gtsAWZrctAvEzT8Tol8alLIPFoxb9hhDcwSK5
 glsymSDHXA.AsDkICot.zKoGweetjuKWkfwXkRCG69lpoGfJjIh9tgN9bK8sdBu6Vu6PG1Tm1FDi
 Hd0mKjAypAapA7pzWV401iTNc1MAMI_Jm6IoaYc51ENvIzny5cdORcW57TJO0d8as.AkPakQxV3X
 4mVLGBqdPH7ZiFaeYWkwzvWAmomEdV5r80wSBR1CPnABqPa2it2DLRea4CKDNFrUSgQv6VCu5f4C
 SlG2KQ7eF20_Z9Au7Ge.CyxFobeiKtYMXiEu6OrC7xeNMCOd1lNjSaN6WJQqqYBrFDc4JV.H_twL
 .tDZJq1mhl6z.0f_QaT4g5LMKR3fc9XVRFfHzJmmHxvwesh2CmX7e7V46YXjkJYo4KV80Ovo8CnP
 se9nbjKmfr8D4pjaOwbA3sZnMqiQivZnGO3s8ahmQD2lBa0BlMQvVPsAwO2xSsfhVJQTp27NGzwO
 kETK1Id42p6JTSzQWfiQl3Ehxsftk.Ncs4ZKAHeDb8t51JLI8o7WJ6B.CE62_nxGIwJz9psBgHOo
 Y1NkiN1QBOpiMQ5fl7yv4.2lBm6F1MU0WKyUbD.JYCYRRY7arIYPMxfcYPYlONAwgLTmGfOn1N94
 JQfTZFoisX8SrfINH_nkvzKgVrLTaJMfdNtjCRN.CeKl6_DX.yknSn80r3j8AHGiRpNBRsLChT3d
 skV3zvMc_AzlqpYW.xXuGLN0Q8s_i1PW_CLusVxEeFRe2BTUv1WIi0nDzqBNd.fIZNoeVM2lqLQ.
 onNX6177NdOCpY8XMirmG8akC_zL90JyxCesvOSQtbU3qh3Th.qLX0nTadQw6cQ.bJlOX6QeuVKl
 Wxgdo5e6BuoNpdB.N4AtUeng1rIEvMO2K2ToE6XZV..._zoWCEAx410xfp5lap5DAG0gVvem1Ge_
 MWq5VsBfoW.4j5OYOZ.LqFQqSvyMqCc.aq_rSJdyNpfwIhpx1Ow.FQwcyiw8Wadm6gd2OnVMxk_Z
 BizgNYQKiM1yuMu54o2FsKpHHAIDy14WHbxzwBLHEQsgWzOjwcuOL689OJgqOrqCQFEMyptz9H24
 L9CqOSyfSLi0LrEOPtPeNkdLjQUBCx4nFastySJEfFwhrRSDnyn7PM0.IQTDV1dVV_ozor7UNnl9
 e6G8RWRdYaHufO5dZrlv89ZHcX5oEThHMQbnNMJq0UxZfMRgm5ZjzhFPkJhKG_0no70w4LuMWF3J
 5aNHoGgtckN7ELOONsG3ZUehXyBHQiHt6NHO2LmlLH8J_vdFQU_Ib0u_C8obk6fA5sh9CFzGYDfn
 8NGUaxdVBjQW8EMX9QR7kiUFa6O1z6NEgRfMraZo9qEp05E67TARsM0QqYJcEbGp_qVQnPVH0edE
 xR32Hzaf6SfZgvMlxR8KUHa5gFpqkS7Yjdfibn3PRV2xrCj4rNKm.0vB6Nn2CKwxwnJ7QByY4EKd
 9VlV16aVi0uwWxXchkDtWDbVJV.4i9Rju_ShbqCUJ2ZZaooQtyRDZm1SI6faUx8N6quxdXMftK1h
 C.Jpwsa2vFu3ixAkjAXBRw2dkjky_.gDAROMue0JlBAX.0QDwO2I_0ZW4R.4klHuu8AENWh9sMvX
 c2CQq5tyJOXmSFRdyXHlE2KcvPMtPUIe4ibiiR6F5_umS4MbBPCcGAYFvEcMqA6dB3OlycDJCmrZ
 xPXqEOu..KzjKxOqCVKWqchnHMFzGqpve_JHO9Kn8DjmTzMMncPte6aHMSEw40z2Jn5Wlr.hReF.
 K69SnOHJVPSd3TwMLJo_UCqDyqSGKlePOcyXpRYF8KO17oO2moSjliCbCNir55NIitaJAj7829nI
 lLdltVK3MseynkZ_vebN2arSI.FrjGkNgKVoopTzAVR641A6RaXdjxukRlJ9EgAy1dGKdqPukKPq
 UDzql3E0gqTSi77p9het6NRCx7.HD.JpC6MUps415JDh.JWutVBKqK9wGfAJ3B7MYp5gn0aqavrk
 pFDl60m1cEk3ta9MvM45aqDq3D0S7Sgz4BS9FgH5z9ltzcGoM3zvioyi.Et6I0GHTlIeT4M9TwEi
 5wSNtAh4Et2DLRy9LNjkKBRS_Axar5.U_E2OLSOOQALfA2QPrw.NWZliXQABJHTzaXFyGur07w2q
 kYF5IrSP5jo8YmovGAzhhgz.zH2U_BoddGEDfn6wVXguI4U0zjaoGfKOFJoMzlzZUfM.JE0q5DWB
 tArBsHYb8fjCxVkbamE5nomNJHNw1ifjuiuCIRzBFarvyMr7MpKlXKl3I0zLC8bFLQenAogWDM8r
 xEvsvcAYJWmq.XMes2ARy
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 700e2cdd-c8ed-4318-afcb-52ac6506848a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Wed, 12 Nov 2025 21:30:47 +0000
Received: by hermes--production-bf1-58477f5468-psqm5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 995cafb30473317169439b4b5c8ac7e4;
          Wed, 12 Nov 2025 21:20:38 +0000 (UTC)
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
Subject: [PATCH v4] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
Date: Wed, 12 Nov 2025 22:20:26 +0100
Message-ID: <20251112212026.31441-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <20251112212026.31441-1-adelodunolaoluwa.ref@yahoo.com>

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
index 000000000000..9413f8a0814f
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
+	if (variant->socket_type == SOCK_DGRAM) {
+		/* No real connection, just close the server */
+		close(self->server);
+	} else {
+		/* Establish full connection first */
+		self->child = accept(self->server, NULL, NULL);
+		ASSERT_LT(-1, self->child);
+
+		/* Send data that will remain unread */
+		send(self->client, "hello", 5, 0);
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


