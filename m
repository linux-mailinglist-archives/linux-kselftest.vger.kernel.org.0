Return-Path: <linux-kselftest+bounces-30068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA7A7A5C9
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 16:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0781885619
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 14:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F4E2500D0;
	Thu,  3 Apr 2025 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgKlvynW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3EC24EF97;
	Thu,  3 Apr 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692202; cv=none; b=dUll3fnQvZ64+WOFk3nfYhzd9+hXV9fGVswe3N6lYXyIroWNYsf2wIXPenUDpiYSh9ltOkpS/lYQl5umVWyrCRy69RATKqydXaNmxPWUwo1x8JnoWbfE0bc1IHpUaaxk1J4cOzAQdYQN+ojAID9o3Ml7EL2dEl0mQdGfeWdECqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692202; c=relaxed/simple;
	bh=6/x6iXXhs066uwpjYjDYbJ4AK+vYOFcSaGF7+d13GD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vgp/4fcieUqXtsW4xldJfwDfkYkrq1/aRMX3xuUhU+8SLcR92Rch47X4Umep449ZLANg8sX5WzNVLW4yaGUmGprFpvBvoR1G1cOborfBJtic8mBVPL2zn3v3vFQ63HFw+UzDHvh+p9jUII5fZUF93IY3PWWOAJ+anKFYxI9F3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgKlvynW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A91C4CEE3;
	Thu,  3 Apr 2025 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743692199;
	bh=6/x6iXXhs066uwpjYjDYbJ4AK+vYOFcSaGF7+d13GD8=;
	h=From:To:Cc:Subject:Date:From;
	b=NgKlvynW5R4qzTy2jAixjRYgk2fgUXpaW9TqP2pVVm3YdRIpm70Paz3wpglPVxXmL
	 QuBOBS8F6VZNtryzxgC3FrOu5QlqnImiEzK2oXvcPBI8aN2JN7REFctw1jlUl5dXTm
	 c8IqIQdeMYAdKRuKpC1q859FQHsPR/7TsqxxrMyRuwTeT/EObp0D7z9PMcR9cb5TBm
	 rwGi1TIJ37t7CEFOAjU5SAcCjH2110xEK5zeUcev9W9P1thirYyhfN/GqVGsdvidxE
	 ADwMXNgjzKU6O391mMUc7THj5wbz5KIo36z/i9Z47JiecA9LiFoWq9LMjEm5ZAjh3w
	 yGmTjl1aJ73DA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	ap420073@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: amt: indicate progress in the stress test
Date: Thu,  3 Apr 2025 07:56:36 -0700
Message-ID: <20250403145636.2891166-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our CI expects output from the test at least once every 10 minutes.
The AMT test when running on debug kernel is just on the edge
of that time for the stress test. Improve the output:
 - print the name of the test first, before starting it,
 - output a dot every 10% of the way.

Output after:

  TEST: amt discovery                                                 [ OK ]
  TEST: IPv4 amt multicast forwarding                                 [ OK ]
  TEST: IPv6 amt multicast forwarding                                 [ OK ]
  TEST: IPv4 amt traffic forwarding torture               ..........  [ OK ]
  TEST: IPv6 amt traffic forwarding torture               ..........  [ OK ]

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Since net-next is closed I'm sending this for net.
We enabled DEBUG_PREEMPT in the debug flavor and the test now
times out most of the time.

CC: ap420073@gmail.com
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/amt.sh | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index d458b45c775b..3ef209cacb8e 100755
--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -194,15 +194,21 @@ test_remote_ip()
 
 send_mcast_torture4()
 {
-	ip netns exec "${SOURCE}" bash -c \
-		'cat /dev/urandom | head -c 1G | nc -w 1 -u 239.0.0.1 4001'
+	for i in `seq 10`; do
+		ip netns exec "${SOURCE}" bash -c \
+		   'cat /dev/urandom | head -c 100M | nc -w 1 -u 239.0.0.1 4001'
+		echo -n "."
+	done
 }
 
 
 send_mcast_torture6()
 {
-	ip netns exec "${SOURCE}" bash -c \
-		'cat /dev/urandom | head -c 1G | nc -w 1 -u ff0e::5:6 6001'
+	for i in `seq 10`; do
+		ip netns exec "${SOURCE}" bash -c \
+		   'cat /dev/urandom | head -c 100M | nc -w 1 -u ff0e::5:6 6001'
+		echo -n "."
+	done
 }
 
 check_features()
@@ -278,10 +284,12 @@ wait $pid || err=$?
 if [ $err -eq 1 ]; then
 	ERR=1
 fi
+printf "TEST: %-50s" "IPv4 amt traffic forwarding torture"
 send_mcast_torture4
-printf "TEST: %-60s  [ OK ]\n" "IPv4 amt traffic forwarding torture"
+printf "  [ OK ]\n"
+printf "TEST: %-50s" "IPv6 amt traffic forwarding torture"
 send_mcast_torture6
-printf "TEST: %-60s  [ OK ]\n" "IPv6 amt traffic forwarding torture"
+printf "  [ OK ]\n"
 sleep 5
 if [ "${ERR}" -eq 1 ]; then
         echo "Some tests failed." >&2
-- 
2.49.0


