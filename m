Return-Path: <linux-kselftest+bounces-16377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ED2960437
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 10:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 654911F23770
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 08:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20938197A66;
	Tue, 27 Aug 2024 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmMzjxOR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73D919753F;
	Tue, 27 Aug 2024 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724746789; cv=none; b=C0+VO334+YE/pWUZsaZdzNbl2ggFtasB4XRXWRff2P1GHnU5tCaULU22kjbkhC/ZXQ0i40eCvOcUWEU9HWj2C/qNgKv50ty8Y+8I7OmTiu9VREepi/oZD4AfS9EF6LZS+lSNIHvcZO/EdHe0YflF2hnZqcEisCqtfgWTxsKO7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724746789; c=relaxed/simple;
	bh=6h4iXpQdb/9xGXnZ1+NPHenkSASJkmmzHyqR0jmKxfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=De9kkwciQPBDQm0J3Q1WtF035as841mLO2Mo9ebrIfo2e0x+4HhZdQjLdnKekQegqtnIL9wNbP4k8Sm+JAHV9kxchmR4gwEONLpU5i1UIvhTCEYsESDRIHRHwPZQ7pne9WE07nFe0GXpqQP0m+r14Qw2K+Sj8J/5gvREViBSVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmMzjxOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E21C5812B;
	Tue, 27 Aug 2024 08:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724746788;
	bh=6h4iXpQdb/9xGXnZ1+NPHenkSASJkmmzHyqR0jmKxfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kmMzjxORhHYYIwAcdTu7jJN5RRTtCpuPCHunTuwOisCD1BlvjfMqhA9e5/iP0XhRF
	 97dOnrk3moDkRCpZizP8oBlhUNiIbYpzzR3UYD/g8ixiaPdfLr7Yim+jaj76CCmowR
	 gjMNMxZkiM/nEyWRM4qrK7SgCJXgsX23RgoBEgYe17QAs22iMiSiCLV57JMeHspofk
	 /9gXwlty2SVXKEjBsDpqVysPih+b7BlKp6xjYAZn7CNYaRE3ZZr4j1GEmfyFNfBBwX
	 B2X4zHI4Rtz6g+zDJziE5iNPYITYWrstxBR+qwUrmKfW6hrT1D5W8qHxi0Pdjkz/Sf
	 JDoD/A+SUQ2Lw==
From: bentiss@kernel.org
Date: Tue, 27 Aug 2024 17:19:29 +0900
Subject: [PATCH v5 1/4] HID: hidraw: add HIDIOCREVOKE ioctl
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240827-hidraw-revoke-v5-1-d004a7451aea@kernel.org>
References: <20240827-hidraw-revoke-v5-0-d004a7451aea@kernel.org>
In-Reply-To: <20240827-hidraw-revoke-v5-0-d004a7451aea@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724746785; l=5993;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=ZvWYoKJHBWlvY55mfDuVglJ2CeO6TPIC/MH+FJqiE54=;
 b=5Lguoj1BIsObYCUlhYPs7Fexvtg0dyCreWz9sisQ/g/NFYSAXAUpAsyiWqsBcWreyOBiSY6wg
 juLurGZWdrrD8gI23bs+aIaqEkZm0AkfYwrKXwyu1PZzJEBtoTjekIt
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

Changes to v4:
none
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


