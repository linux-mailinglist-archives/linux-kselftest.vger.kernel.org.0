Return-Path: <linux-kselftest+bounces-43649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD31BF5831
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 11:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D13C4FEEF1
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Oct 2025 09:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3F32BF38;
	Tue, 21 Oct 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0mU7F9S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19C32BF23
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 09:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038988; cv=none; b=Kd7rfD0C6rRnRD76DsSjCsXyfSKilaoLSTZTisq4GzNov1ac2wIRC5GLm3rQhCtK3ZNb2BKVetTnKrP4GWnPv0StQmlOrGUKtb6FBm2OVg9ycjCYL2IebrFa43MSFcCO75IT+xq8Ftqo4nEKV0rsXCLhlAoJmtRSWTigGFQIklk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038988; c=relaxed/simple;
	bh=a0aYEnjhpTG92+dnI0WBlUVlRCWAmJ8S6jfAl5OV3b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nPPzE5Fys/dLYOnvd4xKEGULS5YHYn8rDGta92Oqq+oYxABIuyaSDI+UWFlz3PBi2iwk+vjmCJK4nkyt/DxrDLhCvykjcV3uEd0caY4I6qWDrbNPvTI7Lfjk2X1U56Wuam4CrNr3EJp6pQNxx0ed1wFoQSofZEryfeUM1SU/DrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0mU7F9S; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b6a7d3040efso1946803a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Oct 2025 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761038986; x=1761643786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvR5jT1gTJqYZoXGVwpmZ3jCtyBD10kX3ZPMFN21KF0=;
        b=m0mU7F9ScuY9yV0ke51OMEnR8mn6fnRzvNVB1pZPpObxmNZOcRhNAY4ic7cKPqwGsW
         RepEORdMPadhq7RyuDkxN0eYNGjjc7DelhO10IMeKcvf9ms0banPOZeOIOBy9vy78o6R
         kWBTA1bl1zpoTDKttQTaNfvTOfODb6uSOCLanSc9Zwdz2diOEFYZo+/nQCUQNqTcl0vN
         WybJLuIxSGnxdzqb1H9/x3fUVeWMU1xhRL1/RqC7+WDEQDAufDWjN9C9VPcXshUrMwi6
         i/HU2VXaoGbYqu22edL+lmM+wMRq3rcwAmPqbaka6CT12IvbRJr9JeirO7JP4a7+75iq
         dnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038986; x=1761643786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvR5jT1gTJqYZoXGVwpmZ3jCtyBD10kX3ZPMFN21KF0=;
        b=kCycnSOBShIBgQZdmkMb8OG7pm1dbYpmPPwjMofX5Ed6iLIphzZJ5ecWd/S1ChrCPN
         iZMKPbS0we687mi9DBCEZ7+26wll6DgmdyRA5cHzI4gF8ZNcaRcH/6oLIeZ/Z5qGwr9d
         yUaNQmmiv0HIIstV/mrpjkdB5JnOJcGU4xUTdjc1EaBO/u60CKW1AJo1b0xs5PuQWe+4
         fHp4f+TVsT4sNDiGINq75egUy4qygGR4uOB6HRTQUwz5JOB9CSKTuTMF6cISGF6l44yk
         QJvufw1SUMN/f60a2s5nHdQzSNvgRWSfVXL5KJhQF4EeUX9znVKVOmN0YcT6zzp9F/yZ
         h0AA==
X-Forwarded-Encrypted: i=1; AJvYcCWBRDDrNr/coCHJH/Jzf6XmmabtDwTiFoqLsZawVi8qsnF3rPr7vPJ1GemZoUkLjSZmj6ZE4MxCPLJE9fQUTYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt91XdJWUL8jpVM9ZabIvCEoDwzX4XyJ2qLiyz9aXDJSdaVtJY
	DikdVBtkwOc6JE6cIyQjjdxsHjbmIBk53bSE+600u8aAJNUFT9so+p+DTSAudE/a
X-Gm-Gg: ASbGncvChMmkjky8EPb5XnBT0ZXlLKNPTK7Tme/wAdr9XMyHE3K/cDfRMufWWPRzfkk
	ZlYNKmYOt2U7V2u1tRSD7Rot8tIK/faT9nUgQIQNvFCYhN17ufftZPahzu6lqBIdyIjjSDfUYr2
	H2gFpI1aa2i9OqEKv16AsMGlNktUwAMKSqkvkzfSuJOKn1IBUYEwhQxrImyKTM+NVm1mW//Sv9g
	5x4uYhG9zkUDIY3V7MP4Ud76k+4NJK+JUdDfIffWWOI2wpQKW6t/ggQkNHIH1NqZdhN0mtFa3s/
	245LXqtIZ2Px8zfvig4OT70abSUD42tNIRX5uQL7VflGsbQ+JJJK9mUrXovM6qNNzEkA5+tuH30
	2VrokWuvpQnEz/J4r+jFN/cRObwmxhHmxsakgg3jMdBRrnWM1NaaquCYqW1qZJ90R2fRQMCkfZ7
	ASqGIdH0wAE9iKq5w=
X-Google-Smtp-Source: AGHT+IGNpCqiz7TPzWCbt9/AmNXXOBYfhN0gHSeI/H2uNi+8T0qW2fZHA/ppMSHGKcSUDizFe+92aA==
X-Received: by 2002:a17:902:c942:b0:264:a34c:c6d with SMTP id d9443c01a7336-290ca121a65mr193635025ad.37.1761038985547;
        Tue, 21 Oct 2025 02:29:45 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc83esm104497195ad.38.2025.10.21.02.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:29:45 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH net-next v7 2/2] selftests: tls: add tls record_size_limit test
Date: Tue, 21 Oct 2025 19:29:18 +1000
Message-ID: <20251021092917.386645-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021092917.386645-2-wilfred.opensource@gmail.com>
References: <20251021092917.386645-2-wilfred.opensource@gmail.com>
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
V6 -> V7:
 - Added a TLS 1.3 test case
---
 tools/testing/selftests/net/tls.c | 192 ++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 5c6d8215021c..d256668b35bf 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2856,6 +2856,198 @@ TEST_F(tls_err, oob_pressure)
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
+TEST(tls_12_tx_max_payload_len)
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
+TEST(tls_13_tx_max_payload_len)
+{
+	struct tls_crypto_info_keys tls13;
+	int cfd, ret, fd, overhead;
+	size_t total_plaintext_rx = 0;
+	__u8 tx[1024], rx[2000];
+	__u16 limit = 63;
+	__u16 opt = 0;
+	unsigned int optlen = sizeof(opt);
+	bool notls;
+
+	tls_crypto_info_init(TLS_1_3_VERSION, TLS_CIPHER_AES_CCM_128,
+			     &tls13, 0);
+
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+
+	if (notls)
+		exit(KSFT_SKIP);
+
+	/* Don't install keys on fd, we'll parse raw records */
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX, &tls13, tls13.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &limit,
+			 sizeof(limit));
+	ASSERT_EQ(ret, 0);
+
+	ret = getsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &opt, &optlen);
+	EXPECT_EQ(ret, 0);
+	/* TLS 1.3: plaintext length should contain the ContentType byte */
+	EXPECT_EQ(limit + 1, opt);
+	EXPECT_EQ(optlen, sizeof(limit));
+
+	memset(tx, 0, sizeof(tx));
+	ASSERT_EQ(send(cfd, tx, sizeof(tx), 0), sizeof(tx));
+	close(cfd);
+
+	ret = recv(fd, rx, sizeof(rx), 0);
+
+	/*
+	 * 16B tag + 1B ContentType -- record header (5B) is not counted but
+	 * we'll need it to walk the record stream
+	 */
+	overhead = 16 + 1;
+	total_plaintext_rx = parse_tls_records(_metadata, rx, ret, overhead,
+					       opt);
+
+	ASSERT_EQ(total_plaintext_rx, sizeof(tx));
+	close(fd);
+}
+
+TEST(tls_12_tx_max_payload_len_open_rec)
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


