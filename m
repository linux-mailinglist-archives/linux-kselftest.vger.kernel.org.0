Return-Path: <linux-kselftest+bounces-41281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ED4B544F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 10:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56003A32DD
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 08:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2132D3EF6;
	Fri, 12 Sep 2025 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/62oiqs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E292E401;
	Fri, 12 Sep 2025 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665096; cv=none; b=HVxE+Yfi+XG3NYN99776oc1HcO2nMjs6PVpggYSHnuuPwKrtSZsXZMfd5ci89F48iIeOkiN1562bJ37b2wEBjVpzGF6WH43myeYjRIWQt/LCLBiaRx4mG+UpC9UNwfebgv3aevdQapq47F4VJrsJKmkuCrNhfSZ2bYgASfpJQlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665096; c=relaxed/simple;
	bh=e711hS+rgV444nNMnFjLGf+X5w1SGP/L2zBBnyjeT+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0ZtfrcJoOldWKXRh/2dlTuxEdQX74lGK6+m8sHh9EO6myCwTJBd7ULR8HAQA4WM+8mT6A0CqTjSIyQHt0plPohuwhQwvz7AnNMZt+JMOS0L7taLkKsLUiJOhawhu8fndLNs2GSyPPivW4Oc3S6EDTCl15+O2QLUFE8q04G21hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/62oiqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05292C4CEF4;
	Fri, 12 Sep 2025 08:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757665096;
	bh=e711hS+rgV444nNMnFjLGf+X5w1SGP/L2zBBnyjeT+U=;
	h=From:To:Cc:Subject:Date:From;
	b=Q/62oiqs6m4mF7WUbfclhp0jjJdkSwMJOmyK61FkH4zcrMM8T36pCFYx9aRcF9jhM
	 lK5BVKcJPhtSpxQD8DE50RlsdGL1uCI6LlddXwcGNPlOEUmO2MM8fIVaZPpzf42XPk
	 DYymNHpQMDXv0s5XGpPA/SeQQzPagOpvurfhAQOc90Tljh80LZsoWwC7cvbu++RHIC
	 wU+1r7VgrGo8Vy2MfOw6XgU1ucsUMtLoWy0Ek44P/GTKKRpbVUk2Auy9QvWfIFZK/l
	 6f4szknCiKeyISUu+/+uQ7K+qXc7gJ+jA23j4f4zdfgc6XXsGoTDz64wfT95SfZHx+
	 S1rqsAVrwwywA==
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 0/5] platform/chrome: Fix a possible UAF via revocable
Date: Fri, 12 Sep 2025 08:17:12 +0000
Message-ID: <20250912081718.3827390-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
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

The 5th patch converts cros_ec_chardev to a resource consumer of
cros_ec_device to fix the UAF.

[1] https://lore.kernel.org/chrome-platform/20250721044456.2736300-6-tzungbi@kernel.org/
[2] https://lpc.events/event/17/contributions/1627/

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>

v3:
- Rebase onto https://lore.kernel.org/chrome-platform/20250828083601.856083-1-tzungbi@kernel.org
  and next-20250912.
- Change the 4th patch accordingly.

v2: https://lore.kernel.org/chrome-platform/20250820081645.847919-1-tzungbi@kernel.org
- Rename "ref_proxy" -> "revocable".
- Add test cases in Kunit and selftest.

v1: https://lore.kernel.org/chrome-platform/20250814091020.1302888-1-tzungbi@kernel.org/

Tzung-Bi Shih (5):
  revocable: Revocable resource management
  revocable: Add Kunit test cases
  selftests: revocable: Add kselftest cases
  platform/chrome: Protect cros_ec_device lifecycle with revocable
  platform/chrome: cros_ec_chardev: Consume cros_ec_device via revocable

 .../driver-api/driver-model/index.rst         |   1 +
 .../driver-api/driver-model/revocable.rst     | 151 ++++++++++++
 MAINTAINERS                                   |   9 +
 drivers/base/Kconfig                          |   8 +
 drivers/base/Makefile                         |   5 +-
 drivers/base/revocable.c                      | 229 ++++++++++++++++++
 drivers/base/revocable_test.c                 | 110 +++++++++
 drivers/platform/chrome/cros_ec.c             |   5 +
 drivers/platform/chrome/cros_ec_chardev.c     | 124 +++++++---
 include/linux/platform_data/cros_ec_proto.h   |   4 +
 include/linux/revocable.h                     |  37 +++
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/drivers/base/revocable/Makefile |   7 +
 .../drivers/base/revocable/revocable_test.c   | 116 +++++++++
 .../drivers/base/revocable/test-revocable.sh  |  39 +++
 .../base/revocable/test_modules/Makefile      |  10 +
 .../revocable/test_modules/revocable_test.c   | 188 ++++++++++++++
 17 files changed, 1003 insertions(+), 41 deletions(-)
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
2.51.0.384.g4c02a37b29-goog


