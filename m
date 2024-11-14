Return-Path: <linux-kselftest+bounces-22042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8299C8EE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF6D1F22B7C
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD081AF0C0;
	Thu, 14 Nov 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="SHVGGydd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="avlyQzU9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F211AF0C6;
	Thu, 14 Nov 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599493; cv=none; b=UjMXaYWii08HQoTzb0rgu77NLDV1cwJLlpPS1lCH7jFq+MlofkVMn5CWm4j0zqeQ47OwqH3B1wzIV5FWprqGN80i1RTZvTYbG/xIE2HsJW82McTqovaCfv3LPy9/xuaVu26gyUpkitrcTXo1Jjb1fC0V1sZWd5Vb+PujB9qQRHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599493; c=relaxed/simple;
	bh=4Pa6DNnO87blpP9+fJjQ6rjzdknBnN6Y4aYsDz+wIKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eROEZ1jH6HEs9M88AT9mRABJp+5ksryFQ9S0eN3MT4OlGYJLxU5p1JpZQK2qY4/4Em/EmI8IZW1pKo0xiUsKZhgzdcuv5KdqNoTElkznZ9CSAmAjk9znpENNGb82TMuvgEnQzv+7jH1fx/l2S6vITFzmuqIWnDWdKmIMqc2Lm5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=SHVGGydd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=avlyQzU9; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailflow.stl.internal (Postfix) with ESMTP id 529AD1D4073F;
	Thu, 14 Nov 2024 10:51:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 14 Nov 2024 10:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731599490; x=
	1731603090; bh=BICk4k0mxFzSs2XqErOIM8b67gtSVvVyQsMxlwRSLBY=; b=S
	HVGGyddmsdwIEpw3KpMMrEeeC+yxN340lnwhU6j4qd9n3zZ2Dp7sYjkInWF3q/vz
	O3402cgLJIkVMQxst+E+x5f7Qv9UEo2d9b+en/bA7HtnDVqZn9eRf3sebXLAQE3N
	Fo5Cp+VcToSU2zX4Uj47c0kvPsW5E2Qk51fNbWfisJMAHNzPX9pVmclM2xMh/AhB
	YjxKI8jS6sHZ8d+gQU6zY2UfdUBhkPfFhp/3MxOmsPnoR5PmCIy944oFX/dAAjt4
	Nm1gNjAhj+3AbDOcwtMSlkpA9p+tMf+9FlKa0MR4wwXUtuyGSlHSZfQQgGdG49Bl
	I0n68bRmQC4whvi+8XFGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731599490; x=1731603090; bh=B
	ICk4k0mxFzSs2XqErOIM8b67gtSVvVyQsMxlwRSLBY=; b=avlyQzU9ctavwqagy
	2VgqfdGKI/QUjIy5z9HL+YdzbtKKNJsdOyt4AMGnQYqi3Tny6UQDV5ERv1xsjZ30
	pZg8f1pkJ5Q7dNjmgTMq44Ns7JbO4C/A6pK+0TgWwyB/1bA1Xv/bLpFVTdt9JWaE
	qgiTbkQK5BvSQiXOq3xfTKaLborwKDubiKcn2HG2DWWiQMsy5skyVAjnvocAJy7I
	JAtJCF1eW7w45DBUjvTz+VmrEP4RRlmaG4Sc4OgHAmgKKwGT9wo8rs7etn5SIrmG
	ZmKEs1Dkrgt4u28K6AAnNnXudHYOGav0TsQhECfo/814HjNbx55oDl4G4MyzTHCn
	wcDQA==
X-ME-Sender: <xms:gRw2Z1q6a1UD0gYGAy8traETK8_sRLtX3NOdHoAo7kOPGFwXyCx-jg>
    <xme:gRw2Z3pQOUdL849DFy5R1U_ciUNNoKzPZZTZSz70IusQFybXBVXznVNaPXNI8rDmi
    PWc02fKlkBjAt0w4K8>
X-ME-Received: <xmr:gRw2ZyM4jcV3HyXHmlcM_dXvU54oRmoAANrEnOs-WN4Hqu-B4gdb-IOXB_O_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfet
    veeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhn
    rghilhdrnhgvthdprhgtphhtthhopehvfhgvughorhgvnhhkohesnhhovhgvkhdrrhhupd
    hrtghpthhtohepfhhkrhgvnhiivghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhihihusegrmhgriihonh
    drtghomhdprhgtphhtthhopegrphhoohhrvhhkohesrghmrgiiohhnrdgtohhmpdhrtghp
    thhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhhnhdrfh
    grshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:gRw2Zw7Ft1zpN-YLzITGCDxf_V0ijinxlOT-wm8FyO62i5KbAjsFlw>
    <xmx:gRw2Z04_dZ5MlCm_qk3vuN7M8S777RvhiKx65xqIeZ3qF4bo30skCw>
    <xmx:gRw2Z4ikmk9NfH2Taod9fw4C13iPQTLsa-r7PLuN8FgurWxoW0D4ig>
    <xmx:gRw2Z27Pp-Smx4t_MzGs9mfCniLBm-SYHwRJr2d1QKn2CnxJNA7hog>
    <xmx:gRw2Z0jpwjehHebl6InO0ZQxKSYQ5VkMGfKTmrKI9GZxnupf-agKvKTY>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 10:51:29 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Vadim Fedorenko <vfedorenko@novek.ru>,
	Frantisek Krenzelok <fkrenzel@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Apoorv Kothari <apoorvko@amazon.com>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 6/6] selftests: tls: add rekey tests
Date: Thu, 14 Nov 2024 16:50:53 +0100
Message-ID: <e00a6aed157b20573afbfc6c2353af2afa54f48e.1731597571.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731597571.git.sd@queasysnail.net>
References: <cover.1731597571.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: add rekey_fail test (reject changing the version/cipher)
v3: add rekey_peek_splice following Jakub's comment
    add rekey+poll tests
v4: rebase, new selftests were added
    check that rekey isn't supported on TLS1.2

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 460 ++++++++++++++++++++++++++++++
 1 file changed, 460 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index b1f52d2bb096..4fc07da10b9e 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1670,6 +1670,466 @@ TEST_F(tls, recv_efault)
 		EXPECT_EQ(memcmp(rec2, recv_mem + 9, ret - 9), 0);
 }
 
+#define TLS_RECORD_TYPE_HANDSHAKE      0x16
+/* key_update, length 1, update_not_requested */
+static const char key_update_msg[] = "\x18\x00\x00\x01\x00";
+static void tls_send_keyupdate(struct __test_metadata *_metadata, int fd)
+{
+	size_t len = sizeof(key_update_msg);
+
+	EXPECT_EQ(tls_send_cmsg(fd, TLS_RECORD_TYPE_HANDSHAKE,
+				(char *)key_update_msg, len, 0),
+		  len);
+}
+
+static void tls_recv_keyupdate(struct __test_metadata *_metadata, int fd, int flags)
+{
+	char buf[100];
+
+	EXPECT_EQ(tls_recv_cmsg(_metadata, fd, TLS_RECORD_TYPE_HANDSHAKE, buf, sizeof(buf), flags),
+		  sizeof(key_update_msg));
+	EXPECT_EQ(memcmp(buf, key_update_msg, sizeof(key_update_msg)), 0);
+}
+
+/* set the key to 0 then 1 for RX, immediately to 1 for TX */
+TEST_F(tls_basic, rekey_rx)
+{
+	struct tls_crypto_info_keys tls12_0, tls12_1;
+	char const *test_str = "test_message";
+	int send_len = strlen(test_str) + 1;
+	char buf[20];
+	int ret;
+
+	if (self->notls)
+		return;
+
+	tls_crypto_info_init(TLS_1_3_VERSION, TLS_CIPHER_AES_GCM_128,
+			     &tls12_0, 0);
+	tls_crypto_info_init(TLS_1_3_VERSION, TLS_CIPHER_AES_GCM_128,
+			     &tls12_1, 1);
+
+
+	ret = setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12_1, tls12_1.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12_0, tls12_0.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12_1, tls12_1.len);
+	EXPECT_EQ(ret, 0);
+
+	EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
+	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
+}
+
+/* set the key to 0 then 1 for TX, immediately to 1 for RX */
+TEST_F(tls_basic, rekey_tx)
+{
+	struct tls_crypto_info_keys tls12_0, tls12_1;
+	char const *test_str = "test_message";
+	int send_len = strlen(test_str) + 1;
+	char buf[20];
+	int ret;
+
+	if (self->notls)
+		return;
+
+	tls_crypto_info_init(TLS_1_3_VERSION, TLS_CIPHER_AES_GCM_128,
+			     &tls12_0, 0);
+	tls_crypto_info_init(TLS_1_3_VERSION, TLS_CIPHER_AES_GCM_128,
+			     &tls12_1, 1);
+
+
+	ret = setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12_0, tls12_0.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12_1, tls12_1.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12_1, tls12_1.len);
+	EXPECT_EQ(ret, 0);
+
+	EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
+	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
+}
+
+TEST_F(tls, rekey)
+{
+	char const *test_str_1 = "test_message_before_rekey";
+	char const *test_str_2 = "test_message_after_rekey";
+	struct tls_crypto_info_keys tls12;
+	int send_len;
+	char buf[100];
+
+	if (variant->tls_version != TLS_1_3_VERSION)
+		return;
+
+	/* initial send/recv */
+	send_len = strlen(test_str_1) + 1;
+	EXPECT_EQ(send(self->fd, test_str_1, send_len, 0), send_len);
+	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+	EXPECT_EQ(memcmp(buf, test_str_1, send_len), 0);
+
+	/* update TX key */
+	tls_send_keyupdate(_metadata, self->fd);
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12, 1);
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+	/* send after rekey */
+	send_len = strlen(test_str_2) + 1;
+	EXPECT_EQ(send(self->fd, test_str_2, send_len, 0), send_len);
+
+	/* can't receive the KeyUpdate without a control message */
+	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), -1);
+
+	/* get KeyUpdate */
+	tls_recv_keyupdate(_metadata, self->cfd, 0);
+
+	/* recv blocking -> -EKEYEXPIRED */
+	EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), 0), -1);
+	EXPECT_EQ(errno, EKEYEXPIRED);
+
+	/* recv non-blocking -> -EKEYEXPIRED */
+	EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), MSG_DONTWAIT), -1);
+	EXPECT_EQ(errno, EKEYEXPIRED);
+
+	/* update RX key */
+	EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0);
+
+	/* recv after rekey */
+	EXPECT_NE(recv(self->cfd, buf, send_len, 0), -1);
+	EXPECT_EQ(memcmp(buf, test_str_2, send_len), 0);
+}
+
+TEST_F(tls, rekey_fail)
+{
+	char const *test_str_1 = "test_message_before_rekey";
+	char const *test_str_2 = "test_message_after_rekey";
+	struct tls_crypto_info_keys tls12;
+	int send_len;
+	char buf[100];
+
+	/* initial send/recv */
+	send_len = strlen(test_str_1) + 1;
+	EXPECT_EQ(send(self->fd, test_str_1, send_len, 0), send_len);
+	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+	EXPECT_EQ(memcmp(buf, test_str_1, send_len), 0);
+
+	/* update TX key */
+	tls_send_keyupdate(_metadata, self->fd);
+
+	if (variant->tls_version != TLS_1_3_VERSION) {
+		/* just check that rekey is not supported and return */
+		tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12, 1);
+		EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), -1);
+		EXPECT_EQ(errno, EBUSY);
+		return;
+	}
+
+	/* successful update */
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12, 1);
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+	/* invalid update: change of version */
+	tls_crypto_info_init(TLS_1_2_VERSION, variant->cipher_type, &tls12, 1);
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* invalid update (RX socket): change of version */
+	tls_crypto_info_init(TLS_1_2_VERSION, variant->cipher_type, &tls12, 1);
+	EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* invalid update: change of cipher */
+	if (variant->cipher_type == TLS_CIPHER_AES_GCM_256)
+		tls_crypto_info_init(variant->tls_version, TLS_CIPHER_CHACHA20_POLY1305, &tls12, 1);
+	else
+		tls_crypto_info_init(variant->tls_version, TLS_CIPHER_AES_GCM_256, &tls12, 1);
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* send after rekey, the invalid updates shouldn't have an effect */
+	send_len = strlen(test_str_2) + 1;
+	EXPECT_EQ(send(self->fd, test_str_2, send_len, 0), send_len);
+
+	/* can't receive the KeyUpdate without a control message */
+	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), -1);
+
+	/* get KeyUpdate */
+	tls_recv_keyupdate(_metadata, self->cfd, 0);
+
+	/* recv blocking -> -EKEYEXPIRED */
+	EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), 0), -1);
+	EXPECT_EQ(errno, EKEYEXPIRED);
+
+	/* recv non-blocking -> -EKEYEXPIRED */
+	EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), MSG_DONTWAIT), -1);
+	EXPECT_EQ(errno, EKEYEXPIRED);
+
+	/* update RX key */
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12, 1);
+	EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0);
+
+	/* recv after rekey */
+	EXPECT_NE(recv(self->cfd, buf, send_len, 0), -1);
+	EXPECT_EQ(memcmp(buf, test_str_2, send_len), 0);
+}
+
+TEST_F(tls, rekey_peek)
+{
+	char const *test_str_1 = "test_message_before_rekey";
+	struct tls_crypto_info_keys tls12;
+	int send_len;
+	char buf[100];
+
+	if (variant->tls_version != TLS_1_3_VERSION)
+		return;
+
+	send_len = strlen(test_str_1) + 1;
+	EXPECT_EQ(send(self->fd, test_str_1, send_len, 0), send_len);
+
+	/* update TX key */
+	tls_send_keyupdate(_metadata, self->fd);
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12, 1);
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+	EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), MSG_PEEK), send_len);
+	EXPECT_EQ(memcmp(buf, test_str_1, send_len), 0);
+
+	EXPECT_EQ(recv(self->cfd, buf, send_len, 0), send_len);
+	EXPECT_EQ(memcmp(buf, test_str_1, send_len), 0);
+
+	/* can't receive the KeyUpdate without a control message */
+	EXPECT_EQ(recv(self->cfd, buf, send_len, MSG_PEEK), -1);
+
+	/* peek KeyUpdate */
+	tls_recv_keyupdate(_metadata, self->cfd, MSG_PEEK);
+
+	/* get KeyUpdate */
+	tls_recv_keyupdate(_metadata, self->cfd, 0);
+
+	/* update RX key */
+	EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0);
+}
+
+TEST_F(tls, splice_rekey)
+{
+	int send_len = TLS_PAYLOAD_MAX_LEN / 2;
+	char mem_send[TLS_PAYLOAD_MAX_LEN];
+	char mem_recv[TLS_PAYLOAD_MAX_LEN];
+	struct tls_crypto_info_keys tls12;
+	int p[2];
+
+	if (variant->tls_version != TLS_1_3_VERSION)
+		return;
+
+	memrnd(mem_send, sizeof(mem_send));
+
+	ASSERT_GE(pipe(p), 0);
+	EXPECT_EQ(send(self->fd, mem_send, send_len, 0), send_len);
+
+	/* update TX key */
+	tls_send_keyupdate(_metadata, self->fd);
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12, 1);
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+	EXPECT_EQ(send(self->fd, mem_send, send_len, 0), send_len);
+
+	EXPECT_EQ(splice(self->cfd, NULL, p[1], NULL, TLS_PAYLOAD_MAX_LEN, 0), send_len);
+	EXPECT_EQ(read(p[0], mem_recv, send_len), send_len);
+	EXPECT_EQ(memcmp(mem_send, mem_recv, send_len), 0);
+
+	/* can't splice the KeyUpdate */
+	EXPECT_EQ(splice(self->cfd, NULL, p[1], NULL, TLS_PAYLOAD_MAX_LEN, 0), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* peek KeyUpdate */
+	tls_recv_keyupdate(_metadata, self->cfd, MSG_PEEK);
+
+	/* get KeyUpdate */
+	tls_recv_keyupdate(_metadata, self->cfd, 0);
+
+	/* can't splice before updating the key */
+	EXPECT_EQ(splice(self->cfd, NULL, p[1], NULL, TLS_PAYLOAD_MAX_LEN, 0), -1);
+	EXPECT_EQ(errno, EKEYEXPIRED);
+
+	/* update RX key */
+	EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0);
+
+	EXPECT_EQ(splice(self->cfd, NULL, p[1], NULL, TLS_PAYLOAD_MAX_LEN, 0), send_len);
+	EXPECT_EQ(read(p[0], mem_recv, send_len), send_len);
+	EXPECT_EQ(memcmp(mem_send, mem_recv, send_len), 0);
+}
+
+TEST_F(tls, rekey_peek_splice)
+{
+	char const *test_str_1 = "test_message_before_rekey";
+	struct tls_crypto_info_keys tls12;
+	int send_len;
+	char buf[100];
+	char mem_recv[TLS_PAYLOAD_MAX_LEN];
+	int p[2];
+
+	if (variant->tls_version != TLS_1_3_VERSION)
+		return;
+
+	ASSERT_GE(pipe(p), 0);
+
+	send_len = strlen(test_str_1) + 1;
+	EXPECT_EQ(send(self->fd, test_str_1, send_len, 0), send_len);
+
+	/* update TX key */
+	tls_send_keyupdate(_metadata, self->fd);
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12, 1);
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+	EXPECT_EQ(recv(self->cfd, buf, sizeof(buf), MSG_PEEK), send_len);
+	EXPECT_EQ(memcmp(buf, test_str_1, send_len), 0);
+
+	EXPECT_EQ(splice(self->cfd, NULL, p[1], NULL, TLS_PAYLOAD_MAX_LEN, 0), send_len);
+	EXPECT_EQ(read(p[0], mem_recv, send_len), send_len);
+	EXPECT_EQ(memcmp(mem_recv, test_str_1, send_len), 0);
+}
+
+TEST_F(tls, rekey_getsockopt)
+{
+	struct tls_crypto_info_keys tls12;
+	struct tls_crypto_info_keys tls12_get;
+	socklen_t len;
+
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12, 0);
+
+	len = tls12.len;
+	EXPECT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &tls12_get, &len), 0);
+	EXPECT_EQ(len, tls12.len);
+	EXPECT_EQ(memcmp(&tls12_get, &tls12, tls12.len), 0);
+
+	len = tls12.len;
+	EXPECT_EQ(getsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12_get, &len), 0);
+	EXPECT_EQ(len, tls12.len);
+	EXPECT_EQ(memcmp(&tls12_get, &tls12, tls12.len), 0);
+
+	if (variant->tls_version != TLS_1_3_VERSION)
+		return;
+
+	tls_send_keyupdate(_metadata, self->fd);
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12, 1);
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+	tls_recv_keyupdate(_metadata, self->cfd, 0);
+	EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0);
+
+	len = tls12.len;
+	EXPECT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &tls12_get, &len), 0);
+	EXPECT_EQ(len, tls12.len);
+	EXPECT_EQ(memcmp(&tls12_get, &tls12, tls12.len), 0);
+
+	len = tls12.len;
+	EXPECT_EQ(getsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12_get, &len), 0);
+	EXPECT_EQ(len, tls12.len);
+	EXPECT_EQ(memcmp(&tls12_get, &tls12, tls12.len), 0);
+}
+
+TEST_F(tls, rekey_poll_pending)
+{
+	char const *test_str = "test_message_after_rekey";
+	struct tls_crypto_info_keys tls12;
+	struct pollfd pfd = { };
+	int send_len;
+	int ret;
+
+	if (variant->tls_version != TLS_1_3_VERSION)
+		return;
+
+	/* update TX key */
+	tls_send_keyupdate(_metadata, self->fd);
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12, 1);
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+	/* get KeyUpdate */
+	tls_recv_keyupdate(_metadata, self->cfd, 0);
+
+	/* send immediately after rekey */
+	send_len = strlen(test_str) + 1;
+	EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
+
+	/* key hasn't been updated, expect cfd to be non-readable */
+	pfd.fd = self->cfd;
+	pfd.events = POLLIN;
+	EXPECT_EQ(poll(&pfd, 1, 0), 0);
+
+	ret = fork();
+	ASSERT_GE(ret, 0);
+
+	if (ret) {
+		int pid2, status;
+
+		/* wait before installing the new key */
+		sleep(1);
+
+		/* update RX key while poll() is sleeping */
+		EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0);
+
+		pid2 = wait(&status);
+		EXPECT_EQ(pid2, ret);
+		EXPECT_EQ(status, 0);
+	} else {
+		pfd.fd = self->cfd;
+		pfd.events = POLLIN;
+		EXPECT_EQ(poll(&pfd, 1, 5000), 1);
+
+		exit(!__test_passed(_metadata));
+	}
+}
+
+TEST_F(tls, rekey_poll_delay)
+{
+	char const *test_str = "test_message_after_rekey";
+	struct tls_crypto_info_keys tls12;
+	struct pollfd pfd = { };
+	int send_len;
+	int ret;
+
+	if (variant->tls_version != TLS_1_3_VERSION)
+		return;
+
+	/* update TX key */
+	tls_send_keyupdate(_metadata, self->fd);
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type, &tls12, 1);
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
+
+	/* get KeyUpdate */
+	tls_recv_keyupdate(_metadata, self->cfd, 0);
+
+	ret = fork();
+	ASSERT_GE(ret, 0);
+
+	if (ret) {
+		int pid2, status;
+
+		/* wait before installing the new key */
+		sleep(1);
+
+		/* update RX key while poll() is sleeping */
+		EXPECT_EQ(setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len), 0);
+
+		sleep(1);
+		send_len = strlen(test_str) + 1;
+		EXPECT_EQ(send(self->fd, test_str, send_len, 0), send_len);
+
+		pid2 = wait(&status);
+		EXPECT_EQ(pid2, ret);
+		EXPECT_EQ(status, 0);
+	} else {
+		pfd.fd = self->cfd;
+		pfd.events = POLLIN;
+		EXPECT_EQ(poll(&pfd, 1, 5000), 1);
+		exit(!__test_passed(_metadata));
+	}
+}
+
 FIXTURE(tls_err)
 {
 	int fd, cfd;
-- 
2.47.0


