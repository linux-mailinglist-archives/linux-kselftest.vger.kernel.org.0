Return-Path: <linux-kselftest+bounces-14297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B8193DDF7
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 11:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0933B2287F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BE157CA7;
	Sat, 27 Jul 2024 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smG1ejq7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1675644E;
	Sat, 27 Jul 2024 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071076; cv=none; b=eCLqHe1yIZNLRmeiQkM9oIxCGShzKPQ/hDjZXWLlUoUTbk4/rFaPcGtHeh7D+ovc4W/HNtHf0a6VR3COkbx58toRnw3V8B8mYx8JJlM/yiT9cOgLmcx8BLH/1XR/hjwWQmySq2yclHDlCskxSZLunFKYcn2cEszIopLTxcM9qhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071076; c=relaxed/simple;
	bh=SpiGDFVVItBkk2hUaR++T+dqgnkf1BKqsH2W3d4BbxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p8qxBEm4knx2wXhZbUQ7gZJxY1N0yf2EjJuLxBmpyAIxlfvygUd/riCXgMhfK3Z1womMRYAphAB9x14IAoqWcmJVQcHJO3csP6GOa0ji6iVtzKIhNKkq7GAkmdLYxJy7JmZ/Vz3hIT2OKHcDA16IcafWKroGxa7RzewFBiueORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smG1ejq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBBCC4AF09;
	Sat, 27 Jul 2024 09:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722071076;
	bh=SpiGDFVVItBkk2hUaR++T+dqgnkf1BKqsH2W3d4BbxA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=smG1ejq74bTlNov3jNKz5q7iTIVDu5KwMGgseSluI7fkXkspa6ZMzErxqnzPbFsLp
	 WZaSlIz+2sT6F3UjMB3yA+kGaLEr6lImBRkAj2nTcsGvX/wzeZ4jsn9uCuwUm4/VvU
	 PrOFiq2qXfaux/SoNS5wnU96Os/3dARRdjAQxRnmpPOwZLyl+UJagmnXXDRhLD/br+
	 SPPWx/np/1tF0kzlzCCN6tqUieb8hdPBhnWGUrUFyC0b8qZSwBwcD9vHRDTY6FIJy9
	 Q4ckPedWIMFEDfr16HcTwdRX+uu3jAsfx/x6g2MAxJe2VB2aAL34aEKTi8hJ3+a8A9
	 MooDG50Q8fz5A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 11:04:00 +0200
Subject: [PATCH net 2/5] mptcp: fix NL PM announced address accounting
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-2-1e7d25a23362@kernel.org>
References: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-0-1e7d25a23362@kernel.org>
In-Reply-To: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-0-1e7d25a23362@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=T66oV6CP4f0kaix+xkHtdBR+09B9n+xPUh6tQPDiSEk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpLga8+q3SbPbXlwi0Bl7uRvL8dbXdv4jDKYZS
 BOx3GEbKL6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqS4GgAKCRD2t4JPQmmg
 c8SxD/95W4XuNVPXDAq6pIt5eCIYrBUbMHELrjygkm25so6nWCZZuwd+QEjEmVQTBQCrVEJqhOI
 8tC0HNeMZ3Zc/zCRrT10mcYvksr1ZOPpeKOaM/mkrkQGp4yql9fXBLVOBbLAgxHTesc3ych1Z1M
 H8HG/WELaYTXFaX5PiU7Ah06b4sOS7AOSNfVUhZvwZjfZa0XYGx+IincULP+PwFRTYFeVXLsD3e
 FKaxaXzVwexRlxd22kp0iOfkf8j/zKmVDknH9Koer/H0pwQ2TaZgbwBtHa6GoSXqtfXfK+znuVY
 Wxe5ENkZcMoAVB3gKy3BKS134kUxg9iS5H7IrbOmIxB8kizdwAgH1mxND9lXCjXhlPKpm2bSHMj
 V+mETzJwLShS4LwW6Z2Hk8Xr8kvQ3pnAStv1JJsz+DdN5p/Y+YvSlFigk1QdzCgLEznSDZlodQ9
 1TpZxMVg5oie+Co+Uy6Mcu6eSQ4gFQmTHXfUxNlSjH8i5O/y7XhN8ogbMbXcZbbGqMDmvnIoBwo
 NEkSfte6sULvI/eJyDqwauGzJ3mmIShYinlrrTo0BmPY2mvLVMXwLRe3s3gP9gKBERRPiF6hTFI
 Bxx86HwLcNxdwpjnXSZbDFLtV1IfJnSHvSLqVw5wUF8VEtbZFR4mKxK7s/Qz7w8qxIqSEaXavZQ
 /7shxohN6IBfaoA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Currently the per connection announced address counter is never
decreased. As a consequence, after connection establishment, if
the NL PM deletes an endpoint and adds a new/different one, no
additional subflow is created for the new endpoint even if the
current limits allow that.

Address the issue properly updating the signaled address counter
every time the NL PM removes such addresses.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b399f2b7a369..f65831de5c1a 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1401,6 +1401,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= ret;
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
@@ -1565,17 +1566,18 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
-		    slist.nr < MPTCP_RM_IDS_MAX)
+		if (slist.nr < MPTCP_RM_IDS_MAX &&
+		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
 			slist.ids[slist.nr++] = entry->addr.id;
 
-		if (remove_anno_list_by_saddr(msk, &entry->addr) &&
-		    alist.nr < MPTCP_RM_IDS_MAX)
+		if (alist.nr < MPTCP_RM_IDS_MAX &&
+		    remove_anno_list_by_saddr(msk, &entry->addr))
 			alist.ids[alist.nr++] = entry->addr.id;
 	}
 
 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= alist.nr;
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}

-- 
2.45.2


