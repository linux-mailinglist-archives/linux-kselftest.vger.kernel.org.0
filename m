Return-Path: <linux-kselftest+bounces-30575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB31CA85B11
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B697B1BA4F4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3402980DE;
	Fri, 11 Apr 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzMzHr2J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C64020AF66;
	Fri, 11 Apr 2025 11:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369520; cv=none; b=PAI0FWk4pN4i+HZd7/Dgen6YWGSAVTx1h5QgyicIXyAdjwGoDupx7ltuP3wVD5z6MrU+cHahloHsSQZqdV/G9QZU90KFM7njIkzaAwW4Uuu5mI37LylQFN/82pMQgUwEQSHTowqwXSOrTKKn83nBTFA5qb44DM3HDC03QfWJDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369520; c=relaxed/simple;
	bh=WrBTkiARmd3Jb8fcgTuNcW/0SOYLvJWTTJgrJR3rlB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VglG/Uoh4/kehZeq9RkfOqSoi9+JnJM+OUM1JJBx6xWACVD1s0HUi9GOLo/PM5UAx+uszX8SteG/8qUxwqL5tw24kzx5kecsAdM2d8sidUQGVw9lq2eRZmJougm+zu6kT0V0vzmqpWwxZs72M8IS4rg9UtySIkSIRNH1GHKSj8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzMzHr2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831A1C4CEE7;
	Fri, 11 Apr 2025 11:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744369517;
	bh=WrBTkiARmd3Jb8fcgTuNcW/0SOYLvJWTTJgrJR3rlB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nzMzHr2J/i/W+nqTO+YvQC4Nm1EKRbRkfYW44TTv5ys/WVFHaZ+eTJ9r1EFo9B2E+
	 2MiPfYt9jk07MvRPbODnPVNB+tUCQZ/TxsRPmKNoRzuwW5MG7P6anDbrXNSjVIOXmS
	 MotN2nHy+RzxHo1PtFYJ6FHtQ8srWvjBLDPo17T5UKjinzFbFLZMDuUPdARnJZ8C1T
	 xgEPLh6UEp9BkasIRgTX1tuAKkWAMuEzfuVl0juqiqxMQ+v9ThjiJFbuPNl5iNmfiJ
	 yNM+wkLUamre70Ay0/dQwfwf9NmefmnnUj3/LDywO1c/kujOeFEmKLQJithU7ZC3qL
	 Fr9yAzmpQh2gg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 11 Apr 2025 13:04:48 +0200
Subject: [PATCH net-next 2/8] mptcp: sched: split validation part
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-2-85ac8c6654c3@kernel.org>
References: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
In-Reply-To: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2087; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9aiVx29fees/W2uocvD+Mgcs0CLE7TCa9lg37jBJZWw=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+Pddc5+F+WycmH4oqfveTCff7+VA1aXe7/DbH
 JMPEkyeFgKJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/j3XQAKCRD2t4JPQmmg
 c/YqD/99HV7P0G3V9l9zT0nWLuBpDLt53BHUQeEzJUzY4GdIwatwriGMgnnQSxX3ehwge9gPOrY
 uAor4Gbvu8FbLGRloe8S7YBqbiBEFrChyALSbxxD7zVHGqGNjSDQGWzPDR/rVSy7qga8Ns6ok0l
 MnIgitNoVT9xoDYZcAGhQuzPDvzpluJpQBa6mLf0FEj54jQLG+Hc1vGTkjKXrKrfe00yrsbw6re
 dM7ZydRSf3P6OSBXHKxUclP/sNvGKpORq6tFFeDjt3xAPk/BXOwNwQxbjOZONSy0cKAxX3xSg/v
 Uqz2RLbSAsD98zqxuNpjd5ZlpGA40zIlMFM20NGTpXYhwqz/MH0TDIfwhP5/gWw/Mw6Fe9xVKdT
 3+pw+bcoEYgBNq6uLfydduOzyH2NOfc+3bOr0tHVyXFgyzLWDAU6DJG+lMzYarxEtxxESrE2n5r
 xnx3h8xy8RcMTgp8ZIU3P73pdPFI5kITRKcXt5oDGTukqsuOhho4fd17MOpRpHu4mqzLJCPYza7
 Dm2v1trsMOWC1mMS7WEKYCC4ORH2wMApYNaFA9X1td8OFo+0Nyo5opmryDfhtRmzVH1em1kO9Do
 jtr6ha3/Rheipnm3TQTni3dezkg7PxJLPD2fmzJWqN8JRCXspPOd1IXvECc9ow9URouk6x5rP6n
 1/mC4IvWZ33pTTA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang@kernel.org>

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


