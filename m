Return-Path: <linux-kselftest+bounces-2263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE0181A239
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 16:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E166B22235
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A084640BE2;
	Wed, 20 Dec 2023 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tuDHrFQY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5440BE3;
	Wed, 20 Dec 2023 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=+TT0x2mfXYsJfJLBBaBRybFsPHGeBn/YbhuKpVUSDZs=; t=1703085601; x=1704295201; 
	b=tuDHrFQYj/y2SLsaPGiIg5fZFOKbyTKEVtDr78dzCDLIvtq1cqPipO8qEFT4CdKryn9zbT7CujJ
	yXo7WoT9OBarb+R8vEe8RWi6ID86moP0wZGFnH7MEc0OFDpJrFHa2Zme2LgB1R6BBLkJxKcrPjHuW
	HLWyy3b4UbEwXly5NRVWM509Lz9bSOsQduMHPVIVr8ufL2mrfH2SLsoT1qKQ0I3AWg8ATAXl61CG5
	F2jjRF9XA+/f2RL+gFWzJgzh9Xn3yxDtiS2G45Uq2wm0apFhKTgZPrZSht3kXAi+kB5lpmf5l3bBN
	6967XIROnVpx/vuxDyGcw3w3srlSuCFZODrA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1rFyMX-00000001WFz-1eNn;
	Wed, 20 Dec 2023 16:19:57 +0100
From: benjamin@sipsolutions.net
To: linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 0/6] Add some more cfg80211 and mac80211 kunit tests
Date: Wed, 20 Dec 2023 16:19:46 +0100
Message-ID: <20231220151952.415232-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

This patchset adds a couple of helpers for kunit as well as tests for
cfg80211 and mac80211 that use them.

Benjamin Berg (3):
  kunit: add parameter generation macro using description from array
  kunit: add a convenience allocation wrapper for SKBs
  wifi: cfg80211: tests: add some scanning related tests

Johannes Berg (3):
  wifi: mac80211: add kunit tests for public action handling
  wifi: mac80211: kunit: generalize public action test
  wifi: mac80211: kunit: extend MFP tests

 Documentation/dev-tools/kunit/usage.rst |  12 +-
 include/kunit/skbuff.h                  |  56 +++
 include/kunit/test.h                    |  19 +
 net/mac80211/ieee80211_i.h              |  10 +
 net/mac80211/rx.c                       |   4 +-
 net/mac80211/tests/Makefile             |   2 +-
 net/mac80211/tests/mfp.c                | 286 +++++++++++
 net/wireless/core.h                     |  13 +-
 net/wireless/scan.c                     |   9 +-
 net/wireless/tests/Makefile             |   2 +-
 net/wireless/tests/scan.c               | 625 ++++++++++++++++++++++++
 net/wireless/tests/util.c               |  56 +++
 net/wireless/tests/util.h               |  66 +++
 13 files changed, 1145 insertions(+), 15 deletions(-)
 create mode 100644 include/kunit/skbuff.h
 create mode 100644 net/mac80211/tests/mfp.c
 create mode 100644 net/wireless/tests/scan.c
 create mode 100644 net/wireless/tests/util.c
 create mode 100644 net/wireless/tests/util.h

-- 
2.43.0


