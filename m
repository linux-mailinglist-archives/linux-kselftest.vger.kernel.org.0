Return-Path: <linux-kselftest+bounces-15857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BB795A032
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 16:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894F02850E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9D619995B;
	Wed, 21 Aug 2024 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hH6yL6lg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A32D7D3E2
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 14:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251403; cv=none; b=fvb2sCf69/Cj5ls7P279M4J/MbufDkIlo4jamPxxuzzv8HtdSv77wa55fpC4mEdt3W6hLTtDnF/D6bgpfcgpUMDFMMXDcdzZ+O9k0ePtyAkwFIS2nVoQzq/rSz3ojR4D42zX10cHwHGOq1Xt+zrCPYFP6tL0Q9Z1sGAtv7iMMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251403; c=relaxed/simple;
	bh=c63gTfhMatcJRZQir21NXaOWtiX0zCT9+nAawywUXTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kHHZCzT5AYMyYVgCAjBXgrPBIHQEw4StfT21FaSoP3zcyiVZSqqYTXZxam7ZOshvGZwbTM2h3zSr4RM4mHBLqN41dPc5uoyAufCpnuA1/R/3fmAGi6SSF9AUaFDjZRzz36yiwP+td7Q+RONTjtq8mBo4njmW0fQa0AjMQpUaFkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hH6yL6lg; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724251402; x=1755787402;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c63gTfhMatcJRZQir21NXaOWtiX0zCT9+nAawywUXTQ=;
  b=hH6yL6lgs63GLxM0Nf1g9zcxUH2xQxy9u9M0pw4HlPNew+IXksMGicDe
   xreWXW1JW7JEShjIQRq+JBi+CEUHWuwoM1LeMwcb2XehLAo8OPhCp3EiH
   gkKnkdD0p0JiKTixrpF+sMk1vslqSm0aNw7wsyPTv648FsiJeBcxsqZj6
   lijwuYQ/X9TdT/X0/OfYNdRsL8bx5H7OnnLjMweNkqFwM8192CYTTblGF
   jn8T7BA5QAscLrodA2QscHn74uY4EzWlYy9rgL0ZenISqMPsxEpbbq/QT
   wYl+ULLpyZl3yMDdaTf8gclYYwqdCh74fWklN229VfkVW6k0jHNx38onm
   A==;
X-CSE-ConnectionGUID: T+alcApyTbSbMYh5B73fCA==
X-CSE-MsgGUID: +8BodxbbSk6O66lZu/Kyaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22750520"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22750520"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:43:21 -0700
X-CSE-ConnectionGUID: V/ijyL62S7CwDmVBQbygOw==
X-CSE-MsgGUID: /x80MolHTqWdClBEDOsZpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65316479"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.19.248])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 07:43:19 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 0/4] kunit: Add macros to help write more complex tests
Date: Wed, 21 Aug 2024 16:43:01 +0200
Message-Id: <20240821144305.1958-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was suggested to promote some of the ideas introduced by [1] to be
a part of the core KUnit instead of keeping them locally.

[1] https://patchwork.freedesktop.org/series/137095/

Cc: Rae Moar <rmoar@google.com>
Cc: David Gow <davidgow@google.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>

Michal Wajdeczko (4):
  kunit: Introduce kunit_is_running()
  kunit: Add macro to conditionally expose declarations to tests
  kunit: Allow function redirection outside of the KUnit thread
  kunit: Add example with alternate function redirection method

 include/kunit/static_stub.h    | 80 ++++++++++++++++++++++++++++++++++
 include/kunit/test-bug.h       | 12 ++++-
 include/kunit/visibility.h     |  8 ++++
 lib/kunit/kunit-example-test.c | 63 ++++++++++++++++++++++++++
 lib/kunit/static_stub.c        | 21 +++++++++
 5 files changed, 182 insertions(+), 2 deletions(-)

-- 
2.43.0


