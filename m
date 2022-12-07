Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B498645DE7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 16:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiLGPts (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 10:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiLGPtq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 10:49:46 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB6B27CE5
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 07:49:45 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d7so1106338pll.9
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Dec 2022 07:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SebK6VeMwVI8zNPc+AGDZ/foDvzVT7LenZ1q5aL6Vd0=;
        b=bXpIMlKZLOugUItEp+yK3IZEPErrpxgFQ3yGo+icXLxideMkE4N9Fl1V9tRqJmVJKL
         kkGO+i3x5P4gqnCUXgxjG6vCaQUG4ifV0IyOaZqXC1wAIy4PoD6cdcnJ+oJrZBc/aqiq
         xPr95nZlhxEuoy7lqLgIC5sVkXFhlAxbDK/BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SebK6VeMwVI8zNPc+AGDZ/foDvzVT7LenZ1q5aL6Vd0=;
        b=JfRW6cqHh4xcv+tLAcVEiJVo8PFy2qQPlP91BNAiLoKbOW6XirhApUcEOeGsTbXMbs
         /j+XO6MkLl910QC/F1wjerifcGhzt0Rd+pI+aOoZNEOTVsqfPXLrrzL1lS3ZXqSKzOmY
         cSnIfrgJeYOZe4TUTeuaa9M7Z4gCzz918tD2k9M9zx+PJOSXC16hqw+IzrYc6z02HSun
         c0LY0tBHf1N9OU9bfsZGyAv5ZbSUxUwh+21Zi0KXCS8jtDEpZFhADFo5gtdSeLYzrYQd
         nTO1d/UCieN5UKDZ8l9+VdSU2VdjZyM2UtjFT5OMpIfNlwZhEDKqARig/7j/l+80iPgh
         M2og==
X-Gm-Message-State: ANoB5pkfKCsXh3qSgvXCaYJQmHgK59tsiMB8EXYemsf0sQ7jwKXefka9
        e76ATetXsjxGgXB284UIYI/4ZQ==
X-Google-Smtp-Source: AA0mqf7DJw1rIWEXKC49n6cPVKA1w2gt+CVOmiPUQGyrAdU+wzfuFVLdh+Ap0uUT4HhJtSSro1Heww==
X-Received: by 2002:a17:902:9a82:b0:189:e085:8416 with SMTP id w2-20020a1709029a8200b00189e0858416mr714393plp.17.1670428184683;
        Wed, 07 Dec 2022 07:49:44 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b0017f7628cbddsm14920934plh.30.2022.12.07.07.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 07:49:44 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org
Subject: [PATCH v6 0/6] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
Date:   Wed,  7 Dec 2022 15:49:33 +0000
Message-Id: <20221207154939.2532830-1-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Since Linux introduced the memfd feature, memfd have always had their
execute bit set, and the memfd_create() syscall doesn't allow setting
it differently.

However, in a secure by default system, such as ChromeOS, (where all
executables should come from the rootfs, which is protected by Verified
boot), this executable nature of memfd opens a door for NoExec bypass
and enables “confused deputy attack”.  E.g, in VRP bug [1]: cros_vm
process created a memfd to share the content with an external process,
however the memfd is overwritten and used for executing arbitrary code
and root escalation. [2] lists more VRP in this kind.

On the other hand, executable memfd has its legit use, runc uses memfd’s
seal and executable feature to copy the contents of the binary then
execute them, for such system, we need a solution to differentiate runc's
use of  executable memfds and an attacker's [3].

To address those above, this set of patches add following:
1> Let memfd_create() set X bit at creation time.
2> Let memfd to be sealed for modifying X bit.
3> A new pid namespace sysctl: vm.memfd_noexec to control the behavior of
   X bit.For example, if a container has vm.memfd_noexec=2, then
   memfd_create() without MFD_NOEXEC_SEAL will be rejected.
4> A new security hook in memfd_create(). This make it possible to a new
LSM, which rejects or allows executable memfd based on its security policy.

This is V6 version of patch: see [4] [5] [6] [7] for previous versions.

[1] https://crbug.com/1305411
[2] https://bugs.chromium.org/p/chromium/issues/list?q=type%3Dbug-security%20memfd%20escalation&can=1
[3] https://lwn.net/Articles/781013/
[4] https://lwn.net/Articles/890096/
[5] https://lore.kernel.org/lkml/20220805222126.142525-1-jeffxu@google.com/
[6] https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
[7] https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/

Daniel Verkamp (2):
  mm/memfd: add F_SEAL_EXEC
  selftests/memfd: add tests for F_SEAL_EXEC

Jeff Xu (4):
  mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
  mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
  selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC
  mm/memfd: security hook for memfd_create

 include/linux/lsm_hook_defs.h              |   1 +
 include/linux/lsm_hooks.h                  |   4 +
 include/linux/pid_namespace.h              |  19 ++
 include/linux/security.h                   |   6 +
 include/uapi/linux/fcntl.h                 |   1 +
 include/uapi/linux/memfd.h                 |   4 +
 kernel/pid_namespace.c                     |   5 +
 kernel/pid_sysctl.h                        |  59 ++++
 mm/memfd.c                                 |  61 +++-
 mm/shmem.c                                 |   6 +
 security/security.c                        |  13 +
 tools/testing/selftests/memfd/fuse_test.c  |   1 +
 tools/testing/selftests/memfd/memfd_test.c | 348 ++++++++++++++++++++-
 13 files changed, 525 insertions(+), 3 deletions(-)
 create mode 100644 kernel/pid_sysctl.h


base-commit: eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

