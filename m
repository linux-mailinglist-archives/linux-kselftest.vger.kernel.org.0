Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58D0B99FFC
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2019 21:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389239AbfHVTZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Aug 2019 15:25:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40559 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391877AbfHVTZH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Aug 2019 15:25:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so4234391pgj.7
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Aug 2019 12:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V6iaCvkOKV70LTF1R2QxVbxqJJklSryV7VrfrPuNBPI=;
        b=WM1U6q3fPx6VAdWuhVbasFSZ7o86MDefD/45MBjids0aZXHG3L567a42cBKkzs82Zy
         zepTPT7of9GWrAA3oxb/hR24FzE6TL1jBjFt/La5FVBTSo5fAU9pLUw8QsoTi8c39do6
         K6CLNpIF2TTudMamXSJHhT0QSIy/Gk+Qg06W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V6iaCvkOKV70LTF1R2QxVbxqJJklSryV7VrfrPuNBPI=;
        b=ouFbwrDPF2KzTYtDHUUyuEGUJclttObp9s5TwR+WQdoIl8U0piOKwFB0MlmpL87GxE
         2kAPR9xSUHBNZJeWFlVA6bdhOpB4KKKQLSsey2tfsMXb4fFxgk2w6ZoxHQvPqsL8znSp
         qv9v57Zse0Kn2syjvzZ9dixdxZyY16G49V2hgi+LuVgkxVSbq1uPgTol6pZ8GAQUcLWK
         XUmh1xvtTukDfIBzSD4bWdAmGXcaNDhlw1vPLbnaXm6M0KW2ryXmb8O+rOgNWFI0B8co
         ZJxRi/FQigpPm6Ch4WVcfbW2j4lLn/m+rEkXr5y7fx4RTpU14vHW4ANCi3x1TsdiJYYj
         ctWA==
X-Gm-Message-State: APjAAAXfTchQvbZQFWqQ4YzVqoMzC/Fbk8pihdq7J6LH826WJHDkdxAL
        YN30dBq1RlF+yBTnezS+cPU86Q==
X-Google-Smtp-Source: APXvYqzSHf/VaI25XUU6JwgxHcTwum+eqwNg/nDEX2+Z4NtuYsQqfDBBgWEP7OESrOUbhgp0aExEbQ==
X-Received: by 2002:a62:7503:: with SMTP id q3mr859120pfc.151.1566501906434;
        Thu, 22 Aug 2019 12:25:06 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id c12sm198018pfc.22.2019.08.22.12.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:25:05 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH 0/7] firmware: add partial read support in request_firmware_into_buf
Date:   Thu, 22 Aug 2019 12:24:44 -0700
Message-Id: <20190822192451.5983-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series adds partial read support in request_firmware_into_buf.
In order to accept the enhanced API it has been requested that kernel
selftests and upstreamed driver utilize the API enhancement and so
are included in this patch series.

Also, no tests existed for existing request_firmware_into_buf kernel API.
Therefore tests have been created and submitted upstream here:
"[PATCH v2 0/2] firmware: selftest for request_firmware_into_buf"
https://lkml.org/lkml/2019/8/22/1367

The firmware selftests patches here require those patches to
be applied first in order for the firmware selftest patches in this
series to be valid.

Finally, in this patch series is the addition of a new Broadcom Valkyrie driver
utilizing the new request_firmware_into_buf enhanced API.

Scott Branden (7):
  fs: introduce kernel_pread_file* support
  firmware: add offset to request_firmware_into_buf
  test_firmware: add partial read support for request_firmware_into_buf
  selftests: firmware: Test partial file reads of
    request_firmware_into_buf
  bcm-vk: add bcm_vk UAPI
  misc: bcm-vk: add Broadcom Valkyrie driver
  MAINTAINERS: bcm-vk: Add maintainer for Broadcom Valkyrie Driver

 MAINTAINERS                                   |    7 +
 drivers/base/firmware_loader/firmware.h       |    5 +
 drivers/base/firmware_loader/main.c           |   49 +-
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/bcm-vk/Kconfig                   |   16 +
 drivers/misc/bcm-vk/Makefile                  |    7 +
 drivers/misc/bcm-vk/README                    |   29 +
 drivers/misc/bcm-vk/bcm_vk.h                  |  229 +++
 drivers/misc/bcm-vk/bcm_vk_dev.c              | 1558 +++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c              |  963 ++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h              |  169 ++
 drivers/misc/bcm-vk/bcm_vk_sg.c               |  273 +++
 drivers/misc/bcm-vk/bcm_vk_sg.h               |   60 +
 drivers/soc/qcom/mdt_loader.c                 |    7 +-
 fs/exec.c                                     |   77 +-
 include/linux/firmware.h                      |    8 +-
 include/linux/fs.h                            |   15 +
 include/uapi/linux/misc/bcm_vk.h              |   88 +
 lib/test_firmware.c                           |  139 +-
 .../selftests/firmware/fw_filesystem.sh       |   80 +
 21 files changed, 3744 insertions(+), 37 deletions(-)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/README
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

-- 
2.17.1

