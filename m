Return-Path: <linux-kselftest+bounces-15907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D789A95A528
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665B028307F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A95E16EBE0;
	Wed, 21 Aug 2024 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iv2OZm6a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0828616DED2
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267702; cv=none; b=HKTO6ykNPR9KRxwoxTLerXAcdjuqI0/44GymjSzImD+cSl2k+q0ucYcyqqHAVT4tZabAjLoqOkj8NanIRcDGQE8Y0o6mFuSyjn5ROo0uihC5lacxV3Kc5ojHTDoHuVTyOJ0iToM7zXNWCY6gnZUcwxM12ctki05XYSY8/Fk/3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267702; c=relaxed/simple;
	bh=tAytofjtM+LX89uuayDs1pCibWEoVTAAvB99gbrLKaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z+o6oS9rL7MFxfI8lwevGUy3Yw17NVEASe0m1l5+8YNMAxJPuj2CMTamRnkdZP3ffMTdBY2dWLWzsPwprLEyxhTpi8Pee0V3kIKT//CowQc6Wq6jwQ+IBXZpBxLmI7U/nmk8GiHdcR7gzA57NSlFPJZjJHiCuDLy0mhMeY9QsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iv2OZm6a; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724267701; x=1755803701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tAytofjtM+LX89uuayDs1pCibWEoVTAAvB99gbrLKaQ=;
  b=Iv2OZm6aYW/+8fFzmQ6Ymf8kGMFHjIRBJZdauXzWSXsT/AX72oXPA02m
   Cvr8Bj6pe3lwqX2l+LtuBRw4oPp3Li4GLevc/geF22xm9jVr2Jh8i74X7
   oFWBH6fFMnQ1eGRTPmwz0LORh3W/p262PBnG8SxHIQV5BAqmIwzL5PQng
   Ks+iiFqkexljqBEL504acwdxt3CDVdLqyRoEgsTPG24P/Fguw2HWzpwfw
   9WDNi9/zqCnI6c+AXan3yb1hh/h2PCROOvuN9SFiIsFIyggM6REHGvpe1
   AhkdrPNcGiqzrWe2/DtkzUJSBaJEmQzriGNQzKiQT8eJ8gM+mmk407dRQ
   A==;
X-CSE-ConnectionGUID: R3994ZYzTnKgDr7m7hIJhg==
X-CSE-MsgGUID: VlwTz/QCSRisSgc1hCy/5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22802451"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22802451"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 12:15:00 -0700
X-CSE-ConnectionGUID: QdaIVlzbT7GCNsuEprBcnQ==
X-CSE-MsgGUID: zsKKzOO1TpiY1zj3ddTvpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="84357284"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.19.248])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 12:14:58 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH 1/3] kunit: Improve format of the NOT_ERR_OR_NULL assertion
Date: Wed, 21 Aug 2024 21:14:10 +0200
Message-Id: <20240821191412.2031-2-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240821191412.2031-1-michal.wajdeczko@intel.com>
References: <20240821191412.2031-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Diagnostic message for failed KUNIT_ASSERT|EXPECT_NOT_ERR_OR_NULL
shows only raw error code, like for this example:

  void *myptr = ERR_PTR(-ENOMEM);
  KUNIT_EXPECT_NOT_ERR_OR_NULL(test, myptr);

we will get:

  [ ] Expected myptr is not error, but is: -12

but we can improve it by using more friendly error pointer format:

  [ ] Expected myptr is not error, but is -ENOMEM

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>
---
 lib/kunit/assert.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 867aa5c4bccf..6e4333d0c6a0 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -82,9 +82,9 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
 				  ptr_assert->text);
 	} else if (IS_ERR(ptr_assert->value)) {
 		string_stream_add(stream,
-				  KUNIT_SUBTEST_INDENT "Expected %s is not error, but is: %ld\n",
+				  KUNIT_SUBTEST_INDENT "Expected %s is not error, but is %pe\n",
 				  ptr_assert->text,
-				  PTR_ERR(ptr_assert->value));
+				  ptr_assert->value);
 	}
 	kunit_assert_print_msg(message, stream);
 }
-- 
2.43.0


