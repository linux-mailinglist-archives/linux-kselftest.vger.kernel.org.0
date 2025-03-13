Return-Path: <linux-kselftest+bounces-28900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA486A5F0AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F043BE521
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C038266562;
	Thu, 13 Mar 2025 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNVAGd8T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC823261583;
	Thu, 13 Mar 2025 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861374; cv=none; b=BkAO3dngRNGzvdKOrdJoU+x7IfFAmHWfvO3kxzuyZjHj0YvWLrt5ENFtKtcGjlC82+jptuZDWwARD2c1eoJuMTidbPuC+Kz2ELS6U3TtTfppSyAB6wdfoYPo/8K3e87eTcVFl1ENSg9BsZz3sLdlelmJzGQUgRnbXOF9kd6wp1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861374; c=relaxed/simple;
	bh=X7qj2Fannnfwa9xeBpdSpc8P0kVb7QIc4gTw5pZTGp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5YbEEAhjUk9knXrjbeSl0xu8/1WGhR6bCvKQ4JIgxIqahyqBx9E0aKnL4ubDrYQ+PanY+j8f6s6evaipTmCbCdwgDXuGRWS2b3nvZLwkPzn0vOn7n2+7bzksmc5RwwHi3j+zi+YxWxXQwvINrfRWbJ1WG+1dS7ffAwJBJGCJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNVAGd8T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07EDC4CEE3;
	Thu, 13 Mar 2025 10:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741861374;
	bh=X7qj2Fannnfwa9xeBpdSpc8P0kVb7QIc4gTw5pZTGp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CNVAGd8TbHFoF1h3YG3NxJjO/UTo0UNIk3ZpJEJ3sq9L11kDUS6Bdf/V5TPrVk8F+
	 5E8nPrMHwFH7j33mckkCgWQGdetTEvZd5eX6FNuPPlPWg/1KuAxWBMXQ268gtV2qMX
	 dRL8Vzd1HqCttAmAmqICulA3qLgB48OsnQBoqymPD8+biO84n/BqNhhCwcCWI+8gbx
	 7xfkGViS9vFTeEat9rktBTsqz6ciAhg0sWdLbsCz9ykMKJxqwUtqbawkENT51ez5E+
	 0VDB5ljrOYQhDC5CukZkkzYHH7fK9fhEMc+oAQyiUC3keOq7Q6lknGBCKAUJ1Kpuq+
	 JU0W8Wsv7LbXA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Mar 2025 11:20:57 +0100
Subject: [PATCH net-next 08/12] mptcp: sysctl: set path manager by name
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-net-next-mptcp-pm-ops-intro-v1-8-f4e4a88efc50@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5752; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oGH0XhqcKRHt4ikWS4HVI+e7kmGO2yr284+UtlnAV0o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0rGbIRd3vkGNGdw99iNkqwDBiOqKTCACPTQP4
 FBbsp3Dtw6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9KxmwAKCRD2t4JPQmmg
 cydrEACU6lZX/KkhEofh6cAgLdGkkq96satYnHULxo3ZekyEUDOFdacHrC26bgVu6dvWM2n6b7i
 qiLpL/whj8vQr4PiuiT5N15eaRoaTibnaIZpukry2vqwUauV20czBlzcbYE1uBlFSesnbPgFAu4
 32njwncAj96dfdX81O9UmcaIMIzTk3aC+CTZhYF3J9GVLM2miFbtbHhneB0dMZGaorJOuR65deQ
 jBy4LfudfHSdnFS2/BgfUCbDBvxyUe9ziPiwoyDJv72l8FNMIUqYFvU08w3RUIxv7luEFyIzdSz
 U5L33vtP64yg4/lWcC5Fuh2d7sQy5By8i3rEvqsnkuVDlWTlPC0fixLYov8a4R8lypZjP3BXptG
 6iJ5Sj1iGb20H6SYt+On9iltLF5Orv7XBC9Oop7no5+GRNQ24vjX4VhrxyyyaoFWj69H22oVwni
 p934mV//U3YcrjohN48wrMi8BlDYAKP0Q8ynW2BH3XFr95LAs8zm3Zoi84nA/hZQpfENRfWabGO
 DoiWcahIAXHtUHTcK+DsgmipyLnFnTXyB8P1duM50YTrPPr4A6hz9LjWCBIYUV6+sUhMLqzsqED
 2NaQoVNYi3WGuCOQ2HYWyYxYJBTdRSBXeGuOWiIopK/nqeZ7oB93r7O0XOxEQ9gmgh0W5YuylET
 JqOF9Oa1MHFiRjg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Similar to net.mptcp.scheduler, a new net.mptcp.path_manager sysctl knob
is added to determine which path manager will be used by each newly
created MPTCP socket by setting the name of it.

Dealing with an explicit name is easier than with a number, especially
when more PMs will be introduced.

This sysctl knob makes the old one "pm_type" deprecated.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/networking/mptcp-sysctl.rst | 19 ++++++++++++
 net/mptcp/ctrl.c                          | 50 +++++++++++++++++++++++++++++++
 net/mptcp/protocol.h                      |  1 +
 3 files changed, 70 insertions(+)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 03e1d3610333e29423b0f40591c9e914dc2d0366..b78a2254d4523e0c0fa09338d4b676da18f82d97 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -72,6 +72,23 @@ enabled - BOOLEAN
 
 	Default: 1 (enabled)
 
+path_manager - STRING
+	Set the default path manager name to use for each new MPTCP
+	socket. In-kernel path management will control subflow
+	connections and address advertisements according to
+	per-namespace values configured over the MPTCP netlink
+	API. Userspace path management puts per-MPTCP-connection subflow
+	connection decisions and address advertisements under control of
+	a privileged userspace program, at the cost of more netlink
+	traffic to propagate all of the related events and commands.
+
+	This is a per-namespace sysctl.
+
+	* "kernel"          - In-kernel path manager
+	* "userspace"       - Userspace path manager
+
+	Default: "kernel"
+
 pm_type - INTEGER
 	Set the default path manager type to use for each new MPTCP
 	socket. In-kernel path management will control subflow
@@ -84,6 +101,8 @@ pm_type - INTEGER
 
 	This is a per-namespace sysctl.
 
+	Deprecated since v6.15, use path_manager instead.
+
 	* 0 - In-kernel path manager
 	* 1 - Userspace path manager
 
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index be6c0237e10bfd7520edd3c57ec43ce4377b97d5..4209dc7f97048d27deea1923742dfd5ebd710694 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -39,6 +39,7 @@ struct mptcp_pernet {
 	u8 allow_join_initial_addr_port;
 	u8 pm_type;
 	char scheduler[MPTCP_SCHED_NAME_MAX];
+	char path_manager[MPTCP_PM_NAME_MAX];
 };
 
 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
@@ -83,6 +84,11 @@ int mptcp_get_pm_type(const struct net *net)
 	return mptcp_get_pernet(net)->pm_type;
 }
 
+const char *mptcp_get_path_manager(const struct net *net)
+{
+	return mptcp_get_pernet(net)->path_manager;
+}
+
 const char *mptcp_get_scheduler(const struct net *net)
 {
 	return mptcp_get_pernet(net)->scheduler;
@@ -101,6 +107,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->stale_loss_cnt = 4;
 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
 	strscpy(pernet->scheduler, "default", sizeof(pernet->scheduler));
+	strscpy(pernet->path_manager, "kernel", sizeof(pernet->path_manager));
 }
 
 #ifdef CONFIG_SYSCTL
@@ -174,6 +181,42 @@ static int proc_blackhole_detect_timeout(const struct ctl_table *table,
 	return ret;
 }
 
+static int mptcp_set_path_manager(char *path_manager, const char *name)
+{
+	struct mptcp_pm_ops *pm_ops;
+	int ret = 0;
+
+	rcu_read_lock();
+	pm_ops = mptcp_pm_find(name);
+	if (pm_ops)
+		strscpy(path_manager, name, MPTCP_PM_NAME_MAX);
+	else
+		ret = -ENOENT;
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static int proc_path_manager(const struct ctl_table *ctl, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	char (*path_manager)[MPTCP_PM_NAME_MAX] = ctl->data;
+	char pm_name[MPTCP_PM_NAME_MAX];
+	const struct ctl_table tbl = {
+		.data = pm_name,
+		.maxlen = MPTCP_PM_NAME_MAX,
+	};
+	int ret;
+
+	strscpy(pm_name, *path_manager, MPTCP_PM_NAME_MAX);
+
+	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
+	if (write && ret == 0)
+		ret = mptcp_set_path_manager(*path_manager, pm_name);
+
+	return ret;
+}
+
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
@@ -253,6 +296,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.mode = 0644,
 		.proc_handler = proc_dou8vec_minmax,
 	},
+	{
+		.procname = "path_manager",
+		.maxlen	= MPTCP_PM_NAME_MAX,
+		.mode = 0644,
+		.proc_handler = proc_path_manager,
+	},
 };
 
 static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
@@ -278,6 +327,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[8].data = &pernet->close_timeout;
 	table[9].data = &pernet->blackhole_timeout;
 	table[10].data = &pernet->syn_retrans_before_tcp_fallback;
+	table[11].data = &pernet->path_manager;
 
 	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
 				     ARRAY_SIZE(mptcp_sysctl_table));
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c9e435a1fd7c7ab22a279c6de7c1573fe45cee98..818c2c648677c255a00d668ab9b7406f0731fcf8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -699,6 +699,7 @@ int mptcp_allow_join_id0(const struct net *net);
 unsigned int mptcp_stale_loss_cnt(const struct net *net);
 unsigned int mptcp_close_timeout(const struct sock *sk);
 int mptcp_get_pm_type(const struct net *net);
+const char *mptcp_get_path_manager(const struct net *net);
 const char *mptcp_get_scheduler(const struct net *net);
 
 void mptcp_active_disable(struct sock *sk);

-- 
2.48.1


