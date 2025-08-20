Return-Path: <linux-kselftest+bounces-39357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B7B2D61B
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 10:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387074E214D
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 08:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FB92DA77D;
	Wed, 20 Aug 2025 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfJcplxp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A762DA776;
	Wed, 20 Aug 2025 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677855; cv=none; b=DmM2n5wKSRUkwabEgdzAkaeB47wa6uPzK9+mrL7Yml0cqdWQo6f1lgdC8vW129xOvH1xJiW40cIoL34EBAD1VYgcbHsGfm15JzdFLeRF5GuAydgBYTd5CN0h6baitCMEXp8abVG8dkU+vPo1uEfOG3/M7yCzTinZzIeoxJAwEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677855; c=relaxed/simple;
	bh=JMpIgp8YIbrOSw336Fx7Pf1imqt/c5Pc3wWDqKBle34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtjREno3QO1WeA6yBZa4/H407KS+H91hApde1scI97FtWYTT6kdAIORqrYE6k0ZgrjXZCbTVXLsK6U1Y/RpEEj6jPFgxBKBnnlyPBuwCzXopWjha4/zPBn0gySARFAy9CWejHlI/eBmnY13wwzcn5igiJkcRJCUpYANqsQcZWgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfJcplxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CC9C4CEEB;
	Wed, 20 Aug 2025 08:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755677855;
	bh=JMpIgp8YIbrOSw336Fx7Pf1imqt/c5Pc3wWDqKBle34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UfJcplxpUPDflKOZsWezZeWsG7SqcXhO2qVLnFE1MpovVnbQbdfJIGhqjlB50Zz2V
	 QBPHPE+OooMGlt/sXhN96M57wAN9SlYuJ1S5hFfdq1Y3zbOr+C7yaLlXaL2tZU6U6l
	 M+XMzFcZLGGcger62L/+Fg59ZZRIR2fJiIkxcMfnTXbi5nZi8KaO++AbfNQIXEkE2s
	 hM58INCxce4hJ3xqEOIkpshELZ99An5WP/ux6h+5lIujvnWXDcHM49bEDw4yEY8aFn
	 EdT5rPnT5mVtdP6zcPB3sb2MmwjznUvZqdM+EN+RLmHZqzuum3cHmJSGvAtdRlAW2I
	 chtYEt1F6zOzQ==
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
Subject: [PATCH v2 5/5] platform/chrome: cros_ec_chardev: Consume cros_ec_device via revocable
Date: Wed, 20 Aug 2025 08:16:45 +0000
Message-ID: <20250820081645.847919-6-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
In-Reply-To: <20250820081645.847919-1-tzungbi@kernel.org>
References: <20250820081645.847919-1-tzungbi@kernel.org>
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
v2:
- Rename "ref_proxy" -> "revocable".
- Fix a sparse warning by removing the redundant __rcu annotation.

v1: https://lore.kernel.org/chrome-platform/20250814091020.1302888-4-tzungbi@kernel.org

 drivers/platform/chrome/cros_ec_chardev.c | 124 +++++++++++++++-------
 1 file changed, 84 insertions(+), 40 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index c9d80ad5b57e..d41c7f574cf1 100644
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
+		goto err;
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
+		goto err;
 	}
 
+	return 0;
+err:
+	if (priv->ec_dev_rev)
+		revocable_free(priv->ec_dev_rev);
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
2.51.0.rc1.167.g924127e9c0-goog


