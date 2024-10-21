Return-Path: <linux-kselftest+bounces-20293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE599A7157
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 19:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABE3FB2149A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 17:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C551F1308;
	Mon, 21 Oct 2024 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMBeo5f1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298251E5707;
	Mon, 21 Oct 2024 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729532952; cv=none; b=gEJWfsDHMluYjXXbZmhBnORNXOI8zKDH3/3WUzE1Q7aA4XNeyG90jpsAiTkGCJ+wrRmrLef50nX/zDU1Mdm52zFDF4HE/hG7AKFubk3siPbpxjRJOm9TVYZvl2wEFRnAoTP05RC1CGZieGorvvPAFQHre3h/XfMDVjQEnkAmW2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729532952; c=relaxed/simple;
	bh=jfgbl9FYc/btQKcnfcZ/ghDPePhVRcB/ya1WfADseYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/h69lJNwPeTWiNYC2w2Cjoq/8CRlkRL1ZL0VVohBGdrJMKI8fdkKzdj9hb2zJPDeKR/3Z/fsUN5xc3t+8DzD70IP7Avb0D+1F1akRwOCjvkiXNUpqzApl0CQJN5J64VoRQV0E+KZ8WikuFRyljumudayg6I7Meb5QyeXQkvoBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HMBeo5f1; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-28896d9d9deso1955887fac.2;
        Mon, 21 Oct 2024 10:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729532949; x=1730137749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7MSnWEfT/8V1xH5VKXIG4UAeeTISuvyCvsx87ByJa9Y=;
        b=HMBeo5f1s9NpCXQ2gCiyE6dRwZoE0OOGaCIpr0t9XeETUZUXUMf9FbuGdamps4lkQM
         LjhlSFH55vRH/sBFBzwXajO/mEZYkxbnZyMylovS0kzWf+vYEZQxCjXHIhC7XyKZeOhu
         SoSzgREr49DTbCKOFf4QAmUJya/kheVzmMYP7ZIUv+suP2iRH5v5PYjAel31XaIspjMX
         tjpP42NSuo0CvkHv1eEYceQ7PWG8Q8lguPRjGpjvBprsCLH4TZsFJDTdM82cjjn8UzYu
         K81PEEjX719Q6OP2WjssJIpQbcQVa8LiP9brDyK2KBDy+0yTA4XYdZ67iisVbqRNgbuP
         JGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729532949; x=1730137749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7MSnWEfT/8V1xH5VKXIG4UAeeTISuvyCvsx87ByJa9Y=;
        b=QA/52d0drpJQn6zYKfZn4zsvDE2aF31NM7doo2uu770zMxcCDzfZZEkxoeB34pSvjL
         2TUzaaZyiGGU74/KJtADEn89QRdF7m8ZOGg4HpPUQ0z034MXVqC7SLC4sJYRbyuXvvTZ
         kCMHwF0kElOfR4nRF+iiMfJyAvZdG6oZd1UgT/mgxKMB/c83ZXz3iFV/rnoLiWnAlgUC
         FyI5nBaBJoGrhVN2m1h5y5b0AmAf2FCD0CyZtPDv8V0zvnzs+JUfGNkaElro7Jex9EPl
         TmG+ZJPDjSSy151+OTnRA4dgPJPMhSHMt3jbgblsp77Kvmi7TkQUd44JdygAj4c01VfB
         kcYA==
X-Forwarded-Encrypted: i=1; AJvYcCVdKS+cCRh0Ulv+cC8JpQeKL4i31gGEhVRX+XSkebklOTF+uYx5Vo4kUJcMc8eVWiShnLgU8rwGUq8d6s4=@vger.kernel.org, AJvYcCVrIYGWXBtsydHn+jbFJ2ToXLlRJ7d3oN1kjCQt2AKNKJsFTti7eGowu7HQQRgVYbe2WG0cbBdzUa/zd29TPFwG@vger.kernel.org, AJvYcCXomnaOJ7vowVfLddaLM1iNjbd5T5GW/EnlV+c4sv9X8TAeRLSoAgI2DvTQpBEokvkAGcHmuD02@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2J9c32jtXSGrnxEclKTA4KZAUxZnLLfk18CAcWFZrf9WUL+Ka
	aJjTA1j1GmkkH8TiOMbrOtYAjUYWq/fJG/Sscaldrazp7UdOWM5d
X-Google-Smtp-Source: AGHT+IGDmo7OKprBDuKH8SR9WI7/1qw9WgRZyHGazlTGm/cwhgPMrcRi4tD+xowmauF8SL9gzsIkwg==
X-Received: by 2002:a05:6870:968c:b0:287:d54a:fa6 with SMTP id 586e51a60fabf-28caae795cdmr921474fac.22.1729532948765;
        Mon, 21 Oct 2024 10:49:08 -0700 (PDT)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:9c61:f65c:7755:5ad3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13eafa7sm3264174b3a.177.2024.10.21.10.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 10:49:07 -0700 (PDT)
From: Leo Stone <leocstone@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	0x7f454c46@gmail.com,
	horms@kernel.org
Cc: Leo Stone <leocstone@gmail.com>,
	rdunlap@infradead.org,
	mnassiri@ciena.com,
	jiapeng.chong@linux.alibaba.com,
	colin.i.king@gmail.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] selftest/tcp-ao: Add filter tests
Date: Mon, 21 Oct 2024 10:46:44 -0700
Message-ID: <20241021174652.6949-1-leocstone@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that check if getsockopt(TCP_AO_GET_KEYS) returns the right
keys when using different filters.

Sample output:

> # ok 114 filter keys: by sndid, rcvid, address
> # ok 115 filter keys: by is_current
> # ok 116 filter keys: by is_rnext
> # ok 117 filter keys: by sndid, rcvid
> # ok 118 filter keys: correct nkeys when in.nkeys < matches

Acked-by: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Leo Stone <leocstone@gmail.com>
---
v3:
  - Ordered locals in reverse xmas tree order
  - Separated socket fd declaration from assignment
  - Broke lines longer than 80 columns
v2: https://lore.kernel.org/netdev/20241016055823.21299-1-leocstone@gmail.com/
  - Changed 2 unnecessary test_error calls to test_fail
  - Added another test to make sure getsockopt returns the right nkeys
  value when the input nkeys is smaller than the number of matching keys
  - Removed the TODO that this patch addresses
v1: https://lore.kernel.org/netdev/20241014213313.15100-1-leocstone@gmail.com/

Thanks to the reviewers for their time and feedback!
---
 .../selftests/net/tcp_ao/setsockopt-closed.c  | 186 +++++++++++++++++-
 1 file changed, 181 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
index 084db4ecdff6..0abb9807d742 100644
--- a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
+++ b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
@@ -6,6 +6,8 @@
 
 static union tcp_addr tcp_md5_client;
 
+#define FILTER_TEST_NKEYS 16
+
 static int test_port = 7788;
 static void make_listen(int sk)
 {
@@ -813,23 +815,197 @@ static void duplicate_tests(void)
 	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EEXIST, "duplicate: SendID differs");
 }
 
+static void fetch_all_keys(int sk, struct tcp_ao_getsockopt *keys)
+{
+	socklen_t optlen = sizeof(struct tcp_ao_getsockopt);
+
+	memset(keys, 0, sizeof(struct tcp_ao_getsockopt) * FILTER_TEST_NKEYS);
+	keys[0].get_all = 1;
+	keys[0].nkeys = FILTER_TEST_NKEYS;
+	if (getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS, &keys[0], &optlen))
+		test_error("getsockopt");
+}
+
+static int prepare_test_keys(struct tcp_ao_getsockopt *keys)
+{
+	const char *test_password = "Test password number ";
+	struct tcp_ao_add test_ao[FILTER_TEST_NKEYS];
+	char test_password_scratch[64] = {};
+	u8 rcvid = 100, sndid = 100;
+	int sk;
+
+	sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+	if (sk < 0)
+		test_error("socket()");
+
+	for (int i = 0; i < FILTER_TEST_NKEYS; i++) {
+		snprintf(test_password_scratch, 64, "%s %d", test_password, i);
+		test_prepare_key(&test_ao[i], DEFAULT_TEST_ALGO, this_ip_dest,
+			  false, false, DEFAULT_TEST_PREFIX, 0, sndid++,
+			  rcvid++, 0, 0, strlen(test_password_scratch),
+			  test_password_scratch);
+	}
+	test_ao[0].set_current = 1;
+	test_ao[1].set_rnext = 1;
+	/* One key with a different addr and overlapping sndid, rcvid */
+	tcp_addr_to_sockaddr_in(&test_ao[2].addr, &this_ip_addr, 0);
+	test_ao[2].sndid = 100;
+	test_ao[2].rcvid = 100;
+
+	/* Add keys in a random order */
+	for (int i = 0; i < FILTER_TEST_NKEYS; i++) {
+		int randidx = rand() % (FILTER_TEST_NKEYS - i);
+
+		if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY,
+			       &test_ao[randidx], sizeof(struct tcp_ao_add)))
+			test_error("setsockopt()");
+		memcpy(&test_ao[randidx], &test_ao[FILTER_TEST_NKEYS - 1 - i],
+		       sizeof(struct tcp_ao_add));
+	}
+
+	fetch_all_keys(sk, keys);
+
+	return sk;
+}
+
+/* Assumes passwords are unique */
+static int compare_mkts(struct tcp_ao_getsockopt *expected, int nexpected,
+			struct tcp_ao_getsockopt *actual, int nactual)
+{
+	int matches = 0;
+
+	for (int i = 0; i < nexpected; i++) {
+		for (int j = 0; j < nactual; j++) {
+			if (memcmp(expected[i].key, actual[j].key,
+				   TCP_AO_MAXKEYLEN) == 0)
+				matches++;
+		}
+	}
+	return nexpected - matches;
+}
+
+static void filter_keys_checked(int sk, struct tcp_ao_getsockopt *filter,
+				struct tcp_ao_getsockopt *expected,
+				unsigned int nexpected, const char *tst)
+{
+	struct tcp_ao_getsockopt filtered_keys[FILTER_TEST_NKEYS] = {};
+	struct tcp_ao_getsockopt all_keys[FILTER_TEST_NKEYS] = {};
+	socklen_t len = sizeof(struct tcp_ao_getsockopt);
+
+	fetch_all_keys(sk, all_keys);
+	memcpy(&filtered_keys[0], filter, sizeof(struct tcp_ao_getsockopt));
+	filtered_keys[0].nkeys = FILTER_TEST_NKEYS;
+	if (getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS, filtered_keys, &len))
+		test_error("getsockopt");
+	if (filtered_keys[0].nkeys != nexpected) {
+		test_fail("wrong nr of keys, expected %u got %u", nexpected,
+			  filtered_keys[0].nkeys);
+		goto out_close;
+	}
+	if (compare_mkts(expected, nexpected, filtered_keys,
+			 filtered_keys[0].nkeys)) {
+		test_fail("got wrong keys back");
+		goto out_close;
+	}
+	test_ok("filter keys: %s", tst);
+
+out_close:
+	close(sk);
+	memset(filter, 0, sizeof(struct tcp_ao_getsockopt));
+}
+
+static void filter_tests(void)
+{
+	struct tcp_ao_getsockopt original_keys[FILTER_TEST_NKEYS];
+	struct tcp_ao_getsockopt expected_keys[FILTER_TEST_NKEYS];
+	struct tcp_ao_getsockopt filter = {};
+	int sk, f, nmatches;
+	socklen_t len;
+
+	f = 2;
+	sk = prepare_test_keys(original_keys);
+	filter.rcvid = original_keys[f].rcvid;
+	filter.sndid = original_keys[f].sndid;
+	memcpy(&filter.addr, &original_keys[f].addr,
+	       sizeof(original_keys[f].addr));
+	filter.prefix = original_keys[f].prefix;
+	filter_keys_checked(sk, &filter, &original_keys[f], 1,
+			    "by sndid, rcvid, address");
+
+	f = -1;
+	sk = prepare_test_keys(original_keys);
+	for (int i = 0; i < original_keys[0].nkeys; i++) {
+		if (original_keys[i].is_current) {
+			f = i;
+			break;
+		}
+	}
+	if (f < 0)
+		test_error("No current key after adding one");
+	filter.is_current = 1;
+	filter_keys_checked(sk, &filter, &original_keys[f], 1, "by is_current");
+
+	f = -1;
+	sk = prepare_test_keys(original_keys);
+	for (int i = 0; i < original_keys[0].nkeys; i++) {
+		if (original_keys[i].is_rnext) {
+			f = i;
+			break;
+		}
+	}
+	if (f < 0)
+		test_error("No rnext key after adding one");
+	filter.is_rnext = 1;
+	filter_keys_checked(sk, &filter, &original_keys[f], 1, "by is_rnext");
+
+	f = -1;
+	nmatches = 0;
+	sk = prepare_test_keys(original_keys);
+	for (int i = 0; i < original_keys[0].nkeys; i++) {
+		if (original_keys[i].sndid == 100) {
+			f = i;
+			memcpy(&expected_keys[nmatches], &original_keys[i],
+			       sizeof(struct tcp_ao_getsockopt));
+			nmatches++;
+		}
+	}
+	if (f < 0)
+		test_error("No key for sndid 100");
+	if (nmatches != 2)
+		test_error("Should have 2 keys with sndid 100");
+	filter.rcvid = original_keys[f].rcvid;
+	filter.sndid = original_keys[f].sndid;
+	filter.addr.ss_family = test_family;
+	filter_keys_checked(sk, &filter, expected_keys, nmatches,
+			    "by sndid, rcvid");
+
+	sk = prepare_test_keys(original_keys);
+	filter.get_all = 1;
+	filter.nkeys = FILTER_TEST_NKEYS / 2;
+	len = sizeof(struct tcp_ao_getsockopt);
+	if (getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS, &filter, &len))
+		test_error("getsockopt");
+	if (filter.nkeys == FILTER_TEST_NKEYS)
+		test_ok("filter keys: correct nkeys when in.nkeys < matches");
+	else
+		test_fail("filter keys: wrong nkeys, expected %u got %u",
+			  FILTER_TEST_NKEYS, filter.nkeys);
+}
+
 static void *client_fn(void *arg)
 {
 	if (inet_pton(TEST_FAMILY, __TEST_CLIENT_IP(2), &tcp_md5_client) != 1)
 		test_error("Can't convert ip address");
 	extend_tests();
 	einval_tests();
+	filter_tests();
 	duplicate_tests();
-	/*
-	 * TODO: check getsockopt(TCP_AO_GET_KEYS) with different filters
-	 * returning proper nr & keys;
-	 */
 
 	return NULL;
 }
 
 int main(int argc, char *argv[])
 {
-	test_init(121, client_fn, NULL);
+	test_init(126, client_fn, NULL);
 	return 0;
 }
-- 
2.43.0


