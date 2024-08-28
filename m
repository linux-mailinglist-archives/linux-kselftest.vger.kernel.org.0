Return-Path: <linux-kselftest+bounces-16502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F70961F45
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59EA1F2577C
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F3715747D;
	Wed, 28 Aug 2024 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgC9grp8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61075156F54;
	Wed, 28 Aug 2024 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825679; cv=none; b=JFxo8VVcWJa4KSJkiS1LYYvZlMb8nTOSkL7AUzyMhH8s2CG6Cb27Qq7wxprvykhEK57G2ft3DaOLAXh0Zo3T98PdtXIY77en6HZLcqKTT/hA3BUQOnfnq2JQx3JZeuUFdxRUl5u0J2dAuS+HRXO1KBvcdDcfoHA4uqs1gF5kqLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825679; c=relaxed/simple;
	bh=uBgQXn45PSoGn3B85BZxeuEjozCCLSXYXLxZViAD8zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JtgQzeJXHF8A51/bDrXGTIcmNvS48R0+jDf/V8IWBMEdYyaZoMNqm3Sb4YGrIja7GEgadfF9xZvdQjhwDykMTdLJWH3X1UAbPm9CFdfh9syRwdomhTnQ5gKd84AkzKGypv8sNz/avSkKbbGXJHClzWq+F39rrrQQA5CUmJVqEwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgC9grp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEC3C4AF64;
	Wed, 28 Aug 2024 06:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825679;
	bh=uBgQXn45PSoGn3B85BZxeuEjozCCLSXYXLxZViAD8zQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PgC9grp861R+uiOxXOBVLAz5Ptm1ArKQngSDoDfmByhxqmOyKuaJ7qnzanO0rSi3F
	 vmr8na8muduCUSBlYr/jMak7K9yV1LDZz442LSPcxkKsf+AUsICyZhLMmCWVymsJRG
	 gQhtacnGvSZHwDiBOY+QJtTWv+3L/0HebA0zQsuF7JreIs+EafTmNx7H1ffXsYbnHb
	 ocCrjjOGHlIsrzYNj2JZPoacCD9kJ76ivwDpfvLdeucfJhIqFmpudQAfziu8BzwjmE
	 jMDVADsQRO37+AQasCPwFUtZdnU6rioSzOXv7sTuOxND58kPp1qb0ilqTxMz4svTtw
	 GNFtgn11N21SA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:24 +0200
Subject: [PATCH net v2 01/15] mptcp: pm: reuse ID 0 after delete and re-add
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-1-7f11b283fff7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uBgQXn45PSoGn3B85BZxeuEjozCCLSXYXLxZViAD8zQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBHExP4VpBpF16uGH0QfOO8iDSPgZ8D7U7LN
 8dwpONuo2CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ARwAKCRD2t4JPQmmg
 cx+eEADpL8T4COShp/huXf21uQ5m3hPAZJ+m2vplvau6BaMP8tmljPNZjgxQGbrnpDpTk0Tuzrx
 YbfLwsg+JFcv2la1bjsJIEsAc0ADs7aERn9w/ooPMbHrf50BAFIm2Yw8bEradBRVpT9bd4QanAV
 41pId4d/XyA+W6troLjpMg2Up2YS5cXfAuULJcx70f/pKPVGKugBC2GSg2kS0ezt3Vwp9kx0M5v
 W7hzLOF4seodLVGadgHM5CpOO5t3TAWhERmjd3P3r7IkokvFPY82uNO/xPKUtwVXcyzZ/FAPWnY
 GOOIVHIcIICMvrgwp8jXEuA811Qka8wR88Zcgj85A2p8Agnq+mAIrdZn+gf3NU/tNf5Evz4YrnQ
 2A+cpHZXsHYaMNxDI7vsk+fJr54Pq7FKqY/fWZatthsUtN8BCyL/ZSnmAQQxTBEa/TDwPAVCOYM
 fFsBYmnOYApIxeZqVaD2xVLJTjNse280VG6lHGTk10JmeKHUrehBPt40dlZ0aT3EHgO6mLVN90X
 yi6wCfcCRFnQqXkCOmH1d7YKBq6Fws7pxdciyWvfVsCC4CIAxKDId5J115rczh1OETugcSqhtFK
 O5KiTi5zhKI/sX5DuaF2tivVI3pl4iZAa3dxPwyWmULQzVtcGcaET6s+omX/jUeBFr9VlSvb5P0
 mQWNHb3LBC70ouw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the endpoint used by the initial subflow is removed and re-added
later, the PM has to force the ID 0, it is a special case imposed by the
MPTCP specs.

Note that the endpoint should then need to be re-added reusing the same
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 8d2f97854c64..ec45ab4c66ab 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -585,6 +585,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 		msk->pm.add_addr_signaled++;
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		mptcp_pm_announce_addr(msk, &local.addr, false);
 		mptcp_pm_nl_addr_send_ack(msk);
 
@@ -609,6 +614,11 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		msk->pm.local_addr_used++;
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
+
+		/* Special case for ID0: set the correct ID */
+		if (local.addr.id == msk->mpc_endpoint_id)
+			local.addr.id = 0;
+
 		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
 			continue;

-- 
2.45.2


