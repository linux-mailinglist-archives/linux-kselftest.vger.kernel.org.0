Return-Path: <linux-kselftest+bounces-37402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4644EB06BF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 05:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C1E177CFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jul 2025 03:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732F9287269;
	Wed, 16 Jul 2025 03:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+6l719B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4677286D5E
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Jul 2025 03:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635175; cv=none; b=tMc/4vjy/Jr5NE025BzLU5kmgw1IzkKVkDcZmWHjYv0mlca/LgpMocuWoTNZWFOiIKB5Yb0ULHgNIwW3ijmuEMKhoMoHaV7iwAxH6ozTgfE145ki5ltzgVfiiYcKMcFlLbWdBAbf3ZtWBYJV7rOWbOpIQAt1WZ0dYk+RFc4DIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635175; c=relaxed/simple;
	bh=yvEdgs2nXUWjdMl9gW7ScSBLyyxJCqlOM9mBp2BycIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KaJfwpg4ukVbNw8+2ENVVqSLNVzWHO0sWhFl2VM7OjtrmKdZ1JeNI6iwVzbStRL2LmtdjusND0KvXk/wNkLC0abPN/7GVyYpCR5dpSaD20Y5rjuy2x59wAuw+5cDuC/UHDGijaOjoxnb9LtKGixM9Bad/Ng52l1hd7Gb7zbA/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+6l719B; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-315af08594fso6510171a91.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Jul 2025 20:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752635173; x=1753239973; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJyiXrcxEaOrLnExvfxF4iaGO8N7lUzqsD5ouhDVNBI=;
        b=P+6l719BHTkQKALHa9oefQGZyU70dYLR0NIgwJzdpVf+dR/f1xEoAP1/9fkm9+uQNH
         AjAxSZIh3vqEAPa221rbuTgbf7Dpmt82q4UcNcOG/QmXynirBSevD0pTY2W8F1UvepZO
         ajJTEmhxAPL59aKZYZCfAi9OVQ+rJ1kD0udEOIfaDDsKuStDf2obYqoPTTQz5loz8oys
         ZT+L7fQDiyHAT2D08T5GvA9Yw/TSGLTjG55n3/hnUoNT6FHlrs1DDP9Op7AAWKdzOLJ8
         sfK8mo94+ikN6d38Jd1TLD/QXAGFMEb8ouxiu34BYf1s5zG4KY/Q/Dlvl3PI/3XuV4X/
         9Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635173; x=1753239973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JJyiXrcxEaOrLnExvfxF4iaGO8N7lUzqsD5ouhDVNBI=;
        b=dIv+sK2nJbXkBDCE0zH8B8I4fNmWcVkdBY5hFkt6WvWhWhfygmVKY95LxRqAjLJCxC
         jm2PHWWwm4tf6LKwHfvOVVRYPpp30lyIuRYDEI4/+fJ4lU0jP0/jl5wE5CEI0Mb2ZlYy
         A2wSIk8KRFUPWUidhUnbq7hcuD2l25wfRUvX7ZfBiOg2M+g478IIgWHork0ixYRgErXu
         lQMmBRdnHqdL3ARkQ88/ZClKACuinKfUXVXYRCB9SfTRqq8omRzuCG3y+dBga1AMLwTA
         2wrYgTal58X2ygswwqKeHJDs/R3rFWk5XkKwdMmjuA7mFmSqizlEpo2LTSz+A7h5yLgP
         Jxxg==
X-Forwarded-Encrypted: i=1; AJvYcCVXRQdPJ/+oYI9nUYDL7DmqjqSX84Ea0C5CJt/VDhnN/oW5qS5AXDLp4DZg1tdf1PSkjdUbJJ0ygoUULhpnGGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1DAJqiDNodvdoTWXhmJFEa+1BpNeMlCB7t93Unu+g9n4IeCZj
	VH1Ki/VtEXPUOkwZPGE0mAxW+s2wdR8YodAFMAlTO/nLkZPbyotjWNcF9iQRHoqFFdMAvUJjcrk
	ceunbLA==
X-Google-Smtp-Source: AGHT+IFDGwwmBom5R3AeCsNrmsJsGaDmKZ6nwxto47OpXfv54XBWKzi5o3ZDO8E9HG9YurznkyjmKbtvlxI=
X-Received: from pjg12.prod.google.com ([2002:a17:90b:3f4c:b0:312:df0e:5f09])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1fc3:b0:30c:540b:9ba
 with SMTP id 98e67ed59e1d1-31c9f44bc2dmr1486650a91.10.1752635173229; Tue, 15
 Jul 2025 20:06:13 -0700 (PDT)
Date: Tue, 15 Jul 2025 20:05:55 -0700
In-Reply-To: <20250716030557.1547501-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716030557.1547501-1-surenb@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716030557.1547501-7-surenb@google.com>
Subject: [PATCH v7 6/7] fs/proc/task_mmu: remove conversion of seq_file
 position to unsigned
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Back in 2.6 era, last_addr used to be stored in seq_file->version
variable, which was unsigned long. As a result, sentinels to represent
gate vma and end of all vmas used unsigned values. In more recent
kernels we don't used seq_file->version anymore and therefore conversion
from loff_t into unsigned type is not needed. Similarly, sentinel values
don't need to be unsigned. Remove type conversion for set_file position
and change sentinel values to signed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/proc/task_mmu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 751479eb128f..b8bc06d05a72 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -135,7 +135,7 @@ static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
 	if (vma) {
 		*ppos = vma->vm_start;
 	} else {
-		*ppos = -2UL;
+		*ppos = -2;
 		vma = get_gate_vma(priv->mm);
 	}
 
@@ -145,11 +145,11 @@ static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
 static void *m_start(struct seq_file *m, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
-	unsigned long last_addr = *ppos;
+	loff_t last_addr = *ppos;
 	struct mm_struct *mm;
 
 	/* See m_next(). Zero at the start or after lseek. */
-	if (last_addr == -1UL)
+	if (last_addr == -1)
 		return NULL;
 
 	priv->task = get_proc_task(priv->inode);
@@ -170,9 +170,9 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 		return ERR_PTR(-EINTR);
 	}
 
-	vma_iter_init(&priv->iter, mm, last_addr);
+	vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
 	hold_task_mempolicy(priv);
-	if (last_addr == -2UL)
+	if (last_addr == -2)
 		return get_gate_vma(mm);
 
 	return proc_get_vma(priv, ppos);
@@ -180,8 +180,8 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
-	if (*ppos == -2UL) {
-		*ppos = -1UL;
+	if (*ppos == -2) {
+		*ppos = -1;
 		return NULL;
 	}
 	return proc_get_vma(m->private, ppos);
-- 
2.50.0.727.gbf7dc18ff4-goog


