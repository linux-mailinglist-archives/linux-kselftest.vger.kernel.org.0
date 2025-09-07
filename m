Return-Path: <linux-kselftest+bounces-40910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40234B47C1B
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 17:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C301189F861
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Sep 2025 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E332853F3;
	Sun,  7 Sep 2025 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oV1qXewn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E60627F18B;
	Sun,  7 Sep 2025 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757259197; cv=none; b=iebadbIZC3ZZQFZ0fpr+if4ggKBR4bkxQZ9KF13yDtNgzzupqh+fNKDCAqsGu1f06xKVVG0ZKwzFwEiAGZupbl+hQV77duIeewpIW0spKld4IT+CtOvxLHeAy4dpv1psby4ANq8TDRioguvxHQkwE4gCSnFcIBPWwwU/OiwAx1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757259197; c=relaxed/simple;
	bh=stiQPhak8MOP6pYZdLyutUNcmHegMkQrARaC/Ai+XFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9Kl+YcnFW5BiJOFL+1Q3ODXQMz7OARgSHtoKBFR9KQPMxxKcP7yZ5Klu7f16VetRmzcPIMk9zMwDjWFO/TKYWWxvl+l0uN+AKYUklSrEDo54U/QycB+VAJXThfo27lcx2oZChFSC1G999iqZfcFA+G/jOsrsokttTDHWqPyk1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oV1qXewn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD218C4CEF5;
	Sun,  7 Sep 2025 15:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757259195;
	bh=stiQPhak8MOP6pYZdLyutUNcmHegMkQrARaC/Ai+XFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oV1qXewnDKnbIJFTqiUEeQSwC/3McmLPaxozGZiGZS4XPia3fck2g4HagmezLSevB
	 q0pdBFKlGsmp3PcrO1qLRnwP82jG7KdW9YW5zybjKh9TxrXlkqToYp04fV9gQ5jty2
	 hlImczw3DAS+vt19Gdj+rw0gbEFo/Ct9/Vs0jMQ+heMMkIq4piSxnDb1k+rFs7ORHp
	 jXA/pknZpbHxlfpQT4W1nQ4Tns6yb//nYLVPjU7qVKxa7Jf8k6LAhPWzSg1Jyzlw5g
	 EgtZWsPaVenSSDEF9sjuqGq+cDPcOxw6EPLqr9Fzih/IrG4p5j6cpoUNeGecz1h56c
	 jEVxvqfJ1U6jw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sun, 07 Sep 2025 17:32:44 +0200
Subject: [PATCH net-next 3/3] selftests: mptcp: join: allow more time to
 send ADD_ADDR
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-net-next-mptcp-add_addr-retrans-adapt-v1-3-824cc805772b@kernel.org>
References: <20250907-net-next-mptcp-add_addr-retrans-adapt-v1-0-824cc805772b@kernel.org>
In-Reply-To: <20250907-net-next-mptcp-add_addr-retrans-adapt-v1-0-824cc805772b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=stiQPhak8MOP6pYZdLyutUNcmHegMkQrARaC/Ai+XFA=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL2Ll03M+ezbfADr3m8AZMe8TRyNYUadN31K9z+2fpty
 ycOTsVlHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABOxF2ZkWJds57F+s/mG38ma
 8gxheh2vV6pP7NK++q+Xh0ffKGimCCPDFT0jhRV3OQ4Ua+pqSU1o5jbj3sHp3re59vbylSvEeXy
 YAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When many ADD_ADDR need to be sent, it can take some time to send each
of them, and create new subflows. Some CIs seem to occasionally have
issues with these tests, especially with "debug" kernels.

Two subtests will now run for a slightly longer time: the last two where
3 or more ADD_ADDR are sent during the test.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e9e11a9e60fd5374c8a98c3b7159ccbca8053030..b41cebfa1f921ce9ea6a88a908bf6d5e6027b367 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2268,7 +2268,8 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.4.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 3 3 3
 		chk_add_nr 3 3
 	fi
@@ -2280,7 +2281,8 @@ signal_address_tests()
 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
 		pm_nl_add_endpoint $ns1 10.0.14.1 flags signal
 		pm_nl_set_limits $ns2 3 3
-		run_tests $ns1 $ns2 10.0.1.1
+		speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
 		join_syn_tx=3 \
 			chk_join_nr 1 1 1
 		chk_add_nr 3 3

-- 
2.51.0


