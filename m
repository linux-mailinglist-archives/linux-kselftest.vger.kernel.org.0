Return-Path: <linux-kselftest+bounces-15906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBA395A527
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A9B1F22918
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 19:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA81616DECB;
	Wed, 21 Aug 2024 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRAH2u06"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819C16DEBA
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267700; cv=none; b=UP/EcCA78qeOYS9ZIGmjD8i8LSoExgrOJdUWbkVi4BNGYl5qoUBqSErqdUNLWKNKKnhPMfEdU8Vg/Y9DkhBpx5/4fF7yYodWlfV12YDZCrqjYs/EETvsOw9mSvu1766UcwmWy0xiuqny4QO1K3VZM7Mwv3GzctU5bG2i18RJRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267700; c=relaxed/simple;
	bh=EbwWlepH/F0GVriLivKt+R6TQIRq1xU8sQQlPVwzFbI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Lu8Y5DEFDqOgeNHajcbfxqdeBMKifixtGoxsw9NPD9sOilzG7iXiYrIWv6t0R+M8eE9bLnxS1w9rH1UEVMbUq50eAlECfj8y5wisY2W5LmDHhh+f1p24xtXQlo4eAcikgeFE7S52/cuydkr6GG+TLsWrgEToE4lUnNPLpsNRzxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRAH2u06; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724267699; x=1755803699;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EbwWlepH/F0GVriLivKt+R6TQIRq1xU8sQQlPVwzFbI=;
  b=QRAH2u060cfHw7txzobRHnRuooKDILRu9hBJYkSb95cm7mp3p+Y/NMET
   BJYSUSsA/B3BaifzC8LtkvPdCYswj9LAg6c7l0HWdRnOXXWaUtII0jAym
   vCdNO+Vyl3+nSqjfFST3MxKcc5b2uIOxTjg+W3iCC1nTUp0nLzoM3fw22
   swGiudCbkp4aEExDpkr6q7Oea5iHY1uOhdtcogJxIYF2opL+6lK8gT9j5
   7fopVdOgHUl+gQeXxoqFOaWMKLOviLonYTTJ8BtNm0t9XOVdLJ9JgRzGW
   UGuLr+2ezNwXkxLhiGf4XCd+XTlb/9U8jA0Q8WSNYeweabKjKOuR6O/su
   g==;
X-CSE-ConnectionGUID: Sz3ZCsqyQmafUR4A+ZsFPQ==
X-CSE-MsgGUID: ZINlY/ebRf2Fc7fydE7BVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22802448"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22802448"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 12:14:58 -0700
X-CSE-ConnectionGUID: NdKHUme/TYmTF4nb+mu5JQ==
X-CSE-MsgGUID: kuBgtL5LT4CKOpnUW25Bgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="84357269"
Received: from mwajdecz-mobl.ger.corp.intel.com ([10.246.19.248])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 12:14:57 -0700
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>
Subject: [PATCH 0/3] kunit: Improve format of some assertion messages
Date: Wed, 21 Aug 2024 21:14:09 +0200
Message-Id: <20240821191412.2031-1-michal.wajdeczko@intel.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is mostly a re-post of a series [1] that was apparently lost last year.

[1] https://lore.kernel.org/all/20230928133821.1467-1-michal.wajdeczko@intel.com/

Cc: David Gow <davidgow@google.com>
Cc: Rae Moar <rmoar@google.com>

Michal Wajdeczko (3):
  kunit: Improve format of the NOT_ERR_OR_NULL assertion
  kunit: Improve format of the PTR_EQ|NE|NULL assertion
  kunit: Improve format of the KUNIT_EXPECT_EQ assertion

 lib/kunit/assert.c | 64 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 14 deletions(-)

-- 
2.43.0


