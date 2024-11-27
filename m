Return-Path: <linux-kselftest+bounces-22555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1EC9DA0F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 03:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B358B22502
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 02:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E920156236;
	Wed, 27 Nov 2024 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8GRcF/8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C11482E3
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2024 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676284; cv=none; b=FK0gFzgGrBwYprBB6/PAgP3Vl27+43Stq1a8vjV3yymLkOCq4s4dAbW/yvqEL4S7vjF1QPrQ8Z1/axZs2OyEJys5cb0v8A6K+AoXetglq+QTR8u2cyVTUCdZTE2x9DUuEjcb4+/mJbwixOOEPAsxygISuRS27Ipu14w4sdZNawc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676284; c=relaxed/simple;
	bh=0cgN7lCrUY481ds+fbjA4PD1+m21LOwhclWRHQ8YlGo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D+A72o/hQmofkt4AYn1ACEum2thMSNbK7WdXU92FjuSmBxfWS661Z/EWmgloefoZXD8fuWzDSIKPTmGF7T4pNHxBRWK68LqeaC3hBdMomQ3dUK/0ZjW3AgiNwbr3BGgxBYucjFcwatKHMPSd8qTncQ8AfxDb0XWVQ0sWAHWqx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8GRcF/8; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-5eb78268680so4537614eaf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 18:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732676280; x=1733281080; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J230iZRfwuVra4Pz4XMka7O3vESUEZ4tRN3Joobiohw=;
        b=R8GRcF/8LlzUK6goo1JweEZOeenx3AMR2T7v91HDRrtVJfjmfX+mvqnBlTg4WaXShi
         +YgymgNynQd+WkZUsC91H1wQ2JwMuXuCXoF8RmSKWhglhqYsgnwWyolUFCZtAQxXV/R/
         V2DRONOGGta4+2sgHVmipOodTK4zzBXKgUWK8nJNhTKgGNdXQiL2Jb8Qc1/xoOd0Kv2u
         /MaTUenJd0Ubw1Qw+RLDAx2X7PMuCw4iPNQ/006nsPBSw8yVspKACuxG0+7/N0paQTis
         R9sYs9k24q/e9IdnI83Yvb77LIZyBRGn1JqtXzK84JUeC0At7EOQdBkFiReQscoH/1t/
         BHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732676280; x=1733281080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J230iZRfwuVra4Pz4XMka7O3vESUEZ4tRN3Joobiohw=;
        b=O+hCpIKFyhRhxMGi83f70vRU9byxv90mCPKXEs3i/u7uU4NPB7P5VL96Yf0ucpdiI3
         4Iafu5bb34dSowiDMy+iVDOeNbU688qlz0Qs5axt1JuXGFRbJHg1x6xmStLStu9I1WZc
         UA6kkot1rjirDkV8jV1DKYEviT+cbmNI0OuQYz9Ds6Viwy5Vxj9Luc3nEXe2wgYwy+q6
         YUnaLueNk1Y5/YU45AR466n8H662gSf4ZhQY9nuu+qqwZ7f2DDlc8PiPuU6xm2d2hZrd
         pcvMzC1y6B2gJ06Pn9pNATwHF9U+p0BNnpaG5b36P0gZrz4HkcPL7YZZf7mjfOJLrkUF
         i9IA==
X-Forwarded-Encrypted: i=1; AJvYcCV9e4Kw+1x3W23CWq1W7rhMuqQMXN0NpqqTVu6hrr+HPxAPQHzOcWszswNi9jBnQUGoq0uk2STZKHFd6+aOfDc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqr+qHpPh+VZ8He93sou0U5PnAL8O3qO91r06CZZXn6XzAYiWV
	f4LzGBJT9G6IBMMDarva75ivr3OzqsuU7znigsboQsA7R9BuUUoly3CjnZyGUCNpwAnEYJdYW/W
	ARUSGZg==
X-Google-Smtp-Source: AGHT+IFIJL8h5DmsRNBM5ZiX5QfIqL9o1tI1OHXYDHS0S9zx9IEBE7CHBXLRc6dJk0foy6FX7GvuZ5iRwwn6
X-Received: from oabvr9.prod.google.com ([2002:a05:6871:a0c9:b0:295:f44d:8dfa])
 (user=yuanchu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:3b1b:b0:296:cdee:f7de
 with SMTP id 586e51a60fabf-29dc417fa5fmr1273477fac.21.1732676280422; Tue, 26
 Nov 2024 18:58:00 -0800 (PST)
Date: Tue, 26 Nov 2024 18:57:28 -0800
In-Reply-To: <20241127025728.3689245-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127025728.3689245-10-yuanchu@google.com>
Subject: [PATCH v4 9/9] virtio-balloon: add workingset reporting
From: Yuanchu Xie <yuanchu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, Yuanchu Xie <yuanchu@google.com>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ballooning is a way to dynamically size a VM, and it requires guest
collaboration. The amount to balloon without adversely affecting guest
performance is hard to compute without clear metrics from the guest.

Workingset reporting can provide guidance to the host to allow better
collaborative ballooning, such that the host balloon controller can
properly gauge the amount of memory the guest is actively using, i.e.,
the working set.

A draft QEMU series [1] is being worked on. Currently it is able to
configure the workingset reporting bins, refresh_interval, and report
threshold. Through QMP or HMP, a balloon controller can request a
workingset report. There is also a script [2] exercising the QMP
interface with a visual breakdown of the guest's workingset size.

According to the OASIS VIRTIO v1.3, there's a new balloon device in the
works and this one I'm adding to is the "traditional" balloon. If the
existing balloon device is not the right place for new features. I'm
more than happy to add it to the new one as well.

For technical details, this patch adds the a generic mechanism into
workingset reporting infrastructure to allow other parts of the kernel
to receive workingset reports. Two virtqueues are added to the
virtio-balloon device, notification_vq and report_vq. The notification
virtqueue allows the host to configure the guest workingset reporting
parameters and request a report. The report virtqueue sends a working
set report to the host when one is requested or due to memory pressure.

The workingset reporting feature is gated by the compilation flag
CONFIG_WORKINGSET_REPORT and the balloon feature flag
VIRTIO_BALLOON_F_WS_REPORTING.

[1] https://github.com/Dummyc0m/qemu/tree/wsr
[2] https://gist.github.com/Dummyc0m/d45b4e1b0dda8f2bc6cd8cfb37cc7e34

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 drivers/virtio/virtio_balloon.c     | 390 +++++++++++++++++++++++++++-
 include/linux/balloon_compaction.h  |   1 +
 include/linux/mmzone.h              |   4 +
 include/linux/workingset_report.h   |  66 ++++-
 include/uapi/linux/virtio_balloon.h |  30 +++
 mm/workingset_report.c              |  89 ++++++-
 6 files changed, 566 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index b36d2803674e..8eb300653dd8 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -18,6 +18,7 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
+#include <linux/workingset_report.h>
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -45,6 +46,8 @@ enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_STATS,
 	VIRTIO_BALLOON_VQ_FREE_PAGE,
 	VIRTIO_BALLOON_VQ_REPORTING,
+	VIRTIO_BALLOON_VQ_WORKING_SET,
+	VIRTIO_BALLOON_VQ_NOTIFY,
 	VIRTIO_BALLOON_VQ_MAX
 };
 
@@ -124,6 +127,23 @@ struct virtio_balloon {
 	spinlock_t wakeup_lock;
 	bool processing_wakeup_event;
 	u32 wakeup_signal_mask;
+
+#ifdef CONFIG_WORKINGSET_REPORT
+	struct virtqueue *working_set_vq, *notification_vq;
+
+	/* Protects node_id, wsr_receiver, and report_buf */
+	struct mutex wsr_report_lock;
+	int wsr_node_id;
+	struct wsr_receiver wsr_receiver;
+	/* Buffer to report to host */
+	struct virtio_balloon_working_set_report *report_buf;
+
+	/* Buffer to hold incoming notification from the host. */
+	struct virtio_balloon_working_set_notify *notify_buf;
+
+	struct work_struct update_balloon_working_set_work;
+	struct work_struct update_balloon_notification_work;
+#endif
 };
 
 #define VIRTIO_BALLOON_WAKEUP_SIGNAL_ADJUST (1 << 0)
@@ -339,8 +359,352 @@ static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num)
 	return num_freed_pages;
 }
 
-static inline void update_stat(struct virtio_balloon *vb, int idx,
-			       u16 tag, u64 val)
+#ifdef CONFIG_WORKINGSET_REPORT
+static bool wsr_is_configured(struct virtio_balloon *vb)
+{
+	if (node_online(READ_ONCE(vb->wsr_node_id)) &&
+	    READ_ONCE(vb->wsr_receiver.wsr.refresh_interval) > 0 &&
+	    READ_ONCE(vb->wsr_receiver.wsr.page_age) != NULL)
+		return true;
+	return false;
+}
+
+/* wsr_receiver callback */
+static void wsr_receiver_notify(struct wsr_receiver *receiver)
+{
+	int bin;
+	struct virtio_balloon *vb =
+		container_of(receiver, struct virtio_balloon, wsr_receiver);
+
+	/* if we fail to acquire the locks, send stale report */
+	if (!mutex_trylock(&vb->wsr_report_lock))
+		goto out;
+	if (!mutex_trylock(&receiver->wsr.page_age_lock))
+		goto out_unlock_report_buf;
+	if (!READ_ONCE(receiver->wsr.page_age))
+		goto out_unlock_page_age;
+
+	vb->report_buf->error = cpu_to_le32(0);
+	vb->report_buf->node_id = cpu_to_le32(vb->wsr_node_id);
+	for (bin = 0; bin < WORKINGSET_REPORT_MAX_NR_BINS; ++bin) {
+		struct virtio_balloon_working_set_report_bin *dest =
+			&vb->report_buf->bins[bin];
+		struct wsr_report_bin *src = &receiver->wsr.page_age->bins[bin];
+
+		dest->anon_bytes =
+			cpu_to_le64(src->nr_pages[LRU_GEN_ANON] * PAGE_SIZE);
+		dest->file_bytes =
+			cpu_to_le64(src->nr_pages[LRU_GEN_FILE] * PAGE_SIZE);
+		if (src->idle_age == WORKINGSET_INTERVAL_MAX) {
+			dest->idle_age = cpu_to_le64(WORKINGSET_INTERVAL_MAX);
+			break;
+		}
+		dest->idle_age = cpu_to_le64(jiffies_to_msecs(src->idle_age));
+	}
+
+out_unlock_page_age:
+	mutex_unlock(&receiver->wsr.page_age_lock);
+out_unlock_report_buf:
+	mutex_unlock(&vb->wsr_report_lock);
+out:
+	/* Send the working set report to the device. */
+	spin_lock(&vb->stop_update_lock);
+	if (!vb->stop_update)
+		queue_work(system_freezable_wq, &vb->update_balloon_working_set_work);
+	spin_unlock(&vb->stop_update_lock);
+}
+
+static void virtio_balloon_working_set_request(struct virtio_balloon *vb,
+					       int nid)
+{
+	int err = 0;
+
+	if (!node_online(nid)) {
+		err = -EINVAL;
+		goto error;
+	}
+
+	err = wsr_refresh_receiver_report(NODE_DATA(nid));
+	if (err)
+		goto error;
+
+	return;
+error:
+	mutex_lock(&vb->wsr_report_lock);
+	vb->report_buf->error = cpu_to_le16(err);
+	vb->report_buf->node_id = cpu_to_le32(nid);
+	mutex_unlock(&vb->wsr_report_lock);
+	spin_lock(&vb->stop_update_lock);
+	if (!vb->stop_update)
+		queue_work(system_freezable_wq,
+			   &vb->update_balloon_working_set_work);
+	spin_unlock(&vb->stop_update_lock);
+}
+
+static void notification_receive(struct virtqueue *vq)
+{
+	struct virtio_balloon *vb = vq->vdev->priv;
+
+	spin_lock(&vb->stop_update_lock);
+	if (!vb->stop_update)
+		queue_work(system_freezable_wq, &vb->update_balloon_notification_work);
+	spin_unlock(&vb->stop_update_lock);
+}
+
+static int
+virtio_balloon_register_working_set_receiver(struct virtio_balloon *vb)
+{
+	struct pglist_data *pgdat;
+	struct wsr_report_bins *bins = NULL, __rcu *old;
+	int nid, bin, err = 0, old_nid = vb->wsr_node_id;
+	struct virtio_balloon_working_set_notify *notify = vb->notify_buf;
+
+	nid = le16_to_cpu(notify->node_id);
+	if (!node_online(nid)) {
+		dev_warn(&vb->vdev->dev, "node not online %d\n", nid);
+		return -EINVAL;
+	}
+
+	pgdat = NODE_DATA(nid);
+	bins = kzalloc(sizeof(struct wsr_report_bins), GFP_KERNEL);
+
+	if (!bins)
+		return -ENOMEM;
+
+	for (bin = 0; bin < WORKINGSET_REPORT_MAX_NR_BINS; ++bin) {
+		u32 age_msecs = le32_to_cpu(notify->idle_age[bin]);
+		unsigned long age = msecs_to_jiffies(age_msecs);
+
+		/*
+		 * A correct idle_age array should end in
+		 * WORKINGSET_INTERVAL_MAX.
+		 */
+		if (age_msecs == (u32)WORKINGSET_INTERVAL_MAX) {
+			bins->idle_age[bin] = WORKINGSET_INTERVAL_MAX;
+			break;
+		}
+		bins->idle_age[bin] = age;
+		if (bin > 0 && bins->idle_age[bin] <= bins->idle_age[bin - 1]) {
+			dev_warn(&vb->vdev->dev, "bins not increasing\n");
+			err = -EINVAL;
+			goto error;
+		}
+	}
+	if (bin < WORKINGSET_REPORT_MIN_NR_BINS - 1 ||
+	    bin == WORKINGSET_REPORT_MAX_NR_BINS) {
+		err = -ERANGE;
+		goto error;
+	}
+	bins->nr_bins = bin;
+
+	mutex_lock(&vb->wsr_report_lock);
+	err = wsr_set_refresh_interval(
+		&vb->wsr_receiver.wsr,
+		le32_to_cpu(notify->refresh_interval));
+	if (err) {
+		mutex_unlock(&vb->wsr_report_lock);
+		goto error;
+	}
+	if (old_nid != NUMA_NO_NODE)
+		wsr_remove_receiver(&vb->wsr_receiver, NODE_DATA(old_nid));
+	WRITE_ONCE(vb->wsr_node_id, nid);
+	WRITE_ONCE(vb->wsr_receiver.wsr.report_threshold,
+		   msecs_to_jiffies(le32_to_cpu(notify->report_threshold)));
+	WRITE_ONCE(vb->wsr_receiver.notify, wsr_receiver_notify);
+	mutex_unlock(&vb->wsr_report_lock);
+
+	/* update the bins for target node */
+	mutex_lock(&pgdat->wsr_update_mutex);
+	old = rcu_replace_pointer(pgdat->wsr_page_age_bins, bins,
+				  lockdep_is_held(&pgdat->wsr_update_mutex));
+	mutex_unlock(&pgdat->wsr_update_mutex);
+	kfree_rcu(old, rcu);
+
+	wsr_register_receiver(&vb->wsr_receiver, pgdat);
+
+	return 0;
+error:
+	kfree(bins);
+	return err;
+}
+
+static void update_balloon_notification_func(struct work_struct *work)
+{
+	unsigned int len, op;
+	int err;
+	struct virtio_balloon *vb;
+	struct scatterlist sg_in;
+
+	vb = container_of(work, struct virtio_balloon,
+			  update_balloon_notification_work);
+	op = le16_to_cpu(vb->notify_buf->op);
+
+	switch (op) {
+	case VIRTIO_BALLOON_WS_OP_REQUEST:
+		virtio_balloon_working_set_request(vb,
+						   READ_ONCE(vb->wsr_node_id));
+		break;
+	case VIRTIO_BALLOON_WS_OP_CONFIG:
+		err = virtio_balloon_register_working_set_receiver(vb);
+		if (err)
+			dev_warn(&vb->vdev->dev,
+				 "Error configuring working set, %d\n", err);
+		break;
+	default:
+		dev_warn(&vb->vdev->dev, "Received invalid notification, %u\n",
+			 op);
+		break;
+	}
+
+	/* Detach all the used buffers from the vq */
+	while (virtqueue_get_buf(vb->notification_vq, &len))
+		;
+	/* Add a new notification buffer for device to fill. */
+	sg_init_one(&sg_in, vb->notify_buf, sizeof(*vb->notify_buf));
+	virtqueue_add_inbuf(vb->notification_vq, &sg_in, 1, vb, GFP_KERNEL);
+	virtqueue_kick(vb->notification_vq);
+}
+
+static void update_balloon_ws_func(struct work_struct *work)
+{
+	struct virtio_balloon *vb;
+
+	vb = container_of(work, struct virtio_balloon,
+			  update_balloon_working_set_work);
+
+	if (wsr_is_configured(vb)) {
+		struct scatterlist sg_out;
+		int unused;
+		int err;
+
+		/* Detach all the used buffers from the vq */
+		while (virtqueue_get_buf(vb->working_set_vq, &unused))
+			;
+		sg_init_one(&sg_out, vb->report_buf, sizeof(*vb->report_buf));
+		err = virtqueue_add_outbuf(vb->working_set_vq, &sg_out, 1, vb, GFP_KERNEL);
+		if (unlikely(err))
+			dev_err(&vb->vdev->dev,
+				"Failed to send working set report err = %d\n",
+				err);
+		else
+			virtqueue_kick(vb->working_set_vq);
+
+	} else {
+		dev_warn(&vb->vdev->dev, "Working Set not initialized.");
+	}
+}
+
+static void wsr_init_vqs_info(struct virtio_balloon *vb,
+			      struct virtqueue_info vqs_info[])
+{
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING)) {
+		vqs_info[VIRTIO_BALLOON_VQ_WORKING_SET].name = "ws";
+		vqs_info[VIRTIO_BALLOON_VQ_WORKING_SET].callback = NULL;
+		vqs_info[VIRTIO_BALLOON_VQ_NOTIFY].name = "notify";
+		vqs_info[VIRTIO_BALLOON_VQ_NOTIFY].callback = notification_receive;
+	}
+}
+
+static int wsr_init_vq(struct virtio_balloon *vb, struct virtqueue *vqs[])
+{
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING)) {
+		struct scatterlist sg;
+		int err;
+
+		vb->working_set_vq = vqs[VIRTIO_BALLOON_VQ_WORKING_SET];
+		vb->notification_vq = vqs[VIRTIO_BALLOON_VQ_NOTIFY];
+
+		/* Prime the notification virtqueue for the device to fill. */
+		sg_init_one(&sg, vb->notify_buf, sizeof(*vb->notify_buf));
+		err = virtqueue_add_inbuf(vb->notification_vq, &sg, 1, vb, GFP_KERNEL);
+		if (unlikely(err)) {
+			dev_err(&vb->vdev->dev,
+				"Failed to prepare notifications, err = %d\n", err);
+			return err;
+		}
+		virtqueue_kick(vb->notification_vq);
+	}
+	return 0;
+}
+
+static void wsr_init_work(struct virtio_balloon *vb)
+{
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING)) {
+		INIT_WORK(&vb->update_balloon_working_set_work,
+			  update_balloon_ws_func);
+		INIT_WORK(&vb->update_balloon_notification_work,
+			  update_balloon_notification_func);
+	}
+}
+
+static int wsr_init(struct virtio_balloon *vb)
+{
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING)) {
+		vb->report_buf = kzalloc(sizeof(*vb->report_buf), GFP_KERNEL);
+		if (!vb->report_buf)
+			return -ENOMEM;
+
+		vb->notify_buf = kzalloc(sizeof(*vb->notify_buf), GFP_KERNEL);
+		if (!vb->notify_buf) {
+			kfree(vb->report_buf);
+			vb->report_buf = NULL;
+			return -ENOMEM;
+		}
+
+		wsr_init_state(&vb->wsr_receiver.wsr);
+		vb->wsr_node_id = NUMA_NO_NODE;
+		vb->report_buf->bins[0].idle_age = WORKINGSET_INTERVAL_MAX;
+	}
+	return 0;
+}
+
+static void wsr_remove(struct virtio_balloon *vb)
+{
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING) &&
+	    vb->wsr_node_id != NUMA_NO_NODE) {
+		wsr_remove_receiver(&vb->wsr_receiver, NODE_DATA(vb->wsr_node_id));
+		wsr_destroy_state(&vb->wsr_receiver.wsr);
+	}
+
+	kfree(vb->report_buf);
+	kfree(vb->notify_buf);
+	mutex_destroy(&vb->wsr_report_lock);
+}
+
+static void wsr_cancel_work(struct virtio_balloon *vb)
+{
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING)) {
+		cancel_work_sync(&vb->update_balloon_working_set_work);
+		cancel_work_sync(&vb->update_balloon_notification_work);
+	}
+}
+#else
+static inline void wsr_init_vqs_info(struct virtio_balloon *vb,
+				     struct virtqueue_info vqs_info[])
+{
+}
+static inline int wsr_init_vq(struct virtio_balloon *vb,
+			      struct virtqueue *vqs[])
+{
+	return 0;
+}
+static inline void wsr_init_work(struct virtio_balloon *vb)
+{
+}
+static inline int wsr_init(struct virtio_balloon *vb)
+{
+	return 0;
+}
+static inline void wsr_remove(struct virtio_balloon *vb)
+{
+}
+static inline void wsr_cancel_work(struct virtio_balloon *vb)
+{
+}
+#endif
+
+static inline void update_stat(struct virtio_balloon *vb, int idx, u16 tag,
+			       u64 val)
 {
 	BUG_ON(idx >= VIRTIO_BALLOON_S_NR);
 	vb->stats[idx].tag = cpu_to_virtio16(vb->vdev, tag);
@@ -605,6 +969,8 @@ static int init_vqs(struct virtio_balloon *vb)
 		vqs_info[VIRTIO_BALLOON_VQ_REPORTING].callback = balloon_ack;
 	}
 
+	wsr_init_vqs_info(vb, vqs_info);
+
 	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
 			      vqs_info, NULL);
 	if (err)
@@ -615,6 +981,7 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		struct scatterlist sg;
 		unsigned int num_stats;
+
 		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
 
 		/*
@@ -640,6 +1007,11 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
 		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
 
+	err = wsr_init_vq(vb, vqs);
+
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -961,15 +1333,21 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		goto out;
 	}
 
+	vb->vdev = vdev;
+
 	INIT_WORK(&vb->update_balloon_stats_work, update_balloon_stats_func);
 	INIT_WORK(&vb->update_balloon_size_work, update_balloon_size_func);
+	wsr_init_work(vb);
 	spin_lock_init(&vb->stop_update_lock);
 	mutex_init(&vb->balloon_lock);
 	init_waitqueue_head(&vb->acked);
-	vb->vdev = vdev;
 
 	balloon_devinfo_init(&vb->vb_dev_info);
 
+	err = wsr_init(vb);
+	if (err)
+		goto out_remove_wsr;
+
 	err = init_vqs(vb);
 	if (err)
 		goto out_free_vb;
@@ -1085,7 +1463,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	return 0;
-
 out_unregister_oom:
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		unregister_oom_notifier(&vb->oom_nb);
@@ -1099,6 +1476,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	vdev->config->del_vqs(vdev);
 out_free_vb:
 	kfree(vb);
+out_remove_wsr:
+	wsr_remove(vb);
 out:
 	return err;
 }
@@ -1130,11 +1509,13 @@ static void virtballoon_remove(struct virtio_device *vdev)
 		unregister_oom_notifier(&vb->oom_nb);
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		virtio_balloon_unregister_shrinker(vb);
+	wsr_remove(vb);
 	spin_lock_irq(&vb->stop_update_lock);
 	vb->stop_update = true;
 	spin_unlock_irq(&vb->stop_update_lock);
 	cancel_work_sync(&vb->update_balloon_size_work);
 	cancel_work_sync(&vb->update_balloon_stats_work);
+	wsr_cancel_work(vb);
 
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
 		cancel_work_sync(&vb->report_free_page_work);
@@ -1200,6 +1581,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
+	VIRTIO_BALLOON_F_WS_REPORTING,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 5ca2d5699620..d92b8337dbcf 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -43,6 +43,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/list.h>
+#include <linux/workingset_report.h>
 
 /*
  * Balloon device information descriptor.
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ee728c0c5a3b..9a2dc506779d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1429,8 +1429,12 @@ typedef struct pglist_data {
 #endif
 
 #ifdef CONFIG_WORKINGSET_REPORT
+	/* protects wsr_page_age_bins */
 	struct mutex wsr_update_mutex;
 	struct wsr_report_bins __rcu *wsr_page_age_bins;
+	/* protects wsr_receiver_lost */
+	struct mutex wsr_receiver_mutex;
+	struct list_head wsr_receiver_list;
 #endif
 
 	CACHELINE_PADDING(_pad2_);
diff --git a/include/linux/workingset_report.h b/include/linux/workingset_report.h
index f6bbde2a04c3..1074b89035e9 100644
--- a/include/linux/workingset_report.h
+++ b/include/linux/workingset_report.h
@@ -11,13 +11,14 @@ struct node;
 struct lruvec;
 struct cgroup_file;
 struct wsr_state;
-
-#ifdef CONFIG_WORKINGSET_REPORT
+struct wsr_receiver;
 
 #define WORKINGSET_REPORT_MIN_NR_BINS 2
 #define WORKINGSET_REPORT_MAX_NR_BINS 32
 
 #define WORKINGSET_INTERVAL_MAX ((unsigned long)-1)
+
+#ifdef CONFIG_WORKINGSET_REPORT
 #define ANON_AND_FILE 2
 
 struct wsr_report_bin {
@@ -52,6 +53,8 @@ struct wsr_state {
 	struct wsr_page_age_histo *page_age;
 };
 
+void wsr_init_state(struct wsr_state *wsr);
+void wsr_destroy_state(struct wsr_state *wsr);
 void wsr_init_lruvec(struct lruvec *lruvec);
 void wsr_destroy_lruvec(struct lruvec *lruvec);
 void wsr_init_pgdat(struct pglist_data *pgdat);
@@ -66,6 +69,47 @@ void wsr_remove_sysfs(struct node *node);
 bool wsr_refresh_report(struct wsr_state *wsr, struct mem_cgroup *root,
 			struct pglist_data *pgdat, unsigned long *refresh_time);
 
+/*
+ * If refresh_interval > 0, enable working set reporting and kick
+ * the aging thread (if configured).
+ * If refresh_interval = 0, disable working set reporting and free
+ * the bookkeeping resources.
+ *
+ * @param refresh_interval milliseconds.
+ */
+int wsr_set_refresh_interval(struct wsr_state *wsr,
+			     unsigned long refresh_interval);
+
+struct wsr_receiver {
+	/*
+	 * Working set reporting ensures that two notify calls to
+	 * the same receivercannot interleave one another.
+	 *
+	 * Must be set before calling wsr_register_receiver.
+	 */
+	void (*notify)(struct wsr_receiver *receiver);
+	struct wsr_state wsr;
+	struct list_head list;
+};
+
+/*
+ * Register a per-node receiver
+ * report_threshold and refresh_interval are configured
+ * by the caller in struct wsr_state and contain valid values.
+ * page_age is allocated.
+ */
+void wsr_register_receiver(struct wsr_receiver *receiver,
+			  struct pglist_data *pgdat);
+
+void wsr_remove_receiver(struct wsr_receiver *receiver,
+			 struct pglist_data *pgdat);
+
+/*
+ * Refresh the report for the specified node, unless a refresh is already
+ * in progress or the parameters are being updated.
+ */
+int wsr_refresh_receiver_report(struct pglist_data *pgdat);
+
 #ifdef CONFIG_WORKINGSET_REPORT_AGING
 void wsr_wakeup_aging_thread(void);
 #else /* CONFIG_WORKINGSET_REPORT_AGING */
@@ -77,6 +121,12 @@ static inline void wsr_wakeup_aging_thread(void)
 int wsr_set_refresh_interval(struct wsr_state *wsr,
 			     unsigned long refresh_interval);
 #else
+static inline void wsr_init_state(struct wsr_state *wsr)
+{
+}
+static inline void wsr_destroy_state(struct wsr_state *wsr)
+{
+}
 static inline void wsr_init_lruvec(struct lruvec *lruvec)
 {
 }
@@ -100,6 +150,18 @@ static inline int wsr_set_refresh_interval(struct wsr_state *wsr,
 {
 	return 0;
 }
+static inline int wsr_register_receiver(struct wsr_receiver *receiver,
+					struct pglist_data *pgdat)
+{
+	return -ENODEV;
+}
+static inline void wsr_remove_receiver(struct wsr_receiver *receiver,
+				       struct pglist_data *pgdat)
+{
+}
+static inline void wsr_refresh_receiver_report(struct pglist_data *pgdat)
+{
+}
 #endif /* CONFIG_WORKINGSET_REPORT */
 
 #endif /* _LINUX_WORKINGSET_REPORT_H */
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ee35a372805d..668eaa39c85b 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -25,6 +25,7 @@
  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
  * SUCH DAMAGE. */
+#include "linux/workingset_report.h"
 #include <linux/types.h>
 #include <linux/virtio_types.h>
 #include <linux/virtio_ids.h>
@@ -37,6 +38,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_WS_REPORTING	6 /* Working Set Size reporting */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -128,4 +130,32 @@ struct virtio_balloon_stat {
 	__virtio64 val;
 } __attribute__((packed));
 
+/* Operations from the device */
+#define VIRTIO_BALLOON_WS_OP_REQUEST 1
+#define VIRTIO_BALLOON_WS_OP_CONFIG 2
+
+struct virtio_balloon_working_set_notify {
+	/* REQUEST or CONFIG */
+	__le16 op;
+	__le16 node_id;
+	/* the following fields valid iff op=CONFIG */
+	__le32 report_threshold;
+	__le32 refresh_interval;
+	__le32 idle_age[WORKINGSET_REPORT_MAX_NR_BINS];
+};
+
+struct virtio_balloon_working_set_report_bin {
+	__le64 idle_age;
+	/* bytes in this bucket for anon and file */
+	__le64 anon_bytes;
+	__le64 file_bytes;
+};
+
+struct virtio_balloon_working_set_report {
+	__le32 error;
+	__le32 node_id;
+	struct virtio_balloon_working_set_report_bin
+		bins[WORKINGSET_REPORT_MAX_NR_BINS];
+};
+
 #endif /* _LINUX_VIRTIO_BALLOON_H */
diff --git a/mm/workingset_report.c b/mm/workingset_report.c
index dad539e602bb..4b3397ebdbd0 100644
--- a/mm/workingset_report.c
+++ b/mm/workingset_report.c
@@ -20,27 +20,51 @@ void wsr_init_pgdat(struct pglist_data *pgdat)
 {
 	mutex_init(&pgdat->wsr_update_mutex);
 	RCU_INIT_POINTER(pgdat->wsr_page_age_bins, NULL);
+	INIT_LIST_HEAD(&pgdat->wsr_receiver_list);
 }
 
 void wsr_destroy_pgdat(struct pglist_data *pgdat)
 {
 	struct wsr_report_bins __rcu *bins;
+	struct list_head *cursor, *next;
 
 	mutex_lock(&pgdat->wsr_update_mutex);
 	bins = rcu_replace_pointer(pgdat->wsr_page_age_bins, NULL,
 			    lockdep_is_held(&pgdat->wsr_update_mutex));
-	kfree_rcu(bins, rcu);
 	mutex_unlock(&pgdat->wsr_update_mutex);
+	kfree_rcu(bins, rcu);
+	mutex_lock(&pgdat->wsr_receiver_mutex);
+	list_for_each_safe(cursor, next, &pgdat->wsr_receiver_list) {
+		/* pgdat does not own the receiver, so it's not free'd here */
+		list_del(cursor);
+	}
+	mutex_unlock(&pgdat->wsr_receiver_mutex);
+
 	mutex_destroy(&pgdat->wsr_update_mutex);
+	mutex_destroy(&pgdat->wsr_receiver_mutex);
+}
+
+void wsr_init_state(struct wsr_state *wsr)
+{
+	memset(wsr, 0, sizeof(*wsr));
+	mutex_init(&wsr->page_age_lock);
+}
+EXPORT_SYMBOL_GPL(wsr_init_state);
+
+void wsr_destroy_state(struct wsr_state *wsr)
+{
+	kfree(wsr->page_age);
+	mutex_destroy(&wsr->page_age_lock);
+	memset(wsr, 0, sizeof(*wsr));
 }
+EXPORT_SYMBOL_GPL(wsr_destroy_state);
 
 void wsr_init_lruvec(struct lruvec *lruvec)
 {
 	struct wsr_state *wsr = &lruvec->wsr;
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 
-	memset(wsr, 0, sizeof(*wsr));
-	mutex_init(&wsr->page_age_lock);
+	wsr_init_state(wsr);
 	if (memcg && !mem_cgroup_is_root(memcg))
 		wsr->page_age_cgroup_file = mem_cgroup_page_age_file(memcg);
 }
@@ -49,9 +73,7 @@ void wsr_destroy_lruvec(struct lruvec *lruvec)
 {
 	struct wsr_state *wsr = &lruvec->wsr;
 
-	mutex_destroy(&wsr->page_age_lock);
-	kfree(wsr->page_age);
-	memset(wsr, 0, sizeof(*wsr));
+	wsr_destroy_state(wsr);
 }
 
 int workingset_report_intervals_parse(char *src,
@@ -395,6 +417,7 @@ int wsr_set_refresh_interval(struct wsr_state *wsr,
 		wsr_wakeup_aging_thread();
 	return err;
 }
+EXPORT_SYMBOL_GPL(wsr_set_refresh_interval);
 
 static ssize_t refresh_interval_store(struct kobject *kobj,
 				      struct kobj_attribute *attr,
@@ -569,12 +592,62 @@ void wsr_remove_sysfs(struct node *node)
 }
 EXPORT_SYMBOL_GPL(wsr_remove_sysfs);
 
+/* wsr belongs to the root memcg or memcg is disabled */
+static int notify_receiver(struct wsr_state *wsr, struct pglist_data *pgdat)
+{
+	struct list_head *cursor;
+
+	if (!mutex_trylock(&pgdat->wsr_receiver_mutex))
+		return -EAGAIN;
+	list_for_each(cursor, &pgdat->wsr_receiver_list) {
+		struct wsr_receiver *entry =
+			list_entry(cursor, struct wsr_receiver, list);
+
+		wsr_refresh_report(&entry->wsr, NULL, pgdat, NULL);
+		entry->notify(entry);
+	}
+	mutex_unlock(&pgdat->wsr_receiver_mutex);
+	return 0;
+}
+
+int wsr_refresh_receiver_report(struct pglist_data *pgdat)
+{
+	struct wsr_state *wsr = &mem_cgroup_lruvec(NULL, pgdat)->wsr;
+
+	return notify_receiver(wsr, pgdat);
+}
+EXPORT_SYMBOL_GPL(wsr_refresh_receiver_report);
+
 void notify_workingset(struct mem_cgroup *memcg, struct pglist_data *pgdat)
 {
 	struct wsr_state *wsr = &mem_cgroup_lruvec(memcg, pgdat)->wsr;
 
-	if (mem_cgroup_is_root(memcg))
+	if (mem_cgroup_is_root(memcg)) {
 		kernfs_notify(wsr->page_age_sys_file);
-	else
+		notify_receiver(wsr, pgdat);
+	} else
 		cgroup_file_notify(wsr->page_age_cgroup_file);
 }
+
+void wsr_register_receiver(struct wsr_receiver *receiver,
+			   struct pglist_data *pgdat)
+{
+	struct wsr_state *wsr = &receiver->wsr;
+
+	mutex_lock(&pgdat->wsr_receiver_mutex);
+	list_add_tail(&receiver->list, &pgdat->wsr_receiver_list);
+	mutex_unlock(&pgdat->wsr_receiver_mutex);
+
+	if (!!wsr->page_age && READ_ONCE(wsr->refresh_interval))
+		wsr_wakeup_aging_thread();
+}
+EXPORT_SYMBOL(wsr_register_receiver);
+
+void wsr_remove_receiver(struct wsr_receiver *receiver,
+			 struct pglist_data *pgdat)
+{
+	mutex_lock(&pgdat->wsr_receiver_mutex);
+	list_del(&receiver->list);
+	mutex_unlock(&pgdat->wsr_receiver_mutex);
+}
+EXPORT_SYMBOL(wsr_remove_receiver);
-- 
2.47.0.338.g60cca15819-goog


