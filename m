Return-Path: <linux-kselftest+bounces-43610-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2CCBF393A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 22:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A978E4FDAB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 20:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F65339B42;
	Mon, 20 Oct 2025 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrlY2yEq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050F339B33;
	Mon, 20 Oct 2025 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993644; cv=none; b=qc8ORfh00mAeNBRdokwoV7iLfQzRRKQxIqXeCv6dxtBejKCsGicShdb58iYNuKa3Q/CMr5EsemfjGhAc2NQ3kEg2WxOTm+zK+Yzb8B6Z/etgJWnhkjFIEdTkx7fsWML+wPIK17OpMbpXMB1cfwEheVStqhKLy1YVO/88zCofYCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993644; c=relaxed/simple;
	bh=bHGo8+BWrfJBGH0sCvbI3J2YnPZniPBZaTu937O/yl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=saBkOSJoYMiSK3VQonHPPR1x+mHXsjFsIStoy8wb8Kp3hJtcUlYXEL33rRXmJQNFolxIKa69uRETfiDRXAQPmv8oCnIAaAdHI9YulpWHaqmH7webaITxcLPk17dy5JlnwVMqcH1wOB/FdPeCOj/PKQUJgZe8CrERrLA6EqrVVoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrlY2yEq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93858C2BCF7;
	Mon, 20 Oct 2025 20:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760993642;
	bh=bHGo8+BWrfJBGH0sCvbI3J2YnPZniPBZaTu937O/yl0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NrlY2yEqf8J/6HabLfI4t1bHNmQHnv/8197GtVsmbrsdnJmTN5DFxOvAbcyEzkMSv
	 vfcdGjCTfKThEh4e0lBSTFZz5mHewt4r897QAKppkY94OFwdzHSgcwWulE9GA2R5a2
	 3s2PUTofrq3sPqcNGfywbq/Vs93EmvInFdtRDZ/BjqMjWR7Fl+2xMqHA9/JL3bUGA7
	 4jRVzZFNDtYmuZ/mfq9rWV8oFnTh/+uy9J4FccxiwGY0KCNZTDvfid9i3Dbo7BhJTN
	 QsfqRzepsqy1n7+eSMxT1KMi1pm2VGcWKYWP8dPPa4SdRGoGBpjDHcCpx/cy2EBuU6
	 tyJvh3ascdbLA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 Oct 2025 22:53:30 +0200
Subject: [PATCH net 5/5] selftests: mptcp: join: mark laminar tests as
 skipped if not supported
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-net-mptcp-c-flag-late-add-addr-v1-5-8207030cb0e8@kernel.org>
References: <20251020-net-mptcp-c-flag-late-add-addr-v1-0-8207030cb0e8@kernel.org>
In-Reply-To: <20251020-net-mptcp-c-flag-late-add-addr-v1-0-8207030cb0e8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2950; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bHGo8+BWrfJBGH0sCvbI3J2YnPZniPBZaTu937O/yl0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK+LYzw1t+pKv5+Z9q7lOeXLGKmhj/zz+7Kky54ZNR2u
 Pj7rfpzHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPZ1srIsPcG29aQojCf3bZR
 U8yjauO9A/13KP/tkez7t/rH7UBLTob/KXeuv7Z2SbQykxdkfrmdc1t5/p7PU7+y8xVskdy+Keo
 SGwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The call to 'continue_if' was missing: it properly marks a subtest as
'skipped' if the attached condition is not valid.

Without that, the test is wrongly marked as passed on older kernels.

Fixes: c912f935a5c7 ("selftests: mptcp: join: validate new laminar endp")
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b2a8c51a3969..78a1aa4ecff2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2324,7 +2324,7 @@ laminar_endp_tests()
 {
 	# no laminar endpoints: routing rules are used
 	if reset_with_tcp_filter "without a laminar endpoint" ns1 10.0.2.2 REJECT &&
-	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2336,7 +2336,7 @@ laminar_endp_tests()
 
 	# laminar endpoints: this endpoint is used
 	if reset_with_tcp_filter "with a laminar endpoint" ns1 10.0.2.2 REJECT &&
-	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2348,7 +2348,7 @@ laminar_endp_tests()
 
 	# laminar endpoints: these endpoints are used
 	if reset_with_tcp_filter "with multiple laminar endpoints" ns1 10.0.2.2 REJECT &&
-	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2363,7 +2363,7 @@ laminar_endp_tests()
 
 	# laminar endpoints: only one endpoint is used
 	if reset_with_tcp_filter "single laminar endpoint" ns1 10.0.2.2 REJECT &&
-	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2376,7 +2376,7 @@ laminar_endp_tests()
 
 	# laminar endpoints: subflow and laminar flags
 	if reset_with_tcp_filter "sublow + laminar endpoints" ns1 10.0.2.2 REJECT &&
-	   mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_get_endp_laminar_max$"; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal

-- 
2.51.0


