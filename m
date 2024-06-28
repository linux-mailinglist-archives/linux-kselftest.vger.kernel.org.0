Return-Path: <linux-kselftest+bounces-12949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D6E91C7B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 23:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6DF91F2158A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jun 2024 21:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A23B77F08;
	Fri, 28 Jun 2024 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1qMXz7p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0541CF8D
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719608410; cv=none; b=F6745u9X9QK9qGyCubkr57uF0YYiubQ1OIa8hL/8DHL+C7NO6BfPchfS7+PtSdq5r6Q77bbqg0KDOnYfZHEK2LrbYT65lw0ehIGFX4mGdRRZQ+eKy0UiMIJUsddHTFycf0N/Q9tZ7So2eEst9uKiQre5zzVWOZx6LNP0KwmzSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719608410; c=relaxed/simple;
	bh=RvARpek5oB1OiKMp/udcOI/AnnOjzh0gz3imanKMPKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l90RFlrZNcg5ymjtfhCqvjPzYAtWfd3BCws/Yt9UHPcLzWyyecGQK0KGRRV8uSpElfD0VvEfpj6d1ADikTp6tvNc9Al9wLK1yyqHCWItnrhtHgODhOE2lUm9Z4MEP+li5pC9uRRI5Po6Yc7SUCEFDejt0IxnfGC9CRFQV1V8FBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I1qMXz7p; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-706645f6ef3so1003036b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jun 2024 14:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719608408; x=1720213208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K55H9E0t59nm9KeHZLiBbB7OkhvKOcAfSENsb6p/u6w=;
        b=I1qMXz7pXxE6seAHTUlK1V6nEGcHaM+2BB6KYT/YOmDzxcDQdPBWX1+fEh3YDE0Ixp
         IwqtfuvnRKfOrCyTwelO+9qpbRTB0DZT/r6HWvQ0HntUqJ1zRfdhMT69VhzWp446lroX
         0DFhZ2fAEWFbZDZRBH6CBGNtJTrhygM7uVJSp85lP9Uewld7xmqeyWLR/T8Znu9RnwBR
         30qd07UGpAJrxSuJmNXRLIGMIGgUB4YMU0QElyv/4rLowvMAj0yELvoTwI3FjffF9t/T
         JqLiv3ORPya+d1TsimEdGxZGBqHyXlTRRn3Xw2Bx4Q+YXhMWMB0qqgaHooNEKA1UHUqV
         QfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719608408; x=1720213208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K55H9E0t59nm9KeHZLiBbB7OkhvKOcAfSENsb6p/u6w=;
        b=AyjLJCzCGH+WkKWKnFo5zUVG5od+iff8R8owDcrEDRk65PlLhqQZw+0oyAzWdqbKYq
         eYshUDydlTPzcif5hI9XuHf1XwMMjfuLoQPs7q7SFb61enQczusFLavjDnTGVaAf2M51
         u6NnFINmPm5xPAJrNrOo8EfCQ4XIqk/YZqPcSxRB2+sRIBjO0Q33mfri4JeQ9E1W/IO/
         287N+E4Ht6eEHTkj8y93W9Sh3V9DAE1/ULUmQZfvHs9aWC4UxsxhgDBYLR1mCQruDuN6
         57uiGAYaWF98X7Y2cuGhfGEU6kn2WlSb2d0HFxOQwOl+7hhtdzsqk5+zew3v+oD1aFCe
         nCyw==
X-Forwarded-Encrypted: i=1; AJvYcCUbN1i/+DioW4Rz2Nm1zR70Y+p73mWzfxNwGXMGwwGBV5KiINHfJUSTWtqFbBnKJtc5xewK2epB1IAnwUdYP33KinuvzUpNEz6OQSijdygk
X-Gm-Message-State: AOJu0YwTq0dZeYwg8oQqUtLOGYP6SsTWuV46oTdvEwb/AYJa1M914Fye
	neIAY69JvQ/KCl0h+XnWJkm89mi0r/0sxZNxqBDCPTDyERgycp/h/Hlc0Tf8I8duBsmsSubWycZ
	FrehRJqSU9A==
X-Google-Smtp-Source: AGHT+IFbZGpVVtA+GUKb/6c6jsaI0OiKjqock+AA+pWiWe+A5unyUwPSLs/SOm+K4zdLrXzAV8wcIH5VRSCYXg==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6a00:3698:b0:706:6b52:43a7 with SMTP
 id d2e1a72fcca58-706746db53fmr184314b3a.3.1719608407790; Fri, 28 Jun 2024
 14:00:07 -0700 (PDT)
Date: Fri, 28 Jun 2024 20:59:58 +0000
In-Reply-To: <20240628205958.2845610-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628205958.2845610-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628205958.2845610-5-jiaqiyan@google.com>
Subject: [PATCH v7 4/4] docs: mm: add enable_soft_offline sysctl
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com
Cc: jane.chu@oracle.com, ioworker0@gmail.com, muchun.song@linux.dev, 
	akpm@linux-foundation.org, shuah@kernel.org, rdunlap@infradead.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, ak@linux.intel.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the documentation for soft offline behaviors / costs, and what
the new enable_soft_offline sysctl is for.

Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index e86c968a7a0e..75e22137d849 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -36,6 +36,7 @@ Currently, these files are in /proc/sys/vm:
 - dirtytime_expire_seconds
 - dirty_writeback_centisecs
 - drop_caches
+- enable_soft_offline
 - extfrag_threshold
 - highmem_is_dirtyable
 - hugetlb_shm_group
@@ -267,6 +268,37 @@ used::
 These are informational only.  They do not mean that anything is wrong
 with your system.  To disable them, echo 4 (bit 2) into drop_caches.
 
+enable_soft_offline
+===================
+Correctable memory errors are very common on servers. Soft-offline is kernel's
+solution for memory pages having (excessive) corrected memory errors.
+
+For different types of page, soft-offline has different behaviors / costs.
+- For a raw error page, soft-offline migrates the in-use page's content to
+  a new raw page.
+- For a page that is part of a transparent hugepage, soft-offline splits the
+  transparent hugepage into raw pages, then migrates only the raw error page.
+  As a result, user is transparently backed by 1 less hugepage, impacting
+  memory access performance.
+- For a page that is part of a HugeTLB hugepage, soft-offline first migrates
+  the entire HugeTLB hugepage, during which a free hugepage will be consumed
+  as migration target.  Then the original hugepage is dissolved into raw
+  pages without compensation, reducing the capacity of the HugeTLB pool by 1.
+
+It is user's call to choose between reliability (staying away from fragile
+physical memory) vs performance / capacity implications in transparent and
+HugeTLB cases.
+
+For all architectures, enable_soft_offline controls whether to soft offline
+memory pages.  When set to 1, kernel attempts to soft offline the pages
+whenever it thinks needed.  When set to 0, kernel returns EOPNOTSUPP to
+the request to soft offline the pages.  Its default value is 1.
+
+It is worth mentioning that after setting enable_soft_offline to 0, the
+following requests to soft offline pages will not be performed:
+- Request to soft offline pages from RAS Correctable Errors Collector.
+- On ARM, the request to soft offline pages from GHES driver.
+- On PARISC, the request to soft offline pages from Page Deallocation Table.
 
 extfrag_threshold
 =================
-- 
2.45.2.803.g4e1b14247a-goog


