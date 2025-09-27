Return-Path: <linux-kselftest+bounces-42537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1184BA5CE0
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 11:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A82217E043
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 09:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E032D77E0;
	Sat, 27 Sep 2025 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdwLtorY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B02D7809;
	Sat, 27 Sep 2025 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966074; cv=none; b=ivR4Aqij7dHNKApouSwtqi3539vhCTk5JZhfB80Gc/xqI5gcNXYmu8KjMIOUI5x7FOMseRYaR6+PeHLFSnSpkPXs43ZY+VDQgjNsXUuAgqX2sLtzco4IYaxGnCPUT3+ozjTz/2fBtnNVLgXA1BpiowqwvXhG/NWQwIRYOSWtEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966074; c=relaxed/simple;
	bh=HzIZhFYsoiSBj+TBnB6khPNFpiWrBNQ8WWdb4UesiYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oettnUnxODapOuAUPBi5VuZrcnJPI5S6p2uq1cOYhazsuj91S6vVzwuBQz2Fw1rBm0GTEUdIfAqpbHSg4vLGNxzJp8CrIbtDKjbL0cDlWzppoC9DDRgkjP+pMyZyBBrw2UifQrZkPOnGBMEPOg3a+u414tcKo8iF9rcRJ+TE/0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdwLtorY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C147EC4CEF8;
	Sat, 27 Sep 2025 09:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758966073;
	bh=HzIZhFYsoiSBj+TBnB6khPNFpiWrBNQ8WWdb4UesiYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rdwLtorYvHbeOdNEkcp1m0AypZdLUfyKBfrM8opRqaQubdesEd7sZt6TJBD4lE8kJ
	 pRxd/XrPWTRf9B+cbY3DrDxCIaYi+Wui45sGfiVvHWlOva47i13Zt24welyzTa/X8f
	 65b36t423TihZY15H0gHKLtzbEP3s7Yw+DuARidMWqrQU9U7OouTzP7Xw+TfRjvIbG
	 YhaCxSGFw2kAXtc2eXqP9WNATh/dETB40MLlWGB3NB/WlrFJx09DRM49SCykAGM5zH
	 i4mWcFF7qShqua8pacadqMkBvhiZi+3Re1fV+mWtA6BexpOvBUufTMc69Zh1Uk9Nap
	 Ie4THEbpgCazA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Sep 2025 11:40:41 +0200
Subject: [PATCH net-next 5/8] mptcp: remove unneeded mptcp_move_skb()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-net-next-mptcp-rcv-path-imp-v1-5-5da266aa9c1a@kernel.org>
References: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
In-Reply-To: <20250927-net-next-mptcp-rcv-path-imp-v1-0-5da266aa9c1a@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JNrMkwL33N4F+1s5Xmhp9Td2/aae/RO13IS7/UsLU0Q=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKub1RaISl87Ie9pkTP+umrTBl1Decu2VZ1Qohns86iC
 /wTjoQv6ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjITGtGhhlzzXTiFrwTv1gV
 MX1KufnEtcXy3+4duL/8x8993kn5c9MZGQ7mBu+L0fpUNTUm+KfcvBDX91UbulYsf5K13HXVen2
 n6TwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Since commit b7535cfed223 ("mptcp: drop legacy code around RX EOF"),
sk_shutdown can't change during the main recvmsg loop, we can drop
the related race breaker.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 832782e23740d22acda608966c29516666c9b111..26fbd9f6a3f7802c428e79c7f4e1da45aa9533e5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2207,14 +2207,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 				break;
 			}
 
-			if (sk->sk_shutdown & RCV_SHUTDOWN) {
-				/* race breaker: the shutdown could be after the
-				 * previous receive queue check
-				 */
-				if (__mptcp_move_skbs(sk))
-					continue;
+			if (sk->sk_shutdown & RCV_SHUTDOWN)
 				break;
-			}
 
 			if (sk->sk_state == TCP_CLOSE) {
 				copied = -ENOTCONN;

-- 
2.51.0


