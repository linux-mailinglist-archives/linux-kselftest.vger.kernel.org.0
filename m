Return-Path: <linux-kselftest+bounces-40655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C947B40F22
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 23:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52461A88078
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 21:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF1035CECA;
	Tue,  2 Sep 2025 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7lAnzYE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E545E35CEC1;
	Tue,  2 Sep 2025 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847524; cv=none; b=WLW6GTycKZESZlrW5NjilsS7kzsyTZBlawRiM9HysrR9LdjyJlDo37SziuwZOkL/Q2+vEoYfl2x6brLSClHtDhoosIChS0geOliTnGDJHxny1xnKAtFoInVAZFgly60R2OMPB9h91R2y450QyW/g99ky7mgjJYacjAwIrnZ+kK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847524; c=relaxed/simple;
	bh=aKV7V4/h1VElLNwk04j6OR0rXx+jT4YWtNS//uiCe6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Icro4JGcjXu7O8s21eRr9PheKP4yuiL8YRO30RB2A+NuS7Q8PVv8Mv4ZNLL3AUhPx+sMEB0t7XMxxns5A9d9CDOzo5sSeNbzg18T1dwjjKMaz7wGX/fT3MBEt/CVY2AgOgk36F8zebl21w1xWMBLM99v0tKSSJNrlfDaYLp4Thg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7lAnzYE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E333C4CEED;
	Tue,  2 Sep 2025 21:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756847523;
	bh=aKV7V4/h1VElLNwk04j6OR0rXx+jT4YWtNS//uiCe6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H7lAnzYEmW/NPPw04oAjm59dxUN1wcKksLZFgwM+oRkRk/bHbURBIRcrlyw0ue3OI
	 LunqnZD0RqxuVhjxVczkR2QqIAbADeNoQBwA2CGu1xGudxw4xNFBIF1KNzkJU+/D6u
	 l9mwSnaCunyobBqY/Jc7nSVJmg7N0CdPoM77nfll+FseezBmBx2jNfhRrYUUycnYAX
	 SPW+MI0qKsWJ7SAbdcN5L3HBGIuBqunG2ZAxH/KDUTq5lpqAnBKQgDxA3EIHzzpx2Q
	 Fnh4JUhKbaz8fQuk4j9WiJ93WxVvkJeF44QFFfWubCvFQEWEoWmCV/Nr7mVkXLGKP+
	 rb+ts+pOpVQ3g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 02 Sep 2025 23:11:36 +0200
Subject: [PATCH net-next v2 4/4] mptcp: record subflows in RPS table
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-net-next-mptcp-misc-feat-6-18-v2-4-fa02bb3188b1@kernel.org>
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
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2920; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JcdYSSMrpRvS9n1aF7EX7vQ1sd6hTMXnoLQdj6fho/M=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK2x04JFZuneOLANe7ZrVYfNRSkZze/6tF9MmdR4rVoU
 cfDgu8edZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWjIVAYuTgGYSPVRhv/xPrOOv9Q3eWG4
 4OQv9fZvu/fl8TMeODG3tG/L7N49cy2KGf6XH/5Yuu2CpP1VmelVOW4PEi4VnKk5Lf7zZvp1Ucu
 M0CxuAA==
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
2.51.0


