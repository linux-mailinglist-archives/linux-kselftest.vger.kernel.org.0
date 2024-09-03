Return-Path: <linux-kselftest+bounces-17048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A53096A106
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 16:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADFDD1C23F48
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2024 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2DE14A092;
	Tue,  3 Sep 2024 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjDPYAXB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695C644C6F;
	Tue,  3 Sep 2024 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374769; cv=none; b=TxRjDNMjxlyV5V6wpZD+wjvOLNDnzt3mLxqmAc7+YkSHNT67I2EUJb+e3COj62sU4yoLwd2nrvUzPS5WavKsUetcFezzrPSrS3EtVbWcbG++i/UufE3FJ2wh+zjqZlWhvx81xCqOiTB3FTNa5sW73tB/mngdBlb+S95GyHqHsZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374769; c=relaxed/simple;
	bh=LPPs4oCE7KV7VBYcHdwrc/ZyvAhlz7OEHNcKcZbEXSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrKWOyRJzeI94IxOMqvUzDb8I8cTt5y6G1+dFXrabmyNT5bQnYOycshehUU5Csb+UVKA+NuT62/jXLVbijbjI8NSwoM0ZAYAKSr8S1nLarJwBsvkCeT6KbLFCjAbQ01WnJ9gmrbmC3rnS1LqbHQ4X85u5kq1941EN8XR6ie4NDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjDPYAXB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725374767; x=1756910767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LPPs4oCE7KV7VBYcHdwrc/ZyvAhlz7OEHNcKcZbEXSg=;
  b=YjDPYAXB/qlr/jHlNrZnjwN5h6f2oLBEQYEfhmwEH3HLaGUbIdV74VK7
   MQRLFsJr5POJMZxp8/JB3V+qZcASY81P39aforw0H+vwvoCMaQgdGzpHm
   2hYK8M7DdSuz4C5puTMthE2kTqQCOuQ5vPKzEgQY5+XMTfMAsGCit5ndk
   +sMeNcQ5L5k0S3fe95HL6mV6BDyV2XqoGcu8hMnYmnwUGWGKTDBHGTgre
   A0MpsQijcAqYzshfbjWM6JCzpMzN+UlzUusxHJjTsIhvfYZq7iBSRr5+E
   MEH4b4mPaZAFswG0YTn/kAzIsFqIq0SH4oQ5nbvjUqezRmxZEXrS2zSvg
   A==;
X-CSE-ConnectionGUID: 2uLYDaAPRVWwdQwrschRFg==
X-CSE-MsgGUID: okHRtK0xT02NZih9qZu4+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24145296"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24145296"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:46:07 -0700
X-CSE-ConnectionGUID: Lz6jqwc2TWGZJM2dqyVeiQ==
X-CSE-MsgGUID: 9yaUN89GQL+P47Z7qrs8Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64577452"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.241])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:46:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 3/4] selftests/x86: don't clobber CFLAGS
Date: Tue,  3 Sep 2024 17:45:27 +0300
Message-Id: <20240903144528.46811-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
References: <20240903144528.46811-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The x86 selftests makefile clobbers CFLAGS preventing lib.mk from
making the necessary adjustments into CFLAGS. This would lead to a
build failure after upcoming change which wants to add -DHAVE_CPUID=
into CFLAGS.

Reorder CFLAGS initialization in x86 selftest. Place the constant part
of CFLAGS initialization before inclusion of lib.mk but leave adding
KHDR_INCLUDES into CFLAGS into the existing position because
KHDR_INCLUDES might be generated inside lib.mk.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v4:
- New patch

 tools/testing/selftests/x86/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5c8757a25998..88a6576de92f 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+CFLAGS := -O2 -g -std=gnu99 -pthread -Wall
+
 all:
 
 include ../lib.mk
@@ -35,7 +37,7 @@ BINARIES_64 := $(TARGETS_C_64BIT_ALL:%=%_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
 
-CFLAGS := -O2 -g -std=gnu99 -pthread -Wall $(KHDR_INCLUDES)
+CFLAGS += $(KHDR_INCLUDES)
 
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)
-- 
2.39.2


