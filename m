Return-Path: <linux-kselftest+bounces-43608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACE2BF394F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 22:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF4A3A38B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BE5338924;
	Mon, 20 Oct 2025 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPvieKZd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E00337B91;
	Mon, 20 Oct 2025 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993640; cv=none; b=YU3BWUx4I21+f5TrysYyAXj6F69JgeE84mzM95Qso7hnU3wTQEzJV8lyBK/CxEGNi5wRUbrt3RKCSO+204lg2YpTy+6xxQD6MjWi4bgwT10u1os3eqij7h3ZmcJw5ADuK1dASHlX81HWKYp/Fy7sVT9SZR/o+6TZBwnqWa4WI9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993640; c=relaxed/simple;
	bh=oZeuTBdKyvhXFvs6kqfXdPyeq9dxJOn0u2Uo580N4Zs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kIwX2sdI1Np9wEoNIUGO8kWhlZZeFqpU40WIko1OJ8Wm/kFY/lsdKfv1gsrj9p5XqjGdfzvjoD3I1qD2BooNrEYP1lVFQasexT0IybUqCdwD4T6hh9tGPm9FrXAWGL3H1ukt0FbJh8DxZzBCoh4VY524ykY+TXf+80wp/clo7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPvieKZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10A6C2BC9E;
	Mon, 20 Oct 2025 20:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760993640;
	bh=oZeuTBdKyvhXFvs6kqfXdPyeq9dxJOn0u2Uo580N4Zs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gPvieKZd02WniFWZLczdyuFomyLAGOaebAPaXFkYxYfrl4rvcmKQ/qA7w771q7bZw
	 eTuFGzaFzFTwIUms9hDqcwH10EcNK0DIKFw4Xlf3snVg3+QzQNIszNP5joBhtyZN/Q
	 yC1L4o9uRQeedezDtyf60XGuuhmcAN5CyzxkMjiou9ULkQDcPW3hxjnaBiQXlbKfW8
	 r4SIr4fZfHdgOCvlQvIZAM8asO2/LQVSCHhs3cpFa5b+iAC+nl9Sf0q/NIo1VxTBKk
	 8MptPs8bdWJ46CZ/eqQtq29xGsyFwymLrC+0ZDmNB5sre6frysvpPiwo6d6wQoPUxT
	 D45WHkkZTMRVg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 Oct 2025 22:53:29 +0200
Subject: [PATCH net 4/5] selftests: mptcp: join: mark 'delete re-add
 signal' as skipped if not supported
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-net-mptcp-c-flag-late-add-addr-v1-4-8207030cb0e8@kernel.org>
References: <20251020-net-mptcp-c-flag-late-add-addr-v1-0-8207030cb0e8@kernel.org>
In-Reply-To: <20251020-net-mptcp-c-flag-late-add-addr-v1-0-8207030cb0e8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=oZeuTBdKyvhXFvs6kqfXdPyeq9dxJOn0u2Uo580N4Zs=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK+LQwP7c/gKvp/OGDbTvO7K9+dvr3n3xnDFweTT9tkf
 4tcW7hFtaOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAiUdMYGfZqfMzOexAz+dJr
 saB0P+9lrirrvq/OTjZQ3RDwzTxKPIDhf6GbOatmBNOeW/P+nptcE645MeHlVF6fz8tT5zkLrw7
 mYQEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The call to 'continue_if' was missing: it properly marks a subtest as
'skipped' if the attached condition is not valid.

Without that, the test is wrongly marked as passed on older kernels.

Fixes: b5e2fb832f48 ("selftests: mptcp: add explicit test case for remove/readd")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d98f8f8905b9..b2a8c51a3969 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4040,7 +4040,7 @@ endpoint_tests()
 
 	# remove and re-add
 	if reset_with_events "delete re-add signal" &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=0
 		pm_nl_set_limits $ns1 0 3
 		pm_nl_set_limits $ns2 3 3

-- 
2.51.0


