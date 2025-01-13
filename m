Return-Path: <linux-kselftest+bounces-24379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA64A0BC62
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 16:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026A13A4C4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C2820AF9A;
	Mon, 13 Jan 2025 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlayQBfT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8DF20AF95;
	Mon, 13 Jan 2025 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783128; cv=none; b=JVcxSWTE8KFwGpoWKrQO0RXDCmVJr2vpY6RN8hsjkC9DdHH/qhVBBqLPZ1P2lrmDFTFYOOp323Ulie26G9860Fa08kjVLZRdHNSXdwyl9hJmEo+fq6iPWs5BjSXpRBQNyOnbfzEyeuDcx2elUl6jLRZMlWCH/eHnOmQg+gMOTdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783128; c=relaxed/simple;
	bh=ugNVgWtl26atWi7BtzLBGgkS6jelBYNZMUVYTnwVTcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEErZHybEngYHrakBrsmpZSTO21HDtWXrEWwSVaItsn2V1+iXjAYcYSuGPqE3xMjVVBtNCqvEPhtb93v5XvWVRQHQkO+BO0kUN3tHk+m2kkr7eI1u+BHM+9ZFeQIWsRW/59AWObbW9e5UZ0PB3PRkqChC0ldPMUgb8AwLVjNM0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlayQBfT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40CD7C4CEE5;
	Mon, 13 Jan 2025 15:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736783128;
	bh=ugNVgWtl26atWi7BtzLBGgkS6jelBYNZMUVYTnwVTcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nlayQBfTCq9kLSpc994NZs5IjJRV5h4wFdV5LGWCppda0j38fElxzwSOTItNdybWX
	 jzQusNqGozKLr1SagRL1G0cFHJnz9wq+2l3+yWiaSh5S6LZ7hUGwAMiQllqqjGzdRv
	 vT7rxsDVLKqDISEB9EsDTrVxMAO0IQVe4f6+PUgJyEFhUFxZ5uP/8ho4BB9oSbdF9+
	 WT/OoTg+a2uofukRDi/wbALoJa7FD2tTnczv61sdcIO5E8VTH/CHhLD/bbhdmz0QRG
	 BBqTGP9bWIvLQrvN7DdOK6y80Y4/ivTgtF8Xax8kAw4fWevDdzbtcFbJzABevTivxR
	 5ZKaccY/GCZHg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 13 Jan 2025 16:44:56 +0100
Subject: [PATCH net 1/3] mptcp: be sure to send ack when mptcp-level window
 re-opens
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-net-mptcp-connect-st-flakes-v1-1-0d986ee7b1b6@kernel.org>
References: <20250113-net-mptcp-connect-st-flakes-v1-0-0d986ee7b1b6@kernel.org>
In-Reply-To: <20250113-net-mptcp-connect-st-flakes-v1-0-0d986ee7b1b6@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=X8mzsaeWtbOt6rMrUcEg7CQDrWlfiCApjb9AfxhrAxw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhTURw3RVQlYDvo1NrHEl350PM3SBqxyrVwTtR
 Jjtcl8x4XmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4U1EQAKCRD2t4JPQmmg
 c27kEACvqRhdhNWfJNyGMIkgB7U9XQfcxxn/CJ94D3AW0jx0xolkl2g/ZEl3MvQG7V4Uw1+m70M
 12Y0aUa1WLsT4YrhYa8EPY2U3nE7eT07Wst++ipAuCpjWflauZQAT7dg0w7ZhekTEfsLDvx9jZu
 FFuUZ9yGKwUHI785pM0xewbqQoCHVPoV8ltkr+oxqNrK2WFKUEu01bhKmI7UfWWyhn5DPqWvnzO
 4b/RNkVHJk06Y/VOGg+dP5Ba08WEUv9WfdO3slEst27uYOPkBaqqQ+IdR0i3FAb0Ctzln9bg9jX
 JKNKxyeOWsYFNeSsj75WTn0TBI90kZq+GSiHUzDd4QpTlGY2P4FRHRntWDsEcakd6eBEk8ZmAlD
 IROBaXV55WbIjSsRir8DtGl20KmCm7vnDyaCqzFjtHYeZF93dFn6qKtZ76Qdb3MtwI2UJudBq4j
 wbwDYp9MDOXQdMXYIpwLlzscXWfv9I5g65qvXXca6dGnO/WyivHDclfJexcebyMhNtKPloZFPpz
 2R9YJyTPDymi+WpaopG/ojHzb6ATnLXKhMq1cyDShQ9wBxl/lglB1+S7+R8h77h40iyNDhe1uyx
 PlCfO1j0iID3DpY5JKoPcUqUQCHjYYqKOXOj+QBhU5wMlnx8O6To6tK6We8cWwboavluyNwxrNW
 QwigZ2QPIQkExeA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

mptcp_cleanup_rbuf() is responsible to send acks when the user-space
reads enough data to update the receive windows significantly.

It tries hard to avoid acquiring the subflow sockets locks by checking
conditions similar to the ones implemented at the TCP level.

To avoid too much code duplication - the MPTCP protocol can't reuse the
TCP helpers as part of the relevant status is maintained into the msk
socket - and multiple costly window size computation, mptcp_cleanup_rbuf
uses a rough estimate for the most recently advertised window size:
the MPTCP receive free space, as recorded as at last-ack time.

Unfortunately the above does not allow mptcp_cleanup_rbuf() to detect
a zero to non-zero win change in some corner cases, skipping the
tcp_cleanup_rbuf call and leaving the peer stuck.

After commit ea66758c1795 ("tcp: allow MPTCP to update the announced
window"), MPTCP has actually cheap access to the announced window value.
Use it in mptcp_cleanup_rbuf() for a more accurate ack generation.

Fixes: e3859603ba13 ("mptcp: better msk receive window updates")
Cc: stable@vger.kernel.org
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/20250107131845.5e5de3c5@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/options.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a62bc874bf1e17c4ee3b4d8d94eef4d0e7c9f272..123f3f2972841aab9fc2ef338687b4c4758efd4a 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -607,7 +607,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	}
 	opts->ext_copy.use_ack = 1;
 	opts->suboptions = OPTION_MPTCP_DSS;
-	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
 
 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
 	if (dss_size == 0)
@@ -1288,7 +1287,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 			}
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICT);
 		}
-		return;
+		goto update_wspace;
 	}
 
 	if (rcv_wnd_new != rcv_wnd_old) {
@@ -1313,6 +1312,9 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 		th->window = htons(new_win);
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDSHARED);
 	}
+
+update_wspace:
+	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
 }
 
 __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)

-- 
2.47.1


