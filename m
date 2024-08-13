Return-Path: <linux-kselftest+bounces-15204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F24019502C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 12:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87641F228D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BF9170A0E;
	Tue, 13 Aug 2024 10:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IeFnZ4iO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF48BF3;
	Tue, 13 Aug 2024 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545931; cv=none; b=RmvLj4cGIewJje2biS9EC7SVLgtPRWgAOloqCNZXKyadRmZP0T8k86ew2reCIkc6rOi1GFS6RcFf1uQjnLkiUkHxLzMW2V8njlmsrYWHH+QQAx+rbyD//nv1mMJ5WuzNcv641bojv6JLrMFU4kHe8QtBQkQj49dVkKlqRI7cP38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545931; c=relaxed/simple;
	bh=GtoxJigfolH+oBAORYGKJfvd4tmm1qFKK/TAlO/6ZUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=gFqZfrSP0rUtUXoBcvf2gpOQ31hUOlxo9odibOKJWWJ1YkIiL9vPXTULarp9Ge19qBxws/Xtc2RROWFi/Azsx46I96NizDLq1PTjO/rOIr/3JDHSIt2Mg80Ju6fWnuprVuwedneuwTfdb+7ExsDGV9mJVGMDvFSaClZeL3v1CcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IeFnZ4iO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723545929; x=1755081929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GtoxJigfolH+oBAORYGKJfvd4tmm1qFKK/TAlO/6ZUs=;
  b=IeFnZ4iO1KSJWpE4LubUx6iwR1k4E0Uj7tgLFfHYZeg1MvU6Bd4svkmF
   omQ6ffT7DF/Lzk4giMj+mHM8OzI1B9i3ePWQpd9uOVl67plbJbJzmTKUe
   tdGJGuPwR95lD+q81jdMwZMiaHvKoMohCaSvJ36wKva8sTKAtDEcts+yw
   Sx9cXtjZoumTeFM54pL+ZASosHUiuxNmc3R+rIMNBT5LM2DEZ+jPma+yP
   NnPR0k0/uvcb0zO23jJf9cTjOFFXlTZSy6up/ZzbFyESxImLMehqkwqCQ
   PkhFWHqHM8XTroxs7abGgclQ5C3WbDIRRxEC+OmCVaaQk3srDii2HJ4Do
   w==;
X-CSE-ConnectionGUID: Q76JhZD2Qxe03nhqkSJDvg==
X-CSE-MsgGUID: zJ6/QD3WTfOK8z9jk1Y4gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="39148345"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="39148345"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:45:28 -0700
X-CSE-ConnectionGUID: joqqMooTTTWl/5wP+yR53Q==
X-CSE-MsgGUID: Yc7QpMtsRiKJrTbxtivdog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="62786910"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.153])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 03:45:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Shuah Khan <shuah@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] selftests: Fix cpuid / vendor checking build issues
Date: Tue, 13 Aug 2024 13:45:12 +0300
Message-Id: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

First, generalize resctrl selftest non-contiguous CAT check to not
assume non-AMD vendor implies Intel. Second, improve kselftest common
parts and resctrl selftest such that the use of __cpuid_count() does
not lead into a build failure (happens at least on ARM).

The last patch might still require some work on which symbol the
conditional in kselftest.h is implemented. I could not find any
pre-existing one that could be used. Perhaps somebody who's more
familiar with the kselftest build system has a better suggestion on
which symbol the logic should be based at?

Ilpo Järvinen (3):
  selftests/resctrl: Generalize non-contiguous CAT check
  selftests/resctrl: Always initialize ecx to avoid build warnings
  [RFC] kselftest: Provide __cpuid_count() stub on non-x86 archs

 tools/testing/selftests/kselftest.h        |  6 +++++
 tools/testing/selftests/lib.mk             |  4 ++++
 tools/testing/selftests/resctrl/cat_test.c | 28 +++++++++++++---------
 3 files changed, 27 insertions(+), 11 deletions(-)

-- 
2.39.2


