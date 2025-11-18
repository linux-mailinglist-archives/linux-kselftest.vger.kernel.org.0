Return-Path: <linux-kselftest+bounces-45840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B717DC67F38
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2EE84F6EE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 07:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0272530AD06;
	Tue, 18 Nov 2025 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovSupcb0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD13B309DAB;
	Tue, 18 Nov 2025 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450483; cv=none; b=WCawKIj5qf28CWnVGRR7GeSaGjc/SHFTw2r1UU1+KxvEp8xVjUqK/ywnN/fly352z/dKTX5padOrENgoWTLmar/K/5aKnHixfuzhl2GoSNyvMJFiPiibi4b/or/11WR/aP0qQ7Nvc339S6S0OxCXcioJBAzLGEYyfLHx2sQcfgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450483; c=relaxed/simple;
	bh=/SkZ/1rikGfId+WTzg5hsP0H8Mzs9COHcj4A55ocTio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I2p5XM4KgMgSWUhB84Zq7/fy3twuRvWxV+PFJqSa5JxV60zmrs6Vclr4VYg198nzAonvE28ajEMempazfviqzyU3oyEfu0/nyNWD0Yuj53YwJLopsO0hWVOIMwr9GdrOFAKRoodbKPqk/7DkM9RMC8KOE2aHkwu8HT7q1NFwfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovSupcb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85B5C116D0;
	Tue, 18 Nov 2025 07:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450483;
	bh=/SkZ/1rikGfId+WTzg5hsP0H8Mzs9COHcj4A55ocTio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ovSupcb0zLFPEUeYVlWE0TMTFZj5zElpvLgqrAV/mRhJhs4dl+coz/H8UXoXAz4E/
	 NuugPeVjrtbdd77obP2P/NV+khiEqDFJ1PbajUWvQ5jQjRXR3EB2qTPm3OYItWFHwy
	 fA7OJo8wNWVbUVtP8Agv4pXfSxPSxS/7jsM6KOL4A14g5EIvtXIuCTOMSKLPHt75+P
	 eQXH1YJSxpdqJmmojI60GaQElQ/tWgq/aJEyXxQk+LjWbrhdyVfjYPWM82SiOxjwfD
	 S0nLZJbq24wox/4IX0kKDTPeDXFP1XFlZzpNogJaPEeHNPHcHIiYnLchZlB3baAkM7
	 nfOR8kOBo93iQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Nov 2025 08:20:28 +0100
Subject: [PATCH net 10/11] mptcp: fix address removal logic in
 mptcp_pm_nl_rm_addr
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-10-806d3781c95f@kernel.org>
References: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
In-Reply-To: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RZgHhm/YQehCU4ffPYcYWbBUBUzzcOnO6DmzyJ5iJLE=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJl5AInRjY/kXz6lPvgwuPZHcLy7j8EmVdN9vr1ZJ+NV
 UPqYUfbjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl4JjH8z/uyue/IR8YPlj9u
 qP/+fKgwa9kEO70JshnnzJcufJV+/DAjQ/v/jWUCN2K/2Hb2f2coFdjMyLGgoHY2q4OvZe1r0QU
 lnAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

Fix inverted WARN_ON_ONCE condition that prevented normal address
removal counter updates. The current code only executes decrement
logic when the counter is already 0 (abnormal state), while
normal removals (counter > 0) are ignored.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
Fixes: 636113918508 ("mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_received")
Cc: stable@vger.kernel.org
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 2ae95476dba3..0a50fd5edc06 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -672,7 +672,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 
 void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
 {
-	if (rm_id && WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+	if (rm_id && !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
 		u8 limit_add_addr_accepted =
 			mptcp_pm_get_limit_add_addr_accepted(msk);
 

-- 
2.51.0


