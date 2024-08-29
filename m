Return-Path: <linux-kselftest+bounces-16679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD30996463E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 15:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75C641F20E38
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 13:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6E4197556;
	Thu, 29 Aug 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDWDPAV2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0721519005B;
	Thu, 29 Aug 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937450; cv=none; b=pAG7Welj4MIE1gDWc6AOLG9PHE4M7tAY56iKq+rAvFNPv6i4+flvKgBbwzZTcM5TROm6Q/NyOl0nQmjgGDq8Y9t2NWg6EEn9dpWj+HWf4EX3CGB4iQHs4Wimgf5aMWY7tjLN74FG4opLdxh01qkzJmqJ+cw4MPWk8DW7ss300fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937450; c=relaxed/simple;
	bh=t6uBeYGfUEyeNA+x65LOdfaF0fJ05xrJR7VelOUkPi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rNkGKDGxRFPjQgphJP3AKRAajlbtvtlKzxaGEANdk8zA4kZ2KAycearhN3zJOYrjNBeISFFzp0obhWfodWHHVNFZTRa/frLs36i9lH+A/aUdv9gAICzPXj/V30VttQAR+ZI6Fikm3+ezZvEhEcxc7d286rDN+PAZuWUbOwdTiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDWDPAV2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724937449; x=1756473449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t6uBeYGfUEyeNA+x65LOdfaF0fJ05xrJR7VelOUkPi4=;
  b=EDWDPAV2zWXb9GwZKcoy/DXhoB4vs9ttLhq38bZQQociZPsma2PvzKQv
   rA1vzD6xVRSN8Dm7Wy8tsGhzgFLMPuduSNdqGbKIuC/EMeNzqXRT7FXhl
   KdiWwEpmxeZtgoR8NoJ57/gYInCTniFEVtqFwlze/d9bD0rgx4FB2tF3a
   UJu+f1utVWff34IsJ/Un83P3pYYpU8SNpLtwahWdi4yxWQKHCyKEJAh8v
   GkEiIM+sNtspBsEBIzTn1gRHieqjdkj1tbyX0PQdLQIsZEwKyBD6oPop7
   MUQlNMQll0tPDxE4AwrFQ4o1BWp3D4asDuwqLwUGQLwUd5MnOMTLLY4Au
   w==;
X-CSE-ConnectionGUID: idJ0uPH+S++bsEnkDE0/1A==
X-CSE-MsgGUID: yfGe9gwpQSeqkwcEAUOeMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23656499"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23656499"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 06:17:28 -0700
X-CSE-ConnectionGUID: ZiGKM1MUTOCQGwoJR2TgFw==
X-CSE-MsgGUID: fv4p4tZ6TDOvORuXVUt1QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="68461046"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 06:17:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 2/3] selftests/resctrl: Always initialize ecx to avoid build warnings
Date: Thu, 29 Aug 2024 16:16:56 +0300
Message-Id: <20240829131657.1917-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829131657.1917-1-ilpo.jarvinen@linux.intel.com>
References: <20240829131657.1917-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To avoid warnings when __cpuid_count() is an empty stub, always
initialize ecx because it is used in the return statement.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/resctrl/cat_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 51a1cb6aac34..9882c5d19408 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -290,7 +290,7 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 
 static bool arch_supports_noncont_cat(const struct resctrl_test *test)
 {
-	unsigned int eax, ebx, ecx, edx;
+	unsigned int eax, ebx, ecx = 0, edx;
 
 	switch (get_vendor()) {
 	case ARCH_AMD:
-- 
2.39.2


