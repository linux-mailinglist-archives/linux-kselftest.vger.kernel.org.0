Return-Path: <linux-kselftest+bounces-4793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3422D856C37
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EA71C21A99
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FC613A24F;
	Thu, 15 Feb 2024 18:12:51 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DA713959E;
	Thu, 15 Feb 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020771; cv=none; b=rCyoRbseZtsWuoUHQAulXdLPqvtP8x5dT/acr3Q7ffvU7DLJ8zARrb6aObOBKVOXal4YkWgLEF9UBGhaH2/W+KFFNf3bDN38jVvGbfa5DoEAyx80jGMmr2Xqr6ySf01O1hYmhCSthr4d9F4MoBFeGSSnjI8wbnNJhy8BodoLGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020771; c=relaxed/simple;
	bh=mobHejLyMa9lwd2koRFuFHd/TN2Lj+Tpf18ZnDm+jd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UXX2UwL9hFkX2eMtAXcAT2KkY/C3lojUP60hq2a3wO+NeuT2HdlkCku/Z0IWPcLhwXhXJiR4UdYS8rwDNJEHknZGzLrnbSArm4uF466ah/sRObmAL0iGTVDVx4hadQElKgogumVxDojn6xZQFWrbmIcS6UE6Z72gJNoWgEXzLuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EA1F821F36;
	Thu, 15 Feb 2024 18:12:47 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 702C51346A;
	Thu, 15 Feb 2024 18:12:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id hjlKDh9UzmX3VwAAn2gu4w
	(envelope-from <mpdesouza@suse.com>); Thu, 15 Feb 2024 18:12:47 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Thu, 15 Feb 2024 15:12:22 -0300
Subject: [PATCH 3/3] selftests: livepatch: Add initial .gitignore
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-lp-selftests-fixes-v1-3-89f4a6f5cddc@suse.com>
References: <20240215-lp-selftests-fixes-v1-0-89f4a6f5cddc@suse.com>
In-Reply-To: <20240215-lp-selftests-fixes-v1-0-89f4a6f5cddc@suse.com>
To: Shuah Khan <shuah@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, 
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 live-patching@vger.kernel.org, Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708020755; l=492;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=mobHejLyMa9lwd2koRFuFHd/TN2Lj+Tpf18ZnDm+jd0=;
 b=yt2S3SLlOz8UjVQ3bvVyhzblQN92xH3EvaRhnrlwLoYKonlhBs++FysaWuRcC+F6VDo/cxdky
 Edgz/8WeASHCdy3tAVe8/kyfBeluhkGdMx3yDa6TVieBnOG9ovuzvbY
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: EA1F821F36
X-Spam-Level: 
X-Spam-Score: -4.00
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


