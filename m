Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216484E8CF2
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 06:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiC1ECt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 00:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiC1ECH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 00:02:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1147945AC1
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Mar 2022 21:00:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e643f85922so108808877b3.2
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Mar 2022 21:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=5yVgehYPp/D4TvQwla1lP4QXTd3no9VslKN9O7AQtMc=;
        b=PhhJHuDY8p3QcagPQvPZS3gUNE+WTXGwsjHGcy5vYWAnTDsBi689RrlHpX0zFrkeeB
         cgq7zsJvQ4TmXMK1FTpCqUW7u3lra5MV6nGauGeFVJDPCVrWmnkHjOmwhDdU+M7H3MZe
         9q35JQxGebLqH5/ONPtCo4HXNZx4OcvVXTYpNkTBV6/yAbNgaRVy5ssOv6jFVcFkP4kh
         c6sqXcTOyO3FaJ9kpa11O5JJElojJYBxTFCpnde1aJSzeINLr01Z2GHiUlyp+D3vIicZ
         9yFl6rYahM5JoO00jsPYyoSQwu+mCGj11q2ksSeUHehSTH8F0UI4LYMgOKHBkHzbM5kw
         cvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=5yVgehYPp/D4TvQwla1lP4QXTd3no9VslKN9O7AQtMc=;
        b=XMkXHCALkgBHRbyW1gdKVfvqdUURL+knVyZLrExPAnclPXPcCR0/AJBVeaIOFCCw+T
         67s+X/n8Df1+ffbShDeWs1+MUivxlG2MFdGYPTT69G4PEVw2X76YTSXdkOkj9QDkWqNG
         CAxB+ZfZafaxPas6LoNZ8WQvTt7JF7RfRMgLPZ1tRIlFTNxKBznUQ8Hnvc8H9GnPt1ex
         e06KZvxz8HXVTifCJ74+1WvSzM1lZjYm79CN1zo3EdJGnHc+z6h8qKjQjkNFnr+2QZfQ
         pcVjdEmAdb7DIRlLgZg8HKzYEEO36a5kzSw76+RVjJWxBWuYuRoYHWoGDKxa4a2VsjJI
         nlXQ==
X-Gm-Message-State: AOAM5308W9JZixhF8jm3FGthVoyHySZlcwOEyBOWRW6XpCj5ru1z03Er
        zTHTzZinhLTh1wmyLEykTDQh2mrglOoMXiw=
X-Google-Smtp-Source: ABdhPJys0sTPrji6EjHujuYz082iO9ggsvoNSm4OdxVncyEN7gJkiqTrwHhvJvo9vVVIk7aJX3q2Povqc86sLs4=
X-Received: from tj2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:187])
 (user=tjmercier job=sendgmr) by 2002:a25:bdd3:0:b0:635:eaaf:53 with SMTP id
 g19-20020a25bdd3000000b00635eaaf0053mr20426308ybk.74.1648440008833; Sun, 27
 Mar 2022 21:00:08 -0700 (PDT)
Date:   Mon, 28 Mar 2022 03:59:43 +0000
In-Reply-To: <20220328035951.1817417-1-tjmercier@google.com>
Message-Id: <20220328035951.1817417-5-tjmercier@google.com>
Mime-Version: 1.0
References: <20220328035951.1817417-1-tjmercier@google.com>
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [RFC v4 4/8] dmabuf: heaps: export system_heap buffers with GPU
 cgroup charging
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

All DMA heaps now register a new GPU cgroup device upon creation, and the
system_heap now exports buffers associated with its GPU cgroup device for
tracking purposes.

Signed-off-by: Hridya Valsaraju <hridya@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>

---
v3 changes
Use more common dual author commit message format per John Stultz.

v2 changes
Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
heap to a single dma-buf function for all heaps per Daniel Vetter and
Christian K=C3=B6nig.
---
 drivers/dma-buf/dma-heap.c          | 27 +++++++++++++++++++++++++++
 drivers/dma-buf/heaps/system_heap.c |  3 +++
 include/linux/dma-heap.h            | 11 +++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 8f5848aa144f..885072427775 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -7,6 +7,7 @@
  */
=20
 #include <linux/cdev.h>
+#include <linux/cgroup_gpu.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
@@ -31,6 +32,7 @@
  * @heap_devt		heap device node
  * @list		list head connecting to list of heaps
  * @heap_cdev		heap char device
+ * @gpucg_dev		gpu cgroup device for memory accounting
  *
  * Represents a heap of memory from which buffers can be made.
  */
@@ -41,6 +43,9 @@ struct dma_heap {
 	dev_t heap_devt;
 	struct list_head list;
 	struct cdev heap_cdev;
+#ifdef CONFIG_CGROUP_GPU
+	struct gpucg_device gpucg_dev;
+#endif
 };
=20
 static LIST_HEAD(heap_list);
@@ -216,6 +221,26 @@ const char *dma_heap_get_name(struct dma_heap *heap)
 	return heap->name;
 }
=20
+#ifdef CONFIG_CGROUP_GPU
+/**
+ * dma_heap_get_gpucg_dev() - get struct gpucg_device for the heap.
+ * @heap: DMA-Heap to get the gpucg_device struct for.
+ *
+ * Returns:
+ * The gpucg_device struct for the heap. NULL if the GPU cgroup controller=
 is
+ * not enabled.
+ */
+struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap)
+{
+	return &heap->gpucg_dev;
+}
+#else /* CONFIG_CGROUP_GPU */
+struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap)
+{
+	return NULL;
+}
+#endif /* CONFIG_CGROUP_GPU */
+
 struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 {
 	struct dma_heap *heap, *h, *err_ret;
@@ -288,6 +313,8 @@ struct dma_heap *dma_heap_add(const struct dma_heap_exp=
ort_info *exp_info)
 	list_add(&heap->list, &heap_list);
 	mutex_unlock(&heap_list_lock);
=20
+	gpucg_register_device(dma_heap_get_gpucg_dev(heap), exp_info->name);
+
 	return heap;
=20
 err2:
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/sy=
stem_heap.c
index ab7fd896d2c4..752a05c3cfe2 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -395,6 +395,9 @@ static struct dma_buf *system_heap_allocate(struct dma_=
heap *heap,
 	exp_info.ops =3D &system_heap_buf_ops;
 	exp_info.size =3D buffer->len;
 	exp_info.flags =3D fd_flags;
+#ifdef CONFIG_CGROUP_GPU
+	exp_info.gpucg_dev =3D dma_heap_get_gpucg_dev(heap);
+#endif
 	exp_info.priv =3D buffer;
 	dmabuf =3D dma_buf_export(&exp_info);
 	if (IS_ERR(dmabuf)) {
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 0c05561cad6e..e447a61d054e 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -10,6 +10,7 @@
 #define _DMA_HEAPS_H
=20
 #include <linux/cdev.h>
+#include <linux/cgroup_gpu.h>
 #include <linux/types.h>
=20
 struct dma_heap;
@@ -59,6 +60,16 @@ void *dma_heap_get_drvdata(struct dma_heap *heap);
  */
 const char *dma_heap_get_name(struct dma_heap *heap);
=20
+/**
+ * dma_heap_get_gpucg_dev() - get a pointer to the struct gpucg_device for=
 the
+ * heap.
+ * @heap: DMA-Heap to retrieve gpucg_device for.
+ *
+ * Returns:
+ * The gpucg_device struct for the heap.
+ */
+struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap);
+
 /**
  * dma_heap_add - adds a heap to dmabuf heaps
  * @exp_info:		information needed to register this heap
--=20
2.35.1.1021.g381101b075-goog

