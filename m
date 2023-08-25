Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76753789070
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Aug 2023 23:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjHYVgI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Aug 2023 17:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjHYVfx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Aug 2023 17:35:53 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DA92691
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Aug 2023 14:35:50 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-m7dtteH5PAOi6CjjPXuiqg-1; Fri, 25 Aug 2023 17:35:46 -0400
X-MC-Unique: m7dtteH5PAOi6CjjPXuiqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C9CC800193;
        Fri, 25 Aug 2023 21:35:45 +0000 (UTC)
Received: from hog.localdomain (unknown [10.39.192.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E3DD1678B;
        Fri, 25 Aug 2023 21:35:44 +0000 (UTC)
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     netdev@vger.kernel.org
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 01/17] selftests: tls: add test variants for aria-gcm
Date:   Fri, 25 Aug 2023 23:35:06 +0200
Message-Id: <ccf4a4d3f3820f8ff30431b7629f5210cb33fa89.1692977948.git.sd@queasysnail.net>
In-Reply-To: <cover.1692977948.git.sd@queasysnail.net>
References: <cover.1692977948.git.sd@queasysnail.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Only supported for TLS1.2.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/config |  1 +
 tools/testing/selftests/net/tls.c  | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index cd3cc52c59b4..8da562a9ae87 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -51,3 +51,4 @@ CONFIG_AMT=m
 CONFIG_VXLAN=m
 CONFIG_IP_SCTP=m
 CONFIG_NETFILTER_XT_MATCH_POLICY=m
+CONFIG_CRYPTO_ARIA=y
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 4b63708c6a81..95bef2be48cd 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -36,6 +36,8 @@ struct tls_crypto_info_keys {
 		struct tls12_crypto_info_sm4_ccm sm4ccm;
 		struct tls12_crypto_info_aes_ccm_128 aesccm128;
 		struct tls12_crypto_info_aes_gcm_256 aesgcm256;
+		struct tls12_crypto_info_aria_gcm_128 ariagcm128;
+		struct tls12_crypto_info_aria_gcm_256 ariagcm256;
 	};
 	size_t len;
 };
@@ -76,6 +78,16 @@ static void tls_crypto_info_init(uint16_t tls_version, uint16_t cipher_type,
 		tls12->aesgcm256.info.version = tls_version;
 		tls12->aesgcm256.info.cipher_type = cipher_type;
 		break;
+	case TLS_CIPHER_ARIA_GCM_128:
+		tls12->len = sizeof(struct tls12_crypto_info_aria_gcm_128);
+		tls12->ariagcm128.info.version = tls_version;
+		tls12->ariagcm128.info.cipher_type = cipher_type;
+		break;
+	case TLS_CIPHER_ARIA_GCM_256:
+		tls12->len = sizeof(struct tls12_crypto_info_aria_gcm_256);
+		tls12->ariagcm256.info.version = tls_version;
+		tls12->ariagcm256.info.cipher_type = cipher_type;
+		break;
 	default:
 		break;
 	}
@@ -312,6 +324,18 @@ FIXTURE_VARIANT_ADD(tls, 13_nopad)
 	.nopad = true,
 };
 
+FIXTURE_VARIANT_ADD(tls, 12_aria_gcm)
+{
+	.tls_version = TLS_1_2_VERSION,
+	.cipher_type = TLS_CIPHER_ARIA_GCM_128,
+};
+
+FIXTURE_VARIANT_ADD(tls, 12_aria_gcm_256)
+{
+	.tls_version = TLS_1_2_VERSION,
+	.cipher_type = TLS_CIPHER_ARIA_GCM_256,
+};
+
 FIXTURE_SETUP(tls)
 {
 	struct tls_crypto_info_keys tls12;
-- 
2.40.1

