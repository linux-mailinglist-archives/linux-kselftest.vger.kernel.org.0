Return-Path: <linux-kselftest+bounces-42134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697EDB94DF6
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 09:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07DCF2E300E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2782A31A545;
	Tue, 23 Sep 2025 07:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWs2taNL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE938316911;
	Tue, 23 Sep 2025 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614048; cv=none; b=aloiIYmgcvGCvV27VnUGEzh2YUbm+Hwjd2y0S3CfbcTbE94e3BBnXfZzKHexznoU+93gWmgJ4KAwa40oZChme6vCjVYcQ6ICxfI449ei7l6y+jA5YywkITcMcUi71437I0V64oYo+YWKRU6y6OaTSH0DsD9uxHOQN4u+KTheh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614048; c=relaxed/simple;
	bh=o24QhhmJhFoOpPs5W1B9tctsB4oSL2CP11f+qD6c0Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKUCnw8g7hAZuhORf7Z+O3UW20vNhzo4tL3Njvz+6vFASQDHDfPJKEa6Gnm/sJpXBB7uicsx4pWDAqHrsnAPIh930r7458sdCVLtrt9+q4knGnOUZzKFdC6theXIDlFSR8tBv6j2/sHNFOZj+ZJKJdt+zFZ0WL274xmhldSx0+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWs2taNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439C0C116C6;
	Tue, 23 Sep 2025 07:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758614047;
	bh=o24QhhmJhFoOpPs5W1B9tctsB4oSL2CP11f+qD6c0Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IWs2taNLS+dJ9WXJzOY37cw3+8IckMKqrddtc4+fX1kPG50Ds5JsIFF87ADscpFMM
	 m8DvOlLgwh2DTkVlkhHnc2NEtkb91AMNeZJEww6nb6CvN8N7WDepuTLOOYMvAVDX6y
	 NmJsSpyzrsal004h9yH2Somdkv7p7N3gMWJD2lfOZ5P82uK9Jbzh9FukUn8LGol6hN
	 9r0CdiTV+VtbqYxptIOXuKToiGLltM5kuk0JsTYcUbB9yJ9V8ZiLBr0MSH2OBeV9Ey
	 9ylPDQ4Z/XeZZ31Mb3qAdt05Q74/+6rvHedTOFl6ax2CCceOjApfgJcIvGeMl0SSev
	 NmFPcS3NahCBg==
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
Subject: [PATCH v4 4/7] platform/chrome: Protect cros_ec_device lifecycle with revocable
Date: Tue, 23 Sep 2025 07:52:59 +0000
Message-ID: <20250923075302.591026-5-tzungbi@kernel.org>
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

The cros_ec_device can be unregistered when the underlying device is
removed.  Other kernel drivers that interact with the EC may hold a
pointer to the cros_ec_device, creating a risk of a use-after-free
error if the EC device is removed while still being referenced.

To prevent this, leverage the revocable and convert the underlying
device drivers to resource providers of cros_ec_device.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v4:
- No changes.

v3: https://lore.kernel.org/chrome-platform/20250912081718.3827390-5-tzungbi@kernel.org
- Initialize the revocable provider in cros_ec_device_alloc() instead of
  spreading in protocol device drivers.

v2: https://lore.kernel.org/chrome-platform/20250820081645.847919-5-tzungbi@kernel.org
- Rename "ref_proxy" -> "revocable".

v1: https://lore.kernel.org/chrome-platform/20250814091020.1302888-3-tzungbi@kernel.org

 drivers/platform/chrome/cros_ec.c           | 5 +++++
 include/linux/platform_data/cros_ec_proto.h | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 1da79e3d215b..95e3e898e3da 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/cros_ec_commands.h>
 #include <linux/platform_data/cros_ec_proto.h>
+#include <linux/revocable.h>
 #include <linux/slab.h>
 #include <linux/suspend.h>
 
@@ -47,6 +48,10 @@ struct cros_ec_device *cros_ec_device_alloc(struct device *dev)
 	if (!ec_dev)
 		return NULL;
 
+	ec_dev->revocable_provider = devm_revocable_provider_alloc(dev, ec_dev);
+	if (!ec_dev->revocable_provider)
+		return NULL;
+
 	ec_dev->din_size = sizeof(struct ec_host_response) +
 			   sizeof(struct ec_response_get_protocol_info) +
 			   EC_MAX_RESPONSE_OVERHEAD;
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index de14923720a5..fbb6ca34a40f 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -12,6 +12,7 @@
 #include <linux/lockdep_types.h>
 #include <linux/mutex.h>
 #include <linux/notifier.h>
+#include <linux/revocable.h>
 
 #include <linux/platform_data/cros_ec_commands.h>
 
@@ -165,6 +166,7 @@ struct cros_ec_command {
  * @pd: The platform_device used by the mfd driver to interface with the
  *      PD behind an EC.
  * @panic_notifier: EC panic notifier.
+ * @revocable_provider: The revocable_provider to this device.
  */
 struct cros_ec_device {
 	/* These are used by other drivers that want to talk to the EC */
@@ -211,6 +213,8 @@ struct cros_ec_device {
 	struct platform_device *pd;
 
 	struct blocking_notifier_head panic_notifier;
+
+	struct revocable_provider *revocable_provider;
 };
 
 /**
-- 
2.51.0.534.gc79095c0ca-goog


