Return-Path: <linux-kselftest+bounces-47203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6100CA906B
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 20:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C63AC303171A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 19:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8273D38C96D;
	Fri,  5 Dec 2025 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeLNN2aH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A03E38C965;
	Fri,  5 Dec 2025 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960939; cv=none; b=jbC9A6hdCAnEnEsPh92Z9HHvwH67Xo7PrZnw4X3AFB8sZBFrN0f0eV/stPluF8o4bgiwqBM7fai0p3Z7VZOB1M3oqtg5NgoabzEUH0pAHGqqW0/CBKtG+UvFawhsEt8dZ1KpvQsqeB60PhRi5ZDhZyZnRLdwumTkK/lX0fWlIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960939; c=relaxed/simple;
	bh=LBGJ10NGm/7i5Fc6PC0h0738AWnQFDymUI8BVZwe1ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/TE2Zb6uUysiqPwroSwfhTflVQI1Iw6gs5Jy7O6EyETCgcmZ/s0+d2/eDPw925sIrYXy/McN2iqgPZXWP7hbV6PCwKtWiJUCPzoUE+PUDQBwj6Yx7uN4XYqpnQ5s/XC/2mzXT3VCYMirOzFgGCP3FGAKX8rqO3rkLIpdhZNBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeLNN2aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844E8C116B1;
	Fri,  5 Dec 2025 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764960939;
	bh=LBGJ10NGm/7i5Fc6PC0h0738AWnQFDymUI8BVZwe1ng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QeLNN2aHuqPcDcSKao4sg/t7MOtKD/8gke9z3q/bW9xylX8p0rCrhYlcdHgKy94JP
	 9RwSYVf7MR2Glb3vTE79Np007JFOPxVpBoCqd/ZRo1Ph2/LYP5jwhAvQC4AlC53fXT
	 sOK0oECLO1A2Ut2mHgrDTApGiLF9t75U7NE4O9XyRAR/JP865tUKhuf1KctpnHH6/b
	 oTpRp6XuLcTYJCA88H5QlkyoLVFwkGoqow1HRzgs/E3HHuGE8DA7DuA9alhszbHLgS
	 0bWFl8uwalfpS9Y4f6uOWk09iyGmnB+Zr5NtiHJ/HrLw6p9QFl3UsaHL7a5xM+rPv5
	 S/vv56K2JbGbw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Dec 2025 19:55:16 +0100
Subject: [PATCH net 3/4] mptcp: schedule rtx timer only after pushing data
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-3-9e4781a6c1b8@kernel.org>
References: <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-0-9e4781a6c1b8@kernel.org>
In-Reply-To: <20251205-net-mptcp-misc-fixes-6-19-rc1-v1-0-9e4781a6c1b8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2121; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RKCyTYaihj0DTuxY9L2L/+KtoO/PTG2GYNXSf8p2Bjc=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKNtebWKffturdj4c/p/OcreBp+37/z5qdy+qKmz5O2T
 z/gXqLN01HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCR0hOMDKvlYzQ7Hm3mTm6I
 3nnowAnBWJ9n3ZGKCw48OrI2YfLPdVoM/wyWtL7+fczDfoFV/ZkpKZNmCR67+ONt21bleoFV/Uk
 H3TkB
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP protocol usually schedule the retransmission timer only
when there is some chances for such retransmissions to happen.

With a notable exception: __mptcp_push_pending() currently schedule
such timer unconditionally, potentially leading to unnecessary rtx
timer expiration.

The issue is present since the blamed commit below but become easily
reproducible after commit 27b0e701d387 ("mptcp: drop bogus optimization
in __mptcp_check_push()")

Fixes: 33d41c9cd74c ("mptcp: more accurate timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e212c1374bd0..d8a7f7029164 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1623,7 +1623,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
-	bool do_check_data_fin = false;
+	bool copied = false;
 	int push_count = 1;
 
 	while (mptcp_send_head(sk) && (push_count > 0)) {
@@ -1665,7 +1665,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 						push_count--;
 					continue;
 				}
-				do_check_data_fin = true;
+				copied = true;
 			}
 		}
 	}
@@ -1674,11 +1674,14 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	if (ssk)
 		mptcp_push_release(ssk, &info);
 
-	/* ensure the rtx timer is running */
-	if (!mptcp_rtx_timer_pending(sk))
-		mptcp_reset_rtx_timer(sk);
-	if (do_check_data_fin)
+	/* Avoid scheduling the rtx timer if no data has been pushed; the timer
+	 * will be updated on positive acks by __mptcp_cleanup_una().
+	 */
+	if (copied) {
+		if (!mptcp_rtx_timer_pending(sk))
+			mptcp_reset_rtx_timer(sk);
 		mptcp_check_send_data_fin(sk);
+	}
 }
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)

-- 
2.51.0


