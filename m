Return-Path: <linux-kselftest+bounces-12354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A577191115F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 20:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977591C21543
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096421BA06A;
	Thu, 20 Jun 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nmmrU4Ix"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5331B47D9
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909344; cv=none; b=mpy/xC5FMQ5crZlWfhiDTv8zJEXypDDPy3gN7PW0Fhx8ZN+FpnSZQQ1ePd5kvU1IQG7i1FJ/8JWz+DxekxTR44etZJKErf369A3lCXx7l/WaisCEFmKJytiMACnG8Bh5alW4/XwXdNs834Nq8wAknIAti0cgsVJo0/6t1tYpQbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909344; c=relaxed/simple;
	bh=0UdOCczW7R86+kDUSQgo4G5iSbtYqPKnphLsunWLTVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gcWvZyqLJZQSCpvks6eIrqgAhi0wBswwH7vhchwjMDhzb7ztw5MQ50hHVmDMO9avrN7dBWc+RPVKXLcWYoXjpczf/pkJC6cRXUPmMumBmdeNmuf9o2a7nuoZ2e+AhQ7GAKtxPveW8WC94Aibb2GSBb8lSCO273o05hT07oIN6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nmmrU4Ix; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6e82b36467eso1345530a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 11:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718909343; x=1719514143; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HH+9CcttK5GdfJZnghTUQdGY7/vHW0gb5YShHVqiKQ=;
        b=nmmrU4IxAeW4tsY/m0/nhWFp21/C9SgAm4A6jFmiCvJcW9OnzbiH0GaduPreOdWnqD
         pZ43aKS0Ae7VicL/uci5bLf82r6VcFCDlb0hogNx5O3l09sxHCFuw8qgfZ4xr0mKVPi0
         XPPUU0cXDegn+B+qE02ZfZ0YftZLf8YnRsOitSY97NAUWR/pzOn32aKverYiBVXMT4XV
         ZlcXDC1mTV0pNGCfZ3UnJhw2Mj4iXyG2praEuIYLnvmhrV6Ysu0CNZOba7i/XWAwTq/G
         xDbAr+nqyxkXkN7tIKL/cf/s0UQI2kWKEfLoqDmFZl2nq6bUzhQHzG5OVmEeqh4lLIPV
         9UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718909343; x=1719514143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2HH+9CcttK5GdfJZnghTUQdGY7/vHW0gb5YShHVqiKQ=;
        b=FPoFRYpcMVUY0ACdMIK0C60w4w+mKTwUn4ki1JUFeLqOI3JT/MaHFXS4dA/cCCURzU
         FP9sT173/XkMGV16XIygC0cp6O3AL9BRxeWSD7ccrb7x6/D0AYHBCnAOrzBz8lU2cJmT
         oduLldTWZba3bdhh4w4qJV25hdEuGw8BV0x3h6EbSg6agJ068VVG5oblm+uSV+oHYoSl
         kzvuukyRO4KqH7E8RvMSWT3stq0mXsNknVDTh/muTUnq04dOdIL12O9Yar1bsizF57AE
         O8Pi2qn+MRhfEjsZeHMX3jYaD91wjMiYaT12r2wCc1O8MoNPu9KZ+jCP/ZOnqa23dDNM
         cRyw==
X-Forwarded-Encrypted: i=1; AJvYcCWSfhzAUgOtZIYe0XIJ9oXQqpcd2wawkxbi/iQIwgzXbjjuEeatKnAxAQAQKSi0eShpib1wwDlWuntxT/wHaK1dw+47q2/DBcIGiIPW37gJ
X-Gm-Message-State: AOJu0YymMmOe8TcrcfYf1ZIX0dEC/wHqnZlKEEcE5PzsKE65cdUp9J/m
	Xid76fWB0kdFaAZwJ+wfZV6hRclVhlWpE3mcYEMcs53QO0VLoqrnJSYskj9dHgP7Kd2qqMAG6dP
	ZQg3noBvdHg==
X-Google-Smtp-Source: AGHT+IHCsKQY1SzbhPGtb+37q7POGRig59xntnButnizlbSZlNSEHkAssfeNabPHgq9LHWi5d8wkBGQwyLwzZA==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:903:124c:b0:1f6:ee9e:f602 with SMTP
 id d9443c01a7336-1f9aa3cd264mr166835ad.4.1718909342518; Thu, 20 Jun 2024
 11:49:02 -0700 (PDT)
Date: Thu, 20 Jun 2024 18:48:54 +0000
In-Reply-To: <20240620184856.600717-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240620184856.600717-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240620184856.600717-3-jiaqiyan@google.com>
Subject: [PATCH v4 2/4] mm/memory-failure: userspace controls soft-offlining pages
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	osalvador@suse.de
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, rientjes@google.com, duenwen@google.com, fvdl@google.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Correctable memory errors are very common on servers with large
amount of memory, and are corrected by ECC. Soft offline is kernel's
additional recovery handling for memory pages having (excessive)
corrected memory errors. Impacted page is migrated to a healthy page
if inuse; the original page is discarded for any future use.

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
1. when GHES driver sees both GHES_SEV_CORRECTED and
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
 mm/memory-failure.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2a097af7da0e..623aa93aff5a 100644
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
@@ -2749,8 +2760,9 @@ static int soft_offline_in_use_page(struct page *page)
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
@@ -2786,6 +2798,13 @@ int soft_offline_page(unsigned long pfn, int flags)
 		return -EIO;
 	}
 
+	if (!sysctl_enable_soft_offline) {
+		pr_info_once("%#lx: disabled by /proc/sys/vm/enable_soft_offline\n",
+			pfn);
+		put_ref_page(pfn, flags);
+		return -EOPNOTSUPP;
+	}
+
 	mutex_lock(&mf_mutex);
 
 	if (PageHWPoison(page)) {
-- 
2.45.2.741.gdbec12cfda-goog


