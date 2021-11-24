Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C9645B957
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 12:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbhKXLqN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 06:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241385AbhKXLqM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 06:46:12 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB79C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Nov 2021 03:43:02 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v11so3623368wrw.10
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Nov 2021 03:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/I6CWcTOH3LYJx6aWMzykqBhhBjUhlyAfnnXfmSFRMw=;
        b=kSpTOQuyqbeukR11F9hdQbrE8IpbrluDR43qrYiflI0Qysa5P1zfygdaygBCBQ37Vd
         d+Sh7K5aiNk6Id4RhvS4SWQRska5YkUu7ikERqOS89r6FPyOZw7B9HIdKxiYZmuErXD7
         XOR288KfTyPMCNvGj+JwtGA0tRMB9eFmNhhSK5S7KwHy1CQ4QNmAtn0b11/nI/0bYYI9
         JcdzQEAJ9OlAuNJpGBVSmQ7q9EkXG8Q1IVpvi/BIZqlabd+a9sR7bBf9lP4CrrI4ofSU
         s2zxUTBFF0H0hx2mHnfKP1jcO+ETpQ9ju07sRqS3uGlMnbCWs0tIGxd2U4tEiYljaKeL
         D6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/I6CWcTOH3LYJx6aWMzykqBhhBjUhlyAfnnXfmSFRMw=;
        b=HZ+WFQze6nRQ0gCSbJT7XYLREKHUWY0IwS6f9bRl7JI/oDlHhXWZM4Q0nzN2BMyJV7
         pXlMuNK4TTGyEJp3o26NZwlgl+fTrV1SdtNVRZ1VopyfUiKZBL0K6hYyD92C9rLU7ZaD
         oOzwyhFWG/J0jGlvWVYu/6paVVeI7+VSrLPouDgxVVCpOqFUm/NKbEyCUWyfWlFNfsOd
         74lA+6IGRifjwGNqx97lkuBn+E8QDx/szbyn/BzQhcNvcynBMdYUMtB4M6gGs2RX3lk9
         eATyXsaRNJdnuxnxNOdTFSnRknthl7wNpxN+wc7GmT8Ql4R1Mm1i2cYMdAOSj24L20g3
         QC7A==
X-Gm-Message-State: AOAM530gjd+uJMe8GhU7nKtW6Fyx/zi6pl33/PzEWa/FoNXO+gNCYJVL
        l2n8QQBmiRYnxf3lLuX+Sy8cke7IifJL7IJx
X-Google-Smtp-Source: ABdhPJxVQm3AU2243Vzm3e0ommKKsx59qOAWYKHD4m6q9KOULSUf2TkNWiIOKe6lTWiKSl3+l1SgFQ==
X-Received: by 2002:a05:6000:1aca:: with SMTP id i10mr18212310wry.407.1637754181477;
        Wed, 24 Nov 2021 03:43:01 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id s63sm5165173wme.22.2021.11.24.03.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 03:43:01 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v10 0/5] gpio-sim: configfs-based GPIO simulator
Date:   Wed, 24 Nov 2021 12:42:52 +0100
Message-Id: <20211124114257.19878-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Here's the tenth revision of the simulator.

As there was no reasoning with configfs maintainers for many months,
this time the whole concept of committable items has been dropped. Instead,
each configfs chip item (or rather a group - more on that later) exposes a new
attribute called 'live'. Writing 1 to it brings the chip on-line (registers
the platform device) and writing 0 tears it down.

There are some caveats to that approach - for example: we can't block
the user-space from deleting chip items when chips are live but is just
handled by silently destroying the chip device in the background.

Andy (rightfully) pointed out that parsing of the lists of line names is
awkward so in this iteration it's been replaced by a system that is more
elegant and will allow to easily extend configuration options for
specific GPIO lines. This is achieved by turning the chip's configfs
item into a configfs group and allowing the user-space to create
additional items inside it. The items must be called line<offset> (e.g.
line0, line12 etc.) where the offset part indicates to the module the
offset for which given item stores the configuration for. Within each
such line item, there are additional attributes that allow specifying
configuration for specific lines.

In v10 there are additional significant changes:

Kent and Andy suggested that we should wait for probe() to finish and
propagate any errors to user-space. In this version that is implemented.
However there's no mechanism for propagating error codes from probe so
we always return -ENXIO to the user-space if probe fails. Thanks to this
approach, there's no longer need for using udev in user-space to wait
for the device to appear. Once we return from the write() to live, the
device is good to go.

The lines can now be hogged from the kernel-space. This will allow the
user-space to tests various use-cases involving busy lines without
having to use the very tested interface to take them in the first place.

I dropped the separate locks for lines because in most cases the chip
lock needed to be taken anyway. It simplified the locking in general a
lot.

The sysfs interface has been reworked. Instead of creating a single
group with a variable number of attributes (for each line) we go for a
separate group for each line and a constant number of attributes that
can be easily extended in the future.

v1 -> v2:
- add selftests for gpio-sim
- add helper programs for selftests
- update the configfs rename callback to work with the new API introduced in
  v5.11
- fix a missing quote in the documentation
- use !! whenever using bits operation that are required to return 0 or 1
- use provided bitmap API instead of reimplementing copy or fill operations
- fix a deadlock in gpio_sim_direction_output()
- add new read-only configfs attributes for mapping of configfs items to GPIO
  device names
- and address other minor issues pointed out in reviews of v1

v2 -> v3:
- use devm_bitmap_alloc() instead of the zalloc variant if we're initializing
  the bitmap with 1s
- drop the patch exporting device_is_bound()
- don't return -ENODEV from dev_nam and chip_name configfs attributes, return
  a string indicating that the device is not available yet ('n/a')
- fix indentation where it makes sense
- don't protect IDA functions which use their own locking and where it's not
  needed
- use kmemdup() instead of kzalloc() + memcpy()
- collected review tags
- minor coding style fixes

v3 -> v4:
- return 'none' instead of 'n/a' from dev_name and chip_name before the device
  is registered
- use sysfs_emit() instead of s*printf()
- drop GPIO_SIM_MAX_PROP as it's only used in an array's definition where it's
  fine to hardcode the value

v4 -> v5:
- drop lib patches that are already upstream
- use BIT() instead of (1UL << bit) for flags
- fix refcounting for the configfs_dirent in rename()
- drop d_move() from the rename() callback
- free memory allocated for the live and pending groups in configfs_d_iput()
  and not in detach_groups()
- make sure that if a group of some name is in the live directory, a new group
  with the same name cannot be created in the pending directory

v5 -> v6:
- go back to using (1UL << bit) instead of BIT()
- if the live group dentry doesn't exist for whatever reason at the time when
  mkdir() in the pending group is called (would be a BUG()), return -ENOENT
  instead of -EEXIST which should only be returned if given subsystem already
  exists in either live or pending group

v6 -> v7:
- as detailed by Andy in commit 6fda593f3082 ("gpio: mockup: Convert to use
  software nodes") removing device properties after the platform device is
  removed but before the GPIO device gets dropped can lead to a use-after-free
  bug - use software nodes to manually control the freeing of the properties

v7 -> v8:
- fixed some minor coding style issues as pointed out by Andy

v8 -> v9:
- dropped the patches implementing committable-items and reworked the
  driver to not use them
- reworked the gpio-line-names property and configuring specific lines
  in general
- many smaller tweaks here and there

v9 -> v10:
- make writing to 'live' wait for the probe to finish and report an
  error to user-space if it failed
- add the ability to hog lines from the kernel-space
- rework locking (drop separate locks for line context objects)
- rework the sysfs interface (create a separate group for each line with
  a constant number of attributes instead of going the other way around)

Bartosz Golaszewski (5):
  gpiolib: provide gpiod_remove_hogs()
  gpio: sim: new testing module
  selftests: gpio: provide a helper for reading chip info
  selftests: gpio: add a helper for reading GPIO line names
  selftests: gpio: add test cases for gpio-sim

 Documentation/admin-guide/gpio/gpio-sim.rst   |   80 +
 drivers/gpio/Kconfig                          |    8 +
 drivers/gpio/Makefile                         |    1 +
 drivers/gpio/gpio-sim.c                       | 1370 +++++++++++++++++
 drivers/gpio/gpiolib.c                        |   11 +
 include/linux/gpio/machine.h                  |    2 +
 tools/testing/selftests/gpio/.gitignore       |    2 +
 tools/testing/selftests/gpio/Makefile         |    4 +-
 tools/testing/selftests/gpio/config           |    1 +
 tools/testing/selftests/gpio/gpio-chip-info.c |   57 +
 tools/testing/selftests/gpio/gpio-line-name.c |   55 +
 tools/testing/selftests/gpio/gpio-sim.sh      |  306 ++++
 12 files changed, 1895 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/admin-guide/gpio/gpio-sim.rst
 create mode 100644 drivers/gpio/gpio-sim.c
 create mode 100644 tools/testing/selftests/gpio/gpio-chip-info.c
 create mode 100644 tools/testing/selftests/gpio/gpio-line-name.c
 create mode 100755 tools/testing/selftests/gpio/gpio-sim.sh

-- 
2.25.1

