Return-Path: <linux-kselftest+bounces-3556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B7883C0C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 12:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D93B2C32F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 11:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026051CAAE;
	Thu, 25 Jan 2024 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z7bnAG8c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135B523764;
	Thu, 25 Jan 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181011; cv=none; b=GVl/5BhEKJW5pjvHw5AQkrZp9Cio5rL8L02su2Ma1oKc/CA/6oirjcKquPousplUYiNLMYHQ9OenY4lSFxVNu+ZnBK6lBqBj0QatK0HVjzpKO45sWtzzMq0gbIjdh2NNHW+DsX+rB0roWKIyzLB6rl2mFFS1sFA5xmpMHJtqhos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181011; c=relaxed/simple;
	bh=Mr/F63IipvcxWrpKyJn4W5DHDoj6d/37xno7IQH+kGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eph2x28a2rWXwisFAjxK14H0/j/+2KWYSGuj6uDLyp2CI9jVt3zWi6O2NtP4GFRmNFuisJsaTV/GPaqGWnHyXRh+sk35MlwyMjfCJMxL8r5SE/TBaEhPROCYKcUuUK6ET0I+vKoWg1+u8gtof81EYNKAfzkKbT2gWH0k403KaPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z7bnAG8c; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706181010; x=1737717010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mr/F63IipvcxWrpKyJn4W5DHDoj6d/37xno7IQH+kGc=;
  b=Z7bnAG8cplymGG6iAVghnAcZrHygjyvVj/aIx0CXoxw1FxL5UyrRclRc
   DXBwU3u0gq9EeER+EngkwI0pnoZs5PkmhemeRvJInFi1aAyjCxOTa7SC2
   Oi/XQvFwOuIESfF8/R+xGbHrd1KkaW0q7fGbbC431NPK4igFJeddihzsa
   R5WCow7V/ogaUOnQuJreocBYWBC5D6sFmakmi8LGJ9UNk1kjr4ZxEtDuU
   0/J6X5S9+wLBwSVlk0AeiWzkkrg34807vUebAXB9c+3zBxNiUXA91ayO6
   bV8HE0X86TohbaJ/Qsdj3rqY+1d0MFcJXAAcaF19PsCJugi4kphF4Pde+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400987262"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="400987262"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 03:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2394257"
Received: from apejovix-mobl1.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.213.0.239])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 03:10:06 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: reinette.chatre@intel.com,
	fenghua.yu@intel.com,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3 0/5] selftests/resctrl: Add non-contiguous CBMs in Intel CAT selftest
Date: Thu, 25 Jan 2024 12:09:42 +0100
Message-ID: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Non-contiguous CBM support for Intel CAT has been merged into the kernel
with Commit 0e3cd31f6e90 ("x86/resctrl: Enable non-contiguous CBMs in
Intel CAT") but there is no selftest that would validate if this feature
works correctly.
The selftest needs to verify if writing non-contiguous CBMs to the
schemata file behaves as expected in comparison to the information about
non-contiguous CBMs support.

The patch series is based on a rework of resctrl selftests that's
currently in review [1]. The patch also implements a similar
functionality presented in the bash script included in the cover letter
of the original non-contiguous CBMs in Intel CAT series [3].

Changelog v3:
- Rebase onto v4 of Ilpo's series [1].
- Split old patch 3/4 into two parts. One doing refactoring and one
  adding a new function.
- Some changes to all the patches after Reinette's review.

Changelog v2:
- Rebase onto v4 of Ilpo's series [2].
- Add two patches that prepare helpers for the new test.
- Move Ilpo's patch that adds test grouping to this series.
- Apply Ilpo's suggestion to the patch that adds a new test.

[1] https://lore.kernel.org/all/20231215150515.36983-1-ilpo.jarvinen@linux.intel.com/
[2] https://lore.kernel.org/all/20231211121826.14392-1-ilpo.jarvinen@linux.intel.com/
[3] https://lore.kernel.org/all/cover.1696934091.git.maciej.wieczor-retman@intel.com/

Older versions of this series:
[v1] https://lore.kernel.org/all/20231109112847.432687-1-maciej.wieczor-retman@intel.com/
[v2] https://lore.kernel.org/all/cover.1702392177.git.maciej.wieczor-retman@intel.com/

Ilpo Järvinen (1):
  selftests/resctrl: Add test groups and name L3 CAT test L3_CAT

Maciej Wieczor-Retman (4):
  selftests/resctrl: Add helpers for the non-contiguous test
  selftests/resctrl: Split validate_resctrl_feature_request()
  selftests/resctrl: Add resource_info_file_exists()
  selftests/resctrl: Add non-contiguous CBMs CAT test

 tools/testing/selftests/resctrl/cat_test.c    | 84 +++++++++++++++-
 tools/testing/selftests/resctrl/cmt_test.c    |  4 +-
 tools/testing/selftests/resctrl/mba_test.c    |  4 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  6 +-
 tools/testing/selftests/resctrl/resctrl.h     | 11 ++-
 .../testing/selftests/resctrl/resctrl_tests.c | 18 +++-
 tools/testing/selftests/resctrl/resctrlfs.c   | 98 ++++++++++++++++---
 7 files changed, 199 insertions(+), 26 deletions(-)

-- 
2.43.0


