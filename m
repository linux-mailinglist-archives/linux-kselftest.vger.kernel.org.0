Return-Path: <linux-kselftest+bounces-16023-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0F295AFF9
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 10:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEDDA1C22F44
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 08:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1DC176AD0;
	Thu, 22 Aug 2024 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7bkGGJm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9241741FA;
	Thu, 22 Aug 2024 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314324; cv=none; b=mDBgJtqIIKNDc4lb8PKb5MEc9byCRp0vo86KxZXepLJotN6U4k81XbwORi2BH0BdGkKdu/wRNe6uuo2r8hsFXqENGPK/OSlTuqki7KTREoDHTb2GzI+e5skFe7kojr599txWDiFJMtu6kt7CjFCMosmI6gzh6RF+BP7uu/JTlAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314324; c=relaxed/simple;
	bh=t6uBeYGfUEyeNA+x65LOdfaF0fJ05xrJR7VelOUkPi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crZ9asDV9Vk0+/LkZKALx8+o4RRME+etcNWnil3G2BYHwN2+z1xYgNT+ImyXxXsrT11CcPqFOZatGHbqqgzl3wVmoS8QzNHi2SYvAiqI60lNJY3hVogs92pCJGhauc0ucQlCqEm+suKxeT+y1AGZgLeFCm5F/QZapzf8epsKaSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7bkGGJm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724314323; x=1755850323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t6uBeYGfUEyeNA+x65LOdfaF0fJ05xrJR7VelOUkPi4=;
  b=l7bkGGJmLEV93cX5qknZW1wm7aV9cJGwVFwODZYGQuDu5rswbCM+fQi6
   +eRRQ7xsiWXpcI97kC69ASsR5hjxWr4kU7ZBYdnDjt7DmOnaq2VCbTn0O
   i/qINotpu0ko4440bRQxx1Tc+c54h97gIRxfLmPqkDAb0jhgXUoCu1PZs
   fzFiKJmEoo9whQ+5S3KPVt1kJfAOvd+sXvWUXnz81lLkFWhQKYuQ1oN4w
   kw+jg5MvPh1wDW/NDFKPt1eb9xHB6RhxJp2LYLbIlwus6eZFWG64liSsq
   rqPHZSfcWU6+25w8PrRmI0rTg/CTifkW640uf+OaKwRQbmD6OQQqC8VP1
   g==;
X-CSE-ConnectionGUID: gaaBN+kjTBelVJjQ8yblPg==
X-CSE-MsgGUID: AU8zwrevTImWbHjn/t7DyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33331696"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="33331696"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:12:02 -0700
X-CSE-ConnectionGUID: hydgDmEtT+uPjuZr3xFDeA==
X-CSE-MsgGUID: 9luiZIvzRwWUqR+DynlvMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="66182045"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:11:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/3] selftests/resctrl: Always initialize ecx to avoid build warnings
Date: Thu, 22 Aug 2024 11:11:13 +0300
Message-Id: <20240822081114.4695-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com>
References: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com>
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


