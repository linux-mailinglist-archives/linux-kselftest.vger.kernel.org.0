Return-Path: <linux-kselftest+bounces-39946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DA3B35F4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 14:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF12684A8E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13043343215;
	Tue, 26 Aug 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvoJeHgY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835E3431FE;
	Tue, 26 Aug 2025 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212001; cv=none; b=XVAMs4/gpN7/B8hh3gjIsU04+5tcDZsjD7wkumYk8cAppFTCysZ922DJONkl1sJxGdGqAb/1ZC0k3cwtWe+tPEyYlOfBkXnctxc5LtzyQbtle15n0VM9ehQpjIqykxEdop1dOS9+iPhc96YSY/ym7zsgLjAye4TEQuszNTh+WOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212001; c=relaxed/simple;
	bh=LjmB04QPgjrYgaIwBfEs0zviXWneUfF/3NzneUzlG0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BuhKvbifgosTHSD/DiibMhBG/sh72JbgRHZOwVPPGN3yWE7INP92a8tYItUBV409hSf5pBh4nDpi0+HEfU5ehNlw/pZ9EG3fBi7BpTFZqjgGmD1vsrBBzOvfUDiZmxmOYxho5O6PH+JQ2xhK7zSZuDx8f7+Oq5O/qOk9rC5YusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvoJeHgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBC5C19424;
	Tue, 26 Aug 2025 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756212000;
	bh=LjmB04QPgjrYgaIwBfEs0zviXWneUfF/3NzneUzlG0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZvoJeHgYirAothpZ1fo8dpGbuZ1gXoSqup1ue2GphXnmbcwU0BEB+w7JCcjPMlMZO
	 oX2Jhpy9viJU9FDMbIMh2EVNRfJ8PyPB/m3r/n+kFrhKiK415y5QW3YHxSEtclIUDg
	 LaTDgC0U1kW/MzKFNvuqrZeuwPNcuoGeolVKUkd4/vpPy+grcSQh3dO5UFbHt69Nf/
	 r6OKViMBTlttUipH7DvZyGy5mPjUl3Bdf/cckaCAeExA0bPr/c/zV8T/U4bNYQ6/9S
	 Lkn3Rsyvxvf8wK3oTq05MOu3TqQJcvjkW3pf0dwSWdW8KIKOdzpknl01F/kFg/NERq
	 NVeW1exRxPCQQ==
From: bentiss@kernel.org
Date: Tue, 26 Aug 2025 14:39:41 +0200
Subject: [PATCH v2 3/3] HID: tighten ioctl command parsing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250826-b4-hidraw-ioctls-v2-3-c7726b236719@kernel.org>
References: <20250826-b4-hidraw-ioctls-v2-0-c7726b236719@kernel.org>
In-Reply-To: <20250826-b4-hidraw-ioctls-v2-0-c7726b236719@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756211993; l=9012;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=KZHaOS6e7iHYeZyNxItBcY9Qs+NZLFJ6hQpelRnM5kk=;
 b=i380UFR0uXVHXY2lFZNgDq58bgE+nWEzzbVgLo679JKVUyFr402smHWrAgBHwbtLG8yYbE/4e
 PTec60LEg/hDufvUUgcXfJYNvN7fl61CAlqM8jYjvt/uIwWzznmUkV9
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

From: Arnd Bergmann <arnd@arndb.de>

The handling for variable-length ioctl commands in hidraw_ioctl() is
rather complex and the check for the data direction is incomplete.

Simplify this code by factoring out the various ioctls grouped by dir
and size, and using a switch() statement with the size masked out, to
ensure the rest of the command is correctly matched.

Fixes: 9188e79ec3fd ("HID: add phys and name ioctls to hidraw")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hidraw.c        | 224 ++++++++++++++++++++++++--------------------
 include/uapi/linux/hidraw.h |   2 +
 2 files changed, 124 insertions(+), 102 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index c887f48756f4be2a4bac03128f2885bde96c1e39..bbd6f23bce78951c7d667ff5c1c923cee3509e3f 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -394,27 +394,15 @@ static int hidraw_revoke(struct hidraw_list *list)
 	return 0;
 }
 
-static long hidraw_ioctl(struct file *file, unsigned int cmd,
-							unsigned long arg)
+static long hidraw_fixed_size_ioctl(struct file *file, struct hidraw *dev, unsigned int cmd,
+				    void __user *arg)
 {
-	struct inode *inode = file_inode(file);
-	unsigned int minor = iminor(inode);
-	long ret = 0;
-	struct hidraw *dev;
-	struct hidraw_list *list = file->private_data;
-	void __user *user_arg = (void __user*) arg;
-
-	down_read(&minors_rwsem);
-	dev = hidraw_table[minor];
-	if (!dev || !dev->exist || hidraw_is_revoked(list)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	struct hid_device *hid = dev->hid;
 
 	switch (cmd) {
 		case HIDIOCGRDESCSIZE:
-			if (put_user(dev->hid->rsize, (int __user *)arg))
-				ret = -EFAULT;
+			if (put_user(hid->rsize, (int __user *)arg))
+				return -EFAULT;
 			break;
 
 		case HIDIOCGRDESC:
@@ -422,113 +410,145 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 				__u32 len;
 
 				if (get_user(len, (int __user *)arg))
-					ret = -EFAULT;
-				else if (len > HID_MAX_DESCRIPTOR_SIZE - 1)
-					ret = -EINVAL;
-				else if (copy_to_user(user_arg + offsetof(
-					struct hidraw_report_descriptor,
-					value[0]),
-					dev->hid->rdesc,
-					min(dev->hid->rsize, len)))
-					ret = -EFAULT;
+					return -EFAULT;
+
+				if (len > HID_MAX_DESCRIPTOR_SIZE - 1)
+					return -EINVAL;
+
+				if (copy_to_user(arg + offsetof(
+				    struct hidraw_report_descriptor,
+				    value[0]),
+				    hid->rdesc,
+				    min(hid->rsize, len)))
+					return -EFAULT;
+
 				break;
 			}
 		case HIDIOCGRAWINFO:
 			{
 				struct hidraw_devinfo dinfo;
 
-				dinfo.bustype = dev->hid->bus;
-				dinfo.vendor = dev->hid->vendor;
-				dinfo.product = dev->hid->product;
-				if (copy_to_user(user_arg, &dinfo, sizeof(dinfo)))
-					ret = -EFAULT;
+				dinfo.bustype = hid->bus;
+				dinfo.vendor = hid->vendor;
+				dinfo.product = hid->product;
+				if (copy_to_user(arg, &dinfo, sizeof(dinfo)))
+					return -EFAULT;
 				break;
 			}
 		case HIDIOCREVOKE:
 			{
-				if (user_arg)
-					ret = -EINVAL;
-				else
-					ret = hidraw_revoke(list);
-				break;
+				struct hidraw_list *list = file->private_data;
+
+				if (arg)
+					return -EINVAL;
+
+				return hidraw_revoke(list);
 			}
 		default:
-			{
-				struct hid_device *hid = dev->hid;
-				if (_IOC_TYPE(cmd) != 'H') {
-					ret = -EINVAL;
-					break;
-				}
+			/*
+			 * None of the above ioctls can return -EAGAIN, so
+			 * use it as a marker that we need to check variable
+			 * length ioctls.
+			 */
+			return -EAGAIN;
+	}
 
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCSFEATURE(0))) {
-					int len = _IOC_SIZE(cmd);
-					ret = hidraw_send_report(file, user_arg, len, HID_FEATURE_REPORT);
-					break;
-				}
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGFEATURE(0))) {
-					int len = _IOC_SIZE(cmd);
-					ret = hidraw_get_report(file, user_arg, len, HID_FEATURE_REPORT);
-					break;
-				}
+	return 0;
+}
 
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCSINPUT(0))) {
-					int len = _IOC_SIZE(cmd);
-					ret = hidraw_send_report(file, user_arg, len, HID_INPUT_REPORT);
-					break;
-				}
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGINPUT(0))) {
-					int len = _IOC_SIZE(cmd);
-					ret = hidraw_get_report(file, user_arg, len, HID_INPUT_REPORT);
-					break;
-				}
+static long hidraw_rw_variable_size_ioctl(struct file *file, struct hidraw *dev, unsigned int cmd,
+					  void __user *user_arg)
+{
+	int len = _IOC_SIZE(cmd);
+
+	switch (cmd & ~IOCSIZE_MASK) {
+	case HIDIOCSFEATURE(0):
+		return hidraw_send_report(file, user_arg, len, HID_FEATURE_REPORT);
+	case HIDIOCGFEATURE(0):
+		return hidraw_get_report(file, user_arg, len, HID_FEATURE_REPORT);
+	case HIDIOCSINPUT(0):
+		return hidraw_send_report(file, user_arg, len, HID_INPUT_REPORT);
+	case HIDIOCGINPUT(0):
+		return hidraw_get_report(file, user_arg, len, HID_INPUT_REPORT);
+	case HIDIOCSOUTPUT(0):
+		return hidraw_send_report(file, user_arg, len, HID_OUTPUT_REPORT);
+	case HIDIOCGOUTPUT(0):
+		return hidraw_get_report(file, user_arg, len, HID_OUTPUT_REPORT);
+	}
 
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCSOUTPUT(0))) {
-					int len = _IOC_SIZE(cmd);
-					ret = hidraw_send_report(file, user_arg, len, HID_OUTPUT_REPORT);
-					break;
-				}
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGOUTPUT(0))) {
-					int len = _IOC_SIZE(cmd);
-					ret = hidraw_get_report(file, user_arg, len, HID_OUTPUT_REPORT);
-					break;
-				}
+	return -EINVAL;
+}
 
-				/* Begin Read-only ioctls. */
-				if (_IOC_DIR(cmd) != _IOC_READ) {
-					ret = -EINVAL;
-					break;
-				}
+static long hidraw_ro_variable_size_ioctl(struct file *file, struct hidraw *dev, unsigned int cmd,
+					  void __user *user_arg)
+{
+	struct hid_device *hid = dev->hid;
+	int len = _IOC_SIZE(cmd);
+	int field_len;
+
+	switch (cmd & ~IOCSIZE_MASK) {
+	case HIDIOCGRAWNAME(0):
+		field_len = strlen(hid->name) + 1;
+		if (len > field_len)
+			len = field_len;
+		return copy_to_user(user_arg, hid->name, len) ?  -EFAULT : len;
+	case HIDIOCGRAWPHYS(0):
+		field_len = strlen(hid->phys) + 1;
+		if (len > field_len)
+			len = field_len;
+		return copy_to_user(user_arg, hid->phys, len) ?  -EFAULT : len;
+	case HIDIOCGRAWUNIQ(0):
+		field_len = strlen(hid->uniq) + 1;
+		if (len > field_len)
+			len = field_len;
+		return copy_to_user(user_arg, hid->uniq, len) ?  -EFAULT : len;
+	}
 
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWNAME(0))) {
-					int len = strlen(hid->name) + 1;
-					if (len > _IOC_SIZE(cmd))
-						len = _IOC_SIZE(cmd);
-					ret = copy_to_user(user_arg, hid->name, len) ?
-						-EFAULT : len;
-					break;
-				}
+	return -EINVAL;
+}
 
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWPHYS(0))) {
-					int len = strlen(hid->phys) + 1;
-					if (len > _IOC_SIZE(cmd))
-						len = _IOC_SIZE(cmd);
-					ret = copy_to_user(user_arg, hid->phys, len) ?
-						-EFAULT : len;
-					break;
-				}
+static long hidraw_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	unsigned int minor = iminor(inode);
+	struct hidraw *dev;
+	struct hidraw_list *list = file->private_data;
+	void __user *user_arg = (void __user *)arg;
+	int ret;
 
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWUNIQ(0))) {
-					int len = strlen(hid->uniq) + 1;
-					if (len > _IOC_SIZE(cmd))
-						len = _IOC_SIZE(cmd);
-					ret = copy_to_user(user_arg, hid->uniq, len) ?
-						-EFAULT : len;
-					break;
-				}
-			}
+	down_read(&minors_rwsem);
+	dev = hidraw_table[minor];
+	if (!dev || !dev->exist || hidraw_is_revoked(list)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (_IOC_TYPE(cmd) != 'H') {
+		ret = -EINVAL;
+		goto out;
+	}
 
+	if (_IOC_NR(cmd) > HIDIOCTL_LAST || _IOC_NR(cmd) == 0) {
 		ret = -ENOTTY;
+		goto out;
 	}
+
+	ret = hidraw_fixed_size_ioctl(file, dev, cmd, user_arg);
+	if (ret != -EAGAIN)
+		goto out;
+
+	switch (_IOC_DIR(cmd)) {
+	case (_IOC_READ | _IOC_WRITE):
+		ret = hidraw_rw_variable_size_ioctl(file, dev, cmd, user_arg);
+		break;
+	case _IOC_READ:
+		ret = hidraw_ro_variable_size_ioctl(file, dev, cmd, user_arg);
+		break;
+	default:
+		/* Any other IOC_DIR is wrong */
+		ret = -EINVAL;
+	}
+
 out:
 	up_read(&minors_rwsem);
 	return ret;
diff --git a/include/uapi/linux/hidraw.h b/include/uapi/linux/hidraw.h
index d5ee269864e07fcaba481fa285bacbd98739e44f..ebd701b3c18d9d7465880199091933f13f2e1128 100644
--- a/include/uapi/linux/hidraw.h
+++ b/include/uapi/linux/hidraw.h
@@ -48,6 +48,8 @@ struct hidraw_devinfo {
 #define HIDIOCGOUTPUT(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x0C, len)
 #define HIDIOCREVOKE	      _IOW('H', 0x0D, int) /* Revoke device access */
 
+#define HIDIOCTL_LAST		_IOC_NR(HIDIOCREVOKE)
+
 #define HIDRAW_FIRST_MINOR 0
 #define HIDRAW_MAX_DEVICES 64
 /* number of reports to buffer */

-- 
2.51.0


