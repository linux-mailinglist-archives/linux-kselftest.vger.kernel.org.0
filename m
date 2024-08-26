Return-Path: <linux-kselftest+bounces-16305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734495F5E3
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 18:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BBC2820CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 16:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCAF199E95;
	Mon, 26 Aug 2024 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7ih0KqV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF48F199E81;
	Mon, 26 Aug 2024 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688002; cv=none; b=rjwmMiv94yjeCgLqFNIz6D81voy7kXFEItxhCPYPMKGBZnaAAFXGjqn7tVuxvEQ5gXPYiIarXwL0HzZVMv9ML6wKqnC2/5/Z+5jEhmVTdQQtRHJg8tud69+h/Jrktd8GGElw/kvgXFmwBv2R9SCS+JlbBewv5RQURejtaYZtdwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688002; c=relaxed/simple;
	bh=hUqiD6tize0J9n0G4qdkSCPdVIDOqJXQoFvZCB47rv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDr7dvpc8xxwgdxBPDvWyZg+YRZ3zfh3nYrmRaySJgzh30qV1N0+Xg7lZR3uojD857TPrJaHfJqhOFhZwg4qhwsguEv7kdI0zHYvBKWZ+tJm17Hjln48U6g2tRY7WRQ2sz4ap3cgKUHGZ9GE0n3RUB0IjLllVPGpA2Z0Jk2NHuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7ih0KqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DD8C4DE14;
	Mon, 26 Aug 2024 15:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724688002;
	bh=hUqiD6tize0J9n0G4qdkSCPdVIDOqJXQoFvZCB47rv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P7ih0KqVuMDnD9grVpP07IpdZsg6L5VINlSzzt0uvTyFRG09GmQpoOMGZUAFz6aRh
	 kBiZzNOQFckXtJoUTsjdpM65hgU1ABiud7iFKj5MMYLktLX5npwIGdEarc3ysjTfvb
	 LSIHmFCIYhq4WRp+1mIebqSQBDpojhHMSQ7uJpgh0WssP7ak7ltNkvkhVIxtrgnOVt
	 xlx/Ch/PEP0CGp1YelTVuZQlmXf8rldfKcaiiAQ2g3hmRJk4fqYjnjbPRdNMLFPfAj
	 7Zww7Dm/wI9bg2K5jAbx3xMtcah7klsyY/cezm32ZQ80PV2k3tZoydkLQOly9eS+rM
	 viDZp/2CItSTA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 26 Aug 2024 17:59:10 +0200
Subject: [PATCH net 11/15] selftests: mptcp: join: check re-re-adding ID 0
 endp
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-net-mptcp-more-pm-fix-v1-11-8cd6c87d1d6d@kernel.org>
References: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
In-Reply-To: <20240826-net-mptcp-more-pm-fix-v1-0-8cd6c87d1d6d@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2251; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hUqiD6tize0J9n0G4qdkSCPdVIDOqJXQoFvZCB47rv0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzKZW+W4mhmxjqvN44yLi5kqvXK+t1f2cckD6A
 uGyAlNxqNeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsymVgAKCRD2t4JPQmmg
 cymlEACA98B1Z6boTviuPDNQS+CeuDQb04t5NKihwaeoIBJp3Ji2FnyVik4dMHt7ErXIVuSvNij
 QUrXhQYEuBQAga+iqUN2KZ8PkYTody3pbOGWsv3f9THGqsEvn6eXQfcIa0s/NHkZ9kzV738GFX0
 8E9QwJdYzYvWy3jWaseRXm62tFNI/8xHvug6r6o6d0TwP/qweC1YzbFV2veuLINkub8c+ue+BWs
 b4G+LZYCOD1UBeXXBeMal255XO+GrX6BIJuRBsKR1h39w+wKAhIHkbeOQEGWlPENCl1fATDhdxn
 hnUjH7xNSN0w+TQtSAzwkaRGDSmjWHab9wtuQdEO6Dmr8vWjvawU8wAtHLylISUt0pwxesSicri
 r+fFypsC9PnjvKTeQdCnMqlfk4RyhZmjQSLaIgm3chQwX00BjmN2aXzRNK5wXg0n80SdKzNjcNq
 +GPSYhsbwwndd1S3Z/1yJVNuishO+tMTEuhRRBur7sLEMhW95e89TygJBwnTDfvZQyvFe3Wdd04
 PvB+wVUjgN+6pRMHMKfGLnvORl31ibGuzbdPFSPKZEBKCXPjq0JkVz3+/ZAlKiU9wawweV4v4W5
 dMykqw5omYCadZjK6HEOJ6IrIcmr114AHedGRyOszvU3/oYv04y3lappSe0fdztLDYADA4/UTf1
 oQiTcKQ52Y2Pgvg==
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
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0ffa6f6b04e2..7708ac99ccb6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3611,20 +3611,23 @@ endpoint_tests()
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


