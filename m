Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB84455E99
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 15:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhKROy6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Nov 2021 09:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhKROy6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Nov 2021 09:54:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2DAC061748
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 06:51:58 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d27so12069448wrb.6
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 06:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l/3Z4XGcqYwV4V6oJiYgbORs/SEqlAwMD+aKJHi8Aw0=;
        b=loM5pLXRmcR68RfF6U0PZ3BKyaZb2Jr/o6CnjIAntvneXNEqrHNr7hUcYluL/tLnly
         FDsuKH7X5M0cMQqBDPP4IGCLTZT7sCCtl068RtVv5M8w3NyRZtcX6r2p4SnVeAc6DUSF
         CKHB0nJv2kHTDsPFC1SxDFH2lNeinGpB/MOuAEsxTXGFFctRqE22ksPYxfDK7TWze708
         v00Uv3akr65t5pQgoFcxoj2jT7HCJp3XqLa775zyxu38UHt1Enj2rU90SmytmQKP+8EH
         M+bVpz+tyCf2IcoPx0RgwfmP63gJend3y8vEd0Xc51LOrKE8120PhFkaR6/4MWbwISQI
         kyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l/3Z4XGcqYwV4V6oJiYgbORs/SEqlAwMD+aKJHi8Aw0=;
        b=sI/7XjsyuvOsH3PHevUL/5fPhSXLbu3DO5QlpFwNu3tByTS2/UawWpvM8/v/eP0AtD
         ygsi8uNMpp2Yxla+rl7c/5neLylayAJUVS3UJJtqnNeEx0Kf4PzP19jTa1fFMlkoNckn
         1ntxDX+M7YznftXDJMmD/tjq7S15L97eS+05QwExPgIXkfYqRTuWzBTsITDgZOHJHMg9
         iiPbjkyDb4cAM9CpyVDDjMrsjnr6E7u0GTSId0bA9yJJJe1Wdq07gfW5lz3tIwqPfOs1
         RxcWkhcwQM3/NIhW3WTWSMCzRsHlR6iQImBk6nJpgi9JQabdNLkns6EKgTSp/wubQSMs
         IwBg==
X-Gm-Message-State: AOAM531STlwCZ++jB9qeXDSfvpsiROEoIP7y15blDL+i7rlk3Ya9pELI
        gsoRyaHfLbNqyE5TTj/40BOHq2KOF/cEuGp8
X-Google-Smtp-Source: ABdhPJyNxJobDwtILjTC6h5Cp05n1wiYxhZhxizHmJukDD8j8h6sjQv2l2t4xzah0tH4iZGJPmEgYA==
X-Received: by 2002:adf:d22a:: with SMTP id k10mr31239898wrh.80.1637247116671;
        Thu, 18 Nov 2021 06:51:56 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id f7sm63154wri.74.2021.11.18.06.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 06:51:56 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v9 0/4] gpio-sim: configfs-based GPIO simulator
Date:   Thu, 18 Nov 2021 15:51:38 +0100
Message-Id: <20211118145142.14519-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is another shot at the gpio-sim testing module. As there was no
reasoning with configfs maintainers for many months, this time the whole
concept of committable items has been dropped. Instead, each configfs
chip item (or rather a group - more on that later) exposes a new
attribute called 'live'. Writing 1 to it brings the chip on-line
(registers the platform device) and writing 0 tears it down.

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
configuration for specific lines. Currently we only support the 'name'
attribute but I plan to extend that to support GPIO hogging too.

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

Bartosz Golaszewski (4):
  gpio: sim: new testing module
  selftests: gpio: provide a helper for reading chip info
  selftests: gpio: add a helper for reading GPIO line names
  selftests: gpio: add test cases for gpio-sim

 Documentation/admin-guide/gpio/gpio-sim.rst   |  67 ++
 drivers/gpio/Kconfig                          |   8 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-sim.c                       | 990 ++++++++++++++++++
 tools/testing/selftests/gpio/.gitignore       |   2 +
 tools/testing/selftests/gpio/Makefile         |   4 +-
 tools/testing/selftests/gpio/config           |   1 +
 tools/testing/selftests/gpio/gpio-chip-info.c |  57 +
 tools/testing/selftests/gpio/gpio-line-name.c |  55 +
 tools/testing/selftests/gpio/gpio-sim.sh      | 266 +++++
 10 files changed, 1449 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/admin-guide/gpio/gpio-sim.rst
 create mode 100644 drivers/gpio/gpio-sim.c
 create mode 100644 tools/testing/selftests/gpio/gpio-chip-info.c
 create mode 100644 tools/testing/selftests/gpio/gpio-line-name.c
 create mode 100755 tools/testing/selftests/gpio/gpio-sim.sh

-- 
2.25.1

