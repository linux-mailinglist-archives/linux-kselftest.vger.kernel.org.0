Return-Path: <linux-kselftest+bounces-46963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A7FCA203E
	for <lists+linux-kselftest@lfdr.de>; Thu, 04 Dec 2025 01:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5791E300ACC5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Dec 2025 00:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B008834;
	Thu,  4 Dec 2025 00:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJrWGvgF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFF2125B2
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Dec 2025 00:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764806722; cv=none; b=nAwBhl/7dPcfBBpXxLJTdLtQjBl69jNYeDb+vj3JBpCsyjUwP0OqEWkJo095V00B/SpA6JjuopUa4m0bP3fDi2aPnVjcD2q4fgAg95fu6LpXTCByeqehcdlBsCIvc4GHT84Myd9QxuOCZnYz7Y3KT09KoI6pnKP4ydplSjGp0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764806722; c=relaxed/simple;
	bh=Ng2mAL+3jbbmbK2kdWqTVXksLagXb5kbG5DAQ3Lamwo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NhkNaYxXAyZ3WxrmRmiawuvSCitubY+9JUUivdPh0VVPxi6Z793yBKpkxArGJIJ7gG+TnrmcOnhW9qqumKOJoEP92UPWNvGZf2xt2aPIC990ixb1rNUiW3Y/AcqgMHDBn+xlTIL+bBd6TWnsH3qeM0uwZpc2QbBJA/W6zk0DMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fJrWGvgF; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29b760316a8so4651755ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 16:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764806720; x=1765411520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tG99E2G74NBlCqMFEbuJyuFU682bdGjo6IlyusySJck=;
        b=fJrWGvgFndxNAVZtqHcyVqORi0lZgFmg2RoMxlGwmkVMrZQdthVaYR1hFC6Ly5dzQP
         /O334Uc9hzQbXTaBJBDQpxUV8fClAuQyV+mSvhXft49O5xvrscyOD0tIVtaeER892oz/
         bCrMwusGyc1YxMFNHWfEpA9kvAeVWAG+8WlcWq+/ksmsqkeTuAVDfFQDRKFGmuzsJBvL
         e9UvbzJE/bDfImjPR7c25dS1Wf0t60WB+zUp053+8sdPqxIeXAnUJRwMDmfuuPRk9kh4
         GnB/l58IokpUZO1K7nsuloIUNbGVR2Ys4IGebn4jXvNZI9iXbbkOpBftOM93oV8woYmW
         ZBfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764806720; x=1765411520;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tG99E2G74NBlCqMFEbuJyuFU682bdGjo6IlyusySJck=;
        b=UFRCxslI0lxfrHkTQ/quzDcME3M23rU8RrmtLOql3ov73oEZpYV0j5hXuAaU0hKli+
         aaeqYXRYgY8bBDzeoNvgC9ou0rDxGgqjsfv4YR2HOQUS9ormMsc3tSJnWg6cPjMeF9bS
         00k3Of1E19sMFbM4tvDrRYG6D0B07dBndYIKOlO8TBPGXksvu44wUTSLZKLTu1lDCB4F
         gnEOzVaaEuebc59jujxzY/f477TWcASz9JxTd3kIG8Ru6T9AknRFOhHJSjiqaUwqcsj1
         tLDhPGyrhrg3WVCbVuMBSNIgczYEVYmgTopupMnA14IbX7swuyB01jg2TSlIQf+rsH7f
         7J5A==
X-Forwarded-Encrypted: i=1; AJvYcCV9+eEfE/takS4wLt0Q5LEgqrdb7BSc0fNe6BCW1G6/wgGlk5DLO4tmXmwAv/0G/G502Lyf26L1Os49M/Bi8yY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDFlIgvU+x3RwYJr4cYzZBXY1ST4T1lvNf/4xeJXCiTPtzS8Kr
	ibLHam2s67RglZdPp6l6Tq7o4A525doOHRTrNuGns+XZHW0OSCHAwb7PsL2Re3xnl0G/w0l/3L8
	e0OOUc2klAvExooOkrA==
X-Google-Smtp-Source: AGHT+IGeC714EhBu/T29Z7FIKq0MljnotPa6j758d1YJabmaYRlvO/lv9fc69gFjzEtkHLe56aPYXjQBQYBtJtQ=
X-Received: from plbbb9.prod.google.com ([2002:a17:902:bc89:b0:29d:5afa:2c4])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e943:b0:296:5ea8:ed7c with SMTP id d9443c01a7336-29d68344bf3mr55170825ad.17.1764806720435;
 Wed, 03 Dec 2025 16:05:20 -0800 (PST)
Date: Wed,  3 Dec 2025 16:03:47 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251204000348.1413593-1-tjmercier@google.com>
Subject: [PATCH bpf 1/2] bpf: Fix truncated dmabuf iterator reads
From: "T.J. Mercier" <tjmercier@google.com>
To: yonghong.song@linux.dev, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	android-mm@google.com
Cc: christian.koenig@amd.com, sumit.semwal@linaro.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"

If there is a large number (hundreds) of dmabufs allocated, the text
output generated from dmabuf_iter_seq_show can exceed common user buffer
sizes (e.g. PAGE_SIZE) necessitating multiple start/stop cycles to
iterate through all dmabufs. However the dmabuf iterator currently
returns NULL in dmabuf_iter_seq_start for all non-zero pos values, which
results in the truncation of the output before all dmabufs are handled.

After dma_buf_iter_begin / dma_buf_iter_next, the refcount of the buffer
is elevated so that the BPF iterator program can run without holding any
locks. When a stop occurs, instead of immediately dropping the reference
on the buffer, stash a pointer to the buffer in seq->priv until
either start is called or the iterator is released. This also enables
the resumption of iteration without first walking through the list of
dmabufs based on the pos value.

Fixes: 76ea95534995 ("bpf: Add dmabuf iterator")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 kernel/bpf/dmabuf_iter.c | 56 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/dmabuf_iter.c b/kernel/bpf/dmabuf_iter.c
index 4dd7ef7c145c..cd500248abd9 100644
--- a/kernel/bpf/dmabuf_iter.c
+++ b/kernel/bpf/dmabuf_iter.c
@@ -6,10 +6,33 @@
 #include <linux/kernel.h>
 #include <linux/seq_file.h>
 
+struct dmabuf_iter_priv {
+	/*
+	 * If this pointer is non-NULL, the buffer's refcount is elevated to
+	 * prevent destruction between stop/start. If reading is not resumed and
+	 * start is never called again, then dmabuf_iter_seq_fini drops the
+	 * reference when the iterator is released.
+	 */
+	struct dma_buf *dmabuf;
+};
+
 static void *dmabuf_iter_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	if (*pos)
-		return NULL;
+	struct dmabuf_iter_priv *p = seq->private;
+
+	if (*pos) {
+		struct dma_buf *dmabuf = p->dmabuf;
+
+		if (!dmabuf)
+			return NULL;
+
+		/*
+		 * Always resume from where we stopped, regardless of the value
+		 * of pos.
+		 */
+		p->dmabuf = NULL;
+		return dmabuf;
+	}
 
 	return dma_buf_iter_begin();
 }
@@ -54,8 +77,11 @@ static void dmabuf_iter_seq_stop(struct seq_file *seq, void *v)
 {
 	struct dma_buf *dmabuf = v;
 
-	if (dmabuf)
-		dma_buf_put(dmabuf);
+	if (dmabuf) {
+		struct dmabuf_iter_priv *p = seq->private;
+
+		p->dmabuf = dmabuf;
+	}
 }
 
 static const struct seq_operations dmabuf_iter_seq_ops = {
@@ -71,11 +97,27 @@ static void bpf_iter_dmabuf_show_fdinfo(const struct bpf_iter_aux_info *aux,
 	seq_puts(seq, "dmabuf iter\n");
 }
 
+static int dmabuf_iter_seq_init(void *priv, struct bpf_iter_aux_info *aux)
+{
+	struct dmabuf_iter_priv *p = (struct dmabuf_iter_priv *)priv;
+
+	p->dmabuf = NULL;
+	return 0;
+}
+
+static void dmabuf_iter_seq_fini(void *priv)
+{
+	struct dmabuf_iter_priv *p = (struct dmabuf_iter_priv *)priv;
+
+	if (p->dmabuf)
+		dma_buf_put(p->dmabuf);
+}
+
 static const struct bpf_iter_seq_info dmabuf_iter_seq_info = {
 	.seq_ops		= &dmabuf_iter_seq_ops,
-	.init_seq_private	= NULL,
-	.fini_seq_private	= NULL,
-	.seq_priv_size		= 0,
+	.init_seq_private	= dmabuf_iter_seq_init,
+	.fini_seq_private	= dmabuf_iter_seq_fini,
+	.seq_priv_size		= sizeof(struct dmabuf_iter_priv),
 };
 
 static struct bpf_iter_reg bpf_dmabuf_reg_info = {

base-commit: 30f09200cc4aefbd8385b01e41bde2e4565a6f0e
-- 
2.52.0.177.g9f829587af-goog


