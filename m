Return-Path: <linux-kselftest+bounces-17415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D604E96FB73
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 20:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC861F23A61
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950901CB153;
	Fri,  6 Sep 2024 18:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcbYC4wO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607EE1D88B0;
	Fri,  6 Sep 2024 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648397; cv=none; b=Pl0WKVoGEaANvAVVQ7wFCwHFjdp84zMHdJavKjRIXCQWnJtvpaxQcuO3j7GzKwTK/rSwRTYvKbAm/iB9HqprKkzy9ghntoYRneA6ekT0sijHi1DsXQTFqQRBlL6XCZoYsUkvKZKiT3Qu0d23YHi1ggGDTVqkNkLbUTvCi6sp6aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648397; c=relaxed/simple;
	bh=JIwD47ohgeR39/mflNfwm5sG7pceaysqE8PN4r4u3Js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wy04z4/LjMzHskSZBJUf/qQJQSsHZZU+TJxWWstuu+UD/1xS9QHYu5AmvD3CWq1cfGi8MSp/bIRc16gAjoM4at4QXJ/uJE5F8ewvgrrRHg5AZO1mFoWaZ2RCuZvlz6NnBANb4KfTxzHXkPH8hZ3Tc+PQLSWliUNtDOxtpA69R0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcbYC4wO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727BFC4CEC4;
	Fri,  6 Sep 2024 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725648396;
	bh=JIwD47ohgeR39/mflNfwm5sG7pceaysqE8PN4r4u3Js=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AcbYC4wO+Y/JAa5ZJseSYcmc6yWpZi04cpfcPjphuQHZYhYCQP7tOiMsW/+eRAEA4
	 usfaoVu34PPTI0tN4V2C6ilG9JUafb/lbjFFQhiN+MUNe1BbbM7YzAoKVpDdcMhxB/
	 5/TTZqzxSDDc2cvVbGE6dEYrUnfUGGD/NbOpMvYU9VeC14R3wwiZ/1CBXMilL+HX93
	 q4buwJaXDRmiTCMGf7wEwqXD4zsrMh7hjpiIx4eHs+qPZJq5XHcTT9JQwe8soV1xrE
	 d0DNgU11LZPEat17q+M2XZVh4QkQwfc1DBgp9qS1lUvoQ56rBwApmhpMdTYV5nrfHH
	 m2nX5kOcBNNuQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 06 Sep 2024 20:46:11 +0200
Subject: [PATCH net-next v2 5/5] selftests: mptcp: connect: remove
 duplicated spaces in TAP output
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-net-next-mptcp-ksft-subtest-time-v2-5-31d5ee4f3bdf@kernel.org>
References: <20240906-net-next-mptcp-ksft-subtest-time-v2-0-31d5ee4f3bdf@kernel.org>
In-Reply-To: <20240906-net-next-mptcp-ksft-subtest-time-v2-0-31d5ee4f3bdf@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2231; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JIwD47ohgeR39/mflNfwm5sG7pceaysqE8PN4r4u3Js=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2038rxbInPWV7BitNPE+7QuojyOTqgKUXrM5t
 /1lq8+RPtSJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZttN/AAKCRD2t4JPQmmg
 cwsPD/91Ag+CYOxlBLcBKddIiQSvdaY5x7Miwz+Excw/0+oMUgMvBjQ2+D0L7curjXeyoZPz6Xe
 MqxIOcMQZFdjVj1PQIfvcucuSkflBAI98Bjic96f5huKjuUCdXKvIVJttEM92Qhx46dMs3aUpS6
 SLQdVBLorVedARees1Tp2zDIvODkXIpf1tfVbMMOPEM4UoLGWtqQBuOMvFSglDP10GFl/d5G2j4
 HU3HoUqmewSJ4obKMXSKmWEsdSUBkSdwXIZeCkVBMZlw10qWY1hhcmqSelv7i621udX+EllwUH/
 MXxlcVCNZrtkd38uvXzY51mTb1BlIfroQJp+BH5vsU8uxj76weiN2QINeGp2DnRpyucJQiqTnt9
 5WoKQZUDZJ9SO8Kk1u03JPqncMWSuUWAoCLsKazaQejp9kKcjlPSkWNHJVUa/tlspY55WqUm7af
 JmpJyCthI68OBziS/GhEA+DbjeYyltzaLluusLJiVPGkFWNUHruTmk85/6a8c4Ljn8NavsF4g+Q
 KDT4eURqeRFlF/KYT0eF+15j3EZ2n53MFMMtCDcyR6MQ5C6P88h24t9sT5c0kDKdebBOkUkiQ1j
 4S80L/17rAL3ixOdQkSvQq4VHmoLurI3JNsfSxODnlwAXJIOLPsi6M4wKLg21ByJwNGGZfn7ILq
 7MVdeM0P3SPtKGQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is nice to have a visual alignment in the test output to present the
different results, but it makes less sense in the TAP output that is
there for computers.

It sounds then better to remove the duplicated whitespaces in the TAP
output, also because it can cause some issues with TAP parsers expecting
only one space around the directive delimiter (#).

While at it, change the variable name (result_msg) to something more
explicit.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 49d90c4dbc01..57325d57e4c6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -345,9 +345,11 @@ do_transfer()
 
 	local addr_port
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
-	local result_msg
-	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
-	mptcp_lib_print_title "${result_msg}"
+	local pretty_title
+	pretty_title="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
+	mptcp_lib_print_title "${pretty_title}"
+
+	local tap_title="${connector_ns:0:3} ${cl_proto} -> ${listener_ns:0:3} (${addr_port}) ${srv_proto}"
 
 	if $capture; then
 		local capuser
@@ -443,7 +445,7 @@ do_transfer()
 
 		echo
 		cat "$capout"
-		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
+		mptcp_lib_result_fail "${TEST_GROUP}: ${tap_title}"
 		return 1
 	fi
 
@@ -543,12 +545,12 @@ do_transfer()
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
 		mptcp_lib_pr_ok "${extra:1}"
-		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
+		mptcp_lib_result_pass "${TEST_GROUP}: ${tap_title}"
 	else
 		if [ -n "${extra}" ]; then
 			mptcp_lib_print_warn "${extra:1}"
 		fi
-		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
+		mptcp_lib_result_fail "${TEST_GROUP}: ${tap_title}"
 	fi
 
 	cat "$capout"

-- 
2.45.2


