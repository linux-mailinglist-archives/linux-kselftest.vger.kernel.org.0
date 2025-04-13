Return-Path: <linux-kselftest+bounces-30645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F42A8714D
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 11:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6B63B99CD
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFCB1A238E;
	Sun, 13 Apr 2025 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMeFN2pt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF871A0BFD;
	Sun, 13 Apr 2025 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536901; cv=none; b=u/InF2Xn/sNFhDih2cocrgbgUSTlA2LOzcG9zSJnUU3Ik4+t33UF58uTA0ed+apFD4DDku8vXwD12otn+xolqpU1RUi+PBiE7jwUorJUU6HcVlbZ5Iq7/hX5MraWSsdoykaBRZbnqhBkCh32MhQQ3py0uPcKFUoU5EkjBymjM9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536901; c=relaxed/simple;
	bh=jQ20O7DhqTMfar+V5CaRvgDGRxvFp3gqHN2voLWChWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g8OLiEqEz0fxBECw3mtYHDX4gsaXFE3yEaGFRBezAIXYeb2gXQ4+NNPpL1GLlaaL5pDRniI2GHYMIrZAaIuqKtrfGgF4r7/kawjagQenViqil0KPUcH+pquM7nJcXdHTm2NkPD/YKKaQ6NMD/ds3ljE3j4z+FOdCDrrjAAzeTGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMeFN2pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89976C4CEEC;
	Sun, 13 Apr 2025 09:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744536900;
	bh=jQ20O7DhqTMfar+V5CaRvgDGRxvFp3gqHN2voLWChWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YMeFN2pt/g7ckbCq/fyz93MFpkaRLfaXaNUebwpOLAnjUDCNK7F6CyQdNryOx0nT9
	 QnPDLUIEyoJqvTYC4s13dR1BAbAbuHrLMEbdGvtEkgnaXDi+DHPGjbAY7v+6k3nsia
	 skx3jVcQmxZzyMC1EVVy3xrNzD1Pw+g/mGr59Y/JTRZ1RBsoU5RvwTT/vforcG8Tky
	 rH0gzZa0T/r+LNsU74+pu8msNScxnMQvWibu2qY8bx528OVweNO74qE8iSOE3HvUT5
	 TWL1i61QLG5/eU7Xl7kwU6K4kiKsCmSWYHLFsXsvoksmpTX45eBqlq54tI0fn/T6dL
	 mGJjl64CrVJXA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 13 Apr 2025 11:34:33 +0200
Subject: [PATCH net-next v2 2/8] mptcp: sched: split validation part
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-2-0f83a4350150@kernel.org>
References: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
In-Reply-To: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2140; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Prj8WuhgjJsXvrTgfPfnV6nlpjcjQek+PSeM494ueS4=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+4UzgZLLBKQd6uAAloCrvdIEJRNvhIMENTfYZ
 aG+QaZYkbmJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/uFMwAKCRD2t4JPQmmg
 c/QyEACDdO5T85GLhDhQ7b4dANeZxKqKpxMxhL5lN+h8Rkf15CCs4J05yiDc0HFG6/w/kPRSX9Y
 md/VM8VQ/KiDH/hL+B1uhs3Jh/vdLPNFaU2dozHP+ETXm8NjjDZnbOh9shlr0bEH+xCh83miMzs
 /EgfoluU+bqVjZ52Vd90kkeCviW3cVR/FRqlqVZFuynGat+4aW7le1wIQ49CCfOFeLF5GheTVVh
 T0LJ31q/o5gLtjCLv24Mopz7qZAa6P4EILqaEYHdRen+KysG0swse8nNXYZxF7yCnqinH1CxIb5
 E/Li7GlAkYXyuIqflsqm8ci2so2hPRFBvhNWOatpVtLC5N8i7Vfd8c6XpeT/we6E/jF0gxmtSkz
 fhaMv8UyJg5IYlTapbMKVhX0foYhD7SFU36gYXkd48YDI/dOKzrw/Sr286NMr/uJocO/RudPMNG
 zVLXkqppv5D7zsP79/3cMCbf/CEQ9BauS+k8bEoe8PUPilWkZC7YLD8+qvWuF9LYEHSb36g8dnB
 +nCUKZG8q18kQGqKkio7O7OzFX3vygKdJ1YE3LonN1JIOmXI45p+mSe+TLrqtE48ysONaMn7lUX
 Fyf6ocKie4LNwPUOEUTjHl7iIa0grZlbpFwKkpuEwqsh232KDYLP9t/xxwokOXr7Pp+8m8oud1G
 d526OVgvsak7cXQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

A new interface .validate has been added in struct bpf_struct_ops
recently. This patch prepares a future struct_ops support by
implementing it as a new helper mptcp_validate_scheduler() for struct
mptcp_sched_ops.

In this helper, check whether the required ops "get_subflow" of struct
mptcp_sched_ops has been implemented.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
- v2: fix Author field (--no-mailmap).
---
 net/mptcp/protocol.h |  1 +
 net/mptcp/sched.c    | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d409586b5977f93bff14fffd83b1d3020d57353b..7aa38d74fef6b5f00d97a114d74b711014d0a52d 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -744,6 +744,7 @@ void mptcp_info2sockaddr(const struct mptcp_addr_info *info,
 			 struct sockaddr_storage *addr,
 			 unsigned short family);
 struct mptcp_sched_ops *mptcp_sched_find(const char *name);
+int mptcp_validate_scheduler(struct mptcp_sched_ops *sched);
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_unregister_scheduler(struct mptcp_sched_ops *sched);
 void mptcp_sched_init(void);
diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
index f09f7eb1d63f86b9899c72b5c2fd36c8445898a8..1e59072d478c9b52c7f7b60431b589f6ca3abe65 100644
--- a/net/mptcp/sched.c
+++ b/net/mptcp/sched.c
@@ -82,10 +82,23 @@ void mptcp_get_available_schedulers(char *buf, size_t maxlen)
 	rcu_read_unlock();
 }
 
+int mptcp_validate_scheduler(struct mptcp_sched_ops *sched)
+{
+	if (!sched->get_send) {
+		pr_err("%s does not implement required ops\n", sched->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int mptcp_register_scheduler(struct mptcp_sched_ops *sched)
 {
-	if (!sched->get_send)
-		return -EINVAL;
+	int ret;
+
+	ret = mptcp_validate_scheduler(sched);
+	if (ret)
+		return ret;
 
 	spin_lock(&mptcp_sched_list_lock);
 	if (mptcp_sched_find(sched->name)) {

-- 
2.48.1


