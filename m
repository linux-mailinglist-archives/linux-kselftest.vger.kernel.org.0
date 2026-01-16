Return-Path: <linux-kselftest+bounces-49104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A1BD2DBD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 09:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C091300B02B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 08:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD042F1FE9;
	Fri, 16 Jan 2026 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0Uu6nUg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CAC2F1FDA;
	Fri, 16 Jan 2026 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551067; cv=none; b=XNseM1fqZX8RvgvIabdczHQFAOTKhBxdHQ8Ux4qCrWUzVCdTvLAOkLAKkY1Zx0RXsHTgVbD7uyul4fUr/M6Bq4YazIx0OmrvuqctHlSOiSGpw4SkcyoKXr3pHXD2J6yvl7STmS2XYyLrIJ95GsGw4L7X/iKDS4+5RN7JvJcupVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551067; c=relaxed/simple;
	bh=wFh+7TBblBKdqsuPRAvtZYiS1LG+bG9QlY39DipsRU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QwV3mksL++sycX3fSEMa6hX8gsFRwLH1FXKJcUDrCAUgHIn710to2z6vKSeaXu4K+2U1LdC0TmMyTbFnf+iy10RdZfLWKBcacf0TaTqCsUMUSZjFXG+rX2ZlToKbGXIxWeqLgNxMouavuYnmEptxU/FGHj7T5DwnMR1dnk0XUN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0Uu6nUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA15C19423;
	Fri, 16 Jan 2026 08:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768551067;
	bh=wFh+7TBblBKdqsuPRAvtZYiS1LG+bG9QlY39DipsRU0=;
	h=From:To:Cc:Subject:Date:From;
	b=I0Uu6nUgBPQ6gByHmffeTu+v39Jt4WVp/vzlLvOVJ++6OhHdQS1ZGfEdAM14oAWy6
	 zzSgFsxjZYEKfXT9N6xFYKdYWswEWSfsMzlVXytIA3df+84DFVSWFf91ecaGP+MN/z
	 jUEs2ldPXtqec25Pg590n8ALIZqHEDAfgBi15G7NTneBw0GX8tmMFEZ1rfuQsGnqGZ
	 u7r6/ZV7wawSnyegesjKDqRNmqNi4zl6A4S1drkRxq41250qjZPpFBx9UUPKVuguNX
	 Sp79fOnSXU/nZn+ZomZBsrVp/A/ZgN9iBdV+2YGcMqhw4bwTQzJOuf6e3IOgzAbkIJ
	 xzFXm9+WdSowA==
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
Subject: [PATCH 00/23] gpiolib: Adopt revocable mechanism for UAF prevention
Date: Fri, 16 Jan 2026 08:10:13 +0000
Message-ID: <20260116081036.352286-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series transitions the UAF prevention logic within the GPIO core
(gpiolib) to use the 'revocable' mechanism.

The existing code aims to prevent UAF issues when the underlying GPIO
chip is removed.  This series replaces that custom logic with the
generic 'revocable' API, which is designed to handle such lifecycle
dependencies.  There should be no change in behavior.

This series depends on the 'revocable' API, introduced in [1].  Some
build bots may report errors due to undefined symbols related to
'revocable' until the dependency is merged.

[1] https://lore.kernel.org/chrome-platform/20260116080235.350305-1-tzungbi@kernel.org

Tzung-Bi Shih (23):
  gpiolib: Correct wrong kfree() usage for `kobj->name`
  gpiolib: cdev: Fix resource leaks on errors in gpiolib_cdev_register()
  gpiolib: Fix resource leaks on errors in gpiochip_add_data_with_key()
  gpiolib: Fix resource leaks on errors in lineinfo_changed_notify()
  gpiolib: cdev: Correct return code on memory allocation failure

=> The first 5 patches are fixes.  They aren't directly related to the
   replacement, and should be able to apply independently.

  gpiolib: Access `gpio_bus_type` in gpiochip_setup_dev()
  gpiolib: Remove redundant check for struct gpio_chip
  gpiolib: sysfs: Remove redundant check for struct gpio_chip
  gpiolib: Ensure struct gpio_chip for gpiochip_setup_dev()
  gpiolib: cdev: Don't check struct gpio_chip in gpio_chrdev_open()

=> The following 5 patches are refactors.  Makes the subsequent changes
   easier or at least clear.

  selftests: gpio: Add gpio-cdev-uaf tests

=> The following patch adds kselftest cases for some classic UAF
   scenarios.

  gpiolib: Add revocable provider handle for struct gpio_chip
  gpiolib: cdev: Leverage revocable for gpio_fileops
  gpiolib: cdev: Leverage revocable for linehandle_fileops
  gpiolib: cdev: Leverage revocable for line_fileops
  gpiolib: cdev: Leverage revocable for lineevent_fileops
  gpiolib: cdev: Leverage revocable for lineinfo_changed_notify
  gpiolib: Leverage revocable for gpiolib_sops

=> The following 7 patches start to replace the existing code.  They
   are intentionally making small changes for easier to review.

  revocable: Support to define revocable consumer handle on stack
  revocable: Add Kunit test case for DEFINE_REVOCABLE()
  selftests: revocable: Add test case for DEFINE_REVOCABLE()

=> The following 3 patches introduce a new way to define revocable
   consumer handles on stack and its test cases.

  gpiolib: Leverage revocable for other independent lifecycle instances

=> The following patch handles the "others" (i.e., the rest of those
   custom logic) by using DEFINE_REVOCABLE() to at least make the usage
   easier.  A big patch.

  gpiolib: Remove unused `chip` and `srcu` in struct gpio_device

=> The last patch removes the unused fields for the custom logic as all
   of them should be transiting to revocable.

 .../driver-api/driver-model/revocable.rst     |   5 +-
 drivers/base/revocable.c                      |  60 ++-
 drivers/base/revocable_test.c                 |  54 +++
 drivers/gpio/gpiolib-cdev.c                   | 262 ++++++-----
 drivers/gpio/gpiolib-cdev.h                   |   3 +-
 drivers/gpio/gpiolib-sysfs.c                  |  55 ++-
 drivers/gpio/gpiolib-sysfs.h                  |  11 +-
 drivers/gpio/gpiolib.c                        | 410 ++++++++++--------
 drivers/gpio/gpiolib.h                        |  27 +-
 include/linux/revocable.h                     |  30 +-
 .../drivers/base/revocable/revocable_test.c   |  12 +
 .../revocable/test_modules/revocable_test.c   |  37 +-
 tools/testing/selftests/gpio/Makefile         |   5 +-
 tools/testing/selftests/gpio/gpio-cdev-uaf.c  | 320 ++++++++++++++
 tools/testing/selftests/gpio/gpio-cdev-uaf.sh |  67 +++
 15 files changed, 974 insertions(+), 384 deletions(-)
 create mode 100644 tools/testing/selftests/gpio/gpio-cdev-uaf.c
 create mode 100755 tools/testing/selftests/gpio/gpio-cdev-uaf.sh

-- 
2.52.0.457.g6b5491de43-goog


