Return-Path: <linux-kselftest+bounces-6119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC24876CC6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EB91C20D2E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E449C605C6;
	Fri,  8 Mar 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arHj7jRf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F5F605BD;
	Fri,  8 Mar 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935829; cv=none; b=OF5A3dntUxuoE8oxoxffJTjlIImXNWP7PSCZSTIsdXlPKffYi48uhyaWgRrEbV3zhuTS5bH4agz/MKAi5Og5v5QLLNp1WUAvKPqjAmXRWNnS8sqQydtxepwaXZIXtiBUW3MPCSxhXKqcNLUaDrlTKtf9GL1D0Bj9dDjmWHC4/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935829; c=relaxed/simple;
	bh=4nVIS17p6hfpmz31cy1Qa7DP7XG9Y9xY1ocKKw5lq2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eB4UWiF0TOnP3HRQnkhMfH/zpBMaP8Jz1G9sPXaI509i8Tgb5rDvhDUWklM/Zio1IXfd+bltjySE6mev1wHorDjuPWcL6IDpC/2Ttd8gFUnO4D1WlNWAM/12nyhcZ85vhu2VMjJXmAsvLbG+KNGt30vZLn5uOHKE/e4OXiOKjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arHj7jRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3964C433F1;
	Fri,  8 Mar 2024 22:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935829;
	bh=4nVIS17p6hfpmz31cy1Qa7DP7XG9Y9xY1ocKKw5lq2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=arHj7jRfh0wt3L9GPo/NcZfTpEDVO0rDWgHW0Hq3xC/R8QlStosEhzSPo20eM4qCK
	 LR1kZNEN5fQXlaFa5dBf+l+nQJIrUAV7Es1n47Uj15OPG6RL0Y2y36903rgu2tFh4m
	 2dncchbPM78GVaWEI4HuUBaQ6WnxsAS49iAhxQdmFvb1CHtsutAWVmWttfdBVMpCVK
	 4UyDqWSC+lmoyWwQc3/UNoZpBUuSmwXfGbusYPAsjRQc2UliH33dm1rkx9jbG3PXRn
	 QqugqBsSWbpXcOxTL7Cev8WShjKYe1ptr/OOD5Nlyoop1S1k9VdZlNzeNxj7p2IuFJ
	 V2+gQ06I4dGAQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:09 +0100
Subject: [PATCH net-next 02/15] selftests: mptcp: connect: add dedicated
 port counter
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-2-4f42c347b653@kernel.org>
References: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
In-Reply-To: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uZotqfOJH05r/mkzZnPzrup9bfcx9v2c7hqAmWQhC7o=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zJiuJltdcfRCNiztqCUe/Di09/CiDya2IMd
 PZCFRiYb/SJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyQAKCRD2t4JPQmmg
 c3YUEAC2gns6Li7mDBS6aBV6mvpF2w8E7QmIvpWFTuQR6Cg4F88IpXwGKE+WeObG7NVg1rfdUCf
 Yh0PewFQKsGBQWXO/caFVrNi1SNRm1D0910PfgX3GGGILTTS8cbRisqFIOzny35cFyRY/7WD7GY
 fchWjA6SCKs07cs6K3buCh3eSGyC4avlVNZh39DeW/GZcm+EkQtSdnvQIziLsvo2vtS4IeLQ2St
 xTL0Yg8+BWHxbaVr2qiPLfgNDBQxJJK46cUqlrdJH+fbQibTND7L3CxzsjwJpmAgUqHHXYup6XP
 J6uu5UNRcwQZwrukTNkS/WSQiIW++qR7RKPMiYbXMTuxgXXm72Fd9P+LLYR2M55W7sVxbLNPPGS
 +sibcKVdjcev3grIkj0srjemto5clMqpUGGxNCan6Fe9q1ZEBbv3bwzLHkysxpdw6ozfFi3HB1+
 q2VMytrN/9G6IlAAB5AASiUuAkyBuzi0r/oaHvbAroI/z37GiARbDEWRqMRbqI96QRIb/S50VRn
 cYg0XSdtV6dDApKqdUVrNAf+LPGsmQU4hK2ikpTieyeimlFO2ocTNd1eoW7y2XoJaodQ7XYITav
 FIcWX7ZIXw0I+x7qEckDTr6sPbn/NKGEGqoiSL3CgCd7mESc7V7S8zspNVo+/S2WV6xU4Xs9wyS
 Cclld2D716fW4Ig==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new dedicated counter 'port' instead of TEST_COUNT
to increase port numbers in mptcp_connect.sh.

This can avoid outputting discontinuous test counters.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 679e366c8f6b..ab3f52434753 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -33,6 +33,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+port=$((10000 - 1))
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -313,8 +314,7 @@ do_transfer()
 	local local_addr="$6"
 	local extra_args="$7"
 
-	local port
-	port=$((10000+TEST_COUNT))
+	port=$((port + 1))
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
@@ -710,7 +710,7 @@ EOF
 
 	echo "INFO: test $msg"
 
-	TEST_COUNT=10000
+	port=$((20000 - 1))
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"

-- 
2.43.0


