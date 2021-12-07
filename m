Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9576C46B72B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 10:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhLGJht (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 04:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhLGJhs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 04:37:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74677C061574
        for <linux-kselftest@vger.kernel.org>; Tue,  7 Dec 2021 01:34:18 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q3so28140433wru.5
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 01:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0t1FdK9iYN73YYJRN8Da3dhrOHX36q2qsy0Q6GdzTFA=;
        b=gzYnnnub1MsXfJuyjjXKCLgBzJlnjqRSvHgehItbJQTE7OQ2ZrUzj4FQkM79CbeKqR
         5iFD/4dJPpo8gck108JnYimSG8qYhNGsMu5pcRSI+sLbmQ/a13Bfdux+32QXVvSmRz1y
         WRPudhAT73HmG96vqYTzWOF1JisJMbnOZG5QCCb6Wh+L8bjNDT+DXQB5zY60aFGCBDy/
         /2SnD5R81Yh65gtp8+4JpnMViAepEw6XxsrZ/4hs8mR34YPGKq3l6PzAVKj0EVxcPMuM
         B4JuS36o5iVpbPZGpHSVAeC38vfNC/0SRTKl/TQMjhDVUQPr/Jnw286gTtQeowJeCqlu
         7qUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0t1FdK9iYN73YYJRN8Da3dhrOHX36q2qsy0Q6GdzTFA=;
        b=ivbacb84paBTEQ/Z+Mxg7d2ceuHIDdi21Czm+abGr3lUKqDJUo6YEeQdKInDOwhUYd
         lluQODPT5Mq50BZ4q2q7KoQ+ZQztSuZxoLpTbIzaaPva6RO+elI5mnJdAJ4EiIasqwN3
         VNTnOttGwZU+Ac95BT7jR4hcVogHIJOTR8HK1edhKidy/RJfEbkCnVRpa8Q3F/w7r85r
         GO5AgTFftLUpSI12eAnNtdV6h7soBBoE2ePrJJQMbfXMR48a7wsh/8UH6UL1AYmKPBH/
         /ljEG8RgRxK7ORUlgZMFx2j6eIp67nOjkdgrpheO6obfoEDGFjkmen28sxCAb3S+5BkK
         T07w==
X-Gm-Message-State: AOAM531nD1AJffyaOytC0q7/+YYai6WgDMuuJNMob82ZQhEAx9TIqa7b
        kyaEpmZdigmAdz1rebT5J7Pf5g==
X-Google-Smtp-Source: ABdhPJwfS6kJWS8IQ7vXlvbY1Lo+7vnBLLZwUTL6/BIixBzDzmYBx7R8+MpQ46t3Gkj36jam8t+9pg==
X-Received: by 2002:a5d:6d86:: with SMTP id l6mr49186283wrs.304.1638869657016;
        Tue, 07 Dec 2021 01:34:17 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id k13sm13783291wri.6.2021.12.07.01.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 01:34:16 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v13 0/7] gpio-sim: configfs-based GPIO simulator
Date:   Tue,  7 Dec 2021 10:34:05 +0100
Message-Id: <20211207093412.27833-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hopefully this will be the last iteration of this series. Just some
minor changes requested by Andy in this one.

Tested both with configfs as well as device-tree.

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

v10 -> v11:
- rework the configfs structure to represent a deeper hierarchy that
  gpiolib supports, namely: multiple banks per platform device

v11 -> v12:
- simplify patch 2/7 by removing any mentions of OF from gpiolib.c
- improve the documentation by adding rest markups
- add a device-tree sample to the docs
- drop some trailing whitespaces from the driver
- make gpio_sim_make_bank_swnode() static
- fix coding style in patch 6/7
- add patch 3/7 that makes the OF part of gpiolib prefer to use gpio_chip's fwnode (if set) over of_node

v12 -> v13:
- mentioned ACPI not being converted yet in patch 3/7
- avoided one allocation in gpio_sim_strdup_trimmed() by using memmove()
- use kstrtobool() where applicable
- allow all bases in gpio_sim_bank_config_num_lines_store()
- remove unnecessary commas
- use sysfs_match_string() where applicable
- drop unneeded curr_var local variable

Bartosz Golaszewski (7):
  gpiolib: provide gpiod_remove_hogs()
  gpiolib: allow to specify the firmware node in struct gpio_chip
  gpiolib: of: make fwnode take precedence in struct gpio_chip
  gpio: sim: new testing module
  selftests: gpio: provide a helper for reading chip info
  selftests: gpio: add a helper for reading GPIO line names
  selftests: gpio: add test cases for gpio-sim

 Documentation/admin-guide/gpio/gpio-sim.rst   |  134 ++
 drivers/gpio/Kconfig                          |    8 +
 drivers/gpio/Makefile                         |    1 +
 drivers/gpio/gpio-sim.c                       | 1589 +++++++++++++++++
 drivers/gpio/gpiolib-of.c                     |    3 +
 drivers/gpio/gpiolib.c                        |   18 +-
 include/linux/gpio/driver.h                   |    2 +
 include/linux/gpio/machine.h                  |    2 +
 tools/testing/selftests/gpio/.gitignore       |    2 +
 tools/testing/selftests/gpio/Makefile         |    4 +-
 tools/testing/selftests/gpio/config           |    1 +
 tools/testing/selftests/gpio/gpio-chip-info.c |   57 +
 tools/testing/selftests/gpio/gpio-line-name.c |   55 +
 tools/testing/selftests/gpio/gpio-sim.sh      |  396 ++++
 14 files changed, 2269 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/admin-guide/gpio/gpio-sim.rst
 create mode 100644 drivers/gpio/gpio-sim.c
 create mode 100644 tools/testing/selftests/gpio/gpio-chip-info.c
 create mode 100644 tools/testing/selftests/gpio/gpio-line-name.c
 create mode 100755 tools/testing/selftests/gpio/gpio-sim.sh

-- 
2.25.1

