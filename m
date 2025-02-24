Return-Path: <linux-kselftest+bounces-27352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB87A42493
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 15:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36704443D7F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19D22512D0;
	Mon, 24 Feb 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYIlqsAV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4EA24EF7F
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408454; cv=none; b=i+yQHkv08viOD7powECZ/+46kiq3hXqxP7DE7zYORXNIeC5tu9gzCA7qHPcgSLtN+KIpBztENeqeP8GveF+G2v+dJRy8B1sESZmL9NXablaK+3jnezM5hpvRPeM1YWspSodyNDe+whWc5CRY7lzP5QJC0PmddfRbYvsqalTrgro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408454; c=relaxed/simple;
	bh=E+1O1rAL1bQoC3910IAA8+5w8gcxHtPnJaOqoJosgNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tJXh3XnVAp7CZS2XkycleDFsa/GTonz9sU6yfMnk1l/YSRA8tLbb7EHD76pcUiugbagXLSZRBna5/f0aSw6DtjERkdfapbHZIZVLJMQcTQ9J2E5uiwfRjrQJn+atn9OjCcRyrJ/se5QKWbRjApgSOkrEcjF5rG5LT4+9jlMp8K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lYIlqsAV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43935e09897so31879945e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 06:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740408451; x=1741013251; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GCHGbSH5u71x3rPQwLU8VHf0HNWJtt0XTaDImu1fyhU=;
        b=lYIlqsAVBPlBXFDqoacq35h+XbpIhL1xPW/D5XXuNfi6etUPeSdzZXZxYXjHT+kFxb
         QRDu2q97NhXuNYPtvJY2e6wi7WPdI/7QFLgcwrnSU5EcHJtG/izSzCrXZEMkrV5rBn7s
         zeC9Zifm4K+7J1ovi4khGg0RQtB0zMoFc+pqX/aforQ8B3TAoMEXRicuk4+EIKpmX0kw
         FCGKCyr8vSw8O9lurmvl8D+Mji9wdXDbfGp0rKdMuXWCD7bSWlx/bBwpbsMyVTIFahJn
         G9Nlq/u3RHnUKaheKHCLIp4X2B6cQz2EVaLrBP5SI3BphcP/GnUQ43fEjsWhOdSL85wU
         WRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740408451; x=1741013251;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCHGbSH5u71x3rPQwLU8VHf0HNWJtt0XTaDImu1fyhU=;
        b=c8+ftyNJF/YTF7RV6qgWTT2LWHpxqzV6Zu8HDMMqsPs1BnP2W3R9g+91CE7LGer+M4
         RjkHs2GwWA2K/WBU6RdR4O3MCrGnoBsFJ7Y2a7+umHJ1Y6HJ24j7VKA57AkyVk7E0te6
         1MRUE4mdrWPuzb/zOpFNq3iBevciudRcBHooMWfsXfUaG3nCvTNdtDDckAU4+lwQD4ee
         vWXA5HkeL9NmHeQAPNDpS5S7oSIsepWQRGKji7DaDbgxbj9BojN1QjP2FWQTKTiPxhsH
         Ybjj11hnJzNj1p6xUrE4V+5f4egr8PNNgJSRgrrx5nbQrWkXeV13XfYmT8jQRKjY7rxZ
         /WlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtvcgx5bDxkzCK5fMtXN/6h6QhGV/V7wm3p87fbmbwdSu8HXEA/6dbMDMKEG1dqTiyOvipl+VkMAtgkmBitCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWA1It2bdCD0vOrmaPV3S5HRQwVF0a/ZObqJsfkGPHR+b3lGKT
	0HjsRO3b1r3tf8hfFD/7VI+ZTGURtXIDF1OcFVKDufebFx8APy9/j1nPVcKhvK5cFu32yietmxh
	0peD9sGz5Nw==
X-Google-Smtp-Source: AGHT+IFwIHbdkreZNxpIcvirfoEEWXDLZ8e9Qs1I57U8z8tdFzGqrcazUy7/EH9Qq/dKoOv0alrn0GIwiDqq/Q==
X-Received: from wmrn16.prod.google.com ([2002:a05:600c:5010:b0:439:846f:f9c8])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fd3:b0:439:9543:9488 with SMTP id 5b1f17b1804b1-439ae2196a6mr90807405e9.21.1740408451368;
 Mon, 24 Feb 2025 06:47:31 -0800 (PST)
Date: Mon, 24 Feb 2025 14:47:12 +0000
In-Reply-To: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250224-page-alloc-kunit-v1-2-d337bb440889@google.com>
Subject: [PATCH RFC 2/4] mm/page_alloc_test: Add empty KUnit boilerplate
From: Brendan Jackman <jackmanb@google.com>
To: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Michal Hocko <mhocko@kernel.org>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Brendan Jackman <jackmanb@google.com>, Yosry Ahmed <yosry.ahmed@linux.dev>
Content-Type: text/plain; charset="utf-8"

Add the Kbuild plumbing to create a new KUnit suite. Create the suite,
with no tests inside it.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/.kunitconfig      |  2 ++
 mm/Kconfig           |  8 ++++++++
 mm/Makefile          |  2 ++
 mm/page_alloc_test.c | 21 +++++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/mm/.kunitconfig b/mm/.kunitconfig
new file mode 100644
index 0000000000000000000000000000000000000000..fcc28557fa1c1412b21f9dbddbf6a63adca6f2b4
--- /dev/null
+++ b/mm/.kunitconfig
@@ -0,0 +1,2 @@
+CONFIG_KUNIT=y
+CONFIG_PAGE_ALLOC_KUNIT_TEST=y
\ No newline at end of file
diff --git a/mm/Kconfig b/mm/Kconfig
index 1b501db064172cf54f1b1259893dfba676473c56..1fac51c536c66243a1321195a78eb40668386158 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1358,6 +1358,14 @@ config PT_RECLAIM
 
 	  Note: now only empty user PTE page table pages will be reclaimed.
 
+config PAGE_ALLOC_KUNIT_TEST
+	tristate "KUnit test for page allocator" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds unit tests for page allocator.
+
+	  If unsure, say N.
 
 source "mm/damon/Kconfig"
 
diff --git a/mm/Makefile b/mm/Makefile
index 850386a67b3e0e3b543b27691a6512c448815697..7b8018e0e6510881fac6e4295fdd1472e38d743d 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -61,6 +61,8 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 page-alloc-y := page_alloc.o
 page-alloc-$(CONFIG_SHUFFLE_PAGE_ALLOCATOR) += shuffle.o
 
+obj-$(CONFIG_PAGE_ALLOC_KUNIT_TEST) += page_alloc_test.o
+
 # Give 'memory_hotplug' its own module-parameter namespace
 memory-hotplug-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 
diff --git a/mm/page_alloc_test.c b/mm/page_alloc_test.c
new file mode 100644
index 0000000000000000000000000000000000000000..377dfdd50a3c6928e15210cc87d5399c1db80da7
--- /dev/null
+++ b/mm/page_alloc_test.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/errname.h>
+#include <linux/list.h>
+#include <linux/gfp.h>
+#include <linux/memory.h>
+#include <linux/nodemask.h>
+#include <linux/percpu.h>
+#include <linux/smp.h>
+
+#include <kunit/test.h>
+
+static struct kunit_case test_cases[] = { {} };
+
+static struct kunit_suite test_suite = {
+	.name = "page_alloc",
+	.test_cases = test_cases,
+};
+kunit_test_suite(test_suite);
+
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");

-- 
2.48.1.601.g30ceb7b040-goog


