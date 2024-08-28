Return-Path: <linux-kselftest+bounces-16515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E113961F7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D6C288B26
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3320B16A956;
	Wed, 28 Aug 2024 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9BMlxrR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0398915B133;
	Wed, 28 Aug 2024 06:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825723; cv=none; b=oug3Gl4b+QIUUjHoIz1B4n8ZMWtrS2PmbQhh/o0OmWqVsF+LhT2ldRb0uLyl1PVahqxFEfYRiVbb7YMrBHbkKOAJWntjGLNqrt9FOTEWrvZmfkIQyZNc7IRMT1rrKJ09oHYIrexBoEu4z3poGd0dKGS5x5PEsq0XQegxNVc6YK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825723; c=relaxed/simple;
	bh=x2XI6PON5WOQFb6mZEp5Ok89/mO30tFpl7Gk3FKdepo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cb4pGJnPy8Sa91xsYAfen2Nem92jRoMKplNQMAH2DjaQw+RAD1qI7LBgp9BYyGME/ezr3LvHeiEjpM/3+woPznfOlp9M9ko5xdBtmyLpu/p1Uoqfk+F2Y0yOWotEB+gO8igAsyuVP2+nFn5buCpIoTZbZNiOWXYQWCcq5VsBktE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9BMlxrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D7AC4AF65;
	Wed, 28 Aug 2024 06:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825722;
	bh=x2XI6PON5WOQFb6mZEp5Ok89/mO30tFpl7Gk3FKdepo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S9BMlxrRml0V8fM1rpbF2V9LTjqTq4LGSsJ+Ok8rwF8ZZH80Ygvv/oIKkY6yYEYsL
	 /0DnOV5frXICkbrzBjh9RzhS//1r1zTRFakVdSSdIdjhZAC9ZcMZiFP1qGTrjql6PU
	 EZf/3W7eoe7kiNktwACfiTJMacmqZbgAppPcprUvPLmFDona/gU9bPcn784deXmELf
	 h9YQ2UpoKrgEm/T5uUwdUnJoD+9lFFSD1w8z3QrhYgmYvSOrqy9wEkCeTFmKHlt63j
	 MVapvj4jENVKLGmXxsv9iTwAoj8mhxWJLMfsJVCAAm3cKlfWbsRlN3cos+7jxhatIl
	 oaLGc0WBw4ieg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:37 +0200
Subject: [PATCH net v2 14/15] mptcp: pm: ADD_ADDR 0 is not a new address
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-14-7f11b283fff7@kernel.org>
References: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
In-Reply-To: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3331; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=x2XI6PON5WOQFb6mZEp5Ok89/mO30tFpl7Gk3FKdepo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBI5Ogdp3UUOrnKJxfx0erYNh7pOpOWLEWwr
 gDpolORX2SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ASAAKCRD2t4JPQmmg
 c/EtEACe0CP08TTONl4SVkVWq0E7suPu2+U8P9Ugdx46vTINkt46XGOW56MNfn/ZXFD+UqIs73p
 9CVDJnzeIerdIRLKKRiQN39IIVxu4zfGX9mIcxIy/ltUlCm/l7KbCDwN6eaY3VzzmJ8K7uFH27b
 x+P9yl1GSMso2P012APnwlT2AZrvWlCti0PRluNwVYzGWm8VvLZoJoJl/2ItfVmcbfYx9aD1SQi
 EcXUa2YoeHxW7qGJrdmNZijI0FpcR6gVSA+qNOe9stNMxMfJiyYgknnYTRsFJgM2W/AWEagoOU6
 ZGFLBVNAEmsJkKyPlY6o9TwJpG8csu9dZh+4ZTtdXPKwLXOAFlj2PvWpeAKnLH7Oz5elCx39t8k
 wQmwVvy+O9CFvhhtKnZcIR7oVDyloA4Qp0jaOfr5fHxzd1SKJxjrYzaKWTSYoCadYml/3y7+gyT
 imBySSvlKxlJR1nBFWmkYsnr4nngAqooj5K+P3x659zZVDGC5kk2cg1WGJkoBlOwDnup4zBxU/K
 HdWEvhsAk7ns/Ecm6PJaQUCYR4r3VcXaF1jh7wHMomFtcEKhblYwCI7tFBSbG1p5Hxrmb9aT8Br
 FKO/JY3up9mqme2wPHQnfaekpYJywXFrk3EiNhHLnOOMcKGorXD9fQxxUz+0MfusVHTya+hBo9/
 BY7MekPPkIUkmOQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The ADD_ADDR 0 with the address from the initial subflow should not be
considered as a new address: this is not something new. If the host
receives it, it simply means that the address is available again.

When receiving an ADD_ADDR for the ID 0, the PM already doesn't consider
it as new by not incrementing the 'add_addr_accepted' counter. But the
'accept_addr' might not be set if the limit has already been reached:
this can be bypassed in this case. But before, it is important to check
that this ADD_ADDR for the ID 0 is for the same address as the initial
subflow. If not, it is not something that should happen, and the
ADD_ADDR can be ignored.

Note that if an ADD_ADDR is received while there is already a subflow
opened using the same address, this ADD_ADDR is ignored as well. It
means that if multiple ADD_ADDR for ID 0 are received, there will not be
any duplicated subflows created by the client.

Fixes: d0876b2284cf ("mptcp: add the incoming RM_ADDR support")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 4 +++-
 net/mptcp/pm_netlink.c | 9 +++++++++
 net/mptcp/protocol.h   | 2 ++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 3f8dbde243f1..37f6dbcd8434 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -226,7 +226,9 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 		} else {
 			__MPTCP_INC_STATS(sock_net((struct sock *)msk), MPTCP_MIB_ADDADDRDROP);
 		}
-	} else if (!READ_ONCE(pm->accept_addr)) {
+	/* id0 should not have a different address */
+	} else if ((addr->id == 0 && !mptcp_pm_nl_is_init_remote_addr(msk, addr)) ||
+		   (addr->id > 0 && !READ_ONCE(pm->accept_addr))) {
 		mptcp_pm_announce_addr(msk, addr, true);
 		mptcp_pm_add_addr_send_ack(msk);
 	} else if (mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_RECEIVED)) {
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index a93450ded50a..f891bc714668 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -760,6 +760,15 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	}
 }
 
+bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *remote)
+{
+	struct mptcp_addr_info mpc_remote;
+
+	remote_address((struct sock_common *)msk, &mpc_remote);
+	return mptcp_addresses_equal(&mpc_remote, remote, remote->port);
+}
+
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_context *subflow;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 26eb898a202b..3b22313d1b86 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -993,6 +993,8 @@ void mptcp_pm_add_addr_received(const struct sock *ssk,
 void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
 void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
+bool mptcp_pm_nl_is_init_remote_addr(struct mptcp_sock *msk,
+				     const struct mptcp_addr_info *remote);
 void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk);
 void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
 			       const struct mptcp_rm_list *rm_list);

-- 
2.45.2


