Return-Path: <linux-kselftest+bounces-20090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 937AB9A32B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 04:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EAD7284481
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 02:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E40D17DFF1;
	Fri, 18 Oct 2024 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdAZi4Sg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AA8158DB1;
	Fri, 18 Oct 2024 02:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218162; cv=none; b=Pvap6AU2yRg9PFHRHgsRwAf/LJgP7rdylPVoGAjSevJdAAxh4Bo3vw5iTcHjIqNrTWjYhCqKqPJEibI0g3aGbmV7PIcwVVHlqEb5dmzdRZPvrVk9kQQo9RU0jL1DSwszWHX4bRGlmwNYm9/1k1CSJ4NBfa0hJcFx88/9xlS9nJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218162; c=relaxed/simple;
	bh=2MBkITOraGEw2CIFCHHG4AS4AEaaronvpkHeMTP5ofs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8qxTghbvvJciKC0RVJ9wKrWkDDFDcsT/nGPV72ZOw7jHODLcsuO1IhlhB2LaF1SOjnU7lgcYWzqu55zmKdPnd0usQVKuxQESkaCY17HPB+BLe4wWYWpt8q+3TaA1BjmA7J7+hhMcAk4sACx6WKOcggeQXPrbVVL/uxku+F40vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdAZi4Sg; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729218160; x=1760754160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2MBkITOraGEw2CIFCHHG4AS4AEaaronvpkHeMTP5ofs=;
  b=SdAZi4SgNE8tiUQxPzWTia3EHidU5bqrY00/FlJ3qBFOxxXsrWpb7cbY
   YbawOSssNVDpoDUKPPHXazG4P0uJCJ79BoliB6rOTMMRIiuj67AFeENHY
   04FJb4oaYBt4QfuGmiNUXrdyNvyMRBFPM8/+EyMWoI9l7gnhWGTYpxsTq
   NRMBcdzM0LnrLKp+Etvxi5kCTh1zQkKjaJ0p9kFMvqNTZ6dl/GiqSvum/
   wRFMZkInJVvYGbg59mHFRGxKGZ6HtWIIbCvkT02p58IzwucXQG7QvSfjZ
   wFsUCTIjBz6fjZZlH74CG+QmWBtwtWY424xRvmaSMmDyQilISoHYX7GGy
   A==;
X-CSE-ConnectionGUID: O7T3lv6lQzebpFPjE+NTjg==
X-CSE-MsgGUID: 4z+cjZsxScu+LaQo6i0LtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54149682"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54149682"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:37 -0700
X-CSE-ConnectionGUID: xTYmW/x7T1qrJllEzu6Rag==
X-CSE-MsgGUID: sVOQzbYcTQ26IfWtweFxqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78697704"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 19:22:36 -0700
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
Subject: [PATCH V3 03/15] selftests/resctrl: Fix memory overflow due to unhandled wraparound
Date: Thu, 17 Oct 2024 19:33:18 -0700
Message-ID: <bdd02a0506924a101af066349b6417a28153eee8.1729218182.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729218182.git.reinette.chatre@intel.com>
References: <cover.1729218182.git.reinette.chatre@intel.com>
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
2.46.2


