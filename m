Return-Path: <linux-kselftest+bounces-18601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86193989E7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 11:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAC428884E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5939C18C35F;
	Mon, 30 Sep 2024 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cP3f3OEB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cP3f3OEB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4016C18B46E;
	Mon, 30 Sep 2024 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688798; cv=none; b=ZuZMtxe4xjEFFZAwmyeClk5trqqddcxSiJhpKgB7Kl85DarJqOAM1F57M2ppSwpBFdRJwrUzLWe/NxVPXR20F/nY7w0Zsh6YWZBzFm4ns0lbcQ9YHyX7vltRvA1IxJlp9hz7aTGkJbvGNxXvSM4CcSEL6gs1Mpeqdp9tcciQy9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688798; c=relaxed/simple;
	bh=atsEbO/zIFm2TqoRTGJ2RPFrLTs8eOmSU1pV3nPtN5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gem1xqnE4XBX8VZ/uO2TJWaNFb+9NED8z36QJkJJgooVv3xEF5/lQOf5XEp3S1uhDJMrsQsh2a8stWEckCX8TnIHWQQlLcmwTsvXCuouCZtrACzeCetJPt/1TazxfrG1WyD+vwcGgKw1RcheRlb7SIHtOnjsD+OpqYOargVJhu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cP3f3OEB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cP3f3OEB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8795E1FB9D;
	Mon, 30 Sep 2024 09:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727688794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwRVT0EaJ41BAG65KVAL3xTM2RCPUb1hQkK2fgsIBpE=;
	b=cP3f3OEBha9huRGo5GXl5L2HC+SvKTz3O2VmrslQRAKEdPmIQA/AWTrQJ1PE4ZpUMBcE9a
	9YJ16exvdC9kgB1ZBbh1qCBG++xwrcCHiMg1G3cVLtRKVyzAPzt46VVo5JzxQ6qT9bv3D6
	vZd8GlsRk3v/RPp5NffQvAEd+hDsqQY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727688794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OwRVT0EaJ41BAG65KVAL3xTM2RCPUb1hQkK2fgsIBpE=;
	b=cP3f3OEBha9huRGo5GXl5L2HC+SvKTz3O2VmrslQRAKEdPmIQA/AWTrQJ1PE4ZpUMBcE9a
	9YJ16exvdC9kgB1ZBbh1qCBG++xwrcCHiMg1G3cVLtRKVyzAPzt46VVo5JzxQ6qT9bv3D6
	vZd8GlsRk3v/RPp5NffQvAEd+hDsqQY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44668136CB;
	Mon, 30 Sep 2024 09:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KKNnDlpw+mayMAAAD6G6ig
	(envelope-from <mvetter@suse.com>); Mon, 30 Sep 2024 09:33:14 +0000
From: Michael Vetter <mvetter@suse.com>
To: linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Vetter <mvetter@suse.com>
Subject: [PATCH v4 2/3] selftests: livepatch: save and restore kprobe state
Date: Mon, 30 Sep 2024 11:33:07 +0200
Message-ID: <20240930093308.65103-3-mvetter@suse.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240930093308.65103-1-mvetter@suse.com>
References: <20240930093308.65103-1-mvetter@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

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
index 50361fceff06..91102562db58 100644
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
2.46.1


