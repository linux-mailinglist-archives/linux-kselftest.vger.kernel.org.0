Return-Path: <linux-kselftest+bounces-5282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2595E85F7B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 13:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87E41F24ED1
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A760873;
	Thu, 22 Feb 2024 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4xbulGG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7415915B;
	Thu, 22 Feb 2024 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708603637; cv=none; b=Pg99BBJQyBT7Bd2cVtCRgQjYgTqgJQYmmIcn6tY30SQRWLUodDxkodTbzONiRdZwmjPLDoT5wO0A5eI0ztz4GY9oSt3R08OnLl7hzHzg21jwvSS1BBlU6pi1CFp7dtmfK/JG8uTpv3K66pTzj1AmFkeHbRog8Bwu50DjT2EBOJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708603637; c=relaxed/simple;
	bh=ISipd+RvHeb8FAy3tub2FjR36pI88FRyLXT4pFOGt/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZHkIJmz9Yk4di1jfK4T5pFSbHoqwLsWnXVluFwqhNMqggcFJKUNqLImZ8XhQ+jdJ+tk3HfxXt8u635pI4xb681/6BgtqqlZdetaS0Q484hWdtMVgpKEjCgkCkyOmUJXn/uqyWgtAfVnmdg7rHvrNlSKnjwHdmUJslL3sNxN7xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4xbulGG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708603635; x=1740139635;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ISipd+RvHeb8FAy3tub2FjR36pI88FRyLXT4pFOGt/8=;
  b=g4xbulGGE7kpX0lqCku8/LqruPaawEwQMxh4Lf76H4EJTzEgGFXdzJoJ
   JvN0rgrOsO4gg4Wuz1cTRwcHTJujda00JEWj6Yrxs4V7k4MPxpK3L9z2e
   +wcXlFM2+z8MzpikckPkvHMw/4gKU7XSpdJxdoHx1eWPYtgC1q2je/ChV
   6xtxhwxR5qqVzTvjgLy/LG+JE1OybNFEu1G6+arBNATjfViv+3lvJ2L/G
   Hffkl/S5wqjkPiClXt2c62wkqssjyI2LJk9KeEloXgQZzyJhu7jSjDJg1
   cv/p6msBF6VG5u64WAoIQlIJEIGSOoOuXfhov9nfWz25Q92JwnHo0SSWz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6643098"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="6643098"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:07:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10050370"
Received: from ksulimow-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.23.120])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:07:12 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	shuah@kernel.org,
	fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3 0/3] selftests/resctrl: Simplify test cleanup functions
Date: Thu, 22 Feb 2024 13:06:57 +0100
Message-ID: <cover.1708599491.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleaning up after tests is implemented separately for individual tests
and called at the end of each test execution. Since these functions are
very similar and a more generalized test framework was introduced a
function pointer in the resctrl_test struct can be used to reduce the
amount of function calls.

These functions are also all called in the ctrl-c handler because the
handler isn't aware which test is currently running. Since the handler
is implemented with a sigaction no function parameters can be passed
there but information about what test is currently running can be passed
with a global variable.

Changelog v3:
- Make current_test static.
- Add callback NULL check to the ctrl-c handler.

Changelog v2:
- Make current_test a const pointer limited in scope to resctrl_val
  file.
- Remove tests_cleanup from resctrl.h.
- Cleanup 'goto out' path and labels in individual test functions.

Older versions of this series:
[v1] https://lore.kernel.org/all/cover.1708434017.git.maciej.wieczor-retman@intel.com/
[v2] https://lore.kernel.org/all/cover.1708596015.git.maciej.wieczor-retman@intel.com/

Maciej Wieczor-Retman (3):
  selftests/resctrl: Add cleanup function to test framework
  selftests/resctrl: Simplify cleanup in ctrl-c handler
  selftests/resctrl: Move cleanups out of individual tests

 tools/testing/selftests/resctrl/cat_test.c      |  8 +++-----
 tools/testing/selftests/resctrl/cmt_test.c      |  4 ++--
 tools/testing/selftests/resctrl/mba_test.c      |  8 +++-----
 tools/testing/selftests/resctrl/mbm_test.c      |  8 +++-----
 tools/testing/selftests/resctrl/resctrl.h       |  9 +++------
 tools/testing/selftests/resctrl/resctrl_tests.c | 16 +++++-----------
 tools/testing/selftests/resctrl/resctrl_val.c   |  7 +++++--
 7 files changed, 24 insertions(+), 36 deletions(-)

-- 
2.43.2


