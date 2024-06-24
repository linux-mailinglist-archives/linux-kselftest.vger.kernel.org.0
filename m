Return-Path: <linux-kselftest+bounces-12566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1665A9153F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 18:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C556C287DE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362D719DFBC;
	Mon, 24 Jun 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnEOeL+N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E40919E7DA
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246837; cv=none; b=YfzIlf+p4nbFdoWD1cCtLrpQQ0Wq36nvP2uFZ0K5+hFmPlr7EWDYWUfaqzwFAhn1HcJnmQLGSfpi/wkk12pZusdCKZnR3S2ScWbib+wtR2GZNsdg5mi1SBZE5r5kvVumCpxFHpIapjRxKC3WksjVvFSr8CY6ILs4IYLHDQj+0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246837; c=relaxed/simple;
	bh=pVkOtKaCptTfJGM+OgexYNabmuyK43G7cNJ4MT8MK1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=joEPaUuLJYFSCmOsSLL1Fzmrp2IUKGAgi9auQjOYtoNpYRnlkOJY25l7wiVn6SL/AEcEUZbJ7frMV8wsBL9zT2h72baxI8UDAis3w40n4/dL47SVZfu8q6nwdlkqiySCdrVAPwFKv0Il6kjfNYaKVNl8mXuMcq6iPsJKjvlZ/mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rnEOeL+N; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6e3341c8865so5757926a12.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719246835; x=1719851635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jaVeSRVMUEHHsCQ2CT1Mt2nWqEzTQXYnHsGL8HUoHVg=;
        b=rnEOeL+NaGfJPERg7JBRUd6xfOFjnt8caQSnXx635LA8DZwVQ+KIhf6hQ3JWU+a9Hn
         d+C09b2rnhKnBPCbeS2W5UYcPUPV2Z8o509zgzqUFrCCrd8k4TVSK2aOvxT8VzU8/e5w
         oiO6PaeEmWY8p8ZCsIyJR2AZTqMXnPIKmRidG1Nmnq2+dYlloMUuEFkcGgu6EkkGkkbO
         EUSpY4//9CmiMOiWooVhd8OvFga3qB6K14rfmcvZVWaPQDh6rp8qQMjvkGaQce18NonF
         /yddu8mNGyOyxGd++bhQqGTKfoxAvSO5y0w161gw+KIGhyhD+kPoN8OI+XIiU5yp6qAb
         lNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719246835; x=1719851635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jaVeSRVMUEHHsCQ2CT1Mt2nWqEzTQXYnHsGL8HUoHVg=;
        b=cMRVUgq+HNjwZ5M0HoQdrk0UUeA4C2OOIrV5lIGrFGC2jFXr2zOfhifllF3n2MUIY3
         +4Ky3j3f6KKhdnnvUeqmLzbxciDUMbcJDqfIEhV8bSbHSPhFQ0g449n/DlBMOjB/9Itn
         TtxWmDM893yTg31GuDkqTMwZ5EKOZB6I+95yfyiQVP9JnrSizWnsL7YRwqfkeBNOs9No
         1RgVJkBQdlevYw27OHLq1QTFPW1B3ukSn8b3XwlpYKnNsZcivWRD3QyZmsEza1JhGoKi
         8aoW7gciWx/VxSkSSe9OtEFPE4rT+YHZMQhzrIibbZ2hCImrGZqqxdsr0hVaP+ElgNyJ
         7d9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWohZvT5EOp+isLuhUZphm05x6PePHbET5p88hWlhqzBQF9byZRfL8Dg9SqtrIDTD34HW6n/Tk6fbtRoJclClLmS7G44M/eZtsGt1sxjSHV
X-Gm-Message-State: AOJu0Yx0Hgpt9CWTRS6c1Cl9cBG/vMEWZ2dwTaA88JBzrxTLsTISLIXe
	9sVrf8+rrGU9wNQNHYXo/7/JfI6bHT6Sew+Gp8l6pKjAFpaZH57voVG+Bl0oQURh2wiYhcFmrTD
	er+W/q4C6bw==
X-Google-Smtp-Source: AGHT+IFmjiZXsOh4qVWVE4+iXLz6GybpRfvQXdLXA2xaKMrN+J7XAcxYTT8GInfxKIa7RXbtOwVhCfQSnU4XDg==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a63:2354:0:b0:719:ae7d:9f2e with SMTP id
 41be03b00d2f7-71a35641f60mr18300a12.2.1719246834803; Mon, 24 Jun 2024
 09:33:54 -0700 (PDT)
Date: Mon, 24 Jun 2024 16:33:46 +0000
In-Reply-To: <20240624163348.1751454-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624163348.1751454-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624163348.1751454-3-jiaqiyan@google.com>
Subject: [PATCH v5 2/4] mm/memory-failure: userspace controls soft-offlining pages
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

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 mm/memory-failure.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 2a097af7da0e..0013d338569b 100644
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
+ *         -EOPNOTSUPP for hwpoison_filter() filtered the error event, or
+ *         disabled by /proc/sys/vm/enable_soft_offline,
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


