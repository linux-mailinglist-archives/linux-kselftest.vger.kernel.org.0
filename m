Return-Path: <linux-kselftest+bounces-14303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2634A93DE86
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 12:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E56F1C21333
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 10:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1406160275;
	Sat, 27 Jul 2024 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTv0zcme"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FAD59164;
	Sat, 27 Jul 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722074606; cv=none; b=dDYu9w1ZfLMDU57R2wefjT+8HldlQ0M7s9sZVeoAnpE7Dq/iXH1HqjVArKJG8sAfD0UEUa97b0vycJGwvstFQypxDq4Ues5QPF3txUzqGfPR/ybmkoKY/Ku3wTz2s0ycV+s74brfOXrtsfFGvrFhACNhDimBp1oDDxswDcO1EAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722074606; c=relaxed/simple;
	bh=CTR8gewU45gvgKEmuXT6+SEcMEUMSca6hJ/huUAc6Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fdCzN8f+jnt78f2sydNoK3eN9+7FlwcVfosqwu4yG/vCfESSt+jlsLIMnL3khRcFjtZvLJ328xD5W1Hql0loN7WHqPGvAplWHA5FWISi4Pk6FrtTHZ46H3k81e3Hlo4AtIM/JoYOP4ZQ5HhRR/0P70JgYA+bjtSmesyotkQOBqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTv0zcme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF75C32786;
	Sat, 27 Jul 2024 10:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722074606;
	bh=CTR8gewU45gvgKEmuXT6+SEcMEUMSca6hJ/huUAc6Qs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JTv0zcmeog67C7bb8VAnToMDxxvCq0h4WlJkI+swrmTCG12ND6Dgs4UXe815gke1I
	 RM6DP7FCJaYKiiIjBey4lNdB7NAM4+JIbO5BBW6cY383pSg0nUs6YsgXffHwsoAPgt
	 cBQW0LEgyVzrGfUF+/qmcdGehOYZZkh89VszyGA2PIpLUAiitMYuXwP524TJc957s8
	 UGDJDJ3Ld3d0x3SM2RRIaR8Pgh+SgSaknUaaHciHNvFlQdUgz05h48XldVd7aOHoka
	 ySHQrxcE1lG3ynnmeCDS1X9hAkWQEWESar6bChfv+qWEv8zMjg1ZERaiNjtfsiZAug
	 cTv5JfR6Z3XvA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:01:23 +0200
Subject: [PATCH net 1/7] mptcp: sched: check both directions for backup
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-1-f50b31604cf1@kernel.org>
References: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
In-Reply-To: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3069; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CTR8gewU45gvgKEmuXT6+SEcMEUMSca6hJ/huUAc6Qs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMXljQzK46ZBbvKWMgbuUfFw/J5D3FsIfpAgv
 /dWr6A9NHyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTF5QAKCRD2t4JPQmmg
 c131D/0VgKZjBEl/VO1L6HiKYnWh8ruH6wVt98Cvix/y+by2D3zFS8aN/iv8VtDJHNDy0onTiZA
 Iwqz7YvxKR66Q8piZMqV65/C5TW0KwSOqHgmRx0vZqb3gnf3S/ke6LD6E8tsqKgCRbroAOQrvxf
 1BFi4ZijEuWb24FOq0hW0AdFSqO1pD4NHMa9asspvRxCFHjTNrOWOdXZLRsGrhQSQVMxMfBaD0Z
 n1sYmwYmumo3Fb90p1KyBJ/2qPyqtAP2nHCuC0nAKsHAvehwIGTV+hvCoST+zBnByWyQv3X6NT5
 2HC4GZjAZupcIPnNZYYmsMv+YnjpkEx4U7kNqyEJAGC8apfmU6WpybTMD+24KdIHdFzF4mooAu1
 jlijtoyQo8yp0JRg1OtVwyqPpIex8m9BUnK6ZwpZDB+wq1v+DrRv8CTeeG9cAEye5T8FYnp4ZId
 DNHf9hiqVJK4ALaJiNVhNkgx6l8ybTepQL5BmyIxq78GiX351+sbHtYxypKdKHxxOsT0VCKH+rl
 bfJfJwqLK9MAr5EvHmwccR8IFxnPSlI/iDHkUMUYIgHC5XxVD9wMK4U6/dPFDB1ynEGV8+bGJOS
 pKRRQpuV3AYTGuaga+ldm6dPOLkY58PzDqQcIDLmQrKOhpP4dq0wdJwdIyGXeuMaozxBBBt/ke9
 THaO5iTZOiO56Rw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The 'mptcp_subflow_context' structure has two items related to the
backup flags:

 - 'backup': the subflow has been marked as backup by the other peer

 - 'request_bkup': the backup flag has been set by the host

Before this patch, the scheduler was only looking at the 'backup' flag.
That can make sense in some cases, but it looks like that's not what we
wanted for the general use, because either the path-manager was setting
both of them when sending an MP_PRIO, or the receiver was duplicating
the 'backup' flag in the subflow request.

Note that the use of these two flags in the path-manager are going to be
fixed in the next commits, but this change here is needed not to modify
the behaviour.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org
---
 include/trace/events/mptcp.h |  2 +-
 net/mptcp/protocol.c         | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 09e72215b9f9..085b749cdd97 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -34,7 +34,7 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		struct sock *ssk;
 
 		__entry->active = mptcp_subflow_active(subflow);
-		__entry->backup = subflow->backup;
+		__entry->backup = subflow->backup || subflow->request_bkup;
 
 		if (subflow->tcp_sock && sk_fullsock(subflow->tcp_sock))
 			__entry->free = sk_stream_memory_free(subflow->tcp_sock);
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a26c2c840fd9..a2fc54ed68c0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1422,13 +1422,15 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	}
 
 	mptcp_for_each_subflow(msk, subflow) {
+		bool backup = subflow->backup || subflow->request_bkup;
+
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-		nr_active += !subflow->backup;
+		nr_active += !backup;
 		pace = subflow->avg_pacing_rate;
 		if (unlikely(!pace)) {
 			/* init pacing rate from socket */
@@ -1439,9 +1441,9 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		}
 
 		linger_time = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32, pace);
-		if (linger_time < send_info[subflow->backup].linger_time) {
-			send_info[subflow->backup].ssk = ssk;
-			send_info[subflow->backup].linger_time = linger_time;
+		if (linger_time < send_info[backup].linger_time) {
+			send_info[backup].ssk = ssk;
+			send_info[backup].linger_time = linger_time;
 		}
 	}
 	__mptcp_set_timeout(sk, tout);

-- 
2.45.2


