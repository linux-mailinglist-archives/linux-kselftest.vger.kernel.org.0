Return-Path: <linux-kselftest+bounces-48402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D01CFE7B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 16:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 66D8C3049FC1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998E635773F;
	Wed,  7 Jan 2026 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee91BQm2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8C3355043;
	Wed,  7 Jan 2026 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797602; cv=none; b=ua1cGMzuV8ZKsdBMBoyOCq4811ioqeoCR2b3SrNZHM3L0Zgi+LsYINUjlqoffob5OfnCaD4U8GlKm8V9fQuaarcaKCrizTw3GqZBVQ0LrQSM6QOpnP9bFW/soLmBL62kBpE6OXJoJmzKH4QdICx/NsPuQUUDxSBnWA/GBVrFMOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797602; c=relaxed/simple;
	bh=cArOAZu2vf19+VFBgmj/e+ZIi+kTdN9NBGzWcNSqNRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WibXQ7vymCJ2nKWxmzL905RJPlFZqXOVFXPvQ1vkdrJmAoE+UvaPMWJq1ZNdHOE9/iJ5S6UYWhstYfvkneI8SlT03q08/AeH7I8bLkFDPK17RH6yKi2+/lEaocy7REeN5jEIb+PGghW8xynIcJTuaYJ/0icYYzhIkpKzvKHbcuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee91BQm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67932C4CEF1;
	Wed,  7 Jan 2026 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767797602;
	bh=cArOAZu2vf19+VFBgmj/e+ZIi+kTdN9NBGzWcNSqNRs=;
	h=From:To:Cc:Subject:Date:From;
	b=ee91BQm2IoeyYD6gcMxxj4z29bK0iUJ3krQ567hBuYTdzHHJuJrlfq9NCaAEIkY3Z
	 QHAdCTRQKCowk9CH0Kp1UOoyg2/HEG7lwIOFJrTgmmtEBk6QBcvsBptAgKB8e60MJc
	 /Ka6LO9rXmsoq1G3ywV20thWUY7fFO0ivnnLATSjnp6r1oJgdpsE8TvvwH9h96bHjo
	 2a6kLNGNnfIlWDoRKnNtmkX41r89sO80mNZHLHXZB3jBTKmqEmqOVuSjO6fbLT/dzY
	 g+cuqJd4TUBRUhGJg+hHo+lJ7uyZ01BUNfCzyS0n+A4caH9f9lZ+PLbasFMs92c0fz
	 2V2poM+Zgmg3Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	vladimir.oltean@nxp.com,
	alexander.sverdlin@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: forwarding: update PTP tcpdump patterns
Date: Wed,  7 Jan 2026 06:53:19 -0800
Message-ID: <20260107145320.1837464-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent version of tcpdump (tcpdump-4.99.6-1.fc43.x86_64) seems to have
removed the spurious space after msg type in PTP info, e.g.:

 before:  PTPv2, majorSdoId: 0x0, msg type : sync msg, length: 44
 after:   PTPv2, majorSdoId: 0x0, msg type: sync msg, length: 44

Update our patterns to match both.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: vladimir.oltean@nxp.com
CC: alexander.sverdlin@gmail.com
CC: linux-kselftest@vger.kernel.org
---
 .../net/forwarding/local_termination.sh        | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/local_termination.sh b/tools/testing/selftests/net/forwarding/local_termination.sh
index 892895659c7e..1f2bf6e81847 100755
--- a/tools/testing/selftests/net/forwarding/local_termination.sh
+++ b/tools/testing/selftests/net/forwarding/local_termination.sh
@@ -306,39 +306,39 @@ run_test()
 
 	if [ $skip_ptp = false ]; then
 		check_rcv $rcv_if_name "1588v2 over L2 transport, Sync" \
-			"ethertype PTP (0x88f7).* PTPv2.* msg type : sync msg" \
+			"ethertype PTP (0x88f7).* PTPv2.* msg type *: sync msg" \
 			true "$test_name"
 
 		check_rcv $rcv_if_name "1588v2 over L2 transport, Follow-Up" \
-			"ethertype PTP (0x88f7).* PTPv2.* msg type : follow up msg" \
+			"ethertype PTP (0x88f7).* PTPv2.* msg type *: follow up msg" \
 			true "$test_name"
 
 		check_rcv $rcv_if_name "1588v2 over L2 transport, Peer Delay Request" \
-			"ethertype PTP (0x88f7).* PTPv2.* msg type : peer delay req msg" \
+			"ethertype PTP (0x88f7).* PTPv2.* msg type *: peer delay req msg" \
 			true "$test_name"
 
 		check_rcv $rcv_if_name "1588v2 over IPv4, Sync" \
-			"ethertype IPv4 (0x0800).* PTPv2.* msg type : sync msg" \
+			"ethertype IPv4 (0x0800).* PTPv2.* msg type *: sync msg" \
 			true "$test_name"
 
 		check_rcv $rcv_if_name "1588v2 over IPv4, Follow-Up" \
-			"ethertype IPv4 (0x0800).* PTPv2.* msg type : follow up msg" \
+			"ethertype IPv4 (0x0800).* PTPv2.* msg type *: follow up msg" \
 			true "$test_name"
 
 		check_rcv $rcv_if_name "1588v2 over IPv4, Peer Delay Request" \
-			"ethertype IPv4 (0x0800).* PTPv2.* msg type : peer delay req msg" \
+			"ethertype IPv4 (0x0800).* PTPv2.* msg type *: peer delay req msg" \
 			true "$test_name"
 
 		check_rcv $rcv_if_name "1588v2 over IPv6, Sync" \
-			"ethertype IPv6 (0x86dd).* PTPv2.* msg type : sync msg" \
+			"ethertype IPv6 (0x86dd).* PTPv2.* msg type *: sync msg" \
 			true "$test_name"
 
 		check_rcv $rcv_if_name "1588v2 over IPv6, Follow-Up" \
-			"ethertype IPv6 (0x86dd).* PTPv2.* msg type : follow up msg" \
+			"ethertype IPv6 (0x86dd).* PTPv2.* msg type *: follow up msg" \
 			true "$test_name"
 
 		check_rcv $rcv_if_name "1588v2 over IPv6, Peer Delay Request" \
-			"ethertype IPv6 (0x86dd).* PTPv2.* msg type : peer delay req msg" \
+			"ethertype IPv6 (0x86dd).* PTPv2.* msg type *: peer delay req msg" \
 			true "$test_name"
 	fi
 
-- 
2.52.0


