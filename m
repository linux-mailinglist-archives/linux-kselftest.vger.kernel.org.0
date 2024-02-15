Return-Path: <linux-kselftest+bounces-4784-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48EE856967
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 17:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C711C24380
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C471350C6;
	Thu, 15 Feb 2024 16:18:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19454134CEB;
	Thu, 15 Feb 2024 16:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013887; cv=none; b=An2WBnhqtGrAsgJ/1sTrZ0cNxVaNiLoh9qroTfY8rcqadGRLaw0aq3/zML695Y72BHoyP1GuaOViJNrvp3n4QCBpPQXKuLq82gPHqg2/c+/fGobcUsdF4+n4LEK30v7n3LiV012Qn/0gID5VHEpBs+FtITEyHfTtwkk4xe2UASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013887; c=relaxed/simple;
	bh=wChbdqFjMfdXDHt8mFp256l9WS9RGwwOChUbYAyg1UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRQ0QPcmtFqDiUsgHynojr8kVs7BeKQ5qolaywBB1z8kFnOAsVNB/Enlxb1Yg+pFT2XEMqXkKeXZGmppEMh9v8YUyY2hnZsVQhUmTnFhhU6JHNH9VPvPPcTS5o+2QddiL5gKB9Sj4/k8LbjRGDrlRa6pjgI9S3ihjF8I0L3Z1FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id F26D91C000C;
	Thu, 15 Feb 2024 16:17:55 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Vakul Garg <vakul.garg@nxp.com>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net 3/5] tls: don't skip over different type records from the rx_list
Date: Thu, 15 Feb 2024 17:17:31 +0100
Message-ID: <f00c0c0afa080c60f016df1471158c1caf983c34.1708007371.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1708007371.git.sd@queasysnail.net>
References: <cover.1708007371.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: sd@queasysnail.net

If we queue 3 records:
 - record 1, type DATA
 - record 2, some other type
 - record 3, type DATA
and do a recv(PEEK), the rx_list will contain the first two records.

The next large recv will walk through the rx_list and copy data from
record 1, then stop because record 2 is a different type. Since we
haven't filled up our buffer, we will process the next available
record. It's also DATA, so we can merge it with the current read.

We shouldn't do that, since there was a record in between that we
ignored.

Add a flag to let process_rx_list inform tls_sw_recvmsg that it had
more data available.

Fixes: 692d7b5d1f91 ("tls: Fix recvmsg() to be able to peek across multiple records")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 43dd0d82b6ed..de96959336c4 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1772,7 +1772,8 @@ static int process_rx_list(struct tls_sw_context_rx *ctx,
 			   u8 *control,
 			   size_t skip,
 			   size_t len,
-			   bool is_peek)
+			   bool is_peek,
+			   bool *more)
 {
 	struct sk_buff *skb = skb_peek(&ctx->rx_list);
 	struct tls_msg *tlm;
@@ -1785,7 +1786,7 @@ static int process_rx_list(struct tls_sw_context_rx *ctx,
 
 		err = tls_record_content_type(msg, tlm, control);
 		if (err <= 0)
-			goto out;
+			goto more;
 
 		if (skip < rxm->full_len)
 			break;
@@ -1803,12 +1804,12 @@ static int process_rx_list(struct tls_sw_context_rx *ctx,
 
 		err = tls_record_content_type(msg, tlm, control);
 		if (err <= 0)
-			goto out;
+			goto more;
 
 		err = skb_copy_datagram_msg(skb, rxm->offset + skip,
 					    msg, chunk);
 		if (err < 0)
-			goto out;
+			goto more;
 
 		len = len - chunk;
 		copied = copied + chunk;
@@ -1844,6 +1845,10 @@ static int process_rx_list(struct tls_sw_context_rx *ctx,
 
 out:
 	return copied ? : err;
+more:
+	if (more)
+		*more = true;
+	goto out;
 }
 
 static bool
@@ -1947,6 +1952,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	int target, err;
 	bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
 	bool is_peek = flags & MSG_PEEK;
+	bool rx_more = false;
 	bool released = true;
 	bool bpf_strp_enabled;
 	bool zc_capable;
@@ -1966,12 +1972,12 @@ int tls_sw_recvmsg(struct sock *sk,
 		goto end;
 
 	/* Process pending decrypted records. It must be non-zero-copy */
-	err = process_rx_list(ctx, msg, &control, 0, len, is_peek);
+	err = process_rx_list(ctx, msg, &control, 0, len, is_peek, &rx_more);
 	if (err < 0)
 		goto end;
 
 	copied = err;
-	if (len <= copied || (copied && control != TLS_RECORD_TYPE_DATA))
+	if (len <= copied || (copied && control != TLS_RECORD_TYPE_DATA) || rx_more)
 		goto end;
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
@@ -2130,10 +2136,10 @@ int tls_sw_recvmsg(struct sock *sk,
 		/* Drain records from the rx_list & copy if required */
 		if (is_peek || is_kvec)
 			err = process_rx_list(ctx, msg, &control, copied,
-					      decrypted, is_peek);
+					      decrypted, is_peek, NULL);
 		else
 			err = process_rx_list(ctx, msg, &control, 0,
-					      async_copy_bytes, is_peek);
+					      async_copy_bytes, is_peek, NULL);
 	}
 
 	copied += decrypted;
-- 
2.43.0


