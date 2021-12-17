Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A40A4789F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 12:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbhLQLc4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 06:32:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232164AbhLQLc4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 06:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639740775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IS+IADqtvjtFBPaIHjVHiY8W/A2A4twki8gtFJ6uWRE=;
        b=JBkJkSgAX+DODh0Uedw0PUlDo1VNrZBS7t5nhsbgp99lLWvO1TWDmcihugeHPDXIS32J82
        ClBGeDaInKKiv652xv00g0Z8cHLb4RJO7pIQzosMU42NR4L25OgpcrFT7BkzdIGLc7aDUK
        +79ovj6y9hFlyQxff7fPgkQZV+03B18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-ZvV_edXtN52r3-4io6P9Bg-1; Fri, 17 Dec 2021 06:32:52 -0500
X-MC-Unique: ZvV_edXtN52r3-4io6P9Bg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A280C185302A;
        Fri, 17 Dec 2021 11:32:48 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.204])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4A518CB3E;
        Fri, 17 Dec 2021 11:32:02 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v1 01/11] seqlock: provide lockdep-free raw_seqcount_t variant
Date:   Fri, 17 Dec 2021 12:30:39 +0100
Message-Id: <20211217113049.23850-2-david@redhat.com>
In-Reply-To: <20211217113049.23850-1-david@redhat.com>
References: <20211217113049.23850-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sometimes it is required to have a seqcount implementation that uses
a structure with a fixed and minimal size -- just a bare unsigned int --
independent of the kernel configuration. This is especially valuable, when
the raw_ variants of the seqlock function will be used and the additional
lockdep part of the seqcount_t structure remains essentially unused.

Let's provide a lockdep-free raw_seqcount_t variant that can be used via
the raw functions to have a basic seqlock.

The target use case is embedding a raw_seqcount_t in the "struct page",
where we really want a minimal size and cannot tolerate a sudden grow of
the seqcount_t structure resulting in a significant "struct page"
increase or even a layout change.

Provide raw_read_seqcount_retry(), to make it easy to match to
raw_read_seqcount_begin() in the code.

Let's add a short documentation as well.

Note: There might be other possible users for raw_seqcount_t where the
      lockdep part might be completely unused and just wastes memory --
      essentially any users that only use the raw_ function variants.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/locking/seqlock.rst |  50 +++++++++++
 include/linux/seqlock.h           | 145 +++++++++++++++++++++++-------
 2 files changed, 162 insertions(+), 33 deletions(-)

diff --git a/Documentation/locking/seqlock.rst b/Documentation/locking/seqlock.rst
index 64405e5da63e..6f66ae29cc07 100644
--- a/Documentation/locking/seqlock.rst
+++ b/Documentation/locking/seqlock.rst
@@ -87,6 +87,56 @@ Read path::
 	} while (read_seqcount_retry(&foo_seqcount, seq));
 
 
+Raw sequence counters (``raw_seqcount_t``)
+==========================================
+
+This is the raw counting mechanism, which does not protect against multiple
+writers and does not perform any lockdep tracking.  Write side critical sections
+must thus be serialized by an external lock.
+
+It is primary useful when a fixed, minimal sequence counter size is
+required and the lockdep overhead cannot be tolerated or is unused.
+Prefer using a :ref:`seqcount_t`, a :ref:`seqlock_t` or a
+:ref:`seqcount_locktype_t` if possible.
+
+The raw sequence counter is very similar to the :ref:`seqcount_t`, however,
+it can only be used with functions that don't perform any implicit lockdep
+tracking: primarily the *raw* function variants.
+
+Initialization::
+
+	/* dynamic */
+	raw_seqcount_t foo_seqcount;
+	raw_seqcount_init(&foo_seqcount);
+
+	/* static */
+	static raw_seqcount_t foo_seqcount = RAW_SEQCNT_ZERO(foo_seqcount);
+
+	/* C99 struct init */
+	struct {
+		.seq   = RAW_SEQCNT_ZERO(foo.seq),
+	} foo;
+
+Write path::
+
+	/* Serialized context with disabled preemption */
+
+	raw_write_seqcount_begin(&foo_seqcount);
+
+	/* ... [[write-side critical section]] ... */
+
+	raw_write_seqcount_end(&foo_seqcount);
+
+Read path::
+
+	do {
+		seq = raw_read_seqcount_begin(&foo_seqcount);
+
+		/* ... [[read-side critical section]] ... */
+
+	} while (raw_read_seqcount_retry(&foo_seqcount, seq));
+
+
 .. _seqcount_locktype_t:
 
 Sequence counters with associated locks (``seqcount_LOCKNAME_t``)
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 37ded6b8fee6..c61fba1f9893 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -60,15 +60,27 @@
  * serialization and non-preemptibility requirements, use a sequential
  * lock (seqlock_t) instead.
  *
+ * If it's undesired to have lockdep, especially when a fixed, minimal,
+ * structure size is required, use raw_seqcount_t along with the raw
+ * function variants.
+ *
  * See Documentation/locking/seqlock.rst
  */
+
+typedef unsigned int raw_seqcount_t;
+
 typedef struct seqcount {
-	unsigned sequence;
+	raw_seqcount_t sequence;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif
 } seqcount_t;
 
+static inline void __raw_seqcount_init(raw_seqcount_t *s)
+{
+	*s = 0;
+}
+
 static inline void __seqcount_init(seqcount_t *s, const char *name,
 					  struct lock_class_key *key)
 {
@@ -76,9 +88,15 @@ static inline void __seqcount_init(seqcount_t *s, const char *name,
 	 * Make sure we are not reinitializing a held lock:
 	 */
 	lockdep_init_map(&s->dep_map, name, key, 0);
-	s->sequence = 0;
+	__raw_seqcount_init(&s->sequence);
 }
 
+/**
+ * raw_seqcount_init() - runtime initializer for raw_seqcount_t
+ * @s: Pointer to the raw_seqcount_t instance
+ */
+# define raw_seqcount_init(s) __raw_seqcount_init(s)
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 # define SEQCOUNT_DEP_MAP_INIT(lockname)				\
@@ -111,11 +129,16 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
 # define seqcount_lockdep_reader_access(x)
 #endif
 
+/**
+ * RAW_SEQCNT_ZERO() - static initializer for raw_seqcount_t
+ */
+#define RAW_SEQCNT_ZERO() 0
+
 /**
  * SEQCNT_ZERO() - static initializer for seqcount_t
  * @name: Name of the seqcount_t instance
  */
-#define SEQCNT_ZERO(name) { .sequence = 0, SEQCOUNT_DEP_MAP_INIT(name) }
+#define SEQCNT_ZERO(name) { .sequence = RAW_SEQCNT_ZERO(), SEQCOUNT_DEP_MAP_INIT(name) }
 
 /*
  * Sequence counters with associated locks (seqcount_LOCKNAME_t)
@@ -203,6 +226,12 @@ typedef struct seqcount_##lockname {					\
 	__SEQ_LOCK(locktype	*lock);					\
 } seqcount_##lockname##_t;						\
 									\
+static __always_inline raw_seqcount_t *					\
+__seqprop_##lockname##_raw_ptr(seqcount_##lockname##_t *s)		\
+{									\
+	return &s->seqcount.sequence;					\
+}									\
+									\
 static __always_inline seqcount_t *					\
 __seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 {									\
@@ -247,10 +276,45 @@ __seqprop_##lockname##_assert(const seqcount_##lockname##_t *s)		\
 	__SEQ_LOCK(lockdep_assert_held(lockmember));			\
 }
 
+/*
+ * __raw_seqprop() for raw_seqcount_t
+ */
+
+static inline raw_seqcount_t *__raw_seqprop_raw_ptr(raw_seqcount_t *s)
+{
+	return s;
+}
+
+static inline seqcount_t *__raw_seqprop_ptr(raw_seqcount_t *s)
+{
+	BUILD_BUG();
+	return NULL;
+}
+
+static inline unsigned int __raw_seqprop_sequence(const raw_seqcount_t *s)
+{
+	return READ_ONCE(*s);
+}
+
+static inline bool __raw_seqprop_preemptible(const raw_seqcount_t *s)
+{
+	return false;
+}
+
+static inline void __raw_seqprop_assert(const raw_seqcount_t *s)
+{
+	lockdep_assert_preemption_disabled();
+}
+
 /*
  * __seqprop() for seqcount_t
  */
 
+static inline raw_seqcount_t *__seqprop_raw_ptr(seqcount_t *s)
+{
+	return &s->sequence;
+}
+
 static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
 {
 	return s;
@@ -300,6 +364,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 	seqcount_##lockname##_t: __seqprop_##lockname##_##prop((void *)(s))
 
 #define __seqprop(s, prop) _Generic(*(s),				\
+	raw_seqcount_t:		__raw_seqprop_##prop((void *)(s)),	\
 	seqcount_t:		__seqprop_##prop((void *)(s)),		\
 	__seqprop_case((s),	raw_spinlock,	prop),			\
 	__seqprop_case((s),	spinlock,	prop),			\
@@ -307,6 +372,7 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 	__seqprop_case((s),	mutex,		prop),			\
 	__seqprop_case((s),	ww_mutex,	prop))
 
+#define seqprop_raw_ptr(s)		__seqprop(s, raw_ptr)
 #define seqprop_ptr(s)			__seqprop(s, ptr)
 #define seqprop_sequence(s)		__seqprop(s, sequence)
 #define seqprop_preemptible(s)		__seqprop(s, preemptible)
@@ -314,7 +380,8 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 
 /**
  * __read_seqcount_begin() - begin a seqcount_t read section w/o barrier
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ * @s: Pointer to seqcount_t, raw_seqcount_t or any of the seqcount_LOCKNAME_t
+ *     variants
  *
  * __read_seqcount_begin is like read_seqcount_begin, but has no smp_rmb()
  * barrier. Callers should ensure that smp_rmb() or equivalent ordering is
@@ -339,7 +406,8 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 
 /**
  * raw_read_seqcount_begin() - begin a seqcount_t read section w/o lockdep
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ * @s: Pointer to seqcount_t, raw_seqcount_t or any of the
+ *     seqcount_LOCKNAME_t variants
  *
  * Return: count to be passed to read_seqcount_retry()
  */
@@ -365,7 +433,8 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 
 /**
  * raw_read_seqcount() - read the raw seqcount_t counter value
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ * @s: Pointer to seqcount_t, raw_seqcount_t or any of the seqcount_LOCKNAME_t
+ *     variants
  *
  * raw_read_seqcount opens a read critical section of the given
  * seqcount_t, without any lockdep checking, and without checking or
@@ -386,7 +455,8 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 /**
  * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
  *                        lockdep and w/o counter stabilization
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ * @s: Pointer to seqcount_t, raw_seqcount_t, or any of the seqcount_LOCKNAME_t
+ *     variants
  *
  * raw_seqcount_begin opens a read critical section of the given
  * seqcount_t. Unlike read_seqcount_begin(), this function will not wait
@@ -411,7 +481,8 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
 
 /**
  * __read_seqcount_retry() - end a seqcount_t read section w/o barrier
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ * @s: Pointer to seqcount_t, raw_seqcount_t or any of the seqcount_LOCKNAME_t
+ *     variants
  * @start: count, from read_seqcount_begin()
  *
  * __read_seqcount_retry is like read_seqcount_retry, but has no smp_rmb()
@@ -425,17 +496,19 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  * Return: true if a read section retry is required, else false
  */
 #define __read_seqcount_retry(s, start)					\
-	do___read_seqcount_retry(seqprop_ptr(s), start)
+	do___read_seqcount_retry(seqprop_raw_ptr(s), start)
 
-static inline int do___read_seqcount_retry(const seqcount_t *s, unsigned start)
+static inline int do___read_seqcount_retry(const raw_seqcount_t *s,
+					   unsigned int start)
 {
 	kcsan_atomic_next(0);
-	return unlikely(READ_ONCE(s->sequence) != start);
+	return unlikely(READ_ONCE(*s) != start);
 }
 
 /**
  * read_seqcount_retry() - end a seqcount_t read critical section
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ * @s: Pointer to seqcount_t, raw_seqcount_t or any of the seqcount_LOCKNAME_t
+ *     variants
  * @start: count, from read_seqcount_begin()
  *
  * read_seqcount_retry closes the read critical section of given
@@ -445,9 +518,11 @@ static inline int do___read_seqcount_retry(const seqcount_t *s, unsigned start)
  * Return: true if a read section retry is required, else false
  */
 #define read_seqcount_retry(s, start)					\
-	do_read_seqcount_retry(seqprop_ptr(s), start)
+	do_read_seqcount_retry(seqprop_raw_ptr(s), start)
+#define raw_read_seqcount_retry(s, start) read_seqcount_retry(s, start)
 
-static inline int do_read_seqcount_retry(const seqcount_t *s, unsigned start)
+static inline int do_read_seqcount_retry(const raw_seqcount_t *s,
+					 unsigned int start)
 {
 	smp_rmb();
 	return do___read_seqcount_retry(s, start);
@@ -455,7 +530,8 @@ static inline int do_read_seqcount_retry(const seqcount_t *s, unsigned start)
 
 /**
  * raw_write_seqcount_begin() - start a seqcount_t write section w/o lockdep
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ * @s: Pointer to seqcount_t, raw_seqcount_t or any of the seqcount_LOCKNAME_t
+ *     variants
  *
  * Context: check write_seqcount_begin()
  */
@@ -464,34 +540,35 @@ do {									\
 	if (seqprop_preemptible(s))					\
 		preempt_disable();					\
 									\
-	do_raw_write_seqcount_begin(seqprop_ptr(s));			\
+	do_raw_write_seqcount_begin(seqprop_raw_ptr(s));		\
 } while (0)
 
-static inline void do_raw_write_seqcount_begin(seqcount_t *s)
+static inline void do_raw_write_seqcount_begin(raw_seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
-	s->sequence++;
+	(*s)++;
 	smp_wmb();
 }
 
 /**
  * raw_write_seqcount_end() - end a seqcount_t write section w/o lockdep
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ * @s: Pointer to seqcount_t, raw_seqcount_t or any of the seqcount_LOCKNAME_t
+ *     variants
  *
  * Context: check write_seqcount_end()
  */
 #define raw_write_seqcount_end(s)					\
 do {									\
-	do_raw_write_seqcount_end(seqprop_ptr(s));			\
+	do_raw_write_seqcount_end(seqprop_raw_ptr(s));			\
 									\
 	if (seqprop_preemptible(s))					\
 		preempt_enable();					\
 } while (0)
 
-static inline void do_raw_write_seqcount_end(seqcount_t *s)
+static inline void do_raw_write_seqcount_end(raw_seqcount_t *s)
 {
 	smp_wmb();
-	s->sequence++;
+	(*s)++;
 	kcsan_nestable_atomic_end();
 }
 
@@ -516,7 +593,7 @@ do {									\
 
 static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	do_raw_write_seqcount_begin(s);
+	do_raw_write_seqcount_begin(&s->sequence);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
 }
 
@@ -563,12 +640,13 @@ do {									\
 static inline void do_write_seqcount_end(seqcount_t *s)
 {
 	seqcount_release(&s->dep_map, _RET_IP_);
-	do_raw_write_seqcount_end(s);
+	do_raw_write_seqcount_end(&s->sequence);
 }
 
 /**
  * raw_write_seqcount_barrier() - do a seqcount_t write barrier
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ * @s: Pointer to seqcount_t, raw_seqcount_t or any of the seqcount_LOCKNAME_t
+ *     variants
  *
  * This can be used to provide an ordering guarantee instead of the usual
  * consistency guarantee. It is one wmb cheaper, because it can collapse
@@ -608,33 +686,34 @@ static inline void do_write_seqcount_end(seqcount_t *s)
  *      }
  */
 #define raw_write_seqcount_barrier(s)					\
-	do_raw_write_seqcount_barrier(seqprop_ptr(s))
+	do_raw_write_seqcount_barrier(seqprop_raw_ptr(s))
 
-static inline void do_raw_write_seqcount_barrier(seqcount_t *s)
+static inline void do_raw_write_seqcount_barrier(raw_seqcount_t *s)
 {
 	kcsan_nestable_atomic_begin();
-	s->sequence++;
+	(*s)++;
 	smp_wmb();
-	s->sequence++;
+	(*s)++;
 	kcsan_nestable_atomic_end();
 }
 
 /**
  * write_seqcount_invalidate() - invalidate in-progress seqcount_t read
  *                               side operations
- * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variants
+ * @s: Pointer to seqcount_t, raw_seqcount_t or any of the seqcount_LOCKNAME_t
+ *     variants
  *
  * After write_seqcount_invalidate, no seqcount_t read side operations
  * will complete successfully and see data older than this.
  */
 #define write_seqcount_invalidate(s)					\
-	do_write_seqcount_invalidate(seqprop_ptr(s))
+	do_write_seqcount_invalidate(seqprop_raw_ptr(s))
 
-static inline void do_write_seqcount_invalidate(seqcount_t *s)
+static inline void do_write_seqcount_invalidate(raw_seqcount_t *s)
 {
 	smp_wmb();
 	kcsan_nestable_atomic_begin();
-	s->sequence+=2;
+	(*s) += 2;
 	kcsan_nestable_atomic_end();
 }
 
-- 
2.31.1

