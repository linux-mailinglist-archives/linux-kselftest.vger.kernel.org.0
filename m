Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5B277B464
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 10:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjHNIl5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 04:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjHNIlc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 04:41:32 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3906612E;
        Mon, 14 Aug 2023 01:41:30 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RPSYL1pknz9sSk;
        Mon, 14 Aug 2023 10:41:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1692002486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NUboT/tyGwRN+QiGFmvbhFhtxEwoPw7Up8T9SpZltac=;
        b=eX0Te5I6hNL8L4CL7n0OvdpsIRx4kaXqNueehUKepAeG+Sd+Qq6MBXlO/GGJcDWfbD1lOC
        Lhw0bL0MfKg0xckibbKAez65geHBSd6Mtac8QgW1XaPyPzBmGXmZprz145Kxo3BwIO+9jW
        gOKc4k4SN2vFpEYYAWDcQYJT5KrrtqcFlOrZjJZ2lJaXaEhESt6MVnd7KmLzcKxmkqWD26
        d0Y3gAkGH3kU1kTNNlZbs3oMc85pXONy+EVjrpylEl7dIW/Tzfz5hbSB6TCNqnlE1V98gp
        V6dYzAVf/NZqVl2RJR5ycyGZ9Lj0aOOjqtpbiRurgTcp/+QYLhVNis6HvTF3jQ==
From:   Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH v2 0/5] memfd: cleanups for vm.memfd_noexec
Date:   Mon, 14 Aug 2023 18:40:56 +1000
Message-Id: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJjo2WQC/42OOw6DMBBEr4JcZ5E/BKJU3COicMw6dmGM1gSBE
 HePIUXaVKOn0TzNxhKSx8TuxcYIZ598HDLIS8GM08MLwfeZmeRS8RtXEDDYHuYAQ8QFDbz16MH
 6BRNog428mrp5csuyYCQ8i7x/dJktxQCTI9Q/ZSOUqFTF6/IICQLMOjpN7TdKE8Ohcj5Nkdbz5
 iwO4f/zbt/3D0hF7PboAAAA
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4851; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=dGi8A78yZ0SfEXLJu8jrgDZL5aiUP2hWwUC4ADrzENg=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTcfLFsU0K62YabZfmtzopLqiwzPh5c/dZd3uq54Z1Xn
 THv7Q3yO0pZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBEfngz/OFT3n66XilEuWbV
 v0+5m5bWnF12LCrPd3HIo8dCHS0L1r9l+J+iJJdq8UqKraznccSsZybhN99m7+KUYddfLz254YO
 3JRsA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The most critical issue with vm.memfd_noexec=2 (the fact that passing
MFD_EXEC would bypass it entirely[1]) has been fixed in Andrew's
tree[2], but there are still some outstanding issues that need to be
addressed:

 * vm.memfd_noexec=2 shouldn't reject old-style memfd_create(2) syscalls
   because it will make it far to difficult to ever migrate. Instead it
   should imply MFD_EXEC.

 * The dmesg warnings are pr_warn_once(), which on most systems means
   that they will be used up by systemd or some other boot process and
   userspace developers will never see it.

   - For the !(flags & (MFD_EXEC | MFD_NOEXEC_SEAL)) case, outputting a
     rate-limited message to the kernel log is necessary to tell
     userspace that they should add the new flags.

     Arguably the most ideal way to deal with the spam concern[3,4]
     while still prompting userspace to switch to the new flags would be
     to only log the warning once per task or something similar.
     However, adding something to task_struct for tracking this would be
     needless bloat for a single pr_warn_ratelimited().

     So just switch to pr_info_ratelimited() to avoid spamming the log
     with something that isn't a real warning. There's lots of
     info-level stuff in dmesg, it seems really unlikely that this
     should be an actual problem. Most programs are already switching to
     the new flags anyway.

   - For the vm.memfd_noexec=2 case, we need to log a warning for every
     failure because otherwise userspace will have no idea why their
     previously working program started returning -EACCES (previously
     -EINVAL) from memfd_create(2). pr_warn_once() is simply wrong here.

 * The racheting mechanism for vm.memfd_noexec makes it incredibly
   unappealing for most users to enable the sysctl because enabling it
   on &init_pid_ns means you need a system reboot to unset it. Given the
   actual security threat being protected against, CAP_SYS_ADMIN users
   being restricted in this way makes little sense.

   The argument for this ratcheting by the original author was that it
   allows you to have a hierarchical setting that cannot be unset by
   child pidnses, but this is not accurate -- changing the parent
   pidns's vm.memfd_noexec setting to be more restrictive didn't affect
   children.

   Instead, switch the vm.memfd_noexec sysctl to be properly
   hierarchical and allow CAP_SYS_ADMIN users (in the pidns's owning
   userns) to lower the setting as long as it is not lower than the
   parent's effective setting. This change also makes it so that
   changing a parent pidns's vm.memfd_noexec will affect all
   descendants, providing a properly hierarchical setting. The
   performance impact of this is incredibly minimal since the maximum
   depth of pidns is 32 and it is only checked during memfd_create(2)
   and unshare(CLONE_NEWPID).

 * The memfd selftests would not exit with a non-zero error code when
   certain tests that ran in a forked process (specifically the ones
   related to MFD_EXEC and MFD_NOEXEC_SEAL) failed.

[1]: https://lore.kernel.org/all/ZJwcsU0vI-nzgOB_@codewreck.org/
[2]: https://lore.kernel.org/all/20230705063315.3680666-1-jeffxu@google.com/
[3]: https://lore.kernel.org/Y5yS8wCnuYGLHMj4@x1n/
[4]: https://lore.kernel.org/f185bb42-b29c-977e-312e-3349eea15383@linuxfoundation.org/

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
Changes in v2:
- Make vm.memfd_noexec restrictions properly hierarchical.
- Allow vm.memfd_noexec setting to be lowered by CAP_SYS_ADMIN as long
  as it is not lower than the parent's effective setting.
- Fix the logging behaviour related to the new flags and
  vm.memfd_noexec=2.
- Add more thorough tests for vm.memfd_noexec in selftests.
- v1: <https://lore.kernel.org/r/20230713143406.14342-1-cyphar@cyphar.com>

---
Aleksa Sarai (5):
      selftests: memfd: error out test process when child test fails
      memfd: do not -EACCES old memfd_create() users with vm.memfd_noexec=2
      memfd: improve userspace warnings for missing exec-related flags
      memfd: replace ratcheting feature from vm.memfd_noexec with hierarchy
      selftests: improve vm.memfd_noexec sysctl tests

 include/linux/pid_namespace.h              |  39 ++--
 kernel/pid.c                               |   3 +
 kernel/pid_namespace.c                     |   6 +-
 kernel/pid_sysctl.h                        |  28 ++-
 mm/memfd.c                                 |  33 ++-
 tools/testing/selftests/memfd/memfd_test.c | 332 +++++++++++++++++++++++------
 6 files changed, 322 insertions(+), 119 deletions(-)
---
base-commit: 3ff995246e801ea4de0a30860a1d8da4aeb538e7
change-id: 20230803-memfd-vm-noexec-uapi-fixes-ace725c67b0f

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>

