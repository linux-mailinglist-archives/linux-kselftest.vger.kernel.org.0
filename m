Return-Path: <linux-kselftest+bounces-17856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8387976FFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 20:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F41428736C
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40661BFE10;
	Thu, 12 Sep 2024 18:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dfgeJKyP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3128D1BF7F8;
	Thu, 12 Sep 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164296; cv=none; b=c5Uas364DJnM1mgX0Kq/jFyXUeLGainxvi8v8m9UFi2E/++tR7epgq1v/tWHvW62FdYZ5OCW6bFHX0tXUabeErkT2Rpl3jiyhGZ6RrymwNWqQF8RsqzVpv+mrO3Vfez6LAoovPlzc53DHCR9fqN0Gax0CANM7W4TLOk6BdEnWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164296; c=relaxed/simple;
	bh=wPJfXOB/WVc5EYyKPe+kkP9moln0nfDFpBDGwXFRjwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3iuZibApQCceMNEId2cdXcG53Ph6sLFt3U+Cnz3+1l9P4wrAx9XmmS8Ix+mFbjoUeAaQ2texdB91MM3CFNxbI/GsHEupcd6LYPkUCKVeMhcBBly8TwjRfUXsrXY7odR4WdTBU1aZjyg345gP6tHWogxoUpKLHY0zHOy4b6zXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dfgeJKyP; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726164296; x=1757700296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wPJfXOB/WVc5EYyKPe+kkP9moln0nfDFpBDGwXFRjwE=;
  b=dfgeJKyPCF1tooCUW6W0NQlb0MrjTUCmNyeIB7BR/j3exdNQkJc9JCkv
   NyS07LF+Bfa+H55WYWZEHkfBw9RSh0KRCrQ+mLJlguehMZEsuqjigWbKJ
   01qWjnU9d97cJlzElvufvJMi345bugyFmMbJrb8y6YwsSH+QCZtoErrY6
   eYLuzeb4ODpgOdqjJt0ua1YC/dh2FwVyFgbUTjWqLl3FhrL4nHl9qz8rT
   CpWfwg1GhB/qx12M4aqAO4A0HXvmi9A34SGJQnbiWE0oxYBLUzsuW3+NK
   b5RyJA1O8bcaSFBziJFQkBw2ydryYi3W3Iv7CosNdPbVZ7bbKWJeRvPnD
   Q==;
X-CSE-ConnectionGUID: XHU55XhTSdGYTXpMulopnw==
X-CSE-MsgGUID: HxL06+KwQuWHWceUm8PJ1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24976582"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24976582"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:52 -0700
X-CSE-ConnectionGUID: Z8Lh74GYRJ+9J7qmaMRRcg==
X-CSE-MsgGUID: OD91f+VeTjaPx6Ev2nAgHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67724606"
Received: from b04f130c85c0.jf.intel.com (HELO rchatre-desk1.jf.intel.com) ([10.165.154.99])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 11:04:52 -0700
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
Subject: [PATCH V2 03/13] selftests/resctrl: Fix memory overflow due to unhandled wraparound
Date: Thu, 12 Sep 2024 11:13:52 -0700
Message-ID: <dc99091aeadca217f297c4cc0d4015bcb80443ad.1726164080.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726164080.git.reinette.chatre@intel.com>
References: <cover.1726164080.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
---
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
2.46.0


