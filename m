Return-Path: <linux-kselftest+bounces-22536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 610479D989A
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 14:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A703164471
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 13:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C833DF49;
	Tue, 26 Nov 2024 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RcSffKCb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F607C13D;
	Tue, 26 Nov 2024 13:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628155; cv=none; b=AVbPmYpJtL6slaWaCMh2+mSDmi0cZgGMzTasmnOwoWRf5NBQhOZaLtEDxJ9WjnbCGJOV/l+c1HD3wHme1zKvQdNbMOvOkmLu1RcebmvhjKCIFizOB1JOO25cbKY9/OT55Q1N3XdllDjL42fPFqWOPfVwWlyM0qFt3QucgKCSOZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628155; c=relaxed/simple;
	bh=cUTsPuulG0PR86MomZ5xmUS1HQzMf2A88KFCnA5xvB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UOW1hlb+9VIF1uIVUXf0FMXUN+uR3K8UnQ7ly8Q5JGr4mWY882zyx31a25edOiH4y42r3n58Ge8SdLTqwPEgAzbmtZPe7M/4/C6WtLeyrM6ju9p4WqwyjXGiMWEsZHKV20rqu3YGDu+T2Q/sPwsD7bgo10FAAxi5mYmqGY1Xm84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RcSffKCb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732628154; x=1764164154;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cUTsPuulG0PR86MomZ5xmUS1HQzMf2A88KFCnA5xvB0=;
  b=RcSffKCb/HEZgCoOZxDrzFFBv+zXdvihHFFupY4g0DowNVtmahe8eiIa
   WiZikmLNetlpsM5tYFWfgwGRDPMbsn7nCKNp4SnUVByGubAs/Th7hiVvr
   Tn455onIDdEXwEph66v6BgZdUmiYipQ9eoy/+BAwqFq/ledy/9RYr4FAt
   ujIWdTnU2cQ6HkQMbv1GEEgZtG0xZjVpr2Dk21RoxUqTpQ95HJCC2A3RS
   75bu0ESGJjxk2c7PZaNhkCO/3jSFt8RPAbQHSnfcY10bYrb8s2HvrQAUZ
   Kf0ZklhdE97v7VCJaXcaXktdrrER47ZaZpAZFus24sLe4GI7eBKUCOe6g
   A==;
X-CSE-ConnectionGUID: E6AmRP1ZQn6PiCoj8cbLbA==
X-CSE-MsgGUID: g+szQH1lTxSB/xBIRr70pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="32727801"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="32727801"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 05:35:08 -0800
X-CSE-ConnectionGUID: TknDDEGaT8eG748zBEGg+g==
X-CSE-MsgGUID: 8GABtZP3R/irwX9tfiy9NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; 
   d="scan'208";a="91782168"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.170])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 05:35:04 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: shuah@kernel.org,
	hpa@zytor.com,
	x86@kernel.org,
	dave.hansen@linux.intel.com,
	bp@alien8.de,
	mingo@redhat.com,
	tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kirill@shutemov.name,
	maciej.wieczor-retman@intel.com
Subject: [PATCH v4 0/3] selftests/lam: get_user additions and LAM enabled check
Date: Tue, 26 Nov 2024 14:34:47 +0100
Message-ID: <cover.1732627541.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent change in how get_user() handles pointers [1] has a specific case
for LAM. It assigns a different bitmask that's later used to check
whether a pointer comes from userland in get_user().

While currently commented out (until LASS [2] is merged into the kernel)
it's worth making changes to the LAM selftest ahead of time.

Modify cpu_has_la57() so it provides current paging level information
instead of the cpuid one.

Add test case to LAM that utilizes a ioctl (FIOASYNC) syscall which uses
get_user() in its implementation. Execute the syscall with differently
tagged pointers to verify that valid user pointers are passing through
and invalid kernel/non-canonical pointers are not.

Also to avoid unhelpful test failures add a check in main() to skip
running tests if LAM was not compiled into the kernel.

Code was tested on a Sierra Forest Xeon machine that's LAM capable. The
test was ran without issues with both the LAM lines from [1] untouched
and commented out. The test was also ran without issues with LAM_SUP
both enabled and disabled.

4/5 level pagetables code paths were also successfully tested in Simics
on a 5-level capable machine.

[1] https://lore.kernel.org/all/20241024013214.129639-1-torvalds@linux-foundation.org/
[2] https://lore.kernel.org/all/20241028160917.1380714-1-alexander.shishkin@linux.intel.com/

Maciej Wieczor-Retman (3):
  selftests/lam: Move cpu_has_la57() to use cpuinfo flag
  selftests/lam: Skip test if LAM is disabled
  selftests/lam: Test get_user() LAM pointer handling

 tools/testing/selftests/x86/lam.c | 122 ++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 5 deletions(-)

-- 
2.47.1


