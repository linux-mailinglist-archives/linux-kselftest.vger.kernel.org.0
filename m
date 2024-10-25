Return-Path: <linux-kselftest+bounces-20596-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546279AF6FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 03:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38D21F22CF7
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 01:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E63515383F;
	Fri, 25 Oct 2024 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="s8SS9Yrc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6788522B644;
	Fri, 25 Oct 2024 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820389; cv=none; b=mg4dhnZai3mTretoPx/8gAfQMxIIw/z+tdpUK4WU0lMV9JoaSKpo0y4MvW/sG8BIrqQopjB43VdodnWw5QbCBqXizQujl0Cmt5OzKDLQgEDSXzhT5/8Ja2XK0kgQ1RUtLZ+UxzeND5kaa6bZLZUxEW6RqqpxOu6tDXHCpQYO06s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820389; c=relaxed/simple;
	bh=jyqhRjmJYUC4dlrzZbnwcaBJiIpqnBNzCBrurqjVkFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXKHWtmMCZt/j987HBOPuFz1a/BZfVNXOUY6Km8RYAJlB88jciVcjA2iM9E8mdVuHA242RL/BqF4mvkqClOqx+h5j/jXMuolohNWteGLVJRjJRCvCorAtszYI+jluA4iSxluCSkWMxQwnlPCbepTUi1wHN60ct3tuqMhXhvL0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=s8SS9Yrc; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729820388; x=1761356388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jyqhRjmJYUC4dlrzZbnwcaBJiIpqnBNzCBrurqjVkFw=;
  b=s8SS9YrcQ7wO3LOju2FMNXbjWCQefS7/d9eakavYcVH7y5CQrowRoIT3
   qNRkdF1w5mTlRF2Bbr194a4OLinCmABgQ0Gtt2Q4WZ6Jo+zbqdVjgUGl1
   Am3HS9XXsG/UhfXk74WLX2muimYSMQ+PKwIN7O2DOlDC1ftY0jMlF7144
   TyXdqtzax3ij9o2OuC5sIDToo952pl26EFUlxjR0YSrbVQMf1WHtpV/us
   65xfCQ8Vkh0Xs6KUYahLZ510Vmppez1g0pzbgOO1B2V5JvW7ffjzWGQe5
   QSb/RdiA5DmUklXBFxB7VLpDoXED8edhRwWR+ESYIPUHs5fNnL6iML/RH
   g==;
X-CSE-ConnectionGUID: CA8vzYT3SVySnH5uzc4ZIw==
X-CSE-MsgGUID: FsSvR9yvSVapvhdFuTKYdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="180136537"
X-IronPort-AV: E=Sophos;i="6.11,230,1725289200"; 
   d="scan'208";a="180136537"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:39:39 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 234DADB3C7;
	Fri, 25 Oct 2024 10:39:37 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6A507D968B;
	Fri, 25 Oct 2024 10:39:36 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id EF3CF70BC6;
	Fri, 25 Oct 2024 10:39:35 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 462531A01E9;
	Fri, 25 Oct 2024 09:39:35 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH for-next 7/7] selftests/net: Fix ./ns-XXXXXX not cleanup
Date: Fri, 25 Oct 2024 09:40:10 +0800
Message-ID: <20241025014010.6533-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241025014010.6533-1-lizhijian@fujitsu.com>
References: <20241025014010.6533-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28752.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28752.003
X-TMASE-Result: 10--1.620900-10.000000
X-TMASE-MatchedRID: 6n1zk+md1nW+AcfZRlRvHuOnF2j8nBWbn5nfR7I2dFNlmPP/XnGELrmK
	lv3K7lvCloSrM+MzMAEa/Rm8RmNZp6s4CIwqUsM8rMZ+BqQt2NrJ5SXtoJPLyFcZNuxCoduSsaY
	IF6sQsQ7Nbuq5jiJ+bEqGW42c0HkYPCIyO+XnL284hD0Y/Y/a78E5XPQnBzGXq8KsbROd9VSD3F
	7iC1Qm2idrKX/gwnicYx6ZNoOmH25g/HvJ1232Mp4CIKY/Hg3AaZGo0EeYG95UMLUJu4leYyq2r
	l3dzGQ1tyaKchQkyE45QtN9xzZW3ugJcSBd3qZSUzqf3+iknU+bV/bRlWl7V3ed4oqRsBtzx8E/
	iqf5nIPM85RmE6LnSrhZsTzrx0WohLvAid2uj0YVxRB/din+uJ07T8ZSLiAVvR84/OmB1wQp4n8
	eQBnwiw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

```
readonly STATS="$(mktemp -p /tmp ns-XXXXXX)"
readonly BASE=`basename $STATS`
```
It could be a mistake to write to $BASE rather than $STATS, where $STATS
is used to save the NSTAT_HISTORY and it will be cleaned up before exit.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Cc: netdev@vger.kernel.org

---
Hello,
Cover letter is here.

This patch set aims to make 'git status' clear after 'make' and 'make
run_tests' for kselftests.
---
V2: nothing change
---
 tools/testing/selftests/net/veth.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 4f1edbafb946..457312ef135a 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -46,8 +46,8 @@ create_ns() {
 		ip -n $BASE$ns addr add dev veth$ns $BM_NET_V4$ns/24
 		ip -n $BASE$ns addr add dev veth$ns $BM_NET_V6$ns/64 nodad
 	done
-	echo "#kernel" > $BASE
-	chmod go-rw $BASE
+	echo "#kernel" > $STATS
+	chmod go-rw $STATS
 }
 
 __chk_flag() {
-- 
2.44.0


