Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A194E8CE5
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 06:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237954AbiC1ECc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 00:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbiC1ECI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 00:02:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C214614E
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Mar 2022 21:00:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso9979829ybs.20
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Mar 2022 21:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=k8RlhR5dEgJLGjW4yFVtOJleq5JuOCb1/y10OuMAwrQ=;
        b=B1osyKWvT/lAn6G/kwOvDadVPh3bKb1polWzy5qD913Fa99I5ylb7BbRN8Y29Q6uFJ
         ndWR/Nm1rC0iyNxozOmiiFnUvsjLtsrKn2xvW1IXlHHPrPuW1R8bdOc8rP3BXtqVJ26U
         oWVLPY8nQHtCddD45cd0H4rYVGAsg2vdv/p45uMM3Ovqa7Ezkl0xNXZEJazqQ561220N
         OejV/7D4wCc9oF5ouE7LC/8fY1Pdv5MrY9ec+8E8Yqur4W5fZ/71bxPZLOW2FsQDP+Sg
         dyTiOEXDLp3U/qelMHV2JHODUvKqTexwZ61Ezh7IIZQs2wcV7q9t2+UsAa5W4615IUvI
         U0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=k8RlhR5dEgJLGjW4yFVtOJleq5JuOCb1/y10OuMAwrQ=;
        b=mGWPSGjKIeiDGFq4TIcpn1nO/r9mIt3x0dstN75MXxfuSe4l+No4D/lM5oKBtQH2zL
         KDoittNZ7if030o399ZZCtFnft1aNhrSDlmdpMsrf+OGNuwlDSEcNg+Ri7umU+GaTovW
         r8WepasmZBjdq688n5fme66mqcjPeIE79btEcwZ0TnViKNXFKGsoX5FNDBWutTuAg8Wm
         Ijp+KdGXqq5vM1DWlgu3/AOkGjqlLDkaMHAPHZfdAJw/zcjcJBRfubj78LOxyVVqZI4d
         DRb8DmEqJfugez/Q0F7GLNWG3acF0P3Rqdcmd9cmj8G1HHae2YTrPPGdPUtpAY7ydAmP
         druA==
X-Gm-Message-State: AOAM532/SU2ZUU8j5ma11/S1eD+LrX4viDBeIYBBhbrWPfDhUes4KC5R
        cUPlXGK9VP8wA/YiuKcd8ykzXsrJ4A6t54w=
X-Google-Smtp-Source: ABdhPJwwGB0Iaw4om0iNQX4yoOe6OospAzb+qzxMY2GPvkPpo02gTGOtCyEPcLSkDzltKREZq7Lk4rHX6OpxfDk=
X-Received: from tj2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:187])
 (user=tjmercier job=sendgmr) by 2002:a25:26c4:0:b0:633:64d4:2b84 with SMTP id
 m187-20020a2526c4000000b0063364d42b84mr20415201ybm.428.1648440014432; Sun, 27
 Mar 2022 21:00:14 -0700 (PDT)
Date:   Mon, 28 Mar 2022 03:59:45 +0000
In-Reply-To: <20220328035951.1817417-1-tjmercier@google.com>
Message-Id: <20220328035951.1817417-7-tjmercier@google.com>
Mime-Version: 1.0
References: <20220328035951.1817417-1-tjmercier@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [RFC v4 6/8] binder: Add a buffer flag to relinquish ownership of fds
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kaleshsingh@google.com, Kenny.Ho@amd.com, mkoutny@suse.com,
        skhan@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Hridya Valsaraju <hridya@google.com>

This patch introduces a buffer flag BINDER_BUFFER_FLAG_SENDER_NO_NEED
that a process sending an fd array to another process over binder IPC
can set to relinquish ownership of the fds being sent for memory
accounting purposes. If the flag is found to be set during the fd array
translation and the fd is for a DMA-BUF, the buffer is uncharged from
the sender's cgroup and charged to the receiving process's cgroup
instead.

It is up to the sending process to ensure that it closes the fds
regardless of whether the transfer failed or succeeded.

Most graphics shared memory allocations in Android are done by the
graphics allocator HAL process. On requests from clients, the HAL process
allocates memory and sends the fds to the clients over binder IPC.
The graphics allocator HAL will not retain any references to the
buffers. When the HAL sets the BINDER_BUFFER_FLAG_SENDER_NO_NEED for fd
arrays holding DMA-BUF fds, the gpu cgroup controller will be able to
correctly charge the buffers to the client processes instead of the
graphics allocator HAL.

Since this is a new feature exposed to userspace, the kernel and userspace
must be compatible for the accounting to work for transfers. In all cases
the allocation and transport of DMA buffers via binder will succeed, but
only when both the kernel supports, and userspace depends on this feature
will the transfer accounting work. The possible scenarios are detailed
below:

1. new kernel + old userspace
The kernel supports the feature but userspace does not use it. The old
userspace won't mount the new cgroup controller, accounting is not
performed, charge is not transferred.

2. old kernel + new userspace
The new cgroup controller is not supported by the kernel, accounting is
not performed, charge is not transferred.

3. old kernel + old userspace
Same as #2

4. new kernel + new userspace
Cgroup is mounted, feature is supported and used.

Signed-off-by: Hridya Valsaraju <hridya@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>

---
v3 changes
Remove android from title per Todd Kjos.

Use more common dual author commit message format per John Stultz.

Include details on behavior for all combinations of kernel/userspace
versions in changelog (thanks Suren Baghdasaryan) per Greg Kroah-Hartman.

v2 changes
Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
heap to a single dma-buf function for all heaps per Daniel Vetter and
Christian K=C3=B6nig.
---
 drivers/android/binder.c            | 26 ++++++++++++++++++++++++++
 include/uapi/linux/android/binder.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8351c5638880..4357d2efc8e1 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -42,6 +42,7 @@
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
+#include <linux/dma-buf.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/freezer.h>
@@ -2482,8 +2483,10 @@ static int binder_translate_fd_array(struct list_hea=
d *pf_head,
 {
 	binder_size_t fdi, fd_buf_size;
 	binder_size_t fda_offset;
+	bool transfer_gpu_charge =3D false;
 	const void __user *sender_ufda_base;
 	struct binder_proc *proc =3D thread->proc;
+	struct binder_proc *target_proc =3D t->to_proc;
 	int ret;
=20
 	fd_buf_size =3D sizeof(u32) * fda->num_fds;
@@ -2521,8 +2524,15 @@ static int binder_translate_fd_array(struct list_hea=
d *pf_head,
 	if (ret)
 		return ret;
=20
+	if (IS_ENABLED(CONFIG_CGROUP_GPU) &&
+		parent->flags & BINDER_BUFFER_FLAG_SENDER_NO_NEED)
+		transfer_gpu_charge =3D true;
+
 	for (fdi =3D 0; fdi < fda->num_fds; fdi++) {
 		u32 fd;
+		struct dma_buf *dmabuf;
+		struct gpucg *gpucg;
+
 		binder_size_t offset =3D fda_offset + fdi * sizeof(fd);
 		binder_size_t sender_uoffset =3D fdi * sizeof(fd);
=20
@@ -2532,6 +2542,22 @@ static int binder_translate_fd_array(struct list_hea=
d *pf_head,
 						  in_reply_to);
 		if (ret)
 			return ret > 0 ? -EINVAL : ret;
+
+		if (!transfer_gpu_charge)
+			continue;
+
+		dmabuf =3D dma_buf_get(fd);
+		if (IS_ERR(dmabuf))
+			continue;
+
+		gpucg =3D gpucg_get(target_proc->tsk);
+		ret =3D dma_buf_transfer_charge(dmabuf, gpucg);
+		if (ret) {
+			pr_warn("%d:%d Unable to transfer DMA-BUF fd charge to %d",
+				proc->pid, thread->pid, target_proc->pid);
+			gpucg_put(gpucg);
+		}
+		dma_buf_put(dmabuf);
 	}
 	return 0;
 }
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/andro=
id/binder.h
index 3246f2c74696..169fd5069a1a 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -137,6 +137,7 @@ struct binder_buffer_object {
=20
 enum {
 	BINDER_BUFFER_FLAG_HAS_PARENT =3D 0x01,
+	BINDER_BUFFER_FLAG_SENDER_NO_NEED =3D 0x02,
 };
=20
 /* struct binder_fd_array_object - object describing an array of fds in a =
buffer
--=20
2.35.1.1021.g381101b075-goog

