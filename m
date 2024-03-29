Return-Path: <linux-kselftest+bounces-6872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66D6891859
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 13:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC9A1F23202
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 12:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EA78593B;
	Fri, 29 Mar 2024 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="upNIFOWH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7192785627;
	Fri, 29 Mar 2024 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714171; cv=none; b=IgvGW3X1dS9wfmUKsqzwlkS2FB/zg4IpdR6Z5mxYoUG9I0XgEIeRSlQDLPBbfPPNvI0YffJJtJZ4fqIN+0Xae9fvGEjh83FmttKPT34Sj8yMji2NLTsHNuQgo1D/4sIGQycEPqI8IQyq16Heu584Bef7APZV9Pe1qC2vY+2PTWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714171; c=relaxed/simple;
	bh=obJlusCKO+aBYVZ+i1x3VClG9Vg+uztrKe0aVWem1RY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c85U7OHmxH5ii5ZpJ6acbN4VyJniExSdKQIJzkL3rv4YjQJ94ZXNXWYw7aY8chQOKVLxeszq8UaLEnLI4NvjWs4M6oB6MmM9QM02uL7ENi53mdVMHjMG9genXO8EiJhOviutLJLi5k7EEDk26vlWA1bj1OpW8WvZGLfvhhtbWb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=upNIFOWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DCFC43390;
	Fri, 29 Mar 2024 12:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711714170;
	bh=obJlusCKO+aBYVZ+i1x3VClG9Vg+uztrKe0aVWem1RY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=upNIFOWHxhhnBYjAVXxlMjEx2qopiNxMBczsvGnsQ+6puhXtiEgQzwzniCCj7y3ca
	 PE+4WKqjbcapvtWTY1moeCiEZnNaEhe54soLv+XAxAF/U+aJT+2gmxD8ortCZ58YJf
	 owKf4Vn9v6ejKcJBvD54ij/UcGmiFCtjqZYV+K2zYcX/KcWJyGwmu9knc0EAg+wiLG
	 acnD6dAGYZFEpQXtc8qjarZb80KNWDM595WbG1xE2ws4l0Zylqd57ax1wGzTI6RLHM
	 prieuNYnTpw81Cf8gil82xgkUiE90XEo2EBJeFf1PZNUcz4pWH7Hn/6VAdv6sQvzNv
	 bNftOPWetJ0dw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 29 Mar 2024 13:08:52 +0100
Subject: [PATCH net 1/2] mptcp: don't account accept() of non-MPC client as
 fallback to TCP
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-upstream-net-20240329-fallback-mib-v1-1-324a8981da48@kernel.org>
References: <20240329-upstream-net-20240329-fallback-mib-v1-0-324a8981da48@kernel.org>
In-Reply-To: <20240329-upstream-net-20240329-fallback-mib-v1-0-324a8981da48@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>, stable@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4403; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uIT1YFuZreybFhf23UwWyib0d2owauuM4ktB3kWuvgg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmBq9yVMeY8O4/CWfhbfoWjtO83lDFkK2ICh05b
 ayDkyx0uU+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZgavcgAKCRD2t4JPQmmg
 czZAD/4wPMFT1XAIgaI4hsXrsFZl4ZWOHs95nHoQKiYOo4y4iJ6DChL7LizuGSY2bnW6xM5g6Yr
 5fRJ/ig5/ksBPCwkMoPsiWjbJc8yZT2DKzN2+9iTNfhrrp0KauxUss3YsjyyJhnSVrhKFwzP2Wx
 dZKqb8ZtcZQB/X3rww3y77h4qK+ShOuu5Fz7np4JZlkaY95R5ullTRXSUMEN8qMxHqWwdGkFSws
 n1k9J2bcVmFcugNsgPVT2GAG0gs5enM51TbSgKZDiBGMFFZ3R4YUApBcxa+VFcwtWOFkRwcf9wX
 scODVky/RH74xcnrThzORa4CSBpz2h+DL3bWSiu5EQgbCSI0PyZTAHW6eySgrFCZXbNs+MmqCLs
 amJGgpUwoVDXiNAI8a+yY9GBY80ooYPk/KCYQVOHHlOcKLxMg6coKeIMN3GMpidvaZBwqujtJmw
 WxL2sOSfBe1uJz5iAlyOABu7wHJJTWf2FWer/R2B/JdA2+0d6q26b2BqgQBh/42Ft6Kz5ED4KKR
 jWyrPkGzSkutm0KxgdDwAUX60RNgVXAh7ZuvvmRJtakxTrG0cG2Sm52Zah7C0pWaSw+xasXonxK
 TQc8eNAmKbvL/915gOqrnLxM5q5mAbQBAWmUR7gQrkLuN8zqpzKUiQBaQPdufVtkWiUDbM+zwLF
 mD5+0yd951ExA8w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Davide Caratti <dcaratti@redhat.com>

Current MPTCP servers increment MPTcpExtMPCapableFallbackACK when they
accept non-MPC connections. As reported by Christoph, this is "surprising"
because the counter might become greater than MPTcpExtMPCapableSYNRX.

MPTcpExtMPCapableFallbackACK counter's name suggests it should only be
incremented when a connection was seen using MPTCP options, then a
fallback to TCP has been done. Let's do that by incrementing it when
the subflow context of an inbound MPC connection attempt is dropped.
Also, update mptcp_connect.sh kselftest, to ensure that the
above MIB does not increment in case a pure TCP client connects to a
MPTCP server.

Fixes: fc518953bc9c ("mptcp: add and use MIB counter infrastructure")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/449
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c                               | 2 --
 net/mptcp/subflow.c                                | 2 ++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3a1967bc7bad..7e74b812e366 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3937,8 +3937,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 				mptcp_set_state(newsk, TCP_CLOSE);
 		}
 	} else {
-		MPTCP_INC_STATS(sock_net(ssk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 tcpfallback:
 		newsk->sk_kern_sock = kern;
 		lock_sock(newsk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1626dd20c68f..6042a47da61b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -905,6 +905,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	return child;
 
 fallback:
+	if (fallback)
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	mptcp_subflow_drop_ctx(child);
 	return child;
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 4c4248554826..4131f3263a48 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -383,12 +383,14 @@ do_transfer()
 	local stat_cookierx_last
 	local stat_csum_err_s
 	local stat_csum_err_c
+	local stat_tcpfb_last_l
 	stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
 	stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
 	stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
 	stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
 	stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
 	stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+	stat_tcpfb_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -457,11 +459,13 @@ do_transfer()
 	local stat_cookietx_now
 	local stat_cookierx_now
 	local stat_ooo_now
+	local stat_tcpfb_now_l
 	stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
 	stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
 	stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
 	stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
 	stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
+	stat_tcpfb_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
 	expect_synrx=$((stat_synrx_last_l))
 	expect_ackrx=$((stat_ackrx_last_l))
@@ -508,6 +512,11 @@ do_transfer()
 		fi
 	fi
 
+	if [ ${stat_ooo_now} -eq 0 ] && [ ${stat_tcpfb_last_l} -ne ${stat_tcpfb_now_l} ]; then
+		mptcp_lib_pr_fail "unexpected fallback to TCP"
+		rets=1
+	fi
+
 	if [ $cookies -eq 2 ];then
 		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
 			extra+=" WARN: CookieSent: did not advance"

-- 
2.43.0


