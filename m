Return-Path: <linux-kselftest+bounces-22041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031E9C8EE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3FE8288F25
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D431AF0AB;
	Thu, 14 Nov 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="XTSc+4H5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JtgBTPAB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883C11AF0BB;
	Thu, 14 Nov 2024 15:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599490; cv=none; b=BzKXVPsJG3SDQ1snE3uIgTtPk4lbMr2s+lkV8NxvzD+ju1u1CuK9hY5Fp0Aqdtufy5n5gOZM0vrdjddRjG+Hr+W3UcLDS33xZdngXYWNB2y1EX6muHHw+rq/HwEZAw6+gVnx3PvyCWNlLl/5h6WFx1PAym4M+gaEu1DfTg8zVko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599490; c=relaxed/simple;
	bh=5XaLlYj7aVcjnuWTqPdxuxhVo7J9A2RUrFyrWs2feeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O3bqjLotZhBUzr77jypeReAoRj/uFI4PuhI000c1Qu2Sp2jQdTC2D1rrm2WDvo2u331pdgcfbHU4xm0JwlNWXYfilpOKAD7X1NehxfDLtoWEH8qhdda2Ok6XTXz2YGOM/SfaSGSYIVIFZ+3WdAPHPGxa9KCQYk4I7V2SHFug3EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=XTSc+4H5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JtgBTPAB; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 4F0BF1D405AC;
	Thu, 14 Nov 2024 10:51:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 14 Nov 2024 10:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1731599487; x=
	1731603087; bh=VGLAcNlVtEzHoe5NaUWxkcCbh05hVtFf/pjFKjDXw/4=; b=X
	TSc+4H5DslmWqXosd9CTH3FUM2JwYZUBT0IhnggNA84/SW54Epmr7cwAia/mLud+
	l2IST9kF5TfwgTMISMcExgtZUQOYFqBhoNizCNakRAH11FNmSSHaett5OX47Kx+L
	q/SH0ujNh6wrUU0DD23IS8mMAabct4Z2xi6E627h+jvELm/dL6JwoqfhGUjQ03rk
	1IiGkzEnjqEt00ru+NViYrJEvG1oa/w4opOhkKMnkM0hjEW0yZtJLXbMhHq+nOtf
	ujfeiJ9JHq+QcEByquG0SqgsMpivJg8xZVGiaNQRJVBS2dkFnRNXJcfwIHMva0K3
	cNM2Fpylc4Dj6NN/OkSxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1731599487; x=1731603087; bh=V
	GLAcNlVtEzHoe5NaUWxkcCbh05hVtFf/pjFKjDXw/4=; b=JtgBTPABqCtfDsc9x
	uvCk6PUaLjONTZiP6Xd56B+PrZ6GEQjst/JoYIxgXjgdmnOqkE0DnnNsAShg5N3r
	HW0AoQoTyltXiSZqsl0Wv9+bCceHE2f+vbP4nDmuWmwxglKiKF0RmTOXEXJojMm8
	S2x/8l6ZhvKBjj8557GahtsD2lKSKvQ+3joiZTcREgnfz9UbWA27jSPTr12TQNTE
	I6JAmFM6kRGho4vT/JpCnC1gyfT6fCqdnDcqNftGOo7Xk6mGIHkq0wC7icMCtkgY
	/80mLB6OEbLl5PCsPzsOoBuhTmaKqQVz8EeVab4JtdU2G6Ag+TjITolhdBeOB+SG
	dcCBg==
X-ME-Sender: <xms:fhw2Z80WaTNO3NelhOKM7ZEh3jGnCAhVeJzAT_Ljm_xWR5t7Djfjhw>
    <xme:fhw2Z3H_LGEomq9e67BQHnVke_TqWRHrRSR2Mm_vW8tkYrAPaoJVSyA6a7-Y9fNIT
    Y7R-vhcYDJAmbyUYck>
X-ME-Received: <xmr:fhw2Z06hND-c2UHNuYDm7Tv_-jW8eCRHW6I_RPsFQ_x4w8_tZfethDsvHXRi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdektdcutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:fhw2Z10uIM8XOhve7cQZDw6ndkH75qJlrCt3ZMQ__sIJyTAbDSkj3w>
    <xmx:fhw2Z_EPW7o6kQ1acr2ywYl8jesyU9tu3lFAdtjfxQTTI5uV7Jkz3Q>
    <xmx:fhw2Z-_rKlpR8ldhrq1nN4L6nW-I9cv4g25QJRGC4A31ipEbOx1eXA>
    <xmx:fhw2Z0nAMCmhTgIR8C2cYrni5Uy3wt3KL0FLurLGcMq5khi0VPXz0g>
    <xmx:fxw2Z2_YnwEu3I93B_gkwiHjcmgXqQz_6vizrSg6yo0DYW4-BBkBdl62>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 10:51:26 -0500 (EST)
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
Subject: [PATCH net-next v4 5/6] selftests: tls: add key_generation argument to tls_crypto_info_init
Date: Thu, 14 Nov 2024 16:50:52 +0100
Message-ID: <8169f9b1aaaced7756241e348519b60e6e1a8fa6.1731597571.git.sd@queasysnail.net>
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

This allows us to generate different keys, so that we can test that
rekey is using the correct one.

v3: update for newly added tests
v4: update for newly added tests

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 1a706d03bb6b..b1f52d2bb096 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -44,9 +44,11 @@ struct tls_crypto_info_keys {
 };
 
 static void tls_crypto_info_init(uint16_t tls_version, uint16_t cipher_type,
-				 struct tls_crypto_info_keys *tls12)
+				 struct tls_crypto_info_keys *tls12,
+				 char key_generation)
 {
-	memset(tls12, 0, sizeof(*tls12));
+	memset(tls12, key_generation, sizeof(*tls12));
+	memset(tls12, 0, sizeof(struct tls_crypto_info));
 
 	switch (cipher_type) {
 	case TLS_CIPHER_CHACHA20_POLY1305:
@@ -275,7 +277,7 @@ TEST_F(tls_basic, recseq_wrap)
 	if (self->notls)
 		SKIP(return, "no TLS support");
 
-	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_GCM_128, &tls12);
+	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_GCM_128, &tls12, 0);
 	memset(&tls12.aes128.rec_seq, 0xff, sizeof(tls12.aes128.rec_seq));
 
 	ASSERT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, tls12.len), 0);
@@ -391,7 +393,7 @@ FIXTURE_SETUP(tls)
 		SKIP(return, "Unsupported cipher in FIPS mode");
 
 	tls_crypto_info_init(variant->tls_version, variant->cipher_type,
-			     &tls12);
+			     &tls12, 0);
 
 	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls);
 
@@ -1175,7 +1177,7 @@ TEST_F(tls, bidir)
 		struct tls_crypto_info_keys tls12;
 
 		tls_crypto_info_init(variant->tls_version, variant->cipher_type,
-				     &tls12);
+				     &tls12, 0);
 
 		ret = setsockopt(self->fd, SOL_TLS, TLS_RX, &tls12,
 				 tls12.len);
@@ -1614,7 +1616,7 @@ TEST_F(tls, getsockopt)
 	EXPECT_EQ(get.crypto_info.cipher_type, variant->cipher_type);
 
 	/* get the full crypto_info */
-	tls_crypto_info_init(variant->tls_version, variant->cipher_type, &expect);
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type, &expect, 0);
 	len = expect.len;
 	memrnd(&get, sizeof(get));
 	EXPECT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &get, &len), 0);
@@ -1696,7 +1698,7 @@ FIXTURE_SETUP(tls_err)
 	int ret;
 
 	tls_crypto_info_init(variant->tls_version, TLS_CIPHER_AES_GCM_128,
-			     &tls12);
+			     &tls12, 0);
 
 	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls);
 	ulp_sock_pair(_metadata, &self->fd2, &self->cfd2, &self->notls);
@@ -2118,7 +2120,7 @@ TEST(tls_v6ops) {
 	int sfd, ret, fd;
 	socklen_t len, len2;
 
-	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_GCM_128, &tls12);
+	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_GCM_128, &tls12, 0);
 
 	addr.sin6_family = AF_INET6;
 	addr.sin6_addr = in6addr_any;
@@ -2177,7 +2179,7 @@ TEST(prequeue) {
 	len = sizeof(addr);
 	memrnd(buf, sizeof(buf));
 
-	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_GCM_256, &tls12);
+	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_GCM_256, &tls12, 0);
 
 	addr.sin_family = AF_INET;
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
-- 
2.47.0


