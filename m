Return-Path: <linux-kselftest+bounces-2955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF7A82D240
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jan 2024 23:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5411F21383
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jan 2024 22:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A412C1BA;
	Sun, 14 Jan 2024 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKeeHmg7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE1D2C1B0;
	Sun, 14 Jan 2024 22:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2528AC433F1;
	Sun, 14 Jan 2024 22:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705272470;
	bh=MYytJXqpN/JJg2JT+S/yqKltUArt9T44vTKuLb2rJIw=;
	h=From:To:Cc:Subject:Date:From;
	b=cKeeHmg7TLiAZC/q4XjackcPp6WNwpxfzmHrt3uN/xdeRuZ/M//cBJ+CtGn/f1HcI
	 V9rRi66jBLO2bPNiG0hTjemzdpPPs6arECOLhIy72r0Yv295oBviMbO7UzQRmlQmcv
	 7AOGZx97Xfia7n8oURUDSR5mwoZ7dEmQXW67KZdVp4/VA0zYJMyWlIeuPalBINHfM2
	 J8T+KMDGUSgl035IZGlOSTNHLl7HkBxiBfOXrJaWWqE21E9JIMbw+drxW88CeJ7uID
	 pfzLgphGgbjOdxOiPbf0S5eAj/yqxoBGZ7yO22jAQchhYJbUxmzvru7qiP7DpuWA3C
	 4o/9md2Tq9seg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: netdevsim: correct expected FEC strings
Date: Sun, 14 Jan 2024 14:47:48 -0800
Message-ID: <20240114224748.1210578-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ethtool CLI has changed its output. Make the test compatible.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 .../drivers/net/netdevsim/ethtool-fec.sh       | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
index 0c56746e9ce0..7d7829f57550 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/ethtool-fec.sh
@@ -8,16 +8,20 @@ NSIM_NETDEV=$(make_netdev)
 
 set -o pipefail
 
+# Since commit 2b3ddcb35357 ("ethtool: fec: Change the prompt ...")
+# in ethtool CLI the Configured lines start with Supported/Configured.
+configured=$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2 | head -1 | cut -d' ' -f1)
+
 # netdevsim starts out with None/None
 s=$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
-check $? "$s" "Configured FEC encodings: None
+check $? "$s" "$configured FEC encodings: None
 Active FEC encoding: None"
 
 # Test Auto
 $ETHTOOL --set-fec $NSIM_NETDEV encoding auto
 check $?
 s=$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
-check $? "$s" "Configured FEC encodings: Auto
+check $? "$s" "$configured FEC encodings: Auto
 Active FEC encoding: Off"
 
 # Test case in-sensitivity
@@ -25,7 +29,7 @@ for o in off Off OFF; do
     $ETHTOOL --set-fec $NSIM_NETDEV encoding $o
     check $?
     s=$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
-    check $? "$s" "Configured FEC encodings: Off
+    check $? "$s" "$configured FEC encodings: Off
 Active FEC encoding: Off"
 done
 
@@ -33,7 +37,7 @@ for o in BaseR baser BAser; do
     $ETHTOOL --set-fec $NSIM_NETDEV encoding $o
     check $?
     s=$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
-    check $? "$s" "Configured FEC encodings: BaseR
+    check $? "$s" "$configured FEC encodings: BaseR
 Active FEC encoding: BaseR"
 done
 
@@ -41,7 +45,7 @@ for o in llrs rs; do
     $ETHTOOL --set-fec $NSIM_NETDEV encoding $o
     check $?
     s=$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
-    check $? "$s" "Configured FEC encodings: ${o^^}
+    check $? "$s" "$configured FEC encodings: ${o^^}
 Active FEC encoding: ${o^^}"
 done
 
@@ -49,13 +53,13 @@ done
 $ETHTOOL --set-fec $NSIM_NETDEV encoding rs llrs
 check $?
 s=$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
-check $? "$s" "Configured FEC encodings: RS LLRS
+check $? "$s" "$configured FEC encodings: RS LLRS
 Active FEC encoding: LLRS"
 
 $ETHTOOL --set-fec $NSIM_NETDEV encoding rs off auto
 check $?
 s=$($ETHTOOL --show-fec $NSIM_NETDEV | tail -2)
-check $? "$s" "Configured FEC encodings: Auto Off RS
+check $? "$s" "$configured FEC encodings: Auto Off RS
 Active FEC encoding: RS"
 
 # Make sure other link modes are rejected
-- 
2.43.0


