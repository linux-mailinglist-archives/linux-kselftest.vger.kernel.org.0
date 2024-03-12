Return-Path: <linux-kselftest+bounces-6256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DDC8793DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 13:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7ED81C214C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Mar 2024 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157979DD0;
	Tue, 12 Mar 2024 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t4ONObyr";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t4ONObyr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B326D79B92;
	Tue, 12 Mar 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245556; cv=none; b=FjWff7XIe182wl4eRR3m1YxIKzRoYxh4sHjePagE6JaW8YvQQRRZSw7G6kM3MFjlbXJTOGzTfsVmfQ/vxHTANn5mi1nmkyE2IRa4jJ6W32EdRD4DHvqotqvJw0efWecvqIu0oMQUOVwyKD37uTRLFBgmxdi+/zLhgPXn3r8uPIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245556; c=relaxed/simple;
	bh=TCGQqF+18Os3C61odwkuSi1jlFApKK2G+8qPngHoerU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ueucj43gHUvwsRJqc5oKoNjD6yEmUukuezBjUq13m0Xnup7RLgpZlDCo9cTjC12zAn1kvdrliCB3f67xYwR1gzPgNlxDP3FrlQyyHgKRbJIci1X/CbleJxGpIMr+qf/Je8KYmbU8sOCWIojS2qrEAPIsblOw+88I70WySyUB2Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t4ONObyr; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t4ONObyr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8EF825D48F;
	Tue, 12 Mar 2024 12:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710245551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K16N6xfHk8sdlVr00y/RAqVmoBWADQMREpiQqIg7t24=;
	b=t4ONObyr5++QAsGvG2nciQwD8Hmtahsr1LrTL4diIVIimxQa5tahC8VWGYSIi0BSgxYsVF
	xf3vQmI/1L9n/fPmv6zfgWdWr4nMvIPT2fTmcUoj3VY4oWOKOcti20Lb2PuCZWCRxJAJ0W
	JzxNmPyLso/f3vWK2HF3yGa6QJcoKgI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710245551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K16N6xfHk8sdlVr00y/RAqVmoBWADQMREpiQqIg7t24=;
	b=t4ONObyr5++QAsGvG2nciQwD8Hmtahsr1LrTL4diIVIimxQa5tahC8VWGYSIi0BSgxYsVF
	xf3vQmI/1L9n/fPmv6zfgWdWr4nMvIPT2fTmcUoj3VY4oWOKOcti20Lb2PuCZWCRxJAJ0W
	JzxNmPyLso/f3vWK2HF3yGa6QJcoKgI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 025B413795;
	Tue, 12 Mar 2024 12:12:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e0raKa5G8GUybwAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Tue, 12 Mar 2024 12:12:30 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Tue, 12 Mar 2024 09:12:14 -0300
Subject: [PATCH] selftests: livepatch: Test atomic replace against multiple
 modules
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240312-lp-selftest-new-test-v1-1-9c843e25e38e@suse.com>
X-B4-Tracking: v=1; b=H4sIAJ1G8GUC/x2MsQqAMAwFf0UyG6hBB/0VcRD7qgGp0ogK4r9b3
 O6Gu4cMSWHUFQ8lnGq6xSxVWdC0jHEGq89O4qR2Ii2vOxvWcMAOjrj4B9QelbjQNlNDOd0Tgt7
 /th/e9wN74hgqZgAAAA==
To: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710245547; l=4155;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=TCGQqF+18Os3C61odwkuSi1jlFApKK2G+8qPngHoerU=;
 b=6I4T/Hq9iTuDvZav28jPnVOWoSOcY5/v9CIIdVWciio2q5+O0WHtfceAsRk/38QsKeD/du0qD
 fe9yUsHkNcpDkEKJsG79NCf2pQVbCCVDPhWmUkl04bokw5XSXbHVR06
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=t4ONObyr
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 8EF825D48F
X-Spam-Flag: NO

This new test checks if a livepatch with replace attribute set replaces
all previously applied livepatches.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tools/testing/selftests/livepatch/Makefile         |  3 +-
 .../selftests/livepatch/test-atomic-replace.sh     | 71 ++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index 35418a4790be..e92f61208d35 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -10,7 +10,8 @@ TEST_PROGS := \
 	test-state.sh \
 	test-ftrace.sh \
 	test-sysfs.sh \
-	test-syscall.sh
+	test-syscall.sh \
+	test-atomic-replace.sh
 
 TEST_FILES := settings
 
diff --git a/tools/testing/selftests/livepatch/test-atomic-replace.sh b/tools/testing/selftests/livepatch/test-atomic-replace.sh
new file mode 100755
index 000000000000..09a3dcdcb8de
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-atomic-replace.sh
@@ -0,0 +1,71 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2024 SUSE
+# Author: Marcos Paulo de Souza <mpdesouza@suse.com>
+
+. $(dirname $0)/functions.sh
+
+MOD_REPLACE=test_klp_atomic_replace
+
+setup_config
+
+# - Load three livepatch modules.
+# - Load one more livepatch with replace being set, and check that only one
+#   livepatch module is being listed.
+
+start_test "apply one liveptach to replace multiple livepatches"
+
+for mod in test_klp_livepatch test_klp_syscall test_klp_callbacks_demo; do
+	load_lp $mod
+done
+
+nmods=$(ls /sys/kernel/livepatch | wc -l)
+if [ $nmods -ne 3 ]; then
+	die "Expecting three modules listed, found $nmods"
+fi
+
+load_lp $MOD_REPLACE replace=1
+
+nmods=$(ls /sys/kernel/livepatch | wc -l)
+if [ $nmods -ne 1 ]; then
+	die "Expecting only one moduled listed, found $nmods"
+fi
+
+disable_lp $MOD_REPLACE
+unload_lp $MOD_REPLACE
+
+check_result "% insmod test_modules/test_klp_livepatch.ko
+livepatch: enabling patch 'test_klp_livepatch'
+livepatch: 'test_klp_livepatch': initializing patching transition
+livepatch: 'test_klp_livepatch': starting patching transition
+livepatch: 'test_klp_livepatch': completing patching transition
+livepatch: 'test_klp_livepatch': patching complete
+% insmod test_modules/test_klp_syscall.ko
+livepatch: enabling patch 'test_klp_syscall'
+livepatch: 'test_klp_syscall': initializing patching transition
+livepatch: 'test_klp_syscall': starting patching transition
+livepatch: 'test_klp_syscall': completing patching transition
+livepatch: 'test_klp_syscall': patching complete
+% insmod test_modules/test_klp_callbacks_demo.ko
+livepatch: enabling patch 'test_klp_callbacks_demo'
+livepatch: 'test_klp_callbacks_demo': initializing patching transition
+test_klp_callbacks_demo: pre_patch_callback: vmlinux
+livepatch: 'test_klp_callbacks_demo': starting patching transition
+livepatch: 'test_klp_callbacks_demo': completing patching transition
+test_klp_callbacks_demo: post_patch_callback: vmlinux
+livepatch: 'test_klp_callbacks_demo': patching complete
+% insmod test_modules/test_klp_atomic_replace.ko replace=1
+livepatch: enabling patch 'test_klp_atomic_replace'
+livepatch: 'test_klp_atomic_replace': initializing patching transition
+livepatch: 'test_klp_atomic_replace': starting patching transition
+livepatch: 'test_klp_atomic_replace': completing patching transition
+livepatch: 'test_klp_atomic_replace': patching complete
+% echo 0 > /sys/kernel/livepatch/test_klp_atomic_replace/enabled
+livepatch: 'test_klp_atomic_replace': initializing unpatching transition
+livepatch: 'test_klp_atomic_replace': starting unpatching transition
+livepatch: 'test_klp_atomic_replace': completing unpatching transition
+livepatch: 'test_klp_atomic_replace': unpatching complete
+% rmmod test_klp_atomic_replace"
+
+exit 0

---
base-commit: efb3b8b2308470f08266a9ac9cbf42a0fd9ea572
change-id: 20240229-lp-selftest-new-test-e4de120f95c5

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


