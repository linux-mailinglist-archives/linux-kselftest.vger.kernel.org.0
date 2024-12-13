Return-Path: <linux-kselftest+bounces-23375-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F279F18F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 23:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A6C188F17C
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 22:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF5519992B;
	Fri, 13 Dec 2024 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OUXqNWTY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1F4185949;
	Fri, 13 Dec 2024 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128330; cv=none; b=t3zJGm5LiLIHpEE6uAlLxTW9Gl9gTEIOaPL1n5qf+FK1ojipP3j2j7mlhM3t+8DU7LK80pG8L8xAP6KzLkG7Y1s4OLIUXt+pXf4kzEjvF8giHPXLTcXjaWfqfSUYXUHBaWZ31b6sNqXdVRWkIjHqeorMf59swmj9b43sKF/3GSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128330; c=relaxed/simple;
	bh=yGVF+lGT8ur8QZFdxP3rJGdxQv5/psNez7G9/LlnyAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7c1h3UoF9ZrJTNfNa0KosM+3xva0NH+lycpLQKItuMPhf6BFYUDjhoctZagm1er1cjpQWDx/iVCe96uw2LyKEhgWMt+bIcKlLyOVlwR4tp2nraPE5NlsJZU19/YbVF4EZuLzMf9rWAI6s8k1LO+E2mNsYNyI/7Mmz1bwl7A5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OUXqNWTY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734128329; x=1765664329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yGVF+lGT8ur8QZFdxP3rJGdxQv5/psNez7G9/LlnyAo=;
  b=OUXqNWTYlBzbvRqM+qKeVVc4M4q9SM7LEXOk+5ei+E/0FrT3/YMUKmtz
   si9i3bp+bffBTixi3wt3cchanWo3cxOYK4+hcj3pIl1IJCleSapnoH7e9
   ntqDfPE0kMD7UO5WBk6Mlpg+RSYG9wxKQQTjzSrZgVg2n7rLgWw6+16NL
   5eJ7BH06Gwg35yBinH9AcSiwtvv9Xx/Z91T8DTSTtayZ5F2n1PgumU++L
   /ioz70YfrN1D6xx2ImT96QhLZBGH+EfM9RbX9JQ1/VfxxSCahlVKJbhxG
   6BcNSp4i+Hc1ocNSQUm/Unn5jfD+VwGt++IYY3NrekXJ3lpb5nGhFh5Kn
   w==;
X-CSE-ConnectionGUID: UcEOFs5GQ1W0S9Z/foQ1fg==
X-CSE-MsgGUID: YYHLya8YSYm6UKBfkkU6ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38526460"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38526460"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 14:18:48 -0800
X-CSE-ConnectionGUID: cYDbbYl9QR2Pm3TS6wPPlw==
X-CSE-MsgGUID: CyLYLFNcQ4Cbf0jiSe7UyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="96708626"
Received: from rchatre-desk1.jf.intel.com ([10.165.154.99])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 14:18:48 -0800
From: Reinette Chatre <reinette.chatre@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com,
	shuah@kernel.org
Cc: isaku.yamahata@intel.com,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	reinette.chatre@intel.com
Subject: [PATCH] KVM: selftests: Add printf attribute to _no_printf()
Date: Fri, 13 Dec 2024 14:30:00 -0800
Message-ID: <898ec01580f6f4af5655805863239d6dce0d3fb3.1734128510.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Isaku Yamahata <isaku.yamahata@intel.com>

Annotate the KVM selftests' _no_printf() with the printf format attribute
so that the compiler can help check parameters provided to pr_debug() and
pr_info() irrespective of DEBUG and QUIET being defined.

[reinette: move attribute right after storage class, rework changelog]

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 3e473058849f..77d13d7920cb 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -22,7 +22,7 @@
 
 #define msecs_to_usecs(msec)    ((msec) * 1000ULL)
 
-static inline int _no_printf(const char *format, ...) { return 0; }
+static inline __printf(1, 2) int _no_printf(const char *format, ...) { return 0; }
 
 #ifdef DEBUG
 #define pr_debug(...) printf(__VA_ARGS__)
-- 
2.47.1


