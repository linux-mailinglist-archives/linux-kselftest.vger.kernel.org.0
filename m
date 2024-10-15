Return-Path: <linux-kselftest+bounces-19694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B4099DB1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 03:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4542281960
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 01:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B909513C908;
	Tue, 15 Oct 2024 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="pb1PAwVh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992683BBF6;
	Tue, 15 Oct 2024 01:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954531; cv=none; b=CDc9AXy7loiRexIKg1VDzfzBy3wfh4ARpxYPUEUCWoXi5w99I4IqaVlogQRIWk0k6WzbvisislFOHzia0vnyvrA2+xMNlpddixfIYjJvQrEd3srN93Id7+Y1e3amgCKqdQSvnIBYKOysyt8hZ+RfNQP3llahQHdFdv0c3Cy4O2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954531; c=relaxed/simple;
	bh=FZrqo3amabV9wiV7VHQPPHBMbvLaTfowB+bVsRenlRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X5TpQdDst4c/5OW7JNU7F6qxRMuQaBwVSQgbar5sNrDbd6KTomSOLNrL/c2ulM7x2SCwEmNsrZUfhOD6A78H1eHZtOLHluGMas8hoyNMl+vSfI1vtR2pKvTv4TlE5eBCcZZSSUQgne/H6elQ2oiK0NTibhY7w7CzVHXhkJCjwTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=pb1PAwVh; arc=none smtp.client-ip=68.232.139.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1728954530; x=1760490530;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FZrqo3amabV9wiV7VHQPPHBMbvLaTfowB+bVsRenlRs=;
  b=pb1PAwVhmoEHjVtlEU2LDjz8SoeMCOmD4HK52I8tWK580dgdwhTOAYcL
   vvun1thC03IrmwDPsT2bZnzbFuCkByD4KBnAc0Hg/Q8OUEKRwvx+rQcrh
   L5ov+TFCj+vskdSJO62pybW5094+kWBfoWzrKF4zL1YRKLZzcVvaE5f5t
   QkvTKmeRQYYMcuTv6sjMigsVvOdZIu8uuXlouf/XPaM4wxxjbI4FBxqyY
   FJrax2K/RuGyVdE1mO/SLkHmV1NHlL2hDJyX/ZXuBNmXUfmP7ApdahqUE
   NhfJ10FxKiAuv/EbHs/vgsl75xeafURYlFPKIK+iRCNS4nDDKG7orc9Je
   w==;
X-CSE-ConnectionGUID: sIWWA0cpTdKCnpF9w46wkQ==
X-CSE-MsgGUID: DLPSySMXTKS5wPwE8/i7ug==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="176929692"
X-IronPort-AV: E=Sophos;i="6.11,204,1725289200"; 
   d="scan'208";a="176929692"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 10:07:37 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com [192.168.83.64])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id C2EB9E8529;
	Tue, 15 Oct 2024 10:07:35 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id F3EA5CF7E5;
	Tue, 15 Oct 2024 10:07:34 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8CD5D20071A00;
	Tue, 15 Oct 2024 10:07:34 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id DC0051A000B;
	Tue, 15 Oct 2024 09:07:33 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/3] selftests: Add a few missing gitignore files
Date: Tue, 15 Oct 2024 09:08:15 +0800
Message-ID: <20241015010817.453539-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28732.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28732.003
X-TMASE-Result: 10--5.187600-10.000000
X-TMASE-MatchedRID: JUGAxiLh1cMhiKpapiFQUqoXHZz/dXlxTJDl9FKHbrnBsf5qt44jZ0/m
	RGqrA8qmz5HYWCESGTAoP627gD3TuuBRuAss+FbmEXjPIvKd74DzWEMQjooUzUhnD/tEhIxQQDz
	RyendZRu3ltet8sMG9oAy6p60ZV62Mhe627A+8aHdB/CxWTRRu25FeHtsUoHuQSdiBi2c5Imk2k
	7Is0dul3K67d60oFMtLDbJbukAoaRoBmTSwRxjXg==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Binary files should be added to .gitignore

'git status' complains:
Untracked files:
(use "git add <file>..." to include in what will be committed)
     alsa/global-timer
     alsa/utimer-test
     filesystems/statmount/statmount_test_ns
     mm/hugetlb_dio
     mm/pkey_sighandler_tests_32
     mm/pkey_sighandler_tests_64
     net/netfilter/conntrack_reverse_clash

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 tools/testing/selftests/alsa/.gitignore                  | 2 ++
 tools/testing/selftests/filesystems/statmount/.gitignore | 1 +
 tools/testing/selftests/mm/.gitignore                    | 2 ++
 tools/testing/selftests/net/netfilter/.gitignore         | 1 +
 4 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/alsa/.gitignore b/tools/testing/selftests/alsa/.gitignore
index 12dc3fcd3456..1407fd24a97b 100644
--- a/tools/testing/selftests/alsa/.gitignore
+++ b/tools/testing/selftests/alsa/.gitignore
@@ -1,3 +1,5 @@
 mixer-test
 pcm-test
 test-pcmtest-driver
+global-timer
+utimer-test
diff --git a/tools/testing/selftests/filesystems/statmount/.gitignore b/tools/testing/selftests/filesystems/statmount/.gitignore
index 82a4846cbc4b..66a21f289453 100644
--- a/tools/testing/selftests/filesystems/statmount/.gitignore
+++ b/tools/testing/selftests/filesystems/statmount/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /*_test
+statmount_test_ns
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
diff --git a/tools/testing/selftests/net/netfilter/.gitignore b/tools/testing/selftests/net/netfilter/.gitignore
index 0a64d6d0e29a..eef8d5784e94 100644
--- a/tools/testing/selftests/net/netfilter/.gitignore
+++ b/tools/testing/selftests/net/netfilter/.gitignore
@@ -4,3 +4,4 @@ connect_close
 conntrack_dump_flush
 sctp_collision
 nf_queue
+conntrack_reverse_clash
-- 
2.44.0


