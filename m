Return-Path: <linux-kselftest+bounces-23127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A85B9EC10E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 01:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6C4188A5D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 00:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA63D984;
	Wed, 11 Dec 2024 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="AcfAA+MW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DAB70803;
	Wed, 11 Dec 2024 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733878024; cv=none; b=quSubgNqf1/OKFJu01T1t9gjPHmCCcI+sabGXnLh1kbwEiX30hlgsUdx96D65q0FZRHTUICPE233Jp9+i8okd8ovtA79719zxh6Jmw5ZCTYdTqOLyCG3R5pkLoU+MAkm7DXuABke/8g3G27CcKEMhnmx5ny30Zl7cfw8ViiTlcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733878024; c=relaxed/simple;
	bh=q6X2kMRHBE6WwDLDJhj6QszSmONNL1SPo5EUKxyj+gY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PzCZri25RPOtJnoc0QWB6ebXnCpW4BHD0greF7iT/hgFrDCgKMz6kkqzp8WSw4HtCjv8nzb1tlYxjD7XQGcz7hzUvYKX++DNLw496o0fiRjzaIcNKcDZ0vqq6sASkmfYSeB25jaPpFg6QtT7hF1+rh9BTviwewznM7U4FPJNXOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=AcfAA+MW; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1733878023; x=1765414023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=q6X2kMRHBE6WwDLDJhj6QszSmONNL1SPo5EUKxyj+gY=;
  b=AcfAA+MWTtR66bSFLknUl7o6zrkZxGKI76m9G55kgMnxetbkn4/SO9KE
   PZ3IUMog/5FBxQJxClgFlJ85YLvf5VrhKJ2GT9STXu1LQSY+X7Kw/ZSnv
   1wOHn1Dgr+F1DQ09UyFJsec2uPgiyG8LOKNbrqMBKp+PzHHWRF3Q2pxIx
   qtYAnPvPJDS77F5OHp3Ofwi+nCm3/Dya8uWDNCqGdJkMYRG1kVmLIiDYT
   E1pBdd94R8Hy+STQ6zpegnZh7lUvIlWPT80C3EY8HeFypRxSmDp1kAeT9
   MGAoO0O7780jQVDZNjJDVT5EkODRy1qZZs4ltKL6+3wSBiKjEqRCKuLur
   Q==;
X-CSE-ConnectionGUID: 51TY1MJLQh2qnAI+2Ta6eg==
X-CSE-MsgGUID: /nHwJF7fQ1Kn4L4N9mIH6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="182472789"
X-IronPort-AV: E=Sophos;i="6.12,224,1728918000"; 
   d="scan'208";a="182472789"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:45:50 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2371AD4C42;
	Wed, 11 Dec 2024 09:45:48 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id F106DD7283;
	Wed, 11 Dec 2024 09:45:47 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7AD7620076D0F;
	Wed, 11 Dec 2024 09:45:47 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id CA2891A000B;
	Wed, 11 Dec 2024 08:45:46 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v4] selftests/zram: gitignore output file
Date: Wed, 11 Dec 2024 08:46:25 +0800
Message-ID: <20241211004625.5308-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28852.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28852.000
X-TMASE-Result: 10--12.315400-10.000000
X-TMASE-MatchedRID: 49D3s4su4CaAIpLP/qXbGbnHu4BcYSmtegIHHX2L4YyjEIt+uIPPOBka
	AZoftHktcMrdJyab/PE7316J37LffS8oE1Ngob6lrMZ+BqQt2NrJ5SXtoJPLyFcZNuxCoduSsaY
	IF6sQsQ50RL7pOTKrHkwECQaT0DBZXSJ4c3nT+QfNgrlT5Ajc7sE5XPQnBzGXWAuSz3ewb20HV6
	CRl0Ild2xeoKLN1RJD6L2S69zMjXkoDz0/aX3Nnp4CIKY/Hg3AaZGo0EeYG95p9JuvPBKN/Cq2r
	l3dzGQ1PefUoUh8dMOuvBmzg2L+ap8ACOxIAKTb3sjTEKSi09whbpx7Sgcyeg==
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
V4:
   Remove duplicate Signed-off-by # Shuah

V3:
  Add Copyright description
V2:
   split as a separate patch from a small one [0]
   [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
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


