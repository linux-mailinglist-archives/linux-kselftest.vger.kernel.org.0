Return-Path: <linux-kselftest+bounces-12568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6BA9153FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 18:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8461F214D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 16:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9349E19E809;
	Mon, 24 Jun 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zNAKiJWR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DF319E7F5
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246840; cv=none; b=Wp0Ms59A52/zmzYcARhRQcjyyZJQ5w3ZlpmWKvkbfiNC591mZlmN+k88Lpgiq/f0wIF6pXrHQi7M/EeuG3DAP9dsIcVKl5ujIbAKg7+Iz8buMualIaiXhNQaSz+XvmZf1MO+5tAXpq3vFcNEQGJyROuUG0PuU/EUoRO4uQJEdv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246840; c=relaxed/simple;
	bh=7Wo1vdpRujfwVa5E2lZDEmMHiqeYmjrjdL5DzTInIks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xy2B5ZKUYO55hMd4H6QczkI5hk5EMT/lFce/5xeiJickNeyXOF8iJXvcewRdCoGmonwH4gt/WE2zvEgFA5xlAA3bcpPsQoKNLCx9txOywnqBfFQyw/V4eDSXDXEtUidAjxKVa0jDKrsAMJjiHqSYdOfVm8dKkL+Lz1iHbANe+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zNAKiJWR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f98f733043so47172125ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2024 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719246838; x=1719851638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVvAVLVgyp7BPn3YqnrE+Un4CdtD1Zv3a2093D82WyY=;
        b=zNAKiJWRrdiyMLcRtS9CEAPvNDVlwcMAU4MbzbBKU9uiSTu+/hgU1K4WcLc+7VEtXG
         E9s+XDKLBrFmHqG14TD9iVDtkOxr1kZ8KnbNWeDxXhL9wcL8YH9lTi8TJ6GTWtRonNkJ
         8GPMnhdGp0WoTSLbdTGPQpiAqNDanbJn9dajd8JF4g/h+UvEXaYyFza/QWaWWdfuOtUS
         76guww4d5ehYg3CSJgBSb4S/zEvb5eksfwAODnml17yZB2l/DHhc4axqxm9eVA7oqlhY
         Ejl5XdXhWnzqYFCjgCmnA9gZWU6OBvoD2xLChuE23L9jtXxo6KwwxY0kHq08TOkId0lF
         xkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719246838; x=1719851638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVvAVLVgyp7BPn3YqnrE+Un4CdtD1Zv3a2093D82WyY=;
        b=C1jIbaAc4vfk9rQ7bAv73bEHMgikvOZmjzTJAGXuqOi8pe7PK6xPsudu575USxpkBr
         7hwhhUQwouZahizRLNn2zIaEdeR7YGrh30b1hJRX+iHD9/pBrbBSOnUgvcTEreKRN3sl
         QIcbowo63ub08zmhuV9AOxN6cU+i4p8bz/ZOOxhtjGkIa0aN+ozNGC1DbuZT2NzLvYd9
         s8KzLKXvpM3DjfDy1M+XtXDeDHf4aOEHhxVu3kucRDIAF7DoUuMD5+/SACzcR9XSbg0p
         nfGGvZICqF0nHrElDW5756fUPIlePC4XDZ8Gf8CPYanT38r1iGeuxqTyUGDnUq/ptNnk
         ZKuA==
X-Forwarded-Encrypted: i=1; AJvYcCUgJq8wgf4L8mlb04HhL4kxNlxMl4W9JiN4cOkUhmd7/uf3BwzOGOpoidR17f42YyElaYYypu9WVCuCRfkbeMrmjYZXbTaZCiYAnuM301bQ
X-Gm-Message-State: AOJu0YzAKfDd3ybm9Mi32DXtO1wCFM8ifyj1MJ7VYsOnjYPWhHfaiYQE
	qtFW9swZUSLGJlgfUPRa++Y+gKxFl+6W8ajUibfuN1Y5+BlsjfbekcybD0BIlKXQwI327t4zudn
	ExPk5SpAe6g==
X-Google-Smtp-Source: AGHT+IFQ03M3aTRppiNCfLsuYEASJusj+ybeUo8fprfJ1Y1kR44v8CZCgZBXMkKg6JbKjrrKoR1HPHTKxUnd6g==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a17:902:e74c:b0:1f9:c823:d3 with SMTP id
 d9443c01a7336-1fa1d516b81mr196425ad.6.1719246837884; Mon, 24 Jun 2024
 09:33:57 -0700 (PDT)
Date: Mon, 24 Jun 2024 16:33:48 +0000
In-Reply-To: <20240624163348.1751454-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624163348.1751454-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624163348.1751454-5-jiaqiyan@google.com>
Subject: [PATCH v5 4/4] docs: mm: add enable_soft_offline sysctl
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

Acked-by: Oscar Salvador <osalvador@suse.de>

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
+It is worth mentioning that after setting enable_soft_offline to 0, the
+following requests to soft offline pages will not be performed:
+- Request to soft offline pages from RAS Correctable Errors Collector.
+- On ARM, the request to soft offline pages from GHES driver.
+- On PARISC, the request to soft offline pages from Page Deallocation Table.
 
 extfrag_threshold
 =================
-- 
2.45.2.741.gdbec12cfda-goog


