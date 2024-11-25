Return-Path: <linux-kselftest+bounces-22496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4739D7B9B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 07:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C66E1629DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Nov 2024 06:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B4155398;
	Mon, 25 Nov 2024 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kwXZUS22"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC32500DE;
	Mon, 25 Nov 2024 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732516864; cv=none; b=iqaldl7N6xjIdOnc4ehEE9fTqgVoiMRXrp8eX70OLeOr0XgbuzT40g74vrBKUuJaeneeNU9vPArViRmr7HwHl6sIw0AaJTneUiaQjYAAsr+md7cT+zqN8qP/81I6gZFr35zy8+kJPVeP2Oh/KjKMebNkU/XjTERtAlVNQ0tq7aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732516864; c=relaxed/simple;
	bh=R+Yrl/CXUyWG0r/M1xNa06uDoWkLDm2g2c0kpQJpGbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvoYPpviVhYQfVWL2qd4DV5Ni9n4eIfJzPezUKOeuqH+TqE1yNwBF/nAOxN8DBr4fRAFxcU0by9/jnOmBBg39kAxMCGfzvgyfYXcyseRgDQDApJ9hziSQhC0EhVM7S0GvPlk6FzhYjtBpt1Wll4X20mFxZq0edlaKzep+4w06zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kwXZUS22; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1732516862; x=1764052862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R+Yrl/CXUyWG0r/M1xNa06uDoWkLDm2g2c0kpQJpGbM=;
  b=kwXZUS224cLkj9iK+n8tUFzpwz4z9gAMDGzK9iypAlraeyIfa43+g7FJ
   FvcXtwNxttYGo5nUP2k33iNgnTgKPOf+KIa0DOwfnOZSvvcDJV7uoKg9I
   2jEKqSq/+IvdVupIM6s68zVhZCBtaukCISRo5SlnWBjtGlIvd/iY7efbq
   PKjQ6TG7reyWVglACFMMdB6DjHsl5thi6sBDksuMD3GG0zbT077wOTHGK
   8k2tx/WoVOlUizBLdwq03xNAOsZg2ZYOax9Lwunzm7PG5ooq55Y5eZw+4
   3m65gf1aZfPpDPihpD/KsA09sGQRX2knX579DWMp0gtiu+8UUwCCqnUWd
   g==;
X-CSE-ConnectionGUID: 62zT3ZINSAO/ng8aQdkjsg==
X-CSE-MsgGUID: +sdIroXhQ/OGlMX/+iOz6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11266"; a="169897267"
X-IronPort-AV: E=Sophos;i="6.12,182,1728918000"; 
   d="scan'208";a="169897267"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2024 15:39:50 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 8F63FD480B;
	Mon, 25 Nov 2024 15:39:48 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1CF9FD5610;
	Mon, 25 Nov 2024 15:39:48 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 87D952007CDDF;
	Mon, 25 Nov 2024 15:39:47 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 30A721A006C;
	Mon, 25 Nov 2024 14:39:46 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-mm@kvack.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH for-next v4] selftests/mm: Add a few missing gitignore files
Date: Mon, 25 Nov 2024 14:40:36 +0800
Message-ID: <20241125064036.413536-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241122074612.1582161-1-lizhijian@fujitsu.com>
References: <20241122074612.1582161-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28818.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28818.005
X-TMASE-Result: 10--9.531200-10.000000
X-TMASE-MatchedRID: HRm6PbbemxchiKpapiFQUqoXHZz/dXlxTJDl9FKHbrk/gf7afIrQU36y
	x7OFE28Qe+eZU8eiw0ZakcaN0kYenAtnIcpCCGR9zfqlpbtmcWgrtx/8GWh5m1c/CedjlcvkLHN
	FiwmJRq8xepHN1Gb+gpD1bY6uTBHE77IR1AIYrusqy6shOlK/42Iw13TP8dlT2vch1fMqmI8muo
	4pNDIMvtvWTR/WiMl9HBunSHImBEL9rLNrEHKk3k7nLUqYrlslmOb/jZZZ8UIGWfDd0b0zMaPFj
	JEFr+olwXCBO/GKkVqOhzOa6g8KrW0MLeV6pd59t5Zx1OwHJens0JYSBlfWTr5ameoPLbalQvt6
	QaxTfxs=
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
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
Cc: linux-mm@kvack.org
---

Hey John,
I added your Reviewed-by tag in this revision which have a minor
updates. Feel free to let me know if you feel this is unsuitable.

Hello,
Cover letter is here.

This patch set aims to make 'git status' clear after 'make' and 'make
run_tests' for kselftests.
---
V4:

  Use the exact filename to fix warning reported by lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202411251308.Vjm5MzVC-lkp@intel.com/
V3:
   nothing change, just resend it
   (This .gitignore have not sorted, so I appended new files to the end)
V2:
  split as seperate patch from a small one [0]
  [0] https://lore.kernel.org/linux-kselftest/20241015010817.453539-1-lizhijian@fujitsu.com/
---
 tools/testing/selftests/mm/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index da030b43e43b..689bbd520296 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -51,3 +51,6 @@ hugetlb_madv_vs_map
 mseal_test
 seal_elf
 droppable
+hugetlb_dio
+pkey_sighandler_tests_32
+pkey_sighandler_tests_64
-- 
2.44.0


