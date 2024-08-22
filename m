Return-Path: <linux-kselftest+bounces-16058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F76E95B577
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 14:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364EC28452D
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 12:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C701C945E;
	Thu, 22 Aug 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzLYzlFO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1CD1DFF0
	for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331316; cv=none; b=fZCoN1ikt12S+bOnqN0rNDX023SrJnCku+QDzNnLea5/mW3y4gsHF+Skm1P3EUc5p1YT2Y5aVhYC5NZAnQ1qIRAqVCUYoqnFSSKhxwW2sWAfOJqQHGe6VlqETq0J2/QT2Ug8nOAv5ix7Bv4tcEKr70shvllsciQlRQhpHOlDUOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331316; c=relaxed/simple;
	bh=KBujhIxndHN+tgFIQIFAy3OUZ1u47vhbQRi2S3Q+u/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kHOvhQY0RyiJmy48eRO5P4zNPgWWoY5LdF3a04y9PG6+2kcBZo3n92W+7yIfobJV1pOy3RFuTIufRClU2oIqKcvvqFzBuDI6mZi+302TMmaHzwyxVU+NmOX/ZJ65/eRudOP6ukfxln02F9voMONSiGpG5S1oacoOLAHOFYcHr4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzLYzlFO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724331315; x=1755867315;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KBujhIxndHN+tgFIQIFAy3OUZ1u47vhbQRi2S3Q+u/Y=;
  b=HzLYzlFOP/wL9rktm5Ys2sTTRtqE4fRZiKpN0fXNcABRpyCdu9qPYhyi
   SpU+uc67zYisn3P/U4wO4I+1aT2n0h5SA+4ws6KatyQL+Q02x0UtWyEtU
   OWnKfYWNGv4EWM+bZZwPuFVCAI57y8TsqnfrI6wsbrTQiDtBDGxi1nsWS
   VKisvM942byNFASwFuDqvIuOCBe2KpR0UTugxNnQnsCSPIMflETlby1d1
   R2sehqHGAYqVTJAVCARsHk/E7sj3F0yn6pchej2SSAiHny34M2V+G/AxQ
   3Y6MkidG6ygHVew+Pq+7Wd6NcGWeYWTcuO4xN578lWtHyyajdVGq9LB8g
   A==;
X-CSE-ConnectionGUID: I2pP/rlRQ7uu28VP02oFkA==
X-CSE-MsgGUID: eIk/m/caR3SitOA21wFJrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40203319"
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="40203319"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:55:14 -0700
X-CSE-ConnectionGUID: dqII85vdQBCcNhRQJHnEJg==
X-CSE-MsgGUID: LLf9cIB3TPCL/NN/n9dBog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,167,1719903600"; 
   d="scan'208";a="65634758"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.19.248])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 05:55:12 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH v2 0/3] kunit: Improve format of some assertion messages
Date: Thu, 22 Aug 2024 14:54:56 +0200
Message-Id: <20240822125459.2075-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://patchwork.kernel.org/project/linux-kselftest/list/?series=881867
v2: keep numerical values (David)

Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>

Michal Wajdeczko (3):
  kunit: Improve format of the NOT_ERR_OR_NULL assertion
  kunit: Improve format of the PTR_EQ|NE|NULL assertion
  kunit: Improve format of the KUNIT_EXPECT_EQ assertion

 lib/kunit/assert.c | 71 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 57 insertions(+), 14 deletions(-)

-- 
2.43.0


