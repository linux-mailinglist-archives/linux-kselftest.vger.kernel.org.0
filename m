Return-Path: <linux-kselftest+bounces-49099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A15AD2DA46
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 900DB3007904
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DC42E173D;
	Fri, 16 Jan 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAEE53Gr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491C2DEA80;
	Fri, 16 Jan 2026 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768550597; cv=none; b=Mrql3niAhAYaR1BxJX74qQyEpPBRJI16m1rZk4tGPKFfttIn0M5PrJU2wPHLAHS6/JwHxgtPnB4OBewKAQ1FsL3OI9StJoDh2syP0IQco32aDeFmHMZarKbliY5RKyLBeH0Zu9ggVR0vudQ0fCydK9prNMzjf8xchfQLZ2m5248=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768550597; c=relaxed/simple;
	bh=XTkkLkWWQfZAahv1Z3KRyrnOTFGai1tByTwtfsSXFnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J1JmQBP0u3bwm3D+lkXiq6MlQDZiUiFV7vSOVmVNcDWOFNrk+LkLuQ45S8tAbHDs+oyYfMA1/GNGtgBEBKRHWh3mEmgfnB/us1dWM2uoKPF88GwjKRSxhKiZGPTuzksft9GvFtfZ1+j87rxMqA1p1XhAhme/XZwEyu3zN+Z7zxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAEE53Gr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18A3C116C6;
	Fri, 16 Jan 2026 08:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768550597;
	bh=XTkkLkWWQfZAahv1Z3KRyrnOTFGai1tByTwtfsSXFnE=;
	h=From:To:Cc:Subject:Date:From;
	b=YAEE53GrsEgSNm8JVPHah6+acnZ3kl99lWQvtfK97wy9i2L6DAXNlUsGU22W6OZf7
	 yhvWC+J23i/qOCX3yG3t9H9yAHLGtDBCLubaNVpOCUc/bJ/xXEYKxw053wXfm8Y+3R
	 8QZeWiZ91ubO1mYKtZ9yKpvwDjk8QQXzm7WpFVIOuwdTuk8iAuwThzKan8ZoMHruY9
	 zcgqX4iDdgUj7yPqmF6WMN99lymKCjT/wvkG3X5+NqgK2KJoW3ZzOYTExBOhEC6YAU
	 q4Q5fYhePmQUwQf+TUS10AMq3MFvq4hbbn3M+2gAFx6I1YtlzPfPyTV2X6KafEudmh
	 zwS1TWM7JaZVg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linusw@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	linux-gpio@vger.kernel.org
Subject: [PATCH v7 0/3] drivers/base: Introduce revocable
Date: Fri, 16 Jan 2026 08:02:32 +0000
Message-ID: <20260116080235.350305-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
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

v7:
- Rebase onto next-20260115.

v6: https://lore.kernel.org/chrome-platform/20251106152330.11733-1-tzungbi@kernel.org
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
 .../driver-api/driver-model/revocable.rst     | 152 +++++++++++
 MAINTAINERS                                   |   9 +
 drivers/base/Kconfig                          |   8 +
 drivers/base/Makefile                         |   5 +-
 drivers/base/revocable.c                      | 242 ++++++++++++++++++
 drivers/base/revocable_test.c                 | 139 ++++++++++
 include/linux/revocable.h                     |  69 +++++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/base/revocable/Makefile |   7 +
 .../drivers/base/revocable/revocable_test.c   | 136 ++++++++++
 .../drivers/base/revocable/test-revocable.sh  |  39 +++
 .../base/revocable/test_modules/Makefile      |  10 +
 .../revocable/test_modules/revocable_test.c   | 195 ++++++++++++++
 14 files changed, 1012 insertions(+), 1 deletion(-)
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
2.52.0.457.g6b5491de43-goog


