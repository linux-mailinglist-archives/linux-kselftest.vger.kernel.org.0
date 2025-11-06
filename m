Return-Path: <linux-kselftest+bounces-44997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C49AC3C0B2
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC21A1AA72F7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1242868A2;
	Thu,  6 Nov 2025 15:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0TX162G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE34285CBC;
	Thu,  6 Nov 2025 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442848; cv=none; b=p4vMJdNcr+CJNM4CcFNiULiuy7aCEvEuRz0SB9t23hu022D/Bhs735t1OGAq8rKBXY9nxXqt7xfxX36tMJc0PrlyGxvIXn/UjJdhNFzFEQpqLqb22m7inhNI4lePG3iLERj7GfA3/Tw9dYxUl9iTsRPdinsJG1ZG9UzWR2LLRjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442848; c=relaxed/simple;
	bh=pDW3PIbVUN0hwhMWLObPrf02JXtVWHIKLhJ/XRKRmYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2ZnW17wM5YXhLOyDGuVtNrG5Yh5gutG3ioki/Ir41RzZSw2Iw15DPm9xpYE5MvKtTSO9PiKZfE88td8RpS0k4ujaHewPnuO1ooNENsmJ8n+iRFKMR5wNrUeMGXYgaygBTmeJc/m2c/pTtpUl1j4tvMdn7iiX/HmzAHkNvInF98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0TX162G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF8CC4CEF7;
	Thu,  6 Nov 2025 15:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762442847;
	bh=pDW3PIbVUN0hwhMWLObPrf02JXtVWHIKLhJ/XRKRmYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0TX162GToisQ7H3IIvj6EXwpgipnUqEPMAyv5c8iFmiUEaNmFFgFDJq3UZ7pZzhc
	 n8c2Q3tue/suw7YdxQR1tMGZIONLVNr8HLSrONNshuCKOYll/7f6dLG0/05Z0ePQwr
	 NHqrC5uHyG6PPwoZrRVr0qxANOAzzc1o/RyxKfXws3s7RTqa30dHWTaaw7lEtZELUl
	 BrDuSczsfhNPYsoC8KFyoPHFf1uVACJ9/6PZ45ZjFLjWeDiLZdnVl5feZ0miXXBAMF
	 WxSJBfFGjAGcA3dtxhIhs246cZXJFiigCETLwxTgiIWV5wEu0vcfFcf1UUlDFD1dXm
	 zD/EiAzXr73kg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 2/3] char: misc: Leverage revocable fops replacement
Date: Thu,  6 Nov 2025 23:27:11 +0800
Message-ID: <20251106152712.11850-3-tzungbi@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106152712.11850-1-tzungbi@kernel.org>
References: <20251106152712.11850-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Leverage revocable fops replacement if the driver requests.

The "resource" in the context means presence of the miscdevice.  It
prevents file operations (except .release()) in drivers to be called if
the miscdevice no longer exists.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v6:
- Call fs_revocable_replace() after f_op->open() and modify the API
  usage accordingly.
- Use presence of miscdevice as a virtual resource.

v5: https://lore.kernel.org/chrome-platform/20251016054204.1523139-7-tzungbi@kernel.org
- No primary changes but modify the API usage accordingly to support
  multiple revocable providers.

v4: https://lore.kernel.org/chrome-platform/20250923075302.591026-7-tzungbi@kernel.org
- New in the series.

 drivers/char/misc.c        | 18 ++++++++++++++++--
 include/linux/miscdevice.h |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 726516fb0a3b..e0106270c188 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -50,6 +50,8 @@
 #include <linux/tty.h>
 #include <linux/kmod.h>
 #include <linux/gfp.h>
+#include <linux/fs_revocable.h>
+#include <linux/revocable.h>
 
 /*
  * Head entry for the doubly linked miscdevice list
@@ -157,10 +159,16 @@ static int misc_open(struct inode *inode, struct file *file)
 	 */
 	file->private_data = c;
 
-	err = 0;
 	replace_fops(file, new_fops);
-	if (file->f_op->open)
+
+	if (file->f_op->open) {
 		err = file->f_op->open(inode, file);
+		if (err)
+			goto fail;
+	}
+
+	if (c->revocable)
+		err = fs_revocable_replace(c->rp, file);
 fail:
 	mutex_unlock(&misc_mtx);
 	return err;
@@ -218,6 +226,10 @@ int misc_register(struct miscdevice *misc)
 		return -EINVAL;
 	}
 
+	misc->rp = revocable_provider_alloc(misc);
+	if (!misc->rp)
+		return -ENOMEM;
+
 	INIT_LIST_HEAD(&misc->list);
 
 	mutex_lock(&misc_mtx);
@@ -290,6 +302,8 @@ void misc_deregister(struct miscdevice *misc)
 	if (misc->minor > MISC_DYNAMIC_MINOR)
 		misc->minor = MISC_DYNAMIC_MINOR;
 	mutex_unlock(&misc_mtx);
+
+	revocable_provider_revoke(misc->rp);
 }
 EXPORT_SYMBOL(misc_deregister);
 
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 7d0aa718499c..85fac108e485 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -92,6 +92,8 @@ struct miscdevice {
 	const struct attribute_group **groups;
 	const char *nodename;
 	umode_t mode;
+	bool revocable;
+	struct revocable_provider *rp;
 };
 
 extern int misc_register(struct miscdevice *misc);
-- 
2.48.1


