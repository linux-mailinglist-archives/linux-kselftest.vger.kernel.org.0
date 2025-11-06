Return-Path: <linux-kselftest+bounces-44994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0908EC3C0EE
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 16:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B393A3B9F22
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B7284665;
	Thu,  6 Nov 2025 15:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ni/wX+SP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F326D4F6;
	Thu,  6 Nov 2025 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762442787; cv=none; b=F+WLiPoVtV42PYEHbBMxUJmyzlCdqFvIVL9X9QPsa+O4GOYkXzFUmTfozf126b+wudu0jDtfllcaJoLWabZUzLJA2TvHoq0H4L2IlkKdPaS1TYAYtysymj4m4xXshDyV05yDeNhilMkEFZNGl2ZabEo76jiMIJU9h9LAlG90JmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762442787; c=relaxed/simple;
	bh=p7sejcywyy/r5IDan3tCtEBgPygiAM+/bmvc/ybEIVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mgkPOoM2aYW+BzdfIQXpCTAYqooQtHb75/4lrx6d9cPxJo4dczdDd4OLN1Iy9O4z6e0+wbjmhmpi7uGQtTXPVT3Rl2C0vRqm6D6w/BW6+BnhCaTn7wM9/VZSV5Fh4Qj0MoGxlVme6XvsIDox0ZwQIpUM/ZUZdHlGCL82S8Tsb3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ni/wX+SP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EFAC116C6;
	Thu,  6 Nov 2025 15:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762442787;
	bh=p7sejcywyy/r5IDan3tCtEBgPygiAM+/bmvc/ybEIVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ni/wX+SPYsJPgLp51f/fvtVrM5Qyeho44HXTrH+se/0E7pZTn/4rkYCGv662Xnf4a
	 cJfOrOgeQ9d5OsOuL5epYWYrZvUCCJKngmRC2WtETouroTDuh9GisUPwDsRPrpGVBn
	 j9SYEKQhInTwm2v2uUMyvmxEw7jkA/w3Qg3HoXQCZlQMLL9H6vnRzUg8jUR/I3zmJ4
	 nXn7NhhGqCFIgzOx5jyb2Jdh3S9dsBGqETAvjHZCkM6wTXJv8yrcnD8XhTjostxLZK
	 VPnZxw9hpxvK7+ovXs8AJRzbEogz2SQZpQcVjywS5zd4EUeBMNbg/SUqvs5Sz7gGJ4
	 slyWcfzpVWPuw==
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
Subject: [PATCH v6 2/2] platform/chrome: cros_ec_chardev: Consume cros_ec_device via revocable
Date: Thu,  6 Nov 2025 23:26:02 +0800
Message-ID: <20251106152602.11814-3-tzungbi@kernel.org>
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

The cros_ec_chardev driver provides a character device interface to the
ChromeOS EC.  A file handle to this device can remain open in userspace
even if the underlying EC device is removed.

This creates a classic use-after-free vulnerability.  Any file operation
(ioctl, release, etc.) on the open handle after the EC device has gone
would access a stale pointer, leading to a system crash.

To prevent this, leverage the revocable and convert cros_ec_chardev to a
resource consumer of cros_ec_device.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v6:
- Rename REVOCABLE_TRY_ACCESS_WITH() -> REVOCABLE_TRY_ACCESS_SCOPED().
- Use new REVOCABLE_TRY_ACCESS_WITH() if applicable.

v4-v5:
- Doesn't exist.

v3: https://lore.kernel.org/chrome-platform/20250912081718.3827390-6-tzungbi@kernel.org/
- Use specific labels for different cleanup in cros_ec_chardev_open().

v2: https://lore.kernel.org/chrome-platform/20250820081645.847919-6-tzungbi@kernel.org
- Rename "ref_proxy" -> "revocable".
- Fix a sparse warning by removing the redundant __rcu annotation.

v1: https://lore.kernel.org/chrome-platform/20250814091020.1302888-4-tzungbi@kernel.org

 drivers/platform/chrome/cros_ec_chardev.c | 71 ++++++++++++++++++-----
 1 file changed, 56 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index c9d80ad5b57e..bc152c206fb8 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -22,6 +22,7 @@
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
+#include <linux/revocable.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
@@ -32,7 +33,7 @@
 #define CROS_MAX_EVENT_LEN	PAGE_SIZE
 
 struct chardev_priv {
-	struct cros_ec_device *ec_dev;
+	struct revocable *ec_dev_rev;
 	struct notifier_block notifier;
 	wait_queue_head_t wait_event;
 	unsigned long event_mask;
@@ -55,6 +56,7 @@ static int ec_get_version(struct chardev_priv *priv, char *str, int maxlen)
 	};
 	struct ec_response_get_version *resp;
 	struct cros_ec_command *msg;
+	struct cros_ec_device *ec_dev;
 	int ret;
 
 	msg = kzalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);
@@ -64,7 +66,13 @@ static int ec_get_version(struct chardev_priv *priv, char *str, int maxlen)
 	msg->command = EC_CMD_GET_VERSION + priv->cmd_offset;
 	msg->insize = sizeof(*resp);
 
-	ret = cros_ec_cmd_xfer_status(priv->ec_dev, msg);
+	REVOCABLE_TRY_ACCESS_WITH(priv->ec_dev_rev, ec_dev);
+	if (!ec_dev) {
+		ret = -ENODEV;
+		goto exit;
+	}
+
+	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
 	if (ret < 0) {
 		snprintf(str, maxlen,
 			 "Unknown EC version, returned error: %d\n",
@@ -92,10 +100,17 @@ static int cros_ec_chardev_mkbp_event(struct notifier_block *nb,
 {
 	struct chardev_priv *priv = container_of(nb, struct chardev_priv,
 						 notifier);
-	struct cros_ec_device *ec_dev = priv->ec_dev;
+	struct cros_ec_device *ec_dev;
 	struct ec_event *event;
-	unsigned long event_bit = 1 << ec_dev->event_data.event_type;
-	int total_size = sizeof(*event) + ec_dev->event_size;
+	unsigned long event_bit;
+	int total_size;
+
+	REVOCABLE_TRY_ACCESS_WITH(priv->ec_dev_rev, ec_dev);
+	if (!ec_dev)
+		return NOTIFY_DONE;
+
+	event_bit = 1 << ec_dev->event_data.event_type;
+	total_size = sizeof(*event) + ec_dev->event_size;
 
 	if (!(event_bit & priv->event_mask) ||
 	    (priv->event_len + total_size) > CROS_MAX_EVENT_LEN)
@@ -166,7 +181,12 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->ec_dev = ec_dev;
+	priv->ec_dev_rev = revocable_alloc(ec_dev->revocable_provider);
+	if (!priv->ec_dev_rev) {
+		ret = -ENOMEM;
+		goto free_priv;
+	}
+
 	priv->cmd_offset = ec->cmd_offset;
 	filp->private_data = priv;
 	INIT_LIST_HEAD(&priv->events);
@@ -178,9 +198,14 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
 					       &priv->notifier);
 	if (ret) {
 		dev_err(ec_dev->dev, "failed to register event notifier\n");
-		kfree(priv);
+		goto free_revocable;
 	}
 
+	return 0;
+free_revocable:
+	revocable_free(priv->ec_dev_rev);
+free_priv:
+	kfree(priv);
 	return ret;
 }
 
@@ -251,11 +276,15 @@ static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
 static int cros_ec_chardev_release(struct inode *inode, struct file *filp)
 {
 	struct chardev_priv *priv = filp->private_data;
-	struct cros_ec_device *ec_dev = priv->ec_dev;
+	struct cros_ec_device *ec_dev;
 	struct ec_event *event, *e;
 
-	blocking_notifier_chain_unregister(&ec_dev->event_notifier,
-					   &priv->notifier);
+	REVOCABLE_TRY_ACCESS_SCOPED(priv->ec_dev_rev, ec_dev) {
+		if (ec_dev)
+			blocking_notifier_chain_unregister(&ec_dev->event_notifier,
+							   &priv->notifier);
+	}
+	revocable_free(priv->ec_dev_rev);
 
 	list_for_each_entry_safe(event, e, &priv->events, node) {
 		list_del(&event->node);
@@ -273,6 +302,7 @@ static long cros_ec_chardev_ioctl_xcmd(struct chardev_priv *priv, void __user *a
 {
 	struct cros_ec_command *s_cmd;
 	struct cros_ec_command u_cmd;
+	struct cros_ec_device *ec_dev;
 	long ret;
 
 	if (copy_from_user(&u_cmd, arg, sizeof(u_cmd)))
@@ -299,10 +329,17 @@ static long cros_ec_chardev_ioctl_xcmd(struct chardev_priv *priv, void __user *a
 	}
 
 	s_cmd->command += priv->cmd_offset;
-	ret = cros_ec_cmd_xfer(priv->ec_dev, s_cmd);
-	/* Only copy data to userland if data was received. */
-	if (ret < 0)
-		goto exit;
+	REVOCABLE_TRY_ACCESS_SCOPED(priv->ec_dev_rev, ec_dev) {
+		if (!ec_dev) {
+			ret = -ENODEV;
+			goto exit;
+		}
+
+		ret = cros_ec_cmd_xfer(ec_dev, s_cmd);
+		/* Only copy data to userland if data was received. */
+		if (ret < 0)
+			goto exit;
+	}
 
 	if (copy_to_user(arg, s_cmd, sizeof(*s_cmd) + s_cmd->insize))
 		ret = -EFAULT;
@@ -313,10 +350,14 @@ static long cros_ec_chardev_ioctl_xcmd(struct chardev_priv *priv, void __user *a
 
 static long cros_ec_chardev_ioctl_readmem(struct chardev_priv *priv, void __user *arg)
 {
-	struct cros_ec_device *ec_dev = priv->ec_dev;
+	struct cros_ec_device *ec_dev;
 	struct cros_ec_readmem s_mem = { };
 	long num;
 
+	REVOCABLE_TRY_ACCESS_WITH(priv->ec_dev_rev, ec_dev);
+	if (!ec_dev)
+		return -ENODEV;
+
 	/* Not every platform supports direct reads */
 	if (!ec_dev->cmd_readmem)
 		return -ENOTTY;
-- 
2.48.1


