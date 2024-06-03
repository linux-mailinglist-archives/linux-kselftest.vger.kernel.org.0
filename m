Return-Path: <linux-kselftest+bounces-11120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2DF8D87E1
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 19:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F4224284D9D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 17:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DC7136E34;
	Mon,  3 Jun 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QMv/sq9l";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aTQMV4Vu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F2A25622;
	Mon,  3 Jun 2024 17:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717435613; cv=none; b=RIuWc5lDryteDR1ye+Xge3+canpFI188f3ZKP6xXD5hllPCr/p5WTx6AclWdUNBAlIsLqxenZ6omCAq0R66dqUO+nRcZgZA3ASOBGhz1c2AmJW44YFjm/eSVBwTulqguypyKcKbGY9xzGyF5suZJLaUubcoBISetPwTGL7rcQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717435613; c=relaxed/simple;
	bh=tohLD1yKYUlomeLNDMncipUmAMreIJUHy9J6Kz4ndEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JNPwasXE9gHzTHgZrnnnjezwUadZiqDWE/JUKktzknOaxq5MV9cCoYQ7GgmCkHYv8KB0UeXwcJHjU9jjiOyYGjto1OQI/zznH25c92ghhedU7P+6S42LCB13taOXKqDp6eqRQgW+eLjRq+H7cI0upKWViIUNBbG420HQKk4YiIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QMv/sq9l; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aTQMV4Vu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6E9C1F387;
	Mon,  3 Jun 2024 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717435609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XqKXNtV1CrsKsGKUGtvKhf9a3rqvl/LN5KF8liPNUjo=;
	b=QMv/sq9lFk+A8fpKR1w0ZtDWtAy/Y+n5VCPvRAG/dUNffUWhtxFAP5p8CazBByQWUs69aX
	OQWMAx+fOxTKKHE4DNTSR2U7e2Jvy78+8dFMKjkbOE9Z9aLvNH/Ci+lgAme4RQAMXNq93k
	Ud6JdlpdksrSe2pJGn5c04EOWGEuE74=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=aTQMV4Vu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717435607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XqKXNtV1CrsKsGKUGtvKhf9a3rqvl/LN5KF8liPNUjo=;
	b=aTQMV4Vuv2NRmgQX/TEupW4Ns9sLTklaJs3VZ0vL/Km5t+EQ0udO82kgG206pCTqwaMHqM
	f5dhCFOTT6ZMtplcz0/iNNxM3n1+PC5vcxKDvJJDnIGPOWiYUKGLDu+TIviz2c+MMbXkNw
	rlE4p8Opz0KQNHs+ZS+QmbOD1igJUeI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C57213A93;
	Mon,  3 Jun 2024 17:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jOOSOdb8XWYGIAAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Mon, 03 Jun 2024 17:26:46 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Mon, 03 Jun 2024 14:26:19 -0300
Subject: [PATCH v3] selftests: livepatch: Test atomic replace against
 multiple modules
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-lp-atomic-replace-v3-1-9f3b8ace5c9f@suse.com>
X-B4-Tracking: v=1; b=H4sIALr8XWYC/33OQQ6CMBAF0KuYrh3TTqkBV97DsChlkCZASVurh
 nB3Cxt27uYv5v2/sEDeUmC308I8JRusm3KQ5xMzvZ6eBLbNmSHHgitUMMygoxutAU/zoA1BxRs
 pqeWibA3Lf7Onzn5281Hn3Hk3Quw96UOSAjcp0NBFChEmesN+JAECKlMWklCRLOkeXoEuxo0b3
 dsQnf/uaxNuBf+GJcyWKFBUVdNclRaHVa/r+gNP3YA+/AAAAA==
To: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 Joe Lawrence <joe.lawrence@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717435604; l=10660;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=tohLD1yKYUlomeLNDMncipUmAMreIJUHy9J6Kz4ndEY=;
 b=4M7x2jwB5f1b1Sr/JBs58HJ6Z34OHAKkFCS7Ni/WC9qW7ezL3LEe3fBScNnnlMKDKVJUwe5xc
 r+Uv0AUwwzEBfjZsPlTQDbWakWun160PGacGRXQE/eTtIOYa1jhX+Nd
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Flag: NO
X-Spam-Score: -5.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A6E9C1F387
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email,test-livepatch.sh:url];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.com:+]

Adapt the current test-livepatch.sh script to account the number of
applied livepatches and ensure that an atomic replace livepatch disables
all previously applied livepatches.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes since v2:
* Used variables to stop the name of other livepatches applied to test
  the atomic replace. (Joe)

Changes since v1:
* Added checks in the existing test-livepatch.sh instead of creating a
  new test file. (Joe)
* Fixed issues reported by ShellCheck (Joe)
---
Changes in v3:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://lore.kernel.org/r/20240525-lp-atomic-replace-v2-1-142199bb65a1@suse.com
---
 .../testing/selftests/livepatch/test-livepatch.sh  | 138 +++++++++++++--------
 1 file changed, 89 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index e3455a6b1158..ca770b8c62fc 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -4,7 +4,9 @@
 
 . $(dirname $0)/functions.sh
 
-MOD_LIVEPATCH=test_klp_livepatch
+MOD_LIVEPATCH1=test_klp_livepatch
+MOD_LIVEPATCH2=test_klp_syscall
+MOD_LIVEPATCH3=test_klp_callbacks_demo
 MOD_REPLACE=test_klp_atomic_replace
 
 setup_config
@@ -16,33 +18,33 @@ setup_config
 
 start_test "basic function patching"
 
-load_lp $MOD_LIVEPATCH
+load_lp $MOD_LIVEPATCH1
 
-if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
+if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH1: this has been live patched" ]] ; then
 	echo -e "FAIL\n\n"
 	die "livepatch kselftest(s) failed"
 fi
 
-disable_lp $MOD_LIVEPATCH
-unload_lp $MOD_LIVEPATCH
+disable_lp $MOD_LIVEPATCH1
+unload_lp $MOD_LIVEPATCH1
 
-if [[ "$(cat /proc/cmdline)" == "$MOD_LIVEPATCH: this has been live patched" ]] ; then
+if [[ "$(cat /proc/cmdline)" == "$MOD_LIVEPATCH1: this has been live patched" ]] ; then
 	echo -e "FAIL\n\n"
 	die "livepatch kselftest(s) failed"
 fi
 
-check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
-livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
-livepatch: '$MOD_LIVEPATCH': patching complete
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
-livepatch: '$MOD_LIVEPATCH': unpatching complete
-% rmmod $MOD_LIVEPATCH"
+check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko
+livepatch: enabling patch '$MOD_LIVEPATCH1'
+livepatch: '$MOD_LIVEPATCH1': initializing patching transition
+livepatch: '$MOD_LIVEPATCH1': starting patching transition
+livepatch: '$MOD_LIVEPATCH1': completing patching transition
+livepatch: '$MOD_LIVEPATCH1': patching complete
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH1/enabled
+livepatch: '$MOD_LIVEPATCH1': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH1': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH1': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH1': unpatching complete
+% rmmod $MOD_LIVEPATCH1"
 
 
 # - load a livepatch that modifies the output from /proc/cmdline and
@@ -53,7 +55,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 
 start_test "multiple livepatches"
 
-load_lp $MOD_LIVEPATCH
+load_lp $MOD_LIVEPATCH1
 
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
@@ -69,26 +71,26 @@ unload_lp $MOD_REPLACE
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
 
-disable_lp $MOD_LIVEPATCH
-unload_lp $MOD_LIVEPATCH
+disable_lp $MOD_LIVEPATCH1
+unload_lp $MOD_LIVEPATCH1
 
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
 
-check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
-livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
-livepatch: '$MOD_LIVEPATCH': patching complete
-$MOD_LIVEPATCH: this has been live patched
+check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko
+livepatch: enabling patch '$MOD_LIVEPATCH1'
+livepatch: '$MOD_LIVEPATCH1': initializing patching transition
+livepatch: '$MOD_LIVEPATCH1': starting patching transition
+livepatch: '$MOD_LIVEPATCH1': completing patching transition
+livepatch: '$MOD_LIVEPATCH1': patching complete
+$MOD_LIVEPATCH1: this has been live patched
 % insmod test_modules/$MOD_REPLACE.ko replace=0
 livepatch: enabling patch '$MOD_REPLACE'
 livepatch: '$MOD_REPLACE': initializing patching transition
 livepatch: '$MOD_REPLACE': starting patching transition
 livepatch: '$MOD_REPLACE': completing patching transition
 livepatch: '$MOD_REPLACE': patching complete
-$MOD_LIVEPATCH: this has been live patched
+$MOD_LIVEPATCH1: this has been live patched
 $MOD_REPLACE: this has been live patched
 % echo 0 > /sys/kernel/livepatch/$MOD_REPLACE/enabled
 livepatch: '$MOD_REPLACE': initializing unpatching transition
@@ -96,35 +98,57 @@ livepatch: '$MOD_REPLACE': starting unpatching transition
 livepatch: '$MOD_REPLACE': completing unpatching transition
 livepatch: '$MOD_REPLACE': unpatching complete
 % rmmod $MOD_REPLACE
-$MOD_LIVEPATCH: this has been live patched
-% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
-livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
-livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-livepatch: '$MOD_LIVEPATCH': completing unpatching transition
-livepatch: '$MOD_LIVEPATCH': unpatching complete
-% rmmod $MOD_LIVEPATCH"
+$MOD_LIVEPATCH1: this has been live patched
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH1/enabled
+livepatch: '$MOD_LIVEPATCH1': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH1': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH1': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH1': unpatching complete
+% rmmod $MOD_LIVEPATCH1"
 
 
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
 
-load_lp $MOD_LIVEPATCH
+load_lp $MOD_LIVEPATCH1
 
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
 
+for mod in $MOD_LIVEPATCH2 $MOD_LIVEPATCH3; do
+	load_lp "$mod"
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
+for mod in $MOD_LIVEPATCH3 $MOD_LIVEPATCH2 $MOD_LIVEPATCH1; do
+	unload_lp "$mod"
+done
 
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
@@ -135,13 +159,27 @@ unload_lp $MOD_REPLACE
 grep 'live patched' /proc/cmdline > /dev/kmsg
 grep 'live patched' /proc/meminfo > /dev/kmsg
 
-check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
-livepatch: enabling patch '$MOD_LIVEPATCH'
-livepatch: '$MOD_LIVEPATCH': initializing patching transition
-livepatch: '$MOD_LIVEPATCH': starting patching transition
-livepatch: '$MOD_LIVEPATCH': completing patching transition
-livepatch: '$MOD_LIVEPATCH': patching complete
-$MOD_LIVEPATCH: this has been live patched
+check_result "% insmod test_modules/$MOD_LIVEPATCH1.ko
+livepatch: enabling patch '$MOD_LIVEPATCH1'
+livepatch: '$MOD_LIVEPATCH1': initializing patching transition
+livepatch: '$MOD_LIVEPATCH1': starting patching transition
+livepatch: '$MOD_LIVEPATCH1': completing patching transition
+livepatch: '$MOD_LIVEPATCH1': patching complete
+$MOD_LIVEPATCH1: this has been live patched
+% insmod test_modules/$MOD_LIVEPATCH2.ko
+livepatch: enabling patch '$MOD_LIVEPATCH2'
+livepatch: '$MOD_LIVEPATCH2': initializing patching transition
+livepatch: '$MOD_LIVEPATCH2': starting patching transition
+livepatch: '$MOD_LIVEPATCH2': completing patching transition
+livepatch: '$MOD_LIVEPATCH2': patching complete
+% insmod test_modules/$MOD_LIVEPATCH3.ko
+livepatch: enabling patch '$MOD_LIVEPATCH3'
+livepatch: '$MOD_LIVEPATCH3': initializing patching transition
+$MOD_LIVEPATCH3: pre_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH3': starting patching transition
+livepatch: '$MOD_LIVEPATCH3': completing patching transition
+$MOD_LIVEPATCH3: post_patch_callback: vmlinux
+livepatch: '$MOD_LIVEPATCH3': patching complete
 % insmod test_modules/$MOD_REPLACE.ko replace=1
 livepatch: enabling patch '$MOD_REPLACE'
 livepatch: '$MOD_REPLACE': initializing patching transition
@@ -149,7 +187,9 @@ livepatch: '$MOD_REPLACE': starting patching transition
 livepatch: '$MOD_REPLACE': completing patching transition
 livepatch: '$MOD_REPLACE': patching complete
 $MOD_REPLACE: this has been live patched
-% rmmod $MOD_LIVEPATCH
+% rmmod $MOD_LIVEPATCH3
+% rmmod $MOD_LIVEPATCH2
+% rmmod $MOD_LIVEPATCH1
 $MOD_REPLACE: this has been live patched
 % echo 0 > /sys/kernel/livepatch/$MOD_REPLACE/enabled
 livepatch: '$MOD_REPLACE': initializing unpatching transition

---
base-commit: 6d69b6c12fce479fde7bc06f686212451688a102
change-id: 20240525-lp-atomic-replace-90b33ed018dc

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


