Return-Path: <linux-kselftest+bounces-18167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8DB97D50C
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 13:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5876285D94
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4206615351B;
	Fri, 20 Sep 2024 11:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UccZQdW2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UccZQdW2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6144F13AA46;
	Fri, 20 Sep 2024 11:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726833406; cv=none; b=mckEagKSgDDAzowQ+qsDytTgHyJNNU4XnWGppXdZFnARkH1fBcCksnEbIhRKpRDetXf0VqYRoA1cWEYiUiewvUmn0COQvA5w0mXTwmRYxfSHMdJ76fxYNCqryxdrPcttj4Zi9yZDsCcbPkSxMpgXLUf1QmL0Q/4zOrXK0lD+12Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726833406; c=relaxed/simple;
	bh=JiTbaLFG9Pq53Q3ar+r2KV3KHcnn2M5Nlxmwn69XErI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cbi1Gs9ZdtzYaOlvYCVu5GwxMEp2uDWVce+dOoPVQXqI7OgGU/sjdIjYlL4QpeqLd4hnUu1f6wkYstQbz0bJjgZDBSYHQSBqdmJYbz96U2SDSmtgakHHBFAu6xbGXnGyupsdT+Awv1+y/L1jthSwaBdR6hyK8YdkhimO5vLNNMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UccZQdW2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UccZQdW2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0F53233A38;
	Fri, 20 Sep 2024 11:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726833397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gg08grrRGQdwtSo6sooGrTm+xoyazpq3hhlk/Bd2LA=;
	b=UccZQdW20iLhEgR+OAaHuuQQQxh398dpocZImezvstMrS5DUMSdrbed4WFwebrPiwr3Gze
	1d9kBUdyhPMIkAQ6j/dMlCeXKo29JHARXhw7kAfHXCTcvowy6zhWMmMIw+7r3n8D/PDM7G
	NxJNlTF0jvpxXbKPEEwoWWhGUIsnv/A=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UccZQdW2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726833397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gg08grrRGQdwtSo6sooGrTm+xoyazpq3hhlk/Bd2LA=;
	b=UccZQdW20iLhEgR+OAaHuuQQQxh398dpocZImezvstMrS5DUMSdrbed4WFwebrPiwr3Gze
	1d9kBUdyhPMIkAQ6j/dMlCeXKo29JHARXhw7kAfHXCTcvowy6zhWMmMIw+7r3n8D/PDM7G
	NxJNlTF0jvpxXbKPEEwoWWhGUIsnv/A=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA85513AE1;
	Fri, 20 Sep 2024 11:56:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ePPhKvRi7WbdHwAAD6G6ig
	(envelope-from <mvetter@suse.com>); Fri, 20 Sep 2024 11:56:36 +0000
From: Michael Vetter <mvetter@suse.com>
To: linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Vetter <mvetter@suse.com>
Subject: [PATCH v3 2/3] selftests: livepatch: save and restore kprobe state
Date: Fri, 20 Sep 2024 13:56:30 +0200
Message-ID: <20240920115631.54142-3-mvetter@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240920115631.54142-1-mvetter@suse.com>
References: <20240920115631.54142-1-mvetter@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F53233A38
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

Save the state of /sys/kernel/livepatch/debug/kprobes/enabled
during setup_config() and restore it during cleanup().

This is in preparation for a future commit that will add a test
that should confirm that we cannot livepatch a kprobed function
if that kprobe has a post handler.

Signed-off-by: Michael Vetter <mvetter@suse.com>
---
 tools/testing/selftests/livepatch/functions.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 50361fceff06..6684c01c0567 100644
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
@@ -58,6 +61,7 @@ function push_config() {
 	DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
 			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
 	FTRACE_ENABLED=$(sysctl --values kernel.ftrace_enabled)
+	KPROBE_ENABLED=$(cat $SYSFS_KPROBES_DIR/enabled)
 }
 
 function pop_config() {
@@ -67,6 +71,9 @@ function pop_config() {
 	if [[ -n "$FTRACE_ENABLED" ]]; then
 		sysctl kernel.ftrace_enabled="$FTRACE_ENABLED" &> /dev/null
 	fi
+	if [[ -n "$KPROBE_ENABLED" ]]; then
+		echo "$KPROBE_ENABLED" > "$SYSFS_KPROBES_DIR/enabled"
+	fi
 }
 
 function set_dynamic_debug() {
-- 
2.46.0


