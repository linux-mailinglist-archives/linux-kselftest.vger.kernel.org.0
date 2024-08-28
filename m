Return-Path: <linux-kselftest+bounces-16511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AED961F70
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423C21F22BC3
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBC9165EE4;
	Wed, 28 Aug 2024 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3GsNZ27"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D472514883B;
	Wed, 28 Aug 2024 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825710; cv=none; b=ga/7SqBzu1mHxq9NDqgBhBL5BBvF4m1TPUVru+pXILdj34pZQG0gysrL/2QsHBwHN3YNX+S3R0TzXs0oeM5Tsp7jwfU4Ygel9kms0zvpC0JuyeZmReptjGX7/RFoSzU68EPpeYIuupZGKeqZ2baAXOcsdM+Aih3Qz60pptthV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825710; c=relaxed/simple;
	bh=9H3YWMjD4jyQ1Mei85a4WkXll1ThuEk4wCuo9BcThtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OsRuW2+lgUXTbGQpKBB9tgIVXyb05IoSN2Qno96FKdoXczth5q6/CThVaQqaKi9yEG1lcJNcF0pEJMsT8k/ZKyJjrNNiuvy57N7N8HOcDJUQa4nFeJYUT7E5xhxzRllI0Ubt/4Vqf+d8/G8zaOdV13RH40td+OKwpI+Do5gWXmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3GsNZ27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF07C4AF5F;
	Wed, 28 Aug 2024 06:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825709;
	bh=9H3YWMjD4jyQ1Mei85a4WkXll1ThuEk4wCuo9BcThtE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E3GsNZ27cD653eZH2sRv2xmHKQ9OMFGjoMkMpv2j8CzmY8NaZ082vaU2mjzUh6OhF
	 bMy3o6XH5TqzdniDm5fhe8oHaY2ZamZ7meYrO5N0QtLmbLBULQ5dzSWy/H0EEN6kB5
	 C3JHfNXc2Gu5Pon5pV1B4InV/jE7M7mg6gD0rQjdb1yd6x9/lq74GRrBuVYuqWsx2W
	 XV4VAki6qukGoZKFsmPk2GSWEuUVaOikW0axiaXX2JVgtdNTtaYyIFRqYtm1sKpBLK
	 UUXYbE8UxI1Sd8yAyif0VSmPxYheGNz9DhfmWARNv1i3qm1lDbjJeKZvIoepDrGcm7
	 UTj4+zQIAfVRg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:33 +0200
Subject: [PATCH net v2 10/15] mptcp: pm: fix ID 0 endp usage after multiple
 re-creations
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-10-7f11b283fff7@kernel.org>
References: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
In-Reply-To: <20240828-net-mptcp-more-pm-fix-v2-0-7f11b283fff7@kernel.org>
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
 h=from:subject:message-id; bh=9H3YWMjD4jyQ1Mei85a4WkXll1ThuEk4wCuo9BcThtE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBHljJG4wnjeg31WnPzjrjJHDFvG8MvE257X
 duBT+VmvY6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ARwAKCRD2t4JPQmmg
 c6NjD/4rY1GH/+dGM3ofqnsjUtHVrSkafv1uv+qfYnVsSto3k6XufQ01fN/JCluFANrF8ta2Pte
 Sy3mB4K6uHgB877N3HPHPokKjKSq04OAumENJWwcjXnIdfP0oSpMun9ONPz37EDxKZg7k0wN9Rl
 Wz8TBjtuifUBUoKFY6H/cRXnhUy4+HQaZxEatTYcqfCeOFufwUDSZXPNHY8aUDKCd2+tuWU4Kga
 D82+wAzy8RKPuSFZ5bt/X6glRsmPptW0GRIIm+pS4ONJC/FLlywE+ugJqaGZuidkRSn3P5vTdi1
 5ua9ferotaGCY9dF8ZLApv1+g6oVBsDb484NYHwNpKCda+Nc5AzPyqkZ/l/KAtu079yT6VPFfAp
 jMuh8v5kD34EEXQrJ5EW4nwUVWMzljditthTGk+x05/MaIMZgCrXX9eRZEUTT4bsf5U2e5iAlMQ
 PPPmzomdE6cTOpzB7JVU9BhAfDJ8aVNcwy7My5hycpoUTtnH7B7dAAlEyCIeiTHLERuZO6i4j6m
 9QsAXKjJvflgvPLbUNYAbMzGZYF4mZk7aSdTON9Ge2Rs5SBOJb21OhDMP7mAxmXTBu7uHCgVHbd
 A0VlQwuYNORNA07TUlERRQFa8rHj7DkHiUyBpyDKveep7eZSishx6bRFZ+oxsxy9JUq6FsK1WGC
 i9XZDsPLBz5sUNQ==
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
index 3ff273e219f2..a93450ded50a 100644
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


