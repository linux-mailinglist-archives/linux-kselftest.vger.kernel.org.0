Return-Path: <linux-kselftest+bounces-20599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630BD9AF706
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 03:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 177BF1F223C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 01:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC3132111;
	Fri, 25 Oct 2024 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="oHm6D8Fj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2C43B1AF;
	Fri, 25 Oct 2024 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820451; cv=none; b=jipk/07a5kBtt/IicsEPLd1fGLrWrL86cUD1XbuT+h0Px+Knjt/SOKwVw+08BDZl1o6BJ9ut7OQpgpPkvXRVKe6md2zflobUcwYWcs6n2uEw3w6iLrnYUf0/nDfBsE2075hVqMlQeSln+UVX62cI8f0VbSqrEweHtnb0rb+LrAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820451; c=relaxed/simple;
	bh=PZRLE0CoeSHDSPSCnkQBuUhJ+O7OzxyWkDuUvPghXq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgBxfv0tmlLecMy/m/WvKVpkpyelnIH/qb7ofDd1lE7kyYPY05GfpkgDOFZR09SfadKMYcrT9I3GQrKiNSpz83+gprouYWuGtpfwrnTeux8g5N+Foz3oDKELyIY3gGqxHHAmQKp/ExA7w2PmVdMhAgyhu2xW0fa4WZtoarjfaOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=oHm6D8Fj; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1729820448; x=1761356448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PZRLE0CoeSHDSPSCnkQBuUhJ+O7OzxyWkDuUvPghXq8=;
  b=oHm6D8FjpMGQeXMZkQez9JMma4sX1ohX6yyngm4U4yGMHbyXzPRDsz6g
   VvRA80a6FVzQRTJu30NtGKONezeYEDHAddmEgTVinE3MbBtTzhsXWni1f
   7cy8bmdMe0656lS+vpi2hj3HdfBq0Pn0by2MkFZDBNzJa+vgJgUBDAj31
   cTGCqSX7YvC82lFojaTJuf6uxfu5s5/7FMh5G+VVvhrSLQD3ej5dWZ6D6
   Pf7IGvaD0Hp0tpR4JP7GYZM+/Bj7XZ5GPXqK1Lq7fQcFC46I9ZQZFgmoP
   rCltRkuvzhu4GAcLIT97beE6viz5UORpGSfHLEZ1MQA+Pq8QVoTvWZ3WO
   g==;
X-CSE-ConnectionGUID: 2Ta78dKiSdejsa16rNbJKQ==
X-CSE-MsgGUID: wpb4hFSNQS6pxYfj+Cdw9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="156895123"
X-IronPort-AV: E=Sophos;i="6.11,230,1725289200"; 
   d="scan'208";a="156895123"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:39:36 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0ED43C68E8;
	Fri, 25 Oct 2024 10:39:34 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 45420D9698;
	Fri, 25 Oct 2024 10:39:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id CCBA520074739;
	Fri, 25 Oct 2024 10:39:32 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 165051A000B;
	Fri, 25 Oct 2024 09:39:32 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH for-next 2/7] selftests/filesystems: Add missing gitignore file
Date: Fri, 25 Oct 2024 09:40:05 +0800
Message-ID: <20241025014010.6533-2-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--3.043400-10.000000
X-TMASE-MatchedRID: 54gb2yeIOXQhiKpapiFQUqoXHZz/dXlxTJDl9FKHbrmwcSh5kytY+TxT
	JjE+nPo2V89FgO/U4vBeAZpJlX3ct6Mqw1MrQ3Xs0e7jfBjhB8eBs03RHrzjM2oFlnxJu2+hOki
	GGidO7I8i+t+0AiFaYs/zm2Wt1N8TKA89P2l9zZ6eAiCmPx4NwGmRqNBHmBveVDC1CbuJXmMqtq
	5d3cxkNUgFmQHHop1mCWokdF19v0aPzY9yzt4nZgneKWq5F1UNjDWgTMpkjyH4S4HSmR7YRpIlC
	cLOXWJROR5NILrUG2YBO6L2F7Ory4xrU96OxkmsFcUQf3Yp/ridO0/GUi4gFb0fOPzpgdcEKeJ/
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
V2:
   split as a separate patch from a small one [0]
   [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
---
 tools/testing/selftests/filesystems/statmount/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filesystems/statmount/.gitignore b/tools/testing/selftests/filesystems/statmount/.gitignore
index 82a4846cbc4b..66a21f289453 100644
--- a/tools/testing/selftests/filesystems/statmount/.gitignore
+++ b/tools/testing/selftests/filesystems/statmount/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /*_test
+statmount_test_ns
-- 
2.44.0


