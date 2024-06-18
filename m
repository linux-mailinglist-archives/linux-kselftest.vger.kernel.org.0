Return-Path: <linux-kselftest+bounces-12135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A1090C79C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 12:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF121C22A15
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155B71741C7;
	Tue, 18 Jun 2024 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2+RCRAad";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2VPE0btW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2+RCRAad";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2VPE0btW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738D13A3E4;
	Tue, 18 Jun 2024 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701646; cv=none; b=DWkhSGLv1/VBiitsEVVIeDEJhsCLTqAKUaZV10Y5SEt71dUgW1kxR/+FtHW3YOo7pJG3XkSycCdtU6Pyeu63i1rnEuT+6zO+vDPlTs8p6rcvYBtgLe+y/avipavF8NdXo0H+oOEKgmi8ueO36E44nlrPnuHT1ozAbw7F9SfiapY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701646; c=relaxed/simple;
	bh=DcQDcRnTlysaR2fXOEprGScuMtRc/WhV+Vp5yh0HA2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EN4yfLEaAYGBLBkFJnUCSQcNped5N6kZh/YUu9JOOZz+MQJLc1bujLAw5JxOrm0hLbG3IPWSg62DV4MVoxEyRG/K2Z2Q8blisNBpAx0amNBPOJWws93iH70GU2+TyBpaO+XA1KuO5PrH9v0qu0CVhiExNyqa9qRg8s6URPDqWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2+RCRAad; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2VPE0btW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2+RCRAad; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2VPE0btW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1C0C2197E;
	Tue, 18 Jun 2024 09:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718701639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XvNCc8fANotT8kLlUCsy7ONYSq1LLRm8oXVuaOdGI8=;
	b=2+RCRAad26ybIqGcDZKR7bEtMFLzNd0p5/JeWVVnBi52Kh2ghGqNPaoYCFj0ouQobO3NYY
	Md41m8Se9+uzkNSa5i2WXkvn8SQ02DRDNSr1zc34Mq+yHqGVFmZmBGkFOJJaExf3jhs2W/
	HGgt5APUltBG9ffyaeiMS45SgjM/Ot8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718701639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XvNCc8fANotT8kLlUCsy7ONYSq1LLRm8oXVuaOdGI8=;
	b=2VPE0btWLUXNw75zeaLNl2Y9VKGedLyTjtlAskJwy4G0P7lV+8tvzsbyrs6zVAxx6Ev/tA
	kFt5noXydKkqA6Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718701639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XvNCc8fANotT8kLlUCsy7ONYSq1LLRm8oXVuaOdGI8=;
	b=2+RCRAad26ybIqGcDZKR7bEtMFLzNd0p5/JeWVVnBi52Kh2ghGqNPaoYCFj0ouQobO3NYY
	Md41m8Se9+uzkNSa5i2WXkvn8SQ02DRDNSr1zc34Mq+yHqGVFmZmBGkFOJJaExf3jhs2W/
	HGgt5APUltBG9ffyaeiMS45SgjM/Ot8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718701639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6XvNCc8fANotT8kLlUCsy7ONYSq1LLRm8oXVuaOdGI8=;
	b=2VPE0btWLUXNw75zeaLNl2Y9VKGedLyTjtlAskJwy4G0P7lV+8tvzsbyrs6zVAxx6Ev/tA
	kFt5noXydKkqA6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A936413AC1;
	Tue, 18 Jun 2024 09:07:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mEuZKEdOcWbcEQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 18 Jun 2024 09:07:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Jonathan Corbet <corbet@lwn.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] tools: build: Fix bashisms in run.sh
Date: Tue, 18 Jun 2024 11:06:41 +0200
Message-ID: <20240618090641.359008-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240618090641.359008-1-pvorel@suse.cz>
References: <20240618090641.359008-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Fix bashisms:

* exit -1 converted to 255 (exit|return with negative status code is not
  supported on some shells)
* 'function' is useless

This fixes problems on dash, busybox ash or any other strictly POSIX
compatible shell.

Fixes: c819e2cf2eb6f ("tools build: Add new build support")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/build/tests/run.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/build/tests/run.sh b/tools/build/tests/run.sh
index 2c54e4d435464..87d6cad57b20c 100755
--- a/tools/build/tests/run.sh
+++ b/tools/build/tests/run.sh
@@ -1,20 +1,20 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-function test_ex {
+test_ex() {
 	make -C ex V=1 clean > ex.out 2>&1
 	make -C ex V=1 >> ex.out 2>&1
 
 	if [ ! -x ./ex/ex ]; then
 	  echo FAILED
-	  exit -1
+	  exit 255
 	fi
 
 	make -C ex V=1 clean > /dev/null 2>&1
 	rm -f ex.out
 }
 
-function test_ex_suffix {
+test_ex_suffix() {
 	make -C ex V=1 clean > ex.out 2>&1
 
 	# use -rR to disable make's builtin rules
@@ -24,19 +24,19 @@ function test_ex_suffix {
 
 	if [ -x ./ex/ex ]; then
 	  echo FAILED
-	  exit -1
+	  exit 255
 	fi
 
 	if [ ! -f ./ex/ex.o -o ! -f ./ex/ex.i -o ! -f ./ex/ex.s ]; then
 	  echo FAILED
-	  exit -1
+	  exit 255
 	fi
 
 	make -C ex V=1 clean > /dev/null 2>&1
 	rm -f ex.out
 }
 
-function test_ex_include {
+test_ex_include() {
 	make -C ex V=1 clean > ex.out 2>&1
 
 	# build with krava.h include
@@ -45,7 +45,7 @@ function test_ex_include {
 
 	if [ ! -x ./ex/ex ]; then
 	  echo FAILED
-	  exit -1
+	  exit 255
 	fi
 
 	# build without the include
@@ -54,7 +54,7 @@ function test_ex_include {
 
 	if [ ! -x ./ex/ex ]; then
 	  echo FAILED
-	  exit -1
+	  exit 255
 	fi
 
 	make -C ex V=1 clean > /dev/null 2>&1
-- 
2.45.1


