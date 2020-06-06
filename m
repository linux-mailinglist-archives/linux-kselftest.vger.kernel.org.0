Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E31F050D
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jun 2020 07:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgFFFFp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Jun 2020 01:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgFFFFo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Jun 2020 01:05:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B76C08C5C4
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Jun 2020 22:05:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v24so4506413plo.6
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Jun 2020 22:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tZK4z4NpRXbZ8SJxKOE6PewY/fU6fvBPpDi8Rn1Dflg=;
        b=BNngZ7SHzjRf6h0P9KT4WtAybmmNTGYWY2Nie7eI7GIDB6ADUhA4NxRmqdoLcrhJA6
         3EBImbWjgk0rjo6Pk3HclIPD8NLbduxN+xNIPWrCIGYMvcF3WF28ZCqWTmk5+IIFRhkv
         vB8odMxQz900yo2V6z3jc0h0Z78Ygosdfwm2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tZK4z4NpRXbZ8SJxKOE6PewY/fU6fvBPpDi8Rn1Dflg=;
        b=SrHg74NlcUrCENfZGOVRo3Q/WaRtDbs3FrO8RgKGSQVZMgaBDiMof+Hf5c4WO3ibnF
         ll/yYIhVOZlNNiMg5ON5VsOsh12nod42lPZ19zlR45it3Ewu2OFyq0zUS/lpXcdz0fEd
         0yezdUeogQJ06QciV85FoLFvHU0it5slSDBwxqwQisOFBtPAsdUfIrbnOenmCwB67KgT
         ZAbL8h9dDCbrLVIfLCAd7CxIwA8rVU1UCzfnG5T3mxytUD4rYa+2v7kJIHx0MMIB/EKK
         7JHuknA7JvIG6vP+L6OJ74+QO9ce2PB4b1zwkNC+W7doXRJG+/ibq+rFLXCXHTJtcy7y
         yejQ==
X-Gm-Message-State: AOAM532gK7XZCHkKH+IzhnZ6BDdUtv+2gxAejvnsNTW5W0mG64ohGFRT
        Nt0+sJRpj9fD5AzaExq85EqA1w==
X-Google-Smtp-Source: ABdhPJzAWgx3RsxBTLvWnN69wJxCUJCvJ7BnPkT4keJT4glrjGJmMarQpXqtJ1jeJ0zvETXkYMcx+A==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr13046012pls.304.1591419943488;
        Fri, 05 Jun 2020 22:05:43 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v8sm1057636pfn.217.2020.06.05.22.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 22:05:42 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v7 0/8] firmware: add partial read support in request_firmware_into_buf
Date:   Fri,  5 Jun 2020 22:04:50 -0700
Message-Id: <20200606050458.17281-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch series adds partial read support in request_firmware_into_buf.
In order to accept the enhanced API it has been requested that kernel
selftests and upstreamed driver utilize the API enhancement and so
are included in this patch series.

Also in this patch series is the addition of a new Broadcom VK driver
utilizing the new request_firmware_into_buf enhanced API.

Further comment followed to add IMA support of the partial reads
originating from request_firmware_into_buf calls.

Changes from v6:
 - update ima_post_read_file check on IMA_FIRMWARE_PARTIAL_READ
 - adjust new driver i2c-slave-eeprom.c use of request_firmware_into_buf
 - remove an extern
Changes from v5:
 - add IMA FIRMWARE_PARTIAL_READ support
 - change kernel pread flags to enum
 - removed legacy support from driver
 - driver fixes
Changes from v4:
 - handle reset issues if card crashes
 - allow driver to have min required msix
 - add card utilization information
Changes from v3:
 - fix sparse warnings
 - fix printf format specifiers for size_t
 - fix 32-bit cross-compiling reports 32-bit shifts
 - use readl/writel,_relaxed to access pci ioremap memory,
  removed memory barriers and volatile keyword with such change
 - driver optimizations for interrupt/poll functionalities
Changes from v2:
 - remove unnecessary code and mutex locks in lib/test_firmware.c
 - remove VK_IOCTL_ACCESS_BAR support from driver and use pci sysfs instead
 - remove bitfields
 - remove Kconfig default m
 - adjust formatting and some naming based on feedback
 - fix error handling conditions
 - use appropriate return codes
 - use memcpy_toio instead of direct access to PCIE bar

Scott Branden (8):
  fs: introduce kernel_pread_file* support
  firmware: add offset to request_firmware_into_buf
  test_firmware: add partial read support for request_firmware_into_buf
  firmware: test partial file reads of request_firmware_into_buf
  bcm-vk: add bcm_vk UAPI
  misc: bcm-vk: add Broadcom VK driver
  MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver
  ima: add FIRMWARE_PARTIAL_READ support

 MAINTAINERS                                   |    7 +
 drivers/base/firmware_loader/firmware.h       |    5 +
 drivers/base/firmware_loader/main.c           |   59 +-
 drivers/i2c/i2c-slave-eeprom.c                |    4 +-
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/bcm-vk/Kconfig                   |   29 +
 drivers/misc/bcm-vk/Makefile                  |   11 +
 drivers/misc/bcm-vk/bcm_vk.h                  |  408 +++++
 drivers/misc/bcm-vk/bcm_vk_dev.c              | 1312 +++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.c              | 1438 +++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h              |  201 +++
 drivers/misc/bcm-vk/bcm_vk_sg.c               |  271 ++++
 drivers/misc/bcm-vk/bcm_vk_sg.h               |   60 +
 drivers/misc/bcm-vk/bcm_vk_tty.c              |  352 ++++
 drivers/soc/qcom/mdt_loader.c                 |    7 +-
 fs/exec.c                                     |  101 +-
 include/linux/firmware.h                      |    8 +-
 include/linux/fs.h                            |   30 +
 include/uapi/linux/misc/bcm_vk.h              |   99 ++
 lib/test_firmware.c                           |  144 +-
 security/integrity/ima/ima_main.c             |   24 +-
 .../selftests/firmware/fw_filesystem.sh       |   80 +
 23 files changed, 4598 insertions(+), 54 deletions(-)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

-- 
2.17.1

