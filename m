Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89AA41C9F89
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 02:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgEHA1x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 May 2020 20:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726518AbgEHA1w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 May 2020 20:27:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28140C05BD0A
        for <linux-kselftest@vger.kernel.org>; Thu,  7 May 2020 17:27:52 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t40so3412618pjb.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 May 2020 17:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V0C3bRiQIupjvnAB404TNg3msK2myuQCmZ2x7HRHG2I=;
        b=Jj5o2Eh+WgC06ImxPAdAiLKa43hIVr2SX7PjM5ta2/GY9A8rSs1GqK+RFCHZ9xbE0u
         Oj6CkcxAK/e5keveJNLW6FVl+GLxByi6cVM3Q1SDB3TlG+bD9rIluZ8RJ8OnPVjk1+MN
         Fn8EaOsdeA5cq27MGG/osiw6jB4oxDEZ8o+xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V0C3bRiQIupjvnAB404TNg3msK2myuQCmZ2x7HRHG2I=;
        b=cOINn9HxF93jjacr2ki1NqkbQnUNSYBB0+tFJ3kSY5qWJmk86qzz29t8QdoS0Up8xC
         3XSGR6RTtnKjt/JjpxuC8A1PDz3OV7kHIpncQ2I/NqxDk8PWD1U8ft0LhwlEde5F4W3a
         Rz5giIcIrv8+RDzTT5FmpahGOIzBu9F+OKlzviDS79ZEXS/UOoXrw5qmwYyUzRlctMVV
         7qR54QXgpk8tjZLvqqu+qusjauDA5hM/oxpFnyGR3dKq8+P9ZI/xqRg8r4Rzy7UEVj9H
         eQ8gkoQQFvWvz3E77usAexGGB3oOk0qXO8m5zmEAr99QIkalN8fs8vRni13TcyVlEUfJ
         8XHA==
X-Gm-Message-State: AGi0PuZv/MvZWxKN1g1+y3ESd52I+vQfdX+PiQLp6LHhP2yzNU9Q3qp/
        YM6QHaKkWCfQADYRo3TukGZ7xw==
X-Google-Smtp-Source: APiQypIrISlpFBZ5rGaJiOwmwZHu5iw0N4E5PXxBU6UMHNreuj28ULfxOutLAPlluYPOfVW3wU/lww==
X-Received: by 2002:a17:90a:3b0c:: with SMTP id d12mr2871289pjc.78.1588897671362;
        Thu, 07 May 2020 17:27:51 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id gz14sm882677pjb.42.2020.05.07.17.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 17:27:50 -0700 (PDT)
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
        Andy Gross <agross@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v5 0/7] firmware: add partial read support in request_firmware_into_buf
Date:   Thu,  7 May 2020 17:27:32 -0700
Message-Id: <20200508002739.19360-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Please consider this version series ready for upstream acceptance.

This patch series adds partial read support in request_firmware_into_buf.
In order to accept the enhanced API it has been requested that kernel
selftests and upstreamed driver utilize the API enhancement and so
are included in this patch series.

Also in this patch series is the addition of a new Broadcom VK driver
utilizing the new request_firmware_into_buf enhanced API.

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

Scott Branden (7):
  fs: introduce kernel_pread_file* support
  firmware: add offset to request_firmware_into_buf
  test_firmware: add partial read support for request_firmware_into_buf
  firmware: test partial file reads of request_firmware_into_buf
  bcm-vk: add bcm_vk UAPI
  misc: bcm-vk: add Broadcom VK driver
  MAINTAINERS: bcm-vk: add maintainer for Broadcom VK Driver

 MAINTAINERS                                   |    7 +
 drivers/base/firmware_loader/firmware.h       |    5 +
 drivers/base/firmware_loader/main.c           |   52 +-
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/bcm-vk/Kconfig                   |   29 +
 drivers/misc/bcm-vk/Makefile                  |   12 +
 drivers/misc/bcm-vk/bcm_vk.h                  |  435 +++++
 drivers/misc/bcm-vk/bcm_vk_dev.c              | 1256 +++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_legacy.c           |   89 +
 drivers/misc/bcm-vk/bcm_vk_msg.c              | 1425 +++++++++++++++++
 drivers/misc/bcm-vk/bcm_vk_msg.h              |  196 +++
 drivers/misc/bcm-vk/bcm_vk_sg.c               |  271 ++++
 drivers/misc/bcm-vk/bcm_vk_sg.h               |   60 +
 drivers/misc/bcm-vk/bcm_vk_tty.c              |  352 ++++
 drivers/soc/qcom/mdt_loader.c                 |    7 +-
 fs/exec.c                                     |   96 +-
 include/linux/firmware.h                      |    8 +-
 include/linux/fs.h                            |   20 +
 include/uapi/linux/misc/bcm_vk.h              |   99 ++
 lib/test_firmware.c                           |  144 +-
 .../selftests/firmware/fw_filesystem.sh       |   80 +
 22 files changed, 4596 insertions(+), 49 deletions(-)
 create mode 100644 drivers/misc/bcm-vk/Kconfig
 create mode 100644 drivers/misc/bcm-vk/Makefile
 create mode 100644 drivers/misc/bcm-vk/bcm_vk.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_dev.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_legacy.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_msg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.c
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_sg.h
 create mode 100644 drivers/misc/bcm-vk/bcm_vk_tty.c
 create mode 100644 include/uapi/linux/misc/bcm_vk.h

-- 
2.17.1

