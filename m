Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE78078906F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 23:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjHYVgJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 17:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjHYVf6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 17:35:58 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D98326AD
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Aug 2023 14:35:55 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-uGicqjSAOhCSsyaDBUMOtA-1; Fri, 25 Aug 2023 17:35:50 -0400
X-MC-Unique: uGicqjSAOhCSsyaDBUMOtA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8C0185C1A2;
        Fri, 25 Aug 2023 21:35:49 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A0841678B;
        Fri, 25 Aug 2023 21:35:48 +0000 (UTC)
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     netdev@vger.kernel.org
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 02/17] selftests: tls: add getsockopt test
Date:   Fri, 25 Aug 2023 23:35:07 +0200
Message-Id: <81a007ca13de9a74f4af45635d06682cdb385a54.1692977948.git.sd@queasysnail.net>
In-Reply-To: <cover.1692977948.git.sd@queasysnail.net>
References: <cover.1692977948.git.sd@queasysnail.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kernel accepts fetching either just the version and cipher type,
or exactly the per-cipher struct. Also check that getsockopt returns
what we just passed to the kernel.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 95bef2be48cd..0da6952a047a 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -30,6 +30,7 @@ static int fips_enabled;
 
 struct tls_crypto_info_keys {
 	union {
+		struct tls_crypto_info crypto_info;
 		struct tls12_crypto_info_aes_gcm_128 aes128;
 		struct tls12_crypto_info_chacha20_poly1305 chacha20;
 		struct tls12_crypto_info_sm4_gcm sm4gcm;
@@ -1496,6 +1497,40 @@ TEST_F(tls, shutdown_reuse)
 	EXPECT_EQ(errno, EISCONN);
 }
 
+TEST_F(tls, getsockopt)
+{
+	struct tls_crypto_info_keys expect, get;
+	socklen_t len;
+
+	/* get only the version/cipher */
+	len = sizeof(struct tls_crypto_info);
+	memrnd(&get, sizeof(get));
+	EXPECT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &get, &len), 0);
+	EXPECT_EQ(len, sizeof(struct tls_crypto_info));
+	EXPECT_EQ(get.crypto_info.version, variant->tls_version);
+	EXPECT_EQ(get.crypto_info.cipher_type, variant->cipher_type);
+
+	/* get the full crypto_info */
+	tls_crypto_info_init(variant->tls_version, variant->cipher_type, &expect);
+	len = expect.len;
+	memrnd(&get, sizeof(get));
+	EXPECT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &get, &len), 0);
+	EXPECT_EQ(len, expect.len);
+	EXPECT_EQ(get.crypto_info.version, variant->tls_version);
+	EXPECT_EQ(get.crypto_info.cipher_type, variant->cipher_type);
+	EXPECT_EQ(memcmp(&get, &expect, expect.len), 0);
+
+	/* short get should fail */
+	len = sizeof(struct tls_crypto_info) - 1;
+	EXPECT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &get, &len), -1);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* partial get of the cipher data should fail */
+	len = expect.len - 1;
+	EXPECT_EQ(getsockopt(self->fd, SOL_TLS, TLS_TX, &get, &len), -1);
+	EXPECT_EQ(errno, EINVAL);
+}
+
 FIXTURE(tls_err)
 {
 	int fd, cfd;
-- 
2.40.1

