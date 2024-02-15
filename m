Return-Path: <linux-kselftest+bounces-4807-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FCE856CA5
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D73B26990
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18D614690F;
	Thu, 15 Feb 2024 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNJENkXJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8053014601F;
	Thu, 15 Feb 2024 18:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021580; cv=none; b=iTpScc50w+O2rTssbKCiAOT0upZP1dzPbd+PLgVokQwGl8vjZD6GTWPY7SFCNxurjd3I5XVIRAgRgJ2C73zxyIB/PyS1e716KHvekEcXEdAnwmLsrfIHvpKBD5TyG4KaGXFGaD9p7QJfeizjFhsTm7vXmIBL0GkR1or9yzNkc8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021580; c=relaxed/simple;
	bh=x222K/iVJq1Vit9kTzhOmvETqEf55fuMWAFaC+bQJPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yfz1xghAVhZWzaJg6ncCzZtamNH/DrfzlLsNgsIhwMN3bL9lY6YwPdbyFtfYaysQ4kvOj62a1Z2khXctBSVAYYtLhk4FU2x5mexiAo6EesvQ4PtrQR2l4MdXpbiRGBOhdYHtYqOh82aCB2u0YQYxuJQerbiZW1zOwxRBaXxC9qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNJENkXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A69FC43394;
	Thu, 15 Feb 2024 18:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021580;
	bh=x222K/iVJq1Vit9kTzhOmvETqEf55fuMWAFaC+bQJPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eNJENkXJQd3tdenz6UODUvk6smrVpiDRE9Dbhz0k/rHhyIDmwPRjV8AP20UFaiXr1
	 2gpsp/H/0S47m3/kCpgJMQ0bKv1RVSH730ydj6nhTCAcx2xLxADd+A+VMRaogFIr4K
	 zpDwAxiXaw7uYrD/nG43dO1o6crao0msx0LGo+kUKZe3hcSLKMoikfHzqgdMsJco6i
	 HbpA/DqNWZvDGVvbJ72mgsp3R/2EzMgXkZLDBGZ2jOtyFVMGLrWKseXxxPThwLA+Uu
	 6qtk4fRO4yYaNCqysM1waQN/CuwTERtmkLZEpO5E4cg4jDsZeh3hiURbE590WJ5D2O
	 wOSGCOYpvt0LA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 19:25:40 +0100
Subject: [PATCH net 13/13] selftests: mptcp: diag: unique 'cestab' subtest
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-13-8c01a55d8f6a@kernel.org>
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
In-Reply-To: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2535; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=x222K/iVJq1Vit9kTzhOmvETqEf55fuMWAFaC+bQJPA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlcdkqqo1as8l+1WTgonChxLYAPdqGM3qqqWv
 xMvz1RVmtOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHQAKCRD2t4JPQmmg
 c7P5EADAORF4I6xRVCuIteRM18Viuxr5KG8CJBSnyQSeTV/vonia8wze3JPh9GE6VpUkY0bqPvJ
 Z6yMC991t6M5QFmkPW5hfBjuQQcqeeZ/40MuMkAM1ssJFVq67Dmw19grT1ZLjriD3qXaW+xn5rn
 h3nWRaxK0GZo1NE0tdkwTt0dsmJOfDSH0YSp8Gyxu4iBzbkXfcOV93FDcqdbJne+qTWVZxJKQ8H
 /UZQcRbbO0dWoRh42yISUgigPMQwQuFusT3h6xoIKLek5U97L0dyFquk/X57yRXuoiXu9kYiDI8
 sCvaQL+I6UhulZWWdKVc7bCi6690tmsA9/LFqUNl2n6lFTxJiEg9A0bwTp4L1bowf8UuwNggn+B
 r66SCrglwMHiYXrSJhDxHs9mabj3gGlhqFUzr6qGv3EA189mweNnRmnO12HEOoOTdhVCSoc51W+
 T7OWhhhs1BPgcfnGOjXuOe9tY90XJW6B6a5dZlKKIvXebdaxyVKBfQc//PwyMXFguUdNXd8cD2R
 Ur0C13HAFW7cHBV/cY63MJAzdf2lPQl+6ws8FX+erP5ES7dkboC9do2SeKQVQ4UkDiDYDTnokgF
 HfKz4bR1ASlAhkmE/IK2u0AR3FGAImFLy0kSqC/GUcg/AVyFytIlG4p2KAcCALzY3l3camMdeKA
 lr+DTNHNrTLEXgw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is important to have a unique (sub)test name in TAP, because some CI
environments drop tests with duplicated name.

Some 'cestab' subtests from the diag selftest had the same names, e.g.:

    ....chk 0 cestab

Now the previous value is taken, to have different names, e.g.:

    ....chk 2->0 cestab after flush

While at it, the 'after flush' info is added, similar to what is done
with the 'in use' subtests. Also inspired by these 'in use' subtests,
'many' is displayed instead of a large number:

    many msk socket present                           [  ok  ]
    ....chk many msk in use                           [  ok  ]
    ....chk many cestab                               [  ok  ]
    ....chk many->0 msk in use after flush            [  ok  ]
    ....chk many->0 cestab after flush                [  ok  ]

Fixes: 81ab772819da ("selftests: mptcp: diag: check CURRESTAB counters")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 266656a16229..0a58ebb8b04c 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -189,10 +189,15 @@ chk_msk_inuse()
 # $1: cestab nr
 chk_msk_cestab()
 {
-	local cestab=$1
+	local expected=$1
+	local msg="....chk ${2:-${expected}} cestab"
+
+	if [ "${expected}" -eq 0 ]; then
+		msg+=" after flush"
+	fi
 
 	__chk_nr "mptcp_lib_get_counter ${ns} MPTcpExtMPCurrEstab" \
-		 "${cestab}" "....chk ${cestab} cestab" ""
+		 "${expected}" "${msg}" ""
 }
 
 wait_connected()
@@ -236,7 +241,7 @@ chk_msk_cestab 2
 flush_pids
 
 chk_msk_inuse 0 "2->0"
-chk_msk_cestab 0
+chk_msk_cestab 0 "2->0"
 
 echo "a" | \
 	timeout ${timeout_test} \
@@ -256,7 +261,7 @@ chk_msk_cestab 1
 flush_pids
 
 chk_msk_inuse 0 "1->0"
-chk_msk_cestab 0
+chk_msk_cestab 0 "1->0"
 
 NR_CLIENTS=100
 for I in `seq 1 $NR_CLIENTS`; do
@@ -278,11 +283,11 @@ done
 
 wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
 chk_msk_inuse $((NR_CLIENTS*2)) "many"
-chk_msk_cestab $((NR_CLIENTS*2))
+chk_msk_cestab $((NR_CLIENTS*2)) "many"
 flush_pids
 
 chk_msk_inuse 0 "many->0"
-chk_msk_cestab 0
+chk_msk_cestab 0 "many->0"
 
 mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.43.0


