Return-Path: <linux-kselftest+bounces-15707-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5899574C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A321C20B57
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 19:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3D81E3CCF;
	Mon, 19 Aug 2024 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZ8Uq4EY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AD31DD393;
	Mon, 19 Aug 2024 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096745; cv=none; b=JCL5yQ4pFyjCEH8cBWwlMM9vgZV+1DKYiXJy+eRpJ0at2VGMtpHdlRqD0OwbzdNUGs501KekoyrY12+LwnOPeApr8CjFo4xgKAYPAgmhJPmJYZGHiPJ2SS3pY1IWTGRDB1+R4fboExecMAb7RGvzGUddTgpr1I5IbVzovYP1ROQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096745; c=relaxed/simple;
	bh=el3krj0gIbWdRFoKFHJr5isBMDFRQzCj/EyzGroLrZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=duJDlYd7257WT9tAuQYxxDvH4AeFFIpFwwt6Iy6Bd1epZ2jPKEB2edLlhoFmAfMX6gcz3qwrw9gDHXOj85X8/+k2XqsUDkOATnbkf1TXWSjduRzMEH/f2r17nYWgn7+a/wliezs0FQ7sPYvtyFRfICrPmx7K3suk/37lJ9ivtTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZ8Uq4EY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43226C4AF13;
	Mon, 19 Aug 2024 19:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724096744;
	bh=el3krj0gIbWdRFoKFHJr5isBMDFRQzCj/EyzGroLrZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mZ8Uq4EYocvXI63p+tYZxjxx5hRGWc8NMB4Tr0F7d2siW+V+OJ4DFP1GbD1bMLgTq
	 XbWesBol+9AAKRl7FJ08/dXi3ezZHksrNerJyMep1qZSSB5b1kPT89Wv9bsMsro1Jr
	 Z/4m2hoUBVZnWtiL4M8nx+zGriYqxf9J3ihWZkqNs1tGznn9SB2YSd998cf9bz+Puh
	 umpNItZwjyyFLMraektUlDLHfZGc3AwCcNzBTB4HM0ajqwJyl2iKpBGqShcDjqGIGZ
	 hGESVYQdkTPQDbkKiRMJOBCiA+XoCCD7AjZCFZo9VBPkZmD3U+cnegJS+ks3Pp54sS
	 lrBMdD78HJXHA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 19 Aug 2024 21:45:24 +0200
Subject: [PATCH net 06/14] selftests: mptcp: join: test for flush/re-add
 endpoints
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-net-mptcp-pm-reusing-id-v1-6-38035d40de5b@kernel.org>
References: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
In-Reply-To: <20240819-net-mptcp-pm-reusing-id-v1-0-38035d40de5b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=el3krj0gIbWdRFoKFHJr5isBMDFRQzCj/EyzGroLrZY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmw6DScjkZfQJaQTRVHr1aF5SLxUPZ9KRCi6Qc4
 lsrfGRVXyWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZsOg0gAKCRD2t4JPQmmg
 c2M5D/9ZWZV2bJ/sc8iXcSDFG9UgrJMtMOqHrt3HPuSYkcRelDRlBMwgAhx5OAO2LOEQPdvWLwv
 ak+GdNBvdhpmS0blXW8xflRXP2yyjSQNh7FoceVtlh+RwDqbqBlmq7Krp7hTrNOrTGOPqpSX6CU
 uQyKeM4nbb+YpaOFPMow6Hmup0NkUsyop3usTGWW6i+rpNznxVlL49ReJRZIwGIeZQiHwl4a15x
 +W23roLFxcy8h29U2f5ZmHLx+c6LVgpu3DMlYumqcTbwYwXcpYupJ8hJ8oxrMRWQBz32LY2rZOD
 dCcb5Gf0srj5kTe56I3J8nhklNsQiVDIUkE+yDBAfEij4Fh7/ZhfbcRMhRdJuHHkvwbh3tiyNl1
 0z5onPftIJkhhRfKHKySne9B83notBVhysnTS1nUd+1aHTy2fXvSHhfIwokX4sUiMAdAreiaHQw
 e3r+z/oI8dQqKeiImKsle+ll8YeDWq0scuyMQtykdTTobHpn01gJ8q87CgGr35+oev0R+GLqAyc
 lEM/R8q9YY2hLuAIOvuIO0p41P3M/mENlP5xzVAF67+Hg77HzK1rP9ZBf9EuI99HL9MWaCF8ahw
 ubG61dUchdd7WAuwd+Gvb06MKmA4W/f/ZfgAwAC5LHBgoj5D3DqDIs5UCgs1ehlD4bYjE0Rlb5m
 1SSkwqr+Zx634Fw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After having flushed endpoints that didn't cause the creation of new
subflows, it is important to check endpoints can be re-created, re-using
previously used IDs.

Before the previous commit, the client would not have been able to
re-create the subflow that was previously rejected.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 06faa2271034 ("mptcp: remove multi addresses and subflows in PM")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index fbb0174145ad..f609c02c6123 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3651,6 +3651,36 @@ endpoint_tests()
 		chk_rm_nr 2 1 invert
 	fi
 
+	# flush and re-add
+	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		# broadcast IP: no packet for this address will be received on ns1
+		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+
+		wait_attempt_fail $ns2
+		chk_subflow_nr "before flush" 1
+		chk_mptcp_info subflows 0 subflows 0
+
+		pm_nl_flush_endpoint $ns2
+		pm_nl_flush_endpoint $ns1
+		wait_rm_addr $ns2 0
+		ip netns exec "${ns2}" ${iptables} -D OUTPUT -s "10.0.3.2" -p tcp -j REJECT
+		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
+		wait_mpj $ns2
+		pm_nl_add_endpoint $ns1 10.0.3.1 id 2 flags signal
+		wait_mpj $ns2
+		mptcp_lib_kill_wait $tests_pid
+
+		chk_join_nr 2 2 2
+		chk_add_nr 2 2
+		chk_rm_nr 1 0 invert
+	fi
 }
 
 # [$1: error message]

-- 
2.45.2


