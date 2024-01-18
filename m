Return-Path: <linux-kselftest+bounces-3184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710F183118F
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 03:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48572887AE
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jan 2024 02:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AC79476;
	Thu, 18 Jan 2024 02:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="RnaUryu9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07E4749D
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Jan 2024 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705546310; cv=none; b=PyMTlDFQZ/oda5le8g3byWwQZrAni48i+uJFJ9sCgnee5yP0Erxbh0Bta0oA85pb+eK1cFOx6gVMIc3NlWFMximFFv2IPNdtbqILr59hQLxzLRJZi6SK7U1yMAwPEVjFqCDOeVJzyfh9Kf1gTflJVbrBVTf0tATWBx/qy+Q5t6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705546310; c=relaxed/simple;
	bh=QZKaym8nFiRV9Re87RifRE/NGc2FIS+/ruqdmA8E/9Y=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding; b=o7bOr8yp2NVFq5arFQDd2k+J21kcjcq0zDxpvgmFybNF6A+fyANHUytRiR3ouQiYfaQpgPvTGT6NChCKK79Y/5WHmz5hf00FQwkUdmln/M3pprZaxZwgRaQsx2MbMogecx6vUkatJUXJGZ3Ib3XRvU64MPKF1WWyI8KC7OMoUp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=RnaUryu9; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-337c40fde20so1099575f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 18:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1705546307; x=1706151107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfduzUl6xeBtvtYJDyMTI1tDFj6QysY3Ss5eP9VLuq4=;
        b=RnaUryu9WJX+yexQ0bSf7o1a5cJbb3V+Ka1nrWiWSGu9to5m9tqaxoajm4yi/Hayzg
         uEKUUtd/WEOB3AyKTn6JL43sj6UY9yOgw6CGI6beTQPSMCIEZ0Kb+Tnn+DC4W1VYNxpg
         ULjYwcdo89pKQCzyxvtbv3dkV0/DgH6O684v/qNIc3swsqYe4gbaOiwfGKX5ITxmuY2V
         eJyKUjpRvP12EOXvzeABWNViAmFUHVFS9ETpq7SEQELuOlCznwHysZZ9IKWufhjuoEgp
         ippkf5jn4tITxqcFer/RRUvThMWHq4PzuyeUXFFN6VubjXtk2chJf0GaP0CV0UnMPstW
         mOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705546307; x=1706151107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfduzUl6xeBtvtYJDyMTI1tDFj6QysY3Ss5eP9VLuq4=;
        b=VaxB9SUXAJ0cPD0w5JRJwI2/OyeN2CPnqTvb0pZAnv/3KJaWXlGB+judwdFPYhi/eb
         VCj4MRFoRXLaYGb3rgQ4lP+2IL7M8pz6Ca7AoG/pqZkl1koDgsGZGWE3XLaxpKYrPoPt
         J8jrT7+IAkRR/uErS5xCHeu19tXEDiED5o3zLN3mEcA8RANCQ/XdB/+Z2cyaf0Aa5FLT
         lSbDVhE3v5MZrZ1FtdhDPbqVQnLwYPnc8qfIuYHZLI3KL0ANMdnz4JT0kQck0wf2BnLm
         Fot3xAyxGOHaSsCil/Mg+DuMgey+lII6+YeP8X58uASFbE2A4Qkd4JW7vhsI3EFu2Vld
         RQ6A==
X-Gm-Message-State: AOJu0YyrpNN0K3Rzfsp8++oRF5kJOjS4P9RUuXstKXe1tQen4p2iK8EF
	oFo2536BCfxkeh1Br223rYqKoo7nVFhcEOBCM2DKU1/NUKet9tyrjuAnoq2qOg==
X-Google-Smtp-Source: AGHT+IGm/R0MFqUoxs0sZnObB5pC5VwXCcB30vH4BNIs+FZOGPs6Y6wipK+yotRTeskn8mg4aUbhtA==
X-Received: by 2002:adf:cd85:0:b0:337:be02:b9a4 with SMTP id q5-20020adfcd85000000b00337be02b9a4mr74557wrj.106.1705546307343;
        Wed, 17 Jan 2024 18:51:47 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d440f000000b0033664ffaf5dsm2868219wrq.37.2024.01.17.18.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 18:51:46 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Mohammad Nassiri <mnassiri@ciena.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] selftests/net: Rectify key counters checks
Date: Thu, 18 Jan 2024 02:51:35 +0000
Message-ID: <20240118-tcp-ao-test-key-mgmt-v1-2-3583ca147113@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705546294; l=5702; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=QZKaym8nFiRV9Re87RifRE/NGc2FIS+/ruqdmA8E/9Y=; b=/L7fiuJ8pvO/Z7wlLHp2COBc8azS99uMQ8onBu9cjtNPemIMx1K/wiGBQ+XXKz4wm4HJrkVUg gzvxJJ/nJ8kDBcItyklbYDH+MU/L4UN18UKMbWpKDv8q2AcgKvJwmOo
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


