Return-Path: <linux-kselftest+bounces-14298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4922393DDFB
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 11:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0944128372C
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F62C6F06D;
	Sat, 27 Jul 2024 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pduMOcX8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609DB6CDCC;
	Sat, 27 Jul 2024 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071079; cv=none; b=gOfiGWFmGUtTeaCPqZ5t2P2MU64fsVRntCdIEICy5m1qne2ZzdvXwg/rBfgssnFwftSdKE7paCUO15ySYQDIu9Ovg+4073Pu7c1VFzXYFC+lazvjiJkPwmQ2g4B1hHvnBkpytLRQ1yRDE2rF64ydK+4pqENOo4vjljC7UbNDEw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071079; c=relaxed/simple;
	bh=V3zN+OxK0C/dybQY9jqujF+bUKvkdcqvyAUmVdnWlww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k6/2/xKPNvGN04MgEGVBoZi65GuSnBePskOo2MPgXsuppAqhBJPm+E0lk82hNC108IK3Q1NoOtrhnEGbMIMbhTYzs1uHkWeFmyCT1qiAV3sv23UGvG0lKq7/CsmYKZbO++hjTGs90rinXPiJKFVctKXfkgZ6eU7EgISmpmwnO8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pduMOcX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A703C4AF0E;
	Sat, 27 Jul 2024 09:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722071079;
	bh=V3zN+OxK0C/dybQY9jqujF+bUKvkdcqvyAUmVdnWlww=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pduMOcX8mQt60o3+uketKw4yrSScpNlKrEzuStS05LnuA42IEiITrfyNZB5xlo9I1
	 yHIQl1V7o2I7YqvxSBzxeLSAfCD4qfwDhgIrA+GIaGFa0lkntmS9w4tBJfWcf/Vynl
	 C9C9gYzrLUHdJbIPvrCxKenZ/mAvaGFygSSrjZTB06wfMoclVdDM4O9RHR68dY5RvZ
	 6jsN5tuH1Ey0YSqDfG9XcFQImAqq5m7+iTWCffACUI+DVJmHYmfByVFPa+vnqxAgEn
	 Zrd5U4U5B3uHHTWFDRBS7qR7vEIzdqmt53NVaWK49SV/wVMJbHodP5uw6yiveF+zvG
	 PpMXNTSUtMvqA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 11:04:01 +0200
Subject: [PATCH net 3/5] selftests: mptcp: add explicit test case for
 remove/readd
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-3-1e7d25a23362@kernel.org>
References: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-0-1e7d25a23362@kernel.org>
In-Reply-To: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-0-1e7d25a23362@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=jQIxgQ8nPpyNkqG+0+5KEG8+ixuEiDZsNbtus6NCsR0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpLga+KUGo6bpQhqq177WYWGobQbcjc5pi2xM8
 hudz3Z9HmKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqS4GgAKCRD2t4JPQmmg
 c+jgD/92TC8t1uxryKpSxJv77Z8Y0ug0of9QZHbZfEFKkRRLzknZajSRgvnAOZWi1wCVY7cenQQ
 7NufOm9Oa5i6N0fEBPuMPgDuofQMINa6qdzT30Q5nFgRXoSorvdNq5lOOt8yhBDaXWpclYinJSb
 hq2Wsu/w1EIFEvJLIY9q8thwM0Uyhh67ll+9cQG+lD4yF0vl+r7v0jqsAFdPuR5+Ci4p1GtVMq2
 fn+rgW93OOwxzY5XcIsFu5ivFk2M+swszZbZsIxMm9D7HjSCKFPN+YsSE7T96LiRrTp/GSs0uTQ
 01hf0jO1LM+q7eb9PbBvRtbu0l8WTTjS7U9XsI/xjUf0RaqTHSpNOAfOc+UiSxy9D4PX50Kpsfg
 nljlEJszuHnGv0FNtp/UuP2qwOzrucCC7LxAUJ92XNSpBGHHMbw32jRaO1ije5xwCXk3sF94vCY
 CCuQ/0CnRl89pgylFY7C5UWP9K9bgWF4XcgRpNYLJuzUEWNSrVViC9RJpJMhw1UnYwdnB5t6VPl
 +iQngthhrEGRBjQEFWhJVCT4CPN7iNxscWLy9C2ku9R7fIfJ7WnmOa4dBVjIiBqdpmn1geCrTn9
 U8Hy6Zz9dLOr0eizBqvpSZqqjIHBnmnYQsndiP9P9NcsC+6a21cc12xXuDpRdLKCCbt5NGpeA59
 ojLzxIo4+ScrPuw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

Delete and re-create a signal endpoint and ensure that the PM
actually deletes and re-create the subflow.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 108aeeb84ef1..9c091fc267c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3526,6 +3526,35 @@ endpoint_tests()
 		chk_mptcp_info subflows 1 subflows 1
 		mptcp_lib_kill_wait $tests_pid
 	fi
+
+	# remove and re-add
+	if reset "delete re-add signal" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 1 1
+		pm_nl_set_limits $ns2 1 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
+		test_linkfail=4 speed=20 \
+			run_tests $ns1 $ns2 10.0.1.1 &
+		local tests_pid=$!
+
+		wait_mpj $ns2
+		pm_nl_check_endpoint "creation" \
+			$ns1 10.0.2.1 id 1 flags signal
+		chk_subflow_nr "before delete" 2
+		chk_mptcp_info subflows 1 subflows 1
+
+		pm_nl_del_endpoint $ns1 1 10.0.2.1
+		sleep 0.5
+		chk_subflow_nr "after delete" 1
+		chk_mptcp_info subflows 0 subflows 0
+
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		wait_mpj $ns2
+		chk_subflow_nr "after re-add" 2
+		chk_mptcp_info subflows 1 subflows 1
+		mptcp_lib_kill_wait $tests_pid
+	fi
+
 }
 
 # [$1: error message]

-- 
2.45.2


