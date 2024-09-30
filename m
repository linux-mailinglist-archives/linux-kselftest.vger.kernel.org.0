Return-Path: <linux-kselftest+bounces-18566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12946989A8C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 08:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2782831E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 06:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E8514EC7E;
	Mon, 30 Sep 2024 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="sRG6o+df"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pv50p00im-ztdg10011201.me.com (pv50p00im-ztdg10011201.me.com [17.58.6.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53C1428E0
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678160; cv=none; b=LCuPCvkYUgMZdnHX3ZCVbOq5eCxxwPZmANRNgFtpR1s+NZ1mTqte02EefIcNLDKoMQI/SEF1HmF1AUFoDXdxZfpDZ0oaSFvusz826/aVBormQUzeb9rnE4F3nNuswTACuV2sMkM+AWwLZ7TjeVofQFHC104PLnXHm3xFX2d9YB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678160; c=relaxed/simple;
	bh=A5LErH9xv6FDKEOfjQFXuxh4NmofzV8m2ak+duflbiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSt+SsPVScnSwLCL5YukLgmpdFtcww7UnU5LfotQiPf7uqJsc+bh8Wvy7P5gFcl/LMXcZ24M3dcfOlV6IuvqhXtbf2qQq88AFFEPVXrp/3CEg5X1Mw3c+J6kqp7aVnyjZNBAPasvhtRrlegN+OdUgmTS38JP97VR1+QVvQMeus4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=sRG6o+df; arc=none smtp.client-ip=17.58.6.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727678159;
	bh=YpNvQndGB93js4nxUO98HA455aZHMvYwZk3y5ssfRE4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=sRG6o+dflKJ+qcAgvo6hpdBjLrjvNrKdyhb6Jby+BnwNOnqmZgQ+snZipc2hOqY35
	 IAsXdDPLHclRkbpHLczc8EU6u1/A+l6cxSNhR+LRRt5uJcxgwlaeVnxl2IdNM8IVmO
	 WFS7pqnMLIvhC+lu8VRN4py4SgxddtY0AI7Ota/dx2OU96HtJ6ifhLEISqGHLSUyOT
	 it4PM26mPbO6Qzsv20rfpg2xFWOzhhFD1fuMTKoojXLHeBT7IeWJZDOXWHKX9Tns3b
	 Z+H3ZjUpvDTW54/tsBA6aamtyw3RQpx4w2YeKvP4/HXxjdyZOs+dVhSObpWNODek+3
	 wNOvrWwr1tp9g==
Received: from ubuntu.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011201.me.com (Postfix) with ESMTPSA id EA2C168031C;
	Mon, 30 Sep 2024 06:35:49 +0000 (UTC)
From: Kacper Ludwinski <kac.ludwinski@icloud.com>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petrm@nvidia.com,
	horms@kernel.org,
	edumazet@google.com,
	shuah@kernel.org,
	Kacper Ludwinski <kac.ludwinski@icloud.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH net v4] selftests: net: no_forwarding: fix VID for $swp2 in one_bridge_two_pvids() test
Date: Mon, 30 Sep 2024 15:35:43 +0900
Message-ID: <20240930063543.94247-1-kac.ludwinski@icloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BHsBwRKz_xEIlJoQRYXd2gKmIwKOYFrm
X-Proofpoint-ORIG-GUID: BHsBwRKz_xEIlJoQRYXd2gKmIwKOYFrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409300046
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

Currently, the second bridge command overwrites the first one.
Fix this by adding this VID to the interface behind $swp2.

The one_bridge_two_pvids() test intends to check that there is no
leakage of traffic between bridge ports which have a single VLAN - the
PVID VLAN.

Because of a typo, port $swp1 is configured with a PVID twice (second
command overwrites first), and $swp2 isn't configured at all (and since
the bridge vlan_default_pvid property is set to 0, this port will not
have a PVID at all, so it will drop all untagged and priority-tagged
traffic).

So, instead of testing the configuration that was intended, we are
testing a different one, where one port has PVID 2 and the other has
no PVID. This incorrect version of the test should also pass, but is
ineffective for its purpose, so fix the typo.

This typo has an impact on results of the test results,
potentially leading to wrong conclusions regarding
the functionality of a network device.

Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Kacper Ludwinski <kac.ludwinski@icloud.com>
---
 tools/testing/selftests/net/forwarding/no_forwarding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v4:
	- Add revision history od this patch
	- Add "Reviewed-by:"
	- Limit number of characters in commit to 80
	- Add impact explanation to commit message
v3:
	- Edit commit message
	- Add missing Signed-off-by
	- Link: https://lore.kernel.org/linux-kselftest/20240927112824.339-1-kac.ludwinski@icloud.com/
v2:
	- Add missing CCs
	- Fix typo in commit message
	- Add target name
	- Link: https://lore.kernel.org/linux-kselftest/fQknN_r6POzmrp8UVjyA3cknLnB1HB9I_jfaHoQScvvgHr59VfUNRs9IDo4kQHm1uxEp8_Luym2Vi6_aUGJIec3ZPhjY2qnJ57NgLZGA3K4=@protonmail.com/
v1:
	- Link: https://lore.kernel.org/linux-kselftest/20240925050539.1906-1-kacper@ludwinski.dev/

diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
index 9e677aa64a06..694ece9ba3a7 100755
--- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
+++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
@@ -202,7 +202,7 @@ one_bridge_two_pvids()
 	ip link set $swp2 master br0
 
 	bridge vlan add dev $swp1 vid 1 pvid untagged
-	bridge vlan add dev $swp1 vid 2 pvid untagged
+	bridge vlan add dev $swp2 vid 2 pvid untagged
 
 	run_test "Switch ports in VLAN-aware bridge with different PVIDs"
 
-- 
2.43.0

