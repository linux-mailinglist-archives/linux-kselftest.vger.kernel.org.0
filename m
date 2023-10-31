Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DADB7DD77B
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 22:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344628AbjJaVLR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 17:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjJaVLQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 17:11:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34AE83;
        Tue, 31 Oct 2023 14:11:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 999301F460;
        Tue, 31 Oct 2023 21:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698786671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HtRTJUL19dRqFjIt5OAV5FuQQtcrzutoDTZ1TOareeM=;
        b=h6lXcBST6itQ2T4IOdb1gk7SRUSzZxRA9MVqUFE2th3wn9IQ8K6FwX8pQ9dVrp3trWRiSj
        9zWvAZiLZRcz1auRrcoO03TXlZ+quIlkhPlyQgPDOG4B//sx9JqmqQUzXJ+H5Qya7O2Bvw
        D8OCHcOs9cttVyL0pOsG61nh04XC1EE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15A44138EF;
        Tue, 31 Oct 2023 21:11:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O2cpM25tQWXOWgAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Tue, 31 Oct 2023 21:11:10 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v3 0/3] livepatch: Move modules to selftests and add a new
 test
Date:   Tue, 31 Oct 2023 18:10:50 -0300
Message-Id: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFptQWUC/3WOyw6CMBBFf4V0bUk7LQ9d+R/GBbSDNCKQDhCV8
 O+2bHTj8kzuuXdWRugdEjslK/O4OHJDH0AdEmbaqr8hdzYwAwFKCiU5YW95N/I7YddMSBNxbY6
 ysMbqLM9YEOuKkNe+6k0b1XpsftMLxMzosXHPffhyDdw6mgb/2v9YZLzGSRB52NQKNKRlIbjkj
 9EiDfO7OtNMmJrhwaIeSr+KElJLgDyFUsAfZ9u2D+HrWSH8AAAA
To:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        live-patching@vger.kernel.org,
        Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698786668; l=5672;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=Iu0nYGt8cXjDqfv6B/47jTzt5usx1RM2VTTkkVRsSSs=;
 b=ByHl8CTj1H+gJeuNdbdn/hvrEU2Cg4ynLwNzX7THcremf0HaASI5uXl1tH9kp7p4429pzdd25Z/t
 zJkb+eNQBDHbzbdpa0q1z9zsalxyyAltsK4Qsj3WajRmYoLl4Al/
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset moves the current kernel testing livepatch modules from
lib/livepatches to tools/testing/selftest/livepatch/test_modules, and compiles
them as out-of-tree modules before testing.

There is also a new test being added. This new test exercises multiple processes
calling a syscall, while a livepatch patched the syscall.

Why this move is an improvement:
* The modules are now compiled as out-of-tree modules against the current
  running kernel, making them capable of being tested on different systems with
  newer or older kernels.
* Such approach now needs kernel-devel package to be installed, since they are
  out-of-tree modules. These can be generated by running "make rpm-pkg" in the
  kernel source.

What needs to be solved:
* Currently gen_tar only packages the resulting binaries of the tests, and not
  the sources. For the current approach, the newly added modules would be
  compiled and then packaged. It works when testing on a system with the same
  kernel version. But it will fail when running on a machine with different kernel
  version, since module was compiled against the kernel currently running.

  This is not a new problem, just aligning the expectations. For the current
  approach to be truly system agnostic gen_tar would need to include the module
  and program sources to be compiled in the target systems.

I'm sending the patches now so it can be discussed before Plumbers.

Thanks in advance!
  Marcos

To: Shuah Khan <shuah@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
To: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Sven Schnelle <svens@linux.ibm.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: live-patching@vger.kernel.org
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Changes in v3:
* Rebased on top of v6.6-rc5
* The commits messages were improved (Thanks Petr!)
* Created TEST_GEN_MODS_DIR variable to point to a directly that contains kernel
  modules, and adapt selftests to build it before running the test.
* Moved test_klp-call_getpid out of test_programs, since the gen_tar
  would just copy the generated test programs to the livepatches dir,
  and so scripts relying on test_programs/test_klp-call_getpid will fail.
* Added a module_param for klp_pids, describing it's usage.
* Simplified the call_getpid program to ignore the return of getpid syscall,
  since we only want to make sure the process transitions correctly to the
  patched stated
* The test-syscall.sh not prints a log message showing the number of remaining
  processes to transition into to livepatched state, and check_output expects it
  to be 0.
* Added MODULE_AUTHOR and MODULE_DESCRIPTION to test_klp_syscall.c

The v2 can be seen here:
https://lore.kernel.org/linux-kselftest/20220630141226.2802-1-mpdesouza@suse.com/

---
Marcos Paulo de Souza (3):
      kselftests: lib.mk: Add TEST_GEN_MODS_DIR variable
      livepatch: Move tests from lib/livepatch to selftests/livepatch
      selftests: livepatch: Test livepatching a heavily called syscall

 Documentation/dev-tools/kselftest.rst              |   4 +
 arch/s390/configs/debug_defconfig                  |   1 -
 arch/s390/configs/defconfig                        |   1 -
 lib/Kconfig.debug                                  |  22 ----
 lib/Makefile                                       |   2 -
 lib/livepatch/Makefile                             |  14 ---
 tools/testing/selftests/lib.mk                     |  20 +++-
 tools/testing/selftests/livepatch/Makefile         |   5 +-
 tools/testing/selftests/livepatch/README           |  17 +--
 tools/testing/selftests/livepatch/config           |   1 -
 tools/testing/selftests/livepatch/functions.sh     |  34 +++---
 .../testing/selftests/livepatch/test-callbacks.sh  |  50 ++++-----
 tools/testing/selftests/livepatch/test-ftrace.sh   |   6 +-
 .../testing/selftests/livepatch/test-livepatch.sh  |  10 +-
 .../selftests/livepatch/test-shadow-vars.sh        |   2 +-
 tools/testing/selftests/livepatch/test-state.sh    |  18 ++--
 tools/testing/selftests/livepatch/test-syscall.sh  |  53 ++++++++++
 tools/testing/selftests/livepatch/test-sysfs.sh    |   6 +-
 .../selftests/livepatch/test_klp-call_getpid.c     |  44 ++++++++
 .../selftests/livepatch/test_modules/Makefile      |  20 ++++
 .../test_modules}/test_klp_atomic_replace.c        |   0
 .../test_modules}/test_klp_callbacks_busy.c        |   0
 .../test_modules}/test_klp_callbacks_demo.c        |   0
 .../test_modules}/test_klp_callbacks_demo2.c       |   0
 .../test_modules}/test_klp_callbacks_mod.c         |   0
 .../livepatch/test_modules}/test_klp_livepatch.c   |   0
 .../livepatch/test_modules}/test_klp_shadow_vars.c |   0
 .../livepatch/test_modules}/test_klp_state.c       |   0
 .../livepatch/test_modules}/test_klp_state2.c      |   0
 .../livepatch/test_modules}/test_klp_state3.c      |   0
 .../livepatch/test_modules/test_klp_syscall.c      | 116 +++++++++++++++++++++
 31 files changed, 325 insertions(+), 121 deletions(-)
---
base-commit: 6489bf2e1df1c84e9bcd4694029ff35b39fd3397
change-id: 20231031-send-lp-kselftests-4c917dcd4565

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>

