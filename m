Return-Path: <linux-kselftest+bounces-16709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D9B964D85
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 20:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE13B222CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC28D1B790E;
	Thu, 29 Aug 2024 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwtQu9NA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86951B5EC8
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955247; cv=none; b=ns+/raut/IQDPK3gTb4sLSxL1wfFXkUNd0OIqmkc1al753up2FEaS+8fs/GtD7ELq0BH8jemqe5UDN8olLM2vqCS89JGCLB+oYU+KjI59UE+4481ag5prSZiO/QwaITrUIL7Th9FaK+VxUQ9E1bRPGCJ3MZDBL33H/U1meHjJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955247; c=relaxed/simple;
	bh=oILEKqZ+d3w35AdoRuN4hOm7lzeZfLL5pZaFOKCVrsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rjfhK7lW0l2Y1f0Ondqljlgdg556L2mUmZLJ04jvEzNuA/SqgzMnqJAZz9vlp+GQLog4XywASlouz3yZQWyBleO9o4H8vdQCJQz9K7mklOz9CeoNMgm0h7ASYZdchEA25NujPwl4oUHuKlkEl5eqy6d/H1D9Qvpi749dXgiVRfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwtQu9NA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724955246; x=1756491246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oILEKqZ+d3w35AdoRuN4hOm7lzeZfLL5pZaFOKCVrsk=;
  b=dwtQu9NAr5l4aKFjrHhHws0+nMDQmlRfGvyYCOO79wWHTw6BfBneSmAI
   +MMsn1ezrLK0KHixng0Yne7h0KIWAExsEvhY84GANEonAxcVCDO0wv74C
   ezhKXvtveN9lZ8xHhI51aJrWRTfCb7/HiAyA9brR6T+Sld/9dLSdXqYg6
   eN7SSzhCKL3Xs8LC//jDsOUnrY6gUnyBEaGefoYoSrU9WCHF4CV5Onrq7
   qUQxAsr610r9HS7QUaWnVX4oYxyP15Qjz+iAyU5CWDQqtFJp3tilAnoSM
   htU8AWIQAYpaEmobp9+bIZwGl9Cymxj9nEOhh1dXVZMSikew02lm0Jqyg
   A==;
X-CSE-ConnectionGUID: RQGlskJYRliK0mzHIvJuEA==
X-CSE-MsgGUID: 5foA/jMySB2AYtgXJUIaqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34238440"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34238440"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:14:05 -0700
X-CSE-ConnectionGUID: 0OO065MHQ066VSzBkJgqkg==
X-CSE-MsgGUID: Kv8poLzgSjy9P9kfMjaUlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63353241"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.245.120.199])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:14:03 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v3 3/6] kunit: Add macro to conditionally expose expressions to tests
Date: Thu, 29 Aug 2024 20:13:45 +0200
Message-Id: <20240829181348.1572-4-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240829181348.1572-1-michal.wajdeczko@intel.com>
References: <20240829181348.1572-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VALUE_IF_KUNIT macro will add expression statement only if the
CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
it will evaluate always to 0.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: Rae Moar <rmoar@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
v2: add simple usage example (Rae)
    reformat kernel-doc for better output (Michal)
    s/ONLY_IF_KUNIT/VALUE_IF_KUNIT
---
 include/kunit/visibility.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
index c1825381adfc..b156cafa4705 100644
--- a/include/kunit/visibility.h
+++ b/include/kunit/visibility.h
@@ -30,6 +30,25 @@
      */
     #define DECLARE_IF_KUNIT(body...)	body
 
+    /**
+     * VALUE_IF_KUNIT - Conditionally evaluate an expression
+     * @expr: the expression to be evaluated conditionally
+     *
+     * This macro evaluates expression statement only if CONFIG_KUNIT is enabled.
+     * Otherwise if CONFIG_KUNIT is not enabled it will evaluate always to 0.
+     *
+     * .. code-block:: C
+     *
+     *     int real_func(int i)
+     *     {
+     *         if (VALUE_IF_KUNIT(i == 0xC0FFE))
+     *             return 0;
+     *
+     *         return i + 1;
+     *     }
+     */
+    #define VALUE_IF_KUNIT(expr...)	expr
+
     /**
      * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if
      * CONFIG_KUNIT is not enabled. Otherwise if CONFIG_KUNIT is enabled
@@ -46,6 +65,7 @@
 	    EXPORTED_FOR_KUNIT_TESTING)
 #else
     #define DECLARE_IF_KUNIT(body...)
+    #define VALUE_IF_KUNIT(expr...) 0
     #define VISIBLE_IF_KUNIT static
     #define EXPORT_SYMBOL_IF_KUNIT(symbol)
 #endif
-- 
2.43.0


