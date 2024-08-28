Return-Path: <linux-kselftest+bounces-16510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FF4961F6B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170991F2534D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6851816130C;
	Wed, 28 Aug 2024 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz05o5Sy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313CD160865;
	Wed, 28 Aug 2024 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825706; cv=none; b=n6xIXpXG2nu2n7a6nAF1m4zAmuqfrv8UbGwbFCiJ3KBuBvW2TL30/QnMNQQAC8I1+qmT2o5/HVp/q2NE418enJKg9G/PUllI33qU202BN7n/VbLTchymp/Pss7yzQFfJdQS5OWuUCj6Pb9hx+kMrM5V5HcJGyRlr3jzBDq4iWUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825706; c=relaxed/simple;
	bh=t18cAZFBKR5PZAJDXnlkhw1VSFnUb5QipvZp/exIpos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fGiKMOf9dY36g5LQggrYlWCV/OfQdoeQZWOOoFpxrrJ5jUBzF1MdY2HsfGTLofJG+Aqh23SfoBjrFsW7utgJG4tC+jagyl7bS2645gR4e/MNn93tkGEFf3+51gsbNci/EgKL9MWIllhbiJIqup2fCUq0oOO+EOVPmL6lEHRO6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz05o5Sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D706CC4AF62;
	Wed, 28 Aug 2024 06:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825705;
	bh=t18cAZFBKR5PZAJDXnlkhw1VSFnUb5QipvZp/exIpos=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iz05o5SyLn2L/S2PbrG8UciFzb5/kyXy9jYcYlki4tcn88U3dxg2qCbVwkOTlTVXL
	 vGTQbvRsrzy9XN4muG9tNFLJwXrrjefx8SkpP3BvG3+/0kHComOHbMqYEWnP8zkz+a
	 rJfq0dBPKpJijQ1FxNvKvq9yFzdGFVDKCVWReqs9ybuuuekItpqv7yh4G6sfPy/dPy
	 MmmEPIyDKOZqAl28VQhFOaLvjgR4x3a2bMaww/pWJDKcgsyV7j2MP6g7Vy/5XG2Szo
	 Y9cH7Q2B2ST5w7rVJhEL42YT/WwFXnisTPPcLJGUFTm+AZIUMN5VVWfUW8rLAxOKhL
	 nZ8AYFGInspxg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:32 +0200
Subject: [PATCH net v2 09/15] mptcp: pm: do not remove already closed
 subflows
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-9-7f11b283fff7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=t18cAZFBKR5PZAJDXnlkhw1VSFnUb5QipvZp/exIpos=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBHZNo6DRBLyahuAKxUFW2F/sWwU2w5hLMPA
 xl4uJrEuUuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ARwAKCRD2t4JPQmmg
 c11bD/9UgWbrEUHFbBWA8RhkV3T62QkRvCPDc3lv6dXv5LNWvsoVVrrsZH0+8fb3YiUucA8FcAP
 6ojWg33vNZ5bmsZLTdn5ltbzgzC2+zT2al9ZramFZpUAsmO5+sa8pOcG+Wbx/RUPlHQN6bgY0kD
 3CslxJP1lXHTDoP1PlytbHg9WnaREzmT0t0oC3UcUrY1L85lY4p6lBcYtPna6aK+S2fMqTRJ41Z
 TPOjy6J6DCQRssD1QKlUu81L83sygLhjrBQn4vHfjZllPhrwYJkorPu50ryVuIFnS5wylZLXtRk
 SMsUOvBLx9zWKTFB3TU3uoPwq4P0p6ooep+dJOsOo/+9sZF+IqfM0xfoJJRWNZdv1aO9xK536AX
 /kFqD8GjIsnhLE1LuKOTeseYHQOGqZUzXt+7MEs7418yMAnZdvj6GCBPRZ5Hm/fXEN/Dxww0vhk
 xKYxOrGCWOHbQMJV71wbZNlKzPaJaLiw9PLR1IIV8/2PBJK72/o+vC/7vA1lJUDvvW4SBNYU5p5
 DIyfaAaaG1xyfA3gyUj77pnYZD99pyyZzfvObh9ZR34+qKh7POVkaUYuRv+DHlEH0X4k5nsjsCx
 LhszIUOweFk7VDU4kfuu+Ohy9tR282WNeAN+F/OLhaXuFWkcxHtdGyjqjetnZaA0OIbmI2puBFu
 w6crXf+bYfeS/9Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is possible to have in the list already closed subflows, e.g. the
initial subflow has been already closed, but still in the list. No need
to try to close it again, and increments the related counters again.

Fixes: 0ee4261a3681 ("mptcp: implement mptcp_pm_remove_subflow")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5a84a55e37cc..3ff273e219f2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -838,6 +838,8 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mptcp_sock *msk,
 			int how = RCV_SHUTDOWN | SEND_SHUTDOWN;
 			u8 id = subflow_get_local_id(subflow);
 
+			if (inet_sk_state_load(ssk) == TCP_CLOSE)
+				continue;
 			if (rm_type == MPTCP_MIB_RMADDR && remote_id != rm_id)
 				continue;
 			if (rm_type == MPTCP_MIB_RMSUBFLOW && id != rm_id)

-- 
2.45.2


