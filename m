Return-Path: <linux-kselftest+bounces-28903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C30A5F0B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AFF1711F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D8F266F1F;
	Thu, 13 Mar 2025 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZ+gaHgI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1163726560E;
	Thu, 13 Mar 2025 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861409; cv=none; b=OUkuuv3Q7rPnUJQ054/gHQPsSq/jc/uAh/pqrxq7nbyIhxEXS3QmjE7Fr3bwVZ9zJV92XHS+/37UAmYFvDfVvaM3ThO2fAayS0wBVbNet3C0ru/Igh1794scECRaUUJvPGRb3dcHUqJIu3bsLUPdMKUzRHxK45f6/oY4ZF7uVKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861409; c=relaxed/simple;
	bh=GPnAgI9t4e294JRUYRTZXCYkVhHLkTaZDQSLIZ/7h2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irbRxqaWuT7PqxeQUbsgcOV/AyPQdKF5BkVFECpnjIWTXkIzy9HViQlaXPCs3jXuHZtGOCenZfepbs/bzjcaJsZcWLbzqLQgGFFhBPVNrdDQ1d9+0eXoy12GctjPSQuiPkYBp4TPxo5qcfGd4QOVck7n1F2TrkgtZKT7163X9f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZ+gaHgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A177C4CEDD;
	Thu, 13 Mar 2025 10:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741861408;
	bh=GPnAgI9t4e294JRUYRTZXCYkVhHLkTaZDQSLIZ/7h2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kZ+gaHgI0xN7BrDYwZpgSS9cRUIfku0k5vlJnuCTtWZYkYcqSd0PtV9Filo/yeBP1
	 qggPaWImKIuXlHg2m+lT26n2B30Y4dg5vKR5zyGCNDE0CgzSrx8uiFcvkFd4i7rNWi
	 bUhQbs0RgIV7StHNTrGmwBbzKVqzvhW/vburAfZpmmXfNFjSrmy1uRv1oN1wAuOpgu
	 LsivyMFU+b94S0RGFTEn2dalC4RcLxsFlXnlr7pE09fc6poCD/4mpPHWyWzCLtRDCf
	 D/0hg7U7+7SFpsxQQUgswCsPwGjJ21hvSjCWsxfBktCbUd+OMtHGbcBX4+9SFjdTJC
	 N7iKYZugZSRzg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Mar 2025 11:21:00 +0100
Subject: [PATCH net-next 11/12] mptcp: sysctl: add available_path_managers
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-net-next-mptcp-pm-ops-intro-v1-11-f4e4a88efc50@kernel.org>
References: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
In-Reply-To: <20250313-net-next-mptcp-pm-ops-intro-v1-0-f4e4a88efc50@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4929; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oytQPOm4JRXyC5Ocyqq1dePLR/pEKe/9a1tbEdlpJ8c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0rGbJUKvFCM8/WG+7IqDRzRnRe4wDDTXr3ZWh
 Alv0K1nFSKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9KxmwAKCRD2t4JPQmmg
 cw+YEADVd6HMwgNtqbBVrBfDLgNWsOwXQGj6d9Wq416lQA4ygn6oPLCHTjPsZqPe427DHppYH48
 a6YluKg33GSN4OTK2WipWlN4WBvVAzeaQXpxPAIdPmJ11rgf9c5dP07Dm2mEfu/oSMTwtvQ3kmt
 6gEBTn5vzLbKkyUW5lHlCKQpAquBJPNwXQXwzLJUqevEQN5xkM06GfGo6mKPJNxUTHj90TM6PuE
 2RxZwm8lEhHNWxS30lIeIRiNXSfZEfFA/ZYa9mBLVO2bRVaqUl8PuEbaIz0DvAU9hedonZoZdLb
 Ez9KIfHbDIXuIpcUpbYiGESdCdWBc7eADNPCAOXeQzystz0brAjzZTgmyiuSq/rzUrWpFMKzp7a
 AEIAq2C/qvVI8zl8DVwnL3EuRSzEmH+5TftkR/OvS3e7JdNrE+RQ5zbeltrHTbR2R/wVNm+i29G
 WGZN8g2vVnaczRQp9oQKKQf5kTak0vOhOVBPFPXRJkJ3w707tlLKWEmFbu33B/DSQO+2p5LyCSJ
 Pn8SIA9hmyzHc3ljwFp4PAk8+sA5vN+3XbOmZVGx0LvDiMHSfoslLv5hlXdsErN8rbAF+nlC5tn
 Wjo306WbhiN/sIx8gDK5sS8FFPT1na9xO3V2/Rnzgyvd90vaYSrcY49b+r1GHfyUSWcLCs7LJwv
 v7s9nrFLFMHCfvA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Similarly to net.mptcp.available_schedulers, this patch adds a new one
net.mptcp.available_path_managers to list the available path managers.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst |  4 ++++
 include/net/mptcp.h                       |  2 ++
 net/mptcp/ctrl.c                          | 25 +++++++++++++++++++++++++
 net/mptcp/pm.c                            | 19 +++++++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 5 files changed, 51 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index b78a2254d4523e0c0fa09338d4b676da18f82d97..5bfab01eff5a9db89e1484787953241c16e147cf 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -30,6 +30,10 @@ allow_join_initial_addr_port - BOOLEAN
 
 	Default: 1
 
+available_path_managers - STRING
+	Shows the available path managers choices that are registered. More
+	path managers may be available, but not loaded.
+
 available_schedulers - STRING
 	Shows the available schedulers choices that are registered. More packet
 	schedulers may be available, but not loaded.
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index 645d15695e3f5ec4b945bb543630f3dcc54453f2..bfbad695951cf664af4d05390104883268b6bcd2 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -123,6 +123,8 @@ struct mptcp_sched_ops {
 } ____cacheline_aligned_in_smp;
 
 #define MPTCP_PM_NAME_MAX	16
+#define MPTCP_PM_MAX		128
+#define MPTCP_PM_BUF_MAX	(MPTCP_PM_NAME_MAX * MPTCP_PM_MAX)
 
 struct mptcp_pm_ops {
 	char			name[MPTCP_PM_NAME_MAX];
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 4d8b31f32eb50347d10db792f084e43c93f687c6..d9290c5bb6c7956ca98319259f92b812680f74f7 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -253,6 +253,24 @@ static int proc_pm_type(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static int proc_available_path_managers(const struct ctl_table *ctl,
+					int write, void *buffer,
+					size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tbl = { .maxlen = MPTCP_PM_BUF_MAX, };
+	int ret;
+
+	tbl.data = kmalloc(tbl.maxlen, GFP_USER);
+	if (!tbl.data)
+		return -ENOMEM;
+
+	mptcp_pm_get_available(tbl.data, MPTCP_PM_BUF_MAX);
+	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
+	kfree(tbl.data);
+
+	return ret;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -338,6 +356,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_path_manager,
 	},
+	{
+		.procname = "available_path_managers",
+		.maxlen	= MPTCP_PM_BUF_MAX,
+		.mode = 0444,
+		.proc_handler = proc_available_path_managers,
+	},
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -364,6 +388,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[9].data = &pernet->blackhole_timeout;
 	table[10].data = &pernet->syn_retrans_before_tcp_fallback;
 	table[11].data = &pernet->path_manager;
+	/* table[12] is for available_path_managers which is read-only info */
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3896f21a46bd7f6912d2ffe22a3984ba97923021..18b19dbccbba72916b2f666600a2bc8993ebd1df 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1070,3 +1070,22 @@ void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops)
 	list_del_rcu(&pm_ops->list);
 	spin_unlock(&mptcp_pm_list_lock);
 }
+
+/* Build string with list of available path manager values.
+ * Similar to tcp_get_available_congestion_control()
+ */
+void mptcp_pm_get_available(char *buf, size_t maxlen)
+{
+	struct mptcp_pm_ops *pm_ops;
+	size_t offs = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(pm_ops, &mptcp_pm_list, list) {
+		offs += snprintf(buf + offs, maxlen - offs, "%s%s",
+				 offs == 0 ? "" : " ", pm_ops->name);
+
+		if (WARN_ON_ONCE(offs >= maxlen))
+			break;
+	}
+	rcu_read_unlock();
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 818c2c648677c255a00d668ab9b7406f0731fcf8..d409586b5977f93bff14fffd83b1d3020d57353b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1058,6 +1058,7 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_register(struct mptcp_pm_ops *pm_ops);
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops);
 int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops);
+void mptcp_pm_get_available(char *buf, size_t maxlen);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 

-- 
2.48.1


