Return-Path: <linux-kselftest+bounces-12768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718A19177E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 07:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DBB41C227E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 05:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A1B13541B;
	Wed, 26 Jun 2024 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yJQpeAbR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE50728E7
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 05:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378505; cv=none; b=lL8YFLAJ9Gy5v8K+TNjwjQkdqwMcAdK4fJpmsurlDHa3+flej3PUbE3/v3yvg/SBgTleSjgUHz5wxFZUw5xsvMkIiLvmRI5HT6XDEejLJyqAsLm5o+duin6OngbGLQ5jhOR7DWNrQW4PHQCzitAjwQjankF+460/+iPk4ldeSWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378505; c=relaxed/simple;
	bh=jeEuRsnMW42UDJL4uCR8Lby79ZLU5/csNxUpONX88SY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L4HojHiittq7I7B3njF2hgqY+OMYb/T/S3pH8T3OarExTYnm44+s9AMLytaDKehgvf8klcMEqCa+k306x5XBJ7KyUv2UMBf2Z1UWkfECem5ZXsBtiPBOX8ntywT8geZTp9o+is5rxg1CiL4Da9rl/BC/bhma+7lJjSECxqotL3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yJQpeAbR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7065df788f7so227492b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 22:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719378503; x=1719983303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CGDqphXBU6R+lNPyRUopWgvG7yuYFqi637jqIyNGWis=;
        b=yJQpeAbRG4C/W/M3+obLA27dCf43xhbJ03KYX/s+qr5vdtZftfuXAfUKHqqrEWl/Rz
         bDbhgqiDJbqug826WCOuW8QmzyCGtOgxXynR1nF77WoR+GhqxN//Yvj8B5/Wg80CxGgL
         GVJVdL7wPvnXYcyJybI0gfWhr+yNrwz6P2wOOSru5hPyDg8shDCVIe7Z/reVxwLvQH5b
         xxzUyjJ/Ue/HafxAjQuBI2JdJSblhOlqPjiGqoLb08DmZRlql4KDkl9D34CKtZgYD93Y
         sMSmT+5ubnCcV1wWAQxeT8oje/S5KRdgw11JdSLcud4hfG1EZA0aZCCHUZfqPRPxFPn6
         AvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719378503; x=1719983303;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGDqphXBU6R+lNPyRUopWgvG7yuYFqi637jqIyNGWis=;
        b=Fgxlx8irjiI88KYc0Wf+Bq+BLdYIKp86SfP0xQkCQoEvhyC2CFD3i9szTBDtPYLjTQ
         zBeHycKLCD/usASZgoaBt+UDvpDSFxaE0hDtHAvTkbpatjoErC/IgODqYEm1SxgtYYJ0
         yZs3a88oPMPLHLn8abYoXCfIH63snsgSh36LfvIpinMz/TdtZfhTCPk3evx/Q3SohstQ
         4hau+Tc8zC0xeT38CVzPwq3GzbYpfe6OTGIYtsNVbS0/o6iZrQdvvW3kB7RZ69ksSgQE
         xLI+i5ID+Qy/obQZcCqPKVLbNxdHf1GPQr28aCitvqPSJNveWGIjC+R/9Umkslv3T8Fc
         3wyg==
X-Forwarded-Encrypted: i=1; AJvYcCUfpJOjFPZ/oGQiuBQpyfuV3AYbk1iX+AqRYEefEPjaLwcWsLYMrnFnzr6V9YLPmD13o+1xIiaf6jwMU2lbcDziU3u2CVzdWq7tJOHUMHiI
X-Gm-Message-State: AOJu0YwBXqb9eRbhHMwFQBjRKX02AY4q02IdZIpwWqr4mSXxpDALIcxO
	eCBBT2/NRAf1J15OeY2a/D+CHnKgJIEM8CXiSZyOE9awAS/E9Vp/lIpZ2i3tqWxAAZoNIOC/ds+
	YfdMjd5ZZJA==
X-Google-Smtp-Source: AGHT+IFb+0VOH/8Ji5MJY9Uzpp2NjXzdjAP0KEkJlwDoF3zvJdDZjjCYpaexBLDLoxcxVDGz7IEJNGYV1Aobyw==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6a00:4309:b0:705:d750:83dd with SMTP
 id d2e1a72fcca58-70669e5e132mr340822b3a.0.1719378502937; Tue, 25 Jun 2024
 22:08:22 -0700 (PDT)
Date: Wed, 26 Jun 2024 05:08:14 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240626050818.2277273-1-jiaqiyan@google.com>
Subject: [PATCH v6 0/4] Userspace controls soft-offline pages
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com
Cc: jane.chu@oracle.com, rdunlap@infradead.org, ioworker0@gmail.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
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
v5=> v6:
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
 mm/memory-failure.c                           |  38 ++-
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/hugetlb-soft-offline.c       | 228 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   4 +
 6 files changed, 296 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/mm/hugetlb-soft-offline.c

-- 
2.45.2.741.gdbec12cfda-goog


