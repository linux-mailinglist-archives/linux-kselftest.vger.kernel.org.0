Return-Path: <linux-kselftest+bounces-41286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F12B5450B
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 10:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0683BBA3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 08:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C09D2D8779;
	Fri, 12 Sep 2025 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSTprtzm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA692E401;
	Fri, 12 Sep 2025 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665107; cv=none; b=gpyy/4vHNFJtvuFOHeIab7CWZ/N3EJ0OxhNFucIHOlbYgNip1Nu6Lxunx+UMB6i3uSKE7/SPQFbvMjthuZyfTfGdySj/mdcX5wLcScMGt0A7RgCH6nVKa58SZIOMnjpf76Jwqd2Buaa2Qfq/jB2qtiT2IHKxWjetf58aemA5zSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665107; c=relaxed/simple;
	bh=LXH+SCB4NdyM2LOa87h4dCyYL3cFhysaqeVzB1y5l+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnqxfKTvQkR3U9Wx8P6dVnV1Dosf7Pnl+gnD2V5gDVfhzV4/mduVwd0FLhU7QAC4NjVqllf32si2/oZHU005k+lSTeNqVtuxh+IdDemD0aMPozBbZQbPnjqV66xgeRuEpkyMuh4tvP1xQ+clcNDy3LIM9fl2rMpeylIy/qrhw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSTprtzm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C2AC4CEF9;
	Fri, 12 Sep 2025 08:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757665107;
	bh=LXH+SCB4NdyM2LOa87h4dCyYL3cFhysaqeVzB1y5l+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSTprtzm9jmMz9S4lfLL6xX6qV67wiq97cKlAQXFBFgYj3WK81nPaMlSOvArGNwNF
	 ZFnWgYO/S/qPW/1/YBPYaHNUqMcApzvH1gEoiLAHnLXmaytxu1mHZw0TgILejyGVTh
	 4oTes070KhUNWS83gT5CtfRsc/WzQTlobmSGl9f6t1vAZx3rmQQcRH+NPHtScdi9F5
	 3+I3RRWLtOiVp+MXb0C96OLsvli6dPe47FGz75fUCjMj2CVxHbXXoD3qlU4HNUcNwa
	 nWMckyJ8qDT1WJEscZrfeZ2pwb75Qm2nCXaTKz+2TsPVCiQy2h2GVkJazfA/BL3fwM
	 uTqpqzzs9+G+w==
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
	tzungbi@kernel.org
Subject: [PATCH v3 5/5] platform/chrome: cros_ec_chardev: Consume cros_ec_device via revocable
Date: Fri, 12 Sep 2025 08:17:17 +0000
Message-ID: <20250912081718.3827390-6-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912081718.3827390-1-tzungbi@kernel.org>
References: <20250912081718.3827390-1-tzungbi@kernel.org>
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
v3:
- Use specific labels for different cleanup in cros_ec_chardev_open().

v2: https://lore.kernel.org/chrome-platform/20250820081645.847919-6-tzungbi@kernel.org
- Rename "ref_proxy" -> "revocable".
- Fix a sparse warning by removing the redundant __rcu annotation.

v1: https://lore.kernel.org/chrome-platform/20250814091020.1302888-4-tzungbi@kernel.org

 drivers/platform/chrome/cros_ec_chardev.c | 124 +++++++++++++++-------
 1 file changed, 84 insertions(+), 40 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index c9d80ad5b57e..2677b756e31c 100644
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
@@ -64,12 +66,19 @@ static int ec_get_version(struct chardev_priv *priv, char *str, int maxlen)
 	msg->command = EC_CMD_GET_VERSION + priv->cmd_offset;
 	msg->insize = sizeof(*resp);
 
-	ret = cros_ec_cmd_xfer_status(priv->ec_dev, msg);
-	if (ret < 0) {
-		snprintf(str, maxlen,
-			 "Unknown EC version, returned error: %d\n",
-			 msg->result);
-		goto exit;
+	REVOCABLE(priv->ec_dev_rev, ec_dev) {
+		if (!ec_dev) {
+			ret = -ENODEV;
+			goto exit;
+		}
+
+		ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+		if (ret < 0) {
+			snprintf(str, maxlen,
+				 "Unknown EC version, returned error: %d\n",
+				 msg->result);
+			goto exit;
+		}
 	}
 
 	resp = (struct ec_response_get_version *)msg->data;
@@ -92,22 +101,30 @@ static int cros_ec_chardev_mkbp_event(struct notifier_block *nb,
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
+	REVOCABLE(priv->ec_dev_rev, ec_dev) {
+		if (!ec_dev)
+			return NOTIFY_DONE;
+
+		event_bit = 1 << ec_dev->event_data.event_type;
+		total_size = sizeof(*event) + ec_dev->event_size;
 
-	if (!(event_bit & priv->event_mask) ||
-	    (priv->event_len + total_size) > CROS_MAX_EVENT_LEN)
-		return NOTIFY_DONE;
+		if (!(event_bit & priv->event_mask) ||
+		    (priv->event_len + total_size) > CROS_MAX_EVENT_LEN)
+			return NOTIFY_DONE;
 
-	event = kzalloc(total_size, GFP_KERNEL);
-	if (!event)
-		return NOTIFY_DONE;
+		event = kzalloc(total_size, GFP_KERNEL);
+		if (!event)
+			return NOTIFY_DONE;
 
-	event->size = ec_dev->event_size;
-	event->event_type = ec_dev->event_data.event_type;
-	memcpy(event->data, &ec_dev->event_data.data, ec_dev->event_size);
+		event->size = ec_dev->event_size;
+		event->event_type = ec_dev->event_data.event_type;
+		memcpy(event->data, &ec_dev->event_data.data, ec_dev->event_size);
+	}
 
 	spin_lock(&priv->wait_event.lock);
 	list_add_tail(&event->node, &priv->events);
@@ -166,7 +183,12 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
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
@@ -178,9 +200,14 @@ static int cros_ec_chardev_open(struct inode *inode, struct file *filp)
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
 
@@ -251,11 +278,15 @@ static ssize_t cros_ec_chardev_read(struct file *filp, char __user *buffer,
 static int cros_ec_chardev_release(struct inode *inode, struct file *filp)
 {
 	struct chardev_priv *priv = filp->private_data;
-	struct cros_ec_device *ec_dev = priv->ec_dev;
+	struct cros_ec_device *ec_dev;
 	struct ec_event *event, *e;
 
-	blocking_notifier_chain_unregister(&ec_dev->event_notifier,
-					   &priv->notifier);
+	REVOCABLE(priv->ec_dev_rev, ec_dev) {
+		if (ec_dev)
+			blocking_notifier_chain_unregister(&ec_dev->event_notifier,
+							   &priv->notifier);
+	}
+	revocable_free(priv->ec_dev_rev);
 
 	list_for_each_entry_safe(event, e, &priv->events, node) {
 		list_del(&event->node);
@@ -273,6 +304,7 @@ static long cros_ec_chardev_ioctl_xcmd(struct chardev_priv *priv, void __user *a
 {
 	struct cros_ec_command *s_cmd;
 	struct cros_ec_command u_cmd;
+	struct cros_ec_device *ec_dev;
 	long ret;
 
 	if (copy_from_user(&u_cmd, arg, sizeof(u_cmd)))
@@ -299,10 +331,17 @@ static long cros_ec_chardev_ioctl_xcmd(struct chardev_priv *priv, void __user *a
 	}
 
 	s_cmd->command += priv->cmd_offset;
-	ret = cros_ec_cmd_xfer(priv->ec_dev, s_cmd);
-	/* Only copy data to userland if data was received. */
-	if (ret < 0)
-		goto exit;
+	REVOCABLE(priv->ec_dev_rev, ec_dev) {
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
@@ -313,24 +352,29 @@ static long cros_ec_chardev_ioctl_xcmd(struct chardev_priv *priv, void __user *a
 
 static long cros_ec_chardev_ioctl_readmem(struct chardev_priv *priv, void __user *arg)
 {
-	struct cros_ec_device *ec_dev = priv->ec_dev;
+	struct cros_ec_device *ec_dev;
 	struct cros_ec_readmem s_mem = { };
 	long num;
 
-	/* Not every platform supports direct reads */
-	if (!ec_dev->cmd_readmem)
-		return -ENOTTY;
+	REVOCABLE(priv->ec_dev_rev, ec_dev) {
+		if (!ec_dev)
+			return -ENODEV;
 
-	if (copy_from_user(&s_mem, arg, sizeof(s_mem)))
-		return -EFAULT;
+		/* Not every platform supports direct reads */
+		if (!ec_dev->cmd_readmem)
+			return -ENOTTY;
 
-	if (s_mem.bytes > sizeof(s_mem.buffer))
-		return -EINVAL;
+		if (copy_from_user(&s_mem, arg, sizeof(s_mem)))
+			return -EFAULT;
 
-	num = ec_dev->cmd_readmem(ec_dev, s_mem.offset, s_mem.bytes,
-				  s_mem.buffer);
-	if (num <= 0)
-		return num;
+		if (s_mem.bytes > sizeof(s_mem.buffer))
+			return -EINVAL;
+
+		num = ec_dev->cmd_readmem(ec_dev, s_mem.offset, s_mem.bytes,
+					  s_mem.buffer);
+		if (num <= 0)
+			return num;
+	}
 
 	if (copy_to_user((void __user *)arg, &s_mem, sizeof(s_mem)))
 		return -EFAULT;
-- 
2.51.0.384.g4c02a37b29-goog


