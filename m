Return-Path: <linux-kselftest+bounces-44988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ABBC3C057
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FB3D188A76D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF07026C391;
	Thu,  6 Nov 2025 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4EqVSek"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAAB26B0AE;
	Thu,  6 Nov 2025 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442624; cv=none; b=mL/3g8xyn1VtQnqgDWvHyAjDnJLR3TGzDUYZDcD/Ia9qf/A6YGO35/Y1qX6it6AlrIV73t3Dc4qB4YSqh1mDdojl8lcn+yesgib038xLbEsiibSeuMGG3/ZOspa62bahlLPGkVL3WY3j97JdwUHvRRuFNNwR5Og5iq1JwLV0M3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442624; c=relaxed/simple;
	bh=zIUMeT7hGiOlHf1WB7lre3GGJ2Wo/h4bJ7uQ111gxz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ouDZ0ICojYAchtPepd9MSXAlKZmd64lPdDM2UEGkFTviweCs19dYAkjXB6bWdtSXEVuReZVEvH+YemBt2pxuchshv5qmlQwX8IbS6B5LC9DcP5/ua/p0SCecz2P/lEpxNl2I7ErxBqzGIBGwz4l0T3u/mczUfZnWF6+VNC/8XGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4EqVSek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63191C4CEF7;
	Thu,  6 Nov 2025 15:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762442623;
	bh=zIUMeT7hGiOlHf1WB7lre3GGJ2Wo/h4bJ7uQ111gxz8=;
	h=From:To:Cc:Subject:Date:From;
	b=r4EqVSekQVZrKHPjcwfGG7/Ey9EdpX4dJi33im2Oz6p6lnFJSC/nvA/B31t7rRfQ1
	 HBIcx9i2iueDZ89qaGtd3F7LdG3Ozc6ReX17V6b79fxrjwQIgEvJ8bCjC/Zv0pbkw+
	 KD36Zzb4mQcxGXXMPT/GmYePR8udGHyZ6kAITmTX6Y2a34coJktspJBf/qumyeDc4s
	 KEYRYEExSZ3Lo/if3dn1LUtfbsRO0zuqSGeaevgUyFb77+PN3A92x7cQ/eZ1K7iY0V
	 MVEKEDDIiBFC8hW1qaR25os7KMhmvJ0F8eYW71BIHbWEkZpWz22/bZrrhvtCg3gLVe
	 fu3jG3KwVA81g==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 0/3] drivers/base: Introduce revocable
Date: Thu,  6 Nov 2025 23:23:27 +0800
Message-ID: <20251106152330.11733-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series is separated from [1] to show the independency and compare
potential use cases easier.  This is the revocable core part.  Use cases
are in other series.

The 1st patch introduces the revocable which is an implementation of ideas
from the talk [2].

The 2nd and 3rd patches add test cases for revocable in Kunit and selftest.

[1] https://lore.kernel.org/chrome-platform/20251016054204.1523139-1-tzungbi@kernel.org
[2] https://lpc.events/event/17/contributions/1627/

v6:
- Rebase onto next-20251106.
- Separate revocable core and use cases.

v5: https://lore.kernel.org/chrome-platform/20251016054204.1523139-1-tzungbi@kernel.org
- Rebase onto next-20251015.
- Add more context about the PoC.
- Support multiple revocable providers in the PoC.

v4: https://lore.kernel.org/chrome-platform/20250923075302.591026-1-tzungbi@kernel.org
- Rebase onto next-20250922.
- Remove the 5th patch from v3.
- Add fops replacement PoC in 5th - 7th patches.

v3: https://lore.kernel.org/chrome-platform/20250912081718.3827390-1-tzungbi@kernel.org
- Rebase onto https://lore.kernel.org/chrome-platform/20250828083601.856083-1-tzungbi@kernel.org
  and next-20250912.
- The 4th patch changed accordingly.

v2: https://lore.kernel.org/chrome-platform/20250820081645.847919-1-tzungbi@kernel.org
- Rename "ref_proxy" -> "revocable".
- Add test cases in Kunit and selftest.

v1: https://lore.kernel.org/chrome-platform/20250814091020.1302888-1-tzungbi@kernel.org

Tzung-Bi Shih (3):
  revocable: Revocable resource management
  revocable: Add Kunit test cases
  selftests: revocable: Add kselftest cases

 .../driver-api/driver-model/index.rst         |   1 +
 .../driver-api/driver-model/revocable.rst     | 112 +++++++++
 MAINTAINERS                                   |   9 +
 drivers/base/Kconfig                          |   8 +
 drivers/base/Makefile                         |   5 +-
 drivers/base/revocable.c                      | 234 ++++++++++++++++++
 drivers/base/revocable_test.c                 | 139 +++++++++++
 include/linux/revocable.h                     |  69 ++++++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/base/revocable/Makefile |   7 +
 .../drivers/base/revocable/revocable_test.c   | 136 ++++++++++
 .../drivers/base/revocable/test-revocable.sh  |  39 +++
 .../base/revocable/test_modules/Makefile      |  10 +
 .../revocable/test_modules/revocable_test.c   | 195 +++++++++++++++
 14 files changed, 964 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/driver-model/revocable.rst
 create mode 100644 drivers/base/revocable.c
 create mode 100644 drivers/base/revocable_test.c
 create mode 100644 include/linux/revocable.h
 create mode 100644 tools/testing/selftests/drivers/base/revocable/Makefile
 create mode 100644 tools/testing/selftests/drivers/base/revocable/revocable_test.c
 create mode 100755 tools/testing/selftests/drivers/base/revocable/test-revocable.sh
 create mode 100644 tools/testing/selftests/drivers/base/revocable/test_modules/Makefile
 create mode 100644 tools/testing/selftests/drivers/base/revocable/test_modules/revocable_test.c

-- 
2.48.1


