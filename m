Return-Path: <linux-kselftest+bounces-2191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87EB8185CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 11:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0721C235E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AB715ACD;
	Tue, 19 Dec 2023 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLtfXYLG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5B15484;
	Tue, 19 Dec 2023 10:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FA7FC433CD;
	Tue, 19 Dec 2023 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702983496;
	bh=LwE/zCQspof3hzs385Wn2K0uSLjNcANdEfz0jpywhOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLtfXYLGJ0nhk11riQDUR+mcoL59/3XX7jnbeUvaSCOmkt3xcc/ohnDjKL2dmWH9H
	 p9M3M65vBaVWNByWml88IlfwrI7xyRovh9XRkxBr0sTFUJKkuH8v1tSvOD0nFTQDI4
	 qyALWMu30QrQdJG9wwZvPNai01J0zdPAMT/hbVHRembXWmDda+4sUTBjJKSSHN46R0
	 mGjoh8MODmyabDJ5VMfdqZN+uB63aKomKYbof6nHOMx5TfWVuU8/Pm2MNXl7+4El3p
	 6L96heVSKVyjXxDYmsIaMK0OhQ8v8n9p2jtCjjtqn0LbCVINGBYbm4Yivlnsyb6bjx
	 l76th9WU9seAQ==
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
Subject: [PATCH net-next v11 01/10] selftests: forwarding: ethtool_mm: support devices with higher rx-min-frag-size
Date: Tue, 19 Dec 2023 12:57:56 +0200
Message-Id: <20231219105805.80617-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219105805.80617-1-rogerq@kernel.org>
References: <20231219105805.80617-1-rogerq@kernel.org>
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

v11: no change
v10: no change
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


