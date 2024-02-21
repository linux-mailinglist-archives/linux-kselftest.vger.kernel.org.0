Return-Path: <linux-kselftest+bounces-5204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4E385E45C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 18:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62DB1F25B52
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D1A85929;
	Wed, 21 Feb 2024 17:17:23 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC985920;
	Wed, 21 Feb 2024 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535843; cv=none; b=Q8SyVRcTUknVlnkHzdgVQZ3bn130UW0A1K8EQZy4yuhRxC4Pu2HvzzXMgkpwlF7yEfnMgPgzrr8Fr33o5jx/o4GGf7tMNgQhDVek25xuSxaJ9myuOKb4feEcPCoLyQxJRwD1AsaBILDoqXQ2/3hLVFUxKlLeimEvuyxG9Wzq9OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535843; c=relaxed/simple;
	bh=3poRLsl87I5LGoGOxmZJk8+3nZWuoc4lJ1AqHOCLYZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M8e6BeU+VK3kio6ZrhSufFhW6IFTcav8l92ulW4Hl+FUn+0P9MlmThr5bjuR9ub0Go9ZHYeWou0+rFgAS6O7agYkyKk9g7m2xJ6j8MZ5LGUnT3Rcj/MZJqgIDhb1zVL5GfV3uYABsNck7YGN8JH8W0Llvk6kTXN6YuznoFzM8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26CBA1FD5F;
	Wed, 21 Feb 2024 17:17:20 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A574613A25;
	Wed, 21 Feb 2024 17:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id p5sFGx8w1mUWcQAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Wed, 21 Feb 2024 17:17:19 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Wed, 21 Feb 2024 14:17:04 -0300
Subject: [PATCH v2 2/4] selftests: livepatch: Avoid running the tests if
 kernel-devel is missing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-lp-selftests-fixes-v2-2-a19be1e029a7@suse.com>
References: <20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com>
In-Reply-To: <20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com>
To: Shuah Khan <shuah@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708535830; l=2202;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=3poRLsl87I5LGoGOxmZJk8+3nZWuoc4lJ1AqHOCLYZI=;
 b=MPj10FsveNXGa7hnAV7q6dARSYDTiOPFpQ0FKKtUWcm02p+ZxFSnUtUCDdOKV+Lc8bIZVQQ01
 lD49kFKIBw0DvbKQOi5JcJK70lMbtNnNcbCyAYxscWflPw45s/FjXY5
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 26CBA1FD5F
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

By checking if KDIR is a valid directory we can safely skip the tests if
kernel-devel isn't installed (default value of KDIR), or if KDIR
variable passed doesn't exists.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402191417.XULH88Ct-lkp@intel.com/
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tools/testing/selftests/livepatch/functions.sh          | 13 +++++++++++++
 tools/testing/selftests/livepatch/test_modules/Makefile |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index e60cf09491a6..f0ed148d3c51 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -34,6 +34,18 @@ function is_root() {
 	fi
 }
 
+# Check if we can compile the modules before loading them
+function has_kdir() {
+	if [ -z "$KDIR" ]; then
+		KDIR="/lib/modules/$(uname -r)/build"
+	fi
+
+	if [ ! -d "$KDIR" ]; then
+		echo "skip all tests: KDIR ($KDIR) not available to compile modules."
+		exit $ksft_skip
+	fi
+}
+
 # die(msg) - game over, man
 #	msg - dying words
 function die() {
@@ -108,6 +120,7 @@ function cleanup() {
 #		 the ftrace_enabled sysctl.
 function setup_config() {
 	is_root
+	has_kdir
 	push_config
 	set_dynamic_debug
 	set_ftrace_enabled 1
diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
index f5e880269bff..e6e638c4bcba 100644
--- a/tools/testing/selftests/livepatch/test_modules/Makefile
+++ b/tools/testing/selftests/livepatch/test_modules/Makefile
@@ -13,8 +13,14 @@ obj-m += test_klp_atomic_replace.o \
 	test_klp_shadow_vars.o \
 	test_klp_syscall.o
 
+# Ensure that KDIR exists, otherwise skip the compilation
 modules:
+ifneq ("$(wildcard $(KDIR))", "")
 	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
+endif
 
+# Ensure that KDIR exists, otherwise skip the clean target
 clean:
+ifneq ("$(wildcard $(KDIR))", "")
 	$(Q)$(MAKE) -C $(KDIR) clean KBUILD_EXTMOD=$(TESTMODS_DIR)
+endif

-- 
2.42.1


