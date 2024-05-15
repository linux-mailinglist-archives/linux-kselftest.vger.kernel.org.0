Return-Path: <linux-kselftest+bounces-10254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5C38C6565
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 13:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2481AB20E10
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 11:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671D6664C6;
	Wed, 15 May 2024 11:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VKbFsqTn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C7163511;
	Wed, 15 May 2024 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715771905; cv=none; b=MH3sbQHju0wV5pluh7sh1Or55ekVQ40y4oHFJwLq8XaYL0imloMjZ9GGy15yMEsKQx59feNfHPlYb5pC6hEPnq6cXHKy04WLHRVHJpiCV5AHgldfXiLEs+a9+EgSGZRkHdKzPGFhqoWNGhQtMXEUNlzse44RXaAAu/fXRRaLx9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715771905; c=relaxed/simple;
	bh=VJ6A8qhCWtdctbJft4NMBOXHwXvW0/27z0AwmEqovG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhBIyCD7ztK7oWn4uS+CsSh4wyQWOZGq6W0Y2Cg17xl0fnqRrqAGbJaOdssBgBWCUVgPbK7Sh3ni8d3R+E14ewnabk7kfMv4Fzi3bk+v50FKpz9ZyKI1CCRePY6G8D9I2o0AtWZe7dkvOzVKoHqE/Pk8LrpcpVbmk4UrPcD718E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VKbFsqTn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715771904; x=1747307904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VJ6A8qhCWtdctbJft4NMBOXHwXvW0/27z0AwmEqovG8=;
  b=VKbFsqTnQIdk8XSDJ3K+Y8XpU1rOWhge8opctKIn5cbVZu1DgwfhcWJE
   Dl3c3HjinGkprbdGA94kJTpLe58Oo96NxzDdb6HLwrdIG8Oakh9AUd7gA
   +AS6DUq51SUX/0DoMyKTXDpFRtzoTy2ES271DfmK3pGRswQVGJnojXhyZ
   05DpyhWc9+qhQeJuJqbdTnLDivDx4XgzjrMpZMZWODlRHOf9w2L8C0Qo+
   Ai5Vu1s2+Ljl9S4MROIWthV+yuB6VYVKeao2KhLMAgB3EZ/SJjnEH/1fr
   AgG0ANL3DKO1CgcRhrApiSRnsiF0BvdE3+a4MY2cC9lM0oVq/QmTJ3vdF
   Q==;
X-CSE-ConnectionGUID: atrZUZD+SruKkrpRLXj8eg==
X-CSE-MsgGUID: qhH6Zca4SjWiArQAlQI4Zw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="29305066"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="29305066"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 04:18:23 -0700
X-CSE-ConnectionGUID: 7tqDk9C+THe11S106FEQCw==
X-CSE-MsgGUID: FrM0xDsMSkWDBpqh96tvPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="35900916"
Received: from unknown (HELO wieczorr-mobl1.intel.com) ([10.245.245.148])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 04:18:20 -0700
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	reinette.chatre@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH v2 0/2] selftests/resctrl: SNC kernel support discovery
Date: Wed, 15 May 2024 13:17:39 +0200
Message-ID: <cover.1715769576.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes v2:
- Removed patches 2 and 3 since now this part will be supported by the
  kernel.

Sub-Numa Clustering (SNC) allows splitting CPU cores, caches and memory
into multiple NUMA nodes. When enabled, NUMA-aware applications can
achieve better performance on bigger server platforms.

SNC support in the kernel is currently in review [1]. With SNC enabled
and kernel support in place all the tests will function normally. There
might be a problem when SNC is enabled but the system is still using an
older kernel version without SNC support. Currently the only message
displayed in that situation is a guess that SNC might be enabled and is
causing issues. That message also is displayed whenever the test fails
on an Intel platform.

Add a mechanism to discover kernel support for SNC which will add more
meaning and certainty to the error message.

Series was tested on Ice Lake server platforms with SNC disabled, SNC-2
and SNC-4. The tests were also ran with and without kernel support for
SNC.

Series applies cleanly on kselftest/next.

[1] https://lore.kernel.org/all/20240503203325.21512-1-tony.luck@intel.com/

Previous versions of this series:
[v1] https://lore.kernel.org/all/cover.1709721159.git.maciej.wieczor-retman@intel.com/

Maciej Wieczor-Retman (2):
  selftests/resctrl: Adjust effective L3 cache size with SNC enabled
  selftests/resctrl: Adjust SNC support messages

 tools/testing/selftests/resctrl/cat_test.c  |   2 +-
 tools/testing/selftests/resctrl/cmt_test.c  |   6 +-
 tools/testing/selftests/resctrl/mba_test.c  |   2 +
 tools/testing/selftests/resctrl/mbm_test.c  |   4 +-
 tools/testing/selftests/resctrl/resctrl.h   |   8 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 131 +++++++++++++++++++-
 6 files changed, 144 insertions(+), 9 deletions(-)

-- 
2.45.0


