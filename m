Return-Path: <linux-kselftest+bounces-42294-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEC3B9EAFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 12:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9181BC7930
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0977A2F49FC;
	Thu, 25 Sep 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsntq5uZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6A92F3C38;
	Thu, 25 Sep 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796401; cv=none; b=NaQHr8w0yfE1GrL0ln/3eqAYwukH0FBQPuB48voeeobc78HWMdkYAu/1ILstP83zgRPv91RL+RwncGfj2N4kpBY7l6WqdVD+osF0QgtV32O7pTEL76syFS3QrNLXdQNFhZB4dLK3893m4XX7Dv4AKHGaIuTKCGukBJqL0S/5I40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796401; c=relaxed/simple;
	bh=zWnGj1eCp8t5gumf2c9rwYgkDxIwOKnROlXH4jqgV2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hfV2iVCJUP0UA7Mp9AKMOqxVuONFnoBwHT3+yORWCZE3nf3/1QU/NQdXeZUNEoxqhXf3IB7E6vqi7MqffjCyrVleYJwrF6Fsf9QyuYgE15XGMKBFFE7m45fCoFRVwJexXDIr/dEcJ5ki3hsf+euKqDDXGZ4LDj95LfYjUKG6i9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zsntq5uZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3588C113D0;
	Thu, 25 Sep 2025 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758796401;
	bh=zWnGj1eCp8t5gumf2c9rwYgkDxIwOKnROlXH4jqgV2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zsntq5uZktPFbYwAaHpVOQ1hByVw5vGHLPmtOVw1GBpLsI7nWL5EoCEyGngtnOoyC
	 GQgTlPlyFjabHrLELYrLJlgLJCxB1f8MjasiUpXcYD9bquvk76Gca+VXUMBwo2XGaF
	 4ayIsQl7Ec+9XtJj2YwbZP4ViIpmm+j+vbyU2/BaC+OBbvL8XeFzciujegNWXdMWcl
	 FppfwBJABIkqrL0gJxwm5BzlbeY5Gxx7d4xT19zE5H968JhZWBpB7CUsPrjNooojcg
	 MRDeTCEXSZwNrNoHJa8EtcP0oKFI9HxFxCIEljzautfrkPZ18ZddaaP/HOMvAWZzaI
	 lfGJZmXTlR1Qw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 25 Sep 2025 12:32:37 +0200
Subject: [PATCH net-next 02/15] selftests: mptcp: join: validate C-flag +
 def limit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-net-next-mptcp-c-flag-laminar-v1-2-ad126cc47c6b@kernel.org>
References: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
In-Reply-To: <20250925-net-next-mptcp-c-flag-laminar-v1-0-ad126cc47c6b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zWnGj1eCp8t5gumf2c9rwYgkDxIwOKnROlXH4jqgV2k=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKuSoXU3Kw2NZ8YP3euedm6+fHz1HxMfp6d/W/Kqx1Lz
 Z/90lzG3VHKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRXhWG/0na+nWbmQ54m+p3
 Gz6TCuVXsSvocvvX/zhv9eE1k7pYixn+qS8KuXFoEht33ZKtp82frmxg7/r3lrM+rIxtswfj9rs
 lrAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The previous commit adds an exception for the C-flag case. The
'mptcp_join.sh' selftest is extended to validate this case.

In this subtest, there is a typical CDN deployment with a client where
MPTCP endpoints have been 'automatically' configured:

- the server set net.mptcp.allow_join_initial_addr_port=0

- the client has multiple 'subflow' endpoints, and the default limits:
  not accepting ADD_ADDRs.

Without the parent patch, the client is not able to establish new
subflows using its 'subflow' endpoints. The parent commit fixes that.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: df377be38725 ("mptcp: add deny_join_id0 in mptcp_options_received")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 6055ee5762e13108e5e2924a0e77d58da584d008..a94b3960ad5e009dbead66b6ff2aa01f70aa3e1f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3306,6 +3306,17 @@ deny_join_id0_tests()
 		run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 	fi
+
+	# default limits, server deny join id 0 + signal
+	if reset_with_allow_join_id0 "default limits, server deny join id 0" 0 1; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
+		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 2 2 2
+	fi
 }
 
 fullmesh_tests()

-- 
2.51.0


