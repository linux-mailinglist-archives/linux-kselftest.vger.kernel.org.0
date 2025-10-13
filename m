Return-Path: <linux-kselftest+bounces-42985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 351ADBD1D65
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 09:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B7118987FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 07:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA902E8B71;
	Mon, 13 Oct 2025 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wpD7FE8Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CD27BF6C;
	Mon, 13 Oct 2025 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341054; cv=none; b=f2X0SMZTGlmVXWeH0BdP7Zw9BLvdJ3w1z5zThP8s8Eu4phIYjjbaKXU68rGunmLluA9FiJaeMylF3kuZyCuDOqvuYzWkLSxN2Cn06xzZoD8iEuwsNxSmkuNCp+VC1pW56xsLC4UQpHs1XjJJKvlQYlvrDZcK1jYOMbzyxoMyf7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341054; c=relaxed/simple;
	bh=Ga+qOkS7SIjz/ub6snCjlz+yMTYuLoApdIVfxTfpaAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bnGpSf4EGqAhpMGRQ0hhyFcoz8tO/jffQSJSRpY+OR7W5yXqe0Gm3Yl2CEJEcF8jN/XcK4512zy7PQccdkOTAT8+wu4M6jZ4xmTmKs7mfOt5dnextWjuVETKtH8e1LhfhOHHJb6sWf6s40g/bXsHBTgfIA0Ykhqr6QSnDi47eJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wpD7FE8Y; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=2P7UD8Fnfu8+8RYTF/YIlrkjqnC4Y7kmFuUDRyS3S4E=;
	b=wpD7FE8YoPzFhkqSLKHqEYZ887cUOqSw4+XyO+2zvynVcSFaPOPyHP+yy5ZXZwW8WuZHzaDlY
	BWNHuu6RNUYdKp4cuitcKzyjAkmlpOM/WyvsXAbdg2QXX+y69etjb2UxNOVnTO29RCHPOusckOE
	a7Abp8+cFA2pLMNZO+sfLFI=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4clTh01qkTzmV66;
	Mon, 13 Oct 2025 15:37:04 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F6EF1400F4;
	Mon, 13 Oct 2025 15:37:23 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 13 Oct
 2025 15:37:22 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <shuah@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>, <wangliang74@huawei.com>
Subject: [PATCH net repost] selftests: net: check jq command is supported
Date: Mon, 13 Oct 2025 16:00:39 +0800
Message-ID: <20251013080039.3035898-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

Fixes: dca12e9ab760 ("selftests: net: Add a VLAN bridge binding selftest")
Fixes: 6a414fd77f61 ("selftests: rtnetlink: Add an address proto test")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
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


