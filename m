Return-Path: <linux-kselftest+bounces-4783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA6B856963
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 17:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0EB1C2434E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC818134758;
	Thu, 15 Feb 2024 16:18:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48501339AA;
	Thu, 15 Feb 2024 16:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013885; cv=none; b=um+bo7M7BlbmslkaxKl3PFUulj2nUUWTtTFmVlDKxj2RlG4jklAPJ/CCGcDRLI8thoo8CWyyioXiOkRR4l4gJOZwJc+Hpom3p8w5jxV/Q6m/5qgGShKyrtNYWGLD4boGCI3207mFaBCik9FgUJMP1agNCqOYOYhMUq6B7DCa4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013885; c=relaxed/simple;
	bh=Mg624vi2I0WoxXS16lXwFuIrvK8NIa3TuebEG/YR/mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgPVbkXbw/VzyTXqde8xX4Z3CYsX2DpvcSWxPoOuRPCDe0wt/3pDfJlosdwee/2dTwE3+Jd7se5TfEaJLjObFuX8JJoe8lMa8MeuBpW6Dfv60Ork9HR+8X3ZkqJ7oMPFTo0q4MduOyvZSqFVA0/SnSxTTizEv/BrNBAXeeliZn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id C641F1C0007;
	Thu, 15 Feb 2024 16:17:54 +0000 (UTC)
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
Subject: [PATCH net 2/5] tls: stop recv() if initial process_rx_list gave us non-DATA
Date: Thu, 15 Feb 2024 17:17:30 +0100
Message-ID: <bd31449e43bd4b6ff546f5c51cf958c31c511deb.1708007371.git.sd@queasysnail.net>
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

If we have a non-DATA record on the rx_list and another record of the
same type still on the queue, we will end up merging them:
 - process_rx_list copies the non-DATA record
 - we start the loop and process the first available record since it's
   of the same type
 - we break out of the loop since the record was not DATA

Just check the record type and jump to the end in case process_rx_list
did some work.

Fixes: 692d7b5d1f91 ("tls: Fix recvmsg() to be able to peek across multiple records")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 78aedfc682ba..43dd0d82b6ed 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1971,7 +1971,7 @@ int tls_sw_recvmsg(struct sock *sk,
 		goto end;
 
 	copied = err;
-	if (len <= copied)
+	if (len <= copied || (copied && control != TLS_RECORD_TYPE_DATA))
 		goto end;
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
-- 
2.43.0


