Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85986561DF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jun 2022 16:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbiF3OaM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jun 2022 10:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbiF3O36 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jun 2022 10:29:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE7B747BC;
        Thu, 30 Jun 2022 07:12:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E26921CCF;
        Thu, 30 Jun 2022 14:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656598357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TxYkXnk0/4I8fYFaZJI7PIVTPiAIG6UK1/rXiPeZYy0=;
        b=NPtNaaQO05MtUL0nXK5Q2vQevImJE3d0VfpB5wVvtvh7yAM6egp2LKJ1NGk0DoCnqdZmeh
        WpRvarHslv3dxY+YfQZzVp6O9kc4Wk6D7ZdBDGJ/BMQgesJ9jNQEtttU3R5e2YCZ+lRB4p
        fxj8o0HS7DkVU5PicAnd/lL4kPpBUmw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63BA413A5C;
        Thu, 30 Jun 2022 14:12:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0AlVClOvvWLvYgAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Thu, 30 Jun 2022 14:12:35 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, jpoimboe@redhat.com, mbenes@suse.cz,
        pmladek@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v2 0/2] livepatch: Move tests from lib/livepatch to selftests/livepatch
Date:   Thu, 30 Jun 2022 11:12:24 -0300
Message-Id: <20220630141226.2802-1-mpdesouza@suse.com>
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

this is the v2 of the patchset. The v1 can be found at [1]. There is only one
change in patch 1, which changed the target directory to build the test modules.
All other changes happen in patch 2.

Thanks for reviewing!

Changes from v1:
# test_modules/Makefile
  * Build the test modules targeting /lib/modules, instead of ksrc when building
    from the kernel source.

# test_modules/test_klp_syscall.c
  * Added a parameter array to receive the pids that should transition to the
    new system call. (suggedted by Joe)
  * Create a new sysfs file /sys/kernel/test_klp_syscall/npids to show how many
    pids from the argument need to transition to the new state. (suggested by
    Joe)
  * Fix the PPC32 support by adding the syscall wrapper for archs that select it
    by default, without erroring out. PPC does not set SYSCALL_WRAPPER, so
    having it set in v1 was a mistake. (suggested by Joe)
  * The aarch64 syscall prefix was added too, since the livepatch support will come soon.

# test_binaries/test_klp-call_getpid.c
  * Change %d/%u in printf (suggested byu Joe)
  * Change run -> stop variable name, and inverted the assignments (suggested by
  * Joe).

# File test-syscall.sh
  * Fixed test-syscall.sh to call test_klp-call-getpid in test_binaries dir
  * Load test_klp_syscall passed the pids of the test_klp-call_getpid instances.
    Check the sysfs file from test_klp_syscall module to check that all pids
    transitioned correctly. (suggested by Joe)
  * Simplified the loop that calls test_klp-call_getpid. (suggested by Joe)
  * Removed the "success" comment from the script, as it's implicit that it
    succeed. Otherwise load_lp would error out. (suggested by Joe)

* Changed the commit message of patch 2 to further detail what means "tricky"
  when livepatching syscalls. (suggested by Joe)

[1]: 20220603143242.870-1-mpdesouza@suse.com

Marcos Paulo de Souza (2):
  livepatch: Move tests from lib/livepatch to selftests/livepatch
  selftests: livepatch: Test livepatching a heavily called syscall

 arch/s390/configs/debug_defconfig             |   1 -
 arch/s390/configs/defconfig                   |   1 -
 lib/Kconfig.debug                             |  22 ---
 lib/Makefile                                  |   2 -
 lib/livepatch/Makefile                        |  14 --
 tools/testing/selftests/livepatch/Makefile    |  35 +++-
 tools/testing/selftests/livepatch/README      |   5 +-
 tools/testing/selftests/livepatch/config      |   1 -
 .../testing/selftests/livepatch/functions.sh  |  34 ++--
 .../selftests/livepatch/test-callbacks.sh     |  50 +++---
 .../selftests/livepatch/test-ftrace.sh        |   6 +-
 .../selftests/livepatch/test-livepatch.sh     |  10 +-
 .../selftests/livepatch/test-shadow-vars.sh   |   2 +-
 .../testing/selftests/livepatch/test-state.sh |  18 +--
 .../selftests/livepatch/test-syscall.sh       |  52 ++++++
 .../test_binaries/test_klp-call_getpid.c      |  48 ++++++
 .../selftests/livepatch/test_modules/Makefile |  20 +++
 .../test_modules}/test_klp_atomic_replace.c   |   0
 .../test_modules}/test_klp_callbacks_busy.c   |   0
 .../test_modules}/test_klp_callbacks_demo.c   |   0
 .../test_modules}/test_klp_callbacks_demo2.c  |   0
 .../test_modules}/test_klp_callbacks_mod.c    |   0
 .../test_modules}/test_klp_livepatch.c        |   0
 .../test_modules}/test_klp_shadow_vars.c      |   0
 .../livepatch/test_modules}/test_klp_state.c  |   0
 .../livepatch/test_modules}/test_klp_state2.c |   0
 .../livepatch/test_modules}/test_klp_state3.c |   0
 .../livepatch/test_modules/test_klp_syscall.c | 150 ++++++++++++++++++
 28 files changed, 360 insertions(+), 111 deletions(-)
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

