Return-Path: <linux-kselftest+bounces-12136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B5A90C79E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 12:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0333A1C22293
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 10:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9931BD511;
	Tue, 18 Jun 2024 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KhsbSjP6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vdw+UY/k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KhsbSjP6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vdw+UY/k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5576155389;
	Tue, 18 Jun 2024 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701646; cv=none; b=G22uzxJAgBOpBVEgLt+TdYJ2SNWKwmqbFbNOD/CeLnFcy4exGFTGQYsBr0qrZGsUz28ym1/4gfY7aUP0F3WwJO3Dhf0Kt4kTfxTVhYjbir6GcDJ80NaMuB41hLRjrPoxCx3yEtcYO0Q45TfTMuJpskXJ5s0d8vPC5ywFLIfaPGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701646; c=relaxed/simple;
	bh=iAcRPr7AOKSjGkTdc99w7XDM1enuja+68OlgB77FMYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U2Bd75e3ka0b6XLkO2h01quJmzgFxq9itjysuc2mJIRY8tGVPKHDofdIvGnYstd7mUssvaTbio4t0ujQHnV450SD/mG4MXeAGm8G1w+3Lot+O+z5LW9jVUN1925esotyrXZtzCRXnyfla4zU9+pt9J5Uy2OuNUV99k+WggT74d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KhsbSjP6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vdw+UY/k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KhsbSjP6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vdw+UY/k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4B832197C;
	Tue, 18 Jun 2024 09:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718701639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5ZVEYvIYH9j/W1UVN1FalkuLoxY8JnQpAdqMTu+qdf4=;
	b=KhsbSjP6y0GkinjWslI4OBoh+kALBi/4ivyQ4++K/mVn37Mb09NqUqHbFFntz/RvfAfh19
	oGttCyZbD9fueWEZoKQpLFG3+oZOnGDtnBG1FNx6lI/vtYRG83iYWhWPy0kdxWfifMcyC+
	bghjjgJT1fjRgEX4nUhmwp47v26770E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718701639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5ZVEYvIYH9j/W1UVN1FalkuLoxY8JnQpAdqMTu+qdf4=;
	b=vdw+UY/kFBdiKfLHS8rOpqGy2uyVugyAY0pjhxoM1T6wfQIvhB/9RRD0TcSnbOkUvh86Go
	1g0ctgc7on755lAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KhsbSjP6;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="vdw+UY/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718701639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5ZVEYvIYH9j/W1UVN1FalkuLoxY8JnQpAdqMTu+qdf4=;
	b=KhsbSjP6y0GkinjWslI4OBoh+kALBi/4ivyQ4++K/mVn37Mb09NqUqHbFFntz/RvfAfh19
	oGttCyZbD9fueWEZoKQpLFG3+oZOnGDtnBG1FNx6lI/vtYRG83iYWhWPy0kdxWfifMcyC+
	bghjjgJT1fjRgEX4nUhmwp47v26770E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718701639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5ZVEYvIYH9j/W1UVN1FalkuLoxY8JnQpAdqMTu+qdf4=;
	b=vdw+UY/kFBdiKfLHS8rOpqGy2uyVugyAY0pjhxoM1T6wfQIvhB/9RRD0TcSnbOkUvh86Go
	1g0ctgc7on755lAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 702121369F;
	Tue, 18 Jun 2024 09:07:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0tB6GkdOcWbcEQAAD6G6ig
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
Subject: [PATCH 1/2] tools: kernel-chktaint: Fix bashism, simplify code
Date: Tue, 18 Jun 2024 11:06:40 +0200
Message-ID: <20240618090641.359008-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A4B832197C
X-Spam-Score: -2.44
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.44 / 50.00];
	BAYES_HAM(-2.43)[97.41%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

'==' is bashism, '=' needs to be used for comparison.
With this fix script can work on systems where the default shell is
dash, busybox ash or any other strictly POSIX compatible shell.

While at it, also improve:
* remove "x" in the comparison (not needed for decades)
* use $# for checking number of arguments
* cleanup whitespace

Fixes: 4ab5a5d2a4a22 ("tools: add a kernel-chktaint to tools/debugging")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/debugging/kernel-chktaint | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 279be06332be9..adbb1d621ccd4 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -18,11 +18,11 @@ retrieved from /proc/sys/kernel/tainted on another system.
 EOF
 }
 
-if [ "$1"x != "x" ]; then
-	if  [ "$1"x == "--helpx" ] || [ "$1"x == "-hx" ] ; then
+if [ $# -gt 0 ]; then
+	if  [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
 		usage
 		exit 1
-	elif  [ $1 -ge 0 ] 2>/dev/null ; then
+	elif  [ $1 -ge 0 ] 2>/dev/null; then
 		taint=$1
 	else
 		echo "Error: Parameter '$1' not a positive integer. Aborting." >&2
-- 
2.45.1


