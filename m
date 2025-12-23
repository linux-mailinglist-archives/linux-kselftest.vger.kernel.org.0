Return-Path: <linux-kselftest+bounces-47929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF978CD9EB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 17:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6F93301F7F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 16:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847A230F537;
	Tue, 23 Dec 2025 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a6ei8ziB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A37381C4
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506706; cv=none; b=a0I62hWguBQBZP00f4n/X8dXJWUm08zbS5J/yZSq7G/jexfVFmpKKVDkhgjODLOSJnXfHhjVJ38gF8vLy1tmsCyWf9/WHORBDwRkh5z3LIAEt6FCgxY8zE/QRDTCZDCsnSxNw/NBPrU5FrsjasxQJc6J9DYxzqKB5g9KzgjT9K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506706; c=relaxed/simple;
	bh=4ikesTTr3gH957w8Rz5esRmJyY+21//TWoL1liu9TsI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jw8gYkW0ipq8H1ERZY0hn1R5nx36vQD0jDx+qrjcg19tRxTHGMm9jvk1k8HjIrBzzLxzKVKM929Cu2czs2eR/ouw92XWlIoBvFhgApn/rDQXiLI3M50RrtuUMKCSX9TeZAv88R9rHzFlgpX08kKOJnP2wnbTDrIduIpNS5qcoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a6ei8ziB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477a0ddd1d4so46738555e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 08:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766506703; x=1767111503; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gp9XbXDpsLxRfCX6IDYmiMiyLFvCv3BI5tK1fIK0sqc=;
        b=a6ei8ziBJuNDsz54qm/d+mRhr26lLt+3hV/set14heK9QEgt4erLBiGigU5PkW0aQ9
         5vhalN8DHnhs16X/0CVZLyPFGc3c3XRQH1olqqFyqYAi0uTFIuDrR7+GiVJwyBn9TL8j
         3rW8ULL1bM89gVu8FYiROwCpcpHrGgj//wIxWqrG5qcDPnrYqpp885uBnOS8UubiEFyM
         NNCFjUzoJLBaL9fvtX/lcP0foHWapKP/ZIo/63ACVtiFkLlUh2eHJ/XCvn08k4Dyonw5
         3h3FN6gyHFlxSU9CwWQnoWM4DujL7UiLXTed5NB1WgupRyaoYweAlk/X37gKtRIIY9hi
         J/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766506703; x=1767111503;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gp9XbXDpsLxRfCX6IDYmiMiyLFvCv3BI5tK1fIK0sqc=;
        b=s/G0wmW0b6RybEb0zMVHWjBELPIws5ZV3e3vVNbh8R8wbjKVSjhj+yJw0mrlF4Ie2j
         tv6aymHQvKlc243E7tl4WGDT4iGAnKlnBukgpNeGh+dd2DbDVzRR1ZTxxMN8DSKaN+n8
         ze8DV3Y201DQcvPXTJ5X1/k+Q7AmiZ/1EDFFtU8eZo0j2M2Ld5EymVJl0jhUWYIq4/3p
         Hwvr6oiLoYfds1WJBRvtgGHDnDo1/G4TSHQ6Mg6UpL2WPn1mRkOXoa4mhs8NqZrBGAUB
         qeyzCdJV02A5ORVO/oIPInmNUl3pTXtGpojsVa0i/nZWe7Dcsn1VKoCR8pCT+9Ewi6T+
         YUCA==
X-Gm-Message-State: AOJu0YwWM6Mm3eJv8nqTf6yJbN5gR2tJlpzRvUh0ZzZSuG9oNLIz/XUK
	EFw+mPCxHgVrS7m4A5bQQGktrzvytfm6TpA0IFCLoIEXJQltqeeXwdPbxrak7OWCcBpWHth4/o6
	pc5UUqXg/8N8Mrw==
X-Google-Smtp-Source: AGHT+IGPr3MNh9Y63iLCh43jSDD1otDWg2upubHvHKONp3Z/jU8xumFyRt2FzEbY0GIFeXDVV9+gjwkh4PeGrQ==
X-Received: from wrs12.prod.google.com ([2002:a05:6000:64c:b0:42f:bb46:77bd])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:115:b0:46e:37fe:f0e6 with SMTP id 5b1f17b1804b1-47d1997e733mr103467595e9.30.1766506703258;
 Tue, 23 Dec 2025 08:18:23 -0800 (PST)
Date: Tue, 23 Dec 2025 16:18:09 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAMHASmkC/x3MTQ5AMBBA4avIrE3C+AmuIhbFlAkpaVUk0rtrL
 N/iey84tsIOuuQFy7c4OUyMPE1gWpVZGGWODZRRlRMVOJa4eSMX+ihR7fsxYa24mXU2NqoliPK 0rOX5r/0QwgcV4GlIZQAAAA==
X-Change-Id: 20251223-b4-kunit-user-alloc-6ae8df0b8a92
X-Mailer: b4 0.14.3
Message-ID: <20251223-b4-kunit-user-alloc-v1-0-fb910ae0e50c@google.com>
Subject: [PATCH 0/3] EDITME: cover title for b4/kunit-user-alloc
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

kunit_attach_mm() leaks an mm_struct (verified with dumb printf
debugging). Fix that. In the process, add a new kthread mm operation,
and clean up some nearby cleanup code in the KUnit lib.

---
Here's how I understand mm refcounts:

  funcs             | counter  | manages lifecycle of...
  --------------------------------------------------------
  mmgrab()/mmdrop() | mm_count | mm_struct and PGD
  --------------------------------------------------------
  mmget()/mmput()   | mm_users | userspace address space
  
  All mm_users references share a single reference to the mm_struct.

---
Brendan Jackman (3):
      kunit: test: Delete pointless resource API usage
      kthread: Add kthread_take_mm()
      kunit: test: fix mm_struct leak in kunit_attach_mm()

 include/linux/kthread.h |  1 +
 kernel/fork.c           |  3 +-
 kernel/kthread.c        | 36 +++++++++++++++++------
 lib/kunit/user_alloc.c  | 78 +++++--------------------------------------------
 4 files changed, 37 insertions(+), 81 deletions(-)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251223-b4-kunit-user-alloc-6ae8df0b8a92

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


