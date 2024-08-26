Return-Path: <linux-kselftest+bounces-16343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E395FCA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 00:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70353B21BAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 22:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463C119D07D;
	Mon, 26 Aug 2024 22:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B36ueka6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDBA811E2
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724710838; cv=none; b=jmbVqbj1PRym+F8r4oySelJznbQ5EQzX1swezdYG8NLpVJ+cMz1Ruflwefkp2DYL6rycQH+NSJ/6cCC7VmNr/TCED9N5eBKYUr8TiuAtMBUqGDKl0us2ZRg5wtdldqRCQwy3yJqmvsYJdChGDPbpK6mWx3ueix3McJCDdA9Cwts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724710838; c=relaxed/simple;
	bh=sU0ech7PhVj3cE3JKopGkDODGyiifWrk9mA0zCgcDKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sjuHWSLQteAU1H26BWyf/WZkQ49afwCK6mva6t7ICU4B4cMeTCixR8gF1Sz3T7Powh6U/q+F5d/52lsLQnUpmykTqnr4lKaXJ/gY7FCHEHAlCFPqINVAovgYMJ7fs3jy2K7AwGcF3uXAD0rp+y4XYZTmeAoqNYd/3P5CRaWcHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B36ueka6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724710837; x=1756246837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sU0ech7PhVj3cE3JKopGkDODGyiifWrk9mA0zCgcDKY=;
  b=B36ueka6dFmDpZJuqHX+BydyLXslZGrPXckuxaNW758oMbzHSprKjd+A
   wl/HSa6j8qRisUjztZ2sqa4353iO2mztDb0byLg7iffJs78PHJ7r/cZzs
   EUo6+PuSFUZrKI5/DmS9u5xdfG4zIyHNTKZD7UbYRUj7MH9XlvyzHVkOP
   zs8j5iy8PKC9eBV63asPmuKepKBJu6IiCFcRBU4zQfUkhwT3Z1X7u2BNT
   oOpTpRuYP4ng7D0QfGhfx58AAYs9Fj0ZfRcT3J3E6bqq+iayJjfJRpIi2
   W180MTdNnPNaNtV9VE8OsiUKff/m5iWBv5Gc4hnHJKpwfBEY2rnSUd2/O
   w==;
X-CSE-ConnectionGUID: lX2dSN37SjiGDxwK1DhYmQ==
X-CSE-MsgGUID: dud4ZTRZTeSmvNEW0SD1tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34537388"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="34537388"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:20:37 -0700
X-CSE-ConnectionGUID: PYPXPQQpTIy1y88LstEC/g==
X-CSE-MsgGUID: kO+HwQB+QaC3/TQa8wzGkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66992212"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.1.253])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 15:20:35 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH v2 2/6] kunit: Add macro to conditionally expose declarations to tests
Date: Tue, 27 Aug 2024 00:20:11 +0200
Message-Id: <20240826222015.1484-3-michal.wajdeczko@intel.com>
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

The DECLARE_IF_KUNIT macro will introduces identifiers only if
CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
no identifiers from the param list will be defined.

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
---
 include/kunit/visibility.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
index 0dfe35feeec6..1c23773f826c 100644
--- a/include/kunit/visibility.h
+++ b/include/kunit/visibility.h
@@ -11,6 +11,13 @@
 #define _KUNIT_VISIBILITY_H
 
 #if IS_ENABLED(CONFIG_KUNIT)
+    /**
+     * DECLARE_IF_KUNIT - A macro that introduces identifiers only if
+     * CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
+     * no identifiers will be defined.
+     * @body: identifiers to be introduced conditionally
+     */
+    #define DECLARE_IF_KUNIT(body...)	body
     /**
      * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if
      * CONFIG_KUNIT is not enabled. Otherwise if CONFIG_KUNIT is enabled
@@ -26,6 +33,7 @@
     #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
 	    EXPORTED_FOR_KUNIT_TESTING)
 #else
+    #define DECLARE_IF_KUNIT(body...)
     #define VISIBLE_IF_KUNIT static
     #define EXPORT_SYMBOL_IF_KUNIT(symbol)
 #endif
-- 
2.43.0


