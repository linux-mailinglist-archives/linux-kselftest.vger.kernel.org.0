Return-Path: <linux-kselftest+bounces-5991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A1787346F
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 11:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DF331C20C80
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48FA604D6;
	Wed,  6 Mar 2024 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0Oeeb/c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024475D75E;
	Wed,  6 Mar 2024 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721537; cv=none; b=ZgaptmA4mZX+tennCm6eNC5Bbbe+DgLF7s3nd2azmvkAXOwxYidg49YZjz1QqxW29BE6lXwjtAovmvgWi7eCeKx+7pTGhn+B9hEnk8yt2gVbnHvubDglHCjD8KeYAn7z3C16Qn8fvq27niwwigaZY+/G+42t7wCUrJ5xEVpu3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721537; c=relaxed/simple;
	bh=r0STAe9hlRR6y5SgsGZsrkhln+sTjnj9/ZohlOVMJLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IAoO0DoGdCgEwLa3vBROuqCVQJ69JCCWmYhfJPDC1AE3jaV48pyiO6ojZ4/N0pbQo8F/8Vz/6dYDQr4ZIvLIVFJPPFf7isZLW6CuBN9lBrFdzJ38ajj4vtT+oHGQ6ry/4GTBVelE9szn7RJbJ/Ociqk7Amqt8iLNk4R/RRvEfwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0Oeeb/c; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709721536; x=1741257536;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=r0STAe9hlRR6y5SgsGZsrkhln+sTjnj9/ZohlOVMJLk=;
  b=P0Oeeb/cIV4B3uJHx80rhveCxj/4jS5iTs/Qh8Ik1noXujt1OR/yo0pg
   698rmZ83Uqie1vNs6XOmbzp7SSZ7A3xZmAlQ1y1Ghp1LW6gYSfbbf4rVw
   +wfMGVflX7mAERNS08DdOe4O7AOeN/Ot9lAjLohN9nEVh4v4OJYjdTq3J
   r/6uVBtIppM91cVb+uqp8dDnERsMylNIgbN/1hrsIQZGNC8pQgFdmJJIo
   0Wi10QPva8ON49nIaGiqnZeAhgCT5QRfWVjftVBm85KnN/zUEYV+fVECn
   c1CCR/haMKjRK/d9cQMvmeNlU27w4UnImcYInZheZ4UUGyti7AD7azL/N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4177838"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4177838"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:38:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="40697585"
Received: from ksznyce-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.25.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 02:38:50 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	reinette.chatre@intel.com,
	fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	tony.luck@intel.com
Subject: [PATCH 0/4] SNC support for resctrl selftests
Date: Wed,  6 Mar 2024 11:38:32 +0100
Message-ID: <cover.1709721159.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sub-Numa Clustering (SNC) allows splitting CPU cores, caches and memory
into multiple NUMA nodes. When enabled, NUMA-aware applications can
achieve better performance on bigger server platforms.

The series adding SNC support to the kernel is currently in review [1]
but the selftests for resctrl need NUMA-aware adjustments to use these
changes. Issues with resctrl selftests not working properly with SNC
enabled were originally reported by Shaopeng Tan [2][3] and the
following series resolves them.

The main concept currently missing from resctrl selftests is that while
resctrl tracks memory accesses on a single NUMA node (which normally is
the same as the CPU socket) on machines with SNC enabled memory accesses
can leak outside of the local NUMA node and into other NUMA nodes on the
same socket. In that case resctrl could report a diminished value in one
of its monitoring technologies: Cache Monitoring Technology (CMT) or
Memory Bandwidth Monitoring (MBM) .

Implemented solutions for both CMT and MBM follow the same idea which is
to simply sum values reported by different NUMA nodes for a single
Resource Monitoring ID (RMID).

Series was tested on Ice Lake server platforms with SNC disabled, SNC-2
and SNC-4. The tests were also ran with and without kernel support for
SNC.

Series applies cleanly on kselftest/next.

[1] https://lore.kernel.org/all/20240228112215.8044-tony.luck@intel.com/
[2] https://lore.kernel.org/all/TYAPR01MB6330B9B17686EF426D2C3F308B25A@TYAPR01MB6330.jpnprd01.prod.outlook.com/
[3] https://lore.kernel.org/lkml/TYAPR01MB6330A4EB3633B791939EA45E8B39A@TYAPR01MB6330.jpnprd01.prod.outlook.com/

Maciej Wieczor-Retman (4):
  selftests/resctrl: Adjust effective L3 cache size with SNC enabled
  selftests/resctrl: SNC support for CMT
  selftests/resctrl: SNC support for MBM
  selftests/resctrl: Adjust SNC support messages

 tools/testing/selftests/resctrl/cache.c       |  17 ++-
 tools/testing/selftests/resctrl/cat_test.c    |   2 +-
 tools/testing/selftests/resctrl/cmt_test.c    |   6 +-
 tools/testing/selftests/resctrl/mba_test.c    |   3 +-
 tools/testing/selftests/resctrl/mbm_test.c    |   4 +-
 tools/testing/selftests/resctrl/resctrl.h     |  13 +-
 tools/testing/selftests/resctrl/resctrl_val.c |  46 ++++---
 tools/testing/selftests/resctrl/resctrlfs.c   | 128 +++++++++++++++++-
 8 files changed, 185 insertions(+), 34 deletions(-)

-- 
2.44.0


