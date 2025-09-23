Return-Path: <linux-kselftest+bounces-42136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE7B94E14
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 09:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD237AC3C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6827931D373;
	Tue, 23 Sep 2025 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gscxRXPf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B24A31D36B;
	Tue, 23 Sep 2025 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614053; cv=none; b=bfqTZMxlBnyxiovxsYHdRlM6or5YPTUzBHg81Q2bnQmcmRsafjQLO8ucpe4R/J3hKwxADKMcht/FYWSBPhdNhmPBIrURRkA6cqq919NBwz3aom6QSC3FgPE8EsMG6SjDr8PdVd6LdQX4EDi63YSWrsmTzqCfOMp+Az9spUjhB0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614053; c=relaxed/simple;
	bh=B5yspoVEdUZIlz6ON6UuHHvuCsW3fWYDgueIszEOLn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3OiuvjtDCuY3wu0SWnostIu54ePRT0xn/yrLogd7ngeZxI4OZaYKTPEWDroOKPPtORf/yMlDoxhxdWtuV/w1COtP9Xd0T1r2xClH26RjPwyv83WREa7uN3e8h5fu5HTNhcLmuVPQFiHJavg1b3RPN46BvYJ4MZ3BaGlHt6ieF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gscxRXPf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A39C4CEF7;
	Tue, 23 Sep 2025 07:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758614052;
	bh=B5yspoVEdUZIlz6ON6UuHHvuCsW3fWYDgueIszEOLn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gscxRXPfDCn/AwUv9B6wRwgV0nBMv4bx3S1sQ36EpCfXHbMI0/Xb9cORwDIATisQa
	 3+Drjh6iQjpuaP91lu7+9dBEiY4WWnsRVqDaOad9Nt4LNje+x2bHAl8CdWuemBGIlN
	 oHxn3XE+zTaF0pNl5j5ne8psssXjMC4+DL60Rdm06SsUqihyQpdGAcxZ9kGshlmQ9G
	 B0uec76/pArGgSYB91WQNhVCOnz+dhrAab+WUqWdzopCeMbgxRUqfEkV0Vi0TGvob+
	 Iz3Og+3TTJ+TepamprRpzO08+oSO94VYtVK6UH42/m3RT5HHFyeaadn1SCJ+7FBt3/
	 N7gkL0MiKTiXw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Dawid Niedzwiecki <dawidn@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 6/7] char: misc: Leverage revocable fops replacement
Date: Tue, 23 Sep 2025 07:53:01 +0000
Message-ID: <20250923075302.591026-7-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
In-Reply-To: <20250923075302.591026-1-tzungbi@kernel.org>
References: <20250923075302.591026-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
PoC patch.

v4:
- New in the series.

 drivers/char/misc.c        | 7 +++++++
 include/linux/miscdevice.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 726516fb0a3b..fcbbb0b1af35 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -159,6 +159,13 @@ static int misc_open(struct inode *inode, struct file *file)
 
 	err = 0;
 	replace_fops(file, new_fops);
+
+	if (c->rp && c->rops) {
+		err = revocable_replace_fops(file, c->rp, c->rops);
+		if (err)
+			goto fail;
+	}
+
 	if (file->f_op->open)
 		err = file->f_op->open(inode, file);
 fail:
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 7d0aa718499c..00f5c878266a 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/revocable.h>
 
 /*
  *	These allocations are managed by device@lanana.org. If you need
@@ -92,6 +93,8 @@ struct miscdevice {
 	const struct attribute_group **groups;
 	const char *nodename;
 	umode_t mode;
+	struct revocable_provider *rp;
+	const struct revocable_operations *rops;
 };
 
 extern int misc_register(struct miscdevice *misc);
-- 
2.51.0.534.gc79095c0ca-goog


