Return-Path: <linux-kselftest+bounces-12081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 000A390B805
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 19:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D602FB3261F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C70616A93B;
	Mon, 17 Jun 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uo/XVCIQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDB116A944
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643957; cv=none; b=sCP8oZvaD9tkdkg7Gw7pk+CdRSACwpn1VwAxOPVLCaD7POL7M8SUJ3VW2ph18JqcWX0CbClrtZ24610ghfvLjxFfD+6AWnlRFa/gRUOBV1AT5y1gYEIIgbfQKVb7jQ5aDHEe0ViC72mYsQQ9Bgrl9yX4ZP+p7M0hheTcCjUYrCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643957; c=relaxed/simple;
	bh=7hzTI7JNlDxEfLjvpOlOkZQ3nAyRsfeAGvDyTxr2TWY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=emlNX5kruI6okAfQPOXni57gmt+SMUPPwOEZsoHUxnvc9x7KgS0fnmoiSvaecXGA+NUHpy6v66XsM1kWf/evt1s1aaZmqDSPTlIFt4e0etuCzemn72d8gQRvVq21ugzDpTilZ+jcC7uyObPEePUitetH8OLIv/LYEJHMTKEWnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Uo/XVCIQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfec7058deeso9478796276.2
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718643954; x=1719248754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lmqa+eDYiknLWtQ9zaPVQYbfuHlo6Q/kAey0Pd/nR7w=;
        b=Uo/XVCIQPfuYsEv4bvrS/dswcbUZjZj05wMhw35lhxI6H4h6Yh+/MonDuokF9enzeY
         o7cCZJlmYUT/CiW2lUcsHbV3Y2d0+3kSJRTFQs7f6XqR/0pec5hkfg+HEbU4b31t4Ed+
         kRQescCA8jaClcFv/RoniWGjTdNej4Rp/khKl+5hFBi1bObqsDJsILqpu/i9JWJbDYbi
         BEQhw7qjQk9l/zrIVuaqF2iJF4DyQKb34a+3/BuweS1vTPFEY74ceYMTBNKgida5iFOf
         0cuP+obFHy9iLqWmTtuSnMy2DcrOfWoa+7ajWF294lwmmqZu3SyRSavmdTqk+xUEvCIG
         /QIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718643954; x=1719248754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmqa+eDYiknLWtQ9zaPVQYbfuHlo6Q/kAey0Pd/nR7w=;
        b=ZjJuGm6iixi5k7NpDu7viGmMnuU1fK4p9xUl8VV51JQCF/ULFtFDIuNsMJP+iB/all
         a8C1Mk6SYVtoi1W/yLhPq9RLquYX34YeiUOwsqxE3+zyY6AgwmD/yXqmjxrVYEzDxFY/
         Yy1fMtJtbbERIJAqSBBm8woeRycLhOLAI5UBldOWa0zjYMPQjxPBUnAuLp6BvXUEeAsG
         DmkOvOyZzS2nB0G5dB4+BW16wZOxxJl7Hgs3B+UIF9VuQCj6VBnAmZTlSS6JazUSgA8Z
         MDTT0HEDPQ4WNroRyQw2nuZAzIz+ipkygy9m6uAxqXKXmy1kLFjdOSJCDQRSRd5MrTET
         n3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2BRgJtdcHVpQ2S2YTc9UoDceqtvhUaobJsXeTizx+2LU8CQw49+5gcI8ouMHS7N84NGHS2p3EsmtGSqRR9arCzjEMEW1vVpYGdt7aMVOH
X-Gm-Message-State: AOJu0YxlhIYZtNaq/hdi+FSaiwFN+jB39SzvROlyTZfizkUk7rUJ8Aat
	uucVOmXzSlmi/qHnFTZPoIf63pj3F7odT6AGUD296sRupBFoXsSrCNfKBUXnfx+/wEtbYWO5nOz
	fxIzv0t42Uw==
X-Google-Smtp-Source: AGHT+IHINQQBbNRf7KhELYqBt0/Q0yNW0Gm7Uiwvy1m/YHP63sxC+8TwS3fjRLwHObbkJ8tAXyAlcAdEODvV0g==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6902:1007:b0:dff:7d1:33a7 with SMTP
 id 3f1490d57ef6-dff1552cbabmr2952019276.12.1718643954195; Mon, 17 Jun 2024
 10:05:54 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:05:45 +0000
In-Reply-To: <20240617170545.3820912-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240617170545.3820912-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617170545.3820912-4-jiaqiyan@google.com>
Subject: [PATCH v3 3/3] docs: mm: add enable_soft_offline sysctl
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	ioworker0@gmail.com
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the documentation for soft offline behaviors / costs, and what
the new enable_soft_offline sysctl is for.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index e86c968a7a0e..fc62fc272fc5 100644
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
@@ -267,6 +268,38 @@ used::
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
+- For a page that is part of a transparent hugepage,  soft-offline splits the
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
+memory pages.  When setting to 1, kernel attempts to soft offline the pages
+whenever it thinks needed.  When setting to 0, kernel returns EOPNOTSUPP to
+the request to soft offline the pages.  Its default value is 1.
+
+It is worth mentioning that after setting enable_soft_offline to 0:
+- If RAS Correctable Errors Collector is running, its request to soft offline
+  pages will fail.
+- On ARM, the request to soft offline pages from GHES driver will fail.
+- On PARISC, the request to soft offline pages from Page Deallocation Table
+  will fail.
 
 extfrag_threshold
 =================
-- 
2.45.2.627.g7a2c4fd464-goog


