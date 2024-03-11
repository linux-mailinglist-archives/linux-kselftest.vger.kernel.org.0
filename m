Return-Path: <linux-kselftest+bounces-6188-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E88780F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 14:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447F71F23237
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Mar 2024 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26493F8DA;
	Mon, 11 Mar 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBI0Af/A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055BA33070;
	Mon, 11 Mar 2024 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165174; cv=none; b=hH4cwAD8kV6/EgXFYpq8bkN5KzWoxjC6uQMeQIbBTGroChXIx5IBUuSeaIb/13/hDnZf/4n2ccU2UNmLjVtaQnR7aQfdLchA8cMJwNpnPJdmhOzpkUh1Gs3xpBYTsNUt8sMFlu9XIFCaVtK7Ckw2FACK5F4LbCfoiylKBV7ntKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165174; c=relaxed/simple;
	bh=ogDW4usrkBQKvu63zZhNHxHlG4aF4TlGEfKwECbLXEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RI4Xyc36CgMLd6twge1KVT5YF6RNUX/I0gy8+oc/dc64pbvccGDavRpKmFzZsrB+/1bh4dcjbHg/hvw8IROX5W/wXcglzAmrKNNHIbbGIm2+9VgWykfyQW2benk0Q1CsxpA6x/qcvTZc2wCuasnLnUMwl5KkClPCpDgnioPwI40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBI0Af/A; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710165173; x=1741701173;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ogDW4usrkBQKvu63zZhNHxHlG4aF4TlGEfKwECbLXEM=;
  b=WBI0Af/Ad++C9a8AebTOJqWeOouvKOdktk0H9zMExHdoITmPrTIUoXTF
   ZF1gdDnTtN2X66T1GH6jnsMUU1W2m4WHQ6lhiQD9pFDl9IvRyYblL7rew
   FRUYY4qjjA1wJyn3J2J8rNixiNE5aaWj/G+lbLQ1YPpdXSRH6kuuv3ey9
   DB6XYFahZfEKDdrSrustsVb+IMyibB4kZYZb6g/xU5zORyCfDH2t5Do6V
   vsHxe5q/Camd0sgrcCG0PIUK/VBT/pJGQ1akWNl/mIEqqrA0FZqbJCBTS
   tb8xStMtzMU9+NJO47IMHwwXhKlFi6/lK3ugx7TkhRE1ZE1zr0oMisily
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="15388670"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="15388670"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="11166577"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 06:52:44 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 00/13] selftests/resctrl: resctrl_val() related cleanups & improvements
Date: Mon, 11 Mar 2024 15:52:17 +0200
Message-Id: <20240311135230.7007-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This series does a number of cleanups into resctrl_val() and
generalizes it by removing test name specific handling from the
function.

One of the changes improves MBA/MBM measurement by narrowing down the
period the resctrl FS derived memory bandwidth numbers are measured
over. My feel is it didn't cause noticeable difference into the numbers
because they're generally good anyway except for the small number of
outliers. To see the impact on outliers, I'd need to setup a test to
run large number of replications and do a statistical analysis, which
I've not spent my time on. Even without the statistical analysis, the
new way to measure seems obviously better and makes sense even if I
cannot see a major improvement with the setup I'm using.

This series has some conflicts with SNC series from Maciej and also
with the MBA/MBM series from Babu.

--
 i.

v2:
- Resolved conflicts with kselftest/next
- Spaces -> tabs correction

Ilpo Järvinen (13):
  selftests/resctrl: Convert get_mem_bw_imc() fd close to for loop
  selftests/resctrl: Calculate resctrl FS derived mem bw over sleep(1)
    only
  selftests/resctrl: Consolidate get_domain_id() into resctrl_val()
  selftests/resctrl: Use correct type for pids
  selftests/resctrl: Cleanup bm_pid and ppid usage & limit scope
  selftests/resctrl: Rename measure_vals() to measure_mem_bw_vals() &
    document
  selftests/resctrl: Add ->measure() callback to resctrl_val_param
  selftests/resctrl: Add ->init() callback into resctrl_val_param
  selftests/resctrl: Simplify bandwidth report type handling
  selftests/resctrl: Make some strings passed to resctrlfs functions
    const
  selftests/resctrl: Convert ctrlgrp & mongrp to pointers
  selftests/resctrl: Remove mongrp from MBA test
  selftests/resctrl: Remove test name comparing from
    write_bm_pid_to_resctrl()

 tools/testing/selftests/resctrl/cache.c       |   6 +-
 tools/testing/selftests/resctrl/cat_test.c    |   5 +-
 tools/testing/selftests/resctrl/cmt_test.c    |  21 +-
 tools/testing/selftests/resctrl/mba_test.c    |  34 ++-
 tools/testing/selftests/resctrl/mbm_test.c    |  33 ++-
 tools/testing/selftests/resctrl/resctrl.h     |  48 ++--
 tools/testing/selftests/resctrl/resctrl_val.c | 269 ++++++------------
 tools/testing/selftests/resctrl/resctrlfs.c   |  55 ++--
 8 files changed, 224 insertions(+), 247 deletions(-)

-- 
2.39.2


