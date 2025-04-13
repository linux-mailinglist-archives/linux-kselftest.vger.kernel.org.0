Return-Path: <linux-kselftest+bounces-30649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E6BA87157
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 11:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F2267AAF65
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Apr 2025 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C111AC458;
	Sun, 13 Apr 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+0OoWhX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5932F1A727D;
	Sun, 13 Apr 2025 09:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536912; cv=none; b=qnZ4/BFPaMgtCSB2lga8tJ+rr+ePVU8aVIPRA2XQMXnZK3G2VlGfLxHN+60kxN1Kk7V38x+D+utHWNdhZfhX7S9lX6qi+rbh3puhyN9GoyyF/X7SRoBIwBS/0gDiC8zy2tEYQjqCni2cp+KSW3WH0hGXNjcvqTytHvhFmg+Q6WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536912; c=relaxed/simple;
	bh=uEth5ubTM50FPsdKeFiaB6fDW7T8PGg6j4wHqWQHCKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pIwxF5Owazu7WxvQfbDCKvh2vKZ05aU8PTs0Qg4KDaKQzEzBxvoO4BLMFHVA+WsoyicVeI8RrXgxhF4CslEkIy/YMICSG1wBHVl+g6mLrQS9VRWHG736HM5J7ll7QO86963CpuPX0Q2nU5kiWw+xPsqZ4BtVJHOEf3aj6kPniT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+0OoWhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D42AC4CEED;
	Sun, 13 Apr 2025 09:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744536911;
	bh=uEth5ubTM50FPsdKeFiaB6fDW7T8PGg6j4wHqWQHCKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T+0OoWhXNyd8CqvhmjMI2hBGb1DrN4Q9ybNz3mQtifZ7CA7UgeDdT1pYPv3g7SthN
	 o1NGGGJd7Nnu7p/XQzIsZELMIhOOdCdbDWocMXsUspXDgZPYhhxn1mLL14f0oNnmGM
	 4Crz1GW9UslsUfprReKkHXZ6jql0Ld0pV9aX9nz6GqcRUotmA8L1ARCZsgS8gsMmhs
	 Sd/dFcqVTE1wgEEAHKh7khnfhwax0G3t+rN8ZylUUA4MZzvsR02ZpcIKkfibmj/x5p
	 hAEnSaOuOfla0Q+EDFI3pxSn17H6MX9FkN86AqzoJNt6MgLerO191mq29ZePbNqnLx
	 Elg+27pZMbWYQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 13 Apr 2025 11:34:37 +0200
Subject: [PATCH net-next v2 6/8] selftests: mptcp: validate MPJoinRejected
 counter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-6-0f83a4350150@kernel.org>
References: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
In-Reply-To: <20250413-net-next-mptcp-sched-mib-sft-misc-v2-0-0f83a4350150@kernel.org>
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
 b=owEBbQKS/ZANAwAKAfa3gk9CaaBzAcsmYgBn+4U5/1jsCuzuudCNCpj9kt+Yoa03wOP3SEl+U
 uiI0JFnmceJAjMEAAEKAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ/uFOQAKCRD2t4JPQmmg
 c+gZD/9SnOx/wyI3D5gtY3tx6PqPlkg3VScmdIUE3qpAMoh2ewKL50CIsaCgwjQzO6JhVgknq9A
 bi5G4CM3qwlpiLRhUS4D1dRNz4EWnKSF0IW6vYYhiuna2UYyjnYdoA4Vx55XrrC2RKLIGhb+VU7
 5xCUAv9rf2O5rUIO9hl9X2Jt9xQC8KCUDjVtnkb4gGUJiOxGrgpu+iOTVmdOEpWg+uMxnUuq51v
 /hGVGvejRONuAdN9mgD2Qc+IYgUY6e6+FI/QF8OG47gFFS6Obik6Ntaikcexub0nTLTVpVpzb4r
 L7vORJGmXm2yq1r5Pb7lndR7OhSSfwRIfgslzEf8SALYzd2kyRG33T8GQ7lm6Bf9KLSuAFO2t9Y
 4RvUBcp4irjn2+D3rpm0l1EAjmM0Aw4R4UTVb+Zeji0fg4IcSA0z6r0QRn8W7i9JmctpQPCp+nQ
 rX4W80CaxKHWHSURGmwbjTKsr00UM2UeLeLgoccJRoMpwJUm/GuBr1vTHBBozGu4rOGG+75eQvB
 NeDDX9YUUIUXHjiPOrgobzzNulUbUJiT3U10jcVsUxJ/Tbk1hGVNBXI5LbeJQUMhymInIPmwPU9
 aUEZvlJ26l9sIQDhDOFl01cmatFZoZOjISg+0Xn3iAIxY5EHZaum39aG/QtGlDhdkz4RoyrHVjK
 fL73ubCsqzzYMcA==
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


