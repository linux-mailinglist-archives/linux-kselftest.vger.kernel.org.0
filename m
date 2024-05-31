Return-Path: <linux-kselftest+bounces-11070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC418D6BA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 23:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DCFA1F28104
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 21:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1927D40E;
	Fri, 31 May 2024 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVE7kngZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AB17B3FE
	for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191294; cv=none; b=IsrbBJAlPVnIYsyYt2M2QhlFTNHgBR3ErUn+QcY1rVMhof8XQdyoz9SaVMBUz2ZkIVs6oUS1yF+wMk9tq2A5TbyNBf/cyjzxUJmVnSvtnJ0OESxoOvgXRG7wt2qKv5hiMHVlZHT4J+rfAEYKO6CEq0YKNYDnD8XSeWZ8E3lHD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191294; c=relaxed/simple;
	bh=qu902Xc4XZzrHRCZ0yvDNtbLtrB/n0ActWhgbbUFStk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZvNbpwLOVtO0EhO5Sy8F6CNo79JC8CFXnvhc+IAiddWv/Q6WIliv1EyluhR95uv+u70/+fW2L8bTE0qc+XEsAuRswldg44ktGYCdWlMWwQIwqYypbLPEkMm1qYrSEqY5UDOsWWlCgrM497kALzOUJFUkQjvFofTLFiS1/UDGg98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MVE7kngZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-62a379a7c80so1534741a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 May 2024 14:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717191292; x=1717796092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2AZ5BMz5S/rOvkA9+gnvnvJlkq2fc4Ze4ycghZveII=;
        b=MVE7kngZkcAgS/YXPH4OCCzp/idE5IiUsAd/lUthlo8ZLbMc5i0LM5PXYpkt4VeIhF
         SRezQIsf4EiAiqmlirGWWKX/6C8ChfIT5MVjK0HdSZ8Wsarlhl2oAnvQk9POVENlXC0L
         IwR/L7IDAyk/wFSpshNKj76fgUprbtVx/VGZJ5e0BNWugs5z8PP6QGUjPSIHYXItzdHa
         aLY0lnZrblI/mRFfPRwY6cMC/TXbaLJQBs9NnyJKin1L53QerhnAeAQPYVm/nCmeagjr
         EqmhkHhTlPWLIgIqvwBC4x62G8j+/7f50SDXHNJ6ti8EIaX3kS2kD2JpWLsPL70z9o7o
         VvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717191292; x=1717796092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2AZ5BMz5S/rOvkA9+gnvnvJlkq2fc4Ze4ycghZveII=;
        b=ZdRhCvv7Z1aanc1doItsuZNaRNPNU++4g2GW9Mbnjx/8ggqCG6wtcsLKzONwxEFO06
         k6sKcxphavRJvMrKRh4k8kqT45eK9g4Izaq+fiXmKMd9znJ0yFh9TS4yu3PcxyXOcIic
         hHHXRzuzDaElem3M4thf4yxHZvnlGke/Et1Cp0rWAqu4X05n8KA7maJHVPQxI1f1kYsV
         jfvRjaCg3HZHF9loECHVcLVSVvRuruXm5/IWs0M5mrftItk0Cp8c2NBJUqWw3kOk/56L
         4sYLDblpZ/dbMDvxaeJx6t/3RBVN/aDb2LKyaqp7HG05j4rsmshpoBHRmsQmofbFemca
         GVTw==
X-Forwarded-Encrypted: i=1; AJvYcCU8jsEXSdqXe1hZ9KvKoBvcRz0hHaTo2t1+AUurk4UI5BxEDNWV+rJBjZxmr26iGZZxhacuu876Gr8AIr3dS/Q3iyrRlXZvEtVNukAxUA1h
X-Gm-Message-State: AOJu0YxJGTvph9wR55NfgCcDDFYQXco7tkYYbS/QmQeVVOfMSwFWTUFY
	IrjCxcTutJcxL1od/bmZHtMTz+bRCNMKAVJImKgfQqAImoHMaqz2dPI+KCQ0AEZ7CBFGRqG9gEG
	d1zsdQyqsfw==
X-Google-Smtp-Source: AGHT+IHSsGGAcQ6aUIuC8o2985ElkNa7qtVF2VAo7I83ZQQo63eVcbrD7ODzDOPp0guzHEL0/6bg5jblNOTUpg==
X-Received: from yjq3.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:272f])
 (user=jiaqiyan job=sendgmr) by 2002:a63:951a:0:b0:658:7c4c:25b with SMTP id
 41be03b00d2f7-6c3e253c0c9mr14785a12.4.1717191291924; Fri, 31 May 2024
 14:34:51 -0700 (PDT)
Date: Fri, 31 May 2024 21:34:39 +0000
In-Reply-To: <20240531213439.2958891-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240531213439.2958891-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240531213439.2958891-4-jiaqiyan@google.com>
Subject: [PATCH v1 3/3] docs: hugetlbpage.rst: add softoffline_corrected_errors
From: Jiaqi Yan <jiaqiyan@google.com>
To: naoya.horiguchi@nec.com, muchun.song@linux.dev, linmiaohe@huawei.com
Cc: akpm@linux-foundation.org, mike.kravetz@oracle.com, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Add the documentation for what softoffline_corrected_errors
sysfs interface is for.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 Documentation/admin-guide/mm/hugetlbpage.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index f34a0d798d5b..7969ae47f5f1 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -244,7 +244,8 @@ will exist, of the form::
 
 Inside each of these directories, the set of files contained in ``/proc``
 will exist.  In addition, two additional interfaces for demoting huge
-pages may exist::
+pages, and one additional interface for handling corrected memory errors,
+may exist::
 
         demote
         demote_size
@@ -254,6 +255,7 @@ pages may exist::
 	free_hugepages
 	resv_hugepages
 	surplus_hugepages
+	softoffline_corrected_errors
 
 The demote interfaces provide the ability to split a huge page into
 smaller huge pages.  For example, the x86 architecture supports both
@@ -276,6 +278,17 @@ demote
         actually demoted, compare the value of nr_hugepages before and after
         writing to the demote interface.  demote is a write only interface.
 
+The interface for handling corrected memory errors is
+
+softoffline_corrected_errors
+	allow userspace to control how to deal with hugepages that have
+	corrected memory errors.  When setting to 1, kernel attempts to soft
+	offline the hugepage whenever it thinks needed.  If soft offlinging a
+	huge page succeeds, for in-use hugepage, page content is migrated to a
+	new hugepage; however, regardless of in-use or free, capacity of the
+	hugepages will reduce by 1.  When setting to 0, kernel won't attempt to
+	soft offline the hugepage of the specific size. Its default value is 1.
+
 The interfaces which are the same as in ``/proc`` (all except demote and
 demote_size) function as described above for the default huge page-sized case.
 
-- 
2.45.1.288.g0e0cd299f1-goog


