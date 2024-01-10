Return-Path: <linux-kselftest+bounces-2779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5960382913E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 01:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75661F260B6
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jan 2024 00:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23E6389;
	Wed, 10 Jan 2024 00:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kfdyF9VU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kfdyF9VU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F75182;
	Wed, 10 Jan 2024 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 099C321A6E;
	Wed, 10 Jan 2024 00:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704846298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eKECFS3PJhCrAEPASVX42gwRyuFXy0Bqz33UabNUzDg=;
	b=kfdyF9VUVpGUTYo8Gy7k0bx+0JKZQrU5JwJEK3WS5WAz6/ZYasiyTGIGj0TTqQ4KalQsER
	2L3i9NAytAODcBy+BfL/jn+nZdOb+METa9E/wXMY4myzZGocz8IQ6XLsxN63Rt3XU7gq9A
	cy9wlaN0yyonYgHOilhe2SijnWKHNQM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1704846298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eKECFS3PJhCrAEPASVX42gwRyuFXy0Bqz33UabNUzDg=;
	b=kfdyF9VUVpGUTYo8Gy7k0bx+0JKZQrU5JwJEK3WS5WAz6/ZYasiyTGIGj0TTqQ4KalQsER
	2L3i9NAytAODcBy+BfL/jn+nZdOb+METa9E/wXMY4myzZGocz8IQ6XLsxN63Rt3XU7gq9A
	cy9wlaN0yyonYgHOilhe2SijnWKHNQM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A3A813786;
	Wed, 10 Jan 2024 00:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9XG9BNnjnWUiWwAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Wed, 10 Jan 2024 00:24:57 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v5 0/3] livepatch: Move modules to selftests and add a new
 test
Date: Tue, 09 Jan 2024 21:24:53 -0300
Message-Id: <20240109-send-lp-kselftests-v5-0-364d59a69f12@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANXjnWUC/32Py07DMBBFf6XyGkf2+JGUFf+BWPgxIRZtEnnSq
 KXKv2NXQq0QsLyjOefOXBlhTkjseXdlGddEaRpLME87FgY3viNPsWQGApQUSnLCMfLDzD8ID/2
 CtBDXYS/bGKI21rACekfIfXZjGCrq5/5xe4W6M2fs0/lW/PpW8pBomfLldscq67RWgrClUyvQ0
 HSt4JIf54g0nT7dC50ImzAdWcWL9I4oIbUEsA10Av5h1Dfz52er4oKDl9aYAFaY/odB3w2l+Fe
 DLgYdhWg7NHvvHm/Ytu0LpjStU4ABAAA=
To: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 live-patching@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704846294; l=5452;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=qCNt1f6IEQXbGWVTpxhhcLzk8E1XQy5xkgDo4O//u2s=;
 b=o7fXB1IB/RrfU4gvYSGu5u8CTxe2nOeZBORltlCDYTT1u6ptjfnj8GAuinNcdXvH8bEqh99Sv
 EWcw4+1uXUlDH/cMwQbIDkZXG5qxgTFY+ZFF9ZOC2dlESs3MKCTb/L1
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

Changes in v5:
* Fixed an issue found by Joe that copied Kbuild files along with the
  test modules to the installation directory.
* Added Joe Lawrense review tags.

Changes in v4:
* Documented how to compile the livepatch selftests without running the
  tests (Joe)
* Removed the mention to lib/livepatch on MAINTAINERS file, reported by
  checkpatch.

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

- Link to v3: https://lore.kernel.org/r/20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com
- Link to v2: https://lore.kernel.org/linux-kselftest/20220630141226.2802-1-mpdesouza@suse.com/

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

Thanks in advance!
  Marcos

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Marcos Paulo de Souza (3):
      kselftests: lib.mk: Add TEST_GEN_MODS_DIR variable
      livepatch: Move tests from lib/livepatch to selftests/livepatch
      selftests: livepatch: Test livepatching a heavily called syscall

 Documentation/dev-tools/kselftest.rst              |   4 +
 MAINTAINERS                                        |   1 -
 arch/s390/configs/debug_defconfig                  |   1 -
 arch/s390/configs/defconfig                        |   1 -
 lib/Kconfig.debug                                  |  22 ----
 lib/Makefile                                       |   2 -
 lib/livepatch/Makefile                             |  14 ---
 tools/testing/selftests/lib.mk                     |  25 ++++-
 tools/testing/selftests/livepatch/Makefile         |   5 +-
 tools/testing/selftests/livepatch/README           |  25 +++--
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
 32 files changed, 339 insertions(+), 121 deletions(-)
---
base-commit: 89ecef4cb0ac442d5ad48c1aae1e2e1e7744d46f
change-id: 20231031-send-lp-kselftests-4c917dcd4565

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


