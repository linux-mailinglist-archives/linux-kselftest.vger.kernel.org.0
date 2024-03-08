Return-Path: <linux-kselftest+bounces-6093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD2E876514
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 14:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63C11F213E4
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E82F2209E;
	Fri,  8 Mar 2024 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AraYN6oc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D82A256D;
	Fri,  8 Mar 2024 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709904200; cv=none; b=cliyLGAfmcs+iDuQJQ2PfWsMYJ5N627TnchISEMS8PL8/QaPYGdDfVXDZk91ngo6pFLkuSQFlpuEa5x+KCEVv175/wmMXowMSeKFJ3Rjr4uyo8UBYbx9ZfqkdRqu8odmgWRZ2A+IqjiduzGWOprfWRKYxA6wERGnPecawvhsffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709904200; c=relaxed/simple;
	bh=VDlo6QyC8WPJ+nIOkUcxD/O95WbBhi8FFuUJ57pGDCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N3n4I8mcnH9zyjmxvaclhwT3ZHQq1/M2uzdm2azeqNclnLOpyHUPeWOmXZYQpOkEojrpX1N76NiOA0tKbEionR3ojao+DylC+v0TY/I54CR4We2NXa9JhzgRGhD4S168LNNCgBwRgIOdCyOgLabP17x7g9Nt6ESjlBEAIP4p/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AraYN6oc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709904198; x=1741440198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VDlo6QyC8WPJ+nIOkUcxD/O95WbBhi8FFuUJ57pGDCU=;
  b=AraYN6ocpNBwj6msqsdH3YyhhUIa1TV4pxASSzXHZGIZ+zYyTS8w/e4/
   /7cfd92AxmCIJCcBClUqYf+f6NG54F5bILfaH3l64rmuGExVCoCKHzQF/
   fghYAY/KGKAy65f5BxtydTi1BbUnpLDVJrg3HHypMSUZ9SExRa/c4dMiA
   rN5tfhMzMK58dyNnUVKD01pclRx25m203f3rxK/nmzAp8D9RQIIlC6CkL
   pxpVh9K9QECLEXTIbXCLfs70AoioUUbzuXUtokdIlI9oEG4WGQ+Br7rnJ
   aWivXEdd++TZuk6Nsq3PMs/1niZdBckIOnuqD9v7ACYSmfTmNXazr4gTw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="7568390"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="7568390"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:23:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="47927911"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.186])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:23:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Babu Moger <babu.moger@amd.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/13] selftests/resctrl: resctrl_val() related cleanups & improvements
Date: Fri,  8 Mar 2024 15:22:42 +0200
Message-Id: <20240308132255.14442-1-ilpo.jarvinen@linux.intel.com>
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


