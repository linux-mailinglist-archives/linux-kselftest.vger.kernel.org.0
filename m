Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A8122D11F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jul 2020 23:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgGXViq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jul 2020 17:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgGXVgp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jul 2020 17:36:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD70C0698C4
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 14:36:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so6155538pgq.1
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Jul 2020 14:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuSR5OKebfZG9zBTcnsVSNOUx+p1wthou5r7P45Dqng=;
        b=e2g/T7ESZvOK2o3dhi05Vn3Jsik1P7GtuHpRHV97nJhR9chmHD3goRnMyfoRIvXkpJ
         NotPjBIoK9R7ayTLCq5EVGqMimLDdpJZE8JgRudIQ2sj3I259P0AVctQODLLRz2Z1kAe
         FBmH2mq4JZ0WMzHPmHsazvYGXFK3T17zub/5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuSR5OKebfZG9zBTcnsVSNOUx+p1wthou5r7P45Dqng=;
        b=Fr30C/+qLHQQf1sQD0xrAlPzN8NDjdsv8jrIfhYau4/iiec/QdWyw/CUGXc44Kf7DB
         bu0P+sn0FiM5tqYW6kpo6ZOzcZTeXpuE2DHzniG7TLvaseEDFJsUGsEzGkr5Dbmhtqby
         Cp6BXi40PRcn94shSbQ43wQsSJ0AMlVA/WUn2celS0kzgePxy23iX11YQtoAJtP92tez
         iSqr6Unda1TwONiMR5hTcUNNzRLcj9O9/U1Jxk22yXKQ3sJ2PiFnoQt+8cQy52riMZVq
         IuykryBJfRCjbvv8rngh/j2C0Dpbp1lA0QnjuK3ongwmS42/g4CJzrMg4mYIi4z3qgZs
         n65A==
X-Gm-Message-State: AOAM531Fmcc4cEZK4Rs47+PTf2K5RQy7x4I5HJ7clzgoZyTpckm4C9Zj
        LJeaQGVAm9i5U3SqaWMDbEzv2Q==
X-Google-Smtp-Source: ABdhPJxK435CF+iz91hGK+5NgHvqqee3eWSsmt07ckHJqnxWEFT9dhACW0dihJg65rKzTr+cdKdf2g==
X-Received: by 2002:a65:6119:: with SMTP id z25mr10602187pgu.52.1595626605323;
        Fri, 24 Jul 2020 14:36:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 19sm7331534pfy.193.2020.07.24.14.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:36:43 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/19] Introduce partial kernel_read_file() support
Date:   Fri, 24 Jul 2020 14:36:21 -0700
Message-Id: <20200724213640.389191-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v3:
- add reviews/acks
- add "IMA: Add support for file reads without contents" patch
- trim CC list, in case that's why vger ignored v2
v2: [missing from lkml archives! (CC list too long?) repeating changes here]
- fix issues in firmware test suite
- add firmware partial read patches
- various bug fixes/cleanups
v1: https://lore.kernel.org/lkml/20200717174309.1164575-1-keescook@chromium.org/

Hi,

Here's my tree for adding partial read support in kernel_read_file(),
which fixes a number of issues along the way. It's got Scott's firmware
and IMA patches ported and everything tests cleanly for me (even with
CONFIG_IMA_APPRAISE=y).

I think the intention is for this to go via Greg's tree since Scott's
driver code will depend on it?

Thanks,

-Kees


Kees Cook (15):
  test_firmware: Test platform fw loading on non-EFI systems
  selftest/firmware: Add selftest timeout in settings
  firmware_loader: EFI firmware loader must handle pre-allocated buffer
  fs/kernel_read_file: Remove FIRMWARE_PREALLOC_BUFFER enum
  fs/kernel_read_file: Remove FIRMWARE_EFI_EMBEDDED enum
  fs/kernel_read_file: Split into separate source file
  fs/kernel_read_file: Remove redundant size argument
  fs/kernel_read_file: Switch buffer size arg to size_t
  fs/kernel_read_file: Add file_size output argument
  LSM: Introduce kernel_post_load_data() hook
  firmware_loader: Use security_post_load_data()
  module: Call security_kernel_post_load_data()
  LSM: Add "contents" flag to kernel_read_file hook
  fs/kernel_file_read: Add "offset" arg for partial reads
  firmware: Store opt_flags in fw_priv

Scott Branden (4):
  fs/kernel_read_file: Split into separate include file
  IMA: Add support for file reads without contents
  firmware: Add request_partial_firmware_into_buf()
  test_firmware: Test partial read support

 drivers/base/firmware_loader/fallback.c       |  19 +-
 drivers/base/firmware_loader/fallback.h       |   5 +-
 .../base/firmware_loader/fallback_platform.c  |  16 +-
 drivers/base/firmware_loader/firmware.h       |   7 +-
 drivers/base/firmware_loader/main.c           | 143 ++++++++++---
 drivers/firmware/efi/embedded-firmware.c      |  21 +-
 drivers/firmware/efi/embedded-firmware.h      |  19 ++
 fs/Makefile                                   |   3 +-
 fs/exec.c                                     | 132 +-----------
 fs/kernel_read_file.c                         | 189 ++++++++++++++++++
 include/linux/efi_embedded_fw.h               |  13 --
 include/linux/firmware.h                      |  12 ++
 include/linux/fs.h                            |  39 ----
 include/linux/ima.h                           |  19 +-
 include/linux/kernel_read_file.h              |  55 +++++
 include/linux/lsm_hook_defs.h                 |   6 +-
 include/linux/lsm_hooks.h                     |  12 ++
 include/linux/security.h                      |  19 +-
 kernel/kexec.c                                |   2 +-
 kernel/kexec_file.c                           |  19 +-
 kernel/module.c                               |  24 ++-
 lib/test_firmware.c                           | 159 +++++++++++++--
 security/integrity/digsig.c                   |   8 +-
 security/integrity/ima/ima_fs.c               |  10 +-
 security/integrity/ima/ima_main.c             |  70 +++++--
 security/integrity/ima/ima_policy.c           |   1 +
 security/loadpin/loadpin.c                    |  17 +-
 security/security.c                           |  26 ++-
 security/selinux/hooks.c                      |   8 +-
 .../selftests/firmware/fw_filesystem.sh       |  91 +++++++++
 tools/testing/selftests/firmware/settings     |   8 +
 tools/testing/selftests/kselftest/runner.sh   |   6 +-
 32 files changed, 860 insertions(+), 318 deletions(-)
 create mode 100644 drivers/firmware/efi/embedded-firmware.h
 create mode 100644 fs/kernel_read_file.c
 create mode 100644 include/linux/kernel_read_file.h
 create mode 100644 tools/testing/selftests/firmware/settings

-- 
2.25.1

