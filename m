Return-Path: <linux-kselftest+bounces-16290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0423595F579
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 17:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85CA71F2232B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 15:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C269D1946A8;
	Mon, 26 Aug 2024 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdKGW/17"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB319413C;
	Mon, 26 Aug 2024 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724687290; cv=none; b=uttdxsjQ6apWfn4xC2W8Q6RQ6TKBlJTcwKIi1ks5rC3awT1Ge0wX0pgKQxuwXi9oNjfi3ui9ybk6lja5435k8AsPp948WXmTHqyu/OlbOA3i1GUGR/79VkJvUqHmd+QWSMXpd7b399I2vymTJgpmkhAcL4Nx4siLPSxgePfucK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724687290; c=relaxed/simple;
	bh=iZtHxr1WnOWyNhEFKU4cqBivzhqrUHFlW667gxNouVQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LOpXrw7AnLy3oHqCGQWDkfxpZ5RMJ32PhmYs7mUHPX2fdVEB/vVD2S/yEEN1YdA0O+ksTs3EqEH9Z0m8HqGUryBdndfNGGlOIrzGqTAq/msbkFBgskuj4iFZNUY3lKUqHOhgu8TtQj86+uVuIGVr/Blyk47xMHSjN5HVySuG18w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdKGW/17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E5FC4DDFA;
	Mon, 26 Aug 2024 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724687290;
	bh=iZtHxr1WnOWyNhEFKU4cqBivzhqrUHFlW667gxNouVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fdKGW/17gRxd6YSwcwlYMifez7QDlpd932Zkq1oU2fEhRJvxonuLyl6hTbdQcQoxM
	 tAy7M9GnIVie2W9m+A0HEGxpAA0bQT+mRWWbP9eiEAyuH5OhRCHQh5Z6OUbnM6GjzY
	 svjdV1F+DIOzJ6e0pU6ChD1YbfKC6x9C5xwL6BXSrY98DjD40Y2oZLBbr/QxeJYQOP
	 0KK9MaTPnxlSzZMVw/iRUrT6kN2suOVU72p9o5fSk/XLTYEszWixdtMBvArtW4O3tU
	 O6hu1kYZ2v+FOrBLNVOV56ho11sMojLisnn3GuKCoB6sN/FBzK1BP4X0BayCg+Ecq2
	 xNnJd3nUQi/6A==
From: bentiss@kernel.org
Date: Tue, 27 Aug 2024 00:47:51 +0900
Subject: [PATCH v4 1/3] HID: hidraw: add HIDIOCREVOKE ioctl
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-hidraw-revoke-v4-1-88c6795bf867@kernel.org>
References: <20240827-hidraw-revoke-v4-0-88c6795bf867@kernel.org>
In-Reply-To: <20240827-hidraw-revoke-v4-0-88c6795bf867@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724687286; l=5969;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=RLM4AWuodTCoo87UHgn6rO5j8XYNQ3myQZuV/MXya34=;
 b=3qrw0P9PzCrBZwlnrph7NkvpfwYJBMDNR9reduDTIS7tPA2hAvcEbCpcJ90DEJW4xMB6ZlV5k
 KYQeFYz1n2+A8iBP9B3g9hc8yleb4xGyMDUKACvCIURDtRfdsVIbDRd
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

From: Peter Hutterer <peter.hutterer@who-t.net>

There is a need for userspace applications to open HID devices directly.
Use-cases include configuration of gaming mice or direct access to
joystick devices. The latter is currently handled by the uaccess tag in
systemd, other devices include more custom/local configurations or just
sudo.

A better approach is what we already have for evdev devices: give the
application a file descriptor and revoke it when it may no longer access
that device.

This patch is the hidraw equivalent to the EVIOCREVOKE ioctl, see
commit c7dc65737c9a ("Input: evdev - add EVIOCREVOKE ioctl") for full
details.

An MR for systemd-logind has been filed here:
https://github.com/systemd/systemd/pull/33970

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

---

First version of the patch:
https://patchwork.kernel.org/project/linux-input/patch/YmEAPZKDisM2HAsG@quokka/

Changes to v1:
- add the hidraw_is_revoked and hidraw_open_errno weak functions as
  suggested by Benjamin

Changes to v2:
- use __bpf_hook_start/end to silence compiler warnings  (see kernel
  test bot)

Changes to v3 (bentiss):
- drop the BPF related changes, the API is not clear ATM, and it's wrong
  in v2, as ERROR_INJECTION should not be used for normal fmodret.
- drop hidraw_open_errno() new function. The API seems interesting, but
  nothing is really ready, so let's not add a useless API for nothing.
---
 drivers/hid/hidraw.c        | 39 +++++++++++++++++++++++++++++++++++----
 include/linux/hidraw.h      |  1 +
 include/uapi/linux/hidraw.h |  1 +
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 716294e40e8a..c887f48756f4 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -38,12 +38,20 @@ static const struct class hidraw_class = {
 static struct hidraw *hidraw_table[HIDRAW_MAX_DEVICES];
 static DECLARE_RWSEM(minors_rwsem);
 
+static inline bool hidraw_is_revoked(struct hidraw_list *list)
+{
+	return list->revoked;
+}
+
 static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
 	struct hidraw_list *list = file->private_data;
 	int ret = 0, len;
 	DECLARE_WAITQUEUE(wait, current);
 
+	if (hidraw_is_revoked(list))
+		return -ENODEV;
+
 	mutex_lock(&list->read_mutex);
 
 	while (ret == 0) {
@@ -161,9 +169,13 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 
 static ssize_t hidraw_write(struct file *file, const char __user *buffer, size_t count, loff_t *ppos)
 {
+	struct hidraw_list *list = file->private_data;
 	ssize_t ret;
 	down_read(&minors_rwsem);
-	ret = hidraw_send_report(file, buffer, count, HID_OUTPUT_REPORT);
+	if (hidraw_is_revoked(list))
+		ret = -ENODEV;
+	else
+		ret = hidraw_send_report(file, buffer, count, HID_OUTPUT_REPORT);
 	up_read(&minors_rwsem);
 	return ret;
 }
@@ -256,7 +268,7 @@ static __poll_t hidraw_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &list->hidraw->wait, wait);
 	if (list->head != list->tail)
 		mask |= EPOLLIN | EPOLLRDNORM;
-	if (!list->hidraw->exist)
+	if (!list->hidraw->exist || hidraw_is_revoked(list))
 		mask |= EPOLLERR | EPOLLHUP;
 	return mask;
 }
@@ -320,6 +332,9 @@ static int hidraw_fasync(int fd, struct file *file, int on)
 {
 	struct hidraw_list *list = file->private_data;
 
+	if (hidraw_is_revoked(list))
+		return -ENODEV;
+
 	return fasync_helper(fd, file, on, &list->fasync);
 }
 
@@ -372,6 +387,13 @@ static int hidraw_release(struct inode * inode, struct file * file)
 	return 0;
 }
 
+static int hidraw_revoke(struct hidraw_list *list)
+{
+	list->revoked = true;
+
+	return 0;
+}
+
 static long hidraw_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
@@ -379,11 +401,12 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 	unsigned int minor = iminor(inode);
 	long ret = 0;
 	struct hidraw *dev;
+	struct hidraw_list *list = file->private_data;
 	void __user *user_arg = (void __user*) arg;
 
 	down_read(&minors_rwsem);
 	dev = hidraw_table[minor];
-	if (!dev || !dev->exist) {
+	if (!dev || !dev->exist || hidraw_is_revoked(list)) {
 		ret = -ENODEV;
 		goto out;
 	}
@@ -421,6 +444,14 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 					ret = -EFAULT;
 				break;
 			}
+		case HIDIOCREVOKE:
+			{
+				if (user_arg)
+					ret = -EINVAL;
+				else
+					ret = hidraw_revoke(list);
+				break;
+			}
 		default:
 			{
 				struct hid_device *hid = dev->hid;
@@ -527,7 +558,7 @@ int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
 	list_for_each_entry(list, &dev->list, node) {
 		int new_head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
 
-		if (new_head == list->tail)
+		if (hidraw_is_revoked(list) || new_head == list->tail)
 			continue;
 
 		if (!(list->buffer[list->head].value = kmemdup(data, len, GFP_ATOMIC))) {
diff --git a/include/linux/hidraw.h b/include/linux/hidraw.h
index cd67f4ca5599..18fd30a288de 100644
--- a/include/linux/hidraw.h
+++ b/include/linux/hidraw.h
@@ -32,6 +32,7 @@ struct hidraw_list {
 	struct hidraw *hidraw;
 	struct list_head node;
 	struct mutex read_mutex;
+	bool revoked;
 };
 
 #ifdef CONFIG_HIDRAW
diff --git a/include/uapi/linux/hidraw.h b/include/uapi/linux/hidraw.h
index 33ebad81720a..d5ee269864e0 100644
--- a/include/uapi/linux/hidraw.h
+++ b/include/uapi/linux/hidraw.h
@@ -46,6 +46,7 @@ struct hidraw_devinfo {
 /* The first byte of SOUTPUT and GOUTPUT is the report number */
 #define HIDIOCSOUTPUT(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x0B, len)
 #define HIDIOCGOUTPUT(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x0C, len)
+#define HIDIOCREVOKE	      _IOW('H', 0x0D, int) /* Revoke device access */
 
 #define HIDRAW_FIRST_MINOR 0
 #define HIDRAW_MAX_DEVICES 64

-- 
2.46.0


