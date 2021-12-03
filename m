Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7B467847
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 14:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352315AbhLCNdu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 08:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244857AbhLCNdt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 08:33:49 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2ABC061757
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 05:30:25 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so2219245wms.3
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Dec 2021 05:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwhaUG8BV21D7X8P/5YaBthI1oupop5F8Ojb8aCEATw=;
        b=55vBNi+8kGb5EpFV3a8gLK41v0xjQwWFIvJZsBj5vj/S0ydkM6oc/YNSQuHpsjsHsA
         F/U29G4qjbXqPf/6pG8sCYEGTugkVmXhIe3v9Y705cXDBjSXlMOk2Y1cAM6tRoeymhQt
         7t4fd/sAfiIAnx4vd8lsOH0hjHNr8Cg7Zi+AtRL/efhiQNfeJfldwI9Wq63S7vkvcmTt
         L+0ILNGhtYX9/dYqIhzqhPx93bh6gV0FKfPXnYHc9UuBfL5418R+LUrW+SKzHnbTkPrO
         Nx9+cBrYxHKgRyvZx9L4LG9zGnvT8TkTbnTcb/FwqEiIbcyTSb2/AIkrX9AqhQW6cvri
         L2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lwhaUG8BV21D7X8P/5YaBthI1oupop5F8Ojb8aCEATw=;
        b=tEhvit8WqmfH7Q/vybkIMGVaxR6eSF31HaizRrrZsqEKeHvUCxkCQv0bExKOG0xzDo
         sNWfMwPfgyX76U4dmXzBiMjHpGIcbApFHpnwVQFLqRIKbI7a2vBnQnHlZ6WnKkIMwjxl
         NoIGam2e4MUSVXdKeVN2aIVTV8d9wlTylKyZnH48m/JobEUCOpnzmrHme1xKnGbsOLR6
         tMBq2lT6FB0RIx/yANL72gDQhk1ZltEkXmwq3U7Wov74CRMNws5mXDZKbBqrgGoliDeU
         taxcUWe2u68RJT9EVkmEkfpSqNQJ9+s/KbsSnz+3Q0O1JiU1PDfF48AkpnyNvpLAgt3/
         yMcQ==
X-Gm-Message-State: AOAM530sbA/1/dPQJnzcf47TvPraTesF65owXGU6C2KwEgSGnvw652VV
        m2IAeoJxBP3FxOIfiv9c4TN8AQ==
X-Google-Smtp-Source: ABdhPJwNVofpclBtVapBhWHnRLCZpjdeR//+78Qwf/bGWW9GV94c20PEIl1tZQzT6iORFIYgNYoTWw==
X-Received: by 2002:a7b:cf35:: with SMTP id m21mr14568512wmg.140.1638538223852;
        Fri, 03 Dec 2021 05:30:23 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id j11sm2755910wrt.3.2021.12.03.05.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:30:23 -0800 (PST)
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
Subject: [PATCH v12 0/7] gpio-sim: configfs-based GPIO simulator
Date:   Fri,  3 Dec 2021 14:29:56 +0100
Message-Id: <20211203133003.31786-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Another iteration of gpio-sim patches. This time the changes are quite
small. I removed the ifdefs from gpiolib.c as requested by Andy. In this
version gpiolib-of will also prefer fwnodes over of_nodes and - if set -
will convert them to of_nodes before proceeding.

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
 drivers/gpio/gpio-sim.c                       | 1594 +++++++++++++++++
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
 14 files changed, 2274 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/admin-guide/gpio/gpio-sim.rst
 create mode 100644 drivers/gpio/gpio-sim.c
 create mode 100644 tools/testing/selftests/gpio/gpio-chip-info.c
 create mode 100644 tools/testing/selftests/gpio/gpio-line-name.c
 create mode 100755 tools/testing/selftests/gpio/gpio-sim.sh

-- 
2.25.1

