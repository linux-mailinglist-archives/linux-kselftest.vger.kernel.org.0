Return-Path: <linux-kselftest+bounces-12770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0CC9177E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 07:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 262221C22842
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 05:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D879214036F;
	Wed, 26 Jun 2024 05:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tD6mwDII"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B2413D89B
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 05:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378509; cv=none; b=I3FApBcPAjXTamXpEnI38hsdTgbaf+HzJeGYWlDMtCw/UX4ywrBgWCpOKZRexZZPI9WYF/2aBMsO8kqahuKrpH5Z1OilDhd+FGDUPZqmpMKFEUzkUdxioWVNWoU8vQI4Qlj/1XmtEbxwJz6VsXTPK2FIfj5a8m8XtBCBrno2DNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378509; c=relaxed/simple;
	bh=tcIp/UGK2HdcAnbgBr6MhQluLLHq7D2d16NFgsGLSeo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nGyP6Cmya4FPzBh7hg2623M2kLRdp0hzssAyjJKdGn05ujRZW0gtz+GeqvwJnZMOVzRLIkLH+DAvZN9ctV1WYxcROPex5MLp3nh/XACyKdjMxW6lo6AO37K2sbUoc+SPgpoybMqgf8YC4dcS6Gm3jd48aTCkaXq7ylju0eZZ5nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tD6mwDII; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fa9a618847so24225ad.0
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 22:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719378506; x=1719983306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8y7ao8RcoBqL0KFdl8TvipShcb1ljHNHWsgFR/lOgAk=;
        b=tD6mwDII32F5R37XRlpACf9z4VlwpYscfjH6GhdnN1xWUiIe8KlC//CwxeVyGsr328
         v6jV0vN8m5fK8FX2A7n6aqyuT09Mi5ft33l+xNHeYsIhR+Wf7yrW4KFiDN0B3ObffEHx
         nluxkP2NIFtBujVqQvDIPSeEXct3jpVB2C68REfWj0h4uVdedVG15Fye/NQDotNDJixA
         3R0mG1hC3N9pPY3fs1+hpvesxcaLjlTLqNS+jEmznmXshf5Jom+mv149VOlfDV6mHB2M
         3pCwjwTOCnRWzbYEtTiMbc9hXxcqN83EUtwa05+fYWhRbuhB4fuz/c0NUFZwKupSRyDR
         7JGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719378506; x=1719983306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8y7ao8RcoBqL0KFdl8TvipShcb1ljHNHWsgFR/lOgAk=;
        b=iGb+qNhf4JcbTJOsG3sXg4zSCqMuORjqEYTV8meM95OagBjTssJFi/rTFbw+PHGXF9
         voMaftEpz31JJmAFJt3sEotUkskmjtJXiI1xwqEmsJKpRFVlPng1pXQ6kmAwtBWmWODW
         Ix+JHYiGpFIpCbVjOicaVTXP/GI+GMmUa+Ib+u6DVZhheJTZ53bRz13YkMP10Uy0KfC2
         7nizNffv5fxsCGAyLGoKd9HLOhO4Z667nDAYXEPW8nK2xnPZnI4C6ZqaVBsPkc2hgcIc
         SOs/y9L9zq4n7B/mlFsh7v1Znc9M5rwZuQfiq0T0PxQkr3bVm3TmJDPT5QKHFJV1a9AE
         F9dg==
X-Forwarded-Encrypted: i=1; AJvYcCXM8vtoSb1NVsAOvOOQSmz/wdWKuqz7UoKrlavnxXbjZKumZFIjUryBOxLmk8GdQ3o9sstfpD2AKUIEUZkDD29vAW6Qw4INvdCB3BFPqqat
X-Gm-Message-State: AOJu0YyHE+9qN2InwCoMq/DKWLu9ylsG4UcvLZ8S0clF4PSZzJf2wMqY
	/yVtyUYrqhyCVHnQgh2J07MhmhH4ngpoPusAxDMhzG4kzISeb/tdUASku7twJ9euta/hzipVlRS
	g3fRr7lVwnw==
X-Google-Smtp-Source: AGHT+IFMw6f7MOlDWfVepmO+C1PVKVXo4zQODjs53YFlJ2c1BkCfmt+eu9ZUoQDtHFkvUJpUimIn1RfCeGhwow==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:902:eccb:b0:1f9:cc3c:9dc with SMTP id
 d9443c01a7336-1fa104968e4mr4123865ad.5.1719378506297; Tue, 25 Jun 2024
 22:08:26 -0700 (PDT)
Date: Wed, 26 Jun 2024 05:08:16 +0000
In-Reply-To: <20240626050818.2277273-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626050818.2277273-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240626050818.2277273-3-jiaqiyan@google.com>
Subject: [PATCH v6 2/4] mm/memory-failure: userspace controls soft-offlining pages
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com
Cc: jane.chu@oracle.com, rdunlap@infradead.org, ioworker0@gmail.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
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
index 6f5ac334efba..1559e773537f 100644
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


