Return-Path: <linux-kselftest+bounces-16708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84ED964D82
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 20:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD5851C22928
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB05D1B81AF;
	Thu, 29 Aug 2024 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H0ix+Unn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD9A1B5EC8
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955244; cv=none; b=anvM9dzpuLjgUOONiBJHfUT2DG+II4ahUGl3WFgEsur9YsvjTkL90Ga5SoyfjSDT1pQyYgR2sPzXNr1vXmaZweMZOzCnK3fJ4Bmo0UpaKQo1CjojKHuADyGEiYgQe1oBnDCgBOKLPmXIdLMp2LEcbemE5ZWDHNwBxkoy/rSfDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955244; c=relaxed/simple;
	bh=YKnkV684Szy48IHSUnldBzj/JFtnEHMA6jrXEj4Ev9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kc9gqC+SM3/Wc/cgMsWR5Zdy/JoGfcGrCXPBvaGWeh72NLjN1i73fzg+OVnN2+it3DCzX7ToAH0ADOtp20zYOVa2xLTomkdqZQbeTnXErVuQSaNkizUOb8TXu6cgDtRUBV88/DxGwpOV3eRzC8DPY7H4cLaYSEtXmO5GRfV++L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H0ix+Unn; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724955243; x=1756491243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YKnkV684Szy48IHSUnldBzj/JFtnEHMA6jrXEj4Ev9U=;
  b=H0ix+Unn3kkNOXe38Ppq2k1Z5IXV3i6EDUz11xRWW7KOvChIMMy1mQMB
   sTA8w1z6RgrrG1Tqjw4evtW2WkPygbcvpizpfNS+Rp1C9swlb54RQxtHa
   81kFr8wtHD5jdO+EcbYjY4TNGPOm0N5wt24SLnNPjUYJKrFxIDqNXFj/k
   9kpuygXvdv8So2VhkIs7niVBIc0zA7i/N5fGpeLi2n2SOzKVP2Qs/6gVN
   8jCv0AHC644OyAoy2bWuXcN0ebtVT7GuIIbWTi/CAp2GQW5mkBrWsqKAo
   pHbI1i03JeumZhhp96v8Fjauojqaz4Buz/PgA4lhwDX85/qc1KaYo994q
   A==;
X-CSE-ConnectionGUID: tFnXAgw6SSSk13UAi6qxgg==
X-CSE-MsgGUID: kdaxaA9rQfCtkC7q+mirwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34238435"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34238435"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:14:03 -0700
X-CSE-ConnectionGUID: /EgrKxqvRKCYhcc/XmWGZQ==
X-CSE-MsgGUID: LG5Db8MzSFCwOVOaSlJu4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63353227"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.245.120.199])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:14:01 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v3 2/6] kunit: Add macro to conditionally expose declarations to tests
Date: Thu, 29 Aug 2024 20:13:44 +0200
Message-Id: <20240829181348.1572-3-michal.wajdeczko@intel.com>
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

The DECLARE_IF_KUNIT macro will introduces identifiers only if
CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
no identifiers from the param list will be defined.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
v2: include struct example in macro comment (Lucas)
    reformat kernel-doc for better output (Michal)
---
 include/kunit/visibility.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
index 0dfe35feeec6..c1825381adfc 100644
--- a/include/kunit/visibility.h
+++ b/include/kunit/visibility.h
@@ -11,6 +11,25 @@
 #define _KUNIT_VISIBILITY_H
 
 #if IS_ENABLED(CONFIG_KUNIT)
+    /**
+     * DECLARE_IF_KUNIT - Conditionally introduce identifiers
+     * @body: identifiers to be introduced conditionally
+     *
+     * This macro introduces identifiers only if CONFIG_KUNIT is enabled.
+     * Otherwise if CONFIG_KUNIT is not enabled no identifiers will be defined.
+     *
+     * .. code-block:: C
+     *
+     *     struct example {
+     *         // @foo: regular data
+     *         int foo;
+     *
+     *         // private: data available only for CONFIG_KUNIT
+     *         DECLARE_IF_KUNIT(int bar);
+     *     };
+     */
+    #define DECLARE_IF_KUNIT(body...)	body
+
     /**
      * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if
      * CONFIG_KUNIT is not enabled. Otherwise if CONFIG_KUNIT is enabled
@@ -26,6 +45,7 @@
     #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
 	    EXPORTED_FOR_KUNIT_TESTING)
 #else
+    #define DECLARE_IF_KUNIT(body...)
     #define VISIBLE_IF_KUNIT static
     #define EXPORT_SYMBOL_IF_KUNIT(symbol)
 #endif
-- 
2.43.0


