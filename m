Return-Path: <linux-kselftest+bounces-12078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AFB90B766
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 19:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891C71F220DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 17:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F551684BB;
	Mon, 17 Jun 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y5Lmtqz/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A309168486
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643951; cv=none; b=TNTxS4uo8mGVnQzDJUE7rkntJoqx3Mts6ROpv7N/0KsIbPH/qdCq0uKKi+s5ZakRUvB0oawPUOOi0Flb/jw3T8WEwiYaSf3iVSaCNKfWcJHygQqLck+1FncHlkbKXk/strDn2Cg5ChkOJM8VumrflgVlM7ihYsW82kfVGxU1aec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643951; c=relaxed/simple;
	bh=nrb8VcEEmqzCZY0AyheJ4dwjXJaxNn/pRIAkPqq0mIc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CEdR94ug9icxW8sl/11l43g/+ZeVMtodz7g2LxqZmmtUXSWaHKJLR7fNxHCfVEXXTFTth3fEy137ZKuKtr6mriPR7kV50wDXjYhwcHTyxBVRVUDOtKmQ7U/lpT3HXJQOEa9eUjFQCpqP7toEgNpT0UiYHqh/cVA4/zt2eFUjuGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y5Lmtqz/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6338f71a577so49192577b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718643949; x=1719248749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7FfUmROvXWPzNqZLzmg1Chpa3PlFFTPBJMZ6K8GE4k=;
        b=y5Lmtqz/4VmSxMQhjd9pv4F7F9RqAMcRLR5JbhOnN32Yr46WlFr52rDqxfplHzsRWl
         2r79coUO0Sw9aBZoAIXvWR4QQ1FZyRCmBMJl9GTL/qDOM99TPAjP9YhSkktbxMnNSjk+
         TRsRz2dW2j01BWTuykv3JshlpCC8qF7Aq270JjR0F7WoRaCwCx99kczhjWX1tbz8anVH
         CCsr3xfamYlV/l1ynvvRuW7MnUSUoTscHhDhVt9yXxkYJTeYpAfGNepbPkm+XiQkyp10
         5W5SDF6/ty4T1iAMGz52CC19jKKBcR27k02LqeVIP8mu+KLecSVE0tALoLMr3Ew/EtPd
         /TdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718643949; x=1719248749;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7FfUmROvXWPzNqZLzmg1Chpa3PlFFTPBJMZ6K8GE4k=;
        b=Mnl36z2PvFYxA/q6KRMBQw5+Bk2h/QJJ0ixGCtC7DkoR+iX9Xn67lCA127Q7hyfH8m
         cl4/QuOg6fpsGUy8zIbEE3q3MP+I5WqC44KrFyxc94T1koXDvvcqyUTNyZrVq5BovA7+
         CpZgFa+WTDU/7ZuRa+rZ/vMlaizuiIsUJb5c5SgucCUUGgu634/DIZvMN5jHTqYMFGgv
         j6EZbGpTa6Eza4MFfgy8DVTpVAhy44IYt413Q4pTff8ZyMuQ/JZfGpYEhPOByvYEFaaQ
         WSSmKqahDovg4Xk/U6h0/O/rMkmshdDsCMHT5aY8k87ePtNBm3dFjA6Fk0eyt+pS2lIc
         /xQg==
X-Forwarded-Encrypted: i=1; AJvYcCWc6y/qt18YZSeIae9PZyuLDejllX+JZ2qfZCupKwBbQTviG+ElMFQG08QdhGQXoc0tyHW0UnWA3QqszIeFe6qhx+6hz24B3ko81AiWV3Od
X-Gm-Message-State: AOJu0YwFqrI8RA2ig5zDoxabGSXeq288rFYBeoue4PXAHXNf8n74a8qD
	ZbwUq4csyE5esvfZ6PqkWoRD/uQJRUZ3ehVH1s/Jk/f9c+OO9d0vwyUCPg2PFfLxXCI6N4W2N8Q
	XKndBY9JyKQ==
X-Google-Smtp-Source: AGHT+IG6R2axixGQhhzTe7v99HTPI+dX+xPnuaKeod6jwj6XeI/di+Vqf4aBYtfcMff+UqyPSeISN4w3QpoWsQ==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:690c:4805:b0:631:9b3b:525d with SMTP
 id 00721157ae682-63222b588bdmr27182107b3.4.1718643949130; Mon, 17 Jun 2024
 10:05:49 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:05:42 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617170545.3820912-1-jiaqiyan@google.com>
Subject: [PATCH v3 0/3] Userspace controls soft-offline pages
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

v2 => v3:
* incorporate feedbacks from Miaohe Lin <linmiaohe@huawei.come>,
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

Jiaqi Yan (3):
  mm/memory-failure: userspace controls soft-offlining pages
  selftest/mm: test enable_soft_offline behaviors
  docs: mm: add enable_soft_offline sysctl

 Documentation/admin-guide/sysctl/vm.rst       |  33 +++
 mm/memory-failure.c                           |  22 +-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-soft-offline.c       | 229 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 6 files changed, 288 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/mm/hugetlb-soft-offline.c

-- 
2.45.2.627.g7a2c4fd464-goog


