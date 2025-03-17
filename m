Return-Path: <linux-kselftest+bounces-29242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80640A658B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 17:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45AFF1888A82
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 16:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E6D205E0D;
	Mon, 17 Mar 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcdbeLCj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E161A2567;
	Mon, 17 Mar 2025 16:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229539; cv=none; b=geE9E6OEEOZSdLMZxXsxjlCYTuEU0jdSqOHHMp9uG/fWBTXkbuodWhz45tIadnhk2vkyygLKbulmSLGcSCItCfsP12OMKC5LnBDbi0n2LO3EizoETpHvvXguHDwYuaeK4/eVPTS9XGjxLBFoSMNebgPRcTckv3w1g9ofnoAMdTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229539; c=relaxed/simple;
	bh=BbkZhxdokbhfSxfvsTxNQRLIManw6W5IZJTiFkZILlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O1Br8XBHdwVo3blZho/kt3GK02EWRDiWEHT1qqG4zRTE7lWIJjOcjIpMeBXLcjYCb7rQHluvvcpZHyQEwKuUoEI8Ag6RwC3mc0bpRDajAbGwEWyK85mv/n+PNPaJyC/hGnLbSWWNkVomreuwMTVlHS1PGNb3t2EpLqVBu00OrPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcdbeLCj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90935C4CEE3;
	Mon, 17 Mar 2025 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229538;
	bh=BbkZhxdokbhfSxfvsTxNQRLIManw6W5IZJTiFkZILlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KcdbeLCjtGCNHS4gS9LrGF9zsTH+ZI5abOwjn43KTLv824LklxuqWkq1NiVeCkIbo
	 2RlmEozinNTxD0N2mGSBftIfbAuuVATwYuySXxYfbwCIdqLH8DVUEoTYoJUCJwlw5e
	 zTK4W2n5qTxjJz4Vc1qYMhoUMn7tkDxtHYOL88Xwd7ntqmEHTsk75959ceb3cOPsr1
	 8+ndfiEfFvBTeKYOCbsbbyZ3Im30M0W6G+uBf5Vi/PWcYErIBXxTfQyTfVnRyyWIC/
	 vNFG4gZ5+/LB7WtzouYiL7lGtSwbH5am3B31QVjMYCxfxuUdQJ7cZZeRespQyg6jsF
	 Dth5DVHGeG7Ag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>,
	kadlec@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 12/13] selftests: netfilter: skip br_netfilter queue tests if kernel is tainted
Date: Mon, 17 Mar 2025 12:38:17 -0400
Message-Id: <20250317163818.1893102-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163818.1893102-1-sashal@kernel.org>
References: <20250317163818.1893102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.19
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit c21b02fd9cbf15aed6e32c89e0fd70070281e3d1 ]

These scripts fail if the kernel is tainted which leads to wrong test
failure reports in CI environments when an unrelated test triggers some
splat.

Check taint state at start of script and SKIP if its already dodgy.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/netfilter/br_netfilter.sh      | 7 +++++++
 .../testing/selftests/net/netfilter/br_netfilter_queue.sh  | 7 +++++++
 tools/testing/selftests/net/netfilter/nft_queue.sh         | 1 +
 3 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/br_netfilter.sh b/tools/testing/selftests/net/netfilter/br_netfilter.sh
index c28379a965d83..1559ba275105e 100755
--- a/tools/testing/selftests/net/netfilter/br_netfilter.sh
+++ b/tools/testing/selftests/net/netfilter/br_netfilter.sh
@@ -13,6 +13,12 @@ source lib.sh
 
 checktool "nft --version" "run test without nft tool"
 
+read t < /proc/sys/kernel/tainted
+if [ "$t" -ne 0 ];then
+	echo SKIP: kernel is tainted
+	exit $ksft_skip
+fi
+
 cleanup() {
 	cleanup_all_ns
 }
@@ -165,6 +171,7 @@ if [ "$t" -eq 0 ];then
 	echo PASS: kernel not tainted
 else
 	echo ERROR: kernel is tainted
+	dmesg
 	ret=1
 fi
 
diff --git a/tools/testing/selftests/net/netfilter/br_netfilter_queue.sh b/tools/testing/selftests/net/netfilter/br_netfilter_queue.sh
index 6a764d70ab06f..4788641717d93 100755
--- a/tools/testing/selftests/net/netfilter/br_netfilter_queue.sh
+++ b/tools/testing/selftests/net/netfilter/br_netfilter_queue.sh
@@ -4,6 +4,12 @@ source lib.sh
 
 checktool "nft --version" "run test without nft tool"
 
+read t < /proc/sys/kernel/tainted
+if [ "$t" -ne 0 ];then
+	echo SKIP: kernel is tainted
+	exit $ksft_skip
+fi
+
 cleanup() {
 	cleanup_all_ns
 }
@@ -72,6 +78,7 @@ if [ "$t" -eq 0 ];then
 	echo PASS: kernel not tainted
 else
 	echo ERROR: kernel is tainted
+	dmesg
 	exit 1
 fi
 
diff --git a/tools/testing/selftests/net/netfilter/nft_queue.sh b/tools/testing/selftests/net/netfilter/nft_queue.sh
index a9d109fcc15c2..00fe1a6c1f30c 100755
--- a/tools/testing/selftests/net/netfilter/nft_queue.sh
+++ b/tools/testing/selftests/net/netfilter/nft_queue.sh
@@ -593,6 +593,7 @@ EOF
 		echo "PASS: queue program exiting while packets queued"
 	else
 		echo "TAINT: queue program exiting while packets queued"
+		dmesg
 		ret=1
 	fi
 }
-- 
2.39.5


