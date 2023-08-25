Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860BE789078
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 23:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjHYVgl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 17:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjHYVgQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 17:36:16 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E582691
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Aug 2023 14:36:14 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-D7JWxK2KNzuQemzu4-MBxQ-1; Fri, 25 Aug 2023 17:35:53 -0400
X-MC-Unique: D7JWxK2KNzuQemzu4-MBxQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A3B985C710;
        Fri, 25 Aug 2023 21:35:53 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24D531678B;
        Fri, 25 Aug 2023 21:35:52 +0000 (UTC)
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     netdev@vger.kernel.org
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 03/17] selftests: tls: test some invalid inputs for setsockopt
Date:   Fri, 25 Aug 2023 23:35:08 +0200
Message-Id: <bfcfa9cffda56d2064296ab7c99a05775dd4c28e.1692977948.git.sd@queasysnail.net>
In-Reply-To: <cover.1692977948.git.sd@queasysnail.net>
References: <cover.1692977948.git.sd@queasysnail.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This test will need to be updated if new ciphers are added.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 0da6952a047a..297d972558fb 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -241,6 +241,31 @@ TEST_F(tls_basic, base_base)
 	EXPECT_EQ(memcmp(buf, test_str, send_len), 0);
 };
 
+TEST_F(tls_basic, bad_cipher)
+{
+	struct tls_crypto_info_keys tls12;
+
+	tls12.crypto_info.version = 200;
+	tls12.crypto_info.cipher_type = TLS_CIPHER_AES_GCM_128;
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, sizeof(struct tls12_crypto_info_aes_gcm_128)), -1);
+
+	tls12.crypto_info.version = TLS_1_2_VERSION;
+	tls12.crypto_info.cipher_type = 50;
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, sizeof(struct tls12_crypto_info_aes_gcm_128)), -1);
+
+	tls12.crypto_info.version = TLS_1_2_VERSION;
+	tls12.crypto_info.cipher_type = 59;
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, sizeof(struct tls12_crypto_info_aes_gcm_128)), -1);
+
+	tls12.crypto_info.version = TLS_1_2_VERSION;
+	tls12.crypto_info.cipher_type = 10;
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, sizeof(struct tls12_crypto_info_aes_gcm_128)), -1);
+
+	tls12.crypto_info.version = TLS_1_2_VERSION;
+	tls12.crypto_info.cipher_type = 70;
+	EXPECT_EQ(setsockopt(self->fd, SOL_TLS, TLS_TX, &tls12, sizeof(struct tls12_crypto_info_aes_gcm_128)), -1);
+}
+
 FIXTURE(tls)
 {
 	int fd, cfd;
-- 
2.40.1

