Return-Path: <linux-kselftest+bounces-30276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C613A7EBD4
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F40188CC0A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 18:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DD925D1EC;
	Mon,  7 Apr 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TS+QrSO/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0525D1E6;
	Mon,  7 Apr 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050409; cv=none; b=FdpocF1um6XB0T8mwwInmnhufcP3EuK2nTfP9B0GmA4kRwfBdgrDCW3ZmpBa7G4a6F6zxjVdVIbfH3JwOsaF9QYQD0xuSMLf71IU42xxiRoAqkdqQGxx6DFOFqy6Z0QKJ0x+tGAyUgS7kxv6lzKnOUJUsyQ8vpbBpVTt3GT5nn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050409; c=relaxed/simple;
	bh=MyHd0TjRnbf2Mh2HU4okOIGQEKf8vyY86oBFFW5OTAE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+SRucYB/Sn0oVsE8IFr4clRbvieRqkdBR33t/y5wa0ohhs9+wjAjEuXvv1JaCFk6N4AGEYX8Ttk3hsqxjr+1hurPRJ8YwgKUuTj/mVdVAT4dL/aR/ONTO7R9NLq6p7onu3hIkDzSceo20bG7mJurYHHoVHg575GchltZpEd6VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TS+QrSO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4A1C4CEDD;
	Mon,  7 Apr 2025 18:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744050409;
	bh=MyHd0TjRnbf2Mh2HU4okOIGQEKf8vyY86oBFFW5OTAE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TS+QrSO/66kDHas/i6aI/fa+aEcoXxEe0MZBm76l8899NeQjiVhm6i5HcizWEAJCa
	 aDnKh4Em5FDzcz5tSOCgoUHKj+M8pwD74xhhEYtNFWWUc/RicnIKYjCHvi2ESwcHKU
	 sit9HlBXGyJibOuUGFcd27/SLk5UIocTtdnRTEAREL77j6FmW5B4J3RtgjatFsQ6UP
	 bUuMgDcDaO0HyoYneLH9aitvfHFTTzgxW7uS7TTElc4HHZ7iAEkXvZDL1AISFrxy/z
	 BZ1R0tSc7pc/b4Gg+dvy5JC0wAaut4ALTZOs9tjkKvMddjiXe9pdL4wfLv+fjSzFvC
	 8bnmeEUbwKFOQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 07 Apr 2025 20:26:33 +0200
Subject: [PATCH net 2/2] selftests: mptcp: validate MPJoin HMacFailure
 counters
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-net-mptcp-hmac-failure-mib-v1-2-3c9ecd0a3a50@kernel.org>
References: <20250407-net-mptcp-hmac-failure-mib-v1-0-3c9ecd0a3a50@kernel.org>
In-Reply-To: <20250407-net-mptcp-hmac-failure-mib-v1-0-3c9ecd0a3a50@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=MyHd0TjRnbf2Mh2HU4okOIGQEKf8vyY86oBFFW5OTAE=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn9Bjg1Gtym9sISXFIzb2ww3e06wI6gWVSgTfH1
 yphsTczaXqJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/QY4AAKCRD2t4JPQmmg
 cwdqEACUb/JbM+TljiOqLHuRMZxE3Sezd2TIZU4UFTVNCCo+OfZBy9VA/KAAeXki3x34CgZh75H
 7cAoZacSWacZjDyUHN+c0Y14qlMM3bXuy9Y6G40Crsg7Sg+CE+qFk4mreedn+s94Rc7vg4Gki+j
 kLznkDLwZsuhJfA02c73xdjtcRFO98GvPkZXb8yN3egUJi1Vwb546JwhiBeXgihNtESYhTkb+tZ
 xW3+q1PV1iOyu6MmRwTwcO7zQCB65BlM6rvHqVQez00kZE6FJXQQQAOQGMH3+pXQ3tCrlOHTBxZ
 2Lhoe6btlD0mi+NRvE34hzOiXweAooZyjU1EHe3iQXUSVYtGiwx7Ak0gl2jgNcxQuSIQuRlpLHY
 vCTIDJqkRowDHX/GAiXDpQF/kWGFWhU1Wv6r3nTT61FvfQEcpRfZBB8WPjv4j0o3ATQ6cgvoZQV
 XdUGB8HoZOTT36VcG4eKwmyEpIab9PuHc0NP0T18Xu8iGeJDu1+alBOQ2nSyiIwKI6yL0Jjh9zO
 3HqAY79sa1c8fGd+lKWEhE1NcE+uG25dG1vwVJBUuHROuDerDZYD0t31caraNqWrZq68wAB/eTs
 x8ZIa1GnmtCxhSY3Q+367d2UgZ8wRWbmKcwo7+rmfwEpAJw/1yMKtBNq+kylevpeuIFLFOypC8s
 XRLLEptn9EJje/A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The parent commit fixes an issue around these counters where one of them
-- MPJoinAckHMacFailure -- was wrongly incremented in some cases.

This makes sure the counter is always 0. It should be incremented only
in case of corruption, or a wrong implementation, which should not be
the case in these selftests.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 13a3b68181ee14eb628a858e5738094c3c936b74..befa66f5a366bb738f8e6d6d84677f5c07488720 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1441,6 +1441,15 @@ chk_join_nr()
 		fi
 	fi
 
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckHMacFailure")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "0" ]; then
+		rc=${KSFT_FAIL}
+		print_check "synack HMAC"
+		fail_test "got $count JOIN[s] synack HMAC failure expected 0"
+	fi
+
 	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
 	if [ -z "$count" ]; then
 		rc=${KSFT_SKIP}
@@ -1450,6 +1459,15 @@ chk_join_nr()
 		fail_test "got $count JOIN[s] ack rx expected $ack_nr"
 	fi
 
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckHMacFailure")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "0" ]; then
+		rc=${KSFT_FAIL}
+		print_check "ack HMAC"
+		fail_test "got $count JOIN[s] ack HMAC failure expected 0"
+	fi
+
 	print_results "join Rx" ${rc}
 
 	join_syn_tx="${join_syn_tx:-${syn_nr}}" \

-- 
2.48.1


