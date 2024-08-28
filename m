Return-Path: <linux-kselftest+bounces-16512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F6F961F74
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 08:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64A57B23C37
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 06:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6991662FA;
	Wed, 28 Aug 2024 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bgxyixyy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5F514883B;
	Wed, 28 Aug 2024 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724825713; cv=none; b=NRh8+CNYik5BS85V23fxyph5y573SmYISVbbQZnQoTBDNT5/g4mKyloKJ0kbEnTgf+QsNW8pw2kNZ1zwS56PIPc90EcQF1zj+/4R4AgLfYoaPZmPzCkt8GYe9xA+WAcp7tAJGFXNGnvooXWwX9UTchNgJhREdz7+vG1AUk+yBg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724825713; c=relaxed/simple;
	bh=A1J0kbgQ6pNp+/oNsxHOqRSA/QlDKuy6GV2otIOgtEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2GASbIcMvw63i0RvjV0M/NJSg1YsMcrh9oBnh5TMe2Cd61DKjbKPIRQNLV0ErXgg+uWVngynJKNC1ybCxXxPIa2Eh+yUOeSsyP2KVFMLyNvHA3l+bD6rmVl2za95YcEx6AcW8lsSD9sELivo0zNXox5bc0SmYDfDb+YGKdq0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bgxyixyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E39C4AF66;
	Wed, 28 Aug 2024 06:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724825712;
	bh=A1J0kbgQ6pNp+/oNsxHOqRSA/QlDKuy6GV2otIOgtEI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bgxyixyy9dcZRyyoTyMNvpocmLlFg3pubncIp7vtSgbayEnOKd3xDQFFiDRF+QUSv
	 wzswd6nSblmanQ8OBwmMoLcRfM5umTi4NpHfbzVy3etnqVh9wk+DEQW8gIEZot/R3T
	 M42HwyW0wQ76z3AQ9Bv2yRfBGUws8p62ZWXLoNCGJwtVXwIMkmRSg+Z4usEgymsi7t
	 H7SViZOZt+yOevIwDGpLlxyi1ZYE7Ovc1he57CuJaRX28dnSpbxgJ7URlpVHkLUU62
	 FqJ+VV7+BUORNjgApzMVfx9AaNIdvUGVkRwoqvWIzAiRV4YkeYCb9D8pE25DotnO51
	 O0bJeWRJx6SXg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 28 Aug 2024 08:14:34 +0200
Subject: [PATCH net v2 11/15] selftests: mptcp: join: check re-re-adding ID
 0 endp
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-net-mptcp-more-pm-fix-v2-11-7f11b283fff7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2831; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=A1J0kbgQ6pNp+/oNsxHOqRSA/QlDKuy6GV2otIOgtEI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzsBH8RO6crlm5euDAXMbP1l1+bs9XGQ/Zcl9B
 3k0mk4DhGKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs7ARwAKCRD2t4JPQmmg
 czaSD/99XeouTS8j4WDpJj6fBSGNifIE/Ma45+LbcokQNEMCygFcIvEdLL+TgQgvNZDqjhaCtGs
 FvdFUz/EKfN+jZsw7bI+yFzX1ZdoAguFSe3puGrPZZ57M4QfapMu2tK1/XF2hEP8py++oz1JFBF
 RsWw2/uIfNfbRnqIZi85rSoD9WaHe2xdObHUZAas4aaMyIfwsSobbCcPpJcLPHzoiiayV/VNZBb
 Rt0asXYck+nhofDSR5blck7JCUQiRbMTniu0aNWtB1adTY0Lthk2GzhnVksEG8faGTn5fUGNpQg
 bLUjHGKNjwNLZlK3uXNlEGmz7pruFKnPxyqmSWSwbgb0UEYzh+h/0NaKrDfLyn6ZxsIAVt1Tm7f
 H1la3Nnin8hhxAY5bpeeqPBFzClY1InlxIN18ixw5LHfS9GWBqPpeXvaJPeA4w/35wo/XdUOHBS
 2YITBygiMzdBUVKlAYmCJN708Ry4x8Y3fVSm2pt7QzDtBfv99FIihunP6GJJw8JGg7JCya3lEvx
 j6HUiUIBhZnBuFJnxtWKgrdu0aYBmL4SsEtcEDwbXQ38CzJANYUx0n9T61cZRZWz7yivTsh6gDi
 +PORGj/DHNxXysN68mKDXoKN08AvuyEZOAJnuvueZ7VaYCOQLSGXaMQLa41DczHD7fQa9N7ADuf
 fmeV2BnSiOG4/CQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This test extends "delete and re-add" to validate the previous commit:
when the endpoint linked to the initial subflow (ID 0) is re-added
multiple times, it was no longer being used, because the internal linked
counters are not decremented for this special endpoint: it is not an
additional endpoint.

Here, the "del/add id 0" steps are done 3 times to unsure this case is
validated.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 3ad14f54bd74 ("mptcp: more accurate MPC endpoint tracking")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
  - Make the connection longer, to have time to finish all the endpoints
    manipulations when executed in slow environments. At the end of the
    operations, the connection is killed, so it doesn't make the test
    longer. (Jakub)
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a10714b6952f..965b614e4b16 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3576,7 +3576,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 0 3
 		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		test_linkfail=4 speed=20 \
+		test_linkfail=4 speed=5 \
 			run_tests $ns1 $ns2 10.0.1.1 &
 		local tests_pid=$!
 
@@ -3608,20 +3608,23 @@ endpoint_tests()
 		chk_subflow_nr "after no reject" 3
 		chk_mptcp_info subflows 2 subflows 2
 
-		pm_nl_del_endpoint $ns2 1 10.0.1.2
-		sleep 0.5
-		chk_subflow_nr "after delete id 0" 2
-		chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
+		local i
+		for i in $(seq 3); do
+			pm_nl_del_endpoint $ns2 1 10.0.1.2
+			sleep 0.5
+			chk_subflow_nr "after delete id 0 ($i)" 2
+			chk_mptcp_info subflows 2 subflows 2 # only decr for additional sf
 
-		pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
-		wait_mpj $ns2
-		chk_subflow_nr "after re-add id 0" 3
-		chk_mptcp_info subflows 3 subflows 3
+			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
+			wait_mpj $ns2
+			chk_subflow_nr "after re-add id 0 ($i)" 3
+			chk_mptcp_info subflows 3 subflows 3
+		done
 
 		mptcp_lib_kill_wait $tests_pid
 
-		chk_join_nr 4 4 4
-		chk_rm_nr 2 2
+		chk_join_nr 6 6 6
+		chk_rm_nr 4 4
 	fi
 
 	# remove and re-add

-- 
2.45.2


