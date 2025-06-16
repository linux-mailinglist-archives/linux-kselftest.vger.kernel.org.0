Return-Path: <linux-kselftest+bounces-35055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE35AADAB12
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 10:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64303189105A
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 08:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F51211A15;
	Mon, 16 Jun 2025 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwbJx5or"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049E6522F;
	Mon, 16 Jun 2025 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750063682; cv=none; b=VWBE7yK98mD7yYcUdkc6+I8lF39BeYTrLu88VqL0M1ILkhJgedqC4DLfbRN1jUl57VH+Qp5q/8I0Eb5sxJ8iYGdudUW7LBNv9ag3XtmxszBQEe8fP2HLUctaPZ3DusqaqE0niwKwHBD+4Dk9dTJqWh6iU3aRLQ5x6j52Ry7CzLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750063682; c=relaxed/simple;
	bh=ABxPcG6RRfW20RkKqMQhOQXK5M86GqkUcBcJN3JJRhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MA3mio1Jm6+qh2tGJyUrnaxlwPgFBSA7K9iTu4Yj3OEYwxkg9uAOvg4xjZly96JcDPNTj3miSC++/rwikqOIbLm8WDKGw2OSAODNCl5YabVaUks8JbowoRg3KkftEro/sGWw7pQuvzTMUmHthBq4O1pbURIAmqXywMeEKtx1Sdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwbJx5or; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750063682; x=1781599682;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ABxPcG6RRfW20RkKqMQhOQXK5M86GqkUcBcJN3JJRhY=;
  b=SwbJx5ord8FmaZu705n+qbmHewTDGQrz3idfHMEyYxlW1LDu68sOYveh
   yam2Vtzdp+mZOS8QAQxHnwWaLvCLxZry5fiZKAZvsZTjnM2o1fJoz8V8v
   kcURwhHsVgM12QQfaL3aC3nOnzt1b7L3B3XrQ9y1fZCLcPNG8vquazzaI
   6gIoZjDVoQ8chZrVmqmOYA4iJg355914qW9eA3EAgxNhsoVB9e53RZAie
   Xk6IoTPe6UbrBveqICcMS7CbC6CZSKAQtnTl2N5zqxx8bPzblOTJfhrRt
   DwppA3noBODwlEOXaddYZRfSe6xqG02akTIy2Th3+oXG9ZV7QTa54r+Ne
   g==;
X-CSE-ConnectionGUID: wULjngdqT86WdmmnmuMxaw==
X-CSE-MsgGUID: xXkeUqzYR1K9m2z7y0nefg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="51912671"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="51912671"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 01:48:01 -0700
X-CSE-ConnectionGUID: GzQvTa4HT3allmjjapk0tA==
X-CSE-MsgGUID: zXwFLMjjQbOFGQ58ddwGBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="149319583"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.107])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 01:47:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH v1 0/2] kselftest/resctrl: CAT functional tests
Date: Mon, 16 Jun 2025 11:24:51 +0300
Message-Id: <20250616082453.3725-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

In the last Fall Reinette mentioned functional tests of resctrl would
be preferred over selftests that are based on performance measurement.
This series tries to address that shortcoming by adding some functional
tests for resctrl FS interface and another that checks MSRs match to
what is written through resctrl FS. The MSR test is only available for
Intel CPUs at the moment.

Why RFC?

The new functional selftest itself works, AFAIK. However, calling
ksft_test_result_skip() in cat.c if MSR reading is found to be
unavailable is problematic because of how kselftest harness is
architected. The kselftest.h header itself defines some variables, so
including it into different .c files results in duplicating the test
framework related variables (duplication of ksft_count matters in this
case).

The duplication problem could be worked around by creating a resctrl
selftest specific wrapper for ksft_test_result_skip() into
resctrl_tests.c so the accounting would occur in the "correct" .c file,
but perhaps that is considered hacky and the selftest framework/build
systems should be reworked to avoid duplicating variables?


Ilpo Järvinen (2):
  kselftest/resctrl: CAT L3 resctrl FS function tests
  kselftest/resctrl: Add CAT L3 CBM functional test for Intel RDT

 tools/testing/selftests/resctrl/cat_test.c    | 210 ++++++++++++++++++
 tools/testing/selftests/resctrl/msr.c         |  55 +++++
 tools/testing/selftests/resctrl/resctrl.h     |   6 +
 .../testing/selftests/resctrl/resctrl_tests.c |   2 +
 tools/testing/selftests/resctrl/resctrlfs.c   |  48 ++++
 5 files changed, 321 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/msr.c


base-commit: c1d7e19c70cbb8a19f63c190cf53e71b5f970514
-- 
2.39.5


