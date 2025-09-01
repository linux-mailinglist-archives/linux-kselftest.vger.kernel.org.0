Return-Path: <linux-kselftest+bounces-40423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A79FB3DEC7
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 11:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4CE7A85B0
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62A731062C;
	Mon,  1 Sep 2025 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjQ0rv7+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840663101DB;
	Mon,  1 Sep 2025 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719620; cv=none; b=ernCfy9/XlfGGcJ8vB+c4ll8HEASY8lM2E8lcz49yy6ibMgpzjDiFYWjFA0udm7gLqkZ4w7smP9JFDMxPcVWYjvYtITATpJB+FmTCjSb4engowsNkACMD0BJ1HukGOFazh5oQvpKWLQaJX2vqCVUWpsLx9B5zw/orE3wuShILoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719620; c=relaxed/simple;
	bh=xXUKa/ahfEA+dPigVdk1wYHJYq2Hcf1En5xC3FDAHjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gwd2lgS50WOnof/kqvGKC7HmbGa0Iclq4ocQYzoxaxdm5fCq7I1K88XedNSaJ3YJ+5Xb/ltCu7tkK4MSCUj/768DiDZfQcI3ySoGfJwpZkUTt1VNSA4d5DUCcVjGqmHU+dZB0/WZLtcVa2NweUmTWY3a7Lo+L+zpAVpgY+satCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjQ0rv7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B93C4CEF7;
	Mon,  1 Sep 2025 09:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756719620;
	bh=xXUKa/ahfEA+dPigVdk1wYHJYq2Hcf1En5xC3FDAHjM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rjQ0rv7+GecG8W/iYX14MaA2yBXstI7q3rKUFQ66j7uBiWVR31v1sluzWxo0WYj3E
	 GCPaHBNB78gf8ExRdW8sSFk9ySZhU2cludGgYO2GOfD8uXckj6ne/mnpOi3I6KunRn
	 51C/IP9brrZ1MP0a1SfKeAMA5kLjTaSe2h48TGApvNuAp62zKYq8RDhSbEo46dDziC
	 G9kx66wYKHuq5f9m5zQyT5GH3Kdv0gqRdYZ5eoXlaw45tG6aTEtAn6It1fskyhHE/U
	 PB0mDZ0wR+FNv+3fphW0lYYbO5MrOCMC4iB6KWiI8ivU2xb1drVpYGf/Hh4LqVGgnY
	 OfyQXpCX+8kvA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 01 Sep 2025 11:39:15 +0200
Subject: [PATCH net-next 6/6] mptcp: record subflows in RPS table
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-net-next-mptcp-misc-feat-6-18-v1-6-80ae80d2b903@kernel.org>
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
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2920; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=FVq/DLjkSiShyfNhu4andsIboYNo8KQGQUci1ShMrjQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK2Zr5JihI/W+L0RoHdca+w9oaamE9iKa9LBfNNXrXWT
 eR/vlu2o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCI2Nxj+Cv5N73Bx1OaVsvLc
 s/RQTum6yqms0qkm09pvdh+RSnbQZWTo6GPbVFH5WNMmK2P+J9mcpm8ZfxobdH8tuKBy4LLCcls
 mAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Christoph Paasch <cpaasch@openai.com>

Accelerated Receive Flow Steering (aRFS) relies on sockets recording
their RX flow hash into the rps_sock_flow_table so that incoming packets
are steered to the CPU where the application runs.

With MPTCP, the application interacts with the parent MPTCP socket while
data is carried over per-subflow TCP sockets. Without recording these
subflows, aRFS cannot steer interrupts and RX processing for the flows
to the desired CPU.

Record all subflows in the RPS table by calling sock_rps_record_flow()
for each subflow at the start of mptcp_sendmsg(), mptcp_recvmsg() and
mptcp_stream_accept(), by using the new helper
mptcp_rps_record_subflows().

It does not by itself improve throughput, but ensures that IRQ and RX
processing are directed to the right CPU, which is a
prerequisite for effective aRFS.

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ad41c48126e44fda646f1ec1c81957db1407a6cc..a8d57b88578dfea807d3d55e430849aa8005c637 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -12,6 +12,7 @@
 #include <linux/sched/signal.h>
 #include <linux/atomic.h>
 #include <net/aligned_data.h>
+#include <net/rps.h>
 #include <net/sock.h>
 #include <net/inet_common.h>
 #include <net/inet_hashtables.h>
@@ -1740,6 +1741,20 @@ static u32 mptcp_send_limit(const struct sock *sk)
 	return limit - not_sent;
 }
 
+static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
+{
+	struct mptcp_subflow_context *subflow;
+
+	if (!rfs_is_needed())
+		return;
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+
+		sock_rps_record_flow(ssk);
+	}
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -1753,6 +1768,8 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	lock_sock(sk);
 
+	mptcp_rps_record_subflows(msk);
+
 	if (unlikely(inet_test_bit(DEFER_CONNECT, sk) ||
 		     msg->msg_flags & MSG_FASTOPEN)) {
 		int copied_syn = 0;
@@ -2131,6 +2148,8 @@ static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		goto out_err;
 	}
 
+	mptcp_rps_record_subflows(msk);
+
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 
 	len = min_t(size_t, len, INT_MAX);
@@ -3922,6 +3941,8 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 				mptcp_sock_graft(ssk, newsock);
 		}
 
+		mptcp_rps_record_subflows(msk);
+
 		/* Do late cleanup for the first subflow as necessary. Also
 		 * deal with bad peers not doing a complete shutdown.
 		 */

-- 
2.50.1


