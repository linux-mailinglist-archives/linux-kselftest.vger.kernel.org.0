Return-Path: <linux-kselftest+bounces-12564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E36389153F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 18:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC462879CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 16:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D2A19E7C9;
	Mon, 24 Jun 2024 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4RI4MD3P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9704A19DF7C
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246834; cv=none; b=dmIin+YjYctyof47gkHqBTf13JhCIR0fv7W2BmecmseJRGcL5PTmEAR4PL/LemqzsiIa53ijA3NeGKj8rGLER5ZHdnls4WUIFIUn7QI5wtr1UemyVMDIQG1pSXQpMmhhmFWfQmECNyKedoqAdBnGDu4QNZsNswEDE71nd+hGzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246834; c=relaxed/simple;
	bh=lacbOxthCgkkyR6dXnWE9rlnEMZa65HnNtHG10j/o8M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Uf0Xbi8RKmuZYt4iBTFnYPkSL1Nqk8sqbvIL+O4xMTZmDhunvtmOlxCQCpQL20Es61bMsL9RXlicZS+y83SjP6f7oM6XmsJHgeiyZ6p3fhogthQv+8ogCKHd+M7ricRmmSmFG02+Q49qozlMdnhOkL9cEqqBnbf08UTdi2m8C9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4RI4MD3P; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62f43c95de4so99961427b3.3
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 09:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719246831; x=1719851631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eGr5jYrJTE1J6jzu9163uNl/vkyYWJDsDpZJUXS72Vg=;
        b=4RI4MD3PgqTjjAw5pfks+vhg964KG9CihzG1gFE2R0bWTMy7IKnmiB4CJ7mvlfxc1z
         fdUkHv2LWc4dCqtSXrsOv92ccr93+QHw5m4Gc1pNaRbVq2vFJSuMgg8jt0nAzG02K5Qt
         tYNGkBcBk16dUzre0+FmyNlht7YOfMVNZfjKFLeKWmf1Yr4FaRkkA63LByrCwFjcDvvM
         7+yTP/KmpyWokJEj6/S2HEWPy3Ei+GRCmXpTFOYPVJoaYwlD/HDRCrOlgMr4RsXHduXI
         EMXFXSnrF1bjxhnHHu6WKumQ8mfL9TDFaZYy/L/rpNvXe+am/4M9NTco6ZbR7O87MDkB
         ETtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719246831; x=1719851631;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eGr5jYrJTE1J6jzu9163uNl/vkyYWJDsDpZJUXS72Vg=;
        b=ijhBTqaBhVLbk8N63ElRkrEzjWA8++ZDktlVLfEWWQYqsQO75UXg8V0N+RV8CY71OI
         aS8xq5OnrjZMS0pTuPNpZYRZM2mZ6liISIuc5pflzZNsj3h/jv4Dky9M6/uCtuq0N9i+
         CBTnoXLRMP2PFEVE1t0L3F5/brZfcD0zpm6I0ndcWw02T+JngRnOJISxw5LykBCmBFip
         gDqnBC+JEUf/j3jI6bciQeuAD/7s23p5TZWQf6ak2FBT6O8LSSuVGdXWKgZ4lg4aQVOQ
         etHHqfkfI/shwlDUJBg2uO0BwOPzVmb2jK6DlbOd0pAJrPb8VW13xdrObRuqkGDfV5Jb
         QcJg==
X-Forwarded-Encrypted: i=1; AJvYcCWubZmP0LRDSzdp4Kp2WuCxgUWRLqiE3FHznDXTTVE4lOFHTw+/OYWvMxrS9q8X7iVk5CGQLUG80vDNO6lat+42kNFLpJS+X8Y4YhTuCSFy
X-Gm-Message-State: AOJu0YyuPXPEwhDx+Rzwnmx0O2po/1W8nUE35WWpPP0sTz8YglSREal4
	s0/0Bjwm2R96qG3MEVRZrijrR7g2F3Tv75Gl+cfhIt+it2AgAhqmnVauWgZGAeaT+uIbPr+SzHY
	CahsJ/se+Vg==
X-Google-Smtp-Source: AGHT+IFWNAMBkg9ApvF/NZnDFtWll70llg5Vd6Kto042q57IhAU/LTqxD97BtYSxq/w4hjglfhfFmzi2FSC5cw==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6902:2b04:b0:df2:eaac:d811 with SMTP
 id 3f1490d57ef6-e02fc598947mr18823276.10.1719246831656; Mon, 24 Jun 2024
 09:33:51 -0700 (PDT)
Date: Mon, 24 Jun 2024 16:33:44 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624163348.1751454-1-jiaqiyan@google.com>
Subject: [PATCH v5 0/4] Userspace controls soft-offline pages
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	ioworker0@gmail.com
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
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
maintained by userspace, especially in case of an 1G HugeTLB page.
Soft-offline dissolves the HugeTLB page, either in-use or free, into
chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
If userspace has not acknowledged such behavior, it may be surprised
when later mmap hugepages MAP_FAILED due to lack of hugepages.
In case of a transparent hugepage, it will be split into 4K pages
as well; userspace will stop enjoying the transparent performance.

In addition, discarding the entire 1G HugeTLB page only because of
corrected memory errors sounds very costly and kernel better not
doing under the hood. But today there are at least 2 such cases:
1. GHES driver sees both GHES_SEV_CORRECTED and
   CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
2. RAS Correctable Errors Collector counts correctable errors per
   PFN and when the counter for a PFN reaches threshold
In both cases, userspace has no control of the soft offline performed
by kernel's memory failure recovery.

This patch series give userspace the control of softofflining any page:
kernel only soft offlines raw page / transparent hugepage / HugeTLB
hugepage if userspace has agreed to. The interface to userspace is a
new sysctl called enable_soft_offline under /proc/sys/vm. By default
enable_soft_line is 1 to preserve existing behavior in kernel.

Changelog

v4 => v5:
* incorportate feedbacks from Muhammad Usama Anjum
  <usama.anjum@collabora.com>
* refactor selftest to use what available in kselftest.h.
* update a comment in soft_offline_page.

v3 => v4:
* incorporate feedbacks from Miaohe Lin <linmiaohe@huawei.com>,
  Andrew Morton <akpm@linux-foundation.org>, and
  Oscar Salvador <osalvador@suse.de>.
* insert a refactor commit to unify soft offline's logs to follow
  "Soft offline: 0x${pfn}: ${message}" format.
* some rewords in document: fail => will not perform.
* v4 is still based on commit 83a7eefedc9b ("Linux 6.10-rc3"),
  akpm/mm-stable.

v2 => v3:
* incorporate feedbacks from Miaohe Lin <linmiaohe@huawei.com>,
  Lance Yang <ioworker0@gmail.com>, Oscar Salvador <osalvador@suse.de>,
  and David Rientjes <rientjes@google.com>.
* release potential refcount if enable_soft_offline is 0.
* soft_offline_page() returns EOPNOTSUPP if enable_soft_offline is 0.
* refactor hugetlb-soft-offline.c, for example, introduce
  test_soft_offline_common to reduce repeated code.
* rewrite enable_soft_offline's documentation, adds more details about
  the cost of soft-offline for transparent and hugetlb hugepages, and
  components that are impacted when enable_soft_offline becomes 0.
* fix typos in commit messages.
* v3 is still based on commit 83a7eefedc9b ("Linux 6.10-rc3").

v1 => v2:
* incorporate feedbacks from both Miaohe Lin <linmiaohe@huawei.com> and
  Jane Chu <jane.chu@oracle.com>.
* make the switch to control all pages, instead of HugeTLB specific.
* change the API from
  /sys/kernel/mm/hugepages/hugepages-${size}kB/softoffline_corrected_errors
  to /proc/sys/vm/enable_soft_offline.
* minor update to test code.
* update documentation of the user control API.
* v2 is based on commit 83a7eefedc9b ("Linux 6.10-rc3").

Jiaqi Yan (4):
  mm/memory-failure: refactor log format in soft offline code
  mm/memory-failure: userspace controls soft-offlining pages
  selftest/mm: test enable_soft_offline behaviors
  docs: mm: add enable_soft_offline sysctl

 Documentation/admin-guide/sysctl/vm.rst       |  32 +++
 mm/memory-failure.c                           |  38 ++-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-soft-offline.c       | 227 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 6 files changed, 295 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/mm/hugetlb-soft-offline.c

-- 
2.45.2.741.gdbec12cfda-goog


