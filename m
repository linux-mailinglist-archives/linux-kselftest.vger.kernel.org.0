Return-Path: <linux-kselftest+bounces-10698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B71B28CEF56
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 16:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5402E2818AA
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 14:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636CF53804;
	Sat, 25 May 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="moFaAMfq";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="moFaAMfq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092DD4F1EE;
	Sat, 25 May 2024 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716648188; cv=none; b=AAv+8TVSA183LGZX1bRf2RcXeicl4bbsR2BxFkZTPqlxvjYd+zPlw7lYi7tLnYJd+FS6R7NVLQt0T+WHNvk6cZOQWrS3lSvS8TJ2G34YG5yDOOmOS0bLRaKd/JLHZPxQAOfx11D2Ex7RHmI2uVS+gj3+h6YA2CukpgVa/YhRnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716648188; c=relaxed/simple;
	bh=EkrUWFhn0zt+TeGkX6M8/mRR/R/1t+tAjbE/Avl3BCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Sbz3KriaiQip42fFVEz/mvd+cspIgHV8FQ5yxVgZ3G46C52gtfM4k4FDdm1e0qXdRnDCusVLXICwu0+aAeq+a1zAB8bv2KGI+kQrD7lVcO5VsA1L1v1+IQBhdqQpNaHXG1j6Zd8Cng5ZAOIfqt75L2513WNgXwZf/CD75G57VFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=moFaAMfq; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=moFaAMfq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2533E340EF;
	Sat, 25 May 2024 14:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716647658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kayrq4bIogVbNvkYduiGWuYdpRW0aW0d8zLBW6xI8FA=;
	b=moFaAMfqnNAZuh2xbYkD4mwv2iHWITj82fZzbieW9f2Q6I8xV6mz1dvv8ESWYidRH4TmQD
	YSnsz8+N5wfO8lRUNfmTEqTnNO8qHict3hCzLJgA0iQ0rG/nhPCA7VUKcR9hUEPg47JU+A
	p8jm9RnCf1IeYlzi8ut/A7NbiRNLZhc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716647658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kayrq4bIogVbNvkYduiGWuYdpRW0aW0d8zLBW6xI8FA=;
	b=moFaAMfqnNAZuh2xbYkD4mwv2iHWITj82fZzbieW9f2Q6I8xV6mz1dvv8ESWYidRH4TmQD
	YSnsz8+N5wfO8lRUNfmTEqTnNO8qHict3hCzLJgA0iQ0rG/nhPCA7VUKcR9hUEPg47JU+A
	p8jm9RnCf1IeYlzi8ut/A7NbiRNLZhc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B507F13A6B;
	Sat, 25 May 2024 14:34:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oH3EIOn2UWYJNQAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Sat, 25 May 2024 14:34:17 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 25 May 2024 11:34:08 -0300
Subject: [PATCH v2] selftests: livepatch: Test atomic replace against
 multiple modules
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240525-lp-atomic-replace-v2-1-142199bb65a1@suse.com>
X-B4-Tracking: v=1; b=H4sIAN/2UWYC/0XMyw6CMBSE4VchXXtML5CAK9/DuKjtIE2Akp6KJ
 oR3t7JxN99i/k0wUgCLS7WJhDVwiHOBPlXCDXZ+goIvFlrqWja6oXEhm+MUHCUso3WgTj6MgZe
 q9U6U35LQh8/RvN2L+xQnykOC/ZeM0r8SY+wzONOMNx1jVaSoc21toBuYFld+Mc4uTmLfv/V8C
 96uAAAA
To: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716647655; l=4356;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=EkrUWFhn0zt+TeGkX6M8/mRR/R/1t+tAjbE/Avl3BCg=;
 b=zthRmdcWJPIHXlRCyOn1WbeN86DXFqLe49bmdmlhZCkNWwZr9dr+0T2NEmIwwfJELaj27kdyO
 i0FuZ4SkumtCt2lUNlxvCs3e/wf4Mptk5tyPDzw9AIQ3ad/OVX5xTaV
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,test-livepatch.sh:url,suse.com:email]

Adapt the current test-livepatch.sh script to account the number of
applied livepatches and ensure that an atomic replace livepatch disables
all previously applied livepatches.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes since v1:
* Added checks in the existing test-livepatch.sh instead of creating a
  new test file. (Joe)
* Fixed issues reported by ShellCheck (Joe)
---
 .../testing/selftests/livepatch/test-livepatch.sh  | 46 ++++++++++++++++++++--
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index e3455a6b1158..d85405d18e54 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -107,9 +107,12 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 
 # - load a livepatch that modifies the output from /proc/cmdline and
 #   verify correct behavior
-# - load an atomic replace livepatch and verify that only the second is active
-# - remove the first livepatch and verify that the atomic replace livepatch
-#   is still active
+# - load two addtional livepatches and check the number of livepatch modules
+#   applied
+# - load an atomic replace livepatch and check that the other three modules were
+#   disabled
+# - remove all livepatches besides the atomic replace one and verify that the
+#   atomic replace livepatch is still active
 # - remove the atomic replace livepatch and verify that none are active
 
 start_test "atomic replace livepatch"
@@ -119,12 +122,31 @@ load_lp $MOD_LIVEPATCH
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
 
+for mod in test_klp_syscall test_klp_callbacks_demo; do
+	load_lp $mod
+done
+
+mods=(/sys/kernel/livepatch/*)
+nmods=${#mods[@]}
+if [ "$nmods" -ne 3 ]; then
+	die "Expecting three modules listed, found $nmods"
+fi
+
 load_lp $MOD_REPLACE replace=1
 
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
 
-unload_lp $MOD_LIVEPATCH
+mods=(/sys/kernel/livepatch/*)
+nmods=${#mods[@]}
+if [ "$nmods" -ne 1 ]; then
+	die "Expecting only one moduled listed, found $nmods"
+fi
+
+# These modules were disabled by the atomic replace
+for mod in test_klp_callbacks_demo test_klp_syscall $MOD_LIVEPATCH; do
+	unload_lp "$mod"
+done
 
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
@@ -142,6 +164,20 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 livepatch: '$MOD_LIVEPATCH': patching complete
 $MOD_LIVEPATCH: this has been live patched
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
 % insmod test_modules/$MOD_REPLACE.ko replace=1
 livepatch: enabling patch '$MOD_REPLACE'
 livepatch: '$MOD_REPLACE': initializing patching transition
@@ -149,6 +185,8 @@ livepatch: '$MOD_REPLACE': starting patching transition
 livepatch: '$MOD_REPLACE': completing patching transition
 livepatch: '$MOD_REPLACE': patching complete
 $MOD_REPLACE: this has been live patched
+% rmmod test_klp_callbacks_demo
+% rmmod test_klp_syscall
 % rmmod $MOD_LIVEPATCH
 $MOD_REPLACE: this has been live patched
 % echo 0 > /sys/kernel/livepatch/$MOD_REPLACE/enabled

---
base-commit: 6d69b6c12fce479fde7bc06f686212451688a102
change-id: 20240525-lp-atomic-replace-90b33ed018dc

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


