Return-Path: <linux-kselftest+bounces-47930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8EACD9EB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 17:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC3AA3024AC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 16:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00DB322B8A;
	Tue, 23 Dec 2025 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FF/9fvCn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E230C622
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506707; cv=none; b=RiAI3fHd8SFFUza3zk+pHHfLQjqtzNJ2+nqvUeSsZSFR503jK9WIskkzZY8/guOMpMFSBa+e/EF3TYQqBpkahjF3buN18Itxd8MG39TbNGABEGX8qYcveSCgfOE4yHi6DXp5FE9bxuZht1EtKhvs7lceD5rENYQ9vrLwBkfFXv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506707; c=relaxed/simple;
	bh=s9uG3y0OEfewAV0wFIr6ZC5yVfYH9oBTmmtdzG+B/5o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GjLVah/VeDJ+kING0VCUEJTxi9ERQWiwajNOBtcQh2WR+M/QXbMaR7+UW27cdu5h3jqWYuFWrWqw07gisJy9KwuvRSCV44StCCKmkL1T7iSM6KL4aVzGr0sXtz8LvKWJLqWJBbh0+kEJFAguCCIbzihYiQrrh+ldVTAxNdIjzss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FF/9fvCn; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b7d28772a67so506089166b.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 08:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766506704; x=1767111504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/0Hzxx2WqJaEHIGdZr2YZs1v307yu6j+9XrMYnyKbj4=;
        b=FF/9fvCnc2heZYNxaHme9ql97pjM1OeXrBbiC00EKYlV0ueLPJ1TA/1Xd5/dFFztQC
         19OE0FmanBAU9LeBzrDz6DebuEEXS6dZz0Oh6E12UVUr7SGgDZaCJ61/fMIICKk/xZCd
         tmIRVkUWI+Gu6thXnTnkw+7OA9UAr0OhLuBx35gwdG3GmJgn0sstoZ3vA72TUHLv6lwR
         wHuSOPq4Csaya8F7NZ4r8bu1rQecXzn5hsN8keoslAG3NsGuiFxjMh16TOR7mv/RBzAi
         ygbYi1n9B2NHIxOKRM8kGwmC5DfiCBIBZdaEeVtR9puDjoZLFOqc1SArTlndutVOujHk
         o7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766506704; x=1767111504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/0Hzxx2WqJaEHIGdZr2YZs1v307yu6j+9XrMYnyKbj4=;
        b=QNBB7AdLhakA/QaYTUgsfn85VkTnDFzw7bLF7qIznYesXLoo/6BH8nW6rf/i7qvgS/
         Gs7jytUtVoyYWtSU3LExxerMs1J3w6+hu94h7sno+i3JwdJe+Ir6oKKWHEbvcv4JifQj
         k4RLfCLGDEcBK8U3M6WDqOuZ18X+/wys7LBHl7+DNMwBrCnpV5npI7gwoKB2prkEVO6f
         fDHefyD0JgaINfd22NdUabcLCbxEl/YG9gwvKltOW6GPsnJe4ZFW8vy1ygoCkIAVv8YL
         JS0amV2ZaWJsrsOPEOpCuEuYL45UcvlSDZm6x4lo4eVzOZtaCP9Bd/umbuao7vlGc/Qy
         KcQQ==
X-Gm-Message-State: AOJu0Yys9BHRKs6P0mwG2hFNziTDWu268fOf1LiFAYLybori1wVQ9lc/
	33lLgF+4b48hu+3b71NsoHo4oljNiTMNLOPsRma8FN/WWqo/qFkRAn0D3CpqX6OPEU1LOGKeXbq
	NYtBGVLDPZV3psg==
X-Google-Smtp-Source: AGHT+IEtFcjxrDkWqyDW1Yh13A/N/vCOq+YRPV+smnuFFZgDp9YtoqP/3PaSXx1PlTrP2mudWqxqGIkWyOQF1g==
X-Received: from edxn2.prod.google.com ([2002:a05:6402:5c2:b0:640:f53e:dd40])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f58f:b0:b80:50b:6c8f with SMTP id a640c23a62f3a-b8036f5ac89mr1727469766b.27.1766506704176;
 Tue, 23 Dec 2025 08:18:24 -0800 (PST)
Date: Tue, 23 Dec 2025 16:18:10 +0000
In-Reply-To: <20251223-b4-kunit-user-alloc-v1-0-fb910ae0e50c@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251223-b4-kunit-user-alloc-v1-0-fb910ae0e50c@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20251223-b4-kunit-user-alloc-v1-1-fb910ae0e50c@google.com>
Subject: [PATCH 1/3] kunit: test: Delete pointless resource API usage
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

This code uses the low-level resource API to track parameters of the
vm_mmap call, but it doesn't do anything with them, because the mm
teardown code takes care of tearing down the mmaps. Delete it.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 lib/kunit/user_alloc.c | 76 ++++----------------------------------------------
 1 file changed, 6 insertions(+), 70 deletions(-)

diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
index b8cac765e6204..564f5566641d5 100644
--- a/lib/kunit/user_alloc.c
+++ b/lib/kunit/user_alloc.c
@@ -7,21 +7,6 @@
 #include <linux/kthread.h>
 #include <linux/mm.h>
 
-struct kunit_vm_mmap_resource {
-	unsigned long addr;
-	size_t size;
-};
-
-/* vm_mmap() arguments */
-struct kunit_vm_mmap_params {
-	struct file *file;
-	unsigned long addr;
-	unsigned long len;
-	unsigned long prot;
-	unsigned long flag;
-	unsigned long offset;
-};
-
 int kunit_attach_mm(void)
 {
 	struct mm_struct *mm;
@@ -50,67 +35,18 @@ int kunit_attach_mm(void)
 }
 EXPORT_SYMBOL_GPL(kunit_attach_mm);
 
-static int kunit_vm_mmap_init(struct kunit_resource *res, void *context)
-{
-	struct kunit_vm_mmap_params *p = context;
-	struct kunit_vm_mmap_resource vres;
-	int ret;
-
-	ret = kunit_attach_mm();
-	if (ret)
-		return ret;
-
-	vres.size = p->len;
-	vres.addr = vm_mmap(p->file, p->addr, p->len, p->prot, p->flag, p->offset);
-	if (!vres.addr)
-		return -ENOMEM;
-	res->data = kmemdup(&vres, sizeof(vres), GFP_KERNEL);
-	if (!res->data) {
-		vm_munmap(vres.addr, vres.size);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static void kunit_vm_mmap_free(struct kunit_resource *res)
-{
-	struct kunit_vm_mmap_resource *vres = res->data;
-
-	/*
-	 * Since this is executed from the test monitoring process,
-	 * the test's mm has already been torn down. We don't need
-	 * to run vm_munmap(vres->addr, vres->size), only clean up
-	 * the vres.
-	 */
-
-	kfree(vres);
-	res->data = NULL;
-}
-
 unsigned long kunit_vm_mmap(struct kunit *test, struct file *file,
 			    unsigned long addr, unsigned long len,
 			    unsigned long prot, unsigned long flag,
 			    unsigned long offset)
 {
-	struct kunit_vm_mmap_params params = {
-		.file = file,
-		.addr = addr,
-		.len = len,
-		.prot = prot,
-		.flag = flag,
-		.offset = offset,
-	};
-	struct kunit_vm_mmap_resource *vres;
+	int err;
 
-	vres = kunit_alloc_resource(test,
-				    kunit_vm_mmap_init,
-				    kunit_vm_mmap_free,
-				    GFP_KERNEL,
-				    &params);
-	if (vres)
-		return vres->addr;
-	return 0;
+	err = kunit_attach_mm();
+	if (err)
+		return err;
+
+	return vm_mmap(file, addr, len, prot, flag, offset);
 }
 EXPORT_SYMBOL_GPL(kunit_vm_mmap);
 

-- 
2.51.2


