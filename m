Return-Path: <linux-kselftest+bounces-20578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FAE9AF44F
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 23:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AFD282A7F
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C882F21832A;
	Thu, 24 Oct 2024 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mK/u2TUr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C682178E0;
	Thu, 24 Oct 2024 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804086; cv=none; b=N46+lK8uZkfK5x7ukqrZ4N7ySsi29BkIrzE56t8lWOj6yyN+7JO8uZaYXa1xl8k9IcNBfKorddkt46V2Bw6BojFC3mj1O2KhgfmVvl2XPzT4sUgZL1qbgpHd+TjQQ3j+gONa6ZXWdM5fiY2wKBTH38/1e/asX5w6ESsNmsVGfTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804086; c=relaxed/simple;
	bh=UzzqknheAAX6hxjlvFlIZNJbYWmAx1Pye1kk6LJzmEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcfQuyqgYpRHp690/5MPEeLO+SRvqkg9ZODYnMxlv4LVw+ZNdw1IGUu5KlHGZpzR/Vr4EyJ5adnOnpWIf7h242MWgO+W49Xupw4ln7c23xMru31dHMhqWWNRvLClrAbmAiEICpirMWtgZ5v5RAv4UqASKYk1qxnv/GXXY4PKHv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mK/u2TUr; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729804085; x=1761340085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UzzqknheAAX6hxjlvFlIZNJbYWmAx1Pye1kk6LJzmEE=;
  b=mK/u2TUrx0TsmCy4ibt4LmDGOB8Qi0rKBRCiwO/Wfn5eUC+skhr9K5QI
   5ifcsyE08D55MKDzaWn76qGdVtw8/vhNKKrV0qShOXAznMYuErjBzbTJ/
   XHoRw4kM3/D/vlaY2ep2GiGLIWjJmv10Jt732JJw/KL3cKznj7buVE/NJ
   47so5RFDMtP2R5T9R2e/mj0EXckaZZbXDmcQei5M//bPByd2U5pNWXWsm
   4AxMJVbwhlvgwrnUleOYeko/o0AfJsISgFEbNx08uO6Dbaeyfk9bA2Oy7
   GeP+Da1R1vYJ6kY4TbNSumiElrYeDJUP35saO8Xviz7zMDSzYYFsfRz4j
   A==;
X-CSE-ConnectionGUID: B8ArmqlzR6qWsb+MZrj/9w==
X-CSE-MsgGUID: xltyl/nmRTqwV98Io1skoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="17090884"
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="17090884"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:01 -0700
X-CSE-ConnectionGUID: wLaBP/8zS0e0Bbz38b2NEw==
X-CSE-MsgGUID: kitsDoW8QLigmw444S4I8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="85488026"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 14:08:00 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	tony.luck@intel.com,
	peternewman@google.com,
	babu.moger@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com,
	reinette.chatre@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 03/15] selftests/resctrl: Fix memory overflow due to unhandled wraparound
Date: Thu, 24 Oct 2024 14:18:40 -0700
Message-ID: <0927fd4a76961b2452ba3f77f75ed4d19e187b24.1729804024.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729804024.git.reinette.chatre@intel.com>
References: <cover.1729804024.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

alloc_buffer() allocates and initializes (with random data) a
buffer of requested size. The initialization starts from the beginning
of the allocated buffer and incrementally assigns sizeof(uint64_t) random
data to each cache line. The initialization uses the size of the
buffer to control the initialization flow, decrementing the amount of
buffer needing to be initialized after each iteration.

The size of the buffer is stored in an unsigned (size_t) variable s64
and the test "s64 > 0" is used to decide if initialization is complete.
The problem is that decrementing the buffer size may wrap around
if the buffer size is not divisible by "CL_SIZE / sizeof(uint64_t)"
resulting in the "s64 > 0" test being true and memory beyond the buffer
"initialized".

Use a signed value for the buffer size to support all buffer sizes.

Fixes: a2561b12fe39 ("selftests/resctrl: Add built in benchmark")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
Changes since V2:
- Add Ilpo's Reviewed-by tag.

Changes since V1:
- New patch.
---
 tools/testing/selftests/resctrl/fill_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index ae120f1735c0..34e5df721430 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -127,7 +127,7 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush)
 {
 	void *buf = NULL;
 	uint64_t *p64;
-	size_t s64;
+	ssize_t s64;
 	int ret;
 
 	ret = posix_memalign(&buf, PAGE_SIZE, buf_size);
-- 
2.47.0


