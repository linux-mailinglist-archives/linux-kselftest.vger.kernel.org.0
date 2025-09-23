Return-Path: <linux-kselftest+bounces-42130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3043FB94DD5
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 09:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F867A730A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCBB3164C2;
	Tue, 23 Sep 2025 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtKitduX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0592EDD5D;
	Tue, 23 Sep 2025 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614037; cv=none; b=MJKrM0hHZ2PPRx8JTBjoe39xsrEDDL892dgXOzz/MhMom1Q40hepveX9sMicigA8HPiVpPF7vr4YNwHOg0MmSdpLR6wIlsh1ggs5SpnlcPQa4DnuOZyVRq0Qr6bTqXh2GnXef/Wrm1S2rYcL4rl0MdlQCUb7bQ1NqhA7kND2f+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614037; c=relaxed/simple;
	bh=VUZebV4YgydnoL47kBMbJs5HBbo4D90B8BI+/sakfNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okkvedV92usew8gdT9CGvNplwD3NpQXbuGXKbmwcdZ9qZWem0J/qoKwyvhvOYbAH5tnLb8JRNBpYMGVW/GCvakOmJXYTVeqC6jouiT16MQnk6wp5t3xGhvpSn+s/DPFpzM+dZXgWiwKrCDWDz8tHHZPl7m9kKepNo3XL3PJuQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtKitduX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B49C4CEF5;
	Tue, 23 Sep 2025 07:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758614037;
	bh=VUZebV4YgydnoL47kBMbJs5HBbo4D90B8BI+/sakfNQ=;
	h=From:To:Cc:Subject:Date:From;
	b=JtKitduX4snfs7cW8A17xmpXgYD8wDE2yUcH/mBxiCzIcyDV85rIxgpEULMy7jelE
	 71rd03Zi+Ad4Gk2Am6Ncu3JeTJuAh0YelIdGnbBtrpIV9xMvbdVScoU82wDg9vp4Re
	 wniHUtFsfUIedtbOjq+SS0vUsXuJqt7+0hWQKwpTIzFl/ZDK/+jMHhdFDhNyMeDheL
	 B/4IYUvK5WFaVoMBT3sjie/eUfhmwZTb59Mif5opX8tNIeJxYG5U7BHD+JQf5LAZ3d
	 JjHrDtCPQ9ohf6/roKvIfLn5yFFZ482YvvKlhY3EKrDMOmb51VHdheOdGrkx+Wx4WH
	 SkbCDOVtshDnQ==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 0/7] platform/chrome: Fix a possible UAF via revocable
Date: Tue, 23 Sep 2025 07:52:55 +0000
Message-ID: <20250923075302.591026-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up series of [1].  It tries to fix a possible UAF in the
fops of cros_ec_chardev after the underlying protocol device has gone by
using revocable.

The 1st patch introduces the revocable which is an implementation of ideas
from the talk [2].

The 2nd and 3rd patches add test cases for revocable in Kunit and selftest.

The 4th patch converts existing protocol devices to resource providers
of cros_ec_device.

The 5th - 7th are PoC patches for moving most revocable code to subsystem
level.  Miscdevice is used as it would be simpler for PoC.  Note that the
device driver (e.g., cros_ec_chardev) still needs to be revocable-aware.
The driver needs to specify where to save the pointer and thus the resource
is available in fops.
- The 5th patch adds a helper for using revocable API with fops.
- The 6th patch leverages the helper in miscdevice.
- The 7th patch converts cros_ec_chardev to a resource consumer of
  cros_ec_device to fix the UAF.

[1] https://lore.kernel.org/chrome-platform/20250721044456.2736300-6-tzungbi@kernel.org
[2] https://lpc.events/event/17/contributions/1627/

v4:
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

Tzung-Bi Shih (7):
  revocable: Revocable resource management
  revocable: Add Kunit test cases
  selftests: revocable: Add kselftest cases
  platform/chrome: Protect cros_ec_device lifecycle with revocable
  revocable: Add fops replacement
  char: misc: Leverage revocable fops replacement
  platform/chrome: cros_ec_chardev: Secure cros_ec_device via revocable

 .../driver-api/driver-model/index.rst         |   1 +
 .../driver-api/driver-model/revocable.rst     |  87 ++++
 MAINTAINERS                                   |   9 +
 drivers/base/Kconfig                          |   8 +
 drivers/base/Makefile                         |   5 +-
 drivers/base/revocable.c                      | 374 ++++++++++++++++++
 drivers/base/revocable_test.c                 | 110 ++++++
 drivers/char/misc.c                           |   7 +
 drivers/platform/chrome/cros_ec.c             |   5 +
 drivers/platform/chrome/cros_ec_chardev.c     |  15 +-
 include/linux/miscdevice.h                    |   3 +
 include/linux/platform_data/cros_ec_proto.h   |   4 +
 include/linux/revocable.h                     |  60 +++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/base/revocable/Makefile |   7 +
 .../drivers/base/revocable/revocable_test.c   | 116 ++++++
 .../drivers/base/revocable/test-revocable.sh  |  39 ++
 .../base/revocable/test_modules/Makefile      |  10 +
 .../revocable/test_modules/revocable_test.c   | 188 +++++++++
 19 files changed, 1047 insertions(+), 2 deletions(-)
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
2.51.0.534.gc79095c0ca-goog


