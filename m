Return-Path: <linux-kselftest+bounces-23265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319999EECB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 16:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5878283DAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7ED222D4A;
	Thu, 12 Dec 2024 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Gy7ZkuaT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WYsENeiU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB03222D42;
	Thu, 12 Dec 2024 15:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017829; cv=none; b=SwEkLrPeF9t+l9xg/E14sJJpWa6AIcp1YCejkuK1Pndj4OB+ylPEcr31Qgbjpc2N1lD1SG3r6NihOtwOsrMIYImgGk7MrVRCC9ENfELJRVL10FHGEIbjVmdNklW7k1VrA/um2SL6JjKNlEtx8HbF2PL+lj1bEC1cYShd3b1Hq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017829; c=relaxed/simple;
	bh=+fHsghrdf4sZIJkIEvtW+cAvGMkasB03DjPu0Q1nkzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY8EpqHoQQREcG+gNhuucgAi9toFglLNl/ky/uNoexbAqXpd6WDqrLhX+IxPecbMkutnN5LJMsQStIXaZRsSCjDcUbVD55yyuYulnmbCECg5wMAD+tVvkoV4oGRuJERL0YL3zfme58Zg8aq1IvX96OILWdzEFe1cz25S7QQv30E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Gy7ZkuaT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WYsENeiU; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 354F62540266;
	Thu, 12 Dec 2024 10:37:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 12 Dec 2024 10:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734017826; x=
	1734104226; bh=lTaJeILgzHwkCB6op29bPStqrGY9/sWSdlLECTkVDu0=; b=G
	y7ZkuaThpvFIwC/VLhlsfyansnIpyMhpd1pHELX1bv4XuHGSOEzJsV61Y7/Hvmji
	un+749zU+m5DJMel8l5RM3/ZIFfit4gzA+Knl/iYfaw5nUJ+WDzjODuZDgsuHJj0
	1ca3JqB0YeHuY72iJM6NPaAAIhhe98olKWlHA+5FRJ3SxjpfWmqVxx975rJ7+WG2
	qJRvUyuWSMCDnMys9CKD9kFDEGyfAunD91LsyZOqkokoOz852F2E4PCqEBZpNUTp
	OO92pUUd7OYsdEILb8v56Z7Y0CDtEtcbwLxjVtiPBii4QqTKJY4BtzMRJbmcQH0Z
	ry3TIr9GN6p+i+3MUHPMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734017826; x=1734104226; bh=l
	TaJeILgzHwkCB6op29bPStqrGY9/sWSdlLECTkVDu0=; b=WYsENeiUttpxC3jen
	y7hHwdcFfn7tjlE/RZWFq5JSVLY8aMif5UvLss2m/tM8DnR+7TskqXCT2d4PgbzI
	ohGzFBQgc8N25gxdrGmcwO5+WKY5M6FrhPufadiOFr50hSrH9rhnLSlQ1xq/L7Ak
	qrTVeO5bCjbRgQmkWSxB89gonWBEpJB51VYYcgQBrzrufnrjW8mDQ+B4dvkxII66
	4JhzYQWbi9uqYCv0SBRuE7AEEC5v1s/RHqQQmChpvqxbGuu6KZzS6elIBAGawVpo
	n+xPdJdoKW46d4ENp9EGPlTs5IDZ0C6jSWsU6b2regEKH88W1/RTaaMjyOt8JBjF
	pNP+w==
X-ME-Sender: <xms:IQNbZ-F5aVO7uNCIRErQnZBQfipChQoJjJ3Tu07sjgcVPgSdLqVoLw>
    <xme:IQNbZ_Umywje_7GaNucg6j6Y01bflp-NWG5BTIrMyRuCXfvY7TfwNocFzph5gut8f
    HWm-LyNMIheHITgjns>
X-ME-Received: <xmr:IQNbZ4IMvJr3YO3TUsk29_l6t8bc45e1yR0f4wYWinOXeYcUxiIIyGMGMaJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdejjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfet
    veeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhn
    rghilhdrnhgvthdprhgtphhtthhopehvfhgvughorhgvnhhkohesnhhovhgvkhdrrhhupd
    hrtghpthhtohepfhhkrhgvnhiivghlsehrvgguhhgrthdrtghomhdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhihihusegrmhgriihonh
    drtghomhdprhgtphhtthhopegrphhoohhrvhhkohesrghmrgiiohhnrdgtohhmpdhrtghp
    thhtohepsghorhhishhpsehnvhhiughirgdrtghomhdprhgtphhtthhopehjohhhnhdrfh
    grshhtrggsvghnugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:IQNbZ4GLCV6L-uSnA7vZLYJBEH11iHak__Xood1u7U8rTQkOSOHAFQ>
    <xmx:IQNbZ0UQllLaG6yGI8zBlheaEeaxixIJK5wuoV9Y5yDYQ2377wSJbQ>
    <xmx:IQNbZ7OHBVOLTANwFFwLXtNBkJnNYQHqk3pyVJnktwLlKQ2KEIgukw>
    <xmx:IQNbZ70q5xbOA2sx0WWtedaXrBulXNfylBCCzT25EoCR2JdZGJALQw>
    <xmx:IgNbZ5WhfJuuBjONA4SlXE-wSPJAaLdEpMJp2G1QMK0MxDrjTx215tvL>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 10:37:05 -0500 (EST)
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
	Simon Horman <horms@kernel.org>,
	Parthiban.Veerasooran@microchip.com
Subject: [PATCH net-next v5 6/6] selftests: tls: add rekey tests
Date: Thu, 12 Dec 2024 16:36:09 +0100
Message-ID: <1c242d046cb78b37f16f45a7ea046af024acb8d9.1734013874.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734013874.git.sd@queasysnail.net>
References: <cover.1734013874.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the kernel's ability to:
 - update the key (but not the version or cipher), only for TLS1.3
 - pause decryption after receiving a KeyUpdate message, until a new
   RX key has been provided
 - reflect the pause/non-readable socket in poll()

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
v2: add rekey_fail test (reject changing the version/cipher)
v3: add rekey_peek_splice following Jakub's comment
    add rekey+poll tests
v4: rebase, new selftests were added
    check that rekey isn't supported on TLS1.2

 tools/testing/selftests/net/tls.c | 458 ++++++++++++++++++++++++++++++
 1 file changed, 458 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index b1f52d2bb096..9a85f93c33d8 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1670,6 +1670,464 @@ TEST_F(tls, recv_efault)
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
2.47.1


