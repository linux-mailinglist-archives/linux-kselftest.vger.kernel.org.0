Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1CC776007
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 14:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjHIM7j convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 08:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjHIM7j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 08:59:39 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0421FF9
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 05:59:38 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-tyAun_tROBu7SrWS_9vBrg-1; Wed, 09 Aug 2023 08:59:32 -0400
X-MC-Unique: tyAun_tROBu7SrWS_9vBrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80CF2101A5B4;
        Wed,  9 Aug 2023 12:59:31 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A49212166B25;
        Wed,  9 Aug 2023 12:59:29 +0000 (UTC)
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     netdev@vger.kernel.org
Cc:     Sabrina Dubroca <sd@queasysnail.net>,
        Vadim Fedorenko <vfedorenko@novek.ru>,
        Frantisek Krenzelok <fkrenzel@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Apoorv Kothari <apoorvko@amazon.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH net-next v3 5/6] selftests: tls: add key_generation argument to tls_crypto_info_init
Date:   Wed,  9 Aug 2023 14:58:54 +0200
Message-Id: <083539d66583652cf972ab1f5898025b55079dda.1691584074.git.sd@queasysnail.net>
In-Reply-To: <cover.1691584074.git.sd@queasysnail.net>
References: <cover.1691584074.git.sd@queasysnail.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows us to generate different keys, so that we can test that
rekey is using the correct one.

v3: update for newly added tests

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 4b63708c6a81..8d05748a0f57 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -41,9 +41,11 @@ struct tls_crypto_info_keys {
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
@@ -322,7 +324,7 @@ FIXTURE_SETUP(tls)
 		SKIP(return, "Unsupported cipher in FIPS mode");
 
 	tls_crypto_info_init(variant->tls_version, variant->cipher_type,
-			     &tls12);
+			     &tls12, 0);
 
 	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls);
 
@@ -1092,7 +1094,7 @@ TEST_F(tls, bidir)
 		struct tls_crypto_info_keys tls12;
 
 		tls_crypto_info_init(variant->tls_version, variant->cipher_type,
-				     &tls12);
+				     &tls12, 0);
 
 		ret = setsockopt(self->fd, SOL_TLS, TLS_RX, &tls12,
 				 tls12.len);
@@ -1500,7 +1502,7 @@ FIXTURE_SETUP(tls_err)
 	int ret;
 
 	tls_crypto_info_init(variant->tls_version, TLS_CIPHER_AES_GCM_128,
-			     &tls12);
+			     &tls12, 0);
 
 	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls);
 	ulp_sock_pair(_metadata, &self->fd2, &self->cfd2, &self->notls);
@@ -1922,7 +1924,7 @@ TEST(tls_v6ops) {
 	int sfd, ret, fd;
 	socklen_t len, len2;
 
-	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_GCM_128, &tls12);
+	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_GCM_128, &tls12, 0);
 
 	addr.sin6_family = AF_INET6;
 	addr.sin6_addr = in6addr_any;
@@ -1981,7 +1983,7 @@ TEST(prequeue) {
 	len = sizeof(addr);
 	memrnd(buf, sizeof(buf));
 
-	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_GCM_256, &tls12);
+	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_GCM_256, &tls12, 0);
 
 	addr.sin_family = AF_INET;
 	addr.sin_addr.s_addr = htonl(INADDR_ANY);
-- 
2.40.1

