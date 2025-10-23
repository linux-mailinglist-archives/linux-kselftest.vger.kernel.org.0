Return-Path: <linux-kselftest+bounces-43925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0662FC02AA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 19:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30271887BF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 17:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374053126A4;
	Thu, 23 Oct 2025 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="c/11bhLd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic301-22.consmr.mail.gq1.yahoo.com (sonic301-22.consmr.mail.gq1.yahoo.com [98.137.64.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7592BE04B
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239375; cv=none; b=erd6v0IKjoE3LNPOMDkjm34gfAATyACEPc4cmuZi842mjMAh+lLLki76a3y1o6B59Zz0MVwkqK0XV5o5RcJfiAXbIGtVaSgDb/jigob5q1jE4lVy86bksPqpfPwa+1UDyCCblyEihiSbHdiPef1WJOyIcK78MfjtVJlJcGl1d1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239375; c=relaxed/simple;
	bh=KFqopDkBEiCrbld5q3DTGIggHWqhFS7hzvpj30A8qxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=bGBlarb54tzP+16GxQkWhSZPxCiSzJQVQKRRX9YdrHdmIUM4xqy8BrqVnZ8la/+6dI7CSByy7fIGBZqrO6CgFshc31seN/P5l1mSTOP8nVNj1mF/aiv2BPD/mUQrgjE5KjyZgB8Tw+f4GLTTXUTl9ooKwff4/i6ku7o7Q/m37Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=c/11bhLd; arc=none smtp.client-ip=98.137.64.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761239367; bh=aE7BZdVLXACw6vs5pCwkddvosD+AqEq+A3S2weE6JD8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=c/11bhLdB3V28OP98WBP7idZCApxU7FciBNBci0G7D7DroBzYqepJeER1m47srFvUvYxzkrdjVzQUf99icHIa2GRG4b6eP/fNG1LFr/pdhnS75SRy54wMXSIybfSSsjFZYOH5+TrTSxon6BLSU600PfF+8VBJlBtSqOQASmqRP8grs2E7ql4GnyzDpQ3A0A0T0l87Ub3gOkD61R2KMuf9J/NxKPsC4C34thA/A0ojNgorlVHsl58bTHVCq7lNrhf3ZyjJWzpvDhqMMrtFt4kpOMXHZH4VQTNzo1/bsKwcIGemwqfk01dcD540obCo2hzHVeZPhWCu15FdG7eYwx9HQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1761239367; bh=oq0aoPZczol9QA8G6RbUGCygOe0A/46JLuT/+Fy4zsV=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=bPku3vPKyA8qRBItOlWdXw+fDkUIJnZrhi+SCvWkIfHhCfmjiFiFnuIZRWVJzL9Qo/8rnR6pjOCq1tl/+BqOU6wbXg4iXYoCjRnv3maRdVZKlGAAqx4TqOttO/NLPuemC2X04jtR6R4VdT5jrk/nXhZaZC03TNhvAZ3vXO52cPwqg4XkDS+coLlkrA5skmuAbVaSG9+S4yG2PCHj4m4aYZ9GwHNatVnBPEfDIx+G10yqwu21blWPT1UbrIEwWkPCnmzwlTFoYhdk8SDHJZWPug06c6HN0hH9Sr0PQCcFgREgiRboewSesgAlasZVuvTlGan3ZCukxwxscxjJhvqF3A==
X-YMail-OSG: DGMwEvcVM1ncOWOEqQUXBcdSDAgu_7JM_I4yVS.5DqP0VDaVL8Xukdru8JE2N9A
 8u4KqRgQILC1e0tBzPaBAEsgnyfrdG4Aow.NLn0B.Ze_acY24yD11p4d3Pany_WOTqCFa5rVp4LM
 v1oDBRvNPgx1fo.Z6RV9EFHqcswqlMTY5B2LKWRRXSVvHQKK8nWnU6SHKzoLtLwbk8wsNa0VCuZ_
 jJLbjWdZ7jM2x4S.46PdAfSdUgV9IKSEbgtSM0qmLAIugmXtkRvTcDChzGPt5UhDg4CRbc9Qmz0L
 BUjHcT80VsVzz7etv2BLsRYK.aRztNMSm.YFT0dYIIcC9.HKudYT9kMG039GjnH6aUZQ.HXsq_Nf
 SMcTBpE2qz8aC4YC65jN1mrciNWJvxTTUsOYSETSJIyguVTRQ04uMZ252DXYUpwmpII1bf1vJnsO
 qkLJk_h6cUukQxZ1Bw9NVn2FmQPolbOpZ9gfTave_Jc_pMcQZOBRyPNvcffzxJPH2AuoQ._HbS.5
 bV3nhr7m_9r25KCfjg3cVURFYnJ65SkMt7DTbmkcu9mIHDSGL6.9gUGOhI54MmZkMS390HY.K3QP
 .2bpQpgAfnY__t4PllL1tVawFERPXmz_R57nKsFecbW0BpPJ2sqyARqAG_2kxRdBs3V0u9jRJZmo
 Kb.FrOXO_zGee7MNi3cQHrgODg11OF17HJadjlg4FC5IIVm5_kxrfNhauG58E8yiFenpd2gKpm0A
 oDkOSEw3v5UCO9NVPnwixtpg5pnWV3iSCxEz58Px6UrUphV9T72QgGU4h4qYGuApzXGEP62A4GPz
 7JBuogkYAQfPXSn67rs1Pj1Ke6dhTasP.j.LS1DI3z_YmgT3ry_V9sxIlWrd6fUkWe.NbuVtZAg2
 HTih5wF77Tm.CyHNS3h1zeeWn6z4K9mJL8G4gcNzTEFAR6rggfPEwAdEamSBi44Lvka3aEX2zTHH
 7nfWExWfzgSjioui89orpjQxXg1Kp7egjPqVE5p_pxXnHaLWnwus1V0cn0OUBQ.mHFx.v290pd.O
 gkuh4mrOdP5JQHekJRJegQ1mUOp08z4I4Zeu1T8AJ2trTLMdbZdhQFokW.riooPZ0wcnVYulnGAL
 wpmyDNr1QUYHWIop7lcfUhdNfQvIxmEgi8SBDx.5kpsXw5wl4Fsv4.nX0jOo841IUDBBIPv1TMzu
 1Q6mPTjsdeoVbCYQ4nYZZIZWbGPOLW2OxMI9mT1ie2gLhLPwjrDdLEP0Snn66WVZrz7Ukqe43t5r
 43jVlcH0MaMndQHSjQCa4KkJP0I3dpMzz0PjihndUGwlUEuxNPCAemKksllF6XBR5U1kLVXppWhR
 QyINjuo2nWeu1vMUiDgkBoy_FTaAWl3YgiPF4zppy4izUM_x1dt_VhK5FwL3g2P8o1Kxwhzqor7l
 dz.dHoVdkWnM92k3IFcLp2c23tgNbcWSNXsIXdGWBUNqZa_FLUBfpiNw5SvY_yP4XXykuTtjzntX
 v_R_dDKg8VROCAN6jSXwWzO3q.cg_zUvI3dRUWWlpKjCyk9EwyAEs6btfMbgNJOOFJ.WD72li3xl
 hsbtuNSNR_d5T0giKhZ48NrYitxeE2N8MJdAHyVP9k7v3SnAX2jwvjC84C8j5Rryppo0R7hWnEzN
 1CbruE8NpssEVt7Hk4ZDivZPmRh5v5VyIdtpvqpQY2h8.UPNIoQKYb3RsDOkTzSON0MMd2yppJlt
 Fc8nF2WiVN90Su_g21S9AtSNjgtn4l5voDOtuZaAs5RwATK04wVyuhGi9xksgmtrDZfOIlVg_MTg
 pQEpCnHIbZszh3QVjrt7VSeiXLaHylJhEThTIi4PmLq960GbX6UdS3dnZL5Ywqn8dua.MeNhfh1X
 usPLSdtpYjCYO9DN.8Bez4BqfTMQUji8NcBJ1if83hR1rO.B.X3Cj59RYN3gYR6fPHc3cDHzAsgx
 BtloXgWGl30BZqP5O0ucPKyTSAylIqX7B9mzdpgBwgPsedslO2qxajOabGxRQWtQu9yeNogSVIdr
 ST9STUF2U_gfjUyvzwB7QyImli12OTGk9jllSeaWkeL2U_Xk2I8wF3VwGg4mK6HPGuTGQqOIyAPP
 QhKBdzJ1Newhs6NkcNv7lHLRfSezbPBZcjHuO9LDDITbJ92ONTHnNJ9W1fup8fYAHZ_QLr1OoNod
 6f5BNQqDJ929NkA4bvXgEdZqxHKuBpSwdHPFHSO3X.vvSBn6QB2nMaarfLhNZjoV90l4mlgz0RpT
 6KegQtDZbOsCS5tpluFPuzivciud_8mgdis7czWqRmz9Yp9oKh9l9l7SqcWBbBIU7UEvDc5Lrceu
 NN7lYy4JB8.fA6dF87_Vo8Y5dPtEX6xQkpKvHGqjHr1yfDw--
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 044adbe0-9dda-485a-ac7f-ce6fb413e457
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Thu, 23 Oct 2025 17:09:27 +0000
Received: by hermes--production-bf1-554b85575-xddmm (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 498e7fe45cb99d44ce36632502ff7f70;
          Thu, 23 Oct 2025 16:59:16 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org
Cc: horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH] selftests/unix: Add test for ECONNRESET and EOF behaviour
Date: Thu, 23 Oct 2025 17:58:41 +0100
Message-ID: <20251023165841.8164-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20251023165841.8164-1-adelodunolaoluwa.ref@yahoo.com>

Add selftests verifying the EOF and ECONNRESET behaviour of
UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM). The tests document
Linux's semantics and clarify the long-standing differences with BSD.

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
---
 tools/testing/selftests/net/unix/Makefile     |   5 +
 .../selftests/net/unix/test_unix_connreset.c  | 147 ++++++++++++++++++
 2 files changed, 152 insertions(+)
 create mode 100644 tools/testing/selftests/net/unix/Makefile
 create mode 100644 tools/testing/selftests/net/unix/test_unix_connreset.c

diff --git a/tools/testing/selftests/net/unix/Makefile b/tools/testing/selftests/net/unix/Makefile
new file mode 100644
index 000000000000..a52992ba23d9
--- /dev/null
+++ b/tools/testing/selftests/net/unix/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS := test_unix_connreset
+
+include ../../lib.mk
+
diff --git a/tools/testing/selftests/net/unix/test_unix_connreset.c b/tools/testing/selftests/net/unix/test_unix_connreset.c
new file mode 100644
index 000000000000..a8720c7565cb
--- /dev/null
+++ b/tools/testing/selftests/net/unix/test_unix_connreset.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Selftest for UNIX socket close and ECONNRESET behaviour.
+ *
+ * This test verifies that:
+ *  1. SOCK_STREAM sockets return EOF when peer closes normally.
+ *  2. SOCK_STREAM sockets return ECONNRESET if peer closes with unread data.
+ *  3. SOCK_DGRAM sockets do not return ECONNRESET when peer closes,
+ *     unlike BSD where this error is observed.
+ *
+ * These tests document the intended Linux behaviour, distinguishing it from BSD.
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
+#define SOCK_PATH "/tmp/test_unix_connreset.sock"
+
+static void remove_socket_file(void)
+{
+	unlink(SOCK_PATH);
+}
+
+/* Test 1: peer closes normally */
+TEST(stream_eof)
+{
+	int server, client, child;
+	struct sockaddr_un addr = {0};
+	char buf[16] = {0};
+	ssize_t n;
+
+	server = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_GE(server, 0);
+
+	addr.sun_family = AF_UNIX;
+	strcpy(addr.sun_path, SOCK_PATH);
+	remove_socket_file();
+
+	ASSERT_EQ(bind(server, (struct sockaddr *)&addr, sizeof(addr)), 0);
+	ASSERT_EQ(listen(server, 1), 0);
+
+	client = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_GE(client, 0);
+	ASSERT_EQ(connect(client, (struct sockaddr *)&addr, sizeof(addr)), 0);
+
+	child = accept(server, NULL, NULL);
+	ASSERT_GE(child, 0);
+
+	/* Peer closes normally */
+	close(child);
+
+	n = recv(client, buf, sizeof(buf), 0);
+	EXPECT_EQ(n, 0);
+	TH_LOG("recv=%zd errno=%d (%s)", n, errno, strerror(errno));
+
+	close(client);
+	close(server);
+	remove_socket_file();
+}
+
+/* Test 2: peer closes with unread data */
+TEST(stream_reset_unread)
+{
+	int server, client, child;
+	struct sockaddr_un addr = {0};
+	char buf[16] = {0};
+	ssize_t n;
+
+	server = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_GE(server, 0);
+
+	addr.sun_family = AF_UNIX;
+	strcpy(addr.sun_path, SOCK_PATH);
+	remove_socket_file();
+
+	ASSERT_EQ(bind(server, (struct sockaddr *)&addr, sizeof(addr)), 0);
+	ASSERT_EQ(listen(server, 1), 0);
+
+	client = socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_GE(client, 0);
+	ASSERT_EQ(connect(client, (struct sockaddr *)&addr, sizeof(addr)), 0);
+
+	child = accept(server, NULL, NULL);
+	ASSERT_GE(child, 0);
+
+	/* Send data that will remain unread by client */
+	send(client, "hello", 5, 0);
+	close(child);
+
+	n = recv(client, buf, sizeof(buf), 0);
+	EXPECT_LT(n, 0);
+	EXPECT_EQ(errno, ECONNRESET);
+	TH_LOG("recv=%zd errno=%d (%s)", n, errno, strerror(errno));
+
+	close(client);
+	close(server);
+	remove_socket_file();
+}
+
+/* Test 3: SOCK_DGRAM peer close */
+TEST(dgram_reset)
+{
+	int server, client;
+	int flags;
+	struct sockaddr_un addr = {0};
+	char buf[16] = {0};
+	ssize_t n;
+
+	server = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_GE(server, 0);
+
+	addr.sun_family = AF_UNIX;
+	strcpy(addr.sun_path, SOCK_PATH);
+	remove_socket_file();
+
+	ASSERT_EQ(bind(server, (struct sockaddr *)&addr, sizeof(addr)), 0);
+
+	client = socket(AF_UNIX, SOCK_DGRAM, 0);
+	ASSERT_GE(client, 0);
+	ASSERT_EQ(connect(client, (struct sockaddr *)&addr, sizeof(addr)), 0);
+
+	send(client, "hello", 5, 0);
+	close(server);
+
+	flags = fcntl(client, F_GETFL, 0);
+	fcntl(client, F_SETFL, flags | O_NONBLOCK);
+
+	n = recv(client, buf, sizeof(buf), 0);
+	TH_LOG("recv=%zd errno=%d (%s)", n, errno, strerror(errno));
+	/* Expect EAGAIN or EWOULDBLOCK because there is no datagram and peer is closed. */
+	EXPECT_LT(n, 0);
+	EXPECT_TRUE(errno == EAGAIN);
+
+	close(client);
+	remove_socket_file();
+}
+
+TEST_HARNESS_MAIN
+
--
2.43.0


