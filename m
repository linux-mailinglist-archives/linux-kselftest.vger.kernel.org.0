Return-Path: <linux-kselftest+bounces-42128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD7B946C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B93D4808B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 05:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4122B30EF6F;
	Tue, 23 Sep 2025 05:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5tJ60wz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2D30E820
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 05:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758605553; cv=none; b=A/Es5ouvHEEaIts9rOCnLDmxNWM/cOPpr3EyoxxM/vjD64jPhTBF310psAOB3ajfyVY4pmz0WYA2HcbLjK9oeVjF9Lm61fuUTLM2kOJuoo6Z92Z/ZgpzCaO0OhLGIzsmDoZRT5xmNVk/pVvVXbVhJdDMpb3SKQ/4u0gG0otbt5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758605553; c=relaxed/simple;
	bh=1pS++iW3e+7ZhIj9iPpIm2WsDUNya31yJigHOIM7hSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l51pYEJhR9aql0XXKrYcQsDvcDtUZ2odFSIMpWtj2twSx2k75u41DIJ9XRToJOWoxSxzhlD/pc28JHFzHpVVxwdjBviiGQSlBNYDJLZYbcs1sChASHlz6VqLB9juWrawMDSlId16gGQp++YTzD+/ycrh3WcBHdQclhFGwBQe/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5tJ60wz; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77dedf198d4so5584218b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Sep 2025 22:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758605551; x=1759210351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LElroZcQYrizHT6tMHELz8wvWrEyU+n/zvC8wyzfdOY=;
        b=K5tJ60wzx5GBM9zbWHLW321NGy7ynOuikVisbcEho3tAsCd/FXG83ubZFSdhECck7U
         0smTEG7P6GEcIAxA2SGJeNJN99zmtuaVeZ1MlhM4aSVTQcgMfoKSKJQlmGoZ0BR397Wa
         bVtzx8e/0TJhJDax8wZt2zgkAzy0NA6DkQrmwVnszm7G9IVwDJl6FmszZ9HaH+Rsdins
         02w9R8P4K15rIruXe6QyM+4PYOQqWErGCMFfJKXmMELDcOM6/Shklji/o6xoopxbR5JK
         q+anD1GNonneyUxqehQOAfA2YtiYPeQbh+Vkj0ezt9i2K1mblfc6VdCSXbicOQzJnZ5E
         7RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758605551; x=1759210351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LElroZcQYrizHT6tMHELz8wvWrEyU+n/zvC8wyzfdOY=;
        b=YYZmWA62LF6GU+j/cJyHyBUWz7u9VCYxxjFyG7AwO+kkuD5HNF02b03DGtDKpCk6e6
         Xb/WQUHyZjJWK2emPwP0o/L8RTsMIW/TITM0IQreSJp4KxB7tpdGC2Jo5zallWCGkYgS
         xQlC/woibyUw1y+ErDk/xvaFwzCDZ1LbSVA6RRRFkSrDehyMSIn1YX0mF8kk7g5tR/zG
         XILFECQFHDgiM5T9F1uWhlDQrMicQyDbt5+KP4C0aT0z9sOYSw2Uua163ds3KHOQNrvm
         b2Kyjgl7ClXAc2gqoLm6hq4rGzXjUaHH375sUj6teEW4xDUWw3FsyKnUfrxK24pXol8i
         Q0nA==
X-Forwarded-Encrypted: i=1; AJvYcCX/6ce0p3pZxlkCEq4pKWCM+VIzwVKyidiNGE7vTWlqn7JJ0XgPMYazE+1iu4MCLObDQ5vl8mFIvso3FjpiHxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoXv0b8hEMPh78SYUVoDt2ePo8LrtuV9k/jSwWtgXC2kYZXPAF
	DoqOrPzMSCTbxnYJrYkSxm3HkYk/ulhWJFmbS1jK73cwbNwf+UdC9828
X-Gm-Gg: ASbGncszeaT+FJuEC0j8hanAM5mlfPPM9LrR/4IPWyHRaOKnhxXZX+CZolhmcUDhQOP
	fzqsQWXldB8EJP8VbjqUBRmM6DG4QkN759h4FGOL0nPPf9nExaGBw70RmHYzjQnCk34HUvxd0ZN
	T76K7D2oAvDxaC6Jss6t8KrmAyoroldOruqWCnNRFlOmDVZLg3F+t574FfiwDVo1qAsXzTMfpfT
	/XYQEnu4i4uh5kBugfR+X1UccFdW19kraOIIN0x2/c7xm3JKuaamUhnIpqUZI6WtUpnBNXssay/
	ve8RMGI3TAX8edisgF8pHy+axaKJEJII3NMp+oe48tqJ5rJpX/E/GKDxmWexwSq28yvtbpeM1+D
	TAAiQyCG0ftSjwe0zFN+W+54snnE=
X-Google-Smtp-Source: AGHT+IGkt4j8KVJKU+v7beSqHDNw563BzIVI/+APRZhBu+0GLuw5ol/2rDP4fdS5XeLUIfJuRJ9+Kg==
X-Received: by 2002:a05:6a00:21ca:b0:771:e4c6:10cc with SMTP id d2e1a72fcca58-77f53899b37mr1970577b3a.6.1758605550782;
        Mon, 22 Sep 2025 22:32:30 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1550f70asm9639446b3a.13.2025.09.22.22.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 22:32:30 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	shuah@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v4 2/2] selftests: tls: add tls record_size_limit test
Date: Tue, 23 Sep 2025 15:32:07 +1000
Message-ID: <20250923053207.113938-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923053207.113938-1-wilfred.opensource@gmail.com>
References: <20250923053207.113938-1-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Test that outgoing plaintext records respect the tls record_size_limit
set using setsockopt(). The record size limit is set to be 128, thus,
in all received records, the plaintext must not exceed this amount.

Also test that setting a new record size limit whilst a pending open
record exists is handled correctly by discarding the request.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 tools/testing/selftests/net/tls.c | 149 ++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 0f5640d8dc7f..c5bd431d5af3 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -24,6 +24,7 @@
 #include "../kselftest_harness.h"
 
 #define TLS_PAYLOAD_MAX_LEN 16384
+#define TLS_TX_RECORD_SIZE_LIM 5
 #define SOL_TLS 282
 
 static int fips_enabled;
@@ -2770,6 +2771,154 @@ TEST_F(tls_err, poll_partial_rec_async)
 	}
 }
 
+/*
+ * Parse a stream of TLS records and ensure that each record respects
+ * the specified @record_size_limit.
+ */
+static size_t parse_tls_records(struct __test_metadata *_metadata,
+				const __u8 *rx_buf, int rx_len, int overhead,
+				__u16 record_size_limit)
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
+		ASSERT_LE(plaintext_len, record_size_limit);
+		rec += rec_header_len + record_payload_len;
+	}
+
+	return total_plaintext_rx;
+}
+
+TEST(tx_record_size)
+{
+	struct tls_crypto_info_keys tls12;
+	int cfd, ret, fd, rx_len, overhead;
+	size_t total_plaintext_rx = 0;
+	__u8 tx[1024], rx[2000];
+	__u8 *rec;
+	__u16 limit = 128;
+	__u16 opt = 0;
+	__u8 rec_header_len = 5;
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
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_RECORD_SIZE_LIM, &limit, sizeof(limit));
+	ASSERT_EQ(ret, 0);
+
+	ret = getsockopt(cfd, SOL_TLS, TLS_TX_RECORD_SIZE_LIM, &opt, &optlen);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(limit, opt);
+	ASSERT_EQ(optlen, sizeof(limit));
+
+	memset(tx, 0, sizeof(tx));
+	EXPECT_EQ(send(cfd, tx, sizeof(tx), 0), sizeof(tx));
+	close(cfd);
+
+	ret = recv(fd, rx, sizeof(rx), 0);
+	memcpy(&rx_len, rx + 3, 2);
+	rx_len = htons(rx_len);
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
+TEST(tx_record_size_open_rec)
+{
+	struct tls_crypto_info_keys tls12;
+	int cfd, ret, fd, rx_len, overhead;
+	size_t total_plaintext_rx = 0;
+	__u8 tx[1024], rx[2000];
+	__u16 tx_partial = 256;
+	__u8 *rec;
+	__u16 og_limit = 512, limit = 128;
+	__u8 rec_header_len = 5;
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
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_RECORD_SIZE_LIM, &og_limit,
+			 sizeof(og_limit));
+	ASSERT_EQ(ret, 0);
+
+	memset(tx, 0, sizeof(tx));
+	EXPECT_EQ(send(cfd, tx, tx_partial, MSG_MORE), tx_partial);
+
+	/*
+	 * Changing the record size limit with a pending open record should
+	 * not be allowed.
+	 */
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_RECORD_SIZE_LIM, &limit,
+			 sizeof(limit));
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EBUSY);
+
+	EXPECT_EQ(send(cfd, tx + tx_partial, sizeof(tx) - tx_partial, MSG_EOR),
+		  sizeof(tx) - tx_partial);
+	close(cfd);
+
+	ret = recv(fd, rx, sizeof(rx), 0);
+	memcpy(&rx_len, rx + 3, 2);
+	rx_len = htons(rx_len);
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


