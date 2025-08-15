Return-Path: <linux-kselftest+bounces-39111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6639FB284FF
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 19:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12893B62882
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 17:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1004143756;
	Fri, 15 Aug 2025 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDHHL2MY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A13930F524;
	Fri, 15 Aug 2025 17:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278930; cv=none; b=BOhg25iK5/LG5D2jubn+ybUXAsm29QDfSJIZDpd9cWXHZ4FVSdJVO49s84uUDGA6wMje3FPqCW/MP7Xp0EMCHKbkYB9u1DWh4QzEf0Rr4imgRNwx/0HSXqbfhzwryijZxZnobiGRDIb2opFybaN4fYLkJhYuFem26zuCODR2yHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278930; c=relaxed/simple;
	bh=alzUII3HCcV/PNy9aZJrnaMvWFFEiAxn9OrGN59/B+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=psDqXXkH/mJl82U0zaoM/Jvq9Roy1FMBoR/e8e9OA/pWwiDYxOQPCI45/jMskGjiR6ABF7mBm8SLtU8KzWx8lsJhtXBoh0+ildKkfopx0Wh5A/Z90iIGn5rB9z+E4vS835CWPXcmTHwxCNqrDnSR0oy+Nye11zQlLnOhSjYjMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDHHL2MY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF34DC4CEF8;
	Fri, 15 Aug 2025 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278930;
	bh=alzUII3HCcV/PNy9aZJrnaMvWFFEiAxn9OrGN59/B+I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EDHHL2MYImyfQUWxHtTDmITADnFutyeb9Rqj/o0rLgGvvgXpmkiqfD113rfwU+pbv
	 nFsSpNi1vXPpWOEwd4VIze3mBhJeCLEmN8v9DFETfHFkf74apL/gnt6MWSC74lqy9l
	 7ZYYkWS5HUVAhf+GDLMILF5AGQJ2VD6XeJt0hsl/mvEQUAbggAFx7RYVLNfVYv/FhB
	 mTU2Bv7WaL5tK8gfSubYz/cHLnblSnrJJiPEYPbMlYMmHkgAHRE2Jc5W5xXMEZQ4fl
	 +pxE3MPOSv9H9fQ57yB1HXnHqntHYBkb5xgyzJ3kza8cBBS/NaEmDEFzJFzku+FZ0l
	 AeuPplDBs0pmw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 Aug 2025 19:28:19 +0200
Subject: [PATCH net 1/8] mptcp: drop skb if MPTCP skb extension allocation
 fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-1-521fe9957892@kernel.org>
References: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
In-Reply-To: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jianguo Wu <wujianguo@chinatelecom.cn>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, zhenwei pi <pizhenwei@bytedance.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Christoph Paasch <cpaasch@openai.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ZiXTrfWywLXu8XVmrQdOFUX//1vIF1rJYp1AiLk8nPw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLm5zm8vG93Zt8SlsYZa+LZZ554naK+w3LfhqUFi2Xvr
 N5b9ftgdkcpC4MYF4OsmCKLdFtk/sznVbwlXn4WMHNYmUCGMHBxCsBEfIoYGTZx7n7aZmV2ufha
 /yIGG+Mldl4nn6XM+rmVSzmVd8n/F7yMDG2zp2w1ddriuXeRxJRe/RunFiRw7m1Yzu67cutevlr
 GpcwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Christoph Paasch <cpaasch@openai.com>

When skb_ext_add(skb, SKB_EXT_MPTCP) fails in mptcp_incoming_options(),
we used to return true, letting the segment proceed through the TCP
receive path without a DSS mapping. Such segments can leave inconsistent
mapping state and trigger a mid-stream fallback to TCP, which in testing
collapsed (by artificially forcing failures in skb_ext_add) throughput
to zero.

Return false instead so the TCP input path drops the skb (see
tcp_data_queue() and step-7 processing). This is the safer choice
under memory pressure: it preserves MPTCP correctness and provides
backpressure to the sender.

Control packets remain unaffected: ACK updates and DATA_FIN handling
happen before attempting the extension allocation, and tcp_reset()
continues to ignore the return value.

With this change, MPTCP continues to work at high throughput if we
artificially inject failures into skb_ext_add.

Fixes: 6787b7e350d3 ("mptcp: avoid processing packet if a subflow reset")
Cc: stable@vger.kernel.org
Signed-off-by: Christoph Paasch <cpaasch@openai.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 70c0ab0ecf905d282e5dc6c1b21ffc6476c8d71b..2a8ea28442b271675411d190604073f779bee7fa 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1118,7 +1118,9 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-/* Return false if a subflow has been reset, else return true */
+/* Return false in case of error (or subflow has been reset),
+ * else return true.
+ */
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -1222,7 +1224,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
-		return true;
+		return false;
 
 	memset(mpext, 0, sizeof(*mpext));
 

-- 
2.50.0


