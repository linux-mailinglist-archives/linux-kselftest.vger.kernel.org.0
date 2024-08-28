Return-Path: <linux-kselftest+bounces-16506-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAA0961F56
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2670AB2399F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDDD15A86E;
	Wed, 28 Aug 2024 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1MAjpLG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA5915A84A;
	Wed, 28 Aug 2024 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825693; cv=none; b=KF8tkkT7j4OgNAgS8uG36UJGhdyBxqXIEGICDCkWdtHLLe5pIYXfJVjsdKg04vx57vbpx9gk9OVuMw895kV8sPFWjrhfEwmDiaxknejpXt23x2b56jXd8+ODXDRNZ+dcsHkrAt7I6Uh0smbmjYQwehjDOnCQZXUq2IRbxoiTYGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825693; c=relaxed/simple;
	bh=qnbnrR81GAF8Bj7sJdSNyDd+ji6i9sPPwydt+P/sbIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhdVqGMBM9vn4c55E9tSa76MtD/y1j1ehT/DEbdlZ2OZWIPmiu5Biskdj4MfklrdhQH4Gl43MlDcQ/Hd9C5vWj7xiSzDNFAACXDNyVWIN1gn2YDxi6qwRcr9Hv3Nf7PmlW4v+SoOA3klN/9P69OlVJt2utFzOsloBZ20LTvtuIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1MAjpLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B02BC4AF60;
	Wed, 28 Aug 2024 06:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825692;
	bh=qnbnrR81GAF8Bj7sJdSNyDd+ji6i9sPPwydt+P/sbIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S1MAjpLGeYLkuCv5KXowkW3HGBjXUfA6Z561nsFBLZPU5VVNkQAno1dB8vpwiw+Jm
	 SebFC1Xe8ci2ptuz1Qf7Xh/C65yjrwJyMIdTM7RjN0UtyUf84loBJEz/vJL643lYo4
	 uPNXd2CSNmPCkZ/hQH+Ox2no/fQa2AygNp7sFK+sURfj/6Gbqyg3RwuyvdyWVQGVVb
	 qqvy/qiFoeoGY/mMrgRHROC7cR16EsJ5TbOrXAnT/Z8C+dyJPq61KwYLwnjjs6Y7Lb
	 yRaQzlRAahJUfDPyEIr2+LqgRiGVGkKw0z8ced+O5MY7S5pisFFf2anrPohCrmD/PB
	 ogZctcPvo0Hjg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:28 +0200
Subject: [PATCH net v2 05/15] mptcp: pm: skip connecting to already
 established sf
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-5-7f11b283fff7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1788; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qnbnrR81GAF8Bj7sJdSNyDd+ji6i9sPPwydt+P/sbIY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBHe0L7LQj+ZMAw7uoDyJOIbEhbKJ7U1ev3V
 t3mRxBocKyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ARwAKCRD2t4JPQmmg
 c5/0EADTkyYLH2BlAcbnjygLqERNrbQcXHxxzwVofyRuHs7/B/sxigRUw64jUQmQ/lqBl6GYw1t
 AKHicf5V/8zFuAdRQeJ+eOqyZjkTvbXrOEGyViVMPMSXiD2ddwbSXoN/548KLwxVagROl/13YET
 oaq5d7iJVH5bG9bk8+6s1BPXtHp7HDOTCOYMWh+iWRa/6lhbMQWXVpI4sVBQX2NWpAMBPdEsuAz
 4s9HyLLhuJZ1KIb5sDnOkq1U0dXy869Q/Ftg2507PExlLRQ1Dl9aiM/pA6TDAS/jPh564DzbLBh
 xzwPHw0yL+3f0jNJtTCn1sN7w8PQXL6V72O43yQ0SYJ2rCBBp327OcTRpZ6vpOSFSScHYymPUlt
 dPnw20w6LefW8nNoMH9htD+0tHGpofht7cLlVNbmFsBasEW4o/Mee6LETafghXuR31FopNRDm21
 F3b7QeUDKPfmNEkup3cpdeQmO3F0BPfIdWQoVwtLhHKqUN6hULeDg6U+hn7Y3oqVW41yMr2pcHa
 sUrHUISwP7haGMb+aUhkcTvOv/foKu/FYxdXg3nXspHmknvQbJhzSWNBePXDEOk1x6FdCE/uOeQ
 yHuZJc02Eq4QTcBKGFfLEaHvcwb62FQVdsVjjkYMkt6gwivEUwlWdgCNovBTgjPAZ6lVUTlQUgj
 GkY15qDhCRObm8w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The lookup_subflow_by_daddr() helper checks if there is already a
subflow connected to this address. But there could be a subflow that is
closing, but taking time due to some reasons: latency, losses, data to
process, etc.

If an ADD_ADDR is received while the endpoint is being closed, it is
better to try connecting to it, instead of rejecting it: the peer which
has sent the ADD_ADDR will not be notified that the ADD_ADDR has been
rejected for this reason, and the expected subflow will not be created
at the end.

This helper should then only look for subflows that are established, or
going to be, but not the ones being closed.

Fixes: d84ad04941c3 ("mptcp: skip connecting the connected address")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index ed2205ef7208..0134b6273c54 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -130,12 +130,15 @@ static bool lookup_subflow_by_daddr(const struct list_head *list,
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_addr_info cur;
-	struct sock_common *skc;
 
 	list_for_each_entry(subflow, list, node) {
-		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
-		remote_address(skc, &cur);
+		if (!((1 << inet_sk_state_load(ssk)) &
+		      (TCPF_ESTABLISHED | TCPF_SYN_SENT | TCPF_SYN_RECV)))
+			continue;
+
+		remote_address((struct sock_common *)ssk, &cur);
 		if (mptcp_addresses_equal(&cur, daddr, daddr->port))
 			return true;
 	}

-- 
2.45.2


