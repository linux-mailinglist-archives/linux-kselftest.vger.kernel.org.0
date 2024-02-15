Return-Path: <linux-kselftest+bounces-4786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B9985696B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 17:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26F51F277A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D677134CD2;
	Thu, 15 Feb 2024 16:18:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E721350DE;
	Thu, 15 Feb 2024 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013892; cv=none; b=EMrtb/HhHXr95SJp/Rotr2yRXjKVYWi8njy8H1sgufUKcy0X+3iFE7fuIrzLWJI9s/FPlmhZlrwrGVeioxt/BMjdxMpBc60J3vYB0l59WNvnwX+OL6EuqyEnuhuojDj9yzBu5T8txXkLhG5njFnwDdY9DA+eW3lkRpD2SU3kCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013892; c=relaxed/simple;
	bh=njg8Gkf2RwI9/A2a2dwBTtScWpp1FQVywUSPTikLoJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwD28JLIv9v0mEGRG32IG2iB8IkpHJDGZUv32dZZ3orCJDQqsWEw1WUTIuDgCNUb5fw/7XXgiqGvDo2Po04scixU7pWUtAVQ1pXTEfR+yG94nUe4RvGlUTrIfuMzfu+JIeBnkfBwNE2yQs8bBoD2iVewzfcQK5zmyYhOJ6CF6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F35E1C000A;
	Thu, 15 Feb 2024 16:17:53 +0000 (UTC)
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
Subject: [PATCH net 1/5] tls: break out of main loop when PEEK gets a non-data record
Date: Thu, 15 Feb 2024 17:17:29 +0100
Message-ID: <3df2eef4fdae720c55e69472b5bea668772b45a2.1708007371.git.sd@queasysnail.net>
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

PEEK needs to leave decrypted records on the rx_list so that we can
receive them later on, so it jumps back into the async code that
queues the skb. Unfortunately that makes us skip the
TLS_RECORD_TYPE_DATA check at the bottom of the main loop, so if two
records of the same (non-DATA) type are queued, we end up merging
them.

Add the same record type check, and make it unlikely to not penalize
the async fastpath. Async decrypt only applies to data record, so this
check is only needed for PEEK.

process_rx_list also has similar issues.

Fixes: 692d7b5d1f91 ("tls: Fix recvmsg() to be able to peek across multiple records")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9fbc70200cd0..78aedfc682ba 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2064,6 +2064,8 @@ int tls_sw_recvmsg(struct sock *sk,
 				decrypted += chunk;
 				len -= chunk;
 				__skb_queue_tail(&ctx->rx_list, skb);
+				if (unlikely(control != TLS_RECORD_TYPE_DATA))
+					break;
 				continue;
 			}
 
-- 
2.43.0


