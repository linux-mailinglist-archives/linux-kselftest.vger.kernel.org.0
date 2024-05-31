Return-Path: <linux-kselftest+bounces-11067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD08D6BA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 23:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1EBEB23E19
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CA278C90;
	Fri, 31 May 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7dnr1zs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4277F08
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191285; cv=none; b=EkxKyHPQKnROTTSKV6IqncAZ7us7qZfPmOMuM+Y1VNr0EVHDzM/mfYFxmjX9OZMJmMl1k0rjLlCaRysPexxOyrsAcGF31pr6pXF1n9ubSmW4KohSYr2bNrHnBvohJJm9BYetD2I0HiIyA3hOjg0MH/4d/WJPpEllOVaAjCL4+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191285; c=relaxed/simple;
	bh=VutOrirCi9KiHN1eq82vVFg/OfJxQxCO7FYJxWhQ8T8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IYBKNKLlXpUS6qpEmzLcMDIl+uwN9mo3+h25qc1vHa6AEXrIB8CDGlYc87qdpoo8j9duO3T0GSv+gVZrb6l38n60h8hwz5NGJ/J1nZX9d8GxQMozNUVHxU5EkWbCaB0uCOstbE/mEBQL1SSZ5/ry5Nwq6gt2xdCABudOYN6cKZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7dnr1zs; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df78acd5bbbso4389811276.1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717191283; x=1717796083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g9a4m0tSyICWy0UguPev6jQ4VtQUH+IhztdiBrfWz7s=;
        b=t7dnr1zsh+12dcFncafvprruxV6eJoyUdl/xRWLUSwkEOsQz9qOM8Cfjb4/xE3n3y4
         AXP5ulLn0VvMyitMQUjdgvLSYXvZQD4lDvGPuB/pyXiOJ4pcgvJDY73s0KTQrFToCuRP
         qNQImFqnHdkalz8rRbF/TSnupYOig1Nep0pjcyvdKzLmFQHVJNN3uTuhJxcW1ZlORCPs
         Hpf0BAKVXth6LQovdEPP3wCQs6f6SNp2jQ9YNOolUdioxjZJPpJk8K5rulRPOYGyI8rg
         gkDJSVjcbzHY/675MM7/vx16rCoMUWcpZ18dVVqJJXmQlJh/aQ4IEbDF2rXuV//wjaSv
         jIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717191283; x=1717796083;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g9a4m0tSyICWy0UguPev6jQ4VtQUH+IhztdiBrfWz7s=;
        b=hg+Etogm+RtCyLDn/eHs+ukaglMP13AJVO6UEhJKvcF4Y+BFoVtDFSt2OlzFBTQHnV
         Ua7gx98h9a7MLENckcBlqT3y08LC7N4LEt1TI2V2jkNn0cgixFa1kpNTtQ/auh+N0NWx
         hizJMCFOn/3UaD2kerp3E20hTYKiy9XNISZz31Ev9+MTTnM3N6POWIDJQ/rFP/0IaUkF
         ikbnHb5PGxPZRoKtW4MYiPRD/UZjRnOzz6yb+gyAK3fQp3+L/g+6Tg8mlledw6RMb+R5
         OBjarxcuX6I6MwxLqo523C697iRyzC7n++fDLgJ8RdUV4lkxIwVjBBscYkT4N/MBOqpT
         yejA==
X-Forwarded-Encrypted: i=1; AJvYcCX5s8ShUURV75LyhSDIclI4ZZNI10eKvtzPNDZx6qQ78KaBMGSkF2Awmy3T6xOWxK/R9b4Q0yPMwh4fLN0u1yrvwisxXG7T6sxi6OjFy1lV
X-Gm-Message-State: AOJu0YyQg2iDux4hmbuRNhGfQ74AZX/SAkChUiegucEyttjuijgArF9b
	Ca7m8twj3unMVBUWLfZ1fiwu8/VjQxxzhOroV2RC7il6lJcAD8Ccr5HksAzzObXwO6YmnaFcE+k
	gfY+pGit0Sw==
X-Google-Smtp-Source: AGHT+IEcPY6XgPhyEspQP0kWwXng6v8b1Mv+0NoD2vv4x30M+l7m0p019T5E5CKmHGsb9yQrDP2DWrLq7Dg9WQ==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6902:110d:b0:df1:d00c:130c with SMTP
 id 3f1490d57ef6-dfa73bf59bcmr348904276.5.1717191283404; Fri, 31 May 2024
 14:34:43 -0700 (PDT)
Date: Fri, 31 May 2024 21:34:36 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240531213439.2958891-1-jiaqiyan@google.com>
Subject: [PATCH v1 0/3] Userspace controls soft-offline HugeTLB pages
From: Jiaqi Yan <jiaqiyan@google.com>
To: naoya.horiguchi@nec.com, muchun.song@linux.dev, linmiaohe@huawei.com
Cc: akpm@linux-foundation.org, mike.kravetz@oracle.com, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Correctable memory errors are very common on servers with large
amount of memory, and are corrected by ECC, but with two
pain points to users:
1. Correction usually happens on the fly and adds latency overhead
2. Not-fully-proved theory states excessive correctable memory
   errors can develop into uncorrectable memory error.

Soft offline is kernel's additional solution for memory pages
having (excessive) corrected memory errors. Impacted page is migrated
to healthy page if it is in use, then the original page is discarded
for any future use.

The actual policy on whether (and when) to soft offline should be
maintained by userspace, especially in case of HugeTLB hugepages.
Soft-offline dissolves a hugepage, either in-use or free, into
chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
If userspace has not acknowledged such behavior, it may be surprised
when later mmap hugepages MAP_FAILED due to lack of hugepages.
In addition, discarding the entire 1G memory page only because of
corrected memory errors sounds very costly and kernel better not
doing under the hood. But today there are at least 2 such cases:
1. GHES driver sees both GHES_SEV_CORRECTED and
   CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
2. RAS Correctable Errors Collector counts correctable errors per
   PFN and when the counter for a PFN reaches threshold
In both cases, userspace has no control of the soft offline performed
by kernel's memory failure recovery.

This patch series give userspace the control of soft-offlining
HugeTLB pages: kernel only soft offlines hugepage if userspace has
opt-ed in for that specific hugepage size, and exposed to userspace
by a new sysfs entry called softoffline_corrected_errors under
/sys/kernel/mm/hugepages/hugepages-${size}kB directory:
* When softoffline_corrected_errors=0, skip soft offlining for all
  hugepages of size ${size}kB.
* When softoffline_corrected_errors=1, soft offline as before this
  patch series.
By default softoffline_corrected_errors is 1.

This patch set is based at
commit a52b4f11a2e1 ("selftest mm/mseal read-only elf memory segment").

Jiaqi Yan (3):
  mm/memory-failure: userspace controls soft-offlining hugetlb pages
  selftest/mm: test softoffline_corrected_errors behaviors
  docs: hugetlbpage.rst: add softoffline_corrected_errors

 Documentation/admin-guide/mm/hugetlbpage.rst  |  15 +-
 include/linux/hugetlb.h                       |  17 ++
 mm/hugetlb.c                                  |  34 +++
 mm/memory-failure.c                           |   7 +
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-soft-offline.c       | 262 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 8 files changed, 340 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/mm/hugetlb-soft-offline.c

-- 
2.45.1.288.g0e0cd299f1-goog


