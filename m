Return-Path: <linux-kselftest+bounces-42299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC45B9EB27
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8032B3AFE17
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8CC2F99B1;
	Thu, 25 Sep 2025 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No7cmjTV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0A52EDD5F;
	Thu, 25 Sep 2025 10:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796416; cv=none; b=DSFiXU/vHuxcCM9rvyv96LXi6cOJjv/bA0JpFyHFtMXkoMjcS5jwzTuxEknEKg0eQyD9AK7+hQrF9DSJu9pXYve0F1m/+mbISVU17s6gQTmp3QSMKSDjzDYjEeOFFYgIckTRdnLqe1pbm5SaUAOGFiqRPe4u2ss4A/oUqVHWV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796416; c=relaxed/simple;
	bh=IFBQCbyLfAZ1gA2VmVTuO4yj8ytiYbgs/6Gs0NvznfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SoeXknY0izW/Lj7jSa259FzZQIzcc6QsOT3X8rB6F3ExB1S+c4ey+H820rNyb2TytcGDuXUmNJncQO/fNpzbAAvhI8KyJv3/DvJ29jDJwQL/7emllWGO+BoLD3NUoLn+Vn7LRSawiyXFRlS6v320Fk+bRafapWghXBZMpR/LLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No7cmjTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA10C4CEF0;
	Thu, 25 Sep 2025 10:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796415;
	bh=IFBQCbyLfAZ1gA2VmVTuO4yj8ytiYbgs/6Gs0NvznfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=No7cmjTVTOcnDfZ11JKLmxTPJglOMqvwawfR7VHDEBZl2s6Vc0r0UXEGiWjoKTaIj
	 x9D2CExlb5eVGdSX+5QuvoE6d8XpiodpIQvYG4EdZY1widi8xxTLE1bmjE0C8VSdT8
	 9kVVkcuxksLzhxsppmlBX7xokmGy8ev/a7XoLjNceVSb9ApRAh2jNLLwMLrTDBVgD0
	 P1cT+v7YHV1P/6XxXDd0ngNrGbB1LqAQSzYrlhOG7VEnzxY+yIKIyOjMldZvQIJCIA
	 emf79QasrfRZZBFYzoXaHmWl8190u3P4/z6n9l5dR9pmEURi8TfxuD0ryAm485Dy5n
	 P9ixBh4LRd03w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 12:32:42 +0200
Subject: [PATCH net-next 07/15] mptcp: pm: in-kernel: rename
 'add_addr_signal_max' to 'endp_signal_max'
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-net-next-mptcp-c-flag-laminar-v1-7-ad126cc47c6b@kernel.org>
References: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
In-Reply-To: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7459; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=IFBQCbyLfAZ1gA2VmVTuO4yj8ytiYbgs/6Gs0NvznfA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuSkU/mCr8ds7a3As/pzWz7820+Htuqki7RUdKTHOO5
 MxHRx95dZSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEykq42R4dj5WR8yn74O/hZt
 XPzwFXP1o+uq95aXbJm7U+C0lufM2cmMDM92Mp16u31nzymF1IT8hzu2e99Yu8Jn59m0CQpNc0S
 P8rMCAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A few variables linked to the in-kernel Path-Manager are confusing, and
it would help current and future developers, to clarify them.

One of them is 'add_addr_signal_max', which in fact represents the
maximum number of 'signal' endpoints that can be used to announced
addresses, and not the number of ADD_ADDR that can be signalled.

While at it, add an additional name for the corresponding variable in
MPTCP INFO: mptcpi_endp_signal_max. Not to break the current uAPI, the
new name is added as a 'define' pointing to the former name. This will
then also help userspace devs.

No functional changes intended.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 include/uapi/linux/mptcp.h |  1 +
 net/mptcp/pm.c             |  2 +-
 net/mptcp/pm_kernel.c      | 26 +++++++++++++-------------
 net/mptcp/protocol.h       |  2 +-
 net/mptcp/sockopt.c        |  4 ++--
 5 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 314200c61f150da445ff87debb154bfd98f324fc..69fc20db1c2f731d5f93cfee4e58a23119ff7a97 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -48,6 +48,7 @@ struct mptcp_info {
 	__u8	mptcpi_subflows_max;
 	#define mptcpi_limit_extra_subflows mptcpi_subflows_max
 	__u8	mptcpi_add_addr_signal_max;
+	#define mptcpi_endp_signal_max mptcpi_add_addr_signal_max
 	__u8	mptcpi_add_addr_accepted_max;
 	__u32	mptcpi_flags;
 	__u32	mptcpi_token;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 502f6c235e06c3f6fdca9dcf3a1d7b8e97fb9df6..1100ba8b1ce8243de46b161fb27272c360559bc3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1037,7 +1037,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 		WRITE_ONCE(pm->work_pending,
 			   (!!mptcp_pm_get_local_addr_max(msk) &&
 			    subflows_allowed) ||
-			   !!mptcp_pm_get_add_addr_signal_max(msk));
+			   !!mptcp_pm_get_endp_signal_max(msk));
 		WRITE_ONCE(pm->accept_addr,
 			   !!mptcp_pm_get_add_addr_accept_max(msk) &&
 			   subflows_allowed);
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index db0d254d0e6b903fd8b920eb4cda628a811f7d58..740f0b20b941fc457831f3394c187159e9a244e8 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -20,7 +20,7 @@ struct pm_nl_pernet {
 	struct list_head	local_addr_list;
 	unsigned int		addrs;
 	unsigned int		stale_loss_cnt;
-	unsigned int		add_addr_signal_max;
+	unsigned int		endp_signal_max;
 	unsigned int		add_addr_accept_max;
 	unsigned int		local_addr_max;
 	unsigned int		limit_extra_subflows;
@@ -46,13 +46,13 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct genl_info *info)
 	return pm_nl_get_pernet(genl_info_net(info));
 }
 
-unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk)
+unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk)
 {
 	const struct pm_nl_pernet *pernet = pm_nl_get_pernet_from_msk(msk);
 
-	return READ_ONCE(pernet->add_addr_signal_max);
+	return READ_ONCE(pernet->endp_signal_max);
 }
-EXPORT_SYMBOL_GPL(mptcp_pm_get_add_addr_signal_max);
+EXPORT_SYMBOL_GPL(mptcp_pm_get_endp_signal_max);
 
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk)
 {
@@ -275,15 +275,15 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 {
 	struct sock *sk = (struct sock *)msk;
 	unsigned int limit_extra_subflows;
-	unsigned int add_addr_signal_max;
 	bool signal_and_subflow = false;
+	unsigned int endp_signal_max;
 	unsigned int local_addr_max;
 	struct pm_nl_pernet *pernet;
 	struct mptcp_pm_local local;
 
 	pernet = pm_nl_get_pernet(sock_net(sk));
 
-	add_addr_signal_max = mptcp_pm_get_add_addr_signal_max(msk);
+	endp_signal_max = mptcp_pm_get_endp_signal_max(msk);
 	local_addr_max = mptcp_pm_get_local_addr_max(msk);
 	limit_extra_subflows = mptcp_pm_get_limit_extra_subflows(msk);
 
@@ -312,11 +312,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 	pr_debug("local %d:%d signal %d:%d subflows %d:%d\n",
 		 msk->pm.local_addr_used, local_addr_max,
-		 msk->pm.add_addr_signaled, add_addr_signal_max,
+		 msk->pm.add_addr_signaled, endp_signal_max,
 		 msk->pm.extra_subflows, limit_extra_subflows);
 
 	/* check first for announce */
-	if (msk->pm.add_addr_signaled < add_addr_signal_max) {
+	if (msk->pm.add_addr_signaled < endp_signal_max) {
 		/* due to racing events on both ends we can reach here while
 		 * previous add address is still running: if we invoke now
 		 * mptcp_pm_announce_addr(), that will fail and the
@@ -699,8 +699,8 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		pernet->next_id = entry->addr.id;
 
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		addr_max = pernet->add_addr_signal_max;
-		WRITE_ONCE(pernet->add_addr_signal_max, addr_max + 1);
+		addr_max = pernet->endp_signal_max;
+		WRITE_ONCE(pernet->endp_signal_max, addr_max + 1);
 	}
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 		addr_max = pernet->local_addr_max;
@@ -1098,8 +1098,8 @@ int mptcp_pm_nl_del_addr_doit(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SIGNAL) {
-		addr_max = pernet->add_addr_signal_max;
-		WRITE_ONCE(pernet->add_addr_signal_max, addr_max - 1);
+		addr_max = pernet->endp_signal_max;
+		WRITE_ONCE(pernet->endp_signal_max, addr_max - 1);
 	}
 	if (entry->flags & MPTCP_PM_ADDR_FLAG_SUBFLOW) {
 		addr_max = pernet->local_addr_max;
@@ -1185,7 +1185,7 @@ static void __flush_addrs(struct list_head *list)
 
 static void __reset_counters(struct pm_nl_pernet *pernet)
 {
-	WRITE_ONCE(pernet->add_addr_signal_max, 0);
+	WRITE_ONCE(pernet->endp_signal_max, 0);
 	WRITE_ONCE(pernet->local_addr_max, 0);
 	pernet->addrs = 0;
 }
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4c777f87b0497ed623f0d51bf1f87cfa011cf0eb..86c30cd6c1f2ceccba9d14ddac7e6334dd46e21b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1180,7 +1180,7 @@ void __init mptcp_pm_userspace_register(void);
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_worker(struct mptcp_sock *msk);
 void __mptcp_pm_kernel_worker(struct mptcp_sock *msk);
-unsigned int mptcp_pm_get_add_addr_signal_max(const struct mptcp_sock *msk);
+unsigned int mptcp_pm_get_endp_signal_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_limit_extra_subflows(const struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_local_addr_max(const struct mptcp_sock *msk);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 4e82bcfcd34e3a1dffb05799cf181ee2940e75d7..4688e0f25d15d9363b33bdcf3ad75c8295a810e3 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -974,8 +974,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	if (mptcp_pm_is_kernel(msk)) {
 		info->mptcpi_limit_extra_subflows =
 			mptcp_pm_get_limit_extra_subflows(msk);
-		info->mptcpi_add_addr_signal_max =
-			mptcp_pm_get_add_addr_signal_max(msk);
+		info->mptcpi_endp_signal_max =
+			mptcp_pm_get_endp_signal_max(msk);
 		info->mptcpi_add_addr_accepted_max =
 			mptcp_pm_get_add_addr_accept_max(msk);
 		info->mptcpi_local_addr_max =

-- 
2.51.0


