Return-Path: <linux-kselftest+bounces-16344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849E395FCA9
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 00:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03BA6B21C0B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 22:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B24D19CD12;
	Mon, 26 Aug 2024 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVi2qqLZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CA811E2
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710840; cv=none; b=Hw43klWm/n5tjMojKlTBl1GPOIRhmNqBK7+HPOMHJLCxBJOkvRaUCI3Rnu8HVaUF1SY95DQq+l+UB6Ro0FgCAevtW7oWGab3ilNbKUGW2BQIKTrBWtI52RncJvxuHE8LxyKKaeQYQzycBDj1RIf1mFvJz7HKebBBp4wVZn47cHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710840; c=relaxed/simple;
	bh=LmunGQniTVddjjEhBzlKBYQi2KkdQYLohMk4k4MO/r4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Moye4/Y5OQvlR+YCHLpS794mY9SFugAcEbh7fI5OyAkNhHJFghcEWzchjh1J8LNY3aFFxUOYTgj0gorhpzTh4nK78xYtF8Ge6zJw6cLaM3xMGGWB/dWXf1jaCN0QR8IknCiXfumffxExmbx3YDUVn5aqvm3M0h32vUAQ4gq6pC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVi2qqLZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724710839; x=1756246839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LmunGQniTVddjjEhBzlKBYQi2KkdQYLohMk4k4MO/r4=;
  b=RVi2qqLZ1FaD3TGYIbeaV9S8WoCVMoA3PPsS51iQ04GnP4d0QYKEo8dZ
   bCmKTQVgHAv7oXjmJqGyhUQlzWWEOUBy2u+9E8sVKVWtJn89/eCX/ig6x
   3QV/wPNlkaynNo766e6c6thGGCuHuihAri7POCUtZRgCma8lCyDKfFtAL
   1XLNMxpV5C3ZDTB/lf/84lkJAbmjni9zhXoQiSNvESh/2lb3Rsn8yP2pw
   tJ2Yaodxi0G7muCTncu2InkuieD0XLYYaLkuTOI8P3aSMwhu242q04XC6
   Wla4QqcUPsic+ZmeVh4vehZ2RfDUvqvBKSMMlz5K+0LdWhws5b1ZxkUHT
   Q==;
X-CSE-ConnectionGUID: BcLZWTIWSWeRdxCnN9Bb2A==
X-CSE-MsgGUID: tk0ubk11T9u8NmDQZlpiQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34537395"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="34537395"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:20:39 -0700
X-CSE-ConnectionGUID: aqmrJdR8TAukpywuVO82wA==
X-CSE-MsgGUID: RbzbcP8ZRnONosNE3KlBnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66992226"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.1.253])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:20:37 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v2 3/6] kunit: Add macro to conditionally expose expressions to tests
Date: Tue, 27 Aug 2024 00:20:12 +0200
Message-Id: <20240826222015.1484-4-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240826222015.1484-1-michal.wajdeczko@intel.com>
References: <20240826222015.1484-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ONLY_IF_KUNIT macro will add expression statement only if the
CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
it will evaluate always to 0.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: Rae Moar <rmoar@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
 include/kunit/visibility.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
index 1c23773f826c..69c71eacf368 100644
--- a/include/kunit/visibility.h
+++ b/include/kunit/visibility.h
@@ -18,6 +18,13 @@
      * @body: identifiers to be introduced conditionally
      */
     #define DECLARE_IF_KUNIT(body...)	body
+    /**
+     * ONLY_IF_KUNIT - A macro that adds expression statement only if
+     * CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
+     * it will evaluate always to 0.
+     * @expr: expression to be introduced conditionally
+     */
+    #define ONLY_IF_KUNIT(expr...)	expr
     /**
      * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if
      * CONFIG_KUNIT is not enabled. Otherwise if CONFIG_KUNIT is enabled
@@ -34,6 +41,7 @@
 	    EXPORTED_FOR_KUNIT_TESTING)
 #else
     #define DECLARE_IF_KUNIT(body...)
+    #define ONLY_IF_KUNIT(expr...) 0
     #define VISIBLE_IF_KUNIT static
     #define EXPORT_SYMBOL_IF_KUNIT(symbol)
 #endif
-- 
2.43.0


