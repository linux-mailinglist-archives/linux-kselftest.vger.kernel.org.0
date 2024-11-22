Return-Path: <linux-kselftest+bounces-22437-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5209D5A38
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 08:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839F51F22369
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 07:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263EC16F0EB;
	Fri, 22 Nov 2024 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="XiZLD5I3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3256013AA38;
	Fri, 22 Nov 2024 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261740; cv=none; b=BmafTPVj8OAaiDaFbiFB8gsd3BO7s/P2ozuDFMPfwuaKpXefEVQQKEWSiH2fzIvtdfDiMB43xMLpBWx8wIcoLi2XWoa6Jt7AvRu/a8k4uQK+f2tzIsp1CeI/EW5iLI2mStPZzSfLN+OI7DTbnBdOOU7EVA50vAolVOfH0JM5bQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261740; c=relaxed/simple;
	bh=nqL1XvYbyKSZQqMj6JbKQ0PBzBfRzjNjVetM3FWvO5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OOKeL0DPxK/vcFurvCUNZ1FqmsEfM4iGpJJg8TmBEfqrVZjYu5ZEWfjQM33KToJ0s2Kkid+orOPikkigpXHTnnsjlqUsIcA4QX9QJBH28c6x/7r3DP8w0mQdTITMbxQZLvfnBDBgHiJaBK6AX9rlKTRDxPKXoXWRLlsvUT8fI64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=XiZLD5I3; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732261738; x=1763797738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nqL1XvYbyKSZQqMj6JbKQ0PBzBfRzjNjVetM3FWvO5g=;
  b=XiZLD5I3mVJOUozGyLd+2RpOo7/KlxUeO62suX9sdM2VUNbVEdX5+Dti
   OemHhODGeg4zXQsGLFQKxcP10SdQF0bq/t8aMyDTORoXoTJZxze8ilNTw
   1AI1qwtfd3Hb+wtu7RzAqnlkWZRMiXpNIUH4hdAaRAkhX6hCPSsRnQ9Wl
   DZxNUbF1rbW5FSDQfKSAOg9axGkhx9V6K5KwZwIifS0MA0zq3tAOyUtKG
   eYqAzCeQBlbLaqgRs1tpC93aybTqFsJTsDRPTSmwHAbWWHyFli4qYVvkl
   f1GYn5dEkjdVdroHZRMCxzhAR6k+UTqYzEDXAI53wIV+RBrdLEpHDVhFX
   g==;
X-CSE-ConnectionGUID: 9hz+0CwyTB23BXKE8gtvMQ==
X-CSE-MsgGUID: zwtXkKwHTqCAnZXgZx+ACQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="181315553"
X-IronPort-AV: E=Sophos;i="6.12,175,1728918000"; 
   d="scan'208";a="181315553"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 16:48:55 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E30CD4807;
	Fri, 22 Nov 2024 16:48:53 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0C042D6035;
	Fri, 22 Nov 2024 16:48:53 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 9D4082007C3F7;
	Fri, 22 Nov 2024 16:48:52 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 251A61A000B;
	Fri, 22 Nov 2024 15:48:52 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next v3] selftests/zram: gitignore output file
Date: Fri, 22 Nov 2024 15:49:35 +0800
Message-ID: <20241122074935.1583747-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28812.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28812.003
X-TMASE-Result: 10--13.042600-10.000000
X-TMASE-MatchedRID: nUGu75wN8kWAIpLP/qXbGbnHu4BcYSmtegIHHX2L4YyjEIt+uIPPOBka
	AZoftHktcMrdJyab/PE7316J37LffS8oE1Ngob6lrMZ+BqQt2NrJ5SXtoJPLyFcZNuxCoduSsaY
	IF6sQsQ7+4K0BSFVcYVFLvGMRv53EHFja9OI/1x1O5y1KmK5bJSkDYTG6KmZaR/IzlV+CMbbT0P
	pHDbMis75zVhb/Nij2V5Y/cGuAJ/uR9GF2J2xqMxRFJJyf5BJemMMxPRPIOTn6C0ePs7A07RjOl
	t1Pi553XL7I519CZrUnlZ51V8SfPOQmlR1Z/9ig4repHbz7QeU=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

After `make run_tests`, the git status complains:
Untracked files:
    (use "git add <file>..." to include in what will be committed)
        zram/err.log

This file will be cleaned up when execute 'make clean'

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Hello,
Cover letter is here.

This patch set aims to make 'git status' clear after 'make' and 'make
run_tests' for kselftests.
---
V3:
  Add Copyright description
V2:
   split as a separate patch from a small one [0]
   [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tools/testing/selftests/zram/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/zram/.gitignore

diff --git a/tools/testing/selftests/zram/.gitignore b/tools/testing/selftests/zram/.gitignore
new file mode 100644
index 000000000000..088cd9bad87a
--- /dev/null
+++ b/tools/testing/selftests/zram/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+err.log
-- 
2.44.0


