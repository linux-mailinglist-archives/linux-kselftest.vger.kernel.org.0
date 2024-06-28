Return-Path: <linux-kselftest+bounces-12946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498F791C7B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 23:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9431C209D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 21:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3202E7D075;
	Fri, 28 Jun 2024 21:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G1KUlgCA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1476C76
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608405; cv=none; b=JnbjPprdjcV+t+TW57Swh/Y+ipdZB8Lslg8V4dL1zCUcF5HaYRuKacml2eX/WOIyrDcoaCkvpjljwPqLK/1zN+fyn8QtWP4l5P85cyINkqOFUW4qTJ4cJsGruIqIo2SLq3pAsHWGrNv8QHBTd4YzSYONJfpnzuu5Q30W1kTADCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608405; c=relaxed/simple;
	bh=UAPqb+JNmQrB49up25N8O7cnzwrMhoXoMbtq6J/VFLs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PQCOoc6/PmglvKmrkUNo/rd5kLbO3H4TuRvsfW5UHvrNqt25ZRkkJeph1q0oUwkyYKVsqo4BJ8PniYYT37nv8PD+PuTVsdXXYvWE6pfz+ZQEhY6XelpcZVT533nBTfKVns+olMxB3qtnxtT/+STD5ky7ajn57J29ivNb0B0ygFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G1KUlgCA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62f43c95de4so18064407b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 14:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719608401; x=1720213201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H9SemWeck9sqZhF4PUkpmqs6CWCt5ZKMH0k65qfYp1Y=;
        b=G1KUlgCACJUHtii6tGiKYUpcWUhM4r5wfNb5Szwf3XQc75Y4YD5L7zyFOwpxG9A2sw
         fpJpz+uoa4Ufz0yUQmqQnOXJCtWX7elHkVtftaDnloc2XJOJ3YB8xMD7cC+C27/MwM5j
         FefJZKCVZTCul2jStJgkye6BVvZpEB95oHC51aPrgKt5fpEOmLh/EMy0oZLZotX4ri0c
         YV3wj85bgYzeDWl6bbT1Vav7FLO/6VzVmVjS75+5AF7tx4PDr3jl1ayevmb1b1RUad+Y
         Ncl9KFHs/YsKZ66+95K6/cTj/maFkUGUUY5Hlmc96TA7iJ/xFCtXLm+0s95OBNvQoist
         Zfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719608401; x=1720213201;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9SemWeck9sqZhF4PUkpmqs6CWCt5ZKMH0k65qfYp1Y=;
        b=hKG/STlxD3AVJ6JSnd4ohKfXauOCpQlWnD8KCFe8yrKLn92lPkqPV1o6LLmy3Q2kq5
         wIt2pOz9dVo9nx6sRzlqulJ5eKDlX78u3oi0fBIlSC2F0w+4CQId47tqAuA7nvWc16lH
         +T+DAlGu2a2JthXWAtX9iv/0BRnq83nRWAUzhYYa3R9IXllQQ6G+c4HCkbc4MEIN5iyf
         I9rcfu8qE+g4OByV90StQ2IdeEnVixgm1FPo0OqKA1GTamr/7gz777agInARrpBHZrWG
         bM43rPwVBxQrxbbXsc067cLq25yx2ZFQQfeSOeEsThfxq3a3WxRMvBHG6jmq89Owt8tF
         sqdw==
X-Forwarded-Encrypted: i=1; AJvYcCU/3mft1fepOacgdxVwoEWZ4kT0Zf9MUCKuckUE3sEwRFGTGPBPEy04QoWmtztp7Sd/Iw0EBWdpqi+OV8ygFjkRt1+K7DxjGW/w+qfamICk
X-Gm-Message-State: AOJu0YziiZ3wTv8MU3vw5FaaF5f76hm7UDrB1ffCatlcIWJlSrgloxWB
	/YfPS0T02ZhC/TQ9HhuGRhbgs0ZJLrEuLIgDTuGhv/RKUmphgP8B9ZLzAf65ifRylAm6IGF/r7L
	d2FCcpPcAcg==
X-Google-Smtp-Source: AGHT+IHuT2gN9XPtmf5SVn4cA59errpT4hxsDy5JZE1D+/oWILvq0fkQTnieruKPvX36J5LvENb5Muq2Vr+jNQ==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:690c:e:b0:62a:4932:68de with SMTP id
 00721157ae682-6429d26f55emr814727b3.8.1719608401004; Fri, 28 Jun 2024
 14:00:01 -0700 (PDT)
Date: Fri, 28 Jun 2024 20:59:54 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628205958.2845610-1-jiaqiyan@google.com>
Subject: [PATCH v7 0/4] Userspace controls soft-offline pages
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com
Cc: jane.chu@oracle.com, ioworker0@gmail.com, muchun.song@linux.dev, 
	akpm@linux-foundation.org, shuah@kernel.org, rdunlap@infradead.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, ak@linux.intel.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
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
v6 => v7
* incorporate feedbacks from Miaohe Lin <linmiaohe@huawei.com> and David
  Rientjes <rientjes@google.com>
* remove PFN value from enable_soft_offline log
* save/restore enable_soft_offline in run_vmtests.sh
* v7 is based on commit 7c89bdbd3778 ("khugepaged: simplify the
  allocation of slab caches")

v5 => v6:
* incorporate feedbacks from Miaohe Lin <linmiaohe@huawei.com>
* add a ':' in soft offline log.
* close hugetlbfs file descriptor in selftest.
* no need to "return" after ksft_exit_fail_msg.

v4 => v5:
* incorporate feedbacks from Muhammad Usama Anjum
  <usama.anjum@collabora.com>
* refactor selftest to use what available in kselftest.h

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
 mm/memory-failure.c                           |  37 ++-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-soft-offline.c       | 228 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   6 +
 6 files changed, 297 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/mm/hugetlb-soft-offline.c

-- 
2.45.2.803.g4e1b14247a-goog


