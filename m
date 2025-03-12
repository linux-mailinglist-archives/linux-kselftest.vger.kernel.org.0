Return-Path: <linux-kselftest+bounces-28806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DA2A5D8F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 10:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96E2189BEAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 09:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77387239570;
	Wed, 12 Mar 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqD8N1MG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFC238D5F;
	Wed, 12 Mar 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770688; cv=none; b=bsn0eTLAuO6XGaMHb9OKIgkLC2oSstNiemr/jRO7j32IjcBrYWQecg8wwoz5bp7DfDjwl73++7ATULHmT0uoUQs49hjc2PBFPR5XogPGAUaXiOV/SI6QPRxGaxgYKjbxagrWaB/x/kT6dUT36/u7A8tMAaUEb5zzqw0pQ/BVmwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770688; c=relaxed/simple;
	bh=jpuUeVA/yemFV46gMrUwUd85DWAUB/ssFEsQrOfPmyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sa+3AYBzuSj6NIHLQTzQqP00f6fKMcTxI0g+uFbP7dBXyAjWefqsvHh9cTqML2UBSMLlzD1mcJLqfhIIGX6BfdN52v3hn3hl/r5WRfTxIwwdGwi8bHXfqGqREcflfBgG+En6GP9pq6BPZ/Tq8qgusH26SehFMasFCvtlxfefLdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqD8N1MG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCD67C4CEF6;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741770687;
	bh=jpuUeVA/yemFV46gMrUwUd85DWAUB/ssFEsQrOfPmyA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XqD8N1MGNkxhxv0gOeWYWC8VMPI9pGZ0Obo/juXVoi4yj2V5ks51w9EI2oU9pLOsV
	 dmg/VTLjpmGVduYvid5eu34Dyi5EBQmP9TGS6Fjn4Kc1gBIaBZBitagJm1QOuTDSW3
	 4jceidXx+L5jnD2+9cDOLxaNFKI0aCQbsYEjO0slirMHG3lQJWcnxnNWAXtyt9T6vM
	 HDrSZ9lungvc97Z+3yx1dW2VtmtlRVYoJuvx8GKZ8QbzgAC5cJNIO4pABTOBz3/MOe
	 NhvtGOJHWnEbF1kUi7QWFeD2p6V4bbhnEVeeqqA2G+ZexqitzG1P1QZ+ahcH1THcvp
	 deu5RPd++CRbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42C7C28B2E;
	Wed, 12 Mar 2025 09:11:27 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Wed, 12 Mar 2025 09:10:59 +0000
Subject: [PATCH net 5/7] selftests/net: Print the testing side in
 unsigned-md5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-tcp-ao-selftests-polling-v1-5-72a642b855d5@gmail.com>
References: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
In-Reply-To: <20250312-tcp-ao-selftests-polling-v1-0-72a642b855d5@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741770685; l=6683;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=ydYQTERZSZOIrkX7tioZa86cOGyjJIFbeHHeiWz4Tmo=;
 b=IPZZEmEMa20TDSovfBWtyLFVuPCOBmtXl+M3ZLKJ+BLc+RTOEENsT/n2OgXcJgKYe+nRAjSAK
 APCw9H7viCJAqcFPXrTOCAqF08mGWXTHLUQxVwTGAlDbr1hVU7bf2Tl
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

As both client and server print the same test name on failure or pass,
add "[server]" so that it's more obvious from a log which side printed
"ok" or "not ok".

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/unsigned-md5.c | 44 +++++++++++------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
index 4cde2c9f7f49c9ae5a7e1bf73745ef77c7b4706a..a1467b64390adcb5904c02fcfc378a37e989a8bd 100644
--- a/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
+++ b/tools/testing/selftests/net/tcp_ao/unsigned-md5.c
@@ -157,80 +157,80 @@ static void *server_fn(void *arg)
 
 	server_add_routes();
 
-	try_accept("AO server (INADDR_ANY): AO client", port++, NULL, 0,
+	try_accept("[server] AO server (INADDR_ANY): AO client", port++, NULL, 0,
 		   &addr_any, 0, 0, 100, 100, 0, "TCPAOGood",
 		   TEST_CNT_GOOD, 0, 0);
-	try_accept("AO server (INADDR_ANY): MD5 client", port++, NULL, 0,
+	try_accept("[server] AO server (INADDR_ANY): MD5 client", port++, NULL, 0,
 		   &addr_any, 0, 0, 100, 100, 0, "TCPMD5Unexpected",
 		   TEST_CNT_NS_MD5_UNEXPECTED, 1, FAULT_TIMEOUT);
-	try_accept("AO server (INADDR_ANY): no sign client", port++, NULL, 0,
+	try_accept("[server] AO server (INADDR_ANY): no sign client", port++, NULL, 0,
 		   &addr_any, 0, 0, 100, 100, 0, "TCPAORequired",
 		   TEST_CNT_AO_REQUIRED, 0, FAULT_TIMEOUT);
-	try_accept("AO server (AO_REQUIRED): AO client", port++, NULL, 0,
+	try_accept("[server] AO server (AO_REQUIRED): AO client", port++, NULL, 0,
 		   &this_ip_dest, TEST_PREFIX, true,
 		   100, 100, 0, "TCPAOGood", TEST_CNT_GOOD, 0, 0);
-	try_accept("AO server (AO_REQUIRED): unsigned client", port++, NULL, 0,
+	try_accept("[server] AO server (AO_REQUIRED): unsigned client", port++, NULL, 0,
 		   &this_ip_dest, TEST_PREFIX, true,
 		   100, 100, 0, "TCPAORequired",
 		   TEST_CNT_AO_REQUIRED, 0, FAULT_TIMEOUT);
 
-	try_accept("MD5 server (INADDR_ANY): AO client", port++, &addr_any, 0,
+	try_accept("[server] MD5 server (INADDR_ANY): AO client", port++, &addr_any, 0,
 		   NULL, 0, 0, 0, 0, 0, "TCPAOKeyNotFound",
 		   TEST_CNT_NS_KEY_NOT_FOUND, 1, FAULT_TIMEOUT);
-	try_accept("MD5 server (INADDR_ANY): MD5 client", port++, &addr_any, 0,
+	try_accept("[server] MD5 server (INADDR_ANY): MD5 client", port++, &addr_any, 0,
 		   NULL, 0, 0, 0, 0, 0, NULL, 0, 1, 0);
-	try_accept("MD5 server (INADDR_ANY): no sign client", port++, &addr_any,
+	try_accept("[server] MD5 server (INADDR_ANY): no sign client", port++, &addr_any,
 		   0, NULL, 0, 0, 0, 0, 0, "TCPMD5NotFound",
 		   TEST_CNT_NS_MD5_NOT_FOUND, 1, FAULT_TIMEOUT);
 
-	try_accept("no sign server: AO client", port++, NULL, 0,
+	try_accept("[server] no sign server: AO client", port++, NULL, 0,
 		   NULL, 0, 0, 0, 0, 0, "TCPAOKeyNotFound",
 		   TEST_CNT_NS_KEY_NOT_FOUND, 0, FAULT_TIMEOUT);
-	try_accept("no sign server: MD5 client", port++, NULL, 0,
+	try_accept("[server] no sign server: MD5 client", port++, NULL, 0,
 		   NULL, 0, 0, 0, 0, 0, "TCPMD5Unexpected",
 		   TEST_CNT_NS_MD5_UNEXPECTED, 1, FAULT_TIMEOUT);
-	try_accept("no sign server: no sign client", port++, NULL, 0,
+	try_accept("[server] no sign server: no sign client", port++, NULL, 0,
 		   NULL, 0, 0, 0, 0, 0, "CurrEstab", 0, 0, 0);
 
-	try_accept("AO+MD5 server: AO client (matching)", port++,
+	try_accept("[server] AO+MD5 server: AO client (matching)", port++,
 		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
 		   100, 100, 0, "TCPAOGood", TEST_CNT_GOOD, 1, 0);
-	try_accept("AO+MD5 server: AO client (misconfig, matching MD5)", port++,
+	try_accept("[server] AO+MD5 server: AO client (misconfig, matching MD5)", port++,
 		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
 		   100, 100, 0, "TCPAOKeyNotFound", TEST_CNT_AO_KEY_NOT_FOUND,
 		   1, FAULT_TIMEOUT);
-	try_accept("AO+MD5 server: AO client (misconfig, non-matching)", port++,
+	try_accept("[server] AO+MD5 server: AO client (misconfig, non-matching)", port++,
 		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
 		   100, 100, 0, "TCPAOKeyNotFound", TEST_CNT_AO_KEY_NOT_FOUND,
 		   1, FAULT_TIMEOUT);
-	try_accept("AO+MD5 server: MD5 client (matching)", port++,
+	try_accept("[server] AO+MD5 server: MD5 client (matching)", port++,
 		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
 		   100, 100, 0, NULL, 0, 1, 0);
-	try_accept("AO+MD5 server: MD5 client (misconfig, matching AO)", port++,
+	try_accept("[server] AO+MD5 server: MD5 client (misconfig, matching AO)", port++,
 		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
 		   100, 100, 0, "TCPMD5Unexpected",
 		   TEST_CNT_NS_MD5_UNEXPECTED, 1, FAULT_TIMEOUT);
-	try_accept("AO+MD5 server: MD5 client (misconfig, non-matching)", port++,
+	try_accept("[server] AO+MD5 server: MD5 client (misconfig, non-matching)", port++,
 		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
 		   100, 100, 0, "TCPMD5Unexpected",
 		   TEST_CNT_NS_MD5_UNEXPECTED, 1, FAULT_TIMEOUT);
-	try_accept("AO+MD5 server: no sign client (unmatched)", port++,
+	try_accept("[server] AO+MD5 server: no sign client (unmatched)", port++,
 		   &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
 		   100, 100, 0, "CurrEstab", 0, 1, 0);
-	try_accept("AO+MD5 server: no sign client (misconfig, matching AO)",
+	try_accept("[server] AO+MD5 server: no sign client (misconfig, matching AO)",
 		   port++, &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
 		   100, 100, 0, "TCPAORequired",
 		   TEST_CNT_AO_REQUIRED, 1, FAULT_TIMEOUT);
-	try_accept("AO+MD5 server: no sign client (misconfig, matching MD5)",
+	try_accept("[server] AO+MD5 server: no sign client (misconfig, matching MD5)",
 		   port++, &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
 		   100, 100, 0, "TCPMD5NotFound",
 		   TEST_CNT_NS_MD5_NOT_FOUND, 1, FAULT_TIMEOUT);
 
 	/* Key rejected by the other side, failing short through skpair */
-	try_accept("AO+MD5 server: client with both [TCP-MD5] and TCP-AO keys",
+	try_accept("[server] AO+MD5 server: client with both [TCP-MD5] and TCP-AO keys",
 		   port++, &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
 		   100, 100, 0, NULL, 0, 1, FAULT_KEYREJECT);
-	try_accept("AO+MD5 server: client with both TCP-MD5 and [TCP-AO] keys",
+	try_accept("[server] AO+MD5 server: client with both TCP-MD5 and [TCP-AO] keys",
 		   port++, &this_ip_dest, TEST_PREFIX, &client2, TEST_PREFIX, 0,
 		   100, 100, 0, NULL, 0, 1, FAULT_KEYREJECT);
 

-- 
2.42.2



