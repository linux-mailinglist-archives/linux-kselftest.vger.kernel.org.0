Return-Path: <linux-kselftest+bounces-29241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FC3A65890
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 17:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9975A189EFFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 16:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF381EB5EC;
	Mon, 17 Mar 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYFtTVPi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7681AB528;
	Mon, 17 Mar 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742229494; cv=none; b=em/2XXSn7B3s61h7SMqh8e9dwx6LMi1Thu8qF+urGFHEpQnWbjb5PzcsVd/QqI46oI/tPV1A+2l8xA1a4RE5bzcpqXu4nDMtynfb3v6QvQviCfTtvZ9s04wDPOC19xKCwmaaTpcKDo17j4cT/6zFb/SjQZoVjDNBZ4ytGumIL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742229494; c=relaxed/simple;
	bh=0dwYf5DKkHAA2EYSXFTq9qfix/WD/m/Hv9xSOVHciic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p34ER90DNQFWPLrnAjH34e+5UWkWcvu/WvWCeaZpShiOnHh3jZzoE9gXxiD4Fckohnrg41EDV/8r89rQK+T6ydRbK6A217Ft2xnvC/AqTAqiUvzt3DR4gFIwrRYgU8dTq71+hlL+K+UIndq9stwOktZFtODoP3uqynoroxqPA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYFtTVPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62365C4CEE3;
	Mon, 17 Mar 2025 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229494;
	bh=0dwYf5DKkHAA2EYSXFTq9qfix/WD/m/Hv9xSOVHciic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYFtTVPiR0JffKP3olE9P5YoA9dtmy6CbTHp95r2NOgN0QtK+gOByTSCP8LECQ9hl
	 Y6j0o0N0bYLRJP1/OSjSozE1qmcLiVCTSXe3ljkgtj6jWk/BzvmKw5XGhezwKmwmX2
	 pkRhMZvH3e71FvlH/hvnd87lp7Vr3PZzqQVc37VqyvQ/Vn7/OKSJn2nSHk2gpi+7HK
	 vMo8PQABDsP5zdhmhc02rT/YGfIqHnfpf6CeJMZOy/+/uw5IgUkLH2sS7HBP1arMUh
	 j2tjHNf3SXhj8FhR6gXy2kCL0pkZZddIO2Eq7k7GqdZGOhq4AuNQCA+SJVGYCnqr6c
	 qVgX/mKRW+SBw==
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
Subject: [PATCH AUTOSEL 6.13 15/16] selftests: netfilter: skip br_netfilter queue tests if kernel is tainted
Date: Mon, 17 Mar 2025 12:37:24 -0400
Message-Id: <20250317163725.1892824-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163725.1892824-1-sashal@kernel.org>
References: <20250317163725.1892824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.7
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
index 785e3875a6da4..784d1b46912b0 100755
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


