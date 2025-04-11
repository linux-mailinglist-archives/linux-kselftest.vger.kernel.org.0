Return-Path: <linux-kselftest+bounces-30579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E16A85B40
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 13:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F82C9C53D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 11:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F58329C34E;
	Fri, 11 Apr 2025 11:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZubRSVd6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF379238C13;
	Fri, 11 Apr 2025 11:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744369529; cv=none; b=LrJAmgAuNZxRRzWDcIj9n1COmkuvJ/gTKmyL3tgbtiwb4QaknHpH20W0ge4D+8AxTVH4z7CEz/E/qhiy1eRspDnD5hQ3tWp1QpW6yI6tgKxksISJqckFBW9mh5MYmSIbbpkjIdjC0IGVKVSd8SiwsJpdOu4fJCjAxb7xMxtEFHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744369529; c=relaxed/simple;
	bh=uEth5ubTM50FPsdKeFiaB6fDW7T8PGg6j4wHqWQHCKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kf8dV7M7BkUUJgpawxZrR4Id+c8VVeAq4+orEE3wG3/aSVxwkV2syiYoVjY+QJpNB+AmdL27OEaaP73BV+b1uD0sOL3M32WZm/ovuQtkqxKEkoMJPvEkHmsDPFc/1vwAg58s2sIC48Xm4xXqzLe6LaTRjJuqNbgLH7Y98b5X80M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZubRSVd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854A7C4CEE2;
	Fri, 11 Apr 2025 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744369528;
	bh=uEth5ubTM50FPsdKeFiaB6fDW7T8PGg6j4wHqWQHCKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZubRSVd6uLMR3sQ3BjcUGdI/+QHUmzf1BCp6HVu0uiC6ozFBidzrd3bJXX3oJgEXl
	 +pH1WitqOHJ4HRYaJBe5j+qra5oKs5CQLNhXf9DgstrdzGbQ42RFqB7qogZCezUYUv
	 NPpOSsKRYRUG8e2S9o39Xep0zVsFGYwMxayAMn59ZPYIh8xQvIa0qqVhJbDHwxHCbm
	 +8HIb6/gSzpB0iEQSezZzyaylS3ybl3EvDC4lyp8YwGth+64Znm/EVyFVuLJ6tGcZU
	 9bnrK25LanPkPrNqNdtajZhVtiPqAqPo8eU2AoiPGX5m3+tPmwb318GlVjbg6eG8g/
	 sXapeXz3iGkZA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 11 Apr 2025 13:04:52 +0200
Subject: [PATCH net-next 6/8] selftests: mptcp: validate MPJoinRejected
 counter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-6-85ac8c6654c3@kernel.org>
References: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
In-Reply-To: <20250411-net-next-mptcp-sched-mib-sft-misc-v1-0-85ac8c6654c3@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3395; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uEth5ubTM50FPsdKeFiaB6fDW7T8PGg6j4wHqWQHCKM=;
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+PdiGy0HbieqA5qhd/lWETGNK/zaYgdLFQFBa
 AhTTn8hGC+JAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/j3YgAKCRD2t4JPQmmg
 c4N6D/9SDgxNBlokavt0zbvIjUmnq7aWoz4oPcwCKb3wOZojDKXqcGao99hQr2+ZSRhsjr/UJCJ
 Ytzd0ggFYTyUsYM+QBr0qMz5Gxd2b0m/xsG6DuJ6dBpLp31/AyI31WisfdL5j01xVc26eNnSMnk
 aDRWOpy7eYqxOiOs5Xei+OegYzklOX87d0C0F+LdVFxPqwFHRgNLy4TWDouPsczd7RxaviG24SW
 ql8l1CrIigOv/I2KQgLD0MfBuRgzkvx8FD1ceQ6mxVGxc8omAfZVJX+vITIbmgzmceiwUYfgdG4
 VqxJ3EFR9tksxPcRMb7QNAcD4VsZmx5PhQQ6R9V1ozq7CjaqlLDIcAtnSDKk6kNI0xZfn6m8gWi
 a+qDqL5qYj9v2cczQfSQFTfU0S0tTdRIaHx8H20NpJRCnATjmr7VEvfTZBW3ADMIjl7CmlFWgAu
 FdYQCi12FXBQ7FFvdc6Sca7LeaRAbtZyEnkSeQ1oBxqlg4r3pw+tsFbR58W5CYLmf9VCAsW+Fy0
 9ATzVWKLQ2kNtyp70y9RslFN/moe/QDV4JamewxTnMvDFyjbrlfGWmL8cFGaai4iMySoX+5S7Jk
 IozdKgY4xdT1peRrH/HJm/6DFrmRz3lVaxFyGqPPMx/vpF4P67LCfP7bhKpNviwkz3eiBkEPhJQ
 0NMchadsqeoRUUw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The parent commit adds this new counter, incremented when receiving a
connection request, if the PM didn't allow the creation of new subflows.

Most of the time, it is then kept at 0, except when the PM limits cause
the receiver side to reject new MPJoin connections. This is the case in
the following tests:

 - single subflow, limited by server
 - multiple subflows, limited by server
 - subflows limited by server w cookies
 - userspace pm type rejects join
 - userspace pm type prevents mp_prio

Simply set join_syn_rej=1 when checking the MPJoin counters for these
tests.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 26 ++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index befa66f5a366bb738f8e6d6d84677f5c07488720..b8af65373b3ada96472347171924ad3a6cf14777 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -62,6 +62,7 @@ unset sflags
 unset fastclose
 unset fullmesh
 unset speed
+unset join_syn_rej
 unset join_csum_ns1
 unset join_csum_ns2
 unset join_fail_nr
@@ -1403,6 +1404,7 @@ chk_join_nr()
 	local syn_nr=$1
 	local syn_ack_nr=$2
 	local ack_nr=$3
+	local syn_rej=${join_syn_rej:-0}
 	local csum_ns1=${join_csum_ns1:-0}
 	local csum_ns2=${join_csum_ns2:-0}
 	local fail_nr=${join_fail_nr:-0}
@@ -1468,6 +1470,15 @@ chk_join_nr()
 		fail_test "got $count JOIN[s] ack HMAC failure expected 0"
 	fi
 
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinRejected")
+	if [ -z "$count" ]; then
+		rc=${KSFT_SKIP}
+	elif [ "$count" != "$syn_rej" ]; then
+		rc=${KSFT_FAIL}
+		print_check "syn rejected"
+		fail_test "got $count JOIN[s] syn rejected expected $syn_rej"
+	fi
+
 	print_results "join Rx" ${rc}
 
 	join_syn_tx="${join_syn_tx:-${syn_nr}}" \
@@ -1963,7 +1974,8 @@ subflows_tests()
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 0
+		join_syn_rej=1 \
+			chk_join_nr 1 1 0
 	fi
 
 	# subflow
@@ -1992,7 +2004,8 @@ subflows_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 2 2 1
+		join_syn_rej=1 \
+			chk_join_nr 2 2 1
 	fi
 
 	# single subflow, dev
@@ -3061,7 +3074,8 @@ syncookies_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 2 1 1
+		join_syn_rej=1 \
+			chk_join_nr 2 1 1
 	fi
 
 	# test signal address with cookies
@@ -3545,7 +3559,8 @@ userspace_tests()
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 0
+		join_syn_rej=1 \
+			chk_join_nr 1 1 0
 	fi
 
 	# userspace pm type does not send join
@@ -3568,7 +3583,8 @@ userspace_tests()
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 0
+		join_syn_rej=1 \
+			chk_join_nr 1 1 0
 		chk_prio_nr 0 0 0 0
 	fi
 

-- 
2.48.1


