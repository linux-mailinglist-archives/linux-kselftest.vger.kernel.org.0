Return-Path: <linux-kselftest+bounces-44580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA0AC283E3
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 18:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ACA043497B9
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Nov 2025 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA432F6933;
	Sat,  1 Nov 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="B4a84l28"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sonic301-22.consmr.mail.gq1.yahoo.com (sonic301-22.consmr.mail.gq1.yahoo.com [98.137.64.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4DF25782E
	for <linux-kselftest@vger.kernel.org>; Sat,  1 Nov 2025 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.64.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762018438; cv=none; b=n9FnAOXyiXrTuZmzdaT99lD2qOamuyB8lVMAerGvijtT2Eb4rFM+bPURp1s3/Ft6eUB6w26Rc6JuWFMYt1uZtMh67RFNCdt1dw8PUVbhOI1L8QWQ273KVyvv3InWWaWztomdPkjdJCtDkZJ2+RygbCw5Pas0hk2SmuXQfujT9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762018438; c=relaxed/simple;
	bh=e8ZL1LyoygB8SkFsYZxPEgVD1qzn7F0jji+VxJfTDmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=IHqIjuIoSWqDqr1Zg5xfRs7KCRxkhJK/Met/wHx71khieB8sYOwPwtca73YrFjXjR1DRN+bWMYwMuqX8e2BDEaiVDQz/qEl5b4USSh0B/TlKe7bK7aDxjeg6tzLADIjGd0phGADersU7jTZePb+KBHKQS4LJtmN4Y20/YBn8OG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=B4a84l28; arc=none smtp.client-ip=98.137.64.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762018435; bh=Yk4tqq1qBX5rpgljBx4Mh6L84HEjoDVO45tWqTdErbw=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=B4a84l28kAxsKzkaDtCb6TyB43u5FEK58hEI336i4riHanrDYH8/3S3vdcwMH09ZdVLymZ5RLVZmntRcYj2DJC1K0XwOrUt85nsMLNDDzeq/ha4Wj94lvZVzi2q++NrVoc2xgv4fBusjuwKevACEH09YtJ/jh+fHBBeNfFH3jkPtWy7kEOId+tGrjDAfItnYv5c4ZQnlAV598JnFBcC+zp+Dl1WCoTNsE4keeAKO6j12x0yESipB+VxfXwfPq8Tc6xQxogzdbqNz6myEQ72Tr5rDbVx/Qn7V+UyOlNF16ndEDQBsdIMSoX5NJKM5gfMTtS9dTDwfz1v108QSrU/syw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762018435; bh=qdQ6I1LDhsRvcHS9hlaASgf5xX8GaLJRT/1nBtUGIhJ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=ADzm3eVP/Zz4QSgdjXbgY1ZzTf6X7j5np7gYGuUJVTg8G94l9n6K7zouOug9xdoAWb/qZ1oGE/4ZoiHJM/f175Rhw+Ve6IsJDkgow9ujXqbEnkbR/9skBRoH5AjWXMN2vVyd2IdA2Pp2V9AQu3L7Ecp7P3iK3xKqfsLaOWdj0I2ZewHSZJITPkbmhX0cBE8Ejl3Eru+qnnIKgvQzo/5lAFisSSoNSepuHyMhz7IdAEtUjC4KGlIBcQfnz5x0a/X2fUUmXcw1gzmiMGXEgYvGMZSII1A/LXG50thXkGeYaWVLKz/ATwXnLry31SP1X6Mt+MXNPB5s/76kJ3MpdRsq7A==
X-YMail-OSG: cxGA.asVM1llPaQ4xJFPgaiQLfRshjmjJpvlGliUpT9wHdxvbx81mFyAu1ZtAkC
 WaxkgVIqGOujmxXj14boktK..vB30pNRx0bnD5648vn1fBDaTtGEozkoeRVXZMcZ5kHIH28nEZE_
 IWXpmfNu6HK4WrzECd691IcVhsgkYMI9DgDc9OsYkZdQjfAhC6DVXRnYxJavzxgTxwKkSkRq2lgS
 lAq8H5n4u6K0GwFBqbp73WT0kgQQqH.xDixG1oQqabHzh4J9ELzppmGZu.8z3W8PbSe2l4hmHf3A
 DHNadRWCezq54L5POAwBWlWdQ4gkBUYx7gCPPq2LiWCA0bI3D_eNEVgtQVzk7dNLmL6X8gFcJ4DQ
 I4JWXbfZe4PK.RsKClX8f8oBlZR5Air.4ffKQkcrtaaUxj1Zu7bIK8FkRfvK56_g8QJfdBw_fcV5
 RbBJmP4p40wCgb8iZQpaOX4YOqu0b4ijJXxkSi6M0ftEILvlVRVnmp4L3Qjo7mYydXBJ2Bm_yGtt
 ksrOKFVyy5st9R7CoO3hf.Wh17cB0gq1Yje.8y8riEMbaOiy5m_IAdDUQcMxgXd.BcWqTVpJPiCq
 WBg_eZYhwf8nBlurcdtHax3Cjh.12clx9ym8kEzahgIW30aM47JHAc2yJCq8XyA2onQ7oTV0MmaP
 GxLTafsSxWbKgXEMYsFCbPofQJCtp5wAaA.D1WkbtZ9LEOQjn95eKxH3g4lagB8DzMTqGJYfnfTr
 Nu7rTd_GdXVf6CZogWr6Afrt_RkNCFIk.GkMp4a7nrvVau5L9akFo__DCL.W.wshtQ.aobF_lpbV
 _J4r_3z70nTY2rAxCGagN.XGiOtx8rqyPpSULMZtmbakD9b_Z9_yO9Dws8EUxXxECihuALbLWTA5
 kmHLX69U6ro05zBxSMvcuEyByfoKlZoLD5LHKw_2x0IUaGOoW2Hj1VdZHp_YMAPqm1GyAq4LDtQx
 tUk78pkLC8MPLaeU6.hIDgdgsUphhOSpmXPCjhaI4ni7dJvccjndhs_o2cZOmaLPplQ5pyXmHIWx
 ebLe7_E55d9Eawlj4RHWyL2ip1YBPGGFmonjPK9zA46Io90nEaqse0kBU51xgBh7fzN.mCoVNJmb
 pSt45Fs5Lox5E4_jwqdfAsYb7VJif3HZdUvV7Oq5I3ieupJ9Afg3xNxGIryhjwp34HTePHtDdtZn
 UkpNC47_XbaRyuU6NrXH7S5gJsrM7g2yp.7eti42nM8bvixyVuFlCAKyGLjtOuLfIvYZIl_XliHv
 .h81Y1tmQl05tJdl2RJfEhsjXkrJntvuE3uXI6i.22kjpUGxDLXe36_Xg2JTbyufssfWYzI6aBhS
 BBmG70qOdgaSSg9TYtWYiFuS4.FIKVVZvHxozQlUz9dDKELrPDBEO2UtAhiASseP3MKZhv.Venp1
 JNygxfY9BuvU53296Q2TbVYcxO01A7JHhOvyJ14wTR3_ygqzoREhgdZ9UMM6WbHntSs8OAbK2mUo
 FXsuaUWat49AqdKe1BVhJTanhmJO7zkDPyJ8aqUVPDFv86PHO9uSdxNkT4pjDI0x0r_ItO2jqbha
 ZKQfL6cZTOoaTwgtBPNPYXf2Dwuw3RROTrjqe8G0f4TrSbYuENRgcZ55.ExuAZ95PaPwnbv9jlXH
 SOhspyqKdlPAKiNzlRYWY4Os6B_cunV3MvXscUXfOOJKqq5JaDps8mIvdRY7DJxM5VL_N1ldxht5
 IIi.9G6VY61Qs.fd_NTRY7aziSriYN1jrqtPzeEImbhXZxEoLGDKF687CwfUGGKyNIr2QDVL2Qgu
 Ib9EuvSbg9d0ov3M3EQeMd8QoqlR.788ux1mPnUjN3rw_npKD7bnB_1.ATiY.4Xjuaqh28abQQlQ
 T3syO3wvK29W1vsB00woAz1kbvu2GGQC2kF3RHXY.dhzi6Qb0cPzubpdtrvHHlQeWDoUFjJoB_HV
 84LHzHEMQ621CW6aO55XnyE0mxSQTlT.7NENKTfm96.CE1eeStPVTOyCy_voP0mCzS3lQvf9ezGc
 flkSaPtK9mHdCZi8pojbaj6jydENP0EsJVi0eDvOJW59E6cjvfGKyoYhoa0BC_8OQ2Tu5F.MzNjX
 Mj.5hAk6y7SHzxyWrO_KOZNNxhupqed_uB7A7DV0lSuUPARd89rpNsb.RIbjAv28hiKbZ4n3RCwD
 WV993nmj3xBluyJayaKUVhi__iIhYP6SyX7fbqc99r0544enwEny5c9vcDfZj_Wvpx5k0lnv0fAh
 cB2ylzqG2kfN6WfiMuODQqcV06esTC8gjC_pqS9vrOr8sjHvNbtcR8UY_Fqrxht1_xPu84UPQHIX
 yzpNjkMtLjZqnL8_E5F_1Dj08M0th2S0yam8-
X-Sonic-MF: <adelodunolaoluwa@yahoo.com>
X-Sonic-ID: 24fd7ac0-5fe7-458f-af33-a32fc4a479e1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sat, 1 Nov 2025 17:33:55 +0000
Received: by hermes--production-bf1-58477f5468-2sh44 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9f9d36950ad92c3931718f2bdffb5879;
          Sat, 01 Nov 2025 17:23:44 +0000 (UTC)
From: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
To: kuniyu@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Subject: [PATCH v3] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
Date: Sat,  1 Nov 2025 18:22:30 +0100
Message-ID: <20251101172230.10179-1-adelodunolaoluwa@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <20251101172230.10179-1-adelodunolaoluwa.ref@yahoo.com>

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
 tools/testing/selftests/net/af_unix/Makefile  |   1 +
 .../selftests/net/af_unix/unix_connreset.c    | 179 ++++++++++++++++++
 2 files changed, 180 insertions(+)
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
index 000000000000..6f43435d96e2
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
@@ -0,0 +1,179 @@
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
+		variant->socket_type == SOCK_SEQPACKET) {
+		err = listen(self->server, 1);
+		ASSERT_EQ(0, err);
+
+		self->client = socket(AF_UNIX, variant->socket_type, 0);
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
+	if (variant->socket_type == SOCK_STREAM ||
+		variant->socket_type == SOCK_SEQPACKET)
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
+	/* Peer closes normally */
+	if (variant->socket_type == SOCK_STREAM ||
+		variant->socket_type == SOCK_SEQPACKET)
+		close(self->child);
+	else
+		close(self->server);
+
+	n = recv(self->client, buf, sizeof(buf), 0);
+	TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
+	if (variant->socket_type == SOCK_STREAM ||
+		variant->socket_type == SOCK_SEQPACKET) {
+		ASSERT_EQ(0, n);
+	} else {
+		ASSERT_EQ(-1, n);
+		ASSERT_EQ(EAGAIN, errno);
+	}
+}
+
+/* Test 2: peer closes with unread data */
+TEST_F(unix_sock, reset_unread)
+{
+	char buf[16] = {};
+	ssize_t n;
+
+	/* Send data that will remain unread by client */
+	send(self->client, "hello", 5, 0);
+	close(self->child);
+
+	n = recv(self->client, buf, sizeof(buf), 0);
+	TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
+	if (variant->socket_type == SOCK_STREAM ||
+		variant->socket_type == SOCK_SEQPACKET) {
+		ASSERT_EQ(-1, n);
+		ASSERT_EQ(ECONNRESET, errno);
+	} else {
+		ASSERT_EQ(-1, n);
+		ASSERT_EQ(EAGAIN, errno);
+	}
+}
+
+/* Test 3: SOCK_DGRAM peer close */
+TEST_F(unix_sock, dgram_reset)
+{
+	char buf[16] = {};
+	ssize_t n;
+
+	send(self->client, "hello", 5, 0);
+	close(self->server);
+
+	n = recv(self->client, buf, sizeof(buf), 0);
+	TH_LOG("%s: recv=%zd errno=%d (%s)", variant->name, n, errno, strerror(errno));
+	if (variant->socket_type == SOCK_STREAM ||
+		variant->socket_type == SOCK_SEQPACKET) {
+		ASSERT_EQ(-1, n);
+		ASSERT_EQ(ECONNRESET, errno);
+	} else {
+		ASSERT_EQ(-1, n);
+		ASSERT_EQ(EAGAIN, errno);
+	}
+}
+
+TEST_HARNESS_MAIN
+
-- 
2.43.0


