Return-Path: <linux-kselftest+bounces-16941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DB496851F
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20D21C226F1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 10:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AF71D3643;
	Mon,  2 Sep 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj4cRjXC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041471D319D;
	Mon,  2 Sep 2024 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273982; cv=none; b=e2VspqFnq9aS7sTvZ09gpEvzuy+u7GTsYYP+1UGvOtj8MQH5zkE/ItCsgXOi2QUObV1IE/kJpFWY1nvLYka7cN3sYPOZtsB5yXqNV79Ijlk1nqQjUITvjMUrNuxT2n/fmGQIgRCG7frkrbx2WSNOyd6nb54RUEIuU1NfGMKZUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273982; c=relaxed/simple;
	bh=Vtdr0gZHJALXFJUTrkl+lzXlvXaEw8QZdMvHVOvRCUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VX0nO5jk1syM9mjZAJ25aXKfSBlx4CGt2WoEwWEZfPberYIHb2Keoa+mQqPXJ1d5zC6V19wnVi07vw8lGTSjkCoA4QR+KkwDdXjgV7/pBc0sx9Q2oeAUmQ5gk9iHfLlLq5qSWyphoWnXUExntT9LcT+299aingjZLszbqY8qxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj4cRjXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F1EC4CEC8;
	Mon,  2 Sep 2024 10:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725273981;
	bh=Vtdr0gZHJALXFJUTrkl+lzXlvXaEw8QZdMvHVOvRCUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pj4cRjXCAIbsMvthu0G0CU+F7v9OjYZhAOo2YLDY5LGkbXXRUl9XTMF14EvDLZgV3
	 6OdvO/AFmfWNZOBRMJpWh7uw15VUI3muvzDXtA97Oyqhr+yM3R441Uvt55lFXsBAyK
	 09xR9BWwESf0FV+uySxecCDeiXoC5RRabA6QE1s1NoFbHYHgLY+dXfKfQkmiPYY3SB
	 P/vtAxqnCna/NeVOppqe+mICK8tz84SHgKHcFcBpBcYhg9wrmwAuA/j4uo0ciL24KL
	 FJBQTZgK7NKYtH3s5DlRVBKIS5UJZvJxHmEzkz/5z8Nb1EAGRkCSQYVl/hbVmnvBbr
	 aibmD/omJXcdw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 12:45:55 +0200
Subject: [PATCH net-next 04/11] selftests: mptcp: join: reduce join_nr
 params
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-4-d3e0f3773b90@kernel.org>
References: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2833; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Vtdr0gZHJALXFJUTrkl+lzXlvXaEw8QZdMvHVOvRCUk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1Zdt1MxyxM+cKyHlSzadAG5BnbKVoOuMjuNi3
 HsvoTaPy4yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWXbQAKCRD2t4JPQmmg
 c0WND/4kCfWb9vMduMedBs+rbUeOdCMi7XDb3zfDpaAIhBOfXINXEXzjhRFFXpJUlT0brV7HzbK
 CiR5K5Th31CmmeiWcVPb98DS3TAmWsWQuKwijMNpZ5gMaqx6lVfeJbQdzZibjNWF31Op70kEQvl
 2zVZndazsNFUCJNV10Ic/MKSJ69friTEKMsZlBHK9vQXp92EotGzivUUcxzg0CxFzdS9FXit0IB
 joj9c/jS9GLVQgqdVRNqiE2lbgjA/x8b4gYUAt3rmPbMn67m3E0n/gfOBgvH1isHbNX54Ai5Knf
 9zMF6cg6ZMTlmmSXJ5zNhbpuqs4GXhnU6C/6QkhZjRy+EEFFPd3TI+KZd7NLPyFU9lBQMtudFVb
 uON7NwM5BO2sJIEizP74eajzGIxdNUwbLjXXHkqAiBlcBHaWFOL8ndvAeYhF11vQPaU06eQDmkF
 dx4NUMh5l7ZKiJY5wR8/x/G5jE9Z+oHu3mqrLQPA6wa3gnVet3Twudd4ya+2m5B/er06WjD/ifG
 i6svlktVynnYGlqJGAl4ouSPL8Z9qXjjsmFa/nUSr9IggkIf/29iEm75NZbJd695kry69iBhCmg
 CtEhVO3Y0v+Hl60CQrjtcigzfUCi9RYGb2zOW5q/Y2DW6iF/R+f0b+GDXTxYZtzEscyH0BaeCMx
 qLBTVStdB1ozrwQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

chk_join_nr() currently takes 9 positional parameters, 6 of them are
optional. It makes it hard to read:

  chk_join_nr 1 1 1 1 0 1 1 0 4

Naming these vars helps to make it easier to read:

  join_csum_ns1=1 join_csum_ns2=0 \
    join_fail_nr=1 join_rst_nr=1 join_infi_nr=0 \
    join_corrupted_pkts=4 \
    chk_join_nr 1 1 1

It will then be easier to add new optional parameters.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 31 ++++++++++++++++++-------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a4762c49a878..51b226784c6b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -61,6 +61,12 @@ unset sflags
 unset fastclose
 unset fullmesh
 unset speed
+unset join_csum_ns1
+unset join_csum_ns2
+unset join_fail_nr
+unset join_rst_nr
+unset join_infi_nr
+unset join_corrupted_pkts
 
 # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
 #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
@@ -1319,12 +1325,12 @@ chk_join_nr()
 	local syn_nr=$1
 	local syn_ack_nr=$2
 	local ack_nr=$3
-	local csum_ns1=${4:-0}
-	local csum_ns2=${5:-0}
-	local fail_nr=${6:-0}
-	local rst_nr=${7:-0}
-	local infi_nr=${8:-0}
-	local corrupted_pkts=${9:-0}
+	local csum_ns1=${join_csum_ns1:-0}
+	local csum_ns2=${join_csum_ns2:-0}
+	local fail_nr=${join_fail_nr:-0}
+	local rst_nr=${join_rst_nr:-0}
+	local infi_nr=${join_infi_nr:-0}
+	local corrupted_pkts=${join_corrupted_pkts:-0}
 	local count
 	local with_cookie
 
@@ -3164,7 +3170,8 @@ fastclose_tests()
 		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0 0 0 0 1
+		join_rst_nr=1 \
+			chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
 		chk_rst_nr 1 1
 	fi
@@ -3183,7 +3190,10 @@ fail_tests()
 		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=128 \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
+		join_csum_ns1=+1 join_csum_ns2=+0 \
+			join_fail_nr=1 join_rst_nr=0 join_infi_nr=1 \
+			join_corrupted_pkts="$(pedit_action_pkts)" \
+			chk_join_nr 0 0 0
 		chk_fail_nr 1 -1 invert
 	fi
 
@@ -3196,7 +3206,10 @@ fail_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
 		test_linkfail=1024 \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 1 1 1 1 0 1 1 0 "$(pedit_action_pkts)"
+		join_csum_ns1=1 join_csum_ns2=0 \
+			join_fail_nr=1 join_rst_nr=1 join_infi_nr=0 \
+			join_corrupted_pkts="$(pedit_action_pkts)" \
+			chk_join_nr 1 1 1
 	fi
 }
 

-- 
2.45.2


