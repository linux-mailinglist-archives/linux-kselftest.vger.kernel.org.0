Return-Path: <linux-kselftest+bounces-32302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA94BAA89EC
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 00:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F483B6AF3
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 22:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A442248867;
	Sun,  4 May 2025 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JLI9qdMt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4487624BBF4
	for <linux-kselftest@vger.kernel.org>; Sun,  4 May 2025 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746398574; cv=none; b=AAJdVhkPCMRVXLTc45TFguwP2EKXJWj5l0AD4V+r9ajl62mJtxC4dc0zh6Q1G1nzzSqZKbnvq8Gpmz9UififkX/DpvTdjYcxKOmLZg16ttW8dnQhmov4+GsxhFQj96WhaKOnlAOM7+AOARoYXFsUFivz9gq54ZCZWs9hJpui2cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746398574; c=relaxed/simple;
	bh=xbjEgaYe0knSKWqvMyesgpOQp2v/9KVNJ09SSyfOPCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fn6PMhUmAxSVFPRSlNJARz0FIgNhTzZCm1nLJXqQpyBncrrvSGC60iV9dsJeHqOsg1tY6ngBXmxdmBJ323mak07/oXmiGH9i1k9J6REuiS1bWkEB4yiaykB5lChgAfU1DhWvlNQAmjkJi9HSNutrWiLMwAl1t7KsTHbvJk+1cP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JLI9qdMt; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af5156fbe79so4555537a12.1
        for <linux-kselftest@vger.kernel.org>; Sun, 04 May 2025 15:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746398571; x=1747003371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q5KpTdXI+QcIWJN1gYN37H9e/eysRgF4+FGk0oCPDY=;
        b=JLI9qdMtbxWi/tXdB/0jMvEGsXAiZEnsd6RUIFtUhP/8RYY9/Zz1iqGgRT0/Dvh+Fd
         xmn5WtEuxoHOAvoEADTznTBFAeXqdiSOXfQntwtlfSHojqQto+01/Bfq4nefytojU6Tn
         2Qb3l4YaHVRaw6TS5mDDJq8xMR7Xf+AYau+aE01L1n08uKl0aQ+cIr9BEBFeJkVaxWYT
         fENnT2pufdgqgVeTPsD8Ytl2H2mo/7n6TDj4Eh6Tb0VtEA1kbUHk5WOT7/GPYkpLjSBV
         splQkLxDrM/C39e8PQWDfegxBo2TdPi0NxwHkTr4CBFjsoK/S5MAB7JRaAZSd1UmGMk7
         ZEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746398571; x=1747003371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Q5KpTdXI+QcIWJN1gYN37H9e/eysRgF4+FGk0oCPDY=;
        b=o/gM85z2NPToQZBG6+6o1fElPbGV7vBztwUdgtSAi352jPUdb4jWAT2pghRtjXKiWz
         Vh3yMkEquCCaCYiEIUxoEAsY6m0Af7HLzVbBGmhqn3F4Im6Gp9FsnULRERkTuBHEMYt5
         oOuC4Jc3bZxE7nox6QeWkLLpLd+CfphEBeBEMhyh1tlTZUe9RqPbM0c98FLQ8DoA5Bxp
         KdChQD7JrExz4qLEnOoOM3N+IChPtyK6FtytzvC48A0c4DBwhOaxypDsbUVQ4zjXen4J
         MAg8IQQixix6rPFH/WgdTH8JKabPUKObaKF/Z0VD0bFUUt1cObfYRpDcUh7QfCveJepK
         tw6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2EcQlhtOiD97AVEz4Rfp29pWG0b0FeTU7ldi+2Iz8qTcHsFvbJUBFj6ClcQHXUekQ2AB2bvdrgWKcTPQhAe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0l9ctnW26id4iQHWhiuYQP7LO/ZGcGH80EW8Me5jmWo2v3+Ug
	SxYjgCIYae0rMtjD+4CTvA/5FhpOSuHzWlC4bJrc4wfscbuqXIfOW/eFJJ14obgyrBL0OKCVs+v
	R/VIWW3oeU1CIOg==
X-Google-Smtp-Source: AGHT+IHikmnfaHjMsH9xIJ86W1nJvjdXlDz4p94mIH61NtbN6AjKjbT6Vxufz9cEgsCz12wzM0YalIKynYHnj10=
X-Received: from pjbqn5.prod.google.com ([2002:a17:90b:3d45:b0:2fc:2b96:2d4b])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c4a:b0:305:2d27:7ca7 with SMTP id 98e67ed59e1d1-30a6199e001mr9009960a91.16.1746398571608;
 Sun, 04 May 2025 15:42:51 -0700 (PDT)
Date: Sun,  4 May 2025 22:41:42 +0000
In-Reply-To: <20250504224149.1033867-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250504224149.1033867-1-tjmercier@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250504224149.1033867-7-tjmercier@google.com>
Subject: [RFC PATCH v2 6/6] RFC: dma-buf: Remove DMA-BUF statistics
From: "T.J. Mercier" <tjmercier@google.com>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	skhan@linuxfoundation.org, song@kernel.org, alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-doc@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, android-mm@google.com, simona@ffwll.ch, 
	corbet@lwn.net, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	jolsa@kernel.org, mykolal@fb.com, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

I think Android is probably the only remaining user of the dmabuf sysfs
files. The BPF infrastructure added earlier in this series will allow us
to get the same information much more cheaply.

This patch is a RFC because I'd like to keep this for at least one more
longterm stable release (6.18?) before actually removing it so that we
can have one longterm stable kernel version that supports both options
to facilitate a transition from the sysfs files to a BPF program.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 .../ABI/testing/sysfs-kernel-dmabuf-buffers   |  24 ---
 Documentation/driver-api/dma-buf.rst          |   5 -
 drivers/dma-buf/Kconfig                       |  15 --
 drivers/dma-buf/Makefile                      |   1 -
 drivers/dma-buf/dma-buf-sysfs-stats.c         | 202 ------------------
 drivers/dma-buf/dma-buf-sysfs-stats.h         |  35 ---
 drivers/dma-buf/dma-buf.c                     |  18 --
 7 files changed, 300 deletions(-)
 delete mode 100644 Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers
 delete mode 100644 drivers/dma-buf/dma-buf-sysfs-stats.c
 delete mode 100644 drivers/dma-buf/dma-buf-sysfs-stats.h

diff --git a/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers b/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers
deleted file mode 100644
index 5d3bc997dc64..000000000000
--- a/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers
+++ /dev/null
@@ -1,24 +0,0 @@
-What:		/sys/kernel/dmabuf/buffers
-Date:		May 2021
-KernelVersion:	v5.13
-Contact:	Hridya Valsaraju <hridya@google.com>
-Description:	The /sys/kernel/dmabuf/buffers directory contains a
-		snapshot of the internal state of every DMA-BUF.
-		/sys/kernel/dmabuf/buffers/<inode_number> will contain the
-		statistics for the DMA-BUF with the unique inode number
-		<inode_number>
-Users:		kernel memory tuning/debugging tools
-
-What:		/sys/kernel/dmabuf/buffers/<inode_number>/exporter_name
-Date:		May 2021
-KernelVersion:	v5.13
-Contact:	Hridya Valsaraju <hridya@google.com>
-Description:	This file is read-only and contains the name of the exporter of
-		the DMA-BUF.
-
-What:		/sys/kernel/dmabuf/buffers/<inode_number>/size
-Date:		May 2021
-KernelVersion:	v5.13
-Contact:	Hridya Valsaraju <hridya@google.com>
-Description:	This file is read-only and specifies the size of the DMA-BUF in
-		bytes.
diff --git a/Documentation/driver-api/dma-buf.rst b/Documentation/driver-api/dma-buf.rst
index 29abf1eebf9f..2f36c21d9948 100644
--- a/Documentation/driver-api/dma-buf.rst
+++ b/Documentation/driver-api/dma-buf.rst
@@ -125,11 +125,6 @@ Implicit Fence Poll Support
 .. kernel-doc:: drivers/dma-buf/dma-buf.c
    :doc: implicit fence polling
 
-DMA-BUF statistics
-~~~~~~~~~~~~~~~~~~
-.. kernel-doc:: drivers/dma-buf/dma-buf-sysfs-stats.c
-   :doc: overview
-
 DMA Buffer ioctls
 ~~~~~~~~~~~~~~~~~
 
diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index fee04fdb0822..03e38c0d1fff 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -76,21 +76,6 @@ menuconfig DMABUF_HEAPS
 	  allows userspace to allocate dma-bufs that can be shared
 	  between drivers.
 
-menuconfig DMABUF_SYSFS_STATS
-	bool "DMA-BUF sysfs statistics (DEPRECATED)"
-	depends on DMA_SHARED_BUFFER
-	help
-	   Choose this option to enable DMA-BUF sysfs statistics
-	   in location /sys/kernel/dmabuf/buffers.
-
-	   /sys/kernel/dmabuf/buffers/<inode_number> will contain
-	   statistics for the DMA-BUF with the unique inode number
-	   <inode_number>.
-
-	   This option is deprecated and should sooner or later be removed.
-	   Android is the only user of this and it turned out that this resulted
-	   in quite some performance problems.
-
 source "drivers/dma-buf/heaps/Kconfig"
 
 endmenu
diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
index 70ec901edf2c..8ab2bfecb1c9 100644
--- a/drivers/dma-buf/Makefile
+++ b/drivers/dma-buf/Makefile
@@ -6,7 +6,6 @@ obj-$(CONFIG_DMABUF_HEAPS)	+= heaps/
 obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
 obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
 obj-$(CONFIG_UDMABUF)		+= udmabuf.o
-obj-$(CONFIG_DMABUF_SYSFS_STATS) += dma-buf-sysfs-stats.o
 
 dmabuf_selftests-y := \
 	selftest.o \
diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-buf/dma-buf-sysfs-stats.c
deleted file mode 100644
index b5b62e40ccc1..000000000000
--- a/drivers/dma-buf/dma-buf-sysfs-stats.c
+++ /dev/null
@@ -1,202 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * DMA-BUF sysfs statistics.
- *
- * Copyright (C) 2021 Google LLC.
- */
-
-#include <linux/dma-buf.h>
-#include <linux/dma-resv.h>
-#include <linux/kobject.h>
-#include <linux/printk.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-
-#include "dma-buf-sysfs-stats.h"
-
-#define to_dma_buf_entry_from_kobj(x) container_of(x, struct dma_buf_sysfs_entry, kobj)
-
-/**
- * DOC: overview
- *
- * ``/sys/kernel/debug/dma_buf/bufinfo`` provides an overview of every DMA-BUF
- * in the system. However, since debugfs is not safe to be mounted in
- * production, procfs and sysfs can be used to gather DMA-BUF statistics on
- * production systems.
- *
- * The ``/proc/<pid>/fdinfo/<fd>`` files in procfs can be used to gather
- * information about DMA-BUF fds. Detailed documentation about the interface
- * is present in Documentation/filesystems/proc.rst.
- *
- * Unfortunately, the existing procfs interfaces can only provide information
- * about the DMA-BUFs for which processes hold fds or have the buffers mmapped
- * into their address space. This necessitated the creation of the DMA-BUF sysfs
- * statistics interface to provide per-buffer information on production systems.
- *
- * The interface at ``/sys/kernel/dmabuf/buffers`` exposes information about
- * every DMA-BUF when ``CONFIG_DMABUF_SYSFS_STATS`` is enabled.
- *
- * The following stats are exposed by the interface:
- *
- * * ``/sys/kernel/dmabuf/buffers/<inode_number>/exporter_name``
- * * ``/sys/kernel/dmabuf/buffers/<inode_number>/size``
- *
- * The information in the interface can also be used to derive per-exporter
- * statistics. The data from the interface can be gathered on error conditions
- * or other important events to provide a snapshot of DMA-BUF usage.
- * It can also be collected periodically by telemetry to monitor various metrics.
- *
- * Detailed documentation about the interface is present in
- * Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers.
- */
-
-struct dma_buf_stats_attribute {
-	struct attribute attr;
-	ssize_t (*show)(struct dma_buf *dmabuf,
-			struct dma_buf_stats_attribute *attr, char *buf);
-};
-#define to_dma_buf_stats_attr(x) container_of(x, struct dma_buf_stats_attribute, attr)
-
-static ssize_t dma_buf_stats_attribute_show(struct kobject *kobj,
-					    struct attribute *attr,
-					    char *buf)
-{
-	struct dma_buf_stats_attribute *attribute;
-	struct dma_buf_sysfs_entry *sysfs_entry;
-	struct dma_buf *dmabuf;
-
-	attribute = to_dma_buf_stats_attr(attr);
-	sysfs_entry = to_dma_buf_entry_from_kobj(kobj);
-	dmabuf = sysfs_entry->dmabuf;
-
-	if (!dmabuf || !attribute->show)
-		return -EIO;
-
-	return attribute->show(dmabuf, attribute, buf);
-}
-
-static const struct sysfs_ops dma_buf_stats_sysfs_ops = {
-	.show = dma_buf_stats_attribute_show,
-};
-
-static ssize_t exporter_name_show(struct dma_buf *dmabuf,
-				  struct dma_buf_stats_attribute *attr,
-				  char *buf)
-{
-	return sysfs_emit(buf, "%s\n", dmabuf->exp_name);
-}
-
-static ssize_t size_show(struct dma_buf *dmabuf,
-			 struct dma_buf_stats_attribute *attr,
-			 char *buf)
-{
-	return sysfs_emit(buf, "%zu\n", dmabuf->size);
-}
-
-static struct dma_buf_stats_attribute exporter_name_attribute =
-	__ATTR_RO(exporter_name);
-static struct dma_buf_stats_attribute size_attribute = __ATTR_RO(size);
-
-static struct attribute *dma_buf_stats_default_attrs[] = {
-	&exporter_name_attribute.attr,
-	&size_attribute.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(dma_buf_stats_default);
-
-static void dma_buf_sysfs_release(struct kobject *kobj)
-{
-	struct dma_buf_sysfs_entry *sysfs_entry;
-
-	sysfs_entry = to_dma_buf_entry_from_kobj(kobj);
-	kfree(sysfs_entry);
-}
-
-static const struct kobj_type dma_buf_ktype = {
-	.sysfs_ops = &dma_buf_stats_sysfs_ops,
-	.release = dma_buf_sysfs_release,
-	.default_groups = dma_buf_stats_default_groups,
-};
-
-void dma_buf_stats_teardown(struct dma_buf *dmabuf)
-{
-	struct dma_buf_sysfs_entry *sysfs_entry;
-
-	sysfs_entry = dmabuf->sysfs_entry;
-	if (!sysfs_entry)
-		return;
-
-	kobject_del(&sysfs_entry->kobj);
-	kobject_put(&sysfs_entry->kobj);
-}
-
-
-/* Statistics files do not need to send uevents. */
-static int dmabuf_sysfs_uevent_filter(const struct kobject *kobj)
-{
-	return 0;
-}
-
-static const struct kset_uevent_ops dmabuf_sysfs_no_uevent_ops = {
-	.filter = dmabuf_sysfs_uevent_filter,
-};
-
-static struct kset *dma_buf_stats_kset;
-static struct kset *dma_buf_per_buffer_stats_kset;
-int dma_buf_init_sysfs_statistics(void)
-{
-	dma_buf_stats_kset = kset_create_and_add("dmabuf",
-						 &dmabuf_sysfs_no_uevent_ops,
-						 kernel_kobj);
-	if (!dma_buf_stats_kset)
-		return -ENOMEM;
-
-	dma_buf_per_buffer_stats_kset = kset_create_and_add("buffers",
-							    &dmabuf_sysfs_no_uevent_ops,
-							    &dma_buf_stats_kset->kobj);
-	if (!dma_buf_per_buffer_stats_kset) {
-		kset_unregister(dma_buf_stats_kset);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-void dma_buf_uninit_sysfs_statistics(void)
-{
-	kset_unregister(dma_buf_per_buffer_stats_kset);
-	kset_unregister(dma_buf_stats_kset);
-}
-
-int dma_buf_stats_setup(struct dma_buf *dmabuf, struct file *file)
-{
-	struct dma_buf_sysfs_entry *sysfs_entry;
-	int ret;
-
-	if (!dmabuf->exp_name) {
-		pr_err("exporter name must not be empty if stats needed\n");
-		return -EINVAL;
-	}
-
-	sysfs_entry = kzalloc(sizeof(struct dma_buf_sysfs_entry), GFP_KERNEL);
-	if (!sysfs_entry)
-		return -ENOMEM;
-
-	sysfs_entry->kobj.kset = dma_buf_per_buffer_stats_kset;
-	sysfs_entry->dmabuf = dmabuf;
-
-	dmabuf->sysfs_entry = sysfs_entry;
-
-	/* create the directory for buffer stats */
-	ret = kobject_init_and_add(&sysfs_entry->kobj, &dma_buf_ktype, NULL,
-				   "%lu", file_inode(file)->i_ino);
-	if (ret)
-		goto err_sysfs_dmabuf;
-
-	return 0;
-
-err_sysfs_dmabuf:
-	kobject_put(&sysfs_entry->kobj);
-	dmabuf->sysfs_entry = NULL;
-	return ret;
-}
diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.h b/drivers/dma-buf/dma-buf-sysfs-stats.h
deleted file mode 100644
index 7a8a995b75ba..000000000000
--- a/drivers/dma-buf/dma-buf-sysfs-stats.h
+++ /dev/null
@@ -1,35 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * DMA-BUF sysfs statistics.
- *
- * Copyright (C) 2021 Google LLC.
- */
-
-#ifndef _DMA_BUF_SYSFS_STATS_H
-#define _DMA_BUF_SYSFS_STATS_H
-
-#ifdef CONFIG_DMABUF_SYSFS_STATS
-
-int dma_buf_init_sysfs_statistics(void);
-void dma_buf_uninit_sysfs_statistics(void);
-
-int dma_buf_stats_setup(struct dma_buf *dmabuf, struct file *file);
-
-void dma_buf_stats_teardown(struct dma_buf *dmabuf);
-#else
-
-static inline int dma_buf_init_sysfs_statistics(void)
-{
-	return 0;
-}
-
-static inline void dma_buf_uninit_sysfs_statistics(void) {}
-
-static inline int dma_buf_stats_setup(struct dma_buf *dmabuf, struct file *file)
-{
-	return 0;
-}
-
-static inline void dma_buf_stats_teardown(struct dma_buf *dmabuf) {}
-#endif
-#endif // _DMA_BUF_SYSFS_STATS_H
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 7260bdd77c75..adc6a0c96641 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -31,8 +31,6 @@
 #include <uapi/linux/dma-buf.h>
 #include <uapi/linux/magic.h>
 
-#include "dma-buf-sysfs-stats.h"
-
 static inline int is_dma_buf_file(struct file *);
 
 DEFINE_MUTEX(dmabuf_list_mutex);
@@ -88,7 +86,6 @@ static void dma_buf_release(struct dentry *dentry)
 	 */
 	BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
 
-	dma_buf_stats_teardown(dmabuf);
 	dmabuf->ops->release(dmabuf);
 
 	if (dmabuf->resv == (struct dma_resv *)&dmabuf[1])
@@ -671,10 +668,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 		dmabuf->resv = resv;
 	}
 
-	ret = dma_buf_stats_setup(dmabuf, file);
-	if (ret)
-		goto err_dmabuf;
-
 	file->private_data = dmabuf;
 	file->f_path.dentry->d_fsdata = dmabuf;
 	dmabuf->file = file;
@@ -683,10 +676,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 
 	return dmabuf;
 
-err_dmabuf:
-	if (!resv)
-		dma_resv_fini(dmabuf->resv);
-	kfree(dmabuf);
 err_file:
 	fput(file);
 err_module:
@@ -1717,12 +1706,6 @@ static inline void dma_buf_uninit_debugfs(void)
 
 static int __init dma_buf_init(void)
 {
-	int ret;
-
-	ret = dma_buf_init_sysfs_statistics();
-	if (ret)
-		return ret;
-
 	dma_buf_mnt = kern_mount(&dma_buf_fs_type);
 	if (IS_ERR(dma_buf_mnt))
 		return PTR_ERR(dma_buf_mnt);
@@ -1736,6 +1719,5 @@ static void __exit dma_buf_deinit(void)
 {
 	dma_buf_uninit_debugfs();
 	kern_unmount(dma_buf_mnt);
-	dma_buf_uninit_sysfs_statistics();
 }
 __exitcall(dma_buf_deinit);
-- 
2.49.0.906.g1f30a19c02-goog


