Return-Path: <linux-kselftest+bounces-40418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B1B3DEB6
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 11:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C79211749C5
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383BF30C354;
	Mon,  1 Sep 2025 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXipAA0Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0368730C342;
	Mon,  1 Sep 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719604; cv=none; b=PK0lNp9Z8ynyCH11vXlkYRb6PGR20aHOiyu1d9O6sM2WEFifZGfe2hiiTd420MC1qlSSXC8QeGyPtAakP2ADg+3ao5Sj/zfWsneVVXI/GLtOOeQ89X1TTBhKZLthmkKsBwzJeLG5jBJhja+qHK9hQMwiC3zeBxeRYxp+/2Uo974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719604; c=relaxed/simple;
	bh=CqNBy4qAhqOnrt+73tr37KOH8EL1eioRr8crEmdVuQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DMC3KH7jiGyTHqZRiC1NVh+VpnfU29S+dkof04wzySewwmxcNwtfElJVB+72taXsjqAd8Wq7M2K3BKBKeGiHVheZuglDd35UVFLidqyCSOvyBEwhiERpjp7Gqj1kfpEFMMpaVxjd02uoFhk7yTdO+weRlGcMMeoc/LeSvqsf5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXipAA0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902EFC4CEF4;
	Mon,  1 Sep 2025 09:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756719603;
	bh=CqNBy4qAhqOnrt+73tr37KOH8EL1eioRr8crEmdVuQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sXipAA0QCofcHNIb2Znq7ydPl5lTRqyowO6PNMVlVOT4Ux49+NIqV3UzjrelU45nn
	 GZtOLFXHqB9M4A9Ygwce9pgWBsPkl4s5f4Hz1o1DmUE2PaRcIaQxxTqFPdvNHhDl3R
	 rvA3U9IaFcEgCIED5P7FEL31V04UUXgl1hWQdQhpSJoDpD/+UyiIVaSxlKU3F/5KTa
	 TD1HR3IOXkgch+3s6lu9tBODW2Z2anhsIwhk9qG2oN9INyR2Cq2s7/2sbEbJ1sr3ht
	 ommNekT5GDcNGvbfupgO3wdnCWMcZbaAFaZB2GLJ8TbyXc0TqE2fHqm9cc4GI7tTPq
	 R1CEFaYnJSIAA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Sep 2025 11:39:10 +0200
Subject: [PATCH net-next 1/6] mptcp: use HMAC-SHA256 library instead of
 open-coded HMAC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-net-next-mptcp-misc-feat-6-18-v1-1-80ae80d2b903@kernel.org>
References: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
In-Reply-To: <20250901-net-next-mptcp-misc-feat-6-18-v1-0-80ae80d2b903@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Eric Biggers <ebiggers@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2283; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hw8hY2SZgWZHzkPlV37CbfZ5OCuLt+l36o5ACPxGzR8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK2Zj7l2P5UQvx6v75NXd86TWeuD7HbpMzvzksSOpXmL
 nlbT1+uo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCL6igx/OPdOzZXoMD76kfHS
 /d1bMuK+bfyQ5TBhm/J/MWe7/PTXJxj+CqhMcI/+qSzF3v9KYY7ZL9Plbp/zWrmin26/k5sr7+f
 OAQA=
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
2.50.1


