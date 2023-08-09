Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1320776009
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 14:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjHIM7r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 08:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjHIM7q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 08:59:46 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC221FF6
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 05:59:45 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-UjERp_4sMz6znNLlqYM6Rw-1; Wed, 09 Aug 2023 08:59:25 -0400
X-MC-Unique: UjERp_4sMz6znNLlqYM6Rw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC8AC3C11A02;
        Wed,  9 Aug 2023 12:59:24 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B7032166B25;
        Wed,  9 Aug 2023 12:59:22 +0000 (UTC)
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
Subject: [PATCH net-next v3 2/6] tls: block decryption when a rekey is pending
Date:   Wed,  9 Aug 2023 14:58:51 +0200
Message-Id: <eae51cdb1d15c914577a88fb5cd9d1c4b1121642.1691584074.git.sd@queasysnail.net>
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

When a TLS handshake record carrying a KeyUpdate message is received,
all subsequent records will be encrypted with a new key. We need to
stop decrypting incoming records with the old key, and wait until
userspace provides a new key.

Make a note of this in the RX context just after decrypting that
record, and stop recvmsg/splice calls with EKEYEXPIRED until the new
key is available.

v3:
 - move key_update_pending check into tls_rx_rec_wait (Jakub)
 - TLS_RECORD_TYPE_HANDSHAKE was added to include/net/tls_prot.h by
   the tls handshake series, drop that from this patch
 - move key_update_pending into an existing hole

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/tls.h |  3 +++
 net/tls/tls_sw.c  | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/net/tls.h b/include/net/tls.h
index 06fca9160346..219a4f38c0e4 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -69,6 +69,8 @@ extern const struct tls_cipher_size_desc tls_cipher_size_desc[];
 
 #define TLS_CRYPTO_INFO_READY(info)	((info)->cipher_type)
 
+#define TLS_HANDSHAKE_KEYUPDATE		24	/* rfc8446 B.3: Key update */
+
 #define TLS_AAD_SPACE_SIZE		13
 
 #define MAX_IV_SIZE			16
@@ -141,6 +143,7 @@ struct tls_sw_context_rx {
 	u8 async_capable:1;
 	u8 zc_capable:1;
 	u8 reader_contended:1;
+	bool key_update_pending;
 
 	struct tls_strparser strp;
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 2ca0eb90a2a5..497f56c5f169 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1293,6 +1293,10 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	long timeo;
 
+	/* a rekey is pending, let userspace deal with it */
+	if (unlikely(ctx->key_update_pending))
+		return -EKEYEXPIRED;
+
 	timeo = sock_rcvtimeo(sk, nonblock);
 
 	while (!tls_strp_msg_ready(ctx)) {
@@ -1689,6 +1693,33 @@ tls_decrypt_device(struct sock *sk, struct msghdr *msg,
 	return 1;
 }
 
+static int tls_check_pending_rekey(struct sock *sk, struct sk_buff *skb)
+{
+	const struct tls_msg *tlm = tls_msg(skb);
+	const struct strp_msg *rxm = strp_msg(skb);
+
+	if (tlm->control == TLS_RECORD_TYPE_HANDSHAKE) {
+		char hs_type;
+		int err;
+
+		if (rxm->full_len < 1)
+			return -EINVAL;
+
+		err = skb_copy_bits(skb, rxm->offset, &hs_type, 1);
+		if (err < 0)
+			return err;
+
+		if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
+			struct tls_context *ctx = tls_get_ctx(sk);
+			struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
+
+			rx_ctx->key_update_pending = true;
+		}
+	}
+
+	return 0;
+}
+
 static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 			     struct tls_decrypt_arg *darg)
 {
@@ -1708,6 +1739,10 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
 	rxm->full_len -= prot->overhead_size;
 	tls_advance_record_sn(sk, prot, &tls_ctx->rx);
 
+	err = tls_check_pending_rekey(sk, darg->skb);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
@@ -2642,6 +2677,7 @@ int tls_set_sw_offload(struct sock *sk, int tx)
 		skb_queue_head_init(&sw_ctx_rx->rx_list);
 		skb_queue_head_init(&sw_ctx_rx->async_hold);
 		aead = &sw_ctx_rx->aead_recv;
+		sw_ctx_rx->key_update_pending = false;
 	}
 
 	switch (crypto_info->cipher_type) {
-- 
2.40.1

