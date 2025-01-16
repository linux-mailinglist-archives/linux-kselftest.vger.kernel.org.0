Return-Path: <linux-kselftest+bounces-24616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6511FA13100
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 03:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC191888EF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 02:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A9C17578;
	Thu, 16 Jan 2025 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSR2ajiN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02124A7C2;
	Thu, 16 Jan 2025 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736992871; cv=none; b=VcuLk07Z6upSMenwKJJRYzVT/yARr2ef1KBesuPC4bvzFKvSP9LstMxpyDQC3ZMfU9TOTKbkykloUop/8w5ZGlVnOZkIpiKxKGiv3cGsRiVbpswfMbVBfJaPz6/WIYCk18ClM4ZLhOq7LnUijdF8SLIC47k6rUkleg6O7f7SHOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736992871; c=relaxed/simple;
	bh=k7vDAaC+/z+iEoB2pRYl1CqHTDynOmhU4+hG5waP8C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHzVDXxhMSWxiQAYRv1RrI+z2t4v47hdE2tOFltf2hm5uUOmMRiY2Gc63uhFOSw0gQHfiVL9Au3Au31ma5bSuwed+Vc33wCorqDAM5QBDCpSi+6EwgmXfzOuIfz1oHAr2e9FDt8+FJ6UmKzNqTPayeS/AG+AbA8nf/VBrwuP7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSR2ajiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B81A8C4CED1;
	Thu, 16 Jan 2025 02:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736992871;
	bh=k7vDAaC+/z+iEoB2pRYl1CqHTDynOmhU4+hG5waP8C8=;
	h=From:To:Cc:Subject:Date:From;
	b=WSR2ajiNegiTn7xwwHR3BjuT2xOq5H6nRmelElMOhyCyQcl0X7r9aXqbeCNLcmwad
	 SCXdQUgPK/EMwQQuoRpiZcrecel5+95cAR3hFq3/Q70q1KwGYXHQWapKLQ8nU/8G5H
	 dheQBAZeoa3xjaX3nd+xT2vdD47R+7T3HlgR2c38EiExWZrSKF7BjtxDZDZnYyoIVJ
	 nKZL4lMTAv71Z8F07yp6HsQFjW6iSzjMWBo0kaNYSE0SdF0s/kbS9rukxZmnbdEZMA
	 LPy4HmygT70EQ4jLgT+ce8fcDrPmKkEDDXOWwLSWY0IiSaGaj11NL6ULfIFmHQP+dO
	 9xyfHw2QBz8Fw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net-next] selftests: net: give up on the cmsg_time accuracy on slow machines
Date: Wed, 15 Jan 2025 18:01:05 -0800
Message-ID: <20250116020105.931338-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b9d5f5711dd8 ("selftests: net: increase the delay for relative
cmsg_time.sh test") widened the accepted value range 8x but we still
see flakes (at a rate of around 7%).

Return XFAIL for the most timing sensitive test on slow machines.

Before:

  # ./cmsg_time.sh
    Case UDPv4  - TXTIME rel returned '8074us - 7397us < 4000', expected 'OK'
  FAIL - 1/36 cases failed

After:

  # ./cmsg_time.sh
    Case UDPv4  - TXTIME rel returned '1123us - 941us < 500', expected 'OK' (XFAIL)
    Case UDPv6  - TXTIME rel returned '1227us - 776us < 500', expected 'OK' (XFAIL)
  OK

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
CC: willemdebruijn.kernel@gmail.com
---
 tools/testing/selftests/net/cmsg_time.sh | 35 +++++++++++++++++-------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/cmsg_time.sh b/tools/testing/selftests/net/cmsg_time.sh
index 1d7e756644bc..478af0aefa97 100755
--- a/tools/testing/selftests/net/cmsg_time.sh
+++ b/tools/testing/selftests/net/cmsg_time.sh
@@ -34,13 +34,28 @@ BAD=0
 TOTAL=0
 
 check_result() {
+    local ret=$1
+    local got=$2
+    local exp=$3
+    local case=$4
+    local xfail=$5
+    local xf=
+    local inc=
+
+    if [ "$xfail" == "xfail" ]; then
+	xf="(XFAIL)"
+	inc=0
+    else
+	inc=1
+    fi
+
     ((TOTAL++))
-    if [ $1 -ne 0 ]; then
-	echo "  Case $4 returned $1, expected 0"
-	((BAD++))
+    if [ $ret -ne 0 ]; then
+	echo "  Case $case returned $ret, expected 0 $xf"
+	((BAD+=inc))
     elif [ "$2" != "$3" ]; then
-	echo "  Case $4 returned '$2', expected '$3'"
-	((BAD++))
+	echo "  Case $case returned '$got', expected '$exp' $xf"
+	((BAD+=inc))
     fi
 }
 
@@ -66,14 +81,14 @@ for i in "-4 $TGT4" "-6 $TGT6"; do
 		 awk '/SND/ { if ($3 > 1000) print "OK"; }')
 	check_result $? "$ts" "OK" "$prot - TXTIME abs"
 
-	[ "$KSFT_MACHINE_SLOW" = yes ] && delay=8000 || delay=1000
+	[ "$KSFT_MACHINE_SLOW" = yes ] && xfail=xfail
 
-	ts=$(ip netns exec $NS ./cmsg_sender -p $p $i 1234 -t -d $delay |
+	ts=$(ip netns exec $NS ./cmsg_sender -p $p $i 1234 -t -d 1000 |
 		 awk '/SND/ {snd=$3}
 		      /SCHED/ {sch=$3}
-		      END { if (snd - sch > '$((delay/2))') print "OK";
-			    else print snd, "-", sch, "<", '$((delay/2))'; }')
-	check_result $? "$ts" "OK" "$prot - TXTIME rel"
+		      END { if (snd - sch > 500) print "OK";
+			    else print snd, "-", sch, "<", 500; }')
+	check_result $? "$ts" "OK" "$prot - TXTIME rel" $xfail
     done
 done
 
-- 
2.48.0


