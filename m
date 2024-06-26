Return-Path: <linux-kselftest+bounces-12772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 157E79177EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 07:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C072B283198
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 05:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135AB13C810;
	Wed, 26 Jun 2024 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VIyIwzd4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA77913D635
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Jun 2024 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719378514; cv=none; b=EJDD+7xiyj3JzXBZ8iiGB1rLJmy2KTDPdhiA4We2peCp2RG4Q6f0OsXmeyS6kYduCwUY2NJyfFUU0lq65QbxFIC0qU05gg85uLeVuf+Uq3wIj25NX2VLub3O/1VDVHR/indgAGAAFGah5Diewgtl/tOUhpqE7x7KSKQ3dPKVYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719378514; c=relaxed/simple;
	bh=6RTswbAavt5pcU+GjXWq0ODhw/9EICs853/4bjB6N8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H2j/gHiJWzcGXLvqY6KMt49wHrpWFDB9eE5pAY8OXM9q3a7RaVi3pd5eO2fRNVJesKwrqDbuOwMdzfVnXzSzOn6PyTjxa1FcwH+Z/w9wzf9vTe6FNIn3aGRhIBI8SYVC3KaNn0n2CX6W0Mje3jxzhFvVtODJPeM+f8mfzqTsstc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VIyIwzd4; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e032d4cf26aso2115201276.3
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jun 2024 22:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719378510; x=1719983310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fs5YbFk0qJzpaxZmqawYh52QCdlQJr8uKPRepM7gFQs=;
        b=VIyIwzd44aKZC7G4XzySnl/zVWyQhq1Owrj17ZvNhK0a4AyKc9CpoPpQIx/AD7qpLi
         ZOo7Xwj0DuxHmAMpdjJAin2QIeXKXkM8Crg9itk6en/JZWL6B+PnaJj+4GhCGjfLdm+b
         9a7ZNhVLz7KN6lzySDtGKlKU1jO+7w3fsYvMzyRp2G9H9YS/SwrTwpZLdJh2S5QHEw6I
         uXGvSXTq953VN180wdsJt5AyEkYpOH/vImRR7WE9pebFEAANxGM9fagUBCHJpZytLSye
         dctycQnz5mQJNzpPN6vh2ny+1N4wPog5L0OZHELZiUnCxjPG2cp+IjmuGZzUKpHZJASI
         43Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719378510; x=1719983310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fs5YbFk0qJzpaxZmqawYh52QCdlQJr8uKPRepM7gFQs=;
        b=facXg78C6xWL5xaCtGCqeDSzU6NTVeMbAZ6Y7pz/xp8Bb2uIo4jFcvlj7R43eXREmc
         nQBJuBmw3z72ZiPa9YZy+ZDWvCYZGYYd4RjctCzrZkambAb4BtlOHWbQmwpwEI2A2onf
         BlLAwb8Fyq257Zs7m3Dg80wPd6KRauPq2nk/toZOzdkzSkC7ixqEhicO676ZA81E8IQb
         ZetSedtonjBqMaEuTbbpby/ZI1vaGUCoG4SfrBOk1SUHiQ5nb/h9vnnJ9fgONYtPa0Ro
         LnzaQYa4gS7vTOsczy/tC5ZAGagEgIAz9BMEh5OhpBtvV7sR/6NZOJ3mggeTALtgJRLf
         kFlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8jh8FxoTF1RXzEjWAIDCDfbcMt7OdhZtTirKxRPkwq4qUG6jq6bQDHV9OdEChwoRvzA068ZlDiSrkihOALLrv+CNwRmN4Wq4a/zr+jHO2
X-Gm-Message-State: AOJu0YwFBRFKa46R0VuiOawxxKOHXbAcY8ElIcjJcOapTBKmL0AW6sHL
	Rss2MgP5MaMyZ0FmRVM6J9nGKjvvkiNeQd9yFNhLk0gW7V7SY+DJ0xFJCb3zkAOQISV1rXjVhZB
	klYbhqCzt6A==
X-Google-Smtp-Source: AGHT+IFbYtXNPHY4Pw0FRa6rRjfHtPjWM7CA5XFPN+LXvpcfxkrH7JF+YaAawTMCM5hKGPwKQTJAsq2tclvKYg==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6902:2b0a:b0:dff:83e:b259 with SMTP
 id 3f1490d57ef6-e0304040464mr362430276.6.1719378509753; Tue, 25 Jun 2024
 22:08:29 -0700 (PDT)
Date: Wed, 26 Jun 2024 05:08:18 +0000
In-Reply-To: <20240626050818.2277273-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626050818.2277273-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240626050818.2277273-5-jiaqiyan@google.com>
Subject: [PATCH v6 4/4] docs: mm: add enable_soft_offline sysctl
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com
Cc: jane.chu@oracle.com, rdunlap@infradead.org, ioworker0@gmail.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
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
index e86c968a7a0e..71463a7b3e2a 100644
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
2.45.2.741.gdbec12cfda-goog


