Return-Path: <linux-kselftest+bounces-18164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00397D4FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 13:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FD71F2311A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73CE14900E;
	Fri, 20 Sep 2024 11:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e/i9Mayh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="e/i9Mayh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B413AA46;
	Fri, 20 Sep 2024 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726833400; cv=none; b=kaSmnAqeF7g+h/tAdudphwgq6Ey9Qs3LOrDeMHtCmNl7byN+mcZJQjLib5ej4kOWop5aYhMNiCj/YfYmu7pCCeuN5UReeQQtqX7RBqWsCJrEK0Q2rIwEKnsjA1NZV08KNnQlhTTD/O/lQENMhjfXImKxih3gmyTBt/2odyXT2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726833400; c=relaxed/simple;
	bh=cDdBjlBCj1Lto++dEWfEdAbNi9G8VooGB6uVQjeAY08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmPA4A0pyI2n0ueicKMx9l75FbGt0niDPd3YALAKinG0Zmvm7NJovKogioPFXpPYeo/SqrMXl/vHNuowk60tkL52rP3MTAaVHJ8ZRekvETRbLwDSgqE1aNz8R84e/+QVWncv0bnnce7BXUNojyHcyMbyyWBldbDWmQ5JzlJnMls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e/i9Mayh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=e/i9Mayh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2E5320A65;
	Fri, 20 Sep 2024 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726833395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+lg1b9Mb30YANtxNPKYAaBcetces83QSJ9TbQfyUaM=;
	b=e/i9MayhLnVzCH2t1vNHcah9TNFYxhP6r52T+JN03nHFDbf+kHKvVLfyTEY7I/LW44KNxS
	6JTItuDF+d7WqdjKa3uQpINR8s1s9qTDO452n756IZJ8iRTSKZJz1fvWTmIBux4EwNWba/
	Y881BBLfJPjnIHKqXWXTZvP9zApbGiM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="e/i9Mayh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726833395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+lg1b9Mb30YANtxNPKYAaBcetces83QSJ9TbQfyUaM=;
	b=e/i9MayhLnVzCH2t1vNHcah9TNFYxhP6r52T+JN03nHFDbf+kHKvVLfyTEY7I/LW44KNxS
	6JTItuDF+d7WqdjKa3uQpINR8s1s9qTDO452n756IZJ8iRTSKZJz1fvWTmIBux4EwNWba/
	Y881BBLfJPjnIHKqXWXTZvP9zApbGiM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E35E13AE1;
	Fri, 20 Sep 2024 11:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gFI9GPNi7WbdHwAAD6G6ig
	(envelope-from <mvetter@suse.com>); Fri, 20 Sep 2024 11:56:35 +0000
From: Michael Vetter <mvetter@suse.com>
To: linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Vetter <mvetter@suse.com>
Subject: [PATCH v3 1/3] selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
Date: Fri, 20 Sep 2024 13:56:29 +0200
Message-ID: <20240920115631.54142-2-mvetter@suse.com>
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
X-Rspamd-Queue-Id: C2E5320A65
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
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

This naming makes more sense according to the directory structure.
Especially when we later add more paths.

Signed-off-by: Michael Vetter <mvetter@suse.com>
---
 tools/testing/selftests/livepatch/functions.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index fc4c6a016d38..50361fceff06 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -6,7 +6,7 @@
 
 MAX_RETRIES=600
 RETRY_INTERVAL=".1"	# seconds
-KLP_SYSFS_DIR="/sys/kernel/livepatch"
+SYSFS_KLP_DIR="/sys/kernel/livepatch"
 
 # Kselftest framework requirement - SKIP code is 4
 ksft_skip=4
@@ -322,7 +322,7 @@ function check_sysfs_rights() {
 	local rel_path="$1"; shift
 	local expected_rights="$1"; shift
 
-	local path="$KLP_SYSFS_DIR/$mod/$rel_path"
+	local path="$SYSFS_KLP_DIR/$mod/$rel_path"
 	local rights=$(/bin/stat --format '%A' "$path")
 	if test "$rights" != "$expected_rights" ; then
 		die "Unexpected access rights of $path: $expected_rights vs. $rights"
@@ -338,7 +338,7 @@ function check_sysfs_value() {
 	local rel_path="$1"; shift
 	local expected_value="$1"; shift
 
-	local path="$KLP_SYSFS_DIR/$mod/$rel_path"
+	local path="$SYSFS_KLP_DIR/$mod/$rel_path"
 	local value=`cat $path`
 	if test "$value" != "$expected_value" ; then
 		die "Unexpected value in $path: $expected_value vs. $value"
-- 
2.46.0


