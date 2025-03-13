Return-Path: <linux-kselftest+bounces-28899-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2155A5F0A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9808F7A798A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A39265CD1;
	Thu, 13 Mar 2025 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azqIT19j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBF7261583;
	Thu, 13 Mar 2025 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861366; cv=none; b=kiHpEHaakWKR7vDd2oxKehAneLibVG+lKWWWrgNnRa8nWCkgB5iS5svLEeQAvGJ4WxhCYo3xmiHRZwAIa2Httj542jnDFF6/0m8utOCriW3YKGLhDKT0IvVdZBkzeX9cGMGXnho++OvRYFAh8vpwZ4UBA0mJe0MAcz8WUt2Ys6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861366; c=relaxed/simple;
	bh=WQWHLfvXh7gx4BcCE5xUkH8rIVYbU5xVMeyonwcwdxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfO5m60oyAyMaqeIo47380VZDkWMvUjT7ygC8QtjqXbgzopvpknyWu44qTDPFDRYtQ+JlB6wrLwtz6UjMPnzq/bI4H/3GvR2uoGxCZA4taNY0HlRJocgdWMfWFOw5GSdn+rX2C47+l6jT/p+RUYAFUq9xwsYMxu4jLP0241sdno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azqIT19j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C381FC4CEF2;
	Thu, 13 Mar 2025 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741861365;
	bh=WQWHLfvXh7gx4BcCE5xUkH8rIVYbU5xVMeyonwcwdxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=azqIT19jHrM4CssBhbWW+149jy/9GdrMNNVx/Soq7jTrfa0fjjU0LSMrg6nLf6I3k
	 CtN3kcwGhYTa1rPUwkm1ctpeuVkdiFdogtc2+MmWVf9EzZcsZeUajTNcow8ZDrDBwo
	 RQ0QxHWTU3DTQA/c8JnHKCQhxLp+hOgJ437z2HIxOvs9wOgU9dUNYTiZmTS0AHz4SN
	 YZ+SVzyi5EdAa2bi8tdpdEXQ/R2rGYUlHzFuSa475pmC8QiW86m7kUihb6LVnBCrzN
	 E7mLebvN8rCVaLA4bHaNczboeKSUyos/wZNxI+L/6Y9OQMPEpRlxN5Qnpb0O5jQBYB
	 dyujU1XUvIDUw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 13 Mar 2025 11:20:56 +0100
Subject: [PATCH net-next 07/12] mptcp: pm: register in-kernel and userspace
 PM
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-net-next-mptcp-pm-ops-intro-v1-7-f4e4a88efc50@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3867; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xEmRoJfWCXA2Y1Z/hFqCFMDjEYrQsGPFg/P83eQpnl8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn0rGb5MYnrk7INi+pFpCrTuMkWztBOk40QDEL6
 RZHSvymygGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9KxmwAKCRD2t4JPQmmg
 cxlbEACUnWXxnEmlVgCn8omlo5CnFI/gsGPLbsU+2YTEbNUQkbcBbK3kkNCUCTKmcU2hJ2ZVcj7
 6mtRzOITJMtEDMpwc1ERQo6tNL97+9hoDejBDM1ET4COuh7H+qdcIaNvDhOHd36OJDo3Zf3s+FJ
 FcuGTEBZsYfmykD7KiTeem/6FdvDYN57TwX8waUIxXW04NpaWXJfBbmC9VFLic7dylb2LDOtdeE
 nBn8OGh+P96sFcV7HaUY4paZFPE52GDWo4m5A1ujJqANGfFGIpnubLy4Q6yXzFpNKwa5U/oSnVY
 2dMxgdmIkt4aNDTu2xTg2MiJDp7Lilu1O9GMwpqGowdxGyeZTecb4vXNBG9Vf3JujmF2ljO92e7
 BMICOVMaP8zXulkwbZvKcQqWld2QvDaNYZPwzarkra1TAOo6UMuFunx3JN3BtnGjcv+CXfPa0kU
 NsoYZG4dHUNQX2khdC8PACnw66o6S1IFNGgtFAPzC44CwklKt6mqaDSyAyRfTryBGtpeP4f2lYH
 38FJQidCzrn1HpLpuS6kMW42g1oAP4WGhe2H4dDSeG66hILxOw4aL5kVFLxmZUhC5LnTOKlM4w3
 4cY3OGfBWePDM68mLJ5AQs7PiuwK9+ED4ibteF1xk3XjS6trWuv2shL4X63+Wm59TGeZuB8qNy9
 tckiX8S7NSJk47w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines the original in-kernel netlink path manager as a
new struct mptcp_pm_ops named "mptcp_pm_kernel", and register it in
mptcp_pm_kernel_register(). And define the userspace path manager as
a new struct mptcp_pm_ops named "mptcp_pm_userspace", and register it
in mptcp_pm_init().

To ensure that there's always a valid path manager available, the default
path manager "mptcp_pm_kernel" will be skipped in mptcp_pm_unregister().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c           |  5 +++++
 net/mptcp/pm_kernel.c    |  7 +++++++
 net/mptcp/pm_userspace.c | 10 ++++++++++
 net/mptcp/protocol.h     |  4 ++++
 4 files changed, 26 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index f4948a2cf9be078043bd237f56a57c27804ef4db..3896f21a46bd7f6912d2ffe22a3984ba97923021 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1018,6 +1018,7 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
 void __init mptcp_pm_init(void)
 {
 	mptcp_pm_kernel_register();
+	mptcp_pm_userspace_register();
 	mptcp_pm_nl_init();
 }
 
@@ -1061,6 +1062,10 @@ int mptcp_pm_register(struct mptcp_pm_ops *pm_ops)
 
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops)
 {
+	/* skip unregistering the default path manager */
+	if (WARN_ON_ONCE(pm_ops == &mptcp_pm_kernel))
+		return;
+
 	spin_lock(&mptcp_pm_list_lock);
 	list_del_rcu(&pm_ops->list);
 	spin_unlock(&mptcp_pm_list_lock);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 806a9b5b3c07a350c20ec7085183c26af9f50d44..d39e7c1784608db290b8a2c1bc4fc24ed800cbb4 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1398,8 +1398,15 @@ static struct pernet_operations mptcp_pm_pernet_ops = {
 	.size = sizeof(struct pm_nl_pernet),
 };
 
+struct mptcp_pm_ops mptcp_pm_kernel = {
+	.name			= "kernel",
+	.owner			= THIS_MODULE,
+};
+
 void __init mptcp_pm_kernel_register(void)
 {
 	if (register_pernet_subsys(&mptcp_pm_pernet_ops) < 0)
 		panic("Failed to register MPTCP PM pernet subsystem.\n");
+
+	mptcp_pm_register(&mptcp_pm_kernel);
 }
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 13856df226736727783a27fc0932a0003aadd8ee..2cb62f026b1f4420c549ab8ee6f54ffe3880d453 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -682,3 +682,13 @@ int mptcp_userspace_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
 	sock_put(sk);
 	return ret;
 }
+
+static struct mptcp_pm_ops mptcp_pm_userspace = {
+	.name			= "userspace",
+	.owner			= THIS_MODULE,
+};
+
+void __init mptcp_pm_userspace_register(void)
+{
+	mptcp_pm_register(&mptcp_pm_userspace);
+}
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ac8a178426e4ef495d7c5b5b9bd4c8b8835d71e4..c9e435a1fd7c7ab22a279c6de7c1573fe45cee98 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1050,6 +1050,9 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_
 void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 				struct mptcp_pm_addr_entry *entry);
 
+/* the default path manager, used in mptcp_pm_unregister */
+extern struct mptcp_pm_ops mptcp_pm_kernel;
+
 struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_register(struct mptcp_pm_ops *pm_ops);
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops);
@@ -1158,6 +1161,7 @@ static inline u8 subflow_get_local_id(const struct mptcp_subflow_context *subflo
 }
 
 void __init mptcp_pm_kernel_register(void);
+void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);

-- 
2.48.1


