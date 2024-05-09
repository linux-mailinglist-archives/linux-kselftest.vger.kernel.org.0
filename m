Return-Path: <linux-kselftest+bounces-9766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CAC8C0B08
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 07:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BB3B2154F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 05:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7911E14A635;
	Thu,  9 May 2024 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8Bzq5c4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73E414A4E2;
	Thu,  9 May 2024 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232841; cv=none; b=fKl3wxoDecDcpQaLcWaaGDTf4TuQ1Nk/6LzAvdBlWmet0bfU+/CXpSvbCIQeyz74u3mX7YpicHHlhSro4tu3jtmtuzhfliIVNsJVp7SvKhqFTBeF7K1BUx8hfhx71lo6YrC8lOXy48qgHngl3VK9/K08znGtf/oFBTRZqFt76kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232841; c=relaxed/simple;
	bh=jAszuP8QnblnbS5/35iI7OsN248ffew8/z0ntm5DxNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIqb0zUf2Uy5dXPnU+nQ40tIM++52wd1siur8ANJDhMqEcsjr1WHmI0RIWqVztHeSXZPN8p4L0Ucvzn1hYKWQyPGDpNi0UF5QTl/wf90g8GmLzIPj8CnlW8JATyssKCmzyKfAszXHT/4AmEC34p+640/6BXTgg+rhlRs533ApIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8Bzq5c4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715232840; x=1746768840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jAszuP8QnblnbS5/35iI7OsN248ffew8/z0ntm5DxNg=;
  b=a8Bzq5c4RSnIFsu+18CokYiyT2yyuV+A/4w65i24TrdBr1Kr93ymAFdk
   mTxpSKcxLmc3ZMjfIycO4Ztf+ONWnRROHOslXF7eWUHP+6HYxpAPjBzNG
   sd9jrl3yo9WMAUvYE5lYzHIQmDOll4fmoXOejCbT6V0B8wwY+5cE3ZQf5
   1CZnZCNhYep0X85wM7+1u4xBaOByf6OSuL0VI7TaGieDoTbbqmBMGkh3o
   hC4X2ccpUyxEjqo9PehjOuMGVjolECQWbJi8s0cEs2uWMD9uK7Uzjj4D5
   gJJ5sxg9YNEzv+aREvRMqfa2fomXR7bnO4pAUvKItr6bcnN9xPyFl+hz5
   A==;
X-CSE-ConnectionGUID: aP0meGZ9R9ieaTLaoPqm6A==
X-CSE-MsgGUID: Z8bMOrHBTLa42oW+Xp9mdQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11286380"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="11286380"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 22:33:59 -0700
X-CSE-ConnectionGUID: orQ2I0GYRhuK4HTo+zp/ug==
X-CSE-MsgGUID: iLvb0uQfQja7KY/7FF2zRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="66558888"
Received: from unknown (HELO st-server.bj.intel.com) ([10.240.193.102])
  by orviesa001.jf.intel.com with ESMTP; 08 May 2024 22:33:54 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-sgx@vger.kernel.org
Cc: akpm@linux-foundation.org,
	edliaw@google.com,
	ivan.orlov0322@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	bongsu.jeon@samsung.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexandre.belloni@bootlin.com,
	jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	tao1.su@linux.intel.com
Subject: [PATCH v2 2/2] selftests/harness: Use 1024 in place of LINE_MAX
Date: Thu,  9 May 2024 13:31:13 +0800
Message-Id: <20240509053113.43462-3-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509053113.43462-1-tao1.su@linux.intel.com>
References: <20240509053113.43462-1-tao1.su@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Android was seeing a compilation error because its C library does not
define LINE_MAX. Since LINE_MAX is only used to determine the size of
test_name[] and 1024 should be enough for the test name, use 1024
instead of LINE_MAX.

Fixes: 38c957f07038 ("selftests: kselftest_harness: generate test name once")
Signed-off-by: Tao Su <tao1.su@linux.intel.com>
---
 tools/testing/selftests/kselftest_harness.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index ba3ddeda24bf..610642f50977 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -56,7 +56,6 @@
 #include <asm/types.h>
 #include <ctype.h>
 #include <errno.h>
-#include <limits.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -1159,7 +1158,7 @@ void __run_test(struct __fixture_metadata *f,
 		struct __test_metadata *t)
 {
 	struct __test_xfail *xfail;
-	char test_name[LINE_MAX];
+	char test_name[1024];
 	const char *diagnostic;
 
 	/* reset test struct */
-- 
2.34.1


