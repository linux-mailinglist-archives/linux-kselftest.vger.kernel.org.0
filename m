Return-Path: <linux-kselftest+bounces-5203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA4985E45A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 18:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD43D1C22C72
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 17:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2FA85628;
	Wed, 21 Feb 2024 17:17:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CB885279;
	Wed, 21 Feb 2024 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535840; cv=none; b=tXM7sigWilkTLjSJwMysqJPjFHkXpQ/BSacHUvtihJJB8mAgre47ixm/sHkChJPpmPomJo7Hi8FU4FF8gNKh5HiX4dFhwo5TQ0THAN4CBqG3puzr5xZfpRx3OZEsmK/X+f4ehIhOoFzU76oBLY/I4lg3INnWIEahoLrDkUg1Ing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535840; c=relaxed/simple;
	bh=mobHejLyMa9lwd2koRFuFHd/TN2Lj+Tpf18ZnDm+jd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aKBwlJZsaiOGwekcu3v3IwGwF2OzZTcBgjWAXZSLu32KLo0+FLjZtlwIQZycCHL54w5lmmbGM74QZlctShRAaJWGTTyngje1t6df1ZVBy9HFMojDO4XmFZL3Nr0zzINgRF449GUUjtLzV9tSQ9nnYx2fKOFZ5Clm1ca/0Cuis/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED5901FB74;
	Wed, 21 Feb 2024 17:17:16 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 76B7013A25;
	Wed, 21 Feb 2024 17:17:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1X9qDxww1mUScQAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Wed, 21 Feb 2024 17:17:16 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Wed, 21 Feb 2024 14:17:03 -0300
Subject: [PATCH v2 1/4] selftests: livepatch: Add initial .gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-lp-selftests-fixes-v2-1-a19be1e029a7@suse.com>
References: <20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com>
In-Reply-To: <20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com>
To: Shuah Khan <shuah@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708535830; l=492;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=mobHejLyMa9lwd2koRFuFHd/TN2Lj+Tpf18ZnDm+jd0=;
 b=/hIEGXkpjh7TVD6fXJniB+mfAwmZa4nWRiV3dKm0vlhTfkx8DXT9B3XvSYSJfxnrmh0DZ2KUd
 q3MPSndVo/yDoZGyK2sgmloaE43WImB0t95JQj3USZD3kQ57dp2dKwB
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: ED5901FB74
X-Spam-Flag: NO

Ignore the binary used to test livepatching a syscall.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 tools/testing/selftests/livepatch/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/livepatch/.gitignore b/tools/testing/selftests/livepatch/.gitignore
new file mode 100644
index 000000000000..f1e9c2a20e99
--- /dev/null
+++ b/tools/testing/selftests/livepatch/.gitignore
@@ -0,0 +1 @@
+test_klp-call_getpid

-- 
2.42.1


