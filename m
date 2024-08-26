Return-Path: <linux-kselftest+bounces-16304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F080B95F5DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2801C2074E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A7A199397;
	Mon, 26 Aug 2024 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCQv2c+7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0106D194C93;
	Mon, 26 Aug 2024 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688000; cv=none; b=B9Vwyp2nBsWz6pBLPeMitQ4IpltovSewvZ4F0H59nQ8WnFwvXWvaykpwctYgi7lIiexxQNVAsxjF7aCtqDIsu6I/vR9+V4FcaxoFipttVq5zjRCGC/HzQCTWkjnu0XyBQbfBN+878rQkt4blXRXcrCm1fe2vzHxzG7TrxdmSIZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688000; c=relaxed/simple;
	bh=uXwOMuW/G6+0zgv9AO6yFx2u+jhvgs/z/nmI3LCIdrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ITgUEHQDsdwgFnL6DnGBHixbu60ANEwylm+LR1kRY1q3nPmWRaGOlpoJxh7BXPBacFo2461IWjWBlfOFFI7BJ4oDFNhxdjjdpoa1xbwMN3qMJphHuYcVMNj9pJ74ECP0rO1exxCox4SDgYgT0iID9oZCUfWx/1lSqouyLCvuHB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCQv2c+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A3EC4DDF5;
	Mon, 26 Aug 2024 15:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687998;
	bh=uXwOMuW/G6+0zgv9AO6yFx2u+jhvgs/z/nmI3LCIdrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NCQv2c+75NLKvvlJljjrgPhKlzE913e+xVN6CRDrorAjVlZ8A9twCDYPPR/NwXKel
	 h5zg0ZufxzNQo6OfRkyQCXP4ozypzxeoonWUYp/LEcMIXfYpnj7LGYX3OkryXt5+mm
	 GS2pJLk/4zpomBglykC3W/FiKE5lbBvXwhOgVil6klcVxucGy0K3oPEB3DbCDo5e4k
	 JdsasE1II/vsKheEaMR74WYK+qqZ3eoHYrarInupZAq1WHVo+h67B5nuzZu41oD7ae
	 1QRRECRMJI2pMuUG6EKFg9mMx/rMcLfV5LV5V8/ZoGEAXMK2vOeFPc56aF23PbVSiP
	 cEWWG5Bqwghpg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:09 +0200
Subject: [PATCH net 10/15] mptcp: pm: fix ID 0 endp usage after multiple
 re-creations
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-10-8cd6c87d1d6d@kernel.org>
References: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
In-Reply-To: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2308; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uXwOMuW/G6+0zgv9AO6yFx2u+jhvgs/z/nmI3LCIdrI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZW0d11ZBJN4Z+IvERhVx9LuJbaku85sDvf0
 Wft/3oZzlOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVgAKCRD2t4JPQmmg
 c7h9EADYErk8pH+Gu/yqt8tfd6Bj/yopVphZBiIurDOCNJcz5JHzSaiisIoyFHNEmbgcWyCtXVL
 JUk6LANUIWRwB4WrVjzsDdTTceCT7+VXyKbtC74yj71lAm/8d8/GE+wN4VLzh50CUHoYYjUJ7cH
 CvkwQVeAj+i0fMzqV+OpATd87TZamPOj7upNBycclNHwz6EPscfx0mzQ7hlSWHUwC3PdCm7rPem
 XPrv5/kZZY4PBOilDXWvBJOrTAs8n0fxWWXFKKJEjfU2l0FzyAdlPv9dbymLSQdThFFgqVJFPOa
 aDIj3n3eUTLzZeSSeI2FJ54eZqfoU+smNN7yC8hOu2R/+fnvu7T9Qo00J1W+hSVgCKuY/g6qPQa
 QkbSSwjbor/KC//PWKzXkOy5ARc1SQSSbWzNTicplcuxOkO7taZAXbaYb/Wy/tpJeWMux5ElOik
 clcLa4JAkwMCc5N2QrfZLh0lBxqmF6213xW3xHPCp87TMtM6t0zt2eLZzHw4UwwmgpXDoOazj2N
 nehfJaSSyQ/BVQdZyKBIETfB2cuIIl9Az0zkYT+IxMjC7kgIYBVo+LSBBx/SvLaEZJU78OyIcAm
 44Z7AA3M7vj3nhFMyB75m87GWFSlZmYJN4EKfKEDIBgIbhOSgn/ado/Y1WhBorwJA/v7bAtJxay
 XwhVCeqMWAFG6Pg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'local_addr_used' and 'add_addr_accepted' are decremented for addresses
not related to the initial subflow (ID0), because the source and
destination addresses of the initial subflows are known from the
beginning: they don't count as "additional local address being used" or
"ADD_ADDR being accepted".

It is then required not to increment them when the entrypoint used by
the initial subflow is removed and re-added during a connection. Without
this modification, this entrypoint cannot be removed and re-added more
than once.

Reported-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/512
Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Reported-by: syzbot+455d38ecd5f655fc45cf@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/00000000000049861306209237f4@google.com
Cc: stable@vger.kernel.org
Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 90b7c8b45027..591ae2ffb4dd 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -615,12 +615,13 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 
 		fullmesh = !!(local.flags & MPTCP_PM_ADDR_FLAG_FULLMESH);
 
-		msk->pm.local_addr_used++;
 		__clear_bit(local.addr.id, msk->pm.id_avail_bitmap);
 
 		/* Special case for ID0: set the correct ID */
 		if (local.addr.id == msk->mpc_endpoint_id)
 			local.addr.id = 0;
+		else /* local_addr_used is not decr for ID 0 */
+			msk->pm.local_addr_used++;
 
 		nr = fill_remote_addresses_vec(msk, &local.addr, fullmesh, addrs);
 		if (nr == 0)
@@ -750,7 +751,9 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 	spin_lock_bh(&msk->pm.lock);
 
 	if (sf_created) {
-		msk->pm.add_addr_accepted++;
+		/* add_addr_accepted is not decr for ID 0 */
+		if (remote.id)
+			msk->pm.add_addr_accepted++;
 		if (msk->pm.add_addr_accepted >= add_addr_accept_max ||
 		    msk->pm.subflows >= subflows_max)
 			WRITE_ONCE(msk->pm.accept_addr, false);

-- 
2.45.2


