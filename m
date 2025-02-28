Return-Path: <linux-kselftest+bounces-27832-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5728A491D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 08:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7EE116E630
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 07:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619EC1BC09F;
	Fri, 28 Feb 2025 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EqoTNJSL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A7F748F;
	Fri, 28 Feb 2025 07:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726049; cv=none; b=TGnqwIhhAnhm1kLIb114h1oCCnVzoRH4/iXLKIzr2KZI3MMCsdYmH5T+HsZTX3hlGEB0DP6xU6kQqPZGvTCEhzTIQEuT2c6nw+JZvGgM+Aa5GZrxjOIR0mtq0dFnrzaqX+pu3ayFXmmE1GS3HgYo0b2WPQ9UH8Y7BDnkBRGJWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726049; c=relaxed/simple;
	bh=dQNvjTamf5GlF20dGkFjAAXv0agz86HZnKYfFngHYPo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A1ZDvLimzoOvkUuccsNF5/atdH5K33i9pReJtc8QuuPPZ2SqVmjb2q5+BKd2D/2X0KbVYxmY93z3ihjdnVG+O4EMAsiPEnx0iicmE4vIc+/pl5vVTBk0CrobAw3Y9baRLd/AwjBw+sDo3bXRFHNgLjWDEajLS+ZjRkXhtwAgm+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EqoTNJSL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740726047; x=1772262047;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dQNvjTamf5GlF20dGkFjAAXv0agz86HZnKYfFngHYPo=;
  b=EqoTNJSLWy2DwNog8MzK3gHeLsDA4O+YZySv6E+3UHgrMOYDYcFtiCsJ
   OcLItND1pCnNABkpA8Qb2oa2l4CYEBrqthw94dgFQDJoMuikFphApUCzk
   TY3/vTimWMpoz6wA1vr5cew+j3szQup38gYZFnW6AhhNHG6LNfMKNTyQW
   6g5UNCxPSWakTd9T1jv4sKy4+Ui36iE2Ag7qK2PNbUWOxDxjoFZ1ptnQ4
   wqvB9qqncj6Tg8i3l16XA3+0q9SByMw7OVKDiU6b1pppCyxK3IaNZ1cit
   h3tcD6a+OGJv2koLKCDEZb5SCKSeADxNmRjGQws7iI42R0TktHVxRfb0s
   Q==;
X-CSE-ConnectionGUID: YCTBF+w9RgGHKg8ie20m8A==
X-CSE-MsgGUID: 9jgPL5+cT+2gi1h8a4c+HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="53036905"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="53036905"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:00:46 -0800
X-CSE-ConnectionGUID: lSsC+kxQS5yrBN4jxgVlyA==
X-CSE-MsgGUID: 24pGiSQJShutApx1DNI7tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="117227717"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.161.23])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:00:45 -0800
Date: Fri, 28 Feb 2025 15:00:59 +0800
From: Yi Lai <yi1.lai@intel.com>
To: ilpo.jarvinen@linux.intel.com, shuah@kernel.org, bhelgaas@google.com,
	Jonathan.Cameron@huawei.com, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yi1.lai@intel.com
Subject: [PATCH] selftests/pcie_bwctrl: Add "set_pcie_speed.sh" to TEST_PROGS
Message-ID: <Z8FfK8rN30lKzvVV@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The test shell script "set_pcie_speed.sh" is not installed in
INSTALL_PATH. Attempting to execute set_pcie_cooling_state.sh shows
warning:

"
./set_pcie_cooling_state.sh: line 119: ./set_pcie_speed.sh: No such file or directory
"

Add "set_pcie_speed.sh" to TEST_PROGS.

Fixes: 838f12c3d551 ("selftests/pcie_bwctrl: Create selftests")
Signed-off-by: Yi Lai  <yi1.lai@intel.com>
---
 tools/testing/selftests/pcie_bwctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pcie_bwctrl/Makefile b/tools/testing/selftests/pcie_bwctrl/Makefile
index 3e84e26341d1..48ec048f47af 100644
--- a/tools/testing/selftests/pcie_bwctrl/Makefile
+++ b/tools/testing/selftests/pcie_bwctrl/Makefile
@@ -1,2 +1,2 @@
-TEST_PROGS = set_pcie_cooling_state.sh
+TEST_PROGS = set_pcie_cooling_state.sh set_pcie_speed.sh
 include ../lib.mk
-- 
2.39.2


