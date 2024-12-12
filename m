Return-Path: <linux-kselftest+bounces-23264-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCB89EECB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 16:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70717282901
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD082206A5;
	Thu, 12 Dec 2024 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="q/CHE98C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3pcig/xL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BDF221D88;
	Thu, 12 Dec 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734017826; cv=none; b=lV3Xfv9x0EJPdXvPYDtICBv7Yw2+O0jPOadAfjHwaR+gVZ/FkHUIqodZaGqr4Sz74m/cHHmqB7rT1Ss72wMr1mquqifekEwZAqjdfSAUZmnOIGqpzvTHsi+OPmg0h+Eqv45wF6jva9Cz++fSGzT0nl6677L5/9RdK2emfiVKk8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734017826; c=relaxed/simple;
	bh=+ngL7/6ynNxZ3/D6Vnw4E9/5dTXEI2kRWf1ZHF7xV/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4E0OVFiJkZ4aQpK7pnfFZLTU0/9WIBWbCMB8t/nsL3pTd0/VGOVRbyORz+6m1kbuabmJWy3/H4jiglMGWdRsVoS4s/Yaf06+pls2cxQMz9mPThWqf1hX4BYX+N3fA6e9LbhJd9RIk7g7avzN6DxiQm69MQvp9vpCtQKVSMTprc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=q/CHE98C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3pcig/xL; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 8488B1140224;
	Thu, 12 Dec 2024 10:37:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 12 Dec 2024 10:37:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1734017823; x=
	1734104223; bh=WqVu3lXP5TaNV+fZ7rWD5k2KbwJqYJeIBlk5e5y5xec=; b=q
	/CHE98CsTkh9PyNtuLzzKyPhRrDhl89mZ3bX3sywDMpK/64RzKRyv4uLFnBiPFhH
	pmzURK/IFlmpecoiM1FmXrQokOuGPoUxOU/f+lcWRJABeoYKjFQTZ2jUwUy/KKYP
	ZDOjJ04EfBDi3HiuIV700hwoDx9vFqDCtqV39YnLNvRF6MgiPxgWcHHK9qM8V+Hi
	nN/RdJ/9wKSdwpUvNoCq8UGyhXSkhaqwc5EKK93fWN0COTLvKf7ohKPeVPUEEWCS
	3cTP/GfBbbsB9tOK+ZCr+W+DsSGohmKy8Z5OvXIiIm/zfRQq/OHF6aeW59znQ4/J
	QA/A53cRU91MbYPXz01zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1734017823; x=1734104223; bh=W
	qVu3lXP5TaNV+fZ7rWD5k2KbwJqYJeIBlk5e5y5xec=; b=3pcig/xLrUyUXh+6v
	ylGgIHytLEx0p/+Yge4DANRJaphVlmcVTPGlEquKK90uRaH+tHhKeYLtglkwI8cg
	kWZQBy6bpS1zmqDAqHofwowatMhvBTuBZhQLPnSdXPqIhKyJV73hgqDTk/jdob2A
	qzxMP6gzb2HX+TdTIvAlUF43Jjwu1lg9j89EuLu0i6jkd+frmOOfYyWwUHWwbkRP
	gwx57X1S3Ma2OYG4BF9fZB8x912hZ9TtXgnBmzY3gLj0ZColLt6luXIbA/9Y6wxf
	OvFuXS/CZKIaEiZjb3do6/lbRiIsgLPzqVZoQY8RWgB4w4cAItG/S+We+iA8aCON
	Umhyw==
X-ME-Sender: <xms:HwNbZxJepnB9eKCzVp0p3ctelvAT7wvMWxRONsH-7je_AsdxYosg7w>
    <xme:HwNbZ9JV6Au_fM-L5n3vd7IRmVb7t7Q3Mp0et9PS29gU6jyLWHU1Qdk0ZZu_LRlhk
    BE_FbnDAkNliB3GrLg>
X-ME-Received: <xmr:HwNbZ5uO__-UaStiQrqKFz3X15aprwPYN09uVPzdg-8HQv9tBvINz4WogVvO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeehgdejiecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:HwNbZyZmtr8B9MzIPH5pEW_j-SFoWpgB1f2bOTQy2mpZ-rZYAXk5HA>
    <xmx:HwNbZ4Zmu9tEmmwm6HM-CdfFip1xgPLqd8muEgdqRSUWq0-jLCnfig>
    <xmx:HwNbZ2CnVSU7chCPGPRi7OMvln15PH-Xb0f0Oj-INh_glBqSWKqfiQ>
    <xmx:HwNbZ2YV9tjgQkuPRYpy7FOr5ebyMHoA2BgTF4_i9dmo1NW7baC4bQ>
    <xmx:HwNbZ1JIXro2VJqj-ZTDS1KzqT8pB-ZjHpTIc21kBQWUeT0gOeH5R-Wr>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Dec 2024 10:37:02 -0500 (EST)
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
Subject: [PATCH net-next v5 5/6] selftests: tls: add key_generation argument to tls_crypto_info_init
Date: Thu, 12 Dec 2024 16:36:08 +0100
Message-ID: <1af9f0a74c78bb8c08e449c4609493158218f235.1734013874.git.sd@queasysnail.net>
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

This allows us to generate different keys, so that we can test that
rekey is using the correct one.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
v3: update for newly added tests
v4: update for newly added tests

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
2.47.1


