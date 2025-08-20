Return-Path: <linux-kselftest+bounces-39348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7910CB2D1D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 04:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E60572292A
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 02:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8388D224898;
	Wed, 20 Aug 2025 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCFDwNVN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFDE223335;
	Wed, 20 Aug 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755656401; cv=none; b=F6tKpPBX7DOZzLphAmVOG8npgCAQ2b/q+zAgub9uOUBhGUqDaD+6QHYqYLE2Xy8yW9HndGtYsxCn8yUxPR2ggE2WKpRQGT/RAFrmu5TQNE49DJ65U9FAF7PF0kMNNzU2GNzRuWW1Nw0rnIDD59I4SbOoEe85ee7SkvH7Twq1+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755656401; c=relaxed/simple;
	bh=TihLDgDB0EiuerOnjVfDbUlrtmZZUGjg+EUXhvqj688=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NoZXd0ncm1Rvpcb5QWSx26wd+sU714MZVnB0w+QMM82hMpW5sVrr0vOQ73+7L/sNjRO7B9r6NNFYGoGtshWJCzcvoS6sWzccPz5iR8sKfhnDXOlsw2zalrHp50WLSFybvlpO2K2e5hNwwAWGkUo9HvD3eAOZ301gGXTNozFhUnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCFDwNVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7EBCC113D0;
	Wed, 20 Aug 2025 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755656400;
	bh=TihLDgDB0EiuerOnjVfDbUlrtmZZUGjg+EUXhvqj688=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nCFDwNVNBV0GjMIQzuLWIvJ4rKJG7CnqQ86uAxENPdgV+7mRv74iO8r66dE5Ntn4r
	 cfsQFsToJ8UY/2C5VN/CAdvzrFwYWJCYAvwwt0H3mBtmR2C8AkKU3AfLx/liNIz8KW
	 /jRRbaw7SW6IfTD/w7DFai7pxXPhepmH1L60NyBQlQjg9szSiaE6rBH4OVAu2I+zE3
	 AehDrO7fubtzCefc4/2pLGUFe4g5h3U2gS9EazBIw/jjn8CGSwe7rt6iILCct7P3wq
	 YvqHt3dh2yDaKFXIvZG++LKnTzoo6pPE3lGsfEgpCubF8O3g+rjAfOYifK/dN/NM72
	 j+qL9n9kGnL8Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sd@queasysnail.net,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/2] selftests: tls: add tests for zero-length records
Date: Tue, 19 Aug 2025 19:19:52 -0700
Message-ID: <20250820021952.143068-2-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820021952.143068-1-kuba@kernel.org>
References: <20250820021952.143068-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test various combinations of zero-length records.
Unfortunately, kernel cannot be coerced into producing those,
so hardcode the ciphertext messages in the test.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/tls.c | 300 +++++++++++++++++++++++++++++-
 1 file changed, 295 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 2b8387a83bc7..0f5640d8dc7f 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -181,13 +181,12 @@ static int tls_send_cmsg(int fd, unsigned char record_type,
 	return sendmsg(fd, &msg, flags);
 }
 
-static int tls_recv_cmsg(struct __test_metadata *_metadata,
-			 int fd, unsigned char record_type,
-			 void *data, size_t len, int flags)
+static int __tls_recv_cmsg(struct __test_metadata *_metadata,
+			   int fd, unsigned char *ctype,
+			   void *data, size_t len, int flags)
 {
 	char cbuf[CMSG_SPACE(sizeof(char))];
 	struct cmsghdr *cmsg;
-	unsigned char ctype;
 	struct msghdr msg;
 	struct iovec vec;
 	int n;
@@ -206,7 +205,20 @@ static int tls_recv_cmsg(struct __test_metadata *_metadata,
 	EXPECT_NE(cmsg, NULL);
 	EXPECT_EQ(cmsg->cmsg_level, SOL_TLS);
 	EXPECT_EQ(cmsg->cmsg_type, TLS_GET_RECORD_TYPE);
-	ctype = *((unsigned char *)CMSG_DATA(cmsg));
+	if (ctype)
+		*ctype = *((unsigned char *)CMSG_DATA(cmsg));
+
+	return n;
+}
+
+static int tls_recv_cmsg(struct __test_metadata *_metadata,
+			 int fd, unsigned char record_type,
+			 void *data, size_t len, int flags)
+{
+	unsigned char ctype;
+	int n;
+
+	n = __tls_recv_cmsg(_metadata, fd, &ctype, data, len, flags);
 	EXPECT_EQ(ctype, record_type);
 
 	return n;
@@ -2164,6 +2176,284 @@ TEST_F(tls, rekey_poll_delay)
 	}
 }
 
+struct raw_rec {
+	unsigned int plain_len;
+	unsigned char plain_data[100];
+	unsigned int cipher_len;
+	unsigned char cipher_data[128];
+};
+
+/* TLS 1.2, AES_CCM, data, seqno:0, plaintext: 'Hello world' */
+static const struct raw_rec id0_data_l11 = {
+	.plain_len = 11,
+	.plain_data = {
+		0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x77, 0x6f,
+		0x72, 0x6c, 0x64,
+	},
+	.cipher_len = 40,
+	.cipher_data = {
+		0x17, 0x03, 0x03, 0x00, 0x23, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x26, 0xa2, 0x33,
+		0xde, 0x8d, 0x94, 0xf0, 0x29, 0x6c, 0xb1, 0xaf,
+		0x6a, 0x75, 0xb2, 0x93, 0xad, 0x45, 0xd5, 0xfd,
+		0x03, 0x51, 0x57, 0x8f, 0xf9, 0xcc, 0x3b, 0x42,
+	},
+};
+
+/* TLS 1.2, AES_CCM, ctrl, seqno:0, plaintext: '' */
+static const struct raw_rec id0_ctrl_l0 = {
+	.plain_len = 0,
+	.plain_data = {
+	},
+	.cipher_len = 29,
+	.cipher_data = {
+		0x16, 0x03, 0x03, 0x00, 0x18, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0x13, 0x38, 0x7b,
+		0xa6, 0x1c, 0xdd, 0xa7, 0x19, 0x33, 0xab, 0xae,
+		0x88, 0xe1, 0xd2, 0x08, 0x4f,
+	},
+};
+
+/* TLS 1.2, AES_CCM, data, seqno:0, plaintext: '' */
+static const struct raw_rec id0_data_l0 = {
+	.plain_len = 0,
+	.plain_data = {
+	},
+	.cipher_len = 29,
+	.cipher_data = {
+		0x17, 0x03, 0x03, 0x00, 0x18, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x00, 0xc5, 0x37, 0x90,
+		0x70, 0x45, 0x89, 0xfb, 0x5c, 0xc7, 0x89, 0x03,
+		0x68, 0x80, 0xd3, 0xd8, 0xcc,
+	},
+};
+
+/* TLS 1.2, AES_CCM, data, seqno:1, plaintext: 'Hello world' */
+static const struct raw_rec id1_data_l11 = {
+	.plain_len = 11,
+	.plain_data = {
+		0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x77, 0x6f,
+		0x72, 0x6c, 0x64,
+	},
+	.cipher_len = 40,
+	.cipher_data = {
+		0x17, 0x03, 0x03, 0x00, 0x23, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x01, 0x3a, 0x1a, 0x9c,
+		0xd0, 0xa8, 0x9a, 0xd6, 0x69, 0xd6, 0x1a, 0xe3,
+		0xb5, 0x1f, 0x0d, 0x2c, 0xe2, 0x97, 0x46, 0xff,
+		0x2b, 0xcc, 0x5a, 0xc4, 0xa3, 0xb9, 0xef, 0xba,
+	},
+};
+
+/* TLS 1.2, AES_CCM, ctrl, seqno:1, plaintext: '' */
+static const struct raw_rec id1_ctrl_l0 = {
+	.plain_len = 0,
+	.plain_data = {
+	},
+	.cipher_len = 29,
+	.cipher_data = {
+		0x16, 0x03, 0x03, 0x00, 0x18, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x01, 0x3e, 0xf0, 0xfe,
+		0xee, 0xd9, 0xe2, 0x5d, 0xc7, 0x11, 0x4c, 0xe6,
+		0xb4, 0x7e, 0xef, 0x40, 0x2b,
+	},
+};
+
+/* TLS 1.2, AES_CCM, data, seqno:1, plaintext: '' */
+static const struct raw_rec id1_data_l0 = {
+	.plain_len = 0,
+	.plain_data = {
+	},
+	.cipher_len = 29,
+	.cipher_data = {
+		0x17, 0x03, 0x03, 0x00, 0x18, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x01, 0xce, 0xfc, 0x86,
+		0xc8, 0xf0, 0x55, 0xf9, 0x47, 0x3f, 0x74, 0xdc,
+		0xc9, 0xbf, 0xfe, 0x5b, 0xb1,
+	},
+};
+
+/* TLS 1.2, AES_CCM, ctrl, seqno:2, plaintext: 'Hello world' */
+static const struct raw_rec id2_ctrl_l11 = {
+	.plain_len = 11,
+	.plain_data = {
+		0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x77, 0x6f,
+		0x72, 0x6c, 0x64,
+	},
+	.cipher_len = 40,
+	.cipher_data = {
+		0x16, 0x03, 0x03, 0x00, 0x23, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x02, 0xe5, 0x3d, 0x19,
+		0x3d, 0xca, 0xb8, 0x16, 0xb6, 0xff, 0x79, 0x87,
+		0x2a, 0x04, 0x11, 0x3d, 0xf8, 0x64, 0x5f, 0x36,
+		0x8b, 0xa8, 0xee, 0x4c, 0x6d, 0x62, 0xa5, 0x00,
+	},
+};
+
+/* TLS 1.2, AES_CCM, data, seqno:2, plaintext: 'Hello world' */
+static const struct raw_rec id2_data_l11 = {
+	.plain_len = 11,
+	.plain_data = {
+		0x48, 0x65, 0x6c, 0x6c, 0x6f, 0x20, 0x77, 0x6f,
+		0x72, 0x6c, 0x64,
+	},
+	.cipher_len = 40,
+	.cipher_data = {
+		0x17, 0x03, 0x03, 0x00, 0x23, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x02, 0xe5, 0x3d, 0x19,
+		0x3d, 0xca, 0xb8, 0x16, 0xb6, 0xff, 0x79, 0x87,
+		0x8e, 0xa1, 0xd0, 0xcd, 0x33, 0xb5, 0x86, 0x2b,
+		0x17, 0xf1, 0x52, 0x2a, 0x55, 0x62, 0x65, 0x11,
+	},
+};
+
+/* TLS 1.2, AES_CCM, ctrl, seqno:2, plaintext: '' */
+static const struct raw_rec id2_ctrl_l0 = {
+	.plain_len = 0,
+	.plain_data = {
+	},
+	.cipher_len = 29,
+	.cipher_data = {
+		0x16, 0x03, 0x03, 0x00, 0x18, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x02, 0xdc, 0x5c, 0x0e,
+		0x41, 0xdd, 0xba, 0xd3, 0xcc, 0xcf, 0x6d, 0xd9,
+		0x06, 0xdb, 0x79, 0xe5, 0x5d,
+	},
+};
+
+/* TLS 1.2, AES_CCM, data, seqno:2, plaintext: '' */
+static const struct raw_rec id2_data_l0 = {
+	.plain_len = 0,
+	.plain_data = {
+	},
+	.cipher_len = 29,
+	.cipher_data = {
+		0x17, 0x03, 0x03, 0x00, 0x18, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x02, 0xc3, 0xca, 0x26,
+		0x22, 0xe4, 0x25, 0xfb, 0x5f, 0x6d, 0xbf, 0x83,
+		0x30, 0x48, 0x69, 0x1a, 0x47,
+	},
+};
+
+FIXTURE(zero_len)
+{
+	int fd, cfd;
+	bool notls;
+};
+
+FIXTURE_VARIANT(zero_len)
+{
+	const struct raw_rec *recs[4];
+	ssize_t recv_ret[4];
+};
+
+FIXTURE_VARIANT_ADD(zero_len, data_data_data)
+{
+	.recs = { &id0_data_l11, &id1_data_l11, &id2_data_l11, },
+	.recv_ret = { 33, -EAGAIN, },
+};
+
+FIXTURE_VARIANT_ADD(zero_len, data_0ctrl_data)
+{
+	.recs = { &id0_data_l11, &id1_ctrl_l0, &id2_data_l11, },
+	.recv_ret = { 11, 0, 11, -EAGAIN, },
+};
+
+FIXTURE_VARIANT_ADD(zero_len, 0data_0data_0data)
+{
+	.recs = { &id0_data_l0, &id1_data_l0, &id2_data_l0, },
+	.recv_ret = { -EAGAIN, },
+};
+
+FIXTURE_VARIANT_ADD(zero_len, 0data_0data_ctrl)
+{
+	.recs = { &id0_data_l0, &id1_data_l0, &id2_ctrl_l11, },
+	.recv_ret = { 0, 11, -EAGAIN, },
+};
+
+FIXTURE_VARIANT_ADD(zero_len, 0data_0data_0ctrl)
+{
+	.recs = { &id0_data_l0, &id1_data_l0, &id2_ctrl_l0, },
+	.recv_ret = { 0, 0, -EAGAIN, },
+};
+
+FIXTURE_VARIANT_ADD(zero_len, 0ctrl_0ctrl_0ctrl)
+{
+	.recs = { &id0_ctrl_l0, &id1_ctrl_l0, &id2_ctrl_l0, },
+	.recv_ret = { 0, 0, 0, -EAGAIN, },
+};
+
+FIXTURE_VARIANT_ADD(zero_len, 0data_0data_data)
+{
+	.recs = { &id0_data_l0, &id1_data_l0, &id2_data_l11, },
+	.recv_ret = { 11, -EAGAIN, },
+};
+
+FIXTURE_VARIANT_ADD(zero_len, data_0data_0data)
+{
+	.recs = { &id0_data_l11, &id1_data_l0, &id2_data_l0, },
+	.recv_ret = { 11, -EAGAIN, },
+};
+
+FIXTURE_SETUP(zero_len)
+{
+	struct tls_crypto_info_keys tls12;
+	int ret;
+
+	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
+			     &tls12, 0);
+
+	ulp_sock_pair(_metadata, &self->fd, &self->cfd, &self->notls);
+	if (self->notls)
+		return;
+
+	/* Don't install keys on fd, we'll send raw records */
+	ret = setsockopt(self->cfd, SOL_TLS, TLS_RX, &tls12, tls12.len);
+	ASSERT_EQ(ret, 0);
+}
+
+FIXTURE_TEARDOWN(zero_len)
+{
+	close(self->fd);
+	close(self->cfd);
+}
+
+TEST_F(zero_len, test)
+{
+	const struct raw_rec *const *rec;
+	unsigned char buf[128];
+	int rec_off;
+	int i;
+
+	for (i = 0; i < 4 && variant->recs[i]; i++)
+		EXPECT_EQ(send(self->fd, variant->recs[i]->cipher_data,
+			       variant->recs[i]->cipher_len, 0),
+			  variant->recs[i]->cipher_len);
+
+	rec = &variant->recs[0];
+	rec_off = 0;
+	for (i = 0; i < 4; i++) {
+		int j, ret;
+
+		ret = variant->recv_ret[i] >= 0 ? variant->recv_ret[i] : -1;
+		EXPECT_EQ(__tls_recv_cmsg(_metadata, self->cfd, NULL,
+					  buf, sizeof(buf), MSG_DONTWAIT), ret);
+		if (ret == -1)
+			EXPECT_EQ(errno, -variant->recv_ret[i]);
+		if (variant->recv_ret[i] == -EAGAIN)
+			break;
+
+		for (j = 0; j < ret; j++) {
+			while (rec_off == (*rec)->plain_len) {
+				rec++;
+				rec_off = 0;
+			}
+			EXPECT_EQ(buf[j], (*rec)->plain_data[rec_off]);
+			rec_off++;
+		}
+	}
+};
+
 FIXTURE(tls_err)
 {
 	int fd, cfd;
-- 
2.50.1


