Return-Path: <linux-kselftest+bounces-45833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A94AC67ED8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 267AB4F46DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD0E30277E;
	Tue, 18 Nov 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg9hbVjQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AF530274A;
	Tue, 18 Nov 2025 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450463; cv=none; b=aNWGwKnOwYTzEL6nSQzC5gu1vq1RQKxIxnTlvPO9X55YG/IUhyrSqfJZEbGPIhXOY/eMqT6VQv7WP+nXsD5ZsPVgmIdqhECwy9HEx3U3FZpr9sHQ8dmN2R8rOkwPMuzW7Sdfghhi3qWtR6Z60r318UrSRYZoLff0M9Jgv9chtBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450463; c=relaxed/simple;
	bh=TTwSQEIDwEoHL4jY8JupSEs0PP+3fZtDHPv4hnu2HjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QRwi+kl3b1V0TU7qrfCoBgUwuXxEFSHxKMIlByXVy83xrwXeGnGxhyiXs1eGkz6tbq8FhfYzSd59ClRYAbjUPUZtbWdM7qRr0aAJynfzGwTpDS2bn4HL6gd0eH6kxiEqijTeBXX+HfULwyhSSN0ZyviMYxgoo+281jMRCcXQ1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg9hbVjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762D5C116D0;
	Tue, 18 Nov 2025 07:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450463;
	bh=TTwSQEIDwEoHL4jY8JupSEs0PP+3fZtDHPv4hnu2HjA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Eg9hbVjQenMXpKZrvpvpDc5DTAYszo1bfuqtad3UEeXMZbjFpkfY9JwBqysI4GFID
	 4kXPHb6eI6o8Q6s6nzmjIgmr81dJ4aYPw1vyi39XEeyqubn0Z76i/gDA/2bKuedffj
	 iorPIjD1kXAt0KXZ23mVaI16wRSj8VhMJA10vAV1SMKQ97FrDY8qAPx4b3QQb83osc
	 dFO9LEEUbuXBCzZmNag6T+5XX/U2RJ3sIUdZ0PZCW4Qa7vt0y+gz+8ZU0RdjUZZnzI
	 0UT5KRVWFloyMGFain3teRKGaCUoCvAsAAaCDqDB0OMHyxyVHqMu6sIyKwGbfQApEO
	 FD3POZ7GU0o1A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Nov 2025 08:20:21 +0100
Subject: [PATCH net 03/11] mptcp: fix premature close in case of fallback
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-3-806d3781c95f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2156; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4GRqC3IIPU36fC0F6tguAlcMchdbeJR0QnPwZcYgxHM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJl5Dz+/jy5PmJt/iwerZ2pXbG/bQr4ozLtZVUuNdvJP
 lF+d6K2o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLqmYwMJ3sCzdYwsxUcP2le
 luLuFKSRbD1Dj+WPV3l5QUDT3QtbGRn+Hck/4dK/ZsqHOarr37xLvqLJ9lHIOPIDF6ulwumM1/w
 cAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

I'm observing very frequent self-tests failures in case of fallback when
running on a CONFIG_PREEMPT kernel.

The root cause is that subflow_sched_work_if_closed() closes any subflow
as soon as it is half-closed and has no incoming data pending.

That works well for regular subflows - MPTCP needs bi-directional
connectivity to operate on a given subflow - but for fallback socket is
race prone.

When TCP peer closes the connection before the MPTCP one,
subflow_sched_work_if_closed() will schedule the MPTCP worker to
gracefully close the subflow, and shortly after will do another schedule
to inject and process a dummy incoming DATA_FIN.

On CONFIG_PREEMPT kernel, the MPTCP worker can kick-in and close the
fallback subflow before subflow_sched_work_if_closed() is able to create
the dummy DATA_FIN, unexpectedly interrupting the transfer.

Address the issue explicitly avoiding closing fallback subflows on when
the peer is only half-closed.

Note that, when the subflow is able to create the DATA_FIN before the
worker invocation, the worker will change the msk state before trying to
close the subflow and will skip the latter operation as the msk will not
match anymore the precondition in __mptcp_close_subflow().

Fixes: f09b0ad55a11 ("mptcp: close subflow when receiving TCP+FIN")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index e27e0fe2460f..e30e9043a694 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2563,7 +2563,8 @@ static void __mptcp_close_subflow(struct sock *sk)
 
 		if (ssk_state != TCP_CLOSE &&
 		    (ssk_state != TCP_CLOSE_WAIT ||
-		     inet_sk_state_load(sk) != TCP_ESTABLISHED))
+		     inet_sk_state_load(sk) != TCP_ESTABLISHED ||
+		     __mptcp_check_fallback(msk)))
 			continue;
 
 		/* 'subflow_data_ready' will re-sched once rx queue is empty */

-- 
2.51.0


