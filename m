Return-Path: <linux-kselftest+bounces-5751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E66286E81E
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C051C21223
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEF436137;
	Fri,  1 Mar 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGedMBzH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9D38F9B;
	Fri,  1 Mar 2024 18:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317115; cv=none; b=C7D9S5DuVlfyI/aGkASHPr5wLjAFjtfY92LTZvIEGKXCz4eV2mDk0aZV+TI3IqG4pBTgiIAnr//0R+l0+En5ak90FCXtPNklSOf1RBNNVKHTDp+XpH6yCiVmSYy0l5XMlPrmqTES04pOSUiet+KY3U+uAlbCIyxIJOduwc65vZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317115; c=relaxed/simple;
	bh=nt6AK20BL5oE7VRdGXzhIfQmFT8Y3Oo0oEL80YyLgpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CWCyv5n/G74BUBYkJLGipL94EOaAdK67/RQSs0IY1KElv7kb7ukXM+/zTfmZkPqoUfUOx2fRiowLsZGgURF7cTgjWDUjYrVNoLHI/EpeyRakqU/pi6It3DGIivJw8ffqw70giDSIn7N09mRpxsP9+14pK+2UG1F9mU6v6Oo1skU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGedMBzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99129C43330;
	Fri,  1 Mar 2024 18:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317115;
	bh=nt6AK20BL5oE7VRdGXzhIfQmFT8Y3Oo0oEL80YyLgpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MGedMBzHzZeeUXKNXA4pbwd9tulDraVf9ElmbbZaX31Tu4/ngP3JM0xIIaWp0Akzm
	 bpYi9Go0reS2dlilCOtLGjeYQnvOac0qLoiMR7ZJjNo2U4T9mATmx0f3NzW6F9tqwD
	 wofrPNtqKC4UB5YszEGnF0RU0ZE1emVh76TbCS3ir3tyAeuziuUjrOtqmtwxYbALjR
	 FCBSQ3lr9fTurFNlcEBWlOkEXiRjdcbGTzCZ9cBxrGwhadw1bv+k1YSeOUf1jHmIlA
	 FFKogXZaAvBdz5+z3JQAhHOSzd46O/XxcLOWeMlQzxqgmntnzQfMC6Du9nqqs5hEZQ
	 WTqQQ5uWLp8ZA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:25 +0100
Subject: [PATCH net-next 01/15] mptcp: make pm_remove_addrs_and_subflows
 static
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-1-dc30a420b3a0@kernel.org>
References: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=AYZiynLgRUai+yID1XvGhwLbyUgBmTsv+wmTY6d7j1k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hv0xChc9yYB8ar5v7m2sV4b4QOwB2y8ncWKi
 5fPZzqqOZeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIb9AAKCRD2t4JPQmmg
 cykdD/9zcobt34JTrByyeA1zmI504Wl+lTcEYdTDQKK2spFDNgy6NYB6b/Z5uCPGYZFzngjCAGb
 JSBKl/ze7FLssmtStNtKdxrGZdGVJsX/d+/jaKNpPETzlYiZz8DWldWF422PRHNVDOmOnCyba1R
 wDr1IT8/Nooh8hjzh4B7JjsErJLg9FODPalwCQ1SSAMEXS2Sj6Vf4StKlczQXik8E9YEeo9qgwh
 Uv2orFVmKdYxOWAcAR9nMBXienMI7BmtPBP7dTnHmHNJe3fOFNZQ/PVHm4NwPNDVJreha+WbE0h
 xt+RDPQqt/qZ54vd43IjF9gyrGaWD8dafn7OKNniVbhFWi+sVGTqCq9n/tNCUI7/TU6hh2ctp1I
 gsMi4CTxGlX5roM3FjcEh5mwOGNA+Qzw2FV0ks3TacRqlB52mZAXJKUoRQhbHD6JuCtlHFeTpgV
 DzYCA72293xIQ1SjKTmnv1/K3kH8DslE4Ss6OZAKYk2d4mI3vRn65qH14eItlNuKEUw8EJPnU+5
 YxK4wuy7tNehndHBm2sop6DhV+TnCzOQLiJZ+Yc6GMZh6Xcg2fi6BuELjD9Wc/J5qNdjx0CoMId
 xUcR8fdPVUoTjdF8hzPBra1FWVxRcXWpa2gW3Pzov+SX74PSfRUrte/8bPaYmtK52n2jfG36Zxg
 IpjcdF96MdQfKsQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

mptcp_pm_remove_addrs_and_subflows() is only used in pm_netlink.c, it's
no longer used in pm_userspace.c any more since the commit 8b1c94da1e48
("mptcp: only send RM_ADDR in nl_cmd_remove"). So this patch changes it
to a static function.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 4 ++--
 net/mptcp/protocol.h   | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index d5a942b9ab29..80c537659922 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1550,8 +1550,8 @@ void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list)
 	}
 }
 
-void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					struct list_head *rm_list)
+static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
+					       struct list_head *rm_list)
 {
 	struct mptcp_rm_list alist = { .nr = 0 }, slist = { .nr = 0 };
 	struct mptcp_pm_addr_entry *entry;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d0a7955b96c4..b85d1a8d111b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -959,8 +959,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
 int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 int mptcp_pm_remove_subflow(struct mptcp_sock *msk, const struct mptcp_rm_list *rm_list);
 void mptcp_pm_remove_addrs(struct mptcp_sock *msk, struct list_head *rm_list);
-void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
-					struct list_head *rm_list);
 
 void mptcp_free_local_addr_list(struct mptcp_sock *msk);
 

-- 
2.43.0


