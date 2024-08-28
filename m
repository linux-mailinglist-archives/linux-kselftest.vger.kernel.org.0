Return-Path: <linux-kselftest+bounces-16505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCD8961F51
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431F51C21185
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DC41591F3;
	Wed, 28 Aug 2024 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXojYHaR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929121591E2;
	Wed, 28 Aug 2024 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825689; cv=none; b=HFKn/fYCUFr9cThjhK1ySnwm/hu2rsqr3JUrD+iB6JfkqpVkoqtNJTVL8kdlriO6u6ZyoCv0noQeMDnjUKB1NXDSOeqWTuFCA+mcvamqlqXdbgnIjuOhROGFM+WbZk1k4jfPkq4jGF51/2xtMiBGWZe0CjAQWmBp69ZIK2Y2e60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825689; c=relaxed/simple;
	bh=/MonwW2ScW/5kgkZiEMOigLO/IShhzyhY+L59U5xLlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BlU1NYTD0ga14qBds4vnHGRqR0A0w2OYaZMkTKXRJEGAFjpe/3uPuGKkwxsseNcddR4riXdwLJXQixGV2q84lHx95UjKPsx5LG0g1sHR06xLZIvtL7nXtv/0hl+Stnki7T8HQQs8+hf5j/n8Ev/IUB02Z/w6bYwcf/tGSWtashQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXojYHaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F525C4AF63;
	Wed, 28 Aug 2024 06:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825689;
	bh=/MonwW2ScW/5kgkZiEMOigLO/IShhzyhY+L59U5xLlo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aXojYHaRK+yAlWnGZ+wN7sYQg2Ekb2I1rg3kGRKG33Npskcs1jZLP1t+4PjaDnfvR
	 OpYCV3p91WjVRvbjzFxGne4I9V4ihTVu7kKmtwy7nqlsIZ5YTq8+u6fYc2Fdz6E+02
	 DH3wp4DOTGJl7VInLfRTzjNLrPtkCloRX4KgVobTYEf/wAicDrh7GHf0qPalec8Q/1
	 GmvOV4JrwypOHHdrHLk/lFviRWb5yPWNO/8EjP1tcUpi9Vo9qfaqsQ80IYh+rlmlXG
	 dQQetlNaj3onaplTCNVZy5Fjjib+ql5pJusl+phZwfnRSoZBd8NBMRgJiQ/wpach8T
	 dQykcYxf3wKpw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:27 +0200
Subject: [PATCH net v2 04/15] mptcp: pm: send ACK on an active subflow
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-4-7f11b283fff7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/MonwW2ScW/5kgkZiEMOigLO/IShhzyhY+L59U5xLlo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBHpdIgOPBOYPG+V4vJJ0nUDF3XeUkNf5bR5
 Vty9TZxaZqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ARwAKCRD2t4JPQmmg
 cwXXD/0U20KBA4UblZsJghoO/jmAgMGsD22GEcoVNt1YyPTanEawTkAOCiizDHirEqY3HzK6J+o
 7oDicZXrT764hAMErYgLmnrTxDnuMhjvKzegx4mkkbBHg0/mPJ6CEjsjta4OOUR4MoufyyOimdp
 b+JTkCC5aK6Unr7AkAa2A5DF6iDY9gTHqbMAGO7RR9gJSmlIiCZZ+7LBnGqvQMA1+t7TeHTE9tg
 oSbGoeviqjbdcyB7J4xMX7PCTfYSJIlMAgU4NrETL76d/qO0055wRCnabCRenyCbXnWwVLNjJHL
 EOfELjFxibKe2Rt29pCJpQHMak3IT1rQXabohSJUJkpvbcp6PoikNqiGBpYm3y6eRwI0tND7eiB
 1T1dOHFZscfJp9tr45jN6CtZIN2PfpFcxpRhITZJYyxqzudcpR4bYOF+sgLIsb1C1T3gk/4YQjF
 MlktGoEWBJMX3W84pPxj1qvqitplgPEXtPl1upLIe/+1U0DlgO6zD/mM1xoyoQyI4jlQJjteGe4
 oaXV8+MtLWnTLtCowmpEXT1xI8DtGX6yWkx0z82+BEkExB+1geJeQfhmZ/TA7fTKxqKU1Lkxhix
 KV/yLnL12rdKEmYVw40EQZle3NSX3rh0LatELKkdUKtYQAL2s2Jn52dBtS67Bjzxa5b1EoI1NCg
 yGSiB866mAHmpzQ==
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
index 42d4e7b5f65d..ed2205ef7208 100644
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


