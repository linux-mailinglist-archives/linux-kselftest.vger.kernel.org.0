Return-Path: <linux-kselftest+bounces-43285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67483BE18B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 07:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 125A2350F6B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 05:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D51B2522BE;
	Thu, 16 Oct 2025 05:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA3xHqBu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A07251793;
	Thu, 16 Oct 2025 05:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593389; cv=none; b=lRbDxzJl3QbHewPa+HsSZqP8l6+st/cG1FyRKfzAWYoNW3AhplyponU0i6Y6zAivkxQ2AB2HoXLq4wZg0CHDFpAW8OixTOgkxfiWTQlQDXFQk6cmjYf4EM54cvnykEk54w1jgVWI6kYi86CRx0xIL2pX3WC8q2jJ44Ia9Mwwk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593389; c=relaxed/simple;
	bh=I4XuDN4yktmrYsSnv6UDwJT4c61SEYgQLvhKVNQf2O4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZccHoD5ebQ0h/X+hxOZJVkBzWLGY3Zf325gSW+dci37wtJhpqVUqTN98Fr+Al8c1RFWCrutdKa6+bo5CTjbx7t+qQOr6zLuGqJcR+JcWG941QL6eBTLbnLcLagY04WimFVTD40kUDUO3M+CpjEeWbPZx5ZoEOuBPeBBcmqGUSnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IA3xHqBu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D72C4CEFB;
	Thu, 16 Oct 2025 05:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760593389;
	bh=I4XuDN4yktmrYsSnv6UDwJT4c61SEYgQLvhKVNQf2O4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IA3xHqBuTahiy7FZEE8jkseB6+LwzKHIXQWc3Z169sioMUb98utynTzoCiNf7ecCZ
	 Xoz2xTjYjR10JYSrHQXhl3o2M2C5ne4IKCdAf9hcDEzzoebC02pXXDJ56GOdulBT4f
	 Z6E82sQFH1RxDxh9i/5BLJVg/3FFwyrLcVXNtmL5vPy7JFOiIRr1OUtMvJ5nYiHdUx
	 4Xsz25U5+m7aph+Oim7EU7bfPKmn7Nm7mgV8Jskuu+NlN6od1AY+L89TG8QSFG1hgq
	 Zq9OHJNJTjsUA6W75Az2nJ+nZymqBD/tYSneGdByMfJAgj+4Assc+u+R+W/ck+3lw9
	 g1ga55QojYmYQ==
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
Subject: [PATCH v5 6/7] char: misc: Leverage revocable fops replacement
Date: Thu, 16 Oct 2025 05:42:03 +0000
Message-ID: <20251016054204.1523139-7-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
In-Reply-To: <20251016054204.1523139-1-tzungbi@kernel.org>
References: <20251016054204.1523139-1-tzungbi@kernel.org>
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

v5:
- No primary changes but modify the API usage accordingly to support
  multiple revocable providers.

v4: https://lore.kernel.org/chrome-platform/20250923075302.591026-7-tzungbi@kernel.org
- New in the series.

 drivers/char/misc.c        | 8 ++++++++
 include/linux/miscdevice.h | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 726516fb0a3b..5b412e18b8a6 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -50,6 +50,7 @@
 #include <linux/tty.h>
 #include <linux/kmod.h>
 #include <linux/gfp.h>
+#include <linux/fs_revocable.h>
 
 /*
  * Head entry for the doubly linked miscdevice list
@@ -159,6 +160,13 @@ static int misc_open(struct inode *inode, struct file *file)
 
 	err = 0;
 	replace_fops(file, new_fops);
+
+	if (c->frops && c->rps)  {
+		err = fs_revocable_replace(file, c->frops, c->rps, c->num_rps);
+		if (err)
+			goto fail;
+	}
+
 	if (file->f_op->open)
 		err = file->f_op->open(inode, file);
 fail:
diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 7d0aa718499c..b7024a0cebb9 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/device.h>
+#include <linux/revocable.h>
 
 /*
  *	These allocations are managed by device@lanana.org. If you need
@@ -92,6 +93,9 @@ struct miscdevice {
 	const struct attribute_group **groups;
 	const char *nodename;
 	umode_t mode;
+	struct revocable_provider **rps;
+	size_t num_rps;
+	const struct fs_revocable_operations *frops;
 };
 
 extern int misc_register(struct miscdevice *misc);
-- 
2.51.0.788.g6d19910ace-goog


