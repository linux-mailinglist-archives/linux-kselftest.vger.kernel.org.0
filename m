Return-Path: <linux-kselftest+bounces-42940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB21BCB797
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 05:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0374055A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 03:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CDB23D7E8;
	Fri, 10 Oct 2025 03:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="o/TK5PsD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0113C3CD;
	Fri, 10 Oct 2025 03:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760065644; cv=none; b=S7l7BHnmz6CMYlAg2e3/hm8axe7QpoESihoMjoFgb98mbMas/+DbR9/167kprD/cDu0C0OK1lb1xXyH+BNnmFj+OgXmNEBnrGtmVIjdcNir9KJenc48jxnXTam2Ms76oqTZ8csFvtxNQ83mhCWyF6dP3ApKLwhDxgJiicsmQyyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760065644; c=relaxed/simple;
	bh=E+PedWIYDXGpsw54lL5cH1Zzlx9PmLHNpe4sM40g0WA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CA8OClBfl9+CbgW7rnzIytzn3x7gc20T1ESJ2kVByGKHBkxes9k7sLW+0fqAdrhvDRIE07xEIDHcL2Gw3gCwwdlRKSXYyRG7Sny4mNJUhsh/pilJHfYDSWU6Y6AkScK3u3kAmRIa4VopxpEDq949ZeFHDxqbO2CuUG0JBPa6RAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=o/TK5PsD; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=obnXO4y70/lmfDM42dcgMfBq8dtpoCphEXp8xd3mUMI=;
	b=o/TK5PsDM+FVyVpmgeBh1TYKBpOn2O2gkfuCMPKQrVRfWzfJAnZLCoangZXzu5KUaOwNFwnpO
	mpsDI1Bh6MSg/eMAkYc00eiCEpucxISqMQd/tBsN0BMBwQyHJHXWfVcftjwlpQ0gZbxsr4Igy3v
	JsioA7MS9RqYsvNVxShN/xs=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cjWq909YYzcb0Q;
	Fri, 10 Oct 2025 11:06:29 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id C04A81402E9;
	Fri, 10 Oct 2025 11:07:17 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 10 Oct
 2025 11:07:16 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <shuah@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <wangliang74@huawei.com>
Subject: [PATCH net-next] selftests: net: check jq command is supported
Date: Fri, 10 Oct 2025 11:30:43 +0800
Message-ID: <20251010033043.140501-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500016.china.huawei.com (7.185.36.197)

The jq command is used in vlan_bridge_binding.sh, if it is not supported,
the test will spam the following log.

  # ./vlan_bridge_binding.sh: line 51: jq: command not found
  # ./vlan_bridge_binding.sh: line 51: jq: command not found
  # ./vlan_bridge_binding.sh: line 51: jq: command not found
  # ./vlan_bridge_binding.sh: line 51: jq: command not found
  # ./vlan_bridge_binding.sh: line 51: jq: command not found
  # TEST: Test bridge_binding on->off when lower down                   [FAIL]
  #       Got operstate of , expected 0

The rtnetlink.sh has the same problem. It makes sense to check if jq is
installed before running these tests. After this patch, the
vlan_bridge_binding.sh skipped if jq is not supported:

  # timeout set to 3600
  # selftests: net: vlan_bridge_binding.sh
  # TEST: jq not installed                                              [SKIP]

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 tools/testing/selftests/net/rtnetlink.sh           | 2 ++
 tools/testing/selftests/net/vlan_bridge_binding.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index dbf77513f617..163a084d525d 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -1466,6 +1466,8 @@ usage: ${0##*/} OPTS
 EOF
 }
 
+require_command jq
+
 #check for needed privileges
 if [ "$(id -u)" -ne 0 ];then
 	end_test "SKIP: Need root privileges"
diff --git a/tools/testing/selftests/net/vlan_bridge_binding.sh b/tools/testing/selftests/net/vlan_bridge_binding.sh
index db481af9b6b3..e8c02c64e03a 100755
--- a/tools/testing/selftests/net/vlan_bridge_binding.sh
+++ b/tools/testing/selftests/net/vlan_bridge_binding.sh
@@ -249,6 +249,8 @@ test_binding_toggle_off_when_upper_down()
 	do_test_binding_off : "on->off when upper down"
 }
 
+require_command jq
+
 trap defer_scopes_cleanup EXIT
 setup_prepare
 tests_run
-- 
2.34.1


