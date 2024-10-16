Return-Path: <linux-kselftest+bounces-19817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D94C9A00FE
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 07:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720861C221C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 05:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2A218C331;
	Wed, 16 Oct 2024 05:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOiVFytY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4E25221;
	Wed, 16 Oct 2024 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729058348; cv=none; b=VpMAos8wPsKZ+MVXrZ9voq/LSN2nzpxwA0+YGMfcom6C2MpIY0CQcEr5DWwjfNMyI+cvR3gorPnTBrprKsA0kS1oHCRZ6/KEJa1XpfpIDy5Hnop6VSL3HP+Ce3xDVEMy5FsCtAdrcQUtYvukrXNwO2gtcn0yNgdQlN29fPkGBT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729058348; c=relaxed/simple;
	bh=0IOA15zRoe6/OrmFHBMCe+SQXioxlhZfzgGZUOT/ub0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5MYvFJcp0duirkD8lc/CcrAfVTlYzkfsCtv5nOUnW5E8MKgfm54169YYFClUf+yXKsCsF7txN5mFKB6JTMPSjO/7B07JYzj9BfVk4GLjac9jkFLLnc8Mj+s2QAefhXBx4SW2ApKIg5kzef6bBSfMb2EV/Uq/JqmalBgZ1ymCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOiVFytY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso44973435ad.2;
        Tue, 15 Oct 2024 22:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729058346; x=1729663146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPuDG0q3hSSZ6Clb715o6VUtr6SxMF93McoY1IuChbw=;
        b=MOiVFytYM7JTAhGQtN/Rk8aFKIKyhB7aVeNRAYiLgFhAmJxjZOeJi8stbAo13A4RUk
         8yFDi2gAMTIhwax30BRcokFWlaXakZMNf/TMomW8I9v49BTgPi3dJydgNZAOAIwEBqvz
         Ra0y40l5KteeETpAL+FCiJxKQSCvq+QX1dqTz0mKDMPpOpCjWYxY7DuYmOc7ux0++ghN
         fBM8+UCa6KI+7vkhI0ICDkeyuIauRPhiSiEW0PfRlJpnV/Bul/2rw0EE0gcEKHtwk1Nz
         R5U1WgYaxczEa4vb75coXRhozqcttHC4p/YOMdTRO8OpnycRnXgSz108A5mU3kmQB2tX
         ruXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729058346; x=1729663146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPuDG0q3hSSZ6Clb715o6VUtr6SxMF93McoY1IuChbw=;
        b=aUq0M7V1Z4KTI51y/UcWuQJ69pdCU8b4Kx08Hc+NWrEd3kNnFVIL/CW4VhxMIe1Z6c
         hkA4zfSJdM26oIoUO6qQQlfWM55wmfeg1MKvIiGmIKhSfaJXeLWq0pirfLzJjQ64pM+H
         d0GBKMmF9sZnBMwXZQInNGOMDhZuS2escg8z+bh3acphYwcrvQ+8JfdIuznW5WwDPONR
         ogTgeCCeyfbPBXggqPppJQijrkXuwPx6FDS0SbQpw0Ji9YyZXSPtvsuh4mQCG7ru1fLx
         o3BB0228/pMUNcT4vhmw77Emi7BAlOpWPNKQuglrXRo1qIiIpvy5kiN6Ku68Owf6ukYL
         mZtg==
X-Forwarded-Encrypted: i=1; AJvYcCU5B8NPaFIbjy5hdu1Y9DDnJiYQTzLm+B6NkNnHhPrLirYkOLqCrAgbQYZi+qDmG7Fcfl32wENN@vger.kernel.org, AJvYcCUjVIeVVBPMOk/ChCth3bXRVRUaNbzgbH4gKISXOqcb533GWate/fUnGP6Cs5L3QyHD+khP/6oAPD14+48uicau@vger.kernel.org, AJvYcCWVF347rXzJQPl5xXJJnJ1ABjlRw0SLsbP5m8u/MoXFzxAunn/DaWXWunc2ZyQB75BgKrI7tN2e3q6SJ9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZI75m7O6PrLS/97qTJT3BnfkLEz+z+7ZwWWLmO8aiXVx7fS6C
	tGSZ1FSepm5Gfq7gHycAkHdQKikILAQXbgAi6ypXNXz/UAq8aXyJ
X-Google-Smtp-Source: AGHT+IEqCBmNjWKPdNxBClPBSkGETbCM0sxaz4ASty5qUt1SW57qn3/0UHvWnZRVzp0n10mPgwB9Rg==
X-Received: by 2002:a17:902:d486:b0:20d:27f8:d72a with SMTP id d9443c01a7336-20d27f8d757mr30672145ad.61.1729058345784;
        Tue, 15 Oct 2024 22:59:05 -0700 (PDT)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:3f72:2cc4:3779:e19d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d40esm21611265ad.73.2024.10.15.22.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 22:59:05 -0700 (PDT)
From: Leo Stone <leocstone@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	0x7f454c46@gmail.com
Cc: Leo Stone <leocstone@gmail.com>,
	rdunlap@infradead.org,
	mnassiri@ciena.com,
	jiapeng.chong@linux.alibaba.com,
	colin.i.king@gmail.com,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftest/tcp-ao: Add filter tests
Date: Tue, 15 Oct 2024 22:51:52 -0700
Message-ID: <20241016055823.21299-1-leocstone@gmail.com>
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
> # ok 118 filter keys: correct nkeys when in.nkeys < matched_keys

Signed-off-by: Leo Stone <leocstone@gmail.com>
---
Changes in v2:
- Changed 2 unnecessary test_error calls to test_fail
- Added another test to make sure getsockopt returns the right nkeys
  value when the input nkeys is smaller than the number of matching keys
- Removed the TODO that this patch addresses

Thank you for your feedback.
---
 .../selftests/net/tcp_ao/setsockopt-closed.c  | 180 +++++++++++++++++-
 1 file changed, 175 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
index 084db4ecdff6..4bfa76c28e4e 100644
--- a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
+++ b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
@@ -6,6 +6,8 @@
 
 static union tcp_addr tcp_md5_client;
 
+#define FILTER_TEST_NKEYS 16
+
 static int test_port = 7788;
 static void make_listen(int sk)
 {
@@ -813,23 +815,191 @@ static void duplicate_tests(void)
 	setsockopt_checked(sk, TCP_AO_ADD_KEY, &ao, EEXIST, "duplicate: SendID differs");
 }
 
+
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
+	struct tcp_ao_add test_ao[FILTER_TEST_NKEYS];
+	u8 rcvid = 100, sndid = 100;
+	const char *test_password = "Test password number ";
+	char test_password_scratch[64] = {};
+	int sk = socket(test_family, SOCK_STREAM, IPPROTO_TCP);
+
+	if (sk < 0)
+		test_error("socket()");
+
+	for (int i = 0; i < FILTER_TEST_NKEYS; i++) {
+		snprintf(test_password_scratch, 64, "%s %d", test_password, i);
+		test_prepare_key(&test_ao[i], DEFAULT_TEST_ALGO, this_ip_dest, false, false,
+				 DEFAULT_TEST_PREFIX, 0, sndid++, rcvid++, 0, 0,
+				 strlen(test_password_scratch), test_password_scratch);
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
+		if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &test_ao[randidx],
+			       sizeof(struct tcp_ao_add)))
+			test_error("setsockopt()");
+		memcpy(&test_ao[randidx], &test_ao[FILTER_TEST_NKEYS - 1 - i],
+				sizeof(struct tcp_ao_add));
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
+			if (memcmp(expected[i].key, actual[j].key, TCP_AO_MAXKEYLEN) == 0)
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
+	struct tcp_ao_getsockopt all_keys[FILTER_TEST_NKEYS] = {};
+	struct tcp_ao_getsockopt filtered_keys[FILTER_TEST_NKEYS] = {};
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
+	if (compare_mkts(expected, nexpected, filtered_keys, filtered_keys[0].nkeys)) {
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
+	memcpy(&filter.addr, &original_keys[f].addr, sizeof(original_keys[f].addr));
+	filter.prefix = original_keys[f].prefix;
+	filter_keys_checked(sk, &filter, &original_keys[f], 1, "by sndid, rcvid, address");
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
+	filter_keys_checked(sk, &filter, expected_keys, nmatches, "by sndid, rcvid");
+
+	sk = prepare_test_keys(original_keys);
+	filter.get_all = 1;
+	filter.nkeys = FILTER_TEST_NKEYS / 2;
+	len = sizeof(struct tcp_ao_getsockopt);
+	if (getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS, &filter, &len))
+		test_error("getsockopt");
+	if (filter.nkeys == FILTER_TEST_NKEYS)
+		test_ok("filter keys: correct nkeys when in.nkeys < matched_keys");
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


