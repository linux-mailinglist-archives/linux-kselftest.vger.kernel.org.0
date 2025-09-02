Return-Path: <linux-kselftest+bounces-40652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D648B40F16
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A783BAF6C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 21:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D8D35A288;
	Tue,  2 Sep 2025 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwGa4oPI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C182E7652;
	Tue,  2 Sep 2025 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847515; cv=none; b=HPn1jFvvdDfkSB/p6m6XbZ9hosl/k4ma1hGAijT3nv6ejJCU1kwUc8eX51ToGS2CLDFWpoQpz68iL+J9dgBMzcI0aS9URXIi1xEstw5+OhL26QmfKDC6pU5XJT/ihoi8aXBPP8KFcxQI7GikK5igG+gkeVObz0UcDaosHXs9nVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847515; c=relaxed/simple;
	bh=RMPz+kei/l12vMhnBcZU59rKFNLt7AmYvJ+NTIta3uE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rXQDBgEX6v6uG8sB1NSQyUOM3MqQRc5CMbGLxMxlSkd6yG6yv2zEXtU6S8MVlXAUoj3A1W7mUWMnQlVwamANLP/KDBquHfBcaejsou399kDpBdUai0JP1WxqzmOgvxWxnDvzchEda1yCVk6Am1tgw4/9gBRJDoep51WyTyh71XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwGa4oPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16CFC4CEED;
	Tue,  2 Sep 2025 21:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756847515;
	bh=RMPz+kei/l12vMhnBcZU59rKFNLt7AmYvJ+NTIta3uE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TwGa4oPIkHPlzOD1D8xF7kS5N215+V5mQX0aSPnhXN41/SWZoe2JsiTqoT9WK0ttf
	 jHtuRFa2fiLO6XxaU167JDDwgwUz15JJ0FW2HGbHewA4sR8EE69pkEpQWJJrioG/xB
	 s3sC8vlwrvqnxRSCJWWA/+N4o+93b/Px45pT+KGtIkZFp/ZztsOgrolQVElnv2pJiW
	 7lxSzWqzVJHFiIE2J1lgYwdijeO/A61newp2LY9lNJxJolizgNTD+Y1BExXLCMxjdT
	 ghuUL/vSLTn4ffOhmPAPo4tTNOdj7aKvqDWiQKURt8e5C56q1oGd2TVj/ub9uWxk/Q
	 n7SVGfLLherzQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Sep 2025 23:11:33 +0200
Subject: [PATCH net-next v2 1/4] mptcp: use HMAC-SHA256 library instead of
 open-coded HMAC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-net-next-mptcp-misc-feat-6-18-v2-1-fa02bb3188b1@kernel.org>
References: <20250902-net-next-mptcp-misc-feat-6-18-v2-0-fa02bb3188b1@kernel.org>
In-Reply-To: <20250902-net-next-mptcp-misc-feat-6-18-v2-0-fa02bb3188b1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Eric Biggers <ebiggers@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2283; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6oQ+I5kcPXTiXDL88deD5lugpAEBwivyOnumWZNKRys=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK2x058VK58Ov/ym5i5HfdmePzj5XjWETXn7uS6uamu1
 f8sVDf+7yhlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjI4sOMDHMOMt57ePLzn/mO
 S0Mu6Ll+tEx1MWTiW2LNwGZVybLySTAjQ3eWD9uh1gcdD/b9ZbaUsc/9eeJpu8ay/abrHt86bRa
 cwQkA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Eric Biggers <ebiggers@kernel.org>

Now that there are easy-to-use HMAC-SHA256 library functions, use these
in net/mptcp/crypto.c instead of open-coding the HMAC algorithm.

Remove the WARN_ON_ONCE() for messages longer than SHA256_DIGEST_SIZE.
The new implementation handles all message lengths correctly.

The mptcp-crypto KUnit test still passes after this change.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/crypto.c | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
index b08ba959ac4fd485bb833043ff58d4c8bac8a37a..31948e18d97da7ee0ee2ae9e4f7c9ca0e3b330a7 100644
--- a/net/mptcp/crypto.c
+++ b/net/mptcp/crypto.c
@@ -22,7 +22,6 @@
 
 #include <linux/kernel.h>
 #include <crypto/sha2.h>
-#include <linux/unaligned.h>
 
 #include "protocol.h"
 
@@ -43,39 +42,9 @@ void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *idsn)
 
 void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u8 *msg, int len, void *hmac)
 {
-	u8 input[SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE];
-	u8 key1be[8];
-	u8 key2be[8];
-	int i;
+	__be64 key[2] = { cpu_to_be64(key1), cpu_to_be64(key2) };
 
-	if (WARN_ON_ONCE(len > SHA256_DIGEST_SIZE))
-		len = SHA256_DIGEST_SIZE;
-
-	put_unaligned_be64(key1, key1be);
-	put_unaligned_be64(key2, key2be);
-
-	/* Generate key xored with ipad */
-	memset(input, 0x36, SHA256_BLOCK_SIZE);
-	for (i = 0; i < 8; i++)
-		input[i] ^= key1be[i];
-	for (i = 0; i < 8; i++)
-		input[i + 8] ^= key2be[i];
-
-	memcpy(&input[SHA256_BLOCK_SIZE], msg, len);
-
-	/* emit sha256(K1 || msg) on the second input block, so we can
-	 * reuse 'input' for the last hashing
-	 */
-	sha256(input, SHA256_BLOCK_SIZE + len, &input[SHA256_BLOCK_SIZE]);
-
-	/* Prepare second part of hmac */
-	memset(input, 0x5C, SHA256_BLOCK_SIZE);
-	for (i = 0; i < 8; i++)
-		input[i] ^= key1be[i];
-	for (i = 0; i < 8; i++)
-		input[i + 8] ^= key2be[i];
-
-	sha256(input, SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE, hmac);
+	hmac_sha256_usingrawkey((const u8 *)key, sizeof(key), msg, len, hmac);
 }
 
 #if IS_MODULE(CONFIG_MPTCP_KUNIT_TEST)

-- 
2.51.0


