Return-Path: <linux-kselftest+bounces-12356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE639111C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 21:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F212B28E5F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 18:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4111BA095;
	Thu, 20 Jun 2024 18:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zJX0UJQ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56771B9AC8
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909348; cv=none; b=kFPp7iPH+iiBJ+HYaIvbhMGsgoN6I4Ojc2wnev21LJ/dBeVCJwVPs7IeDQ5LQaGrqLyJTglU+jPd4gUSbY68aV/hXARz0iFQ+yIW/yL3u8CCcqlYXHzY53nd1NO8XQZjS2/2249INvxQVmXo0dMKCMac6z75p+MHcHFKZb8JU5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909348; c=relaxed/simple;
	bh=oGrBKUaPPYMt4mq6hQ9WGmkM72JnKKHs67jeHGq/Bl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tVMgtFo0h/hhK7UaSOU+kzBOuit0RHlfLrwmNcY3S9lNFJUjLSpzNz5MnFvYEJDRjX+AbSajOeb9zppi6lg8oj3QhPtY3smsxUolk6Z+MdQeFRDbhEJkp4AxW8nKDENI1pvyN/CGaWsqISJeUAx4P/2UcDA3ftM2wOAl98bgSXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zJX0UJQ4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfa73db88dcso2138919276.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 11:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718909346; x=1719514146; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TWFrrNyw1Nab21+ugVhetla5erwSeVLyLbHLnKsHR/o=;
        b=zJX0UJQ4gCwCPkLhBI7uRvCU0EzGJRxdiNhdqujVfTJgBAnByC221C76Ucf0oMMSUo
         q6FBz/oMvm+uhzzUr+oecJ7xSetfrQGCxaoPV3itjH+nTXLb72qGJujUbCajDw21t6mN
         B6SC8JF+KKwj0sPopwnwHO/bkndzpYhjC3GrT95UZIIrecZvQ3Nc8oO9EDoAbPYjbEg1
         WiiyAiGLzeYn8I0mDzriG30QwpNd5dChka9+En+wuAjHAqzXYjBXptNb66QSjgEOX49L
         aLd0kL+6O+V7wNQ0A5uQPLdUl9oy/IJ8owou/PN5efRA+goxWYMUgOkur4RcxIhUKafW
         /Jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718909346; x=1719514146;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWFrrNyw1Nab21+ugVhetla5erwSeVLyLbHLnKsHR/o=;
        b=qjO6UXGIygXl/l5d/dgq/YPpEspI62HC2Zh8Jjzu8v2cwNbzveuQcSbhreJrxMSIJQ
         BOv6sf5bxwFON/MDM2LwEetwChEGTbmNMEh0I5echPYkeM+cK7hk7+Ws2EitxG9V6fu9
         hP1xR0oYg60qBdcOw+LWf4PLddYoAEyifNlswT8HASOFCSjrtQIFSTqiXepEPuPRU1uw
         F/t8/Ej366HNMeeqtzbiByHzay7hEvY2owKoSE7b6xT8xCFBtCu8c4iDazgRideXJX0E
         TZajy7bP31CEyeFmWgdd4uI4M+7SKCEjmawVlS0dwU9pLhvSkGnnZABcDVC3pD3h68WU
         yQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCWx7uaewCspsmqwJngW1OV/duSq0OfPBnTiqiog7kZtbfru/vJqIIhTV7N3EONtv7F8puX8sw3lx4fnH1gpjafZSdPDVR+D4PHWUj9TLJyy
X-Gm-Message-State: AOJu0YwyYkbr3mRN76a4i1oDVjBKedlZS/b4dpoSbfWL4jTsveSmyy3g
	QX3eSbb5/fhm/9dmtVUfq9itmz+XrrROGc5mTbNIKWkxdMuCMZSsDhp0qxG+lnDqE89Z3X407bo
	sb6I/4Mu+8w==
X-Google-Smtp-Source: AGHT+IFRbsaa5YhIAN16G6oBhNsiWnJskLxaqW20TQItpx0rD0HFxamnsxbmBDl6kbfy5DURgNKiHDq5P351hA==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a05:6902:154e:b0:e02:b093:dc1f with SMTP
 id 3f1490d57ef6-e02be0f2578mr634179276.1.1718909345902; Thu, 20 Jun 2024
 11:49:05 -0700 (PDT)
Date: Thu, 20 Jun 2024 18:48:56 +0000
In-Reply-To: <20240620184856.600717-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240620184856.600717-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240620184856.600717-5-jiaqiyan@google.com>
Subject: [PATCH v4 4/4] docs: mm: add enable_soft_offline sysctl
From: Jiaqi Yan <jiaqiyan@google.com>
To: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	osalvador@suse.de
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, rientjes@google.com, duenwen@google.com, fvdl@google.com, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
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


