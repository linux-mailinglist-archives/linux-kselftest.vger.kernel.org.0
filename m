Return-Path: <linux-kselftest+bounces-36079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0327AECEF0
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 19:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4E7188DBEE
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC1523185E;
	Sun, 29 Jun 2025 17:14:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B78B1EFF92;
	Sun, 29 Jun 2025 17:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217260; cv=none; b=hu3TR3Bk0hiLatjR6CKOxJYs7fQ8XnOIdTF4jzAS8jrcXjjM/RmG6neT7buBfVV1aY2NLQmhNZI3eRASuzpOSgm1g+ObcarHxwmHXwk6ypv2TnaU1mkua0U9bTyfkyRV0y2wAG+KXpgb4knoYo7BsxTym8cjOLy//mCuqlG4px0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217260; c=relaxed/simple;
	bh=HnkcJii31P0NALm35gffTRdskIHKxHTT/7RAsoQ2fME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHVlS80Y3+Ur5hTZSFWj2hzLhijjaV1sOSrZoqHy6/rl09Q0K49m5z5/7lcBVkeEi3S+OunS4ZKJCd2FVzMIgwJ8pstYtnCpJXmTiZqxCGknrMNawDXtcAQtfyg+Dun7yzQ3v6EASwUIysOiioCDVptFF7oIwcWo1EHqUBlp+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 55THDW5A007121
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 29 Jun 2025 19:14:04 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc: Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: [PATCH net-next 2/2] selftests: seg6: fix instaces typo in comments
Date: Sun, 29 Jun 2025 19:12:26 +0200
Message-Id: <20250629171226.4988-3-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250629171226.4988-1-andrea.mayer@uniroma2.it>
References: <20250629171226.4988-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

Fix a typo:
  instaces -> instances

The typo has been identified using codespell, and the tool does not
report any additional issues in the selftests considered.

Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 tools/testing/selftests/net/srv6_end_next_csid_l3vpn_test.sh   | 2 +-
 tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh | 2 +-
 tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh      | 2 +-
 tools/testing/selftests/net/srv6_hl2encap_red_l2vpn_test.sh    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/srv6_end_next_csid_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_next_csid_l3vpn_test.sh
index ba730655a7bf..4bc135e5c22c 100755
--- a/tools/testing/selftests/net/srv6_end_next_csid_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_next_csid_l3vpn_test.sh
@@ -594,7 +594,7 @@ setup_rt_local_sids()
 		dev "${DUMMY_DEVNAME}"
 
 	# all SIDs for VPNs start with a common locator. Routes and SRv6
-	# Endpoint behavior instaces are grouped together in the 'localsid'
+	# Endpoint behavior instances are grouped together in the 'localsid'
 	# table.
 	ip -netns "${nsname}" -6 rule \
 		add to "${VPN_LOCATOR_SERVICE}::/16" \
diff --git a/tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh
index bedf0ce885c2..34b781a2ae74 100755
--- a/tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_end_x_next_csid_l3vpn_test.sh
@@ -681,7 +681,7 @@ setup_rt_local_sids()
         set_underlay_sids_reachability "${rt}" "${rt_neighs}"
 
 	# all SIDs for VPNs start with a common locator. Routes and SRv6
-	# Endpoint behavior instaces are grouped together in the 'localsid'
+	# Endpoint behavior instances are grouped together in the 'localsid'
 	# table.
 	ip -netns "${nsname}" -6 rule \
 		add to "${VPN_LOCATOR_SERVICE}::/16" \
diff --git a/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh b/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh
index 3efce1718c5f..6a68c7eff1dc 100755
--- a/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_hencap_red_l3vpn_test.sh
@@ -395,7 +395,7 @@ setup_rt_local_sids()
 		dev "${VRF_DEVNAME}"
 
 	# all SIDs for VPNs start with a common locator. Routes and SRv6
-	# Endpoint behavior instaces are grouped together in the 'localsid'
+	# Endpoint behavior instances are grouped together in the 'localsid'
 	# table.
 	ip -netns "${nsname}" -6 rule \
 		add to "${VPN_LOCATOR_SERVICE}::/16" \
diff --git a/tools/testing/selftests/net/srv6_hl2encap_red_l2vpn_test.sh b/tools/testing/selftests/net/srv6_hl2encap_red_l2vpn_test.sh
index cabc70538ffe..0979b5316fdf 100755
--- a/tools/testing/selftests/net/srv6_hl2encap_red_l2vpn_test.sh
+++ b/tools/testing/selftests/net/srv6_hl2encap_red_l2vpn_test.sh
@@ -343,7 +343,7 @@ setup_rt_local_sids()
 		encap seg6local action End dev "${DUMMY_DEVNAME}"
 
 	# all SIDs for VPNs start with a common locator. Routes and SRv6
-	# Endpoint behaviors instaces are grouped together in the 'localsid'
+	# Endpoint behaviors instances are grouped together in the 'localsid'
 	# table.
 	ip -netns "${nsname}" -6 rule add \
 		to "${VPN_LOCATOR_SERVICE}::/16" \
-- 
2.20.1


