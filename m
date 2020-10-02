Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E2E2819CB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 19:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388530AbgJBRj4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 13:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbgJBRih (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 13:38:37 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D96C0613AA
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 10:38:36 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u3so1229917pjr.3
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=49NcK3Fme0jYUKwd2j3ovAlb1goyRmSbkHCdODdIeDc=;
        b=B2AcK2G2Zh3IWqw0qnXXSEyovKhS81QCGmrhMZ3ce/zFAH8Sg5udPHdnENJ50X13Ny
         mEJHMqIwsp/h8jMADbLs/i5ewGbAbYqXGdprV6QTunJ845w4WHhNz8T8QGab64x5e6+Q
         YLHO8obovOngL6OSrlrGgaARlZ7WxNMPSsEac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=49NcK3Fme0jYUKwd2j3ovAlb1goyRmSbkHCdODdIeDc=;
        b=RF6QlvtEzT1riSXmVnx4e7g+d1oaB2HMvNozyl88wMKPndeb+7MklnYYfWTIasBexn
         8GQegmlstlFBxbwRfWZOz0tZMHet+FdmW3QGt4hn1LVFMvHoK7bNbUBvjWhyDorTOiO7
         1OlL8AABJsrB4F5r8wqFmzoZAdaT5Y36BiND3GAmUw9pSf9h9uCpXDkCIYjMVpa1sk9e
         rFGyAL7Wg2AwfT7VGohTGH8OmnhbNqQaUpnLiWi6yQYRBP8zdPRPkLUe5NuyoZzSSS49
         RXhIo5nmO1Vf11DqybKn4hXCuoRSuO6iLCHHykXGcWJdLFy9XnZ38RBgGDJOTXPRhwwD
         aKiw==
X-Gm-Message-State: AOAM531hRcts0UbPUROTq7JEmFu7VEtL9hEFdDKewNB3MBxWCOfnhcez
        IkC5gDFoWvi0WtERIIQtNE6org==
X-Google-Smtp-Source: ABdhPJzd49fqaj3jNCPJ5+x9jDSGu4Py3vop91Y7k3rEOOPzUXlaVdJLNBBHCW5hBUb3EGuK0nLHtQ==
X-Received: by 2002:a17:90a:71c2:: with SMTP id m2mr4004540pjs.34.1601660315767;
        Fri, 02 Oct 2020 10:38:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q65sm2660305pfq.219.2020.10.02.10.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:38:33 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/16] Introduce partial kernel_read_file() support
Date:   Fri,  2 Oct 2020 10:38:12 -0700
Message-Id: <20201002173828.2099543-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v5:
- add more reviews (thank you!)
- add "description" string to post_load_data API (mimi)
- drop bug fix that got taken already
v4: https://lore.kernel.org/lkml/20200729175845.1745471-1-keescook@chromium.org/
v3: https://lore.kernel.org/lkml/20200724213640.389191-1-keescook@chromium.org/
v2: lost to the ether
v1: https://lore.kernel.org/lkml/20200717174309.1164575-1-keescook@chromium.org/

Hi,

Here's my tree for adding partial read support in kernel_read_file(),
which fixes a number of issues along the way. It's got Scott's firmware
and IMA patches ported and everything tests cleanly for me (even with
CONFIG_IMA_APPRAISE=y), and now appears to pass 0day. :)

The intention is for this to go via Greg's tree since Scott's driver
code will depend on it.

Thanks,

-Kees

Kees Cook (12):
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
 .../base/firmware_loader/fallback_platform.c  |  12 +-
 drivers/base/firmware_loader/firmware.h       |   7 +-
 drivers/base/firmware_loader/main.c           | 135 ++++++++++---
 fs/Makefile                                   |   3 +-
 fs/exec.c                                     | 132 +-----------
 fs/kernel_read_file.c                         | 189 ++++++++++++++++++
 include/linux/firmware.h                      |  12 ++
 include/linux/fs.h                            |  39 ----
 include/linux/ima.h                           |  20 +-
 include/linux/kernel_read_file.h              |  55 +++++
 include/linux/lsm_hook_defs.h                 |   6 +-
 include/linux/lsm_hooks.h                     |  13 ++
 include/linux/security.h                      |  21 +-
 kernel/kexec.c                                |   2 +-
 kernel/kexec_file.c                           |  19 +-
 kernel/module.c                               |  24 ++-
 lib/test_firmware.c                           | 154 ++++++++++++--
 security/integrity/digsig.c                   |   8 +-
 security/integrity/ima/ima_fs.c               |  10 +-
 security/integrity/ima/ima_main.c             |  73 +++++--
 security/integrity/ima/ima_policy.c           |   1 +
 security/loadpin/loadpin.c                    |  17 +-
 security/security.c                           |  28 ++-
 security/selinux/hooks.c                      |   8 +-
 .../selftests/firmware/fw_filesystem.sh       |  91 +++++++++
 27 files changed, 807 insertions(+), 296 deletions(-)
 create mode 100644 fs/kernel_read_file.c
 create mode 100644 include/linux/kernel_read_file.h

-- 
2.25.1

