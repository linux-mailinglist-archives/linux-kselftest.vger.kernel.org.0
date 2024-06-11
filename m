Return-Path: <linux-kselftest+bounces-11710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADA6904677
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 23:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B8D1F23B31
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 21:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A17415382E;
	Tue, 11 Jun 2024 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vffE8ZYw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4C4150991
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142950; cv=none; b=K8Jq6PtvnhQ+pJ9o043NRMel9LUUgzRjtudeaQ8NmEbBMWaumhANBdSJaTQKd/j4KUDSvgRQiY8cCma+8lWst6y2P9xUZinsRsAdsdepyiHWHb598Gyy9VMGfr+RivKLWMi5FjIu6lj3RHVxFxmFppY1STFuGmhkqrp6FxyDYTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142950; c=relaxed/simple;
	bh=n5fLlB74qN5GgQ8uPf04nzD/7RIUObhD4Pla0tmxksw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AdNITKa+b3sYYEllDSjqmi1J3Dg2X0eKVSZr5ro+MLnWt96yh3h64zQLo9YiZ93jfofECCgv/v3TNW8vBNmh0YOkpZIeb0pljcH4xtziUTGtyGGAKns0W39wssIOSP7wo/nN6olYbVSLPPX60bPK6XpzDq9e4FAKp3glj14+4xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vffE8ZYw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f68c07cbbeso41370485ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 14:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718142948; x=1718747748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jj8YgqrXbXlWU/XVvADXYq9uceGyByggX91FE/iL3i0=;
        b=vffE8ZYwbIYenwEcEncR9cj8SKlIbLkQ8oJq/NdupTijBRVay4xwyncQZiJX4o1hn+
         qSG757uFDVrII1rRpTBWMV7111NFXz8TpjXGqcOX8zbujLQUhWuBnx9DW6CddfedP9rP
         Rjspp2aEDofXqZFFURJgAf/UeXewb9eICWNVxH8xAxJyiP5hGfYbTEGvqKaSg9afpMN3
         RGX2Xrm2R1oPVaoXVI4P0GI8OulDblsfZKKBkuNtAln3G2gBMJNSY7zV24CWMcvz7btp
         n/skVA9RNbpdxwIfNbeutHySdLkr93R/wDJyxALndzt7EWL4iENsRILW5oxaAaafOSq9
         1bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718142948; x=1718747748;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jj8YgqrXbXlWU/XVvADXYq9uceGyByggX91FE/iL3i0=;
        b=fi8pykAMn5mZtccP4m15nkrH2TuU7G6kecknn+4IsWKthHjTyYS+6jJZbfZEX2tsKA
         jQvPk5i2GZoFWCBFfiE56PU6/SD5eJaAEVjlw6tInw33tbaBi83GR0JUSFDlWP24x19g
         80g39/Au4xNjo/NUpMJxhecBX6WyyFXCiDfiplU/w6K4pzS6jPbj2D3zSR7ZLmDlIg/e
         PXg5ZfRQVg6lQppOtS4+FhLJsDX+sk7+DcGZxXPzqsx5kLUOn5ib4pyYh7bE69moq10k
         AgQHxyUuZEfp+8QKZnKp/zTcr9z53WButeoy+R9aGiEDAOMmMHLCXrcANUCDhFzAo0BU
         roeg==
X-Forwarded-Encrypted: i=1; AJvYcCUwjANBF48rhqDIo2fp5o5uEG4BZ5obKDfyKy/GL0s+NNm6QscB9asuqIC5EC9giaqKXpEOnpLJ3bskEIoO2ME1dm5CrS3Ky5Exwlwmv4RS
X-Gm-Message-State: AOJu0YwU12R9DG71QtbaWSKde6dilnh/BjF8vV2sOT6wKtivVmwsNNKB
	u2/JbXKgVOLjjzYOw9RthYTnvLKTARLPSCFpcd+Nokt2xv3ZO7/RnJ4lG+H6/X1CaHSB/7PhntV
	EMAF8aPdiJQ==
X-Google-Smtp-Source: AGHT+IEYPPG9JfHp7uLek7ysPZ+oTxIHFHCXuoWTRFqA/sqnS6jFOn+oGbLU6U4URlsA1/KoSA1/1J+iH4tRJg==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:903:22d0:b0:1f7:165f:3eda with SMTP
 id d9443c01a7336-1f83b55b13bmr5265ad.5.1718142947927; Tue, 11 Jun 2024
 14:55:47 -0700 (PDT)
Date: Tue, 11 Jun 2024 21:55:41 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611215544.2105970-1-jiaqiyan@google.com>
Subject: [PATCH v2 0/3] Userspace controls soft-offline pages
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com
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

 Documentation/admin-guide/sysctl/vm.rst       |  15 +
 mm/memory-failure.c                           |  16 ++
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-soft-offline.c       | 258 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 6 files changed, 295 insertions(+)
 create mode 100644 tools/testing/selftests/mm/hugetlb-soft-offline.c

-- 
2.45.2.505.gda0bf45e8d-goog


