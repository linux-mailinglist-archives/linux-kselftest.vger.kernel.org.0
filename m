Return-Path: <linux-kselftest+bounces-44044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B94EC09EF1
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 21:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEBA54E3E5D
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF11302147;
	Sat, 25 Oct 2025 19:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="QOycWTbs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic316-54.consmr.mail.gq1.yahoo.com (sonic316-54.consmr.mail.gq1.yahoo.com [98.137.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474E301014
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418995; cv=none; b=XByIvKa10T7QnmYX/LCPoJQbpOGAjX5hSU6lSp3/7peK2epOvTSAnAxK6XIC+z9Jskfpk4An4bsPEMLh/OLGjrboNf7VN2UEosfTj5evdCGm7NCYvRuOMoAI8HrLUVgDcUPH2M9V8fmvX8oFGG+vuCTYwsMUiGOawU6YgNstxBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418995; c=relaxed/simple;
	bh=jFyEVJKbaMZMuZBCzdfHdAiwDKOcdgljSspCvmfpL9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=jwgf7+ZVtCDXoeV3qHY0DHSON8TQ/Ic5cNsZ+FEDpIDKVhAFgQ7iQFTDnuSXzlc/SCngQf8/L+p8Rz/i4Y41t7ZbzHnaYr/eduoV5g1HJIV1rSOYG137G2DrmF+FdwJJVvmjkbIhRJnuurC6snge7x3TVSaAAQA/kfQ2/jPAKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=QOycWTbs; arc=none smtp.client-ip=98.137.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761418988; bh=Da/zyt0Nf2E3IbFyhnHrMpnX1b+VrIhAFYhJ++AQV7s=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=QOycWTbsLWpJl40qxRwzVt5qaCFMpnBHkKLyECyShDi0cYRnROqAtx7K0lxAVZY1E+TWMSscCDMnT/U0l/XTfXL2AS3DKHMwnDYOa2wzs+fmvtl02sszObspvofJqkdMPCNqAkOijac+ls8OoymGmRL6Wt8/Cp+3GXrJLc6kUp7dV76SH2D/xPj69v7nzDu13J+Dd7sOBx74WZGF79GnGMuKwTrunSjIoU1r/JflWXb9FED0Wd1M9mIk30b96sj9iNoNWFstUTKlaQG6UtWjRZ+xW4eOimASdCg0qQE6acr/5p0pdWJQpbKkn/OQvi1pukO4l05Sw0OfMlyOCU+brA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761418988; bh=PZ4kWfzKDXB8t5HUj+G/aPI9OmePkg+QzMG1n9NkSxg=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Bx8NDdJ19WrGWuGxFNQyoOIIAkB0de8R+l1o0+r08G3meD/hEPJYFxvAIzPUGSbfBG3cRf5IivLUhurfevYB3TG+RpLdb353lLw1PZ5Mc+batOPP7OjRF1s5ntuUDb2ZZDhQkny4X6wHqxTRJnVTYdARynNz4e1phQUDsc3LHscIvKHAq61pLjg7a3eDahrAMITqBlS7Stwiyb3gN9eLUuZTfMbKCjmfaXWlYf7fVLAWBq3m0fqXH6cM6J0bLx65Y18yBp5U9+M4GrUg5SiR6nyyb1FiamTRb4lR4wbtgGxknkSOw2FxDA0q5V2YZBnlme7JgjRpUm16fhF9aCHJVQ==
X-YMail-OSG: AqeFClMVM1lyuOGbVhTTItpzwbtu3lovdT23yfRd8Tawm8yn0vww0JjnqHVMnBL
 fWNk7xn_Gwpew1vhSVtsf79m0biR720zax5bpVqUZ_09f87aITe9GhwR.Sv1x1jFSkEcLEJ9vLIo
 Ix_AxdEBLxvxEmuhCv_noRLvrdEJKP6jBWNTRVOuQ2kyFhWAF6WVu78b..bJhkpAcl4L5Nl_i2F2
 8no1U74gLs8AjgBF1lDGpQZ7t3XHBSkwo5edFN7Hz8s6t4MYTiK_RIkuq3eRro34ecxsCLR91fID
 Dwvf9hytAb5dGEk7JugxKaZRWFqn75TvKPHYSU.OhQcP.YB0ompw8IBGl4rGf.9vwEkf2e5Os_gE
 YokMo5NKfE27mZFlTTRRhTe9QVThzU7vK1y60p32FvJ1rB6zi2wtNi662v24K4cnxTD9S2TmD3o3
 Def0HEAVGmsNbwFEUp4MKnWpb9evwLXLh0cpjROWPU.F7WZqS.P9M5UU1ANzs8ks48LMU08QZxJZ
 .Uieh1X2zdmR.OQv9Wf_A0XVcyo7phYyzOa2Ir5FFDpOnyps9JWlsioR4iicu6g2GSDmYjeI2qvz
 rUbB.w1KKsezRkntKU2.mAoZkXnZVRKicjPKHPysjw8qRJpW2vDKu5IDpVzPvU0D5wEnjAPKVtgC
 eFek5w11GDt8HD02roP9m4vKZaejdHtrbLSuvKJzZS6.F8bY2GNX.XOsdStR8Ai_lEcREWMTdcAg
 M4loVLLV_HgtbIhN7tWLpFdfjVx3KQk1aGmsdRZNODy1Njbbp8amrCDryhvxoNJuZ9nYfinLGH7y
 _eodKUgg0U1vjwAEdaJgZu3A3I4vecGJoEUVGdS4IS1Q.g4.atCzLcHAmgVpUeJ_i1D7SXLdGgD8
 KkbnfGh9gfkj6IrKjYx.tnnEXJwbXclklN6n5y3gei0u15O8fAQ3f8sK5lXbfHBHyNl_A9e2ibLA
 9f6OjnK0iQ72txOL2K2fpF4kCt59d4UyvtmBVJ1gjfb_XjzvisYhS.u.qfF5z4GABIbYKXRgPO1H
 yys5yoOV1nOvsFKjM7KTCCYomIKMXeUvvoCBBW1.KVNobDG30UF2ntglBYRR4z8vNNVEW8OPaxn5
 h1SpFxyS.JJiEGITr0Gh44zWv.GmUYTSXxEEaSMhvsnrssJD3jI6EpkfJ4yyHj4dDy6u.2aQT3R9
 _bXqp047q.I4MM1VI4yjlF0QPNtvPB8Lc5dr9eD1wr.UKKpVSEnEWoMNAqpoQl2E.xNG6uGkAkbF
 N_xnQXgrbMBibNtdqX4H7nEwFX2qqXb2MwCU0Yu0lSstChq4KI6W2n25HBR7.Y2IkRQmLEsqCLsT
 4JPeSkhIysnJW2w8_jW0uII9MO_gc4n.R.uQRdVXuKlGJKC6QIzILpzPkBqbjgv5mDGmlFeAYlyN
 353grPRiGSvA_cKSxavs6tsXCOC13ESCX4JjayRIhQ3xrVAwGRcDkle5qtJsruxlV2GNlcMNMoHE
 CtbVZCSC4PdIosAr0zHI_0fGZhtLn1o3zYjXUVPa9mTyVTEuzbHOEiMepybqSVMiRFzW.cQsIQeq
 Ff3azk.mpu1rA_V.QSYtXbjudCkZXBth2_rixBoKKA1Ldz_Jq4SEtDm1JqbXs_.HDL7ZTznpyUX3
 kkwi.Xhn7f.alKpirB0P8PVv.SeGMJ74M_yrao01T939t3Yc5564vKZW2dOQMkBMCcw33k80Bt6d
 zBL.DWlxVJPZWUiieUw4xfaHSlbFaTRZffMcpcjq8om7hZCHhmUXz3Ak.F3et0mNh2Wy35aasWLH
 s9fmXCzUQbPxM6DIIukp7o30ED6xsyrVSyqZKKBQqniI9ejp8Zw9QtutFpNOdZLpZ_zfLFOaE8Us
 OJRcegH5QTgBlPhgfh5zYpNHRY8dEeiOvWJnrF6Zyut7i44eqesntuIe0XAxxeSHLA4Id.QJ5VXn
 gDL0VC2r_tJEdRGthrz4riHeWjghsDOf.i1hYJ6j0bpYhukFL07i2qp5qilYRVaUyz4TE5WdOwrH
 4sIgnt9B29v7rZPt1vfhDzrAJgqTkn30_TYjCHpzzkz5Ekqhj6mLn04NKhB9YWxSsv_nqIirj5LM
 o98YTnU_D5ITltGCuxYBY7rwC.NeAp.2n1uE4k2hLKJvZNZvEZ2Gr0U9RD3pguLYuCZzS8u996nt
 fea.2DDZ4LJt4_6bk9P2ZKatdikyN1Pji47o1U5i0UgJP8Fd.waXF.3J4g73dC7Km5Q2eiCuVVX2
 7excDesPuz.o2FwgoW2oLAZ94uBvSb9U1KKm217C9kf_de9XA3PfnFQFhxCsGUol9DOEz3usX_nM
 BvsTTSG68GGt_VMlpGEzK
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 88fef660-61c4-4b80-ad1c-0c25f766fd14
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Sat, 25 Oct 2025 19:03:08 +0000
Received: by hermes--production-bf1-554b85575-vmpgr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0ca7b4e896ed0ba71fcca8b2a04199fd;
          Sat, 25 Oct 2025 19:03:06 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: Kuniyuki Iwashima <kuniyu@google.com>,
	"=David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	David Hunter <david.hunter.linux@gmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH v2] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
Date: Sat, 25 Oct 2025 20:02:56 +0100
Message-ID: <20251025190256.11352-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <20251025190256.11352-1-adelodunolaoluwa.ref@yahoo.com>

Add selftests to verify and document Linux’s intended behaviour for
UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
The tests cover:

  1. EOF returned when a SOCK_STREAM peer closes normally.
  2. ECONNRESET returned when a SOCK_STREAM peer closes with unread data.
  3. SOCK_DGRAM sockets not returning ECONNRESET on peer close.

This follows up on review feedback suggesting a selftest to clarify
Linux’s semantics.

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
Changelog:

Changes made from v1:

- Patch prefix updated to selftest: af_unix:.

- All mentions of “UNIX” changed to AF_UNIX.

- Removed BSD references from comments.

- Shared setup refactored using FIXTURE_VARIANT().

- Cleanup moved to FIXTURE_TEARDOWN() to always run.

- Tests consolidated to reduce duplication: EOF, ECONNRESET, SOCK_DGRAM peer close.

- Corrected ASSERT usage and initialization style.

- Makefile updated for new directory af_unix.

 tools/testing/selftests/net/af_unix/Makefile  |   1 +
 .../selftests/net/af_unix/unix_connreset.c    | 161 ++++++++++++++++++
 2 files changed, 162 insertions(+)
 create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c

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
index 000000000000..c65ec997d77d
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
+ *
+ * This test verifies that:
+ *  1. SOCK_STREAM sockets return EOF when peer closes normally.
+ *  2. SOCK_STREAM sockets return ECONNRESET if peer closes with unread data.
+ *  3. SOCK_DGRAM sockets do not return ECONNRESET when peer closes.
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
+/* Define variants: stream and datagram */
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
+FIXTURE_SETUP(unix_sock)
+{
+	struct sockaddr_un addr = {};
+	int err;
+
+	addr.sun_family = AF_UNIX;
+	strcpy(addr.sun_path, SOCK_PATH);
+
+	self->server = socket(AF_UNIX, variant->socket_type, 0);
+	ASSERT_LT(-1, self->server);
+
+	err = bind(self->server, (struct sockaddr *)&addr, sizeof(addr));
+	ASSERT_EQ(0, err);
+
+	if (variant->socket_type == SOCK_STREAM) {
+		err = listen(self->server, 1);
+		ASSERT_EQ(0, err);
+
+		self->client = socket(AF_UNIX, SOCK_STREAM, 0);
+		ASSERT_LT(-1, self->client);
+
+		err = connect(self->client, (struct sockaddr *)&addr, sizeof(addr));
+		ASSERT_EQ(0, err);
+
+		self->child = accept(self->server, NULL, NULL);
+		ASSERT_LT(-1, self->child);
+	} else {
+		/* Datagram: bind and connect only */
+		self->client = socket(AF_UNIX, SOCK_DGRAM | SOCK_NONBLOCK, 0);
+		ASSERT_LT(-1, self->client);
+
+		err = connect(self->client, (struct sockaddr *)&addr, sizeof(addr));
+		ASSERT_EQ(0, err);
+	}
+}
+
+FIXTURE_TEARDOWN(unix_sock)
+{
+	if (variant->socket_type == SOCK_STREAM)
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
+	if (variant->socket_type != SOCK_STREAM)
+		SKIP(return, "This test only applies to SOCK_STREAM");
+
+	/* Peer closes normally */
+	close(self->child);
+
+	n = recv(self->client, buf, sizeof(buf), 0);
+	TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
+	if (n == -1)
+		ASSERT_EQ(ECONNRESET, errno);
+
+	if (n != -1)
+		ASSERT_EQ(0, n);
+}
+
+/* Test 2: peer closes with unread data */
+TEST_F(unix_sock, reset_unread)
+{
+	char buf[16] = {};
+	ssize_t n;
+
+	if (variant->socket_type != SOCK_STREAM)
+		SKIP(return, "This test only applies to SOCK_STREAM");
+
+	/* Send data that will remain unread by client */
+	send(self->client, "hello", 5, 0);
+	close(self->child);
+
+	n = recv(self->client, buf, sizeof(buf), 0);
+	TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
+	ASSERT_EQ(-1, n);
+	ASSERT_EQ(ECONNRESET, errno);
+}
+
+/* Test 3: SOCK_DGRAM peer close */
+TEST_F(unix_sock, dgram_reset)
+{
+	char buf[16] = {};
+	ssize_t n;
+
+	if (variant->socket_type != SOCK_DGRAM)
+		SKIP(return, "This test only applies to SOCK_DGRAM");
+
+	send(self->client, "hello", 5, 0);
+	close(self->server);
+
+	n = recv(self->client, buf, sizeof(buf), 0);
+	TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
+	/* Expect EAGAIN because there is no datagram and peer is closed. */
+	ASSERT_EQ(-1, n);
+	ASSERT_EQ(EAGAIN, errno);
+}
+
+TEST_HARNESS_MAIN
+
-- 
2.43.0


