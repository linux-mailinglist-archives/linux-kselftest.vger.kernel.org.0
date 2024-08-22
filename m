Return-Path: <linux-kselftest+bounces-16021-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E744095AFF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 10:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83403B21751
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 08:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA8716FF45;
	Thu, 22 Aug 2024 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="na8HAUkz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837A16EBE6;
	Thu, 22 Aug 2024 08:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724314315; cv=none; b=dlk4744DwHYUklC+Dp2kHr6mYyQ80BR/l7dPE9eNkSTbWYOvKYv4sDTLIUYkz0czbabt4cCFRTcu/+thZRifL4W+BrISE8pPbefv5kYBLGTf4+PteMhzUqYVWmTnZx5YnWqNAL/USy6YwFVV06fcvPMBiUbOMh+d5k9TTkkt0BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724314315; c=relaxed/simple;
	bh=jueb454TERTVCWsLfjdv2dFk/7r0IoJNFEqiGgYJD5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Mk1pAVhqyfPXjbQwla6SUuTiIFS7zXY67XKDY7mNcla9JhFvRtItUfkIaeJbBKeYXRP00uBmf4Fz96uO7o/XnlTwghrZL/2Fvt1M/RBr/omi7KoS6hK2Geprvu2vhd7FqGAThucvLWcdSrnBShXTKqPc6QpeI2HjnqSYRp0mEGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=na8HAUkz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724314313; x=1755850313;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jueb454TERTVCWsLfjdv2dFk/7r0IoJNFEqiGgYJD5Y=;
  b=na8HAUkzyqgDl8AeQ+tb/b1H4NsAh/ZrK0nPmm69D4SvOqlLX8X8iDtE
   hNarZOz7c39xCaByRzar0KJJGh+v/2pi97cmHmY9nIUptoilLNE1yDSGN
   OCrCrvUz4SENgFDG9VwN5E2XJsHbiFFcTG0dah8Fha9UMPfc0WzH0R8k0
   jdwxdEs08terThP8Jz6xJjH4VIiYU1Z1UQY2WHFi4sXeRf0JMfBh8wvzp
   xdk3TmzZMoU/RGUrCYUVKojoAdmbhteArRevSyMqswYiO01TvYiVmlRqI
   9OqhRwrptJR+vxIgfY/K7Gd5uGs6xeEibup4um9SIP0Th59lhrDFVu+JB
   A==;
X-CSE-ConnectionGUID: TB294CfYSZ2YtTncqgV9YQ==
X-CSE-MsgGUID: eyZlJy1uQNanRRxunhxSRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33331676"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="33331676"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:11:47 -0700
X-CSE-ConnectionGUID: Ixazv04uQn+09/MSy9tTPQ==
X-CSE-MsgGUID: E+YUPw2WSUa1+3GHk16rJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="66052792"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 01:11:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 0/3] selftests: Fix cpuid / vendor checking build issues
Date: Thu, 22 Aug 2024 11:11:11 +0300
Message-Id: <20240822081114.4695-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series first generalizes resctrl selftest non-contiguous CAT check
to not assume non-AMD vendor implies Intel. Second, it improves
kselftest common parts and resctrl selftest such that the use of
__cpuid_count() does not lead into a build failure (happens at least on
ARM).

While ARM does not currently support resctrl features, there's an
ongoing work to enable resctrl support also for it on the kernel side.
In any case, a common header such as kselftest.h should have a proper
fallback in place for what it provides, thus it seems justified to fix
this common level problem on the common level rather than e.g.
disabling build for resctrl selftest for archs lacking resctrl support.

v2:
- Removed RFC from the last patch & added Fixes and tags
- Fixed the error message's line splits
- Noted down the reason for void casts in the stub

Ilpo Järvinen (3):
  selftests/resctrl: Generalize non-contiguous CAT check
  selftests/resctrl: Always initialize ecx to avoid build warnings
  kselftest: Provide __cpuid_count() stub on non-x86 archs

 tools/testing/selftests/kselftest.h        |  6 +++++
 tools/testing/selftests/lib.mk             |  4 ++++
 tools/testing/selftests/resctrl/cat_test.c | 28 +++++++++++++---------
 3 files changed, 27 insertions(+), 11 deletions(-)

-- 
2.39.2


