Return-Path: <linux-kselftest+bounces-22435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706059D5A31
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 08:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF611F22476
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A159F166315;
	Fri, 22 Nov 2024 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fnnwZchU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DEA1531C8;
	Fri, 22 Nov 2024 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261607; cv=none; b=W50SO/HXYSzP2F42mJgA15ntbHztZK4FskkO4X6j2wrmES7HUsRP4SSiyAUOBpwcQPXyb8Y1ZaWf9phEzroIGMz/VzzSgMmvG6TvUXxkLRt6x0eTEzAkxfJXs8dDJW/Qc4X3UCQU8d1Exr8GU2YRHdAU7tZqkHb8Vxe2yoY+1+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261607; c=relaxed/simple;
	bh=2yClGXvJ9tZ66fmOJ9mXLhirKKRN07WvKtBEi4fP3GI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=td2+6F2hkIwpA2z8MknVSTlgbSGttvIw3ssxqnt+AMiviZxAe4EGxFQw9Tq+OXA/SXTU2XAHgSUC4I/HxtvFpXWCP+yOI4z/hF2UaewQRgfEyKrgjGo0RiHbMQ0FKJl3rL4+I5cYiw8y0o/xXfc58U/De75ZicboWT5gf4VzjE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fnnwZchU; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732261606; x=1763797606;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2yClGXvJ9tZ66fmOJ9mXLhirKKRN07WvKtBEi4fP3GI=;
  b=fnnwZchU+m9UxXO+bXBYNy23REtB9ki7STGC58+54aI0h7L2orEA866a
   XWGFu7Oz3VJ5OG8NACPa+7l5DbXQTIHVK2EXIwKaXxt6RaBYybuqU2VsB
   tfD1qYVwHI4zfxCKAfFJrLvlyzXeKT8Otm9DJlL2PqPAMzIQ5C8vnNp5L
   I2IajHM72M5yRTEndXRz3wr+SXY8awnxCfV3nPJkw0VOWqcl8E03bm9Nw
   kQmSn1kz55WQY9MxJt4s/DZ7/YsZK6W5MkUoYuNHwCJOuK66lgpLVjWGg
   uYVY7k6O4Vn6MyscT0Bqb9CJyGipvmMBja2VeAFEVfLvUlnncWZz0MfV9
   A==;
X-CSE-ConnectionGUID: 7fNRptklTyaKdwwc8dpzow==
X-CSE-MsgGUID: 0sKaQtF9TcywXJuowoCF4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="181346540"
X-IronPort-AV: E=Sophos;i="6.12,175,1728918000"; 
   d="scan'208";a="181346540"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 16:45:34 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id DE508D4C74;
	Fri, 22 Nov 2024 16:45:31 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7013FF6935;
	Fri, 22 Nov 2024 16:45:31 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E79FC2007C3F3;
	Fri, 22 Nov 2024 16:45:30 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B77E51A000B;
	Fri, 22 Nov 2024 15:45:28 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Subject: [PATCH for-next v3] selftests/mm: Add a few missing gitignore files
Date: Fri, 22 Nov 2024 15:46:12 +0800
Message-ID: <20241122074612.1582161-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--4.449200-10.000000
X-TMASE-MatchedRID: I6rpFm0lrcMhiKpapiFQUqoXHZz/dXlxTJDl9FKHbrk/gf7afIrQU36y
	x7OFE28QV89FgO/U4vBeAZpJlX3ct6Mqw1MrQ3Xs0e7jfBjhB8eBs03RHrzjMynNUH+OhiT8Ia7
	NUssol05aJeWpsk0Y3hFBD6+ejtliL/tBTZzO5Q2qh5pv1eDPz685fLDYlgpSmyiLZetSf8nyb6
	HMFK1qe11j5mhaIsibJ0RPnyOnrZJM/gWxOhfhjk+ZCSAmGiXG/he9Yb8sCsToIDZ/Lg2Lo2tT4
	6nKrJH8mm+cAHmyOmAOlZGAOJkVuCjz+AKRf1mYkluEB//hNMbAYLx7rnbR8rDQ8m3TqgloelpC
	XnG+JjvDGBZ1G8r1Sf2D6gx/0ozp
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Compiled binary files should be added to .gitignore
'git status' complains:
   Untracked files:
   (use "git add <file>..." to include in what will be committed)
         mm/hugetlb_dio
         mm/pkey_sighandler_tests_32
         mm/pkey_sighandler_tests_64

Cc: Donet Tom <donettom@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Cc: linux-mm@kvack.org
---
Hello,
Cover letter is here.

This patch set aims to make 'git status' clear after 'make' and 'make
run_tests' for kselftests.
---
V3:
   nothing change, just resend it
   (This .gitignore have not sorted, so I appended new files to the end)
V2:
  split as seperate patch from a small one [0]
  [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
---
 tools/testing/selftests/mm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index da030b43e43b..2ac11b7fcb26 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -51,3 +51,5 @@ hugetlb_madv_vs_map
 mseal_test
 seal_elf
 droppable
+hugetlb_dio
+pkey_sighandler_tests*
-- 
2.44.0


