Return-Path: <linux-kselftest+bounces-45834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84707C67E84
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 796D82A08F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 07:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A230304975;
	Tue, 18 Nov 2025 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oePav5N+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6700E302170;
	Tue, 18 Nov 2025 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450466; cv=none; b=tzAs8qnN0MbX4LKpoaDcQ+jN83UimzVWEO3Bb5ukA5nrdi1vWXOWLpvanleBgpwpep2vQ2EzV+wtfYJ8Usb65YAjHjfhWwEwKdKVPD90pl4qFIAAwiOwxYorOAvkNfXjc1ICkonZ2WRkXKtDIJ0hiqBDOYQAdiXdtqdEQVlSQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450466; c=relaxed/simple;
	bh=v2COROPOkb+/QFrOg17qgWtsZSdKHqoGo4X7yamzLJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iG9DCIy/G3oYnoXrQhGwJI3HEmOTx+f5hBP/UxnLuXtgHhQ8vaeoCHG3WE1ky4Gyn+pVRzoGj1YuKNBKhaxfWxSVHxLW35iBpxAHV8mU4xAcRbM0f9UBNy1+IdrsyIpCliIW2s8mloBwgfTczBvx51mFzjVTmHQ9Zr8OsEGaJwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oePav5N+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4E5C4CEF1;
	Tue, 18 Nov 2025 07:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450466;
	bh=v2COROPOkb+/QFrOg17qgWtsZSdKHqoGo4X7yamzLJI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oePav5N+JLgPNrd3CsgyLmtcsvBEFjgo3JK1bokE0c+np23Fnf0d5BQQxMSRbsdcM
	 4VhaBTce+tDjrx+gy4HWtUJCeCVOzU4yk9OiiShSFtoRV22gHUzrJCFF/AqQScgR6T
	 h0jqsH+3Kz1uFcKFBPGCYx2w/EFDrtJT7PgXNt7WLq4CgzLWCG6gk527ZB+8PM4A5E
	 Cek4QEdGHIv2aJS77/mCaqtdA3e4Qx+wQ2vMsopO+Lrt3xDwe2SNnybqwEVZHJ2YgY
	 bB1ULWNb9TEKKKadjkJlhNF/0ZENJQubcfgY+AudB3Air/tA9pXDbDdDVkGoLFncj4
	 kErQA5CTV3bUQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Nov 2025 08:20:22 +0100
Subject: [PATCH net 04/11] mptcp: do not fallback when OoO is present
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-4-806d3781c95f@kernel.org>
References: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
In-Reply-To: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LpZLBaaDHvLWZEUfCSaXCRCaThAocUVDulzNHtecP5k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJl5DyNlu3KfP00uCjw26zs1zzH7l6t4PrdlZwc97D55
 B8nafYXHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPx92D4wxuYvaIwI0PYbwqj
 /cn8yR426snHjc5HLlPZV/F91odgE6CK5f6L9v0/rZSmGj0//a1T2AvLN8yC1x2dDhXmL12cxMs
 GAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

In case of DSS corruption, the MPTCP protocol tries to avoid the subflow
reset if fallback is possible. Such corruptions happen in the receive
path; to ensure fallback is possible the stack additionally needs to
check for OoO data, otherwise the fallback will break the data stream.

Fixes: e32d262c89e2 ("mptcp: handle consistently DSS corruption")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/598
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e30e9043a694..6f0e8f670d83 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -76,6 +76,13 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 	if (__mptcp_check_fallback(msk))
 		return true;
 
+	/* The caller possibly is not holding the msk socket lock, but
+	 * in the fallback case only the current subflow is touching
+	 * the OoO queue.
+	 */
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		return false;
+
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_infinite_fallback) {
 		spin_unlock_bh(&msk->fallback_lock);

-- 
2.51.0


