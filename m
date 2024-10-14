Return-Path: <linux-kselftest+bounces-19675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E099D93D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 23:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272F91C21E50
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 21:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8B71D150D;
	Mon, 14 Oct 2024 21:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUx2Qzji"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C59626296;
	Mon, 14 Oct 2024 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941826; cv=none; b=fEDVg6J7BcC+VuRLA1fgvPb/HG64/WxdrTWdvxrhdfX4J5P3r1Q+3pLWyUCFkH6ySq6+UZjv1QjyGvhIxSFvTkwoPhfHpnw+nFqDkY7M2aSxS4q3hFjZiGuAsybQwrP37D40nUzD9KbjGu5ACobjEyayfV9HbXxrbB6pOXk3VNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941826; c=relaxed/simple;
	bh=HkOvPod5Po7IUxn9v8V3oIRI3nemGKR4kwPpRnttkkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NfAhSgPrSiRCc8usDtmLUiNE3B5QTLX0vufNXOd8uGruReSvlDmGg4TIu053xjzE24x27cdGZXys70rvz82b2d7smSL6tJ3016CTnx+tGcYCW8XIoPwZv/4Pth4B8a/GMEDIJJAGYpcrjy0LFPMl0DmbrS28u6rSXwlCwCw1hKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUx2Qzji; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso2958645a12.3;
        Mon, 14 Oct 2024 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728941825; x=1729546625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zyvt4hfWvi2xjwmIhjL6WdR6crEcwqI6hT3ogZy/zXA=;
        b=KUx2QzjifRk3xURQjPULl5/IOw0lkH972TVMvYQLYnwZQDyM3wCn9ubD++kXr3p8sU
         BK4gQMjar6HlJRI+I/qYabY62HF1qYhMwknoxVKM+sp/fs8Ul0ZqwgsrelJP9CpBdNO5
         gjG2R6DoRTHo7r4D5ofuVqLUSvW6JhytiOGTKc8LS41dowhpNZ7x1U5rNlnsOOhisF4c
         o/MkpkuJ3gOFLMgNc/cZpcRvc/CSQeIXrpWHLvDpSA3SD6vaOd6H22tJtVjCW3qP39v4
         3KTUP3zzmCB5/IoljrA9VuZvZWmJUGlxEywK7dHvFf0naojTex51Ere3RTx4RQd9rbSX
         SinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941825; x=1729546625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zyvt4hfWvi2xjwmIhjL6WdR6crEcwqI6hT3ogZy/zXA=;
        b=Ubmx7/Oft0Rf4IbAfL3w1eSDyswrZNL6uKBz10ZmorvSGnioSw6MFX8zwK0DJ+yAxO
         Yh8USdidf/zH9C8Ra0QWgfduk6K1PXALPLScC3V5NHkGvfYGYogeTM0U+Ky6BB+I4+s+
         rOkHpdNP424pJX8ZXmgFtX+wr8sk96ZPnsnKSwh4iPa2E9cTRpk7mypPtq/b5MNOB5xT
         Vrmm50J9w9Bqes8PRb7JG+5mN2eJvJeBW8TcveO62/tIygPnFYpGcBeIMnevkO3eeu1a
         voWtkEeLinVtxTgFd9ojXFcPkkLapQqaavUuD+3VdM/vC4KhwwN71OL9wutxDBWh+d/W
         hHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1/gYuibU0otiBpRhVe38fOf5AwFTDIiNM7k65plKDtRXWCbxLWJKV8ByzJlRdGKW0X1M7d8Ryh+tEaldBZHuK@vger.kernel.org, AJvYcCWs49AV4hAiFerU8koYUjpmMX9xeQbCEExxuF3hKFnFX58rJYsiyWU+eyf5C/1GH6+hx3BVgJfz@vger.kernel.org, AJvYcCXUYTZM2ykwUUnQrdhbx7B9dNTmPaGEiT5gldTx29YjUEGPJ2VGtwOkMi8YKN8kuITV4Z3WMLAk8iYeT8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjInwKqxFy5jNNKzuz6UWvkrjNPT3Dm/zN52o8Yxs8NiZ/lrnY
	bZItIjG9UgC6POZ/HRfqBlLBZwzCxdLJe0I97BVWn2I84loEodIlmT/sj5Q0
X-Google-Smtp-Source: AGHT+IEM+CbuOlw1EC7rK8P2ZtDy8fBKPdQFPRlLr9/5qTPTuxcE1fCVaryv0nfmmb8t+WCK5h8jRw==
X-Received: by 2002:a05:6a20:2d1f:b0:1d8:6c7a:2f2d with SMTP id adf61e73a8af0-1d8c96ba64bmr13184084637.47.1728941824561;
        Mon, 14 Oct 2024 14:37:04 -0700 (PDT)
Received: from tc.hsd1.or.comcast.net ([2601:1c2:c104:170:a15c:9f17:806b:220f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e5d1d399dsm3502110b3a.136.2024.10.14.14.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:37:04 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	anupnewsmail@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RFC PATCH] selftest/tcp-ao: Add filter tests 
Date: Mon, 14 Oct 2024 14:33:08 -0700
Message-ID: <20241014213313.15100-1-leocstone@gmail.com>
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
> # ok 115 filter keys: by sndid, rcvid
> # ok 116 filter keys: by is_current
> # ok 117 filter keys: by is_rnext

Signed-off-by: Leo Stone <leocstone@gmail.com>
---
This patch is meant to address the TODO in setsockopt-closed.c:
> /*
>  * TODO: check getsockopt(TCP_AO_GET_KEYS) with different filters
>  * returning proper nr & keys;
>  */

Is this a reasonable way to do these tests? If so, what cases should I
add?
---
 .../selftests/net/tcp_ao/setsockopt-closed.c  | 158 +++++++++++++++++-
 1 file changed, 157 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
index 084db4ecdff6..4c8aa06eef5a 100644
--- a/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
+++ b/tools/testing/selftests/net/tcp_ao/setsockopt-closed.c
@@ -6,6 +6,8 @@
 
 static union tcp_addr tcp_md5_client;
 
+#define FILTER_TEST_NKEYS 16
+
 static int test_port = 7788;
 static void make_listen(int sk)
 {
@@ -813,12 +815,166 @@ static void duplicate_tests(void)
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
+	if (filtered_keys[0].nkeys != nexpected)
+		test_error("wrong nr of keys, expected %u got %u", nexpected,
+			   filtered_keys[0].nkeys);
+	if (compare_mkts(expected, nexpected, filtered_keys, filtered_keys[0].nkeys))
+		test_error("got wrong keys back");
+	test_ok("filter keys: %s", tst);
+
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
 	/*
 	 * TODO: check getsockopt(TCP_AO_GET_KEYS) with different filters
@@ -830,6 +986,6 @@ static void *client_fn(void *arg)
 
 int main(int argc, char *argv[])
 {
-	test_init(121, client_fn, NULL);
+	test_init(125, client_fn, NULL);
 	return 0;
 }
-- 
2.43.0


