Return-Path: <linux-kselftest+bounces-11711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A465690467A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 23:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261EB286877
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 21:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D4C153BE4;
	Tue, 11 Jun 2024 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3D9EYABG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74255153835
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 21:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142951; cv=none; b=IogqoyzQtQUmS4kogr1UnUUkM0FUO7ZRxL/C3GGQlAay5LK8oAhgWXfbAmhmbwTZex4Y/1ddfrlhHzxlD6P71ri205mhbu8B9cpVXqSU5DMNmptlswx2kti8hzr2WGaqDvGHe1gxU7JAjkMI25FfGlLowrdobmDBSu8PFkweh8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142951; c=relaxed/simple;
	bh=TeIh4ZRdAXW2Hf9mptFLzKRzEalNeXXyGMOPn0cwp2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T8tUaL3Mpb9UrdnaSlHO4qhYHi4VBt0MZyVJ6HC5sCxXDFHeL/zoD2BZAh3QBEFCoOWKOGPKt/BRJmJYXFFxqpXgUtFtlsaxWszMr+LCAxm3wX2LCDcfY1N0mgeUKMqe7TfBcGpbxMVNFlhZDzLRxEad2+k5OVPaqQ3dR3WXyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3D9EYABG; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f65539265dso13553305ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2024 14:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718142950; x=1718747750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mS9HbFalMzShQT+POycEgy4uFajHDbIF3DAxgE060+U=;
        b=3D9EYABGpiHgQJNDnhD1LpLVuqluX+BDVEwVdbIxHS7TioT3IadTRxyveIZgyKnpj5
         4SsHH6gbzxK6PXQTLrRPz8LHrGBETRUmPaa7anVNXy79lwBrod0tZcE9MAdgbdG3dQiD
         LkhNK4w/h5p/nwozuIVrsAAz448MZMmhsOZghV9jclFUK4px2LLbSL07yok6SybIzGy/
         I9Ei+0ahP4knNEIlrdYYt1gtcCjpvHQjXZrK1+YM30lQLwmS6Q8HxLjaBasvjHOSJvIx
         EY/MhEpOzTEpSjbmuc7alw4WXsSDZcYLuqHvgPmujnJI3cCGrBH+nEWHiA3r9a6US9e1
         M0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718142950; x=1718747750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mS9HbFalMzShQT+POycEgy4uFajHDbIF3DAxgE060+U=;
        b=PsQLw14i3UDjmmtwHe7YYG1VXCYcZlSJ8USSddiA7IWlDwAjBBlrgIOmPuXJZ6/ZQl
         OYvBTPNz+Jwky2DF+e7FWqDHvXV+1zPGiwmrcG2NwVLbpr2eFI6TWG5VYViSTz/ivzfY
         r/347GcoOOzGvq+JXsAp2iM67noMajrsL4zjraZvt2HIAeMYqkqWUY8bTFGvISbDClVn
         FRQt44CcfMPh1Zdb0ZHEKh+NcwU5akHsU6OFrWw/QIHDh+O1XmCdFAf/27mVunB3mwpZ
         fshzLNsQrUvCoLLod9oQXUgoDg6RqRvUpErC86w0CTXg5WkVk+Vmm6vErNicXoM8oaMr
         DRXA==
X-Forwarded-Encrypted: i=1; AJvYcCXpnKU7icfjLFliD43fDLvS7Dm0b5rsoUK6U0AjYjMDe1eGviYzwN9juxQQvYkEv5L4KwKfDXz79SMtorExkKTCAtlOH5T+buZS9g9PlKKE
X-Gm-Message-State: AOJu0YzBe/hCWfAvjD8VTkdVzxp9hBbf7NlpNbcdf+Y22GD0u9mYOh8U
	hRoiIan2CmpzqdoyLSgynlZdODILcfiUqxVf+v95mceq4HlzK6neKRUf9YeCLqwdWf5SppS1J+3
	fOY1RHovKDQ==
X-Google-Smtp-Source: AGHT+IGVkIg7JWk4rLuAJDkogTWXTNBHCMXhvn7voGGCzQonk6iU8r5R/xu3mAl2mpNPj9KUz+/q9QkmMw61NQ==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:902:c411:b0:1f6:daf7:1c18 with SMTP
 id d9443c01a7336-1f83b5da3b1mr6705ad.2.1718142949584; Tue, 11 Jun 2024
 14:55:49 -0700 (PDT)
Date: Tue, 11 Jun 2024 21:55:42 +0000
In-Reply-To: <20240611215544.2105970-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611215544.2105970-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611215544.2105970-2-jiaqiyan@google.com>
Subject: [PATCH v2 1/3] mm/memory-failure: userspace controls soft-offlining pages
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com
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

This commit gives userspace the control of softofflining any page:
kernel only soft offlines raw page / transparent hugepage / HugeTLB
hugepage if userspace has agreed to. The interface to userspace is a
new sysctl called enable_soft_offline under /proc/sys/vm. By default
enable_soft_line is 1 to preserve existing behavior in kernel.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 mm/memory-failure.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index d3c830e817e3..23415fe03318 100644
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
@@ -2771,6 +2782,11 @@ int soft_offline_page(unsigned long pfn, int flags)
 	bool try_again = true;
 	struct page *page;
 
+	if (!sysctl_enable_soft_offline) {
+		pr_info("soft offline: %#lx: OS-wide disabled\n", pfn);
+		return -EINVAL;
+	}
+
 	if (!pfn_valid(pfn)) {
 		WARN_ON_ONCE(flags & MF_COUNT_INCREASED);
 		return -ENXIO;
-- 
2.45.2.505.gda0bf45e8d-goog


