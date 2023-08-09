Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB84477600E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjHIM7y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 08:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjHIM7y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 08:59:54 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D441FFB
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 05:59:52 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-uRtV6th5PJSm9TCk1AqRNw-1; Wed, 09 Aug 2023 08:59:34 -0400
X-MC-Unique: uRtV6th5PJSm9TCk1AqRNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BCC9185A78B;
        Wed,  9 Aug 2023 12:59:33 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDFE52166B25;
        Wed,  9 Aug 2023 12:59:31 +0000 (UTC)
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
Subject: [PATCH net-next v3 6/6] selftests: tls: add rekey tests
Date:   Wed,  9 Aug 2023 14:58:55 +0200
Message-Id: <b66c17d650e970c40965041df97357d28e05631d.1691584074.git.sd@queasysnail.net>
In-Reply-To: <cover.1691584074.git.sd@queasysnail.net>
References: <cover.1691584074.git.sd@queasysnail.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v2: add rekey_fail test (reject changing the version/cipher)
v3: add rekey_peek_splice (suggested by Jakub)
    add rekey+poll tests

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/tls.c | 450 ++++++++++++++++++++++++++++++
 1 file changed, 450 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 8d05748a0f57..d1a50995a662 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1474,6 +1474,456 @@ TEST_F(tls, shutdown_reuse)
 	EXPECT_EQ(errno, EISCONN);
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
+		exit(!_metadata->passed);
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
+		exit(!_metadata->passed);
+	}
+}
+
 FIXTURE(tls_err)
 {
 	int fd, cfd;
-- 
2.40.1

