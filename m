Return-Path: <linux-kselftest+bounces-45837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0604C67E9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 08:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C8E7829704
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 07:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226973074BB;
	Tue, 18 Nov 2025 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvEeSSAA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60F9306D5F;
	Tue, 18 Nov 2025 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763450475; cv=none; b=ra6v1Unu+98RI3oaB9VRTgK+aPsPE0HF/ElqIkHxzvFZ7rr6XOU9c2EAvqk/R9Z+/Jw2aUzmToqk89QZuzio43idi6zzUoeBoneQkpWLBZws4X/N8Y2glx1nK9U9jkwMc6wTgRGDdbIcTzfBu8Wy1J/jzrJaH70TpZK4SmKoe/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763450475; c=relaxed/simple;
	bh=b2a4lL+pfLejH4X+ZHTAkwbOkvwKHQx6oTEDhFcBeTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i2Yse5HQQUwkbLhPeAl3+CEc6+U9XRP+VfbGkGai1SWOuhTgftmG8SZhPT0PNW1QCAykgbDpBNqtIE/OePUp+D9wYkDPR/6ySFz2UPlDLy/s1lvjPMKyl/9DQGWjid9AdQJjUELiLHXGCAOG/GHtdnH89CQ2oIZ8frZbcBQWnos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvEeSSAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C71C4CEFB;
	Tue, 18 Nov 2025 07:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763450474;
	bh=b2a4lL+pfLejH4X+ZHTAkwbOkvwKHQx6oTEDhFcBeTQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AvEeSSAAbyb9CqA5L4wRZ1GgZa4oPaczwtnK04pDcjkuN5WZFGfviC90dM/LNIHqn
	 aDzz1FpimQ+1LilYsDtwLgZEDS2IYEuw0iriFZVgfGgU3DRVk/V7SEn3tBwX4e3htj
	 B9ctq9WEDEcBfhoXcjjGp7TxxQK6mfDBdVE1hLY1aqsrCRJPfOqq+z2L7qD1xWN+VN
	 e9jB33ggCbOwlUWmxWW9ThN8O53ik4GzaTYv1Wp8lKNmflOefGbxon4jYtXOvkEtC9
	 1hzC7ZL1AUj2povlLcJXphDha10AQTNoDjsSqirgzatpZlENT3qfIUvnFdfGMRDi2C
	 tlvHFlXiTuD2Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 18 Nov 2025 08:20:25 +0100
Subject: [PATCH net 07/11] selftests: mptcp: join: fastclose: remove flaky
 marks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-7-806d3781c95f@kernel.org>
References: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
In-Reply-To: <20251118-net-mptcp-misc-fixes-6-18-rc6-v1-0-806d3781c95f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1276; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=b2a4lL+pfLejH4X+ZHTAkwbOkvwKHQx6oTEDhFcBeTQ=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJl5HxfLLp9uN3cf0nSMfbUWX96VtbcOuL7Uy50xnMXs
 4Qt8UWJHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABO528jwz34Wlwe/9LRvZ8+s
 lYw+tbfipYJSwFaLuAtxPeEilyT02BgZlvEcy+AT/bnmV8yPL8GVrMxmanHPUlfEPwn+OuOPk7o
 lEwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After recent fixes like the parent commit, and "selftests: mptcp:
connect: trunc: read all recv data", the two fastclose subtests no
longer look flaky any more.

It then feels fine to remove these flaky marks, to no longer ignore
these subtests in case of errors.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 41503c241989..303abbca59fc 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3500,7 +3500,6 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
-		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=client \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
@@ -3509,7 +3508,6 @@ fastclose_tests()
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
-		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
 		join_rst_nr=1 \

-- 
2.51.0


