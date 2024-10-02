Return-Path: <linux-kselftest+bounces-18861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCF598CC3F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 07:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867D41C21FA7
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 05:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080FD18027;
	Wed,  2 Oct 2024 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="i5YOjHY0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pv50p00im-ztdg10011901.me.com (pv50p00im-ztdg10011901.me.com [17.58.6.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C5314A8B
	for <linux-kselftest@vger.kernel.org>; Wed,  2 Oct 2024 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727845858; cv=none; b=jwvYCU5dyBfzb+9C4NCMWCIkvU6UWO/NPAKmHXdEyOLIUgtY4PkyqwFzN37eQFLZBx64kyiOVc4AISJxZsIZXlHvpUOf00qJailypeGtZjZ3GXK6t+66xyvxWXvKUNOM3r/Vn/pWU/0LpG0UZNitQbEsvCR8CS/Y3gNpAGzRsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727845858; c=relaxed/simple;
	bh=rKeyUKAoTjjQFoj/mtwHG693RsvejY4A8xpuxnyvOUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UADdUHU7J31U0yn3mL1Zg7lpHON5ew5uzDC6IOoRuLiBqy1eTbPaIMd6oC/reuyInLqfM0QIwDfUPQbqVhiEwEtx0saOBBesKtyvf+9op40CvmPoBmo1UTtrRO2Cf2DqNhG5zIOqhOCJeuTDG1Z7QPXqLQAD/iJhfmxmjp7gfR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=i5YOjHY0; arc=none smtp.client-ip=17.58.6.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727845857;
	bh=z6G3IxDExIkEjufiT6GAO8RF3h8veylkvKjMfW2oLCs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=i5YOjHY0FQgc7fW+JSKTYAFGLsK0xBUyBULRvPEinnFAYgnjdLl2+C60BDJZxlydf
	 96pi6qnpy3K38rg5ePmfL34DqU4h6Vt+DpmMR6Ze/jJUQp70qWunqAW+wsuorYkCHN
	 A9zQetyFZyMCSsEwyG5rhI/VIBuHwTHAcYzI22F+N+Jq1kEB8Ppqb98rbshx6WEvt/
	 dm/aJ/Cu+hmMXSYUpyFwFfk8DQGvqKBV/zN8QlnHurAKIto0no+KXoJhnFmhckvg/H
	 R5ecXS8vgWGu408aUonJyCYrSS4XZxm0isgN2M+QRaeV+CC5aOIpB0RLNsbNsaDRsN
	 rJ6F7eDMva9ng==
Received: from ubuntu.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10011901.me.com (Postfix) with ESMTPSA id D184A3A0060;
	Wed,  2 Oct 2024 05:10:49 +0000 (UTC)
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
Subject: [PATCH net v5] selftests: net: no_forwarding: fix VID for $swp2 in one_bridge_two_pvids() test
Date: Wed,  2 Oct 2024 14:10:16 +0900
Message-ID: <20241002051016.849-1-kac.ludwinski@icloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WWsqm_HQ7cKzEovU1bdz2-cklD7v5vos
X-Proofpoint-ORIG-GUID: WWsqm_HQ7cKzEovU1bdz2-cklD7v5vos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_04,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410020036
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

This typo has an impact on results of the test,
potentially leading to wrong conclusions regarding
the functionality of a network device.

The tests results:

TEST: Switch ports in VLAN-aware bridge with different PVIDs:
	Unicast non-IP untagged   [ OK ]
	Multicast non-IP untagged   [ OK ]
	Broadcast non-IP untagged   [ OK ]
	Unicast IPv4 untagged   [ OK ]
	Multicast IPv4 untagged   [ OK ]
	Unicast IPv6 untagged   [ OK ]
	Multicast IPv6 untagged   [ OK ]
	Unicast non-IP VID 1   [ OK ]
	Multicast non-IP VID 1   [ OK ]
	Broadcast non-IP VID 1   [ OK ]
	Unicast IPv4 VID 1   [ OK ]
	Multicast IPv4 VID 1   [ OK ]
	Unicast IPv6 VID 1   [ OK ]
	Multicast IPv6 VID 1   [ OK ]
	Unicast non-IP VID 4094   [ OK ]
	Multicast non-IP VID 4094   [ OK ]
	Broadcast non-IP VID 4094   [ OK ]
	Unicast IPv4 VID 4094   [ OK ]
	Multicast IPv4 VID 4094   [ OK ]
	Unicast IPv6 VID 4094   [ OK ]
	Multicast IPv6 VID 4094   [ OK ]

Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Kacper Ludwinski <kac.ludwinski@icloud.com>
---
 tools/testing/selftests/net/forwarding/no_forwarding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v5:
	- Add test results impacted by the changes
	- Fix typo in commit message
v4:
	- Add revision history od this patch
	- Add "Reviewed-by:"
	- Limit number of characters in commit to 80
	- Add impact explanation to commit message
	- Link: https://lore.kernel.org/linux-kselftest/20240930063543.94247-1-kac.ludwinski@icloud.com/
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


