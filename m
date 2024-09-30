Return-Path: <linux-kselftest+bounces-18600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0DD989E78
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 11:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 973F2B2385C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 09:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C2318BB8E;
	Mon, 30 Sep 2024 09:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SGxikexD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SGxikexD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C51F189918;
	Mon, 30 Sep 2024 09:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688796; cv=none; b=ncf8UG7bLPqlf2jZPgS/MA9iCk5Hg4G2tnejkrIplJXSRfVZ9lu5ugH8bn/ZBB6GF5faNSfEdtjkjL1OYaGHXQuQDg9G+f7xvZCO/SHFXjRQEWssW7HlCcTMczE5kac+7eDpoUBdvN2Hng5u7xNWv+Zy9BMQnWchOotNV3FPWOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688796; c=relaxed/simple;
	bh=S9BU7amXaisFCMwJDe9mqHSPT/L+KUEmfQ3bzY0mRPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxN8MuagbmbWsQ2YxNcPMM2vF2OGIjNNf3oLMS8HKlpK6QZ3o505qzDFqiVRZBIpmEa4EFzIeCyYvUfhTWKDWGG3H8STKL/PbrPDXqKlNT41RHZ0vxpy2YVwGQ5dToZRBhpPXh+hG3vaJ3aTvDBzxTuHIRode64bJXuyLEIrAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SGxikexD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SGxikexD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5573D1FB9C;
	Mon, 30 Sep 2024 09:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727688793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVM2w3GwvX1N7/KMlvN+2JAgkc99udLBYMBvTeaCRr8=;
	b=SGxikexDlVl4QFK3U1QK/RflBsl/Den60y0+mcWbMEWdMfhnF61iY/BYPASGaTO7RnzszZ
	MxGRMuMfPOAZxc9TAKl7sKVPBqKvcmaRZm2orSFnYlwSvph6l8uZt7iuvQgOElOGw3paxq
	Hkk0sYVBdgSjn2YdYkp+xjFB9DegnBc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1727688793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVM2w3GwvX1N7/KMlvN+2JAgkc99udLBYMBvTeaCRr8=;
	b=SGxikexDlVl4QFK3U1QK/RflBsl/Den60y0+mcWbMEWdMfhnF61iY/BYPASGaTO7RnzszZ
	MxGRMuMfPOAZxc9TAKl7sKVPBqKvcmaRZm2orSFnYlwSvph6l8uZt7iuvQgOElOGw3paxq
	Hkk0sYVBdgSjn2YdYkp+xjFB9DegnBc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 136AD136CB;
	Mon, 30 Sep 2024 09:33:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MLB8Allw+mayMAAAD6G6ig
	(envelope-from <mvetter@suse.com>); Mon, 30 Sep 2024 09:33:13 +0000
From: Michael Vetter <mvetter@suse.com>
To: linux-kselftest@vger.kernel.org,
	live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Vetter <mvetter@suse.com>
Subject: [PATCH v4 1/3] selftests: livepatch: rename KLP_SYSFS_DIR to SYSFS_KLP_DIR
Date: Mon, 30 Sep 2024 11:33:06 +0200
Message-ID: <20240930093308.65103-2-mvetter@suse.com>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
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
2.46.1


