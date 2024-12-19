Return-Path: <linux-kselftest+bounces-23580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DEE9F77CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 09:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C0916ADD3
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1E3221440;
	Thu, 19 Dec 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Vz4U0lMG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980AC147;
	Thu, 19 Dec 2024 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734598662; cv=none; b=uICyr4u49r9YTqXNdcZNM2UAtN65FJuMKoEIrN2Hf7w2WG3afI+dpAfJIFheRiiZ5GaNPS0BYEV7aoN1unMo/GvF+tyMDI11SnxNk/WQTPZCO1znUjT3+8gdYr5vm8ukyxQZDRGDRwLUQqsNcYXPzMM60Dp1cTi203mJCokn8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734598662; c=relaxed/simple;
	bh=HN5aUie6KS/sLX+7BhH8yVUFBGEX+sBFKApAn4ymeNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATRZJaxl7hxru8dIsMOKO9q2N3rJqoJX7nq6OfFSMbiOvtYAbamy9arcqJ7TuNbCWzFgDdrkEH1C4IhZpdUsbw5uT3Rixj6v5jimid6N2vadxhjHx1Egkv29l571ViaEnWg/zg37pCYF0jdXOC0rmd+mvtXq7BNuA6pWqyqEGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Vz4U0lMG; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734598661; x=1766134661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HN5aUie6KS/sLX+7BhH8yVUFBGEX+sBFKApAn4ymeNQ=;
  b=Vz4U0lMGAkcooq4swQZJLDnjx+GF7UQYUmK4XOmB0FOMSAK4DUb1Eeti
   I4nAft/RMX/IGKwCnJ5yemqOxu/NTneAD2pViuPe+c/QFx0bYHedkdCXf
   WFIEuJA9XwGZPoR+/o0xkS1+WQEpfFwB9/q9ceMWOScrCeLOG6+UwCO/l
   P4Z7aYzurC28fiIOLQbBOwGVB/wqrt+El7rjy5CLkVVcR/YDs9viWapj4
   Mv7pPiwdqXpc2MmhW3ifiLNOJ4+87XBHcX/tEdaK3/IeDtGPYelJv98lm
   U3TKu8kBi4qSip1kt3ntAXYnhu+pPMcLY3RZ2ZhOjjJWL06IeHkmYiOje
   Q==;
X-CSE-ConnectionGUID: QHvrLQQXTB+uc5605Eq1xg==
X-CSE-MsgGUID: qx0cApdUQOubcu5GuGxP/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="163224235"
X-IronPort-AV: E=Sophos;i="6.12,247,1728918000"; 
   d="scan'208";a="163224235"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 17:57:32 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id DB682D6EA7;
	Thu, 19 Dec 2024 17:57:29 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A790FD5044;
	Thu, 19 Dec 2024 17:57:29 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 27082223040;
	Thu, 19 Dec 2024 17:57:29 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6D6171A006C;
	Thu, 19 Dec 2024 16:57:28 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next 2/2] selftests/Makefile: add INSTALL_DEP_TARGETS to run_tests
Date: Thu, 19 Dec 2024 16:58:03 +0800
Message-ID: <20241219085803.1145606-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241219085803.1145606-1-lizhijian@fujitsu.com>
References: <20241219085803.1145606-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28868.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28868.006
X-TMASE-Result: 10--0.021700-10.000000
X-TMASE-MatchedRID: 54gb2yeIOXS0+ZONdwr5Uzyjd/AizytBa9qiaDSLgo2Y5nVpihxiww4f
	VAbTdT+ITyMAPRCpByAI9FbMZs+aDuo7bV31UxoOoHDoEp2TszEXivwflisSrFQuGn5b9r2ZRfB
	9456KWmoi+t+0AiFaYvL3NxFKQpq1yV682/wvVhyeAiCmPx4NwGmRqNBHmBveVDC1CbuJXmMqtq
	5d3cxkNUgFmQHHop1mKurGNJsxTad8FhQcyncbVWFDorg1GpunZE381kduDD4mhuNrohXY3nO31
	pzixVHLEXMQHQWTna7o5K4b13wWjgPMScShcwsoFcUQf3Yp/ridO0/GUi4gFb0fOPzpgdcEKeJ/
	HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Similar to the installation process, run_tests out-of-tree requires
copying TEST_FILES and TEST_INCLUDES to the OUTPUT directory.

The `net/lib` directory is a special case because it is a dependency for
`net`. Therefore, it should be processed before `net`.

This patch fixes the following error:
 $ make O=$build/ TARGETS=net kselftest V=1
  # selftests: net: rtnetlink.sh
  # lib.sh: line 5: $O/kselftest/net/lib/sh/defer.sh: No such file or directory
  # FAIL: cannot add dummy interface
  not ok 20 selftests: net: rtnetlink.sh # exit=1
  # timeout set to 3600
  # selftests: net: xfrm_policy.sh
  # lib.sh: line 5: $O/kselftest/net/lib/sh/defer.sh: No such file or directory

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tools/testing/selftests/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index fcaebd122d64..326dfd6ec497 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -206,8 +206,9 @@ all:
 	done; exit $$ret;
 
 run_tests: all
-	@for TARGET in $(TARGETS); do \
+	@for TARGET in $(INSTALL_DEP_TARGETS) $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
+		mkdir -p $$BUILD_TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests \
 				SRC_PATH=$(shell readlink -e $$(pwd)) \
 				OBJ_PATH=$(BUILD)                   \
-- 
2.44.0


