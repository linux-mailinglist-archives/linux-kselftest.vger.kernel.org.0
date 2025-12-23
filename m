Return-Path: <linux-kselftest+bounces-47931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D59AECD9EC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A771E3037511
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBBB274B2B;
	Tue, 23 Dec 2025 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X9xp9T2j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ABD318151
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506708; cv=none; b=Pjce9bVXHbX5MW+73KAUZ6oJDqW4tkKkCWg1Roz7nSpOiD0GliOUi/wCt6Rl1BtH80XLruV2nRzRHxumVYqSYgTsn/Cqj5hKj/fBESKx4UXvmvJTLd8Ruk+i+7R2dre5TJXcagQbSYWLd1rDgWEzYMG/jnshk3tjLxpkl6kLlf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506708; c=relaxed/simple;
	bh=5MbTezqVniVMWrWPh/jzCyIi8y2s09KemMIahGqctog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tKvJ8fmIwzRSmyL4mK8rD+eLRr243bQnzPfQCPbpNYyCoWMUIs52/3Pqi72Y9EympVBnRkulybZOfPVIiyMujpxUl88mAJxpgulzDwzyHcYNTojvpGnDRfpFOF6N3+ppzmX5oAqAL4+dO0iIVYs61KpxIE8xsq5ovakbmZrtq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X9xp9T2j; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-43100a07eb1so2703940f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 08:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766506705; x=1767111505; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R8qAbifDARtNQH6///Cfz2Z6dr98BHzjmVALCF1UKvo=;
        b=X9xp9T2jhsv063FNnaVSB9Fs/hlioAXGiPXM3LX0I9WTnd6IxmteV8yE7rY0OjbldY
         5E3RLjxDprMN73J4+PPGwbx3cXuwFAzwrUQA7hh7FVumoDon0BLHMBksXCtmXbEOzMTO
         2+vphi9MxoKUD+Wttk27IzriVTYsHIkYKTSHeIXS4XC5eIofiAkqWac1ygFioj1xF10V
         IoPmefKfjvnUQoELn9z0Aj1Igx7WBvoqo5CX1Btvu163wvwCDdDBUtqOIC+s2sZKvdxk
         8UdctF42MH1lttXqqIJICzOLry//NOM4Tq5emTx0rs52tUiLNh3iGgJXOoGun/pvmHKq
         qy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766506705; x=1767111505;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8qAbifDARtNQH6///Cfz2Z6dr98BHzjmVALCF1UKvo=;
        b=hq+IqR6QMysgQ6E/PXTcY2k0OJhQMIXSMstBX/f5+ewV0ZJva2/p7XU4DlG5T6obyX
         HvhxOPmnmBlX4qKULxtGT8xnfhb6eUcbEKe82EUIjK+ZVNtQ/Ue+VFyAar/JjWPuLaf9
         qT3FcJClbeCPEtm0Iv5aGIFyvmyhhjfj5OvBGsISi0bqf+xSo6L8OeyPGHUsq0z/Jo3T
         SzpmZuMxVC8s9bguIGAVcIYz6+rIZl445ic9uqBs64vzLz6QH0aal3UBDmiSXaKvgzdt
         b6m8Jl4Hzlj9EFo/vBVX8CmYKT7we6COAA/AD7zNznn3qXwqRdqzPfYDJcLjS2KmOcdQ
         uxfA==
X-Gm-Message-State: AOJu0Yy98ljlGPXqBlIFmrTI1EzoHV340By5bLqZzLLJOz2zs6LR7ap1
	jaaKU0ZuFL4Fxfd7p0W1GhbVkGWINWYt4WnW6YmtumtrI1ey6yx7eedYqLuVcx+IGyklzcxSZ2s
	BBiys9woif5rAwQ==
X-Google-Smtp-Source: AGHT+IE8oDnfqXf51PXB9j7+xWXr487pSfiP2TuENwnOyxXdASQaxwRWlpWlqrTmlw8rYWPUrC2vEA5s/m4GpQ==
X-Received: from wrbfu10.prod.google.com ([2002:a05:6000:25ea:b0:42f:b7f1:749e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f54:0:b0:431:907:f307 with SMTP id ffacd0b85a97d-4324e506ab1mr15076109f8f.48.1766506705229;
 Tue, 23 Dec 2025 08:18:25 -0800 (PST)
Date: Tue, 23 Dec 2025 16:18:11 +0000
In-Reply-To: <20251223-b4-kunit-user-alloc-v1-0-fb910ae0e50c@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251223-b4-kunit-user-alloc-v1-0-fb910ae0e50c@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20251223-b4-kunit-user-alloc-v1-2-fb910ae0e50c@google.com>
Subject: [PATCH 2/3] kthread: Add kthread_take_mm()
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <raemoar63@gmail.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

lib/kunit/user_alloc.c currently uses kthread_use_mm() without a
corresponding kthread_unuse_mm(). This is a bug, but fixing it in KUnit
makes writing tests that use mms more difficult, because of KUnit's
resource/try-catch model.

Therefore, introduce a new operation that does what kunit_attach_mm()
wants, namely an unbalanced call with cleanup deferred to
kthread_exit().

This is actually just the same as kthread_use_mm() but without taking a
reference on the mm_struct.

While adding this, clarify the reference returned by mm_alloc(), since
that is what kthread_take_mm() is gonna be paired with, in practice.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/kthread.h |  1 +
 kernel/fork.c           |  3 ++-
 kernel/kthread.c        | 36 +++++++++++++++++++++++++++---------
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 8d27403888ce9..2e6244d8ff1a3 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -259,6 +259,7 @@ bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *work);
 
 void kthread_destroy_worker(struct kthread_worker *worker);
 
+void kthread_take_mm(struct mm_struct *mm);
 void kthread_use_mm(struct mm_struct *mm);
 void kthread_unuse_mm(struct mm_struct *mm);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index b1f3915d5f8ec..761e6232ea75a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1147,7 +1147,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 }
 
 /*
- * Allocate and initialize an mm_struct.
+ * Allocate and initialize an mm_struct. The caller gets a single reference to
+ * the mm's address space, which should be released with a call to mmput().
  */
 struct mm_struct *mm_alloc(void)
 {
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 99a3808d086f0..c660c04a1b627 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1589,10 +1589,16 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 EXPORT_SYMBOL(kthread_destroy_worker);
 
 /**
- * kthread_use_mm - make the calling kthread operate on an address space
+ * kthread_take_mm - make the calling kthread own an address space.
+ *
+ * Unlike kthread_use_mm(), this doesn't have a cleanup, instead that happens
+ * automatically on kthread exit. Correspondingly, it does not take any
+ * references, by calling this function you donate your reference to the address
+ * space (from mmget()/mm_users).
+ *
  * @mm: address space to operate on
  */
-void kthread_use_mm(struct mm_struct *mm)
+void kthread_take_mm(struct mm_struct *mm)
 {
 	struct mm_struct *active_mm;
 	struct task_struct *tsk = current;
@@ -1600,13 +1606,6 @@ void kthread_use_mm(struct mm_struct *mm)
 	WARN_ON_ONCE(!(tsk->flags & PF_KTHREAD));
 	WARN_ON_ONCE(tsk->mm);
 
-	/*
-	 * It is possible for mm to be the same as tsk->active_mm, but
-	 * we must still mmgrab(mm) and mmdrop_lazy_tlb(active_mm),
-	 * because these references are not equivalent.
-	 */
-	mmgrab(mm);
-
 	task_lock(tsk);
 	/* Hold off tlb flush IPIs while switching mm's */
 	local_irq_disable();
@@ -1632,6 +1631,25 @@ void kthread_use_mm(struct mm_struct *mm)
 	 */
 	mmdrop_lazy_tlb(active_mm);
 }
+EXPORT_SYMBOL_GPL(kthread_take_mm);
+
+/**
+ * kthread_use_mm - make the calling kthread operate on an address space.
+ *
+ * This must be paired with a call to kthread_unuse_mm().
+ *
+ * @mm: address space to operate on
+ */
+void kthread_use_mm(struct mm_struct *mm)
+{
+	/*
+	 * It is possible for mm to be the same as tsk->active_mm, but we must
+	 * still mmgrab(mm) and mmdrop_lazy_tlb(active_mm) (in
+	 * kthread_take_mm()), because these references are not equivalent.
+	 */
+	mmgrab(mm);
+	kthread_take_mm(mm);
+}
 EXPORT_SYMBOL_GPL(kthread_use_mm);
 
 /**

-- 
2.51.2


