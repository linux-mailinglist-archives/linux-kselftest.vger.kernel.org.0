Return-Path: <linux-kselftest+bounces-33547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08767AC188A
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 01:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B34A210E0
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 23:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D4D2D8DAF;
	Thu, 22 May 2025 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xv0ywX4+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D192D4B64
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957969; cv=none; b=K/fjuXIhiOLv7fbl6wRUrMwoMAz5qyP7yPx/G4QzqSkuUJfSIrOTMqi3Wb9ZiQAX8MVebGeNAKdzrx1wrtBxY4ooE16CkuYkgq0WhdD75XOkCpJ3p5EvoG1xnQ5WAlAItYCMpkbn7aMkE119024UWYjsvjW/y/27n+tiriJYJr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957969; c=relaxed/simple;
	bh=10csqsTxzGOkEfQIv9Q5P5aleQ0W+QD5VjZMgcVNvw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f4kbPPVtdNW6/ppBwl/V2i29ZkhPPL4J+d0H0unPzrP/kg18UkPK7geqWcnGIRnG1qL/7WaTzAsIBss/DXSx+O3syYoTZxdZ0KKPAOjGaLhwimZREhoojTgn1d4Hv7YgdFMRdERlZ9rGXy6mZWekNJh02YZ50nKcGtIy9pDYi9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xv0ywX4+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2c00e965d0so1147916a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 16:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747957968; x=1748562768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vuHVtgMNklQ3DNdNkMUrgN1tyOO7CrPEj2V6DIP2LQI=;
        b=Xv0ywX4+2yBdolyOwONRwxrwgk1Td4Dcp8bOX7h3iXl5OkIolDfTvr8hG3Lv8UF6d0
         jCi92gYVND4WN3MKrosaVqjpVQUHXszSSuDIqeX1jAWNbIwqvok1tCZsaqZKx/0XLzXG
         gwIkW3BihX4TNM7Kl1kB/y9sB6PIIz1V/QecVghPXynAS5SXcETPd4y+kQDkM9qDHqrw
         4NjxFAtQ4YsQIgLXVqB19hulSB6slqSM6I76e4h3hSMEEBE//G/un7+dCoUjYZMXIcfC
         fAzdrtBbk+1tHj3b3X01bu0uHyGA4fblWROStIYUMXWZvaJa7+g7aRWGD7ddbEsIkLxJ
         3CHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747957968; x=1748562768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuHVtgMNklQ3DNdNkMUrgN1tyOO7CrPEj2V6DIP2LQI=;
        b=TMOPsTwYh7k+HnNgydM1BTE+zzu8HIcIKjjnXFyICirRI9kCirYJLGkFFKJ2vWtpO5
         tnHmpsifrNob/xwNAT5gSurEw7w4lqfrxmEaFOZ66HYDECBM9aMr9Vl9+dvTb3EQ7o/F
         vS57OiOvswmysGgZLPnmkX9O+5lxcsfYWIYW8zpPkfMSzqcLyXpT9YizOlLHkEn3mBIK
         Uj1R6N7GlqvnC+Viyyq+3Vx/utIM3sjtAI56KST7ajGxblKcafiaKFNaZ7gL22kvx9pV
         pzSdtxqjwge9aBiYZ2kcUUNYA5oep6aZsAWEa+L4soVZ3VMGpz0DdC52yQP1OgJZcYuN
         t/pw==
X-Forwarded-Encrypted: i=1; AJvYcCXthWZA5HKh6MDeDWTxGkAmHShIA5a3W3MNMYI9Qbti6n7aqkbXGCo9N+y4Uta1xzNLKg4knraFRnWyncsXU50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJguM6aMrSsHtkwIF5gbMgVqM01ql0FL0QLEJp0UiivpQrQ3EC
	Yj4pB2E4l1taH6y4quZWuOY6IW3WNPp1y+/nSZz2SUDZ+BlPlti6NGW+z6NslUYFFI6sypebb9w
	nodWBXg==
X-Google-Smtp-Source: AGHT+IHikqs98z49j0Kkg2uX1c0LCZJ4TnpoZgPhfD1i2QFTska6FVqOIcx30KNoejfw/K9L53iBDs4oCi4=
X-Received: from pga7.prod.google.com ([2002:a05:6a02:4f87:b0:b26:e751:bb70])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:faf:b0:223:62f5:fd44
 with SMTP id d9443c01a7336-231d459a467mr365010445ad.40.1747957967798; Thu, 22
 May 2025 16:52:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 16:52:18 -0700
In-Reply-To: <20250522235223.3178519-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235223.3178519-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235223.3178519-9-seanjc@google.com>
Subject: [PATCH v3 08/13] sched/wait: Add a waitqueue helper for fully
 exclusive priority waiters
From: Sean Christopherson <seanjc@google.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Shuah Khan <shuah@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, K Prateek Nayak <kprateek.nayak@amd.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a waitqueue helper to add a priority waiter that requires exclusive
wakeups, i.e. that requires that it be the _only_ priority waiter.  The
API will be used by KVM to ensure that at most one of KVM's irqfds is
bound to a single eventfd (across the entire kernel).

Open code the helper instead of using __add_wait_queue() so that the
common path doesn't need to "handle" impossible failures.

Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/wait.h |  2 ++
 kernel/sched/wait.c  | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 965a19809c7e..09855d819418 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -164,6 +164,8 @@ static inline bool wq_has_sleeper(struct wait_queue_head *wq_head)
 extern void add_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry);
 extern void add_wait_queue_exclusive(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry);
 extern void add_wait_queue_priority(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry);
+extern int add_wait_queue_priority_exclusive(struct wait_queue_head *wq_head,
+					     struct wait_queue_entry *wq_entry);
 extern void remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry);
 
 static inline void __add_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry)
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 4ab3ab195277..15632c89c4f2 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -47,6 +47,24 @@ void add_wait_queue_priority(struct wait_queue_head *wq_head, struct wait_queue_
 }
 EXPORT_SYMBOL_GPL(add_wait_queue_priority);
 
+int add_wait_queue_priority_exclusive(struct wait_queue_head *wq_head,
+				      struct wait_queue_entry *wq_entry)
+{
+	struct list_head *head = &wq_head->head;
+
+	wq_entry->flags |= WQ_FLAG_EXCLUSIVE | WQ_FLAG_PRIORITY;
+
+	guard(spinlock_irqsave)(&wq_head->lock);
+
+	if (!list_empty(head) &&
+	    (list_first_entry(head, typeof(*wq_entry), entry)->flags & WQ_FLAG_PRIORITY))
+		return -EBUSY;
+
+	list_add(&wq_entry->entry, head);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(add_wait_queue_priority_exclusive);
+
 void remove_wait_queue(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry)
 {
 	unsigned long flags;
-- 
2.49.0.1151.ga128411c76-goog


