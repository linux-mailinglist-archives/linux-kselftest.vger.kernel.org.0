Return-Path: <linux-kselftest+bounces-5022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B16585BCEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 14:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8357BB20D39
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D329C6A02F;
	Tue, 20 Feb 2024 13:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxC/GN9G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889C6A323;
	Tue, 20 Feb 2024 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434860; cv=none; b=Vusyggcgyge1fQB0WSjoZjE43ZnfYIBnY3hFjryisc0pMJ+XEOAAd4PL9C3Hml32P0M4m00PdFRUGGlAfK9VjikbsHo0kcKsIpgp4hEXQ071KejDuNFJ2R0mY2ixYJXpb3s84Bo45KPQxeR/ORw/k1AcjD0j87GzytYlk7yWQi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434860; c=relaxed/simple;
	bh=KD8hrMdNCTWfLGe97FVEEX2aWGI4paDsXVz9quv/wPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bhc7JWsIPcpsQ9fd39Mpp1W8k2Lt7k4/94WAL33VJXG0exTFqpCMqFm6fIRGJiatjhGvIHj/tA9vbFxKiirEx3r4UGX1ri2PjQXtKkyEtMiB/HcMrCcMRn1oRZXad9kLqD97sL5L9IjTW6r23+r6gyhXojFCq+6ulnkBAlWNaj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxC/GN9G; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708434859; x=1739970859;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KD8hrMdNCTWfLGe97FVEEX2aWGI4paDsXVz9quv/wPk=;
  b=HxC/GN9G1b4P31bcLT0O/nS7OqrRHJII0vZ00FLi7UsFB649TfCqRX3u
   dw5AfZMYNp3yGRBh+qcNvpI07ayGD4GkawlRV9XxUXczH4wA1hQAJMEs3
   8+k85NMWRCwgsliSrRnVPlIoEH2OhSPGSZlWfvNcgdVs8lHl+o5pe5BKr
   /h7+DY9zHJPvxDSfM1BYs9iln9GND5cbbM1PyxbDNzJwRDmPsuCnsyltj
   qTZr1ZpAEQKm0wWFxKZ0teoeQhECMYq841vlyzEELsb7VI/xa2R0OViiC
   yI61H5uXAmDNlqtqOCzS/d0sv8X/TGsMgFhxum76g0kT8J3Acpit5eM0e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="6308538"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="6308538"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:14:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="9415353"
Received: from jmuniak-mobl.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.4.63])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:14:15 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	reinette.chatre@intel.com,
	fenghua.yu@intel.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH 0/3] selftests/resctrl: Simplify test cleanup functions
Date: Tue, 20 Feb 2024 14:14:05 +0100
Message-ID: <cover.1708434017.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleaning up after tests is implemented separately for individual tests
and called at the end of each test execution. Since these functions are
very similar and a more generalized test framework was introduced a
function pointer in the resctrl_test struct can be used to reduce the
amount of function calls.

These functions are also all called in the ctrl-c handler because the
handler isn't aware which test is currently running. Since the handler
is implemented with a sigaction no function parameters can be passed
there but information about what test is currently running can be passed
with a global variable.

Maciej Wieczor-Retman (3):
  selftests/resctrl: Add cleanup function to test framework
  selftests/resctrl: Simplify cleanup in ctrl-c handler
  selftests/resctrl: Move cleanups out of individual tests

 tools/testing/selftests/resctrl/cat_test.c    |  5 ++---
 tools/testing/selftests/resctrl/cmt_test.c    |  4 ++--
 tools/testing/selftests/resctrl/mba_test.c    |  5 ++---
 tools/testing/selftests/resctrl/mbm_test.c    |  5 ++---
 tools/testing/selftests/resctrl/resctrl.h     |  8 +++----
 .../testing/selftests/resctrl/resctrl_tests.c | 22 ++++++++++---------
 tools/testing/selftests/resctrl/resctrl_val.c |  2 +-
 7 files changed, 25 insertions(+), 26 deletions(-)

-- 
2.43.2


