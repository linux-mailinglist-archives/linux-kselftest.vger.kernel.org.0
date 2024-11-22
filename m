Return-Path: <linux-kselftest+bounces-22433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150119D5A15
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 08:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC2C281E82
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 07:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4338C170854;
	Fri, 22 Nov 2024 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="XB+CUaik"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A90C170A00;
	Fri, 22 Nov 2024 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261006; cv=none; b=g0RWylmjg9YwbEK5Wb2cy4qtXd71rgceDQ6jBFMdE53g11+DcW/LfHFC+6X16cpGGW9Vm+wb7eFo3Cow0TSLsh9lC5bCRTJwIoQeBBSa4jfUyvmqkxG6Ra9AdG0+iXsqq+b45nLez3oPCKhMkf0SoBZ7jQR/wo6o5vHT+5UD2CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261006; c=relaxed/simple;
	bh=CgUx0IlOGrF/yLFV9BJb7HxBI9VBRO+yLhrTxkWGMMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WLan7yjynIcwL2CDzDVCJZeH1pu+sq+vRA/FKQx+MzwxK0WQdmCyV3OKENnUIw+MpYY8v/d3iRcvIgjQAAmWhM5xav32tboBZhUr9LpRw8HsznLu4ShiwcdMJg5RVa1mPLL5eyHdaoIuYPVlUX/VI06TLhGizhQoJwT/2bLiFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=XB+CUaik; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732261004; x=1763797004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CgUx0IlOGrF/yLFV9BJb7HxBI9VBRO+yLhrTxkWGMMw=;
  b=XB+CUaikg2dqWGkCxXH8ROFkYyfApcwV1BM4gVi3TJW6GSL2PjDtHup+
   qlruYkyM+JfVjE51S7N6tv2BdW5I4+QAZMxhjkDjnMdTTUzrd7SgXLJKT
   Mfd682GmEYa64HkeJrtrP5u3e/fLZQGsGLaDcmXbKDt+jUJoaumSVXOzA
   6hqMh8VjWuGGizY0OUi7OrIwws+D+nYlwpIhn2gXQAWelIEGPo3JqzywF
   QmpsmdyPSBeQfip2AvOC3M/cpNiO272F39KxnbhYTb1UY6uoVmLNkas6+
   BB1HmCqxz2IrJEFBuJ2Ki8WtQWRDlsWlG9QY3Gy+jrKnflu2PxmARkIat
   A==;
X-CSE-ConnectionGUID: oGzjwGLkQVePIF+gFQl3Eg==
X-CSE-MsgGUID: qosyJ1m1SRGufkrVzoYS6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="160267502"
X-IronPort-AV: E=Sophos;i="6.12,175,1728918000"; 
   d="scan'208";a="160267502"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 16:36:41 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6DED8D4808;
	Fri, 22 Nov 2024 16:36:39 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 00755C19B3;
	Fri, 22 Nov 2024 16:36:39 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8B355E2070;
	Fri, 22 Nov 2024 16:36:38 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C12A11A006C;
	Fri, 22 Nov 2024 15:36:37 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH for-next v3] selftests/filesystems: Add missing gitignore file
Date: Fri, 22 Nov 2024 15:37:25 +0800
Message-ID: <20241122073725.1531483-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28812.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28812.004
X-TMASE-Result: 10--3.043400-10.000000
X-TMASE-MatchedRID: 54gb2yeIOXQhiKpapiFQUqoXHZz/dXlxTJDl9FKHbrmwcSh5kytY+TxT
	JjE+nPo2V89FgO/U4vBeAZpJlX3ct6Mqw1MrQ3Xs0e7jfBjhB8eBs03RHrzjM2oFlnxJu2+hOki
	GGidO7I8i+t+0AiFaYs/zm2Wt1N8TKA89P2l9zZ6eAiCmPx4NwGmRqNBHmBveVDC1CbuJXmMqtq
	5d3cxkNV6l++H8AVY9CZ85G8TivabAYDXpDgYC7C5BuXeFwSNKRf+ACC6LFtRCeKLNLAFgi0SFq
	9xTvKXggn6P4mGbxT/rFBvKT5XxbAibYH2E0kJqFcUQf3Yp/ridO0/GUi4gFb0fOPzpgdcEKeJ/
	HkAZ8Is=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Compiled binary files should be added to .gitignore

'git status' complains:
Untracked files:
(use "git add <file>..." to include in what will be committed)
     filesystems/statmount/statmount_test_ns

Cc: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
Hello,
Cover letter is here.

This patch set aims to make 'git status' clear after 'make' and 'make
run_tests' for kselftests.
---
V3:
  sorted the ignored files
V2:
   split as a separate patch from a small one [0]
   [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tools/testing/selftests/filesystems/statmount/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/statmount/.gitignore b/tools/testing/selftests/filesystems/statmount/.gitignore
index 82a4846cbc4b..973363ad66a2 100644
--- a/tools/testing/selftests/filesystems/statmount/.gitignore
+++ b/tools/testing/selftests/filesystems/statmount/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
+statmount_test_ns
 /*_test
-- 
2.44.0


