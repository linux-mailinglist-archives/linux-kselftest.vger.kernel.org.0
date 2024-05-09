Return-Path: <linux-kselftest+bounces-9764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1EB8C0AFC
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 07:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065D61F22F3D
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 05:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A7E14A089;
	Thu,  9 May 2024 05:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eBHsIzGp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C17C14A084;
	Thu,  9 May 2024 05:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232829; cv=none; b=ZMwXn/Dy9jagzuEurPCqnvbiOlL1WJj6wEDWIzSaouMC5tsAJ2GtWWnc21uECPFOZmqNKNyxXEuyGeHRMS1c4S9v0Bd5vyGLq1qCESHALs/trMd5zsI9P2SIGf0jkF0K/4bf39op1DDpg4Ua3gS5UTPEJoBITBqNLAcTZQD3loI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232829; c=relaxed/simple;
	bh=3Ex41zxZJpQFqhcvv30eVA/Rdlt84AztCsldCSW3S3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dzuTx9LiMvVxe4YOhR7UZIU3EIGQako/aVTiyUpFZJv3TNr4dE452wRHTbnG30AlP+0guxTM8MwCBO25ql2t2FAsvADDaqjj9fNQ29C1309z/ke9VKACyCszQ0LtJIHJyPJOzriDMQEWpaM+n2AK1ytzsuDtBBiwpMrw0zsmVtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eBHsIzGp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715232828; x=1746768828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3Ex41zxZJpQFqhcvv30eVA/Rdlt84AztCsldCSW3S3I=;
  b=eBHsIzGpKNzKzVY0K0haB6R9KzR2tsNUXkzct5Gfp5x0GWP+vaGOfjap
   r4X8Ck2q1jSq3uDD7Q0oqGfM+sX4+lQjtIG/oFZCkrBfeQCex+55bkhFp
   YSpMEGcFhzgEsrYI5DJPqwJNu5+6/r8vUo0OX5NJNKObgVug/MaViv9wH
   FU/BK8xu/36H00lzmirjXblGTQw46H7C/6hiviw2App8oSauMYnZTFYCF
   Jc/gfm7VDVAmztTgfuHussJCvzimmC7amEOhMcEB39egER82TuJ+uzFg8
   zZlkSKvGhPGwHdo/VHZ2qxlzfoE9GsEpE0nB8YPGFxjwCByGCwPR86tzz
   Q==;
X-CSE-ConnectionGUID: ebsSsMhtQn685BEadfVuMg==
X-CSE-MsgGUID: VN13pNzFRceOlZCPJx3hZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="11286345"
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="11286345"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 22:33:48 -0700
X-CSE-ConnectionGUID: bFeud+yySzylKh5uE2BOpQ==
X-CSE-MsgGUID: ajvf2dKpQh6BItEGgn+qsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,146,1712646000"; 
   d="scan'208";a="66558870"
Received: from unknown (HELO st-server.bj.intel.com) ([10.240.193.102])
  by orviesa001.jf.intel.com with ESMTP; 08 May 2024 22:33:42 -0700
From: Tao Su <tao1.su@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-sgx@vger.kernel.org
Cc: akpm@linux-foundation.org,
	edliaw@google.com,
	ivan.orlov0322@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shuah@kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	bongsu.jeon@samsung.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alexandre.belloni@bootlin.com,
	jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	tao1.su@linux.intel.com
Subject: [PATCH v2 0/2] Selftests: Fix compilation warnings due to missing _GNU_SOURCE definition
Date: Thu,  9 May 2024 13:31:11 +0800
Message-Id: <20240509053113.43462-1-tao1.su@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since kselftest_harness.h introduces asprintf()[1], many selftests have
compilation warnings or errors due to missing _GNU_SOURCE definitions.

The issue stems from a lack of a LINE_MAX definition in Android (see
commit 38c957f07038), which is the reason why asprintf() was introduced.
We tried adding _GNU_SOURCE definitions to more selftests to fix, but
asprintf() may continue to cause problems, and since it is quite late in
the 6.9 cycle, we would like to revert 809216233555 first to provide
testing for forks[2].

[1] https://lore.kernel.org/all/20240411231954.62156-1-edliaw@google.com
[2] https://lore.kernel.org/linux-kselftest/ZjuA3aY_iHkjP7bQ@google.com

v1 -> v2:
- Stop defining _GNU_SOURCE in related selftests
- Revert commit 809216233555
- Use 1024 in place of LINE_MAX to fix 38c957f07038

v1: https://lore.kernel.org/all/20240507063534.4191447-1-tao1.su@linux.intel.com/

Tao Su (2):
  Revert "selftests/harness: remove use of LINE_MAX"
  selftests/harness: Use 1024 in place of LINE_MAX

 tools/testing/selftests/kselftest_harness.h | 11 +++--------
 tools/testing/selftests/mm/mdwe_test.c      |  1 -
 2 files changed, 3 insertions(+), 9 deletions(-)


base-commit: 45db3ab70092637967967bfd8e6144017638563c
-- 
2.34.1


