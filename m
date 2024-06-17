Return-Path: <linux-kselftest+bounces-12079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B9690B77F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 19:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22190B2D9B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2483116A93A;
	Mon, 17 Jun 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0RdWoolO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB5A1684BF
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643954; cv=none; b=QLYbXEjm7gCjMWNyBL/UcyE6gyQpkNfYwQjeXFLV643SeoNTZj/1njn2PyDYX90G5qBpGCbAKAmx+uWSU3rCUQU4I9KBWvF79vlwhGIKo2gNtmZLhZ0GtvtM0amYFm6rWPUakWWcO4t39Zjm0/SYBNwluV9XcyoVJsIPSbvEhmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643954; c=relaxed/simple;
	bh=Gu8A9AYfgQC1Aigf7qPqEvA6BpX8DMbjCBO1dWkHLIo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eF08Wrtvc6Qi/44pO7P2xEdGlWNAn2ik9ZnH0LPaME/6do8x+gObba1n+qzkEXVePydKeuoCzI92rOrU+N0cV2Y1dOlJILEx5zJVf1VaYrBTl2sd3q92WeOiRFUK6vvugOrml1jQ9PWXP1l3rBY91jCRAz9SczL/Hod5RMNSSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0RdWoolO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62fa71fbfc4so85641257b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718643951; x=1719248751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KM/EmQyPzaIKRRU3lBo3RyHuJehGBp5I0jJwxKmg0Wk=;
        b=0RdWoolOyTr2rR0rNjs5Rn+57riblyZXTsiW6IOlAVZnbzL8sfVmGjEn0b0+ZaB8cI
         CDTS+PFP6sQpLeFnhb5KahUt/pb9o4Bvfa60bwZZrmo2D0Yspr8htd+czYSVYwVPZ1zM
         ERbQscjhRY5TcPnzX3hHNy5GmJB147BRT+UipDP2Oci+bhiX26i4MjPhtgp8CNwnEZGU
         xrwpTz1JCizMx+r0JzLzAuPe0sRQdOdJZb/O5LQvJodUzx/CDVQpITy/VZNiI9RNu8AX
         1Czns6ngu2eAPrOO+wH32CjeyqcPA+AHH+dRy48azTSlH/P8uPrdjvUg1RG4V9TpNa7W
         kd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718643951; x=1719248751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KM/EmQyPzaIKRRU3lBo3RyHuJehGBp5I0jJwxKmg0Wk=;
        b=tOcDQK8Utj17H/xsidPj4QMkp0jZHmXsHvG4pO9qs2KQuccn2V6k+cY25FrhJBFnj9
         //r9zo9dkCb4y7s7AD8Mbn1XDDbwfEi2++7l/hlgCHfYRFNY/m4Gb3uD3jUeSGcDmWkn
         bWimhj5Nl+c3uftBMHwNiJcxNgQ7IJwNZM5NSivG061yru/l0NbmWoj/9y43jy4xY+lP
         nddCFWRDIs+zuM5iT72zs8mYB9uKoFfr3/8dgBRGNHuLOOJlNftlYUAo4NjGVR20BWHH
         ed1xoxGkR6SxRtjJ2RwmhqnRJ0ZBw2c9A/FhGkpu1LVaipWPBIAN6WdnfbAQwsw2k5ic
         WsHA==
X-Forwarded-Encrypted: i=1; AJvYcCWB63dOM2LHrGfJ8xTOuWfN7iDgHFSZ0/BuqCnoP8wiaKJmuxkuKfZ7/5c5jHX2VRnNDN7QLKxGqmJ31HEcOPO//6JlIWY1gd7BeDHs6+nu
X-Gm-Message-State: AOJu0YwHKEGlTKy2475aWK9aej/LW7LO5nReHsHjf9pIdHtMyGGWdytf
	NeVMEDU9d/JklmUb0BmUZqMGTXNdoDNbIi+QxpuZ3IZMDndxeLMJvU9q+sG5TRkwQjYcL6REcWz
	f81ROjuj5SA==
X-Google-Smtp-Source: AGHT+IE6i7AwPAxo0OUUZFk9HFUB3axExctM9lLZOhHsVMPD9MZ5+BUeIdWtDZUhg3QZQeglebomfhWpC7C7uw==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6902:1242:b0:dff:2d92:d952 with SMTP
 id 3f1490d57ef6-dff2d92e760mr569722276.9.1718643950758; Mon, 17 Jun 2024
 10:05:50 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:05:43 +0000
In-Reply-To: <20240617170545.3820912-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240617170545.3820912-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617170545.3820912-2-jiaqiyan@google.com>
Subject: [PATCH v3 1/3] mm/memory-failure: userspace controls soft-offlining pages
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	ioworker0@gmail.com
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Correctable memory errors are very common on servers with large
amount of memory, and are corrected by ECC. Soft offline is kernel's
additional recovery handling for memory pages having (excessive)
corrected memory errors. Impacted page is migrated to a healthy page
if it is in-use; the original page is discarded for any future use.

The actual policy on whether (and when) to soft offline should be
maintained by userspace, especially in case of an 1G HugeTLB page.
Soft-offline dissolves the HugeTLB page, either in-use or free, into
chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
If userspace has not acknowledged such behavior, it may be surprised
when later failed to mmap hugepages due to lack of hugepages.
In case of a transparent hugepage, it will be split into 4K pages
as well; userspace will stop enjoying the transparent performance.

In addition, discarding the entire 1G HugeTLB page only because of
corrected memory errors sounds very costly and kernel better not
doing under the hood. But today there are at least 2 such cases
doing so:
1. GHES driver sees both GHES_SEV_CORRECTED and
   CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
2. RAS Correctable Errors Collector counts correctable errors per
   PFN and when the counter for a PFN reaches threshold
In both cases, userspace has no control of the soft offline performed
by kernel's memory failure recovery.

This commit gives userspace the control of softofflining any page:
kernel only soft offlines raw page / transparent hugepage / HugeTLB
hugepage if userspace has agreed to. The interface to userspace is a
new sysctl at /proc/sys/vm/enable_soft_offline. By default its value
is set to 1 to preserve existing behavior in kernel. When set to 0,
soft-offline (e.g. MADV_SOFT_OFFLINE) will fail with EOPNOTSUPP.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 mm/memory-failure.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d3c830e817e3..9eb216ed0b86 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -68,6 +68,8 @@ static int sysctl_memory_failure_early_kill __read_mostly;
 
 static int sysctl_memory_failure_recovery __read_mostly = 1;
 
+static int sysctl_enable_soft_offline __read_mostly = 1;
+
 atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
 
 static bool hw_memory_failure __read_mostly = false;
@@ -141,6 +143,15 @@ static struct ctl_table memory_failure_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "enable_soft_offline",
+		.data		= &sysctl_enable_soft_offline,
+		.maxlen		= sizeof(sysctl_enable_soft_offline),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	}
 };
 
 /*
@@ -2746,8 +2757,9 @@ static int soft_offline_in_use_page(struct page *page)
  * @pfn: pfn to soft-offline
  * @flags: flags. Same as memory_failure().
  *
- * Returns 0 on success
- *         -EOPNOTSUPP for hwpoison_filter() filtered the error event
+ * Returns 0 on success,
+ *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
+ *         -EOPNOTSUPP if disabled by /proc/sys/vm/enable_soft_offline,
  *         < 0 otherwise negated errno.
  *
  * Soft offline a page, by migration or invalidation,
@@ -2783,6 +2795,12 @@ int soft_offline_page(unsigned long pfn, int flags)
 		return -EIO;
 	}
 
+	if (!sysctl_enable_soft_offline) {
+		pr_info("%#lx: OS-wide disabled\n", pfn);
+		put_ref_page(pfn, flags);
+		return -EOPNOTSUPP;
+	}
+
 	mutex_lock(&mf_mutex);
 
 	if (PageHWPoison(page)) {
-- 
2.45.2.627.g7a2c4fd464-goog


