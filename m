Return-Path: <linux-kselftest+bounces-42135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C633B94DFF
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 09:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AA2482EC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074D31CA6D;
	Tue, 23 Sep 2025 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgJgXvfU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E731770E;
	Tue, 23 Sep 2025 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614050; cv=none; b=GDSPV3uJOUP+ZOIRY8RFXUpfv/pujZECff5oCKl16xJUE14H0qU7NTUxL5gAB8hVtbwlnIUachfHOWzlyPYt9Q+BLeW1zfnr0rF62wHeTobV81gigtmQrhSg5jFzI0LoqoYZ7+UYSdthZwVWLMEqUauw1qsN7eJT0k70JiEkJYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614050; c=relaxed/simple;
	bh=ZiFeRg/lVoIv7bC36de1Tj3qgijxbQzaAqA+sbdWAaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHA24tCDJNM08AMTkUn/3r2jumplh+jQIEjN5SD2EIxwMMUogjcB1rlbNy/Dc1frbAIhQFR8VA/NdAA+wkv0PJUOeAtlnw8JqMvu0WiHo8ZOrQknGsemHKk861nwAy65hm7OdbjUFWgypBpHpagK95z0fXYV8pEPtX8xNc1baPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgJgXvfU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11BFC4CEF5;
	Tue, 23 Sep 2025 07:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758614050;
	bh=ZiFeRg/lVoIv7bC36de1Tj3qgijxbQzaAqA+sbdWAaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PgJgXvfUrYyP/xfUiYnS700alLKFz/575rNFxcJjseUOyj8pGVeavxjEdSC2raiDs
	 w1jU7QSEM8sNBnJfp2jEv1bxXqHIWrvN+17aEmfc6Sfhr9RtMli4+uBz/SB2U9KiO3
	 NLBzmWK03uoaT/sBvXxkoMsF5lxXUAjDM8jBte7QzMzehVbecUSlcuWK4gQGSXsktG
	 xD0c3J57Of9Eozt8jt06Popc4KUUB6ovV5XLfFI1cw0FK6kCxggzNOALa0g/rOh6Vl
	 3lLGDDtBXXQXBT7DKSff0iNVVi3meMGKdxys85AWs2TBUiyb1+5xkMZ7B/VjDbkDuK
	 MNxrcMUpVrB8Q==
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
Subject: [PATCH v4 5/7] revocable: Add fops replacement
Date: Tue, 23 Sep 2025 07:53:00 +0000
Message-ID: <20250923075302.591026-6-tzungbi@kernel.org>
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

Introduce revocable_replace_fops() to simplify the use of the revocable
API with file_operations.

The function, should be called from a driver's ->open(), replaces the
fops with a wrapper that automatically handles the `try_access` and
`withdraw_access`.

When the file is closed, the wrapper's ->release() restores the original
fops and cleanups.  This centralizes the revocable logic, making drivers
cleaner and easier to maintain.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
PoC patch.

Known issues:
- All file operations are serialized in a mutex unless we want to embed
  the required context to struct file.
- All file operations (for current version) call revocable_try_access()
  for guaranteeing the resource even if it may be unused in the fops.
- To support multiple revocable resources, extend to arrays.

v4:
- New in the series.

 drivers/base/revocable.c  | 141 ++++++++++++++++++++++++++++++++++++++
 include/linux/revocable.h |   7 ++
 2 files changed, 148 insertions(+)

diff --git a/drivers/base/revocable.c b/drivers/base/revocable.c
index f8dd4363a87b..ebb91231adf5 100644
--- a/drivers/base/revocable.c
+++ b/drivers/base/revocable.c
@@ -5,8 +5,10 @@
  * Revocable resource management
  */
 
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/kref.h>
+#include <linux/poll.h>
 #include <linux/revocable.h>
 #include <linux/slab.h>
 #include <linux/srcu.h>
@@ -231,3 +233,142 @@ void revocable_withdraw_access(struct revocable *rev) __releases(&rev->rp->srcu)
 	srcu_read_unlock(&rp->srcu, rev->idx);
 }
 EXPORT_SYMBOL_GPL(revocable_withdraw_access);
+
+struct fops_replacement {
+	struct file *filp;
+	const struct revocable_operations *rops;
+	const struct file_operations *orig_fops;
+	struct revocable *rev;
+	struct file_operations fops;
+	struct list_head list;
+};
+
+/*
+ * Use a list and linear search for PoC for now.  A hash table should be more
+ * practical.
+ */
+static LIST_HEAD(fops_replacement_list);
+static DEFINE_MUTEX(fops_replacement_mutex);
+
+/*
+ * Use `filp` as the search key.
+ */
+static struct fops_replacement *find_fops_replacement(struct file *filp)
+{
+	struct fops_replacement *fr;
+
+	guard(mutex)(&fops_replacement_mutex);
+	list_for_each_entry(fr, &fops_replacement_list, list) {
+		if (fr->filp == filp)
+			return fr;
+	}
+
+	return NULL;
+}
+
+#define GET_FOPS_REPLACEMENT(filp) ({					\
+	struct fops_replacement *_fr;					\
+	int _ret;							\
+									\
+	_fr = find_fops_replacement(filp);				\
+	if (!_fr)							\
+		return -ENODEV;						\
+									\
+	_ret = _fr->rops->try_access(_fr->rev, filp->private_data);	\
+	if (_ret)							\
+		return _ret;						\
+									\
+	_fr;								\
+})
+
+static void put_fops_replacement(struct fops_replacement *fr)
+{
+	revocable_withdraw_access(fr->rev);
+}
+
+DEFINE_FREE(fops_replacement, struct fops_replacement *, if (_T) put_fops_replacement(_T))
+
+static ssize_t revocable_fr_read(struct file *filp, char __user *buffer,
+				 size_t length, loff_t *offset)
+{
+	struct fops_replacement *fr __free(fops_replacement) =
+			GET_FOPS_REPLACEMENT(filp);
+	return fr->orig_fops->read(filp, buffer, length, offset);
+}
+
+static __poll_t revocable_fr_poll(struct file *filp, poll_table *wait)
+{
+	struct fops_replacement *fr __free(fops_replacement) =
+			GET_FOPS_REPLACEMENT(filp);
+	return fr->orig_fops->poll(filp, wait);
+}
+
+static long revocable_fr_unlocked_ioctl(struct file *filp, unsigned int cmd,
+					unsigned long arg)
+{
+	struct fops_replacement *fr __free(fops_replacement) =
+			GET_FOPS_REPLACEMENT(filp);
+	return fr->orig_fops->unlocked_ioctl(filp, cmd, arg);
+}
+
+static void revocable_recover_fops(struct file *filp,
+				   struct fops_replacement *fr)
+{
+	filp->f_op = fr->orig_fops;
+
+	revocable_free(fr->rev);
+	scoped_guard(mutex, &fops_replacement_mutex)
+		list_del(&fr->list);
+	kfree(fr);
+}
+
+static int revocable_fr_release(struct inode *inode, struct file *filp)
+{
+	int ret = 0;
+	struct fops_replacement *fr = GET_FOPS_REPLACEMENT(filp);
+
+	if (fr->orig_fops->release)
+		ret = fr->orig_fops->release(inode, filp);
+	put_fops_replacement(fr);
+
+	revocable_recover_fops(filp, fr);
+	return ret;
+}
+
+/**
+ * revocable_replace_fops() - Replace the file operations to be revocable-aware.
+ *
+ * Should be used only from ->open() instances.
+ */
+int revocable_replace_fops(struct file *filp, struct revocable_provider *rp,
+			   const struct revocable_operations *rops)
+{
+	struct fops_replacement *fr;
+
+	fr = kzalloc(sizeof(*fr), GFP_KERNEL);
+	if (!fr)
+		return -ENOMEM;
+
+	fr->filp = filp;
+	fr->rops = rops;
+	fr->orig_fops = filp->f_op;
+	fr->rev = revocable_alloc(rp);
+	if (!fr->rev)
+		return -ENOMEM;
+	memcpy(&fr->fops, filp->f_op, sizeof(struct file_operations));
+	scoped_guard(mutex, &fops_replacement_mutex)
+		list_add(&fr->list, &fops_replacement_list);
+
+	fr->fops.release = revocable_fr_release;
+
+	if (filp->f_op->read)
+		fr->fops.read = revocable_fr_read;
+	if (filp->f_op->poll)
+		fr->fops.poll = revocable_fr_poll;
+	if (filp->f_op->unlocked_ioctl)
+		fr->fops.unlocked_ioctl = revocable_fr_unlocked_ioctl;
+
+	filp->f_op = &fr->fops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(revocable_replace_fops);
diff --git a/include/linux/revocable.h b/include/linux/revocable.h
index 7177bf045d9c..9ad1d0198a1e 100644
--- a/include/linux/revocable.h
+++ b/include/linux/revocable.h
@@ -50,4 +50,11 @@ _label:										\
 #define REVOCABLE_TRY_ACCESS_WITH(_rev, _res)					\
 		_REVOCABLE_TRY_ACCESS_WITH(_rev, __UNIQUE_ID(label), _res)
 
+struct revocable_operations {
+	int (*try_access)(struct revocable *rev, void *data);
+};
+
+int revocable_replace_fops(struct file *filp, struct revocable_provider *rp,
+			   const struct revocable_operations *rops);
+
 #endif /* __LINUX_REVOCABLE_H */
-- 
2.51.0.534.gc79095c0ca-goog


