Return-Path: <linux-kselftest+bounces-3887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DD9844A65
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97221F21248
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD13C39FEB;
	Wed, 31 Jan 2024 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFgY/iXR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7939FCF;
	Wed, 31 Jan 2024 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737831; cv=none; b=ubXU98XliG1DN4ejbjJ1m3fGwx4ji3060+adf8rLctoimwUnVmrmigeAcaLJabTq02mFvSO+IZcxcqP7bGjQX52zBJhm+i6Be7mjirrLCnUXfpPJQVAjJEWcjBtyobpxZ8HwizRFYLLi10Yqbqe0FOERvkTQKpofF6ys+MSGHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737831; c=relaxed/simple;
	bh=XXiWwUEZmp5fjWh5iKtz9h44NEjaTGRyKTaVQI0W7EE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RupbRr1gPsymN+x1i6oJfvOb4kas/vgasBXmSFHx0N7iW+B7pTSdvYohe9oW+zY3PvarBqaeU5Rbet075mssk4DWGfN8t9UnPGJskNIJ/rfCwCvV619WLWBohANXdy4AFU8CNKTqSCjLRwTF3vuxTH87ohDvgwrJTISMltTkd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFgY/iXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC91AC433C7;
	Wed, 31 Jan 2024 21:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706737830;
	bh=XXiWwUEZmp5fjWh5iKtz9h44NEjaTGRyKTaVQI0W7EE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sFgY/iXRgbSOFmpZ6z10TkYjISw4HnH3YbXBZrWixCt1KrGI2Zqt2ocCPELJjgyty
	 IR519rsTjb7bnHkOxHISRDgVjv1j+LvQ+5NLp/k0SApAqdKRyHgaCCX10I1wIZ5bYE
	 HM1G0M0O65QJieNRmnNs8Bz4vV73ZS8xKr5IcMvhK+mHIJNEw2ssO20NJtLFolXgML
	 vVobITLTki5kkwaqUlfOamRNE6JKPFYT4mLuUhQ4GSlABtLcvNSgN0d3v9/UcWKueI
	 0XIJw3tg6DhhkXvOi7uIe2yzIMP7tOc6smCcdiBj03XRA0Eb3HHX+nH9dCxwfPlksx
	 gmANgXKdTH+Pw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 22:49:46 +0100
Subject: [PATCH net 1/9] mptcp: fix data re-injection from stale subflow
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-1-4c1c11e571ff@kernel.org>
References: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
In-Reply-To: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1863; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9dynpHdX9Ik8LmCQAbnOxMKWOpT+IehcxBDh9DIP2U4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlusCfymu+KeBVySFiiH6iony4SrKMhe8Ag5Umy
 F6hj4BkVeyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbrAnwAKCRD2t4JPQmmg
 cxvPD/9FQKFrrd+Cjx/3AcNt3A5KkvBCM8chxULaBnM213+Wgrrxn4cyHELI9dLkhFNmhJxbiEL
 S8n4NxN2sOaATxTxNQ+rkBGCNsFOx8tPhPWJelhvTZUjmsZ4+vi0L0b78tFmXlkDqM55qTbF+Ca
 O5qlmSvcPFwdmx419Evx1jF1TqctbR0GlMKu8DKfNhmRobmEJl7kUAOiyC0DiK83ygx3bEFwK8o
 q8EmBcZlG6EX+zVp/6pY8EkJGm4Ev22xshhLO99koDXgJ1ldsKaGxYV6cSVTYn3g+6oBIME6+tJ
 NJNYTvhHNn5GL8vN7ppNEUOYdLIcQZL+xovUIMA5vUgrRkUUOBFBjvReQkgcptrPnBhW2IR/mUr
 +YH2ItVKo1uMk4CXXYXkYH6iQSCfQN3DZRnDX2SGgSy5vrtXVLdbOPQtwmJQCVkwPmTlg0tDY1K
 f6l5Nldy+OL5dM7B7gSi3P82pM2uoQYmPRYLim20jHRQqo2DykB6SJMcDvVH8+qHUq7OfFRL6AV
 WiZSw8pWORKgPTxqOEz/EYSAPaxGYtqvFzQpTcnfi1M7CSBOp/nuiXETL2xvqJ9fm5jun2KWxgk
 e5a96VfxpYjEuz+jDCUB4OsIraP2gRI3b868+nzb4tOC45q5SFvsHWtgMbAlh0NA3yyVBe3BnT0
 7O6hRJyfR737+8Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

When the MPTCP PM detects that a subflow is stale, all the packet
scheduler must re-inject all the mptcp-level unacked data. To avoid
acquiring unneeded locks, it first try to check if any unacked data
is present at all in the RTX queue, but such check is currently
broken, as it uses TCP-specific helper on an MPTCP socket.

Funnily enough fuzzers and static checkers are happy, as the accessed
memory still belongs to the mptcp_sock struct, and even from a
functional perspective the recovery completed successfully, as
the short-cut test always failed.

A recent unrelated TCP change - commit d5fed5addb2b ("tcp: reorganize
tcp_sock fast path variables") - exposed the issue, as the tcp field
reorganization makes the mptcp code always skip the re-inection.

Fix the issue dropping the bogus call: we are on a slow path, the early
optimization proved once again to be evil.

Fixes: 1e1d9d6f119c ("mptcp: handle pending data on closed subflow")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/468
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3ed4709a7509..028e8b473626 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2314,9 +2314,6 @@ bool __mptcp_retransmit_pending_data(struct sock *sk)
 	if (__mptcp_check_fallback(msk))
 		return false;
 
-	if (tcp_rtx_and_write_queues_empty(sk))
-		return false;
-
 	/* the closing socket has some data untransmitted and/or unacked:
 	 * some data in the mptcp rtx queue has not really xmitted yet.
 	 * keep it simple and re-inject the whole mptcp level rtx queue

-- 
2.43.0


