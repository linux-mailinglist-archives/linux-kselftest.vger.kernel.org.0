Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237204D371D
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 18:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237449AbiCIRFg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 12:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbiCIREO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 12:04:14 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF41C19E0B6
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 08:53:01 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc44b6dc9dso18781897b3.23
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Mar 2022 08:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=V8vMjTnKNpMlnc7JqoQhhcwCYCICGfVTjA11ueJBqJY=;
        b=HPhBJpTBiJVYDhNj0DZQIrh2V35TDbkma5Iio+WXF/hcMekPxUMRND2g0CCX8In7eA
         LEUpnnJ+An6CQt91VMdWJ16FK8gQvFAyqTsa5rlG5AWdns4o+hy7+0OojxnhgPcTuenF
         BMnLv3wL46KC+ysjzZ76R5d/tGOpuWkWCWCPvMAfXwR0a5KK3XjpjLwL9pQFigkgD89h
         UfwDU4EeBZ+AuUjNHIDB5TQ3ZOrtGFi86NY5EeNgywb7PE5VH443fnkWqKIiup1Y0udy
         R7MVYYHFJitKmNj3Z9u+ZFiGhMd6bk7xZU88I9EiTT+qF25ldxx/Q3auo1GI4V9pSZKP
         UyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=V8vMjTnKNpMlnc7JqoQhhcwCYCICGfVTjA11ueJBqJY=;
        b=mTVQvJZdBon8jSdomMrSnfmtaEXPDikmj6Edsb2lIVU40/FSJxR1VEUDHwQkkYb+6U
         mu8ETPK7qKsFFlDQtKHkFV0BWHPnVv7eDNawNbdAra/fVednl7nJ9lwosWwvTlcvEGpa
         221j3DZR+TzJikB5hOA7eROHvPDy9mzRoNQtGxGQrgQem0fpWSU3RsbGDpMNuvYyH/Jn
         xc1vJ2ZP5ZPgji7/vHJ9CrAw0t70PIXSNW2oN/gfW0O3R3EHs+2eM3txi4dmCqzFVMLy
         bAmziVDi34qlPsHt1hLDFFY6IVOh4NhJfjNeVYAATjEr/AfA0vZIm5hvxGFp5rdo2vii
         F09w==
X-Gm-Message-State: AOAM531TVrfWhdc0n8e1KFNA5NCUxEyiGkv4Fuo/Gh8dWKkOtWKXvTtK
        abAF6M4DTkNoTLoQd9HF5kKNz1jRyDgNtIg=
X-Google-Smtp-Source: ABdhPJz9YUAclnREKPfkUSw/YVlrcGlYfdaexMLMRAzjJT1CtoYDbmyjdA8pza54fHB/e3zequa24JlX1KWu3NI=
X-Received: from tj2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:187])
 (user=tjmercier job=sendgmr) by 2002:a81:38c6:0:b0:2d7:ee4f:797b with SMTP id
 f189-20020a8138c6000000b002d7ee4f797bmr650786ywa.14.1646844768454; Wed, 09
 Mar 2022 08:52:48 -0800 (PST)
Date:   Wed,  9 Mar 2022 16:52:15 +0000
In-Reply-To: <20220309165222.2843651-1-tjmercier@google.com>
Message-Id: <20220309165222.2843651-6-tjmercier@google.com>
Mime-Version: 1.0
References: <20220309165222.2843651-1-tjmercier@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [RFC v3 5/8] dmabuf: Add gpu cgroup charge transfer function
From:   "T.J. Mercier" <tjmercier@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
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
Cc:     kaleshsingh@google.com, Kenny.Ho@amd.com,
        "T.J. Mercier" <tjmercier@google.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
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

The dma_buf_charge_transfer function provides a way for processes to
transfer charge of a buffer to a different process. This is essential
for the cases where a central allocator process does allocations for
various subsystems, hands over the fd to the client who requested the
memory and drops all references to the allocated memory.

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
 drivers/dma-buf/dma-buf.c | 48 +++++++++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 83d0d1b91547..55e1b982f840 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1374,6 +1374,54 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct d=
ma_buf_map *map)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap, DMA_BUF);
=20
+/**
+ * dma_buf_charge_transfer - Change the GPU cgroup to which the provided d=
ma_buf
+ * is charged.
+ * @dmabuf:	[in]	buffer whose charge will be migrated to a different GPU
+ *			cgroup
+ * @gpucg:	[in]	the destination GPU cgroup for dmabuf's charge
+ *
+ * Only tasks that belong to the same cgroup the buffer is currently charg=
ed to
+ * may call this function, otherwise it will return -EPERM.
+ *
+ * Returns 0 on success, or a negative errno code otherwise.
+ */
+int dma_buf_charge_transfer(struct dma_buf *dmabuf, struct gpucg *gpucg)
+{
+#ifdef CONFIG_CGROUP_GPU
+	struct gpucg *current_gpucg;
+	int ret =3D 0;
+
+	/*
+	 * Verify that the cgroup of the process requesting the transfer is the
+	 * same as the one the buffer is currently charged to.
+	 */
+	current_gpucg =3D gpucg_get(current);
+	mutex_lock(&dmabuf->lock);
+	if (current_gpucg !=3D dmabuf->gpucg) {
+		ret =3D -EPERM;
+		goto err;
+	}
+
+	ret =3D gpucg_try_charge(gpucg, dmabuf->gpucg_dev, dmabuf->size);
+	if (ret)
+		goto err;
+
+	dmabuf->gpucg =3D gpucg;
+
+	/* uncharge the buffer from the cgroup it's currently charged to. */
+	gpucg_uncharge(current_gpucg, dmabuf->gpucg_dev, dmabuf->size);
+
+err:
+	mutex_unlock(&dmabuf->lock);
+	gpucg_put(current_gpucg);
+	return ret;
+#else
+	return 0;
+#endif /* CONFIG_CGROUP_GPU */
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_charge_transfer, DMA_BUF);
+
 #ifdef CONFIG_DEBUG_FS
 static int dma_buf_debug_show(struct seq_file *s, void *unused)
 {
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 742f29c3daaf..85c940c08867 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -646,4 +646,6 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struc=
t *,
 		 unsigned long);
 int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
 void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
+
+int dma_buf_charge_transfer(struct dma_buf *dmabuf, struct gpucg *gpucg);
 #endif /* __DMA_BUF_H__ */
--=20
2.35.1.616.g0bdcbb4464-goog

