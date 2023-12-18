Return-Path: <linux-kselftest+bounces-2145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F6F816FAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 14:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66F521C23E49
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Dec 2023 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7B049891;
	Mon, 18 Dec 2023 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+KX5ASB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3242361;
	Mon, 18 Dec 2023 12:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E89C433C8;
	Mon, 18 Dec 2023 12:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702904124;
	bh=eqN7zRw7WXbeNqUeOcj5HIHBiHvdA7pEbtvP3j9Ylt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I+KX5ASBs18FllyqN4mTeGBTARsAFrAtJqz8bthCz84OLiLwjLG8wA5VGLtIE7Hyp
	 RUMLxgWZpG0HvFMQce15kepJwbsqOZ5PVSys/mT6di6lyxdH4Tg4TAb9+ctm6rrzG2
	 ztFg147FB5jirFvaPcFLzEnldmM6Drwm1EkeAZfI1MxgLB8ubFBc+o7q9qSZTNatbY
	 CdHwQDwTa0F9HYs0+4i6u5u178dlQtin2YCAOdsNdJwQUvVRvUPjPlgWnOmfp7UBL0
	 CjTywIDJhjIZ5vcYxrfchWEu+46mKel7TBKuNKPaHTA/TohiYFwjqGW1sX7yqcVRom
	 pP/ZgyIBm7MEw==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	vladimir.oltean@nxp.com
Cc: s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rogerq@kernel.org
Subject: [PATCH net-next v10 01/10] selftests: forwarding: ethtool_mm: support devices with higher rx-min-frag-size
Date: Mon, 18 Dec 2023 14:55:04 +0200
Message-Id: <20231218125513.52337-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218125513.52337-1-rogerq@kernel.org>
References: <20231218125513.52337-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Some devices have errata due to which they cannot report ETH_ZLEN (60)
in the rx-min-frag-size. This was foreseen of course, and lldpad has
logic that when we request it to advertise addFragSize 0, it will round
it up to the lowest value that is _actually_ supported by the hardware.

The problem is that the selftest expects lldpad to report back to us the
same value as we requested.

Make the selftest smarter by figuring out on its own what is a
reasonable value to expect.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Roger Quadros <rogerq@kernel.org>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 .../selftests/net/forwarding/ethtool_mm.sh    | 37 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 2 deletions(-)

Changelog:

v10: no change.
v9: no code change. Added Kselftest maintainer in Cc.
v8: no change. Moved to the beginning of series.
v7: initial commit

diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
index 39e736f30322..6212913f4ad1 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
@@ -155,15 +155,48 @@ manual_failed_verification_h2_to_h1()
 	manual_failed_verification $h2 $h1
 }
 
+smallest_supported_add_frag_size()
+{
+	local iface=$1
+	local rx_min_frag_size=
+
+	rx_min_frag_size=$(ethtool --json --show-mm $iface | \
+		jq '.[]."rx-min-frag-size"')
+
+	if [ $rx_min_frag_size -le 60 ]; then
+		echo 0
+	elif [ $rx_min_frag_size -le 124 ]; then
+		echo 1
+	elif [ $rx_min_frag_size -le 188 ]; then
+		echo 2
+	elif [ $rx_min_frag_size -le 252 ]; then
+		echo 3
+	else
+		echo "$iface: RX min frag size $rx_min_frag_size cannot be advertised over LLDP"
+		exit 1
+	fi
+}
+
+expected_add_frag_size()
+{
+	local iface=$1
+	local requested=$2
+	local min=$(smallest_supported_add_frag_size $iface)
+
+	[ $requested -le $min ] && echo $min || echo $requested
+}
+
 lldp_change_add_frag_size()
 {
 	local add_frag_size=$1
+	local pattern=
 
 	lldptool -T -i $h1 -V addEthCaps addFragSize=$add_frag_size >/dev/null
 	# Wait for TLVs to be received
 	sleep 2
-	lldptool -i $h2 -t -n -V addEthCaps | \
-		grep -q "Additional fragment size: $add_frag_size"
+	pattern=$(printf "Additional fragment size: %d" \
+			 $(expected_add_frag_size $h1 $add_frag_size))
+	lldptool -i $h2 -t -n -V addEthCaps | grep -q "$pattern"
 }
 
 lldp()
-- 
2.34.1


