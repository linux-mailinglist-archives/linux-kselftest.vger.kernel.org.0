Return-Path: <linux-kselftest+bounces-22577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94309DAC8D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 18:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBD4281E2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD9F1FF7DC;
	Wed, 27 Nov 2024 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nb2bf6Mp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9182D66;
	Wed, 27 Nov 2024 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728959; cv=none; b=Tck4m4OUgKAmnVXRvHH/18CtBm8UJnLujLmFGszE+E+6u9XQCBrOnhnJWqrSQIrj9BCtoZf5lLm5I59ev3F5P17GUuJGj0HW7dB2qPH1Zyg0dvKb610p0MqDTlFhTQxAPbn+giVbIz/qJKU/xEcxpTzV6ylxnmipvxnrDIskVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728959; c=relaxed/simple;
	bh=c0zuWt6mdYDjYYy4T74tvlWPLSfnhUIlLQoMx0yS/PY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V1WajU17UEPOE4d3lhecWHdgs2ihpHfF9qsh54V3Rigirb/pKCoDgWYoxWPa8DCEDY0D6w/ySVj3oqfvfHVqt1voxLiTugdapBxkCLkmoxcPmjZVea+YrY3CeOzdhz16oG+CdgbOLE/rDUE5RcnULU0drMyxWQwMyskvl2Y2qYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nb2bf6Mp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732728958; x=1764264958;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c0zuWt6mdYDjYYy4T74tvlWPLSfnhUIlLQoMx0yS/PY=;
  b=Nb2bf6Mp+iIuTvrSSMxlLWBQL5iYLOa+nZilnl922jnMbuZIPf9aCvcJ
   3IqBBQ2Rm8MAGatbI2+FM6+TW4VSOvjx2DtdTTQU6McdcS+uCSEA+U7Lu
   vMc/CAxA7Yu8weMn4cTZ09EZQya45mpy6Fe3RPylBpC9908ak8eZ7uI/I
   se2HPbr06FU86IJ5jbOAoY6/9+m9/rPfz7mNVctRaFANrGhPRBis0oCk7
   21BWbFQu17dCi2DnO6ECyVxf/mgAp+hLek3R7b0NdMsW65fTzGiJVusgz
   NeazTuLBheeju7Wor2XQ2EF3eBs2oZs9UMps/S4gk9iGbsvWNQ3wGNWB0
   w==;
X-CSE-ConnectionGUID: R51cXALtQG+zT3gOYKGHlw==
X-CSE-MsgGUID: +Z1IE9njQiGYFOzQFnhSKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="43607485"
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="43607485"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 09:35:57 -0800
X-CSE-ConnectionGUID: xnuEqC3CSOi221KXmmb9MQ==
X-CSE-MsgGUID: RgpV8uTaS++Kwab9OnAHCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,189,1728975600"; 
   d="scan'208";a="91626318"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.244.193])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 09:35:54 -0800
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
Subject: [PATCH v5 0/3] selftests/lam: get_user additions and LAM enabled check
Date: Wed, 27 Nov 2024 18:35:28 +0100
Message-ID: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
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

 tools/testing/selftests/x86/lam.c | 120 ++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 5 deletions(-)

-- 
2.47.1


