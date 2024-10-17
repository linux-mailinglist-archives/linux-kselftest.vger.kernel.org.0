Return-Path: <linux-kselftest+bounces-20049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDDD9A2E1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 22:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8DA28367D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 20:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1900F2281C2;
	Thu, 17 Oct 2024 20:01:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AF17BB32;
	Thu, 17 Oct 2024 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729195310; cv=none; b=HlnMFJZ4+DfZ/jMeYALY1P6klM1LGjWrxhpK5PIf3Hc8gY9qjKFZvBh8Vq9GPJuEYvBXjrQNvrWr3tv+LB1WhfzvpLhLggw3iMTMJ2r3X+Jlhl/BMrBbajTQUQ+vetJX+Dmxbz+tyoaQ3n4DiXSveBAmDecilEuk4xe6cMXt/84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729195310; c=relaxed/simple;
	bh=MUH7ox4xw7+eRj41xora3KvXQGvRjDxs78paoxUnKHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxO6Meb7Crq0/mYrxpMOO3JYipXarnAs/qANt0u3PUwAMJeRJQCZgmxHyAIxxzPi6ojjRLkskFQbcXl9kgRGK29PqcYraEVS74a/tpDhCjhkImSeumZrkh5bQWS20o+W4A+0meQw0AgQ9LcblaI9KWKlJcaysgZ+n/NHlQwt7vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBC6921EAF;
	Thu, 17 Oct 2024 20:01:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 940B713A53;
	Thu, 17 Oct 2024 20:01:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2F48IydtEWf1AwAAD6G6ig
	(envelope-from <mvetter@suse.com>); Thu, 17 Oct 2024 20:01:43 +0000
From: Michael Vetter <mvetter@suse.com>
To: linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Vetter <mvetter@suse.com>
Subject: [PATCH v5 2/3] selftests: livepatch: save and restore kprobe state
Date: Thu, 17 Oct 2024 22:01:31 +0200
Message-ID: <20241017200132.21946-3-mvetter@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017200132.21946-1-mvetter@suse.com>
References: <20241017200132.21946-1-mvetter@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BBC6921EAF
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Save the state of /sys/kernel/debug/kprobes/enabled
during setup_config() and restore it during cleanup().

This is in preparation for a future commit that will add a test
that should confirm that we cannot livepatch a kprobed function
if that kprobe has a post handler.

Signed-off-by: Michael Vetter <mvetter@suse.com>
---
 tools/testing/selftests/livepatch/functions.sh | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index e0e7f8db894c..e78e0e16ad4d 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -6,7 +6,10 @@
 
 MAX_RETRIES=600
 RETRY_INTERVAL=".1"	# seconds
-SYSFS_KLP_DIR="/sys/kernel/livepatch"
+SYSFS_KERNEL_DIR="/sys/kernel"
+SYSFS_KLP_DIR="$SYSFS_KERNEL_DIR/livepatch"
+SYSFS_DEBUG_DIR="$SYSFS_KERNEL_DIR/debug"
+SYSFS_KPROBES_DIR="$SYSFS_DEBUG_DIR/kprobes"
 
 # Kselftest framework requirement - SKIP code is 4
 ksft_skip=4
@@ -55,22 +58,26 @@ function die() {
 }
 
 function push_config() {
-	DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
+	DYNAMIC_DEBUG=$(grep '^kernel/livepatch' "$SYSFS_DEBUG_DIR/dynamic_debug/control" | \
 			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
 	FTRACE_ENABLED=$(sysctl --values kernel.ftrace_enabled)
+	KPROBE_ENABLED=$(cat "$SYSFS_KPROBES_DIR/enabled")
 }
 
 function pop_config() {
 	if [[ -n "$DYNAMIC_DEBUG" ]]; then
-		echo -n "$DYNAMIC_DEBUG" > /sys/kernel/debug/dynamic_debug/control
+		echo -n "$DYNAMIC_DEBUG" > "$SYSFS_DEBUG_DIR/dynamic_debug/control"
 	fi
 	if [[ -n "$FTRACE_ENABLED" ]]; then
 		sysctl kernel.ftrace_enabled="$FTRACE_ENABLED" &> /dev/null
 	fi
+	if [[ -n "$KPROBE_ENABLED" ]]; then
+		echo "$KPROBE_ENABLED" > "$SYSFS_KPROBES_DIR/enabled"
+	fi
 }
 
 function set_dynamic_debug() {
-        cat <<-EOF > /sys/kernel/debug/dynamic_debug/control
+        cat <<-EOF > "$SYSFS_DEBUG_DIR/dynamic_debug/control"
 		file kernel/livepatch/* +p
 		func klp_try_switch_task -p
 		EOF
-- 
2.47.0


