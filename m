Return-Path: <linux-kselftest+bounces-44993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C580C3C07F
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8842618994DB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EB728000B;
	Thu,  6 Nov 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PorfN4Yj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8E26D4F6;
	Thu,  6 Nov 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442784; cv=none; b=ff7q/+ThqTRI30e1QHxnlCiOhD5k3Peq8CcCQB0m2sDO8wm3VQzX95jL6ES3ivVkYuDKhfpoyFdPeZ2qx2lMiP+s3qDtYld5N0IUAw+lxU87nkPZ1+aAgP25xb3rKQe3VRdEhTu8OEIKswKSPZYgKhWqgitRkLylgu9JBR63p1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442784; c=relaxed/simple;
	bh=P0chS0ZP7pD2W1uEk1d7ykfQfFOgqFn2PUOuI4DCx8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qnqw/5yDAEhNFEHy1tLOd4ZjTWTieEBhIxaFJFxkOgeLNcicCLURqtCKhaDLVazhK2UofH/ufQ16IJ+rmzMJlqrs3bEU6twnRc5cxxS5eukqJB2kzkKpBu5a6bk/5iX+O+7rF5+orefnCCPSkucQ1za+s4MhuBLmdTYI0cawoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PorfN4Yj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319B0C4CEF7;
	Thu,  6 Nov 2025 15:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762442784;
	bh=P0chS0ZP7pD2W1uEk1d7ykfQfFOgqFn2PUOuI4DCx8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PorfN4YjDfa9dbSNb5rlzDcmGb+67C1iqBMn4/T6YpOodX9KywWT4YiWuipxgOakn
	 g8cQqep65dRv4bw7LUeteTAIM1s4k/k44/aAlgTMToc6usasoKKKaMhdQzh4v7y5q0
	 ti9HkQggjJskw+8uxMSqI5Hhixi3rh3YAZAdo+RFgAu42Az/as+HllRVC311/pusdX
	 +KaOTB+uWCuPYawD5KO8nrLZATFye6gyXRfTMb8BWo3Vxkn0xdU2sLpYRsotiyn4BB
	 yXFRzbc7M6vLAXu593d+FgU37rQXLL5iMQuuNzUlIplgoNsnDJKYgzawBls5H26yHo
	 qqAOAnAXqfD9g==
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
Subject: [PATCH v6 1/2] platform/chrome: Protect cros_ec_device lifecycle with revocable
Date: Thu,  6 Nov 2025 23:26:01 +0800
Message-ID: <20251106152602.11814-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106152602.11814-1-tzungbi@kernel.org>
References: <20251106152602.11814-1-tzungbi@kernel.org>
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
v6:
- No changes.

v5: https://lore.kernel.org/chrome-platform/20251016054204.1523139-5-tzungbi@kernel.org
- No changes.

v4: https://lore.kernel.org/chrome-platform/20250923075302.591026-5-tzungbi@kernel.org
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
2.48.1


