Return-Path: <linux-kselftest+bounces-16713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B19964DB2
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 20:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF32C1F2202A
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC721B86E0;
	Thu, 29 Aug 2024 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfpMe5GB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0988E15B13D
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956346; cv=none; b=Dlcdhk4drFIuh41APIGCgcj1OZwW7mjjEj1/MCdGF/81RZhWC5QfjPDumvsRSqIdh2KEqikZnEUlLJqbowxob1Oy+JLpWYyEwYxo3aaN1Lalfq4YG/rL87792Ssp3PBDCsc6NTUMtIilD9TU3RHodYftiwWuD3hkMReq0vgvfD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956346; c=relaxed/simple;
	bh=koMco8Mfv2xKq+OjfHQNBwdRPjwI2Lu0LfuitZetlZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rpeePX4JNshqDiJQAway1EjToZysD04aKAhcqjSIbLi1BbJXB+pk7ga1ooo4PSA6Ct0O84layzpMmOajnC9AFrbKZi7QFhCrgB/i1SkFS0+LBcoUyesf/smKwJLY9ZVp/pakG5F2qJA+13k7ei1jKF45Dp9w5W0upeH+bbjZE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfpMe5GB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724956345; x=1756492345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=koMco8Mfv2xKq+OjfHQNBwdRPjwI2Lu0LfuitZetlZ8=;
  b=BfpMe5GBaSItVlIlX+FEX8nvLK67X0vKkej26XS73eZkLthrrCTCTRG2
   vHHv2MfI5Zz+C0xvnV+SextYmHXqvzgMQrthSWNsjPNtpvpqepx0IPf7Q
   pv7PfyaSXt38zZOQb/cn4Q40aQU4/i/mxIHGMQRwZEFAPQu/rj1idxXAn
   EBbINdRNGFuHDbwkSaekDXnxQCngsKq7BACKWWMoPkaSDOKFYvglSzhuc
   2CMbmerMOgd3AQFfXXki8eYZ5na2SkqlvTcYaXSoittWG0yUtThCerSEd
   tKZuY7pVxlVd9FTLoBQ9cTl1zwP/aJKwVxOfyJQQ3sbhdOuDFHdXwgThn
   A==;
X-CSE-ConnectionGUID: O/1VEeKWRhSMkMDIMWRWCg==
X-CSE-MsgGUID: E7FQY6JyQfuJ8NrbnJ2A7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="41050784"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="41050784"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:32:24 -0700
X-CSE-ConnectionGUID: chhUn2gcTV2PgYVhSFI5YQ==
X-CSE-MsgGUID: QjkqTW5/TlORFOg/k8jMJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="64160255"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.245.120.199])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 11:32:22 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>
Subject: [PATCH] kunit: Fix kernel-doc for EXPORT_SYMBOL_IF_KUNIT
Date: Thu, 29 Aug 2024 20:31:50 +0200
Message-Id: <20240829183150.1616-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While kunit/visibility.h is today not included in any generated
kernel documentation, also likely due to the fact that none of the
existing comments are correctly recognized as kernel-doc, but once
we decide to add this header and fix the tool, there will be:

../include/kunit/visibility.h:61: warning: Function parameter or
struct member 'symbol' not described in 'EXPORT_SYMBOL_IF_KUNIT'

Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
---
Cc: Rae Moar <rmoar@google.com>
Cc: David Gow <davidgow@google.com>
---
 include/kunit/visibility.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
index 0dfe35feeec6..efff77b58dd6 100644
--- a/include/kunit/visibility.h
+++ b/include/kunit/visibility.h
@@ -22,6 +22,7 @@
      * EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is
      * enabled. Must use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING)
      * in test file in order to use symbols.
+     * @symbol: the symbol identifier to export
      */
     #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
 	    EXPORTED_FOR_KUNIT_TESTING)
-- 
2.43.0


