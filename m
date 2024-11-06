Return-Path: <linux-kselftest+bounces-21553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A08B9BF9C1
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 00:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93EAAB21719
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 23:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54AAC20E004;
	Wed,  6 Nov 2024 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="wTG4I3aq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fnPfu3rC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A3E20D4FE;
	Wed,  6 Nov 2024 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730934842; cv=none; b=oecmzKGogm7Oskp2GIId6Bo65BllIy+wAgtIJRou5TSZZNjySf1iTLYhsBMpSe6TpudQwSLQLuI2AMLPqd2RE8YTBqgWGeRiusjDMyJ19pEnEp8Na7HatiawASq7Jj9HuCUup0H0VZlBWgdO2/Xrk23l1e9M/lWcfa7T8t3LIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730934842; c=relaxed/simple;
	bh=upi6aFSkqDwgeAtG7G2bMl/cX6o5AguCm7pnNdatVBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvKtwuLws5+TCiq3GOK5jJvnMhyvqlxRUfbdwGyTH9MBVQZBxeKJUD7/QOVvXSSm2j5LGzEZU5YtzIB6jNs5XlFO7IKVuYQGEFClYxF6FVwJ3XgExuwjTr55imMry/pWSpGlLAjV7HVh4vsZX44+PgUODylqho0OfvGpo3+WMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=wTG4I3aq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fnPfu3rC; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 1BC7C1D402D4;
	Wed,  6 Nov 2024 18:13:59 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 06 Nov 2024 18:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1730934838; x=
	1730938438; bh=ch6ZOFfW93o9T0aJ2TMNc5B4CZ8UlZQsITw9cF+NXZQ=; b=w
	TG4I3aqFryGVrvAycRsn2NySGOXD6xCHqPnqCkr+909h8/d11dMxFSTtJBJRIhLe
	TBq0LVDYfLP9kx8pueV3D/+htnEokgSxWxHzDv3KsXnYHfMCmL5EkJDWd5YEDQGZ
	LjsXIMDsn5bOGRT1tBarXLYjOZiH1FqFp0n9PuCHwTSYvkqSgKh/FROJ/vksgOIf
	4QXTzrJ7m2e34nYzrvjZZtixOXn1E8XOTLD9A26zwVUzBMtAOXn9ApUXzvlutED+
	E0BNXq+gVXeHJgrKVHL6t32e6MWdk2CGGRZGZr+lK6Ub8g/KVFDcBeRLU5zi1b79
	YYLFt6rCdieS7w3E2pthw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730934838; x=1730938438; bh=c
	h6ZOFfW93o9T0aJ2TMNc5B4CZ8UlZQsITw9cF+NXZQ=; b=fnPfu3rCrTB8xwm4r
	AYD7htOiWzmI+hGbFkCp+wZNI+hznSZn7uDEliAppNTXIpasp5QwZPRfLhF4zQbX
	tSs2kIDstzA+drXLSY/DOlBdCwh04TTq0D3QeyAqFSZ2DJFWWmY0udaxFmKKSva/
	vMqOXiL2ml6krVA8XhKWPd6gD/hPxtmBprSRvjcT20nn3ZLLLQI57TLOTyHTU2Es
	uZKhjMzv/BRG5wmWqhom2q59KYWAQjps5JU2qJ1Tgp7BHYlAgcoeXWo8PvcFdMSB
	6uldkHnSZOpR1IVijZSUU9hgdZ03X51iPn7mJ5C18fFiVMiPLJMnbjDR0sE0b9MW
	d1u1w==
X-ME-Sender: <xms:NvgrZ5wbs-_QGi_KjwfFkgzCsI5stJ40ciCaw63MINi8W9Jv7Kry0w>
    <xme:NvgrZ5QF1_0ko6xEcjNxW9G1oLCiRpC0RUB-CUh6586ZbqbjEHzti5UCBD8PPaudw
    Cb1DMlklguuWNqJfgU>
X-ME-Received: <xmr:NvgrZzWwYLe409mylKTYwITO77IiYwIvfZ6qE5rEIgzKssTwn2GybvlVFyqh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdefgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrih
    hlrdhnvghtqeenucggtffrrghtthgvrhhnpeeiieeuieethedtfeehkefhhfegveeuhfet
    veeuleejieejieevhefghedugfehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgusehquhgvrghshihsnhgr
    ihhlrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkshgv
    lhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NvgrZ7gQOp7EGUcfcvhXfX7ixPGbeWRwXDDRKXH6sUS-4bjXbt-Gew>
    <xmx:NvgrZ7Ayor_LoZM7KYoJe1MEU0_WY4FXj7h9frN9m3RypyzHZiW61w>
    <xmx:NvgrZ0JRwCx__yobrQmzXAnwh2TQMy414ztALK5H8t9rTM2DgU2mRg>
    <xmx:NvgrZ6B2WW5z02Zv8GTMsCiVaHSIaDJ6-CQFCL6_GVz3QCTTTwsKSA>
    <xmx:NvgrZ-PlntGByC1-RAkP1nLEwOWZgOJzdf7V_DLUxixPfyie-DU_mWcC>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Nov 2024 18:13:58 -0500 (EST)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/8] selftests: netdevsim: add a test checking ethtool features
Date: Thu,  7 Nov 2024 00:13:28 +0100
Message-ID: <fff58fa70f8a300440958b5020f6a4eb2e9dad61.1730929545.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730929545.git.sd@queasysnail.net>
References: <cover.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test checking that some features are active by default and
changeable.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 .../selftests/drivers/net/netdevsim/Makefile  |  1 +
 .../drivers/net/netdevsim/ethtool-features.sh | 31 +++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/netdevsim/ethtool-features.sh

diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
index cc08b220323f..df167c637af9 100644
--- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
+++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
@@ -4,6 +4,7 @@ TEST_PROGS = devlink.sh \
 	devlink_in_netns.sh \
 	devlink_trap.sh \
 	ethtool-coalesce.sh \
+	ethtool-features.sh \
 	ethtool-fec.sh \
 	ethtool-pause.sh \
 	ethtool-ring.sh \
diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-features.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-features.sh
new file mode 100644
index 000000000000..bc210dc6ad2d
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-features.sh
@@ -0,0 +1,31 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+source ethtool-common.sh
+
+NSIM_NETDEV=$(make_netdev)
+
+set -o pipefail
+
+FEATS="
+  tx-checksum-ip-generic
+  tx-scatter-gather
+  tx-tcp-segmentation
+  generic-segmentation-offload
+  generic-receive-offload"
+
+for feat in $FEATS ; do
+    s=$(ethtool --json -k $NSIM_NETDEV | jq ".[].\"$feat\".active" 2>/dev/null)
+    check $? "$s" true
+
+    s=$(ethtool --json -k $NSIM_NETDEV | jq ".[].\"$feat\".fixed" 2>/dev/null)
+    check $? "$s" false
+done
+
+if [ $num_errors -eq 0 ]; then
+    echo "PASSED all $((num_passes)) checks"
+    exit 0
+else
+    echo "FAILED $num_errors/$((num_errors+num_passes)) checks"
+    exit 1
+fi
-- 
2.47.0


