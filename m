Return-Path: <linux-kselftest+bounces-11572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC11902563
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 17:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC3B9288F13
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 15:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D248414388C;
	Mon, 10 Jun 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNwy88Hg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73762140E29;
	Mon, 10 Jun 2024 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032635; cv=none; b=kmUYCVWSaV5cMv4MukOqTCT5WFpAPWGyf5MyJ/PW+X2ZnTaBaJiYZ3oSoC8ePordSTX021+R9b0X/9zF3+c9BVCp2T8z/DX2T6VMUv/NvSgpO5COx6qwPAlmW+eO1spRma9psPtTCfBgPnUTeS1umqVnENm8QYwHfX/N8HGZKwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032635; c=relaxed/simple;
	bh=S9cfMwZg/9eewZmsG7lugvWNIjZBo1dQ6QGf+nuEZ0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RbBOFEuCRSyFVcsXqawgoODGvxhgTA9fR3l8Gr8hRvHSFi9acl0w9g4AVIDEoK6kq6ZF47nA2Q64b5RampeItS8yCdtAOGjAst9zfo1haydXv6c/XSGYsGWRkHBwGmq6RszIKADcJdEC2x5jsU4Bwv8kl03DjkJ0qqfLbvjFXx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNwy88Hg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718032635; x=1749568635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9cfMwZg/9eewZmsG7lugvWNIjZBo1dQ6QGf+nuEZ0c=;
  b=cNwy88HgaIfZsEjLopvtUtvpZZ6p0qY2I65Kyiau5Vj0mDFoUffXoQkN
   OmBnoKva5yoN1HDtbMbZKQxm3z6y5NGJ/OyWhM1HfsiTatm1R9WCHTh48
   4Csg6CuH9IZBxJvQf8uo6cxVBLrMHkJyTgzjVdYIDU8yad6NoptTJ/Wv8
   kqWtdp3snrAp9rMlLILXfi5R5bIQmGmMBWLZ/utv0iOfD7Lyp7pjbXnjN
   qVFsTE4FrIqfXCgl1SkpRR4VEYZ4vaw6rsdfyeC/nnHpCoROP1vHBx/Li
   zDBXEVk8WqFBpzql6fn7m3WNIf6XjzEwrq/tFCGr02v7UdWTJKUxaZVMN
   w==;
X-CSE-ConnectionGUID: 2sqUSaFcS0+G+Gg/ATwkJg==
X-CSE-MsgGUID: GFVWXdCkQ8OOpRNUaVDeMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="26115473"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="26115473"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:17:14 -0700
X-CSE-ConnectionGUID: n8PJYbNhQdarxb979Bkc6g==
X-CSE-MsgGUID: Z3Hwag50REOTRmRHMxD0xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="44026612"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.194])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:17:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v7 14/16] selftests/resctrl: Remove mongrp from MBA test
Date: Mon, 10 Jun 2024 18:14:55 +0300
Message-Id: <20240610151457.7305-15-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
References: <20240610151457.7305-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Nothing during MBA test uses mongrp even if it has been defined ever
since the introduction of the MBA test in the commit 01fee6b4d1f9
("selftests/resctrl: Add MBA test").

Remove the mongrp from MBA test.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/mba_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 9c9a4f22e529..5e0b1e794295 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -166,7 +166,6 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBA_STR,
 		.ctrlgrp	= "c1",
-		.mongrp		= "m1",
 		.filename	= RESULT_FILE_NAME,
 		.init		= mba_init,
 		.setup		= mba_setup,
-- 
2.39.2


