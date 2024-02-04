Return-Path: <linux-kselftest+bounces-4120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F57848F6F
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 17:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE22E2837B9
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 16:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F66722F1C;
	Sun,  4 Feb 2024 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmsIf0IJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7DE23750;
	Sun,  4 Feb 2024 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707065782; cv=none; b=gsrYHTbc1S31hUxInycT0UB7Yl4fGUOGBGkYz5zg5vU2I9fKqeU46zBcIr4xwbcFm+zj7Zh+WYc/OYW1cxYyNtCquLiIudcw88DKw3H283bfWlqkhZ14MjcZDfMCuYKwX7LFPsXlWJ5Jf3lHNa/tjNE84BpL3BF8EA3QGWegLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707065782; c=relaxed/simple;
	bh=cU/krCbsSrG89RxP8RzRLlCr9FLW61rqp9gLy7djBYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a32P8HfWjLw/MtPAPcmpZl8aIjI+nGtiRekoix5Qb7hdAeRtC1hzFz6wRJutgAiaqflY4FBES544xlID+3IUxFcUJfY9mJNX4R6OBZPZJybsSfo0zFYhX4QqtmRYvmXtD4LeAYIpFy4a47I0aC5LRSFqcc5GV8fD46o+zG7UViY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmsIf0IJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26541C433C7;
	Sun,  4 Feb 2024 16:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707065781;
	bh=cU/krCbsSrG89RxP8RzRLlCr9FLW61rqp9gLy7djBYg=;
	h=From:To:Cc:Subject:Date:From;
	b=PmsIf0IJM9fO/oWqkJI4a+pUeU4c/wuz1jhUApaOoBUAxxDV85bZVKqU+XhutC9Hj
	 fTpoBNVhY/06ObWTdJvXNZVyTS2vNUz6MiAdQawAP0ifpaErpzGs+7I72xnFmVRB71
	 f/vnaJOgaECKR3aPBzI5wgYXAFq9oQXn38uTxk00t9YF26b9Na1bMA7g88DLfzN+PO
	 nXLJ16zZTdvexncNdVvY4sWZ77sQPBmeEuATEftcBnVzxc9SycQbXTfFT03Z+dvVL5
	 wb7Rh2Z3EDn0HC8/WgHWmxgIHC1JmjWvMUFbfq4SgstLDie9z7kot7P5kmp0/mHNeM
	 m81OxSPhTCQPA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: cmsg_ipv6: repeat the exact packet
Date: Sun,  4 Feb 2024 08:56:18 -0800
Message-ID: <20240204165618.1489880-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmsg_ipv6 test requests tcpdump to capture 4 packets,
and sends until tcpdump quits. Only the first packet
is "real", however, and the rest are basic UDP packets.
So if tcpdump doesn't start in time it will miss
the real packet and only capture the UDP ones.

This makes the test fail on slow machine (no KVM or with
debug enabled) 100% of the time, while it passes in fast
environments.

Repeat the "real" / expected packet.

Fixes: 9657ad09e1fa ("selftests: net: test IPV6_TCLASS")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/cmsg_ipv6.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/cmsg_ipv6.sh b/tools/testing/selftests/net/cmsg_ipv6.sh
index f30bd57d5e38..8bc23fb4c82b 100755
--- a/tools/testing/selftests/net/cmsg_ipv6.sh
+++ b/tools/testing/selftests/net/cmsg_ipv6.sh
@@ -89,7 +89,7 @@ for ovr in setsock cmsg both diff; do
 	check_result $? 0 "TCLASS $prot $ovr - pass"
 
 	while [ -d /proc/$BG ]; do
-	    $NSEXE ./cmsg_sender -6 -p u $TGT6 1234
+	    $NSEXE ./cmsg_sender -6 -p $p $m $((TOS2)) $TGT6 1234
 	done
 
 	tcpdump -r $TMPF -v 2>&1 | grep "class $TOS2" >> /dev/null
@@ -126,7 +126,7 @@ for ovr in setsock cmsg both diff; do
 	check_result $? 0 "HOPLIMIT $prot $ovr - pass"
 
 	while [ -d /proc/$BG ]; do
-	    $NSEXE ./cmsg_sender -6 -p u $TGT6 1234
+	    $NSEXE ./cmsg_sender -6 -p $p $m $LIM $TGT6 1234
 	done
 
 	tcpdump -r $TMPF -v 2>&1 | grep "hlim $LIM[^0-9]" >> /dev/null
-- 
2.43.0


