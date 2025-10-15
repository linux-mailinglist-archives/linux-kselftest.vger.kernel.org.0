Return-Path: <linux-kselftest+bounces-43251-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D148CBE0351
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 20:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E384868BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C907524DD0E;
	Wed, 15 Oct 2025 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uxi7iJ+L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454B3325495
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 18:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553410; cv=none; b=FIGY3kq4X5nH10NREL4P+dy1iWbGM0XX6cAoPLw1BgVykwxuUD6hmbSK6NuSUVUn05HzvZ1pwX7UI7tyw9h4c/K5wRxOQ8Bj2uaqoltEINI7EFelCAU6pEfKRRa8tae99cOLBTDKZk5yAM36gQSDqstwJCGQ5I0Mn9to9GnbH+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553410; c=relaxed/simple;
	bh=+ewbUy3AHFgUEwycvkbHsOaDseVTEdJWwpTlP6Kuyo4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fQG67D3hJy8dCzxu6mxshuw+srPEfq+i1HxeFsi38Jh8pUsRj6icU5vdl8O6LPjmwhCvO8Qb06PYLD3urUxIqo2aSIbrR1QdnjopUi4ZU2Df+q7+RAFSSrOUXBpBAKh8Hr/WD4P8PtYJCfSXwqA7MlmIpx5tAIXZgcdGJfv/mHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uxi7iJ+L; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f5e6a324fso18523834b3a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760553408; x=1761158208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ilCg17JQ++to0ldYWXPZYiNCoMtQnD6yTXTJa/H8UI=;
        b=Uxi7iJ+L0bDVYVPbcCV1xpE/EceJ1lIFMIHhTkZE9eLlmRzDJqf/RYYA8GRpayeow9
         z0uCq46Sgy9KTWIwJgUNYoCjDFI1aB96uLOfMiQdbCPMlZaZQKnZ0YNuLLSryy7XdOLk
         J6fuU90u8snSA1hKOwyYOo+dyuRtTYGgTGBsPSaqt32SgzhssiROZ22icUXhmm3IwHg4
         yaW5KD8ruKwtt1807mbWsbiuvQw+3WPTMVMJ3ev9HmxUQWb5GP92yrGtqHmC2Zx1Gng5
         i3t7Q4gm+XRrSyiHXoahJJ/f+d8sucbrP+oC7gGyCFgi/VIjAD3LfQAXRhXmz6+7FSxE
         VR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553408; x=1761158208;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ilCg17JQ++to0ldYWXPZYiNCoMtQnD6yTXTJa/H8UI=;
        b=kQQKQPGZyXFfDtdKgP40J+DHuGOWfdLGRfWw8J1Yx9wwbo3XnE7mfHE4pfzdAnrqMX
         qCBLTwsY2xFShxThfBUE2u5X5pOLRmZP3QjOC+lHkeoKUiA6pHUQo7i4SbJQdvm5yO+l
         iXUUtm+l8IlY+JJ19Vek0Pt+inByJPN98FdP6LrO2USj3SARjGBG+JbR67omfF7iPTP9
         O/IqKDh9/q9PxxH6r1sRMlrUepaczeAqVf7ELSjZwEeiSmfL8M34xASFRm7pLBPHgP4f
         G7pPb5NdNM4WC+rxSGqVg5qh/VQrXx5S1qS9WmXx/rLqxw48SiapSlkTmcZ3J5FcKpr7
         aFxA==
X-Forwarded-Encrypted: i=1; AJvYcCVoIMGf+qPlKdvCHksI5qgNmMQT3pDmQRMVsYs/N/yR++7ox1PnWIf72ZfbabSEhUpc3xuCVvTfkcEb3Fsxjh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBWOBhPCT1r7PUAWPr4E8QLNIxr1YBVUCxQNIF49KuF6b3Sua4
	8074TEUt4fp+YfRo5bV06X1AfkLHFKtJe7K089drB7u24slJ8qPMbsWz8lOhmyGud+llFOAK1r6
	DqLxUEQ==
X-Google-Smtp-Source: AGHT+IH8PPaE3dBlYhL9Cayq48vHN7MW+dNQWzXLTzpeemhgXmBd6s/PSaBxdBzVpqnpNlS0tiwU3TI6UZk=
X-Received: from pfbbe19.prod.google.com ([2002:a05:6a00:1f13:b0:77f:6432:dc09])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e13:b0:781:1771:c12c
 with SMTP id d2e1a72fcca58-7938269d8b7mr36969858b3a.0.1760553408537; Wed, 15
 Oct 2025 11:36:48 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:35:51 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <cover.1760551864.git.wyihan@google.com>
Subject: [RFC PATCH 0/3] mm: Fix MF_DELAYED handling on memory failure
From: Lisa Wang <wyihan@google.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org, 
	pbonzini@redhat.com, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.or, 
	linux-kselftest@vger.kernel.org
Cc: david@redhat.com, rientjes@google.com, seanjc@google.com, 
	ackerleytng@google.com, vannapurve@google.com, michael.roth@amd.com, 
	jiaqiyan@google.com, tabba@google.com, dave.hansen@linux.intel.com, 
	Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

This patch series addresses an issue in the memory failure handling path
where MF_DELAYED is incorrectly treated as an error. This issue was
revealed because guest_memfd=E2=80=99s .error_remove_folio() callback retur=
ns
MF_DELAYED.

Currently, when the .error_remove_folio() callback for guest_memfd returns
MF_DELAYED, there are a few issues.

1. truncate_error_folio() maps this to MF_FAILED. This causes
   memory_failure() to return -EBUSY, which unconditionally triggers a
   SIGBUS. The process=E2=80=99 configured memory corruption kill policy is=
 ignored
   - even if PR_MCE_KILL_LATE is set, the process will still get a SIGBUS
   on deferred memory failures.

2. =E2=80=9CFailed to punch page=E2=80=9D is printed, even though MF_DELAYE=
D indicates that
   it was intentionally not punched.

The first patch corrects this by updating truncate_error_folio() to
propagate MF_DELAYED to its caller. This allows memory_failure() to return
0, indicating success, and lets the delayed handling proceed as designed.
This patch also updates me_pagecache_clean() to account for the folio's
refcount, which remains elevated during delayed handling, aligning its
logic with me_swapcache_dirty().

The subsequent two patches add KVM selftests to validate the fix and the
expected behavior of guest_memfd memory failure:

The first test patch verifies that memory_failure() now returns 0 in the
delayed case and confirms that SIGBUS signaling logic remains correct for
other scenarios (e.g., madvise injection or PR_MCE_KILL_EARLY).

The second test patch confirms that after a memory failure, the poisoned
page is correctly unmapped from the KVM guest's stage 2 page tables and
that a subsequent access by the guest correctly notifies the userspace VMM
with EHWPOISON.

This patch series is built upon kvm/next. In addition, to align with the
change of INIT_SHARED and to use the macro wrapper in guest_memfd
selftests, we put these patches behind Sean=E2=80=99s patches [1].

For ease of testing, this series is also available, stitched together, at
https://github.com/googleprodkernel/linux-cc/tree/memory-failure-mf-delayed=
-fix-rfc-v1=20

[1]: https://lore.kernel.org/all/20251003232606.4070510-1-seanjc@google.com=
/T/

Thank you,


Lisa Wang (3):
  mm: memory_failure: Fix MF_DELAYED handling on truncation during
    failure
  KVM: selftests: Add memory failure tests in guest_memfd_test
  KVM: selftests: Test guest_memfd behavior with respect to stage 2 page
    tables

 mm/memory-failure.c                           |  24 +-
 .../testing/selftests/kvm/guest_memfd_test.c  | 233 ++++++++++++++++++
 2 files changed, 248 insertions(+), 9 deletions(-)

--=20
2.51.0.788.g6d19910ace-goog


