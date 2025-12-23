Return-Path: <linux-kselftest+bounces-47932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF0BCD9EBC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 17:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D2D2302B144
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E4E33122B;
	Tue, 23 Dec 2025 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pY+sf7a+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A91324B24
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 16:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506709; cv=none; b=c1oO4mEzs2t9woAjsEE7RbUFuCo4Cavp4rUaLzi9JEuay0OOmbylGbW5CmO6zmYGf4h2LPEFsiJbMQ8u+TlA9Fxi9iR1gscbMs/mF0ObF7pjmTb7WOls7Y6k0dRlED4Shy75mX5B8Q8iRSDTQAedvx6QG/QPvLMquRZ02mQzmGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506709; c=relaxed/simple;
	bh=S9xPlp1JbKJpCxpnciHsOatx8AGtJWNQNsuUgj05tOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UR/jsIG5+E8uQZJmYXSEsCyTG+2oJNohBMn55sIJXNAOra2ao8qzyJpvCOYatQOx/+JFOXatMbm8hBaKqApFjB41noOHmS3rVlOJexmvLPxprT7D+LlpdXKVQnIBqGxZf2VboW6MWqR8ETz2FyEJaBWOV2jmMTkfFlbD4o5wZx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pY+sf7a+; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-432488a0ce8so4364733f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 08:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766506706; x=1767111506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ecq4ux8juxn6/rOyJrhpTEUfUCldUGcEOc8fd0njwT4=;
        b=pY+sf7a+1SnGvjPcQU4n0lhFwlvM1MZjUeaqfg1PpakUONFs171qNJy6yD0L1b2/Id
         T4zoGpJxDzz2OG6jSOC3Wpe3snfgNLhJQ3vSZHryYIdAKa8NKadV0wjsQ/84kZ7o7sHt
         9hniT+iAS3POt2CPHdonmU/P7v0vgDFDziVWHeV+hBnhIdWmBKLDLjaYDoqYfD/+iL5b
         CHG9bItD3JEjjoIkuvtPdMfcPmnITU5u5dl3tXkW2Ox5jmTGVcA0RI7tSYO5FNavWQIp
         pq0SYvMbRkfxwXkPmN+9gEhCy711vJawFo7A35qAMnYyhjD+TbPuDRWYyAULne44u3uc
         gaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766506706; x=1767111506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ecq4ux8juxn6/rOyJrhpTEUfUCldUGcEOc8fd0njwT4=;
        b=uU/8/6TIIs8q3MGh5u7jOS86WrHAOUav7DeoCLrVDPUlwSWiFAorhg1AQx2lWOLzh7
         fS1zUyNyFFnxp5UbonM19G6oK4VgeuWZM1GfelwMyDJEN173CDQzf1fFzOp1kh/XH+kz
         gaCDraqc+kTOlan4rS9GVIE+JBgpIhoFhEq0XMRkMjTYyBwn03TZkpKdO6A2o6bXF9yx
         sacw3ujZTI+2rpmrvAMVK4GUjRQ9CG4635WMjNVcF6sb097UpTac2Len2H+ivRzAPnvp
         9SM+WC1M/OFSIgCefx4mgYm0Rw41lgVSgRXMBumwcq1k1SMXXGaOtWBL0gq1g4wZb388
         efCQ==
X-Gm-Message-State: AOJu0Yxu0d03yz4ge45Rh9BB3DCnnKl+20BK1/eALsv1i40AJkfDnG2P
	0d6xB5uhLzFxejlEeRsNfBn2SYKVS7pFGK8w6ovybl+C0rlpt+QAVxchuoRoFp/oObpANiOKCr3
	TYUNiqdNK00EXQg==
X-Google-Smtp-Source: AGHT+IE63cPLMbu1UcIi3eff/7vrdmKmmwcAwevA03KE9Q9fKYy9YzX+rmosSiA8nVUqbpZhJUEcq4BVB0L3Ow==
X-Received: from wre13.prod.google.com ([2002:a05:6000:4b0d:b0:430:f216:9f71])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:24c7:b0:42f:bc6d:e46c with SMTP id ffacd0b85a97d-4324e4d1032mr17311664f8f.26.1766506706286;
 Tue, 23 Dec 2025 08:18:26 -0800 (PST)
Date: Tue, 23 Dec 2025 16:18:12 +0000
In-Reply-To: <20251223-b4-kunit-user-alloc-v1-0-fb910ae0e50c@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251223-b4-kunit-user-alloc-v1-0-fb910ae0e50c@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20251223-b4-kunit-user-alloc-v1-3-fb910ae0e50c@google.com>
Subject: [PATCH 3/3] kunit: test: fix mm_struct leak in kunit_attach_mm()
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

Here's how I understand mm refcounts:

  funcs             | counter  | manages lifecycle of...
  --------------------------------------------------------
  mmgrab()/mmdrop() | mm_count | mm_struct and PGD
  --------------------------------------------------------
  mmget()/mmput()   | mm_users | userspace address space

    All mm_users references share a single reference to the mm_struct.

mm_alloc() returns the mm with a single reference to the user address
space, i.e. with mm_users=1, mm_count=1.

kunit_attach_mm() then passes the mm to kthread_use_mm(). It does not
call kthread_unuse_mm(), instead it relies on the kthread exit path to
release the relevant resources. It does this because KUnit's resource
cleanup logic works by running cleanups in a different kthread from the
test. You can't have cleanups that operate on the kthread, because
the kthread is already gone by the time the cleanup is called.

The kthread exit path will indeed drop the reference to the address
space, i.e. it will call mmput(task->mm), decrementing mm_users.
However, it does not release the reference taken on the mm_struct when
kthread_use_mm() called mmgrab().

To fix this, use the new kthread_take_mm() which provides the API KUnit
needs.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 lib/kunit/user_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/user_alloc.c b/lib/kunit/user_alloc.c
index 564f5566641d5..3fca4ae223f67 100644
--- a/lib/kunit/user_alloc.c
+++ b/lib/kunit/user_alloc.c
@@ -29,7 +29,7 @@ int kunit_attach_mm(void)
 	arch_pick_mmap_layout(mm, &current->signal->rlim[RLIMIT_STACK]);
 
 	/* Attach the mm. It will be cleaned up when the process dies. */
-	kthread_use_mm(mm);
+	kthread_take_mm(mm);
 
 	return 0;
 }

-- 
2.51.2


