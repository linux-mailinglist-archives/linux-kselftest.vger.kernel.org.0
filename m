Return-Path: <linux-kselftest+bounces-15859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815ED95A034
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 16:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B6A1C2254B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81931B1D71;
	Wed, 21 Aug 2024 14:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGK0gIzr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05519993B
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251406; cv=none; b=CI+Uuxx9pS+9uy8T/aBTDo1mEb+jvxmEOri0bMwGY6uxBU4NiO5ljkJuKO2TRU/DTi8oXYR2ZKD8Ahx/caJa2YUxGc5EOBD1QB/vLjhNPgHs9ZGuTEOzhdlSNRT7lSshJI4Dx0Pa+x4LOzPMosJSaR8dk686LiZINRf06YcRlUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251406; c=relaxed/simple;
	bh=hHZuXR4ttBpdzttniC8/ixePUZct9Us1CSGNSWRzPok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mtu6dpy7YK9uO4aj8Q4Odan8y5V5S69Owa65G2qdT/sawO5if99edIiHWJgade2SI8Et5HWTjXddps5AElubM+NFCqdwCpDf3F7oTu+qXL0er5cMNc/bONzPupArLIvuEca72ElyjTW4UxHTyiU8et1XyWghVqWzWg8UxiDE3Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGK0gIzr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724251405; x=1755787405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hHZuXR4ttBpdzttniC8/ixePUZct9Us1CSGNSWRzPok=;
  b=CGK0gIzrZpV74ebQCQhIpS3dUHQdGadMYUaTtM/ppDJo8Zo8EMqUfIbv
   S+AQmn9A4MniXPuALHPeQx2hoRrE2xcOjzyiIld2+pnHJ8zn520qTjiv0
   eceNIex3fBVXZ8QL/6IKAz4JZaaRRbR7Kc6MjwDKpZTxlbBwce1n33ZKv
   BYFlfI0NYTo4Y94kr/bd8R+Jsj9RnTXxK/yGcKNT47bul6YOeHvBQl6c9
   Gztk9Z7UFyWwKo1VoIumrAVOe3RW/hUfq7VRZzKLzPM1rJQOSysUmigvq
   05aoa5tH0tLUaiIlakmvy8Ufq/szP7Y43QJhunyg19maPwqS+YZbM43zT
   w==;
X-CSE-ConnectionGUID: SQXzMvOjS+SNG3tCo8vVyw==
X-CSE-MsgGUID: krc8QwXTTfOIuXB9bmsj2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22750534"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22750534"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:43:25 -0700
X-CSE-ConnectionGUID: tjy0aE1XTvyNXI6NKyDe2w==
X-CSE-MsgGUID: FZjujS2PT2q+mqFmBkgdgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65316512"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.19.248])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:43:23 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 2/4] kunit: Add macro to conditionally expose declarations to tests
Date: Wed, 21 Aug 2024 16:43:03 +0200
Message-Id: <20240821144305.1958-3-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20240821144305.1958-1-michal.wajdeczko@intel.com>
References: <20240821144305.1958-1-michal.wajdeczko@intel.com>
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
---
Cc: Rae Moar <rmoar@google.com>
Cc: David Gow <davidgow@google.com>
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


