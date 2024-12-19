Return-Path: <linux-kselftest+bounces-23581-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA319F77D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 09:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 542DF7A3FCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2024 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65575221447;
	Thu, 19 Dec 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="M6ycW5y2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5C219A80;
	Thu, 19 Dec 2024 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734598724; cv=none; b=FUpcqdFkrDZc12zKyUTxtQHZu6V1q0Zg77rpPh47J5y43PL0FXpCwmtQUR0LvGmlO2KzkVCAYhlkpiJ1rXqlL2iLYNwXYFpc7hPxjrq9DPkx+6TpovOmki1zn19PsxF/e3ml5XHIcLitVQqOS1VFBzc8th+gnCoSCLFWIHMVi4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734598724; c=relaxed/simple;
	bh=zw4H02dlKrhAnEhZe+ox+sBa9eRKpbqW7Ma+PY94/8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwgJzFDbqtUp2gztIDUgQ4gJ8DmMmGoIISJ4WvJsB8aTSJntJpIanR3cvlzEN9e1jTPQ1tkWEwisuBzl9+6o01kjQ7lfBRTt2E3RP9OEkQDnxOcPI0htzt2zuh88FJ+qWRuaIU3sye4lZNlfU7c7NtELlAdhdDrGDW9q62UbCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=M6ycW5y2; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1734598722; x=1766134722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zw4H02dlKrhAnEhZe+ox+sBa9eRKpbqW7Ma+PY94/8o=;
  b=M6ycW5y2Yq3w8Uoo9O36p5qBviiVE7P6OMCE9cg63fh7svoojewLfs3c
   ri+bAqKR4I42Ub7MdIsacFIlZWevYH/smscKr2QkqeydnxZYCDS1N6oK4
   wUtAatQFDlTBap6KRabOcRA0/hYG/Dd9Cu8acXGMmMXHLBoE8241jGas+
   vQPkJlU9esM2q6vFNa+Uq9VO4EVkAfmIkxfmi8afAzvtlKBhHDTrnpcD6
   ZsvKZo3VoP9vWMQcji5JytgK1s1xHUHgoSTaOkNKmAZ8JYE6LQJ9x5hip
   l10wCsJh8LSfDZM0mX3BqhzMGqSHdNlzfwtnweSpOJsSLdlzK7XWAsSm9
   Q==;
X-CSE-ConnectionGUID: FpliFrx9SXuheDYB3Tcw7A==
X-CSE-MsgGUID: hQxBiJ3JRcGe8QpZ+4laPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="163187777"
X-IronPort-AV: E=Sophos;i="6.12,247,1728918000"; 
   d="scan'208";a="163187777"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 17:57:31 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 49EE2C2266;
	Thu, 19 Dec 2024 17:57:29 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 222CDD99A6;
	Thu, 19 Dec 2024 17:57:29 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 86F4D6AB43;
	Thu, 19 Dec 2024 17:57:28 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C49DE1A0071;
	Thu, 19 Dec 2024 16:57:27 +0800 (CST)
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
Subject: [PATCH for-next 1/2] selftests/Makefile: Create BUILD_TARGET directory for INSTALL_DEP_TARGETS
Date: Thu, 19 Dec 2024 16:58:02 +0800
Message-ID: <20241219085803.1145606-2-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--0.939700-10.000000
X-TMASE-MatchedRID: k00rMrYn+g5xonXTOXZ8CyrLqyE6Ur/j/eXcEqFSY3/fUZT83lbkEL8F
	Hrw7frlufNyclu9BH8qAMuqetGVetk6N1CbkSyKE3QfwsVk0UbvqwGfCk7KUs1WId3agGYvIXd2
	wXf8zD1j3yTxce2B/QL8BDGTmGcgA59p/hzepK/TVwuESWNw0zJLHieN0XKSWYm6Se+nk8m8Vfc
	fmpVfR7SHJp2UYVccqxOB8J0pRLhyJxKSZiwBX6QtRTXOqKmFVftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Similar to 'all' which will create BUILD_TARGET for TARGETS, we should
create BUILD_TARGET directory for INSTALL_DEP_TARGETS before generate
the binaries.

This helps to fix the following error for net target during
kselftest-install:
$ make O=$build/ kselftest-install TARGETS=net V=1
...
/usr/bin/ld: cannot open output file $O/kselftest/net/lib/csum: No such file or directory

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tools/testing/selftests/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 2401e973c359..fcaebd122d64 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -263,6 +263,7 @@ ifdef INSTALL_PATH
 	@ret=1;	\
 	for TARGET in $(TARGETS) $(INSTALL_DEP_TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
+		mkdir $$BUILD_TARGET -p;			\
 		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install \
 				INSTALL_PATH=$(INSTALL_PATH)/$$TARGET \
 				SRC_PATH=$(shell readlink -e $$(pwd)) \
-- 
2.44.0


