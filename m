Return-Path: <linux-kselftest+bounces-14305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC1093DE8F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 12:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CE25B232CF
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 10:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4C5757FC;
	Sat, 27 Jul 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOuWBRU/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65302757F8;
	Sat, 27 Jul 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722074613; cv=none; b=OiPKtmm2dOgQMKdZWuQgU5FbowwVOpc+nTSOqJVJwlq1lbMaY8/zUTy5jeIOBw6a0BsPC2bn4uB39Nhj2SIPhcS5eyB/uYQFJHkeZ+RX/m9MI2D5GHOh/vOJd5hJFF9LNZVkqSQ5kv6hyEs2zEGLTjjrl0Rd1zPvpzhjmo2OUOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722074613; c=relaxed/simple;
	bh=C5TD7jO5JZLbE0mArucprAaXqsRm106ZTDt0FgoYp8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M3cxs+slyZ/jpS8Gcu8PbPmfyN0q7DAETB6QTbhk0lI0wuZT2xOZmmiePMy8iVnkwmjflTsaT6huhvpJJuJC84MDXmSowPZQxb0VMLKTlL487N6jkX8olEKkEpjeSw9vX56O7wj9wOc3HTjYLCzmKEsGBY7Zy/TmBDYFJFqsVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOuWBRU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F35C32786;
	Sat, 27 Jul 2024 10:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722074612;
	bh=C5TD7jO5JZLbE0mArucprAaXqsRm106ZTDt0FgoYp8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tOuWBRU/eh9emtwVWPZ35lmnByrz3jSdTxs+94uyoNe1TX5SF2aJ8MvfL9QdS0vt7
	 ImgAaTXS2uyBmpbvxNOqsdI8GJd5U/vgVRvnbzRXOSNEPdViXlD2XPjdx03Sn+pBZJ
	 mi50j/GWcWYSm64Pef/AMh7c4F4jeG7tQlVu08n5+QNy/yHXEr9hXTIYJprgVhF4zS
	 2l3z/JbNKc8q/WXSSUigIX/r2oLwy2CG39xaKzOiK+4tuIhsQsa8KE+O/P4iML0Psh
	 TL37fXVi27ddW159Vn8fgZV5P2bD/HJ+1opulaD3/HUwfwLfFSyBgnV2mKAvI29o6Z
	 FFsQudaDZH21A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:01:25 +0200
Subject: [PATCH net 3/7] mptcp: pm: only set request_bkup flag when sending
 MP_PRIO
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-3-f50b31604cf1@kernel.org>
References: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
In-Reply-To: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=859; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=C5TD7jO5JZLbE0mArucprAaXqsRm106ZTDt0FgoYp8E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMXlxIUksVKZwR1M+GSCTA+PtKUrIMDwE0Ryr
 ZXNfEPvSoCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTF5QAKCRD2t4JPQmmg
 c/FdD/95Dnlp8mvqRewQNqChUwtjrTLHhVcEDguBcEksevqd2dSVCaa4vbSLx8CRBCSWJ7WP4ls
 mBd4KOeZNJ/DxpWyQ0AZ+xTeVgdWpIHydKeKEbM3liRWPYbNJ37/6cm3fGVIBkP9ilJ5qaXZG2X
 9cYfsMBtXdonFCWE/VUhF5nljIY8bpwXm29//jMaaYmSDOErzpDaUWEjTgK+dy6OI64+56JDQ7A
 kY3pPXq9PXINTIn+C9p7hXIZ/FS5xhhLttZC4QZQ+CtrLrN4X0O14VB/Xju4u4LG6+VdULDv+RK
 hyxvq6TXChr+sRt6bDcK9aLHkl50/w2Nf1cnMVy2m+rwAbDRpmaN3dcUIEGu52RR2QmlINN/uHf
 Qy5I05DsZIF0yyWTbiuAfGvxoZ5IiUdLGF/IzjtC8OYIYLoTykblzKNnaFgayCZCMhHJBDbJN/O
 Kxsxadj9W+O1ytvtejskMcz4LUo7TfAsE8R1wGFt9Gdb6ALVkxCO4Z/EaavO9TrNNnW2RdHKdHv
 NgrjOUO/vjBS5Zl++lHm/nbEVkbfP0jX1tTLTewp1zI0VXUQv32NZX2zxJR+mPL3kUYLTzCxP6b
 40eGiC09xmIcYIkA6Y18ewdYaH8PiN8+P0I5+2+ng7xPlaXtOjSKiW8A3GKjdKrfO6VjRPcGiM5
 tx+RyzDOWNiFvrA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'backup' flag from mptcp_subflow_context structure is supposed to be
set only when the other peer flagged a subflow as backup, not the
opposite.

Fixes: 067065422fcd ("mptcp: add the outgoing MP_PRIO support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ea9e5817b9e9..59527335c68e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -471,7 +471,6 @@ static void __mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_con
 	slow = lock_sock_fast(ssk);
 	if (prio) {
 		subflow->send_mp_prio = 1;
-		subflow->backup = backup;
 		subflow->request_bkup = backup;
 	}
 

-- 
2.45.2


