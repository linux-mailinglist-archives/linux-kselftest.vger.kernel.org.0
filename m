Return-Path: <linux-kselftest+bounces-16298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0FD95F5C6
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941A71F23F72
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A101198837;
	Mon, 26 Aug 2024 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7iOtKmk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175BC198838;
	Mon, 26 Aug 2024 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687977; cv=none; b=Encoz9yZfwp1DKgo/vTlFij6Nk3lAy2TMI9k1ualvImVlPohjozQFTV2iHabX8ZToUmfD8/mam8uq0k+QxT94z0BFDUO6n2tZgKML1OkyVfaeggZqmPmYMjZgt3vDQWt/S5aJPNNJ7Q56jUE2dArv6CB+cD8uS7fSNtvRzIRpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687977; c=relaxed/simple;
	bh=LmV+esdBEe916xs5xmg/co551PZP2TIQKsdBgoEOmMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OP2w6oWNz+ZYGqz4cxqtyE2/YxPceNuBfaCt+6YoRSjOhO1LM2DqL+3X2dlh3sY1skkJv21E10xC97x64MzzO2NxFWJfv3lqYZHTtddV46K/AgFhFm+Kwb5so+u+64emKMJbwJcGBx/IGNdVkd3lSK/MwkpPjBLUDJEWE85Sz08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7iOtKmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7222C52FFB;
	Mon, 26 Aug 2024 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687977;
	bh=LmV+esdBEe916xs5xmg/co551PZP2TIQKsdBgoEOmMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T7iOtKmkSg6B4lQ7cEcO978h3UBChjmumhptu+sq3ovQwgqU1m4LvojcT12IfSF7S
	 5F+B7cW6plBXkGKxsEjJUwh5Y/CE6XfkOjQcpwzpjKoyRXMR29C7EO8+8hPPTFi2YC
	 Ey/yyQrM8zYmHUekdBzESctJrZF7n2D1IB8jHsYQt1PwDFy/v9fKEP30ME/IdyEeCt
	 XkTy4eaXzZGgwmUcxz1Nnsx3dym/puXauu4kdCDLDyYGW0Mg6wdkku5aqRsn102Jm7
	 +QKsum8bCqlM21dOI4Gm9kvr+OjC90bG0RSrNb7NDUjI/0oxdfkR7+AwrhR18cAigC
	 Hm0OPZcO7nzFQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:03 +0200
Subject: [PATCH net 04/15] mptcp: pm: send ACK on an active subflow
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-4-8cd6c87d1d6d@kernel.org>
References: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
In-Reply-To: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LmV+esdBEe916xs5xmg/co551PZP2TIQKsdBgoEOmMY=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGbMplbIHWKwLX8Sdft9Uv2XLVWRhoOeIQarFY7Tn9jTHVYUy
 IkCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJmzKZWAAoJEPa3gk9CaaBz25cP/iR8
 55pcFzbFM0gPn38CaB48MwOQrqQokz+Cq4D/uc597qbzBvx1EzUSu5QjWIdQjHECKtMFLAWXr4j
 WjjVLsYSOaSu6gC3AOOORqEP/YTQr52hZexu0UzZOnGm0ALJ5LJ5a/n+FYh8WPQKZByFthXPozP
 wHXPmlWpsgTPZYBe6ODSFFKvxclK095Ax0NqlESUcdaEuenfUTTstLFSQjJilbeTQapLcKz4dEa
 u2caRvgJ4UQgG/YTYsH+jS4qPUdfIsXRRBJDX0xKzIuDWMbg/WDGGkpXVhKUYbWAOMg+5OmgtfV
 N7JmvKn+pOdTiMmUrrXjwWw2Gl3Owhb/T9wOc51YlHM3od53g4v0zD9c/SSIcCwKN4R4SYL0Wc2
 qCT3dugEdvLUwxM43CFg76Hj5o8xz4YlRisBC+bmTHOQqe/DTJq56d4fK3bMPzoKTee7Bjq8GYZ
 kOyaIOcg/eTxwafS3JB87gG5jBh29nyJ283Yh+IFKWmNXqcyXT7TYT91lFhnER//I3bVC4vtWlH
 qv4OV8fs/oYo9tHcV2vHjb4JbdKLuG6pnNu5+v7xYtsM2tObh91nL+rldVsKk4yBiSaQCvcQbpu
 4+Ws3sJG3pd64nY6jBmE7SqRLNltLN1ChYLZVyR6/+wlDrnO3oXJGEXumI5Vx2ZpLuVDP9MMdkE
 pKnOU
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Taking the first one on the list doesn't work in some cases, e.g. if the
initial subflow is being removed. Pick another one instead of not
sending anything.

Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 042cd65d974a..380647f7bc33 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -765,9 +765,12 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
 	    !mptcp_pm_should_rm_signal(msk))
 		return;
 
-	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
-	if (subflow)
-		mptcp_pm_send_ack(msk, subflow, false, false);
+	mptcp_for_each_subflow(msk, subflow) {
+		if (__mptcp_subflow_active(subflow)) {
+			mptcp_pm_send_ack(msk, subflow, false, false);
+			break;
+		}
+	}
 }
 
 int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,

-- 
2.45.2


