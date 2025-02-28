Return-Path: <linux-kselftest+bounces-27912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 739E1A49C3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 15:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CBCE3A80C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 14:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACB62755E1;
	Fri, 28 Feb 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjL5juOd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6B0274276;
	Fri, 28 Feb 2025 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753560; cv=none; b=EmRID7VjrffK4ZvUBjlWg6cNqfPsb+MKivzcuqFBAXCSYdSv99fdsJs+JTrpzBP3xgHWeBNnHrEt8B72kTRQ8in2ALqQ+O6iBe0PGTAFS9ssr20RC3uuO3bKim0WLa6IA5cbvDrg3IBwEuZHzHjskQcVxueI1Km29XwukSjW1E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753560; c=relaxed/simple;
	bh=qd5Hx+b04eodl3pyAKUj3non7RIQIXEm2HBEpyB2Mtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X1y0PHThAY1GQu8qEfRDQyc6IQlKbolHwFn43cY+d8ypkYDEA6Ad/mt0offGytNr1FfacIUt2NJw6zio24fWBoewDqaYPKkoAKWYvmYDFlRfAX/keKOpYmJsZS6jAlvNdKokNSTZlWqOhhX+dvFFTLAMyoWh7vuN2rOiDq6y2XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjL5juOd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E985C4CEE9;
	Fri, 28 Feb 2025 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740753560;
	bh=qd5Hx+b04eodl3pyAKUj3non7RIQIXEm2HBEpyB2Mtg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gjL5juOdjhNiffaQnvoZA/5O1CZ5Zc0QVZaaanQNUaVEWwBYVPBYtaDqhLkrb/hJ/
	 Ns4wIVfwLrZlYds7T+fZOBnn6sodWU9yVIxmLZjU/4raK+849IhEu9vzxXkIMRb+s/
	 0cq5QdmqtVOAmU2jB8qpZeDybCnCrRAZAGnxgv4x8aRAxC6mwdaMJf0p87cLFAV6iF
	 2kdcyUzX0VGfsTncmLg7nnievmt4rfWP+DGzEWoXejpwuNsSFT7DCcP1ECFdeW+0fq
	 +LeXBFAvPkbILRS8n/DJ8jVkoW9NGnMb35mjPge3IU1VWVLsctZahhBRPcrSQwaJOv
	 grbQnUzGWezTg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 15:38:39 +0100
Subject: [PATCH net-next 5/5] mptcp: pm: exit early with ADD_ADDR echo if
 possible
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-net-next-mptcp-coverage-small-opti-v1-5-f933c4275676@kernel.org>
References: <20250228-net-next-mptcp-coverage-small-opti-v1-0-f933c4275676@kernel.org>
In-Reply-To: <20250228-net-next-mptcp-coverage-small-opti-v1-0-f933c4275676@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qd5Hx+b04eodl3pyAKUj3non7RIQIXEm2HBEpyB2Mtg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwcqFRGWhiK+FmMNzI5GxPtdFL4gcycU+ET7Ve
 UyUuRGVIByJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8HKhQAKCRD2t4JPQmmg
 c3N/D/4jcKzyFYnI5GE2aFSqdSEmywcQQ2plQvMZxTIx8OxQlDE7WRHFCeZvXbOC6mm8X20wb5M
 BoUk9yTJyVdlPVf0wJFOBtyBNAqcTXy6GYnhmeHVKqReB24J1oxnNxStlSGefYURTzwgHNfIpDg
 +tgy7RLESh68oo0LoYv5TsmixZLAOu+59DnNy4de9FQlkIi89DqFEkzhl+xDfRWuG31H5ha0JqA
 FkOCU3WfwtY3unE5KOgpb3eapb8REspvdX2qm7ACT/roYSRhKwIgfBRYGUpLTwHLdIuOxIpCLmn
 4UVtKhEXkGr2BiWTlZnxtY+YWAwK7pP5KFKT47H4/quEvjzoDl1uB13OQyt8yZXQr1tB6U80aeZ
 uje4epxSYc2NZXELZO5SIGn9SSxYwiYCHmu03ZQXe7zLLVY0QIKTiLrI4YyhmxRJAFRnPt/jpTl
 1SILxV38Lpcb7dST3OQ6LzYFPXQ0NJm4iuqydU3ncVkT53e16fw03bx3Ao1zM3HYCnkSXMMV7lS
 028NbpKSKG236apoqO3iRvxVzm/ObZsJNB4nUvgKzkfLRChik1iaST3kTI5bhNNFA227soOVIHD
 E/zp+AvLN4uiivGg/vU36K6iZ28Aps+rD6s4Sm2/QjFNEoOk1LmQ71clUOsSGKRadgKDVWp+WrW
 VJu2rIp4zvLSZ8g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the userspace PM is used, or when the in-kernel limits are reached,
there will be no need to schedule the PM worker to signal new addresses.
That corresponds to pm->work_pending set to 0.

In this case, an early exit can be done in mptcp_pm_add_addr_echoed()
not to hold the PM lock, and iterate over the announced addresses list,
not to schedule the worker anyway in this case. This is similar to what
is done when a connection or a subflow has been established.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 16cacce6c10fe86467aa7ef8e588f9f535b586fb..6c8cadf84f31f4c7dcc38b787beda048d5362dc8 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -251,6 +251,9 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	pr_debug("msk=%p\n", msk);
 
+	if (!READ_ONCE(pm->work_pending))
+		return;
+
 	spin_lock_bh(&pm->lock);
 
 	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))

-- 
2.47.1


