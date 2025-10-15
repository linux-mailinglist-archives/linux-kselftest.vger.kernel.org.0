Return-Path: <linux-kselftest+bounces-43155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A582BDC107
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 03:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC5984008DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 01:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F7430C340;
	Wed, 15 Oct 2025 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnOhyz93"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4DE30B522
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493206; cv=none; b=VBdZugPIEJ7Nh6XnB5iTw9uo73TBI0ZX1EHFsc+l+NalinXtCR75u6duYO+W6A8RLafcpuLNlhdHPq1bfgZ0ItcwQQogPqqRZxvccYz0yKmNMuMp7ydDg7By/QMITFNsxXqmpWyl6tX0kJMb/rT4qBPk41NlVngDl2snxjfa2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493206; c=relaxed/simple;
	bh=9RRIxNvkdJzZEHQcDLQmeYeLTnGKYUa3WGMGZiJeAKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRwfQAhchwBAj0aj6g/iRhf9UMSh5Gxb6EkydY5U7LjZBiS1axfdvyZ4O/zb9EwebiBr+uyUWWQ9NC2W49gOK/8CrEPZgalNo6UADfUpeMNybUPcuZ090jqIscR6az+Pc3einrH9/0otaMweDjJPz+2dc5WEoJ0ZnI8Y5aTLTcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnOhyz93; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2698d47e776so45802105ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 18:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760493197; x=1761097997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4jaCd/1DWbgn+CA8tzmONaNbKtsGtABNKa+v5VGOeQ=;
        b=AnOhyz936MVwprfv8AfzeB8rgqXUFnCesu+hA/7GHZip2quvOBMstkonHszmwxEo8e
         h7S6q6qtDqpCFVU+50dw+BeIQyhJbJ+2IzrpG24OenoJp2Bv6slhYhLJU8JID/Ia4d5F
         Xxu3hYvLSieJ8LRh5uxVPFQJnj3SJLzpmyaJ6o4C9SvNK8tomcDp/XMkc/VM5xrLKIfe
         pjeHTHMDL6o51U8pua3sCXPnV1qMo7eWeNzPFndNvqH3IIYiYmGhdw5t+BserYu7S/qU
         vulvyw/hYTL4+8Rr1qE0oMqgviypMyBau9iLfPG0jJZCZnG6m/AEnqpjKO+BK3YJY61A
         o4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493197; x=1761097997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4jaCd/1DWbgn+CA8tzmONaNbKtsGtABNKa+v5VGOeQ=;
        b=Vj071QiPZ6mafihZyHEwKRs73Ak1bQHYbq4beaYZF+ZWPz8nVVrwWOh+dVzUIcdwDw
         z+/Gmz7K6E+5ymEfBu5uwdKlEQCky80EVteenzJ43PTe+NLr6SJ3UOb7TL7+IqAwM4UK
         2/Wo+xtMEThdS5iy5ieKre01JlNbSsEEc5bKtUD1Th4KBNEAFg5vqHU/A8g1+Id3eZX0
         xaD8lTWKjgxdy9+dAiKMWgZQRo26w2oiUAm9xzeDqks8Zwag5ChW1AEEyYrhEECjhET5
         ul+0QZLQvIk2xFHQv7TyLdcBgMfmjrsddfz1XXfXKHdKV9FuVOXs8NcjvKHyucH0pGZX
         EyBw==
X-Forwarded-Encrypted: i=1; AJvYcCWRixX6T1nBvUly5nU6Wes2YbMLAjD7MsGu++r1ipBj5utSR7ugq2rqnOQbRRsq92qmTfGviFTBwNYYJvFx7D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfHR4xz5jtKD+V6odov5/pLxsxQz4aLyDMS0+IzCuJd8r1/a2a
	XJ/oVmV7qrisLNP9yzv9EzXAzfVx2YeZA6FnwQYVh7puI0pZzW+RxfLq
X-Gm-Gg: ASbGncsoI+JNbKFs4tHdG+Sein+tvWYOt4SmwD/MdVn/CqzuQjrO3auI9tM/4bML3xn
	T4zzNt7qwyf6LUiWDEoLXXKkIqpFKy7S3ayxaRIyvfvknJopQUHF/b3eAnHwHfF/j6uy7u3s3JO
	9Hn4+d7QF20zSBI7P5tZvJXQf6FhwNvnk0Ll5GkoEJe0OJlUNYslAzbTprW5CNKxwUiJGAAkQX8
	Yfnt46CZc/5snbyELkmkNX8r5WXaz0tJvCfjhYo90iy+pCpqV8OMfbK9PUt4hrxNr5CGEu68Ig0
	TPCA4DAPQXmj2hFxUtIpT4+lPlTNL4nRnx2Yoz9wx+zsxj8f6Ofk25Ax2jNzEwl4qtDxO18MoSo
	wkIs/VaJx/Za/HBJL+F7/sm3CdZbkQK4LWCjEn3FEoz2n3PL4wfVbM1sn
X-Google-Smtp-Source: AGHT+IEta6vNkL2qYn4xecoYbGeGh0tvTz8Mzn2/SVZLfq79W+xm/83cjsbfvmppODKW/1L9yy+I2g==
X-Received: by 2002:a17:902:ef0f:b0:27c:56af:88ea with SMTP id d9443c01a7336-290273a5f20mr271822745ad.60.1760493197148;
        Tue, 14 Oct 2025 18:53:17 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29055badc54sm111789325ad.37.2025.10.14.18.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:53:16 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH net-next v6 2/2] selftests: tls: add tls record_size_limit test
Date: Wed, 15 Oct 2025 11:52:44 +1000
Message-ID: <20251015015243.72259-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015015243.72259-2-wilfred.opensource@gmail.com>
References: <20251015015243.72259-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Test that outgoing plaintext records respect the tls TLS_TX_MAX_PAYLOAD_LEN
set using setsockopt(). The limit is set to be 128, thus, in all received
records, the plaintext must not exceed this amount.

Also test that setting a new record size limit whilst a pending open
record exists is handled correctly by discarding the request.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 tools/testing/selftests/net/tls.c | 141 ++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index e788b84551ca..158dec851176 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2791,6 +2791,147 @@ TEST_F(tls_err, oob_pressure)
 		EXPECT_EQ(send(self->fd2, buf, 5, MSG_OOB), 5);
 }
 
+/*
+ * Parse a stream of TLS records and ensure that each record respects
+ * the specified @max_payload_len.
+ */
+static size_t parse_tls_records(struct __test_metadata *_metadata,
+				const __u8 *rx_buf, int rx_len, int overhead,
+				__u16 max_payload_len)
+{
+	const __u8 *rec = rx_buf;
+	size_t total_plaintext_rx = 0;
+	const __u8 rec_header_len = 5;
+
+	while (rec < rx_buf + rx_len) {
+		__u16 record_payload_len;
+		__u16 plaintext_len;
+
+		/* Sanity check that it's a TLS header for application data */
+		ASSERT_EQ(rec[0], 23);
+		ASSERT_EQ(rec[1], 0x3);
+		ASSERT_EQ(rec[2], 0x3);
+
+		memcpy(&record_payload_len, rec + 3, 2);
+		record_payload_len = ntohs(record_payload_len);
+		ASSERT_GE(record_payload_len, overhead);
+
+		plaintext_len = record_payload_len - overhead;
+		total_plaintext_rx += plaintext_len;
+
+		/* Plaintext must not exceed the specified limit */
+		ASSERT_LE(plaintext_len, max_payload_len);
+		rec += rec_header_len + record_payload_len;
+	}
+
+	return total_plaintext_rx;
+}
+
+TEST(tx_max_payload_len)
+{
+	struct tls_crypto_info_keys tls12;
+	int cfd, ret, fd, overhead;
+	size_t total_plaintext_rx = 0;
+	__u8 tx[1024], rx[2000];
+	__u16 limit = 128;
+	__u16 opt = 0;
+	unsigned int optlen = sizeof(opt);
+	bool notls;
+
+	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
+			     &tls12, 0);
+
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+
+	if (notls)
+		exit(KSFT_SKIP);
+
+	/* Don't install keys on fd, we'll parse raw records */
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX, &tls12, tls12.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &limit,
+			 sizeof(limit));
+	ASSERT_EQ(ret, 0);
+
+	ret = getsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &opt, &optlen);
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(limit, opt);
+	EXPECT_EQ(optlen, sizeof(limit));
+
+	memset(tx, 0, sizeof(tx));
+	ASSERT_EQ(send(cfd, tx, sizeof(tx), 0), sizeof(tx));
+	close(cfd);
+
+	ret = recv(fd, rx, sizeof(rx), 0);
+
+	/*
+	 * 16B tag + 8B IV -- record header (5B) is not counted but we'll
+	 * need it to walk the record stream
+	 */
+	overhead = 16 + 8;
+	total_plaintext_rx = parse_tls_records(_metadata, rx, ret, overhead,
+					       limit);
+
+	ASSERT_EQ(total_plaintext_rx, sizeof(tx));
+	close(fd);
+}
+
+TEST(tx_max_payload_len_open_rec)
+{
+	struct tls_crypto_info_keys tls12;
+	int cfd, ret, fd, overhead;
+	size_t total_plaintext_rx = 0;
+	__u8 tx[1024], rx[2000];
+	__u16 tx_partial = 256;
+	__u16 og_limit = 512, limit = 128;
+	bool notls;
+
+	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
+			     &tls12, 0);
+
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+
+	if (notls)
+		exit(KSFT_SKIP);
+
+	/* Don't install keys on fd, we'll parse raw records */
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX, &tls12, tls12.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &og_limit,
+			 sizeof(og_limit));
+	ASSERT_EQ(ret, 0);
+
+	memset(tx, 0, sizeof(tx));
+	ASSERT_EQ(send(cfd, tx, tx_partial, MSG_MORE), tx_partial);
+
+	/*
+	 * Changing the payload limit with a pending open record should
+	 * not be allowed.
+	 */
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &limit,
+			 sizeof(limit));
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EBUSY);
+
+	ASSERT_EQ(send(cfd, tx + tx_partial, sizeof(tx) - tx_partial, MSG_EOR),
+		  sizeof(tx) - tx_partial);
+	close(cfd);
+
+	ret = recv(fd, rx, sizeof(rx), 0);
+
+	/*
+	 * 16B tag + 8B IV -- record header (5B) is not counted but we'll
+	 * need it to walk the record stream
+	 */
+	overhead = 16 + 8;
+	total_plaintext_rx = parse_tls_records(_metadata, rx, ret, overhead,
+					       og_limit);
+	ASSERT_EQ(total_plaintext_rx, sizeof(tx));
+	close(fd);
+}
+
 TEST(non_established) {
 	struct tls12_crypto_info_aes_gcm_256 tls12;
 	struct sockaddr_in addr;
-- 
2.51.0


