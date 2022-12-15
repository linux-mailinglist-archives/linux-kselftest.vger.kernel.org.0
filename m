Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A81E64D468
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Dec 2022 01:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiLOAOT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 19:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLOANk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 19:13:40 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608CA511C6
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 16:12:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so1036152pjd.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Dec 2022 16:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5JdRkrY4AHyx5V8nEAerxJVsYW5SOsjwL/9h06jnfpo=;
        b=CgO9jXmXzNorxxCMtt58UeRi5g6/jidHsD3ynHjxaWxA8VdHsZJSxDrf+YAy5/+4rQ
         F0DOwu5R5L6IOCPs5dHRKeQXGZk6Kh4bxTWV9oyybTWUcY19oJZv1nYIn8SB8/kMT96W
         +UtNwSduBVXSD/fBZm3EIsNZoK1klg+cu/Qn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JdRkrY4AHyx5V8nEAerxJVsYW5SOsjwL/9h06jnfpo=;
        b=BqekwcaZETxrGhR315ovT9IyJZ6oHhIo+d512rQGuwO+3jPlCZWKgU3Avj5xQ21Ecg
         NlyVvUsZBqNn0x8zu0Jz960Eqj5Lj2EIIEnmlP5ow32CZcGBrqOhSh0zfdvQIp128JpU
         chvNunrtC+Klm8ewx3klS5JQHOzKTvHX97ZuN5y1j2r21NxDRK36lg3IwVXcXjmUkOhV
         jFAK2Ya4JxnTAyZIg9H6isUo5DLEN+gRmB1kIlJC8S0OVmezr8CchuMduEaBOiFzoMUE
         rikfjz20+tTZM9nrLirF/jldADwcqe7IXPxFGnjG0nGwgUQ4hnJjU+GlbBrWEKG4ED1H
         qg1g==
X-Gm-Message-State: ANoB5pkVZUAV6YpwSN8kgTbazfD12QUSj41QyWnmKDTYJfRxykMJeFZA
        zjy8oGrviW/2iuV1S5u3pJN7mEH1v0TBU9LM
X-Google-Smtp-Source: AA0mqf4gee2qnCLPj8VfLX1RD5pYa2Fu0Or+JQAcmS/nGUkyo0mE3KIi2PFynQkN56elG1XnNi/IHQ==
X-Received: by 2002:a17:90a:ee8a:b0:219:b034:9415 with SMTP id i10-20020a17090aee8a00b00219b0349415mr27482016pjz.12.1671063133657;
        Wed, 14 Dec 2022 16:12:13 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a08c300b0021937b2118bsm1845738pjn.54.2022.12.14.16.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:12:13 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v8 0/5] mm/memfd: introduce MFD_NOEXEC_SEAL and MFD_EXEC
Date:   Thu, 15 Dec 2022 00:12:00 +0000
Message-Id: <20221215001205.51969-1-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

Change history:
v8:
- Update ref bug in cover letter.
- Add Reviewed-by field.
- Remove security hook (security_memfd_create) patch, which will have
  its own patch set in future.

v7:
- patch 2/6: remove #ifdef and MAX_PATH (memfd_test.c).
- patch 3/6: check capability (CAP_SYS_ADMIN) from userns instead of
		global ns (pid_sysctl.h). Add a tab (pid_namespace.h).
- patch 5/6: remove #ifdef (memfd_test.c)
- patch 6/6: remove unneeded security_move_mount(security.c).

v6:https://lore.kernel.org/lkml/20221206150233.1963717-1-jeffxu@google.com/
- Address comment and move "#ifdef CONFIG_" from .c file to pid_sysctl.h

v5:https://lore.kernel.org/lkml/20221206152358.1966099-1-jeffxu@google.com/
- Pass vm.memfd_noexec from current ns to child ns.
- Fix build issue detected by kernel test robot.
- Add missing security.c

v3:https://lore.kernel.org/lkml/20221202013404.163143-1-jeffxu@google.com/
- Address API design comments in v2.
- Let memfd_create() to set X bit at creation time.
- A new pid namespace sysctl: vm.memfd_noexec to control behavior of X bit.
- A new security hook in memfd_create().

v2:https://lore.kernel.org/lkml/20220805222126.142525-1-jeffxu@google.com/
- address comments in V1.
- add sysctl (vm.mfd_noexec) to set the default file permissions of
  memfd_create to be non-executable.

v1:https://lwn.net/Articles/890096/

[1] https://crbug.com/1305267
[2] https://bugs.chromium.org/p/chromium/issues/list?q=type%3Dbug-security%20memfd%20escalation&can=1
[3] https://lwn.net/Articles/781013/

Daniel Verkamp (2):
  mm/memfd: add F_SEAL_EXEC
  selftests/memfd: add tests for F_SEAL_EXEC

Jeff Xu (3):
  mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
  mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
  selftests/memfd: add tests for MFD_NOEXEC_SEAL MFD_EXEC

 include/linux/pid_namespace.h              |  19 ++
 include/uapi/linux/fcntl.h                 |   1 +
 include/uapi/linux/memfd.h                 |   4 +
 kernel/pid_namespace.c                     |   5 +
 kernel/pid_sysctl.h                        |  59 ++++
 mm/memfd.c                                 |  56 +++-
 mm/shmem.c                                 |   6 +
 tools/testing/selftests/memfd/fuse_test.c  |   1 +
 tools/testing/selftests/memfd/memfd_test.c | 341 ++++++++++++++++++++-
 9 files changed, 489 insertions(+), 3 deletions(-)
 create mode 100644 kernel/pid_sysctl.h


base-commit: eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
-- 
2.39.0.rc1.256.g54fd8350bd-goog

