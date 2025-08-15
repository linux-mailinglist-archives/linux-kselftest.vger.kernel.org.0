Return-Path: <linux-kselftest+bounces-39112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6151EB28501
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 19:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4843AC7C2D
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF8E30DEA0;
	Fri, 15 Aug 2025 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPaO5xtn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3130F530;
	Fri, 15 Aug 2025 17:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755278934; cv=none; b=GRCZMNKZdzm8n1ZvLdw6LJE8aT/BI7khzuMEgdDaNowngQGd6UTQxXPqkVGPkWSZ8ebqBIxhsctc4re5uvJ5j7XdE3lKYsVVz2Ep7qT5yDjEWi+mq2hzTC68Im4VV5lKTQZ3+Yc17L8p6zR0mP5lKZV6y30/SYCWipNecwF7QnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755278934; c=relaxed/simple;
	bh=ztDCln7jBtzQR3343136FV3STkEDzGIsbFAfGPVrCzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNkAelSITUjMfFbJxJxDeC+qCUQytqkhpo4mXPDxatZNi2uAhvY+cr7jkHmwpbkGvAo1DIyl57OkBFgVpDpH0U2lMygXYBJleFJArSunkMSh47ZlMJTODOdalJjmJMIs7+ChtjnDAQEkxgK8ZyhyPKce9Vte/5f5Q1DR52tbxoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPaO5xtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913A2C4CEEB;
	Fri, 15 Aug 2025 17:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755278933;
	bh=ztDCln7jBtzQR3343136FV3STkEDzGIsbFAfGPVrCzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YPaO5xtn4cciDNTvb3yUUs2ApkXwHVxq4P8GQVU7TW5k/3+ybhulhp9CSghZO9FaW
	 7dW/mX+6SR/hTdW6nItfPCjXGbwipCdSpnwVm80ryiZO9y+zcer03cALc2omRnLq9J
	 DwY1GjbhDqyoLMpb2CvXaEkWRUlo2SW4KEzRb8S1008kTiCVshP4Fv2t7dqg/j8PUJ
	 Gxuaf8uERnNt2TTsqNqN5RODIbksLYj76Ten1BbZW6xfm5YV3vuGjNW1mPQk5zx0/H
	 3tuRVViuICzNqzo/5FJz/Wk1iQjgEyPLZinJRNqFoAvCrDOT+iz5H1zMvi/6VSwCnA
	 aUUbS+dUJMH9Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 Aug 2025 19:28:20 +0200
Subject: [PATCH net 2/8] mptcp: pm: kernel: flush: do not reset ADD_ADDR
 limit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-2-521fe9957892@kernel.org>
References: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
In-Reply-To: <20250815-net-mptcp-misc-fixes-6-17-rc2-v1-0-521fe9957892@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jianguo Wu <wujianguo@chinatelecom.cn>, Shuah Khan <shuah@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, zhenwei pi <pizhenwei@bytedance.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Thomas Dreibholz <dreibh@simula.no>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1234; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ztDCln7jBtzQR3343136FV3STkEDzGIsbFAfGPVrCzw=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLm5zlpb1VKEfsrPEX0CNcXjhrRFa8KXbffdJo16d00c
 00J8cveHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNRfM3wvyx/uciblc6+TAVf
 /9jkGHb9CH4gGXRu1d4wJ/+LSsu+XmL4ZxAd0j1T+mbvitf6nEazTDTO15xgOvvrc4+95WH/f7u
 N+QE=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A flush of the MPTCP endpoints should not affect the MPTCP limits. In
other words, 'ip mptcp endpoint flush' should not change 'ip mptcp
limits'.

But it was the case: the MPTCP_PM_ATTR_RCV_ADD_ADDRS (add_addr_accepted)
limit was reset by accident. Removing the reset of this counter during a
flush fixes this issue.

Fixes: 01cacb00b35c ("mptcp: add netlink-based PM")
Cc: stable@vger.kernel.org
Reported-by: Thomas Dreibholz <dreibh@simula.no>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/579
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d39e7c1784608db290b8a2c1bc4fc24ed800cbb4..667803d72b643a0bb98365003b136c53f2a9a975 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -1085,7 +1085,6 @@ static void __flush_addrs(struct list_head *list)
 static void __reset_counters(struct pm_nl_pernet *pernet)
 {
 	WRITE_ONCE(pernet->add_addr_signal_max, 0);
-	WRITE_ONCE(pernet->add_addr_accept_max, 0);
 	WRITE_ONCE(pernet->local_addr_max, 0);
 	pernet->addrs = 0;
 }

-- 
2.50.0


