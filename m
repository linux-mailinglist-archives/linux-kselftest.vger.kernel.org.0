Return-Path: <linux-kselftest+bounces-3738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F41841AB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 04:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A744F1F26253
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 03:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAD7381D4;
	Tue, 30 Jan 2024 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="QbuIqwei"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC037708
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jan 2024 03:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706586726; cv=none; b=ompKrnGG05bJCJueVFPT832wEw+6gYSY3bZsaAaUeldc/7Muw43U2xJQzAGrfyEDnJRLHRDedApQq4SdMk+yS0+CHJGcJJ+wUwQlmBkzzr0SjS9fAjAioNMAJOMODn1RVbjbPRT5nNHxsXGkEikOizPGQkfenXPOj/DCCcSpIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706586726; c=relaxed/simple;
	bh=QZKaym8nFiRV9Re87RifRE/NGc2FIS+/ruqdmA8E/9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBbXTukEFiC4g5o+del0M9UNZuHsMS/fEDHRvg3W+aF1L4v4LeKYYBg6tyerrgCql5w/+KeiISAnf5w1oZE/mOPUewK1mXaexIB9V5J9g9rDDKAYfqT2G5v7HzZmHbXyMjioVuyQSY7VS6uzm/Ix0m34aMI95xk1X09Du9o3jVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=QbuIqwei; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33929364bdaso2440289f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 19:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1706586722; x=1707191522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfduzUl6xeBtvtYJDyMTI1tDFj6QysY3Ss5eP9VLuq4=;
        b=QbuIqweiBvAxHH3buU1sieBkx34MzaaUZSKSUo0wR8eV8fSpSlvXyn1Te8sFcVzQIF
         lRW9EzuEJoRJmddAae+Ikv2tuFwcIIezKZ/LhZ23Ct6eHwOfuY84nnnWT4k73x3MTF2q
         8Vxnx+HpvGg+kLC9PJBrAGZFJ8lbYVeDVDe2rbtNgWedyfZb0n+F05Z66TAskmfxGBa8
         CMttysAiEevRvbdH2iJvyoQPKKAsZ6gaccVdGMJvfvSOIIsFPLWMHOcD3YdY0BBc1on8
         XuwkN3Mj6eDhcAjRyI5voAjJ7BJmSxaVyOif5Sj53Hc7Ki25dHwBNPO09skd1fj3iXce
         1tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706586722; x=1707191522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfduzUl6xeBtvtYJDyMTI1tDFj6QysY3Ss5eP9VLuq4=;
        b=KWIfnkeaMMFjWfsfQuI2Jc3H4ZTL2dciZzMccSZi4KEmJN+tArFk9flVw+FlzfWXbq
         yh+ovo4SgMsRxpPIoTX+LiK8XMH8Mp6txxhTsjisxHhjkkcIf1nfGE54nBry1VegunAt
         ZLxeywdWBzXk+3jpOcsRfQYf+d8BxVHFvcNfUEM9zH5Ys9YAfdzKUNYdQtBZs6mMekod
         DCK+GBogex6PhLhVuV3QxCWB8W9r6QXEuGMO7PRg/5J2rC/DmfNKrOIyzieHwce6QiKA
         c3xzfyUUOgpco3p1XoXKXZWnHrngGbIQiY2aBT79hifB2c7jlHJm5Mtel0vm8UhbOyYI
         JocA==
X-Gm-Message-State: AOJu0YxXtEmwDGzvrYR7UYcKYBqzE/+q8JMtNiWHYe48mfxYgmT1eSy5
	EuRToKIuhciAbe7uyrPdVH44VzWbchcO9uvhY+BSDS0pHmTkgHeidOOc/jE4mA==
X-Google-Smtp-Source: AGHT+IEWkeLhdP7cYXdSo5d/XhFN67shLx8ETOlkaxq4ILoIYMlWFY5uN73f1sNTJ96Wm61lIXuUkQ==
X-Received: by 2002:adf:ea02:0:b0:337:2940:ab7b with SMTP id q2-20020adfea02000000b003372940ab7bmr5253230wrm.1.1706586722579;
        Mon, 29 Jan 2024 19:52:02 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id ay13-20020a5d6f0d000000b00337d6aa3912sm9513207wrb.10.2024.01.29.19.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 19:52:01 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Mohammad Nassiri <mnassiri@ciena.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] selftests/net: Rectify key counters checks
Date: Tue, 30 Jan 2024 03:51:53 +0000
Message-ID: <20240130-tcp-ao-test-key-mgmt-v2-2-d190430a6c60@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
References: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706586711; l=5702; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=QZKaym8nFiRV9Re87RifRE/NGc2FIS+/ruqdmA8E/9Y=; b=A7UG9vGwH7vWayZbiEoyzrefAGgWlQNbFZPFq30bO+ymDMD8J1nOVvUsafhss4d6gzAdQWgTV GEn70c1m+qYC2y5aqfFVrTcAjYJgStAkrkFm1TFbfmK87csLr/nJJHg
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

As the names of (struct test_key) members didn't reflect whether the key
was used for TX or RX, the verification for the counters was done
incorrectly for asymmetrical selftests.

Rename these with _tx appendix and fix checks in verify_counters().
While at it, as the checks are now correct, introduce skip_counters_checks,
which is intended for tests where it's expected that a key that was set
with setsockopt(sk, IPPROTO_TCP, TCP_AO_INFO, ...) might had no chance
of getting used on the wire.

Fixes the following failures, exposed by the previous commit:
> not ok 51 server: Check current != rnext keys set before connect(): Counter pkt_good was expected to increase 0 => 0 for key 132:5
> not ok 52 server: Check current != rnext keys set before connect(): Counter pkt_good was not expected to increase 0 => 21 for key 137:10
>
> not ok 63 server: Check current flapping back on peer's RnextKey request: Counter pkt_good was expected to increase 0 => 0 for key 132:5
> not ok 64 server: Check current flapping back on peer's RnextKey request: Counter pkt_good was not expected to increase 0 => 40 for key 137:10

Cc: Mohammad Nassiri <mnassiri@ciena.com>
Fixes: 3c3ead555648 ("selftests/net: Add TCP-AO key-management test")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 .../testing/selftests/net/tcp_ao/key-management.c  | 44 ++++++++++++----------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/key-management.c b/tools/testing/selftests/net/tcp_ao/key-management.c
index f6a9395e3cd7..24e62120b792 100644
--- a/tools/testing/selftests/net/tcp_ao/key-management.c
+++ b/tools/testing/selftests/net/tcp_ao/key-management.c
@@ -417,9 +417,9 @@ struct test_key {
 		matches_vrf		: 1,
 		is_current		: 1,
 		is_rnext		: 1,
-		used_on_handshake	: 1,
-		used_after_accept	: 1,
-		used_on_client		: 1;
+		used_on_server_tx	: 1,
+		used_on_client_tx	: 1,
+		skip_counters_checks	: 1;
 };
 
 struct key_collection {
@@ -609,16 +609,14 @@ static int key_collection_socket(bool server, unsigned int port)
 				addr = &this_ip_dest;
 			sndid = key->client_keyid;
 			rcvid = key->server_keyid;
-			set_current = key->is_current;
-			set_rnext = key->is_rnext;
+			key->used_on_client_tx = set_current = key->is_current;
+			key->used_on_server_tx = set_rnext = key->is_rnext;
 		}
 
 		if (test_add_key_cr(sk, key->password, key->len,
 				    *addr, vrf, sndid, rcvid, key->maclen,
 				    key->alg, set_current, set_rnext))
 			test_key_error("setsockopt(TCP_AO_ADD_KEY)", key);
-		if (set_current || set_rnext)
-			key->used_on_handshake = 1;
 #ifdef DEBUG
 		test_print("%s [%u/%u] key: { %s, %u:%u, %u, %u:%u:%u:%u (%u)}",
 			   server ? "server" : "client", i, collection.nr_keys,
@@ -640,22 +638,22 @@ static void verify_counters(const char *tst_name, bool is_listen_sk, bool server
 	for (i = 0; i < collection.nr_keys; i++) {
 		struct test_key *key = &collection.keys[i];
 		uint8_t sndid, rcvid;
-		bool was_used;
+		bool rx_cnt_expected;
 
+		if (key->skip_counters_checks)
+			continue;
 		if (server) {
 			sndid = key->server_keyid;
 			rcvid = key->client_keyid;
-			if (is_listen_sk)
-				was_used = key->used_on_handshake;
-			else
-				was_used = key->used_after_accept;
+			rx_cnt_expected = key->used_on_client_tx;
 		} else {
 			sndid = key->client_keyid;
 			rcvid = key->server_keyid;
-			was_used = key->used_on_client;
+			rx_cnt_expected = key->used_on_server_tx;
 		}
 
-		test_tcp_ao_key_counters_cmp(tst_name, a, b, was_used,
+		test_tcp_ao_key_counters_cmp(tst_name, a, b,
+					     rx_cnt_expected ? TEST_CNT_KEY_GOOD : 0,
 					     sndid, rcvid);
 	}
 	test_tcp_ao_counters_free(a);
@@ -916,9 +914,8 @@ static int run_client(const char *tst_name, unsigned int port,
 		current_index = nr_keys - 1;
 	if (rnext_index < 0)
 		rnext_index = nr_keys - 1;
-	collection.keys[current_index].used_on_handshake = 1;
-	collection.keys[rnext_index].used_after_accept = 1;
-	collection.keys[rnext_index].used_on_client = 1;
+	collection.keys[current_index].used_on_client_tx = 1;
+	collection.keys[rnext_index].used_on_server_tx = 1;
 
 	synchronize_threads(); /* 3: accepted => send data */
 	if (test_client_verify(sk, msg_sz, msg_nr, TEST_TIMEOUT_SEC)) {
@@ -1059,7 +1056,16 @@ static void check_current_back(const char *tst_name, unsigned int port,
 		test_error("Can't change the current key");
 	if (test_client_verify(sk, msg_len, nr_packets, TEST_TIMEOUT_SEC))
 		test_fail("verify failed");
-	collection.keys[rotate_to_index].used_after_accept = 1;
+	/* There is a race here: between setting the current_key with
+	 * setsockopt(TCP_AO_INFO) and starting to send some data - there
+	 * might have been a segment received with the desired
+	 * RNext_key set. In turn that would mean that the first outgoing
+	 * segment will have the desired current_key (flipped back).
+	 * Which is what the user/test wants. As it's racy, skip checking
+	 * the counters, yet check what are the resulting current/rnext
+	 * keys on both sides.
+	 */
+	collection.keys[rotate_to_index].skip_counters_checks = 1;
 
 	end_client(tst_name, sk, nr_keys, current_index, rnext_index, &tmp);
 }
@@ -1089,7 +1095,7 @@ static void roll_over_keys(const char *tst_name, unsigned int port,
 		}
 		verify_current_rnext(tst_name, sk, -1,
 				     collection.keys[i].server_keyid);
-		collection.keys[i].used_on_client = 1;
+		collection.keys[i].used_on_server_tx = 1;
 		synchronize_threads(); /* verify current/rnext */
 	}
 	end_client(tst_name, sk, nr_keys, current_index, rnext_index, &tmp);

-- 
2.43.0


