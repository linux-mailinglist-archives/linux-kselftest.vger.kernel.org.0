Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503F175253C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 16:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjGMOeh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 10:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjGMOef (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 10:34:35 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0484826AF;
        Thu, 13 Jul 2023 07:34:32 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4R1xvT1mlmz9sTq;
        Thu, 13 Jul 2023 16:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1689258869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lAa7dqvmH+q9XR/GIeI3noqFo+Lf1ym1g3+Ai+iNMRQ=;
        b=qUOa4YG376HPdtUX9J+UbKWx9u11F5Z+gXjdV/pSgA3GrtUNyKbuBsGccuriE0RNBmfVr+
        GGOwyythmmKSi+L/FK9I5Xfwh+tZbGylpGRJ/1cm5pERnc6LMAeEPpwpR6KLaC0OhbZSv2
        6rJ1jlIq3X/d812rYImFbjE2RDymOwNm7QF88DLJdMNYMuk/2J4cLmQsdhgX02yxqAOt1c
        ijb7fHSC4E1HLhOcAVnFqttvDhPqcQJ24eo2dt4A3ylYV5aKQjeVdRVPW+oG7VtYUJnFu6
        C5F3iL4cZcSmSItYWfGBI4d4eP3wCC2JJhzSbBLQPUXrV09d206nmsfo9aygdA==
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 0/3] memfd: cleanups for vm.memfd_noexec
Date:   Fri, 14 Jul 2023 00:33:45 +1000
Message-ID: <20230713143406.14342-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4R1xvT1mlmz9sTq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It seems that the most critical issue with vm.memfd_noexec=2 (the fact
that passing MFD_EXEC would bypass it entirely[1]) has been fixed in
Andrew's tree[2], but there are still some outstanding issues that need
to be addressed:

 * The dmesg warnings are pr_warn_once, which on most systems means that
   they will be used up by systemd or some other boot process and
   userspace developers will never see it. The original patch posted to
   the ML used pr_warn_ratelimited but the merged patch had it changed
   (with a comment about it being "per review"), but given that the
   current warnings are useless, pr_warn_ratelimited makes far more
   sense.

 * vm.memfd_noexec=2 shouldn't reject old-style memfd_create(2) syscalls
   because it will make it far to difficult to ever migrate. Instead it
   should imply MFD_EXEC.

 * The racheting mechanism for vm.memfd_noexec doesn't make sense as a
   security mechanism because a CAP_SYS_ADMIN capable user can create
   executable binaries in a hidden tmpfs very easily, not to mention the
   many other things they can do.

 * The memfd selftests would not exit with a non-zero error code when
   certain tests that ran in a forked process (specifically the ones
   related to MFD_EXEC and MFD_NOEXEC_SEAL) failed.

(This patchset is based on top of Jeff Xu's patches[2] fixing the
MFD_EXEC bug in vm.memfd_noexec=2.)

[1]: https://lore.kernel.org/all/ZJwcsU0vI-nzgOB_@codewreck.org/
[2]: https://lore.kernel.org/all/20230705063315.3680666-1-jeffxu@google.com/

Aleksa Sarai (3):
  memfd: cleanups for vm.memfd_noexec handling
  memfd: remove racheting feature from vm.memfd_noexec
  selftests: memfd: error out test process when child test fails

 include/linux/pid_namespace.h              | 16 +++------
 kernel/pid_sysctl.h                        |  7 ----
 mm/memfd.c                                 | 32 +++++++----------
 tools/testing/selftests/memfd/memfd_test.c | 41 ++++++++++++++++++----
 4 files changed, 51 insertions(+), 45 deletions(-)

-- 
2.41.0

