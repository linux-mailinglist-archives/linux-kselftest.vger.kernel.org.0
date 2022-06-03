Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DEF53CB8B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jun 2022 16:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245092AbiFCOdT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Jun 2022 10:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244009AbiFCOdS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Jun 2022 10:33:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062182E08C;
        Fri,  3 Jun 2022 07:33:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9C93B1F898;
        Fri,  3 Jun 2022 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654266795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QiYPQSSSLVETOIuUpIPfu1jW2fO3cx9UW9VugSIh7uQ=;
        b=f4F9aEqotRUf+gEzB/ScM7JER68jz9nQoayq1HYVnD3u7LPriGdtViGymA/BBBrHb9orC0
        WMM3fW8jLv/gwnoxojr9hMEuBkMhRRJHGQgHrCnIIDkoAeqfhJ3QL/NXYL2pxTPJA92u/f
        iLJfRak3lFaYKCRmLI+P/Gm/H2nvyG8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77BF013AA2;
        Fri,  3 Jun 2022 14:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sTJbD6kbmmIqGgAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Fri, 03 Jun 2022 14:33:13 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 0/2] livepatch: Move tests from lib/livepatch to selftests/livepatch
Date:   Fri,  3 Jun 2022 11:32:40 -0300
Message-Id: <20220603143242.870-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi there,

The first patch moves the current livepatch tests to selftests, allowing it
be better suited to contain more complex tests, like using userspace C code
to use the livepatched kernel code. As a bonus it allows to use
"gen_tar" to export the livepatch selftests, rebuild the modules by
running make in selftests/livepatch directory and simplifies the process
of creating and debugging new selftests.

It keeps the ability to execute the tests by running the shell scripts,
like "test-livepatch.sh", but beware that the kernel modules
might not be up-to-date.

The second patch includes a new test to exercise the functionality to livepatch
a heavy hammered function. The test uses getpid in this case.

I tested the changes by running the tests within the kernel source tree and running
from the gen_tar extracted directory.

Marcos Paulo de Souza (2):
  livepatch: Move tests from lib/livepatch to selftests/livepatch
  selftests: livepatch: Test livepatching a heavily called syscall

 arch/s390/configs/debug_defconfig             |  1 -
 arch/s390/configs/defconfig                   |  1 -
 lib/Kconfig.debug                             | 22 -------
 lib/Makefile                                  |  2 -
 lib/livepatch/Makefile                        | 14 -----
 tools/testing/selftests/livepatch/Makefile    | 35 ++++++++++-
 tools/testing/selftests/livepatch/README      |  5 +-
 tools/testing/selftests/livepatch/config      |  1 -
 .../testing/selftests/livepatch/functions.sh  | 34 ++++-------
 .../selftests/livepatch/test-callbacks.sh     | 50 ++++++++--------
 .../selftests/livepatch/test-ftrace.sh        |  6 +-
 .../selftests/livepatch/test-livepatch.sh     | 10 ++--
 .../selftests/livepatch/test-shadow-vars.sh   |  2 +-
 .../testing/selftests/livepatch/test-state.sh | 18 +++---
 .../selftests/livepatch/test-syscall.sh       | 46 ++++++++++++++
 .../test_binaries/test_klp-call_getpid.c      | 48 +++++++++++++++
 .../selftests/livepatch/test_modules/Makefile | 25 ++++++++
 .../test_modules}/test_klp_atomic_replace.c   |  0
 .../test_modules}/test_klp_callbacks_busy.c   |  0
 .../test_modules}/test_klp_callbacks_demo.c   |  0
 .../test_modules}/test_klp_callbacks_demo2.c  |  0
 .../test_modules}/test_klp_callbacks_mod.c    |  0
 .../test_modules}/test_klp_livepatch.c        |  0
 .../test_modules}/test_klp_shadow_vars.c      |  0
 .../livepatch/test_modules}/test_klp_state.c  |  0
 .../livepatch/test_modules}/test_klp_state2.c |  0
 .../livepatch/test_modules}/test_klp_state3.c |  0
 .../livepatch/test_modules/test_klp_syscall.c | 60 +++++++++++++++++++
 28 files changed, 269 insertions(+), 111 deletions(-)
 delete mode 100644 lib/livepatch/Makefile
 create mode 100755 tools/testing/selftests/livepatch/test-syscall.sh
 create mode 100644 tools/testing/selftests/livepatch/test_binaries/test_klp-call_getpid.c
 create mode 100644 tools/testing/selftests/livepatch/test_modules/Makefile
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_atomic_replace.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_busy.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_demo.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_demo2.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_callbacks_mod.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_livepatch.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_shadow_vars.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state2.c (100%)
 rename {lib/livepatch => tools/testing/selftests/livepatch/test_modules}/test_klp_state3.c (100%)
 create mode 100644 tools/testing/selftests/livepatch/test_modules/test_klp_syscall.c

-- 
2.35.3

