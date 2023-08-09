Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50983776008
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 14:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjHIM7n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 08:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjHIM7n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 08:59:43 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E1B1FF6
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 05:59:42 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-4zjUEokNM8OHUhZVgKvMLQ-1; Wed, 09 Aug 2023 08:59:23 -0400
X-MC-Unique: 4zjUEokNM8OHUhZVgKvMLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2EC838008B3;
        Wed,  9 Aug 2023 12:59:22 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 010482166B25;
        Wed,  9 Aug 2023 12:59:20 +0000 (UTC)
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
Subject: [PATCH net-next v3 1/6] tls: remove tls_context argument from tls_set_sw_offload
Date:   Wed,  9 Aug 2023 14:58:50 +0200
Message-Id: <49bb1e97ace3d18c7b57b2ae6a5011643d351f0a.1691584074.git.sd@queasysnail.net>
In-Reply-To: <cover.1691584074.git.sd@queasysnail.net>
References: <cover.1691584074.git.sd@queasysnail.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It's not really needed since we end up refetching it as tls_ctx. We
can also remove the NULL check, since we have already dereferenced ctx
in do_tls_setsockopt_conf.

v2: reverse xmas tree

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls.h        |  2 +-
 net/tls/tls_device.c |  2 +-
 net/tls/tls_main.c   |  4 ++--
 net/tls/tls_sw.c     | 17 +++++++----------
 4 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 164d6a955e26..6916ff4fbde6 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -89,7 +89,7 @@ void update_sk_prot(struct sock *sk, struct tls_context *ctx);
 int wait_on_pending_writer(struct sock *sk, long *timeo);
 void tls_err_abort(struct sock *sk, int err);
 
-int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx);
+int tls_set_sw_offload(struct sock *sk, int tx);
 void tls_update_rx_zc_capable(struct tls_context *tls_ctx);
 void tls_sw_strparser_arm(struct sock *sk, struct tls_context *ctx);
 void tls_sw_strparser_done(struct tls_context *tls_ctx);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 5df18f696d7f..cc1918a279d4 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -1275,7 +1275,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	context->resync_nh_reset = 1;
 
 	ctx->priv_ctx_rx = context;
-	rc = tls_set_sw_offload(sk, ctx, 0);
+	rc = tls_set_sw_offload(sk, 0);
 	if (rc)
 		goto release_ctx;
 
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 7dbb8cd8f809..ffc50454758e 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -799,7 +799,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXDEVICE);
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRTXDEVICE);
 		} else {
-			rc = tls_set_sw_offload(sk, ctx, 1);
+			rc = tls_set_sw_offload(sk, 1);
 			if (rc)
 				goto err_crypto_info;
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSTXSW);
@@ -813,7 +813,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXDEVICE);
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSCURRRXDEVICE);
 		} else {
-			rc = tls_set_sw_offload(sk, ctx, 0);
+			rc = tls_set_sw_offload(sk, 0);
 			if (rc)
 				goto err_crypto_info;
 			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSRXSW);
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 5c122d7bb784..2ca0eb90a2a5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2581,25 +2581,22 @@ void tls_update_rx_zc_capable(struct tls_context *tls_ctx)
 		tls_ctx->prot_info.version != TLS_1_3_VERSION;
 }
 
-int tls_set_sw_offload(struct sock *sk, struct tls_context *ctx, int tx)
+int tls_set_sw_offload(struct sock *sk, int tx)
 {
-	struct tls_context *tls_ctx = tls_get_ctx(sk);
-	struct tls_prot_info *prot = &tls_ctx->prot_info;
-	struct tls_crypto_info *crypto_info;
+	u16 nonce_size, tag_size, iv_size, rec_seq_size, salt_size;
+	char *iv, *rec_seq, *key, *salt, *cipher_name;
 	struct tls_sw_context_tx *sw_ctx_tx = NULL;
 	struct tls_sw_context_rx *sw_ctx_rx = NULL;
+	struct tls_context *ctx = tls_get_ctx(sk);
+	struct tls_crypto_info *crypto_info;
 	struct cipher_context *cctx;
+	struct tls_prot_info *prot;
 	struct crypto_aead **aead;
-	u16 nonce_size, tag_size, iv_size, rec_seq_size, salt_size;
 	struct crypto_tfm *tfm;
-	char *iv, *rec_seq, *key, *salt, *cipher_name;
 	size_t keysize;
 	int rc = 0;
 
-	if (!ctx) {
-		rc = -EINVAL;
-		goto out;
-	}
+	prot = &ctx->prot_info;
 
 	if (tx) {
 		if (!ctx->priv_ctx_tx) {
-- 
2.40.1

