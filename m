Return-Path: <linux-kselftest+bounces-22145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1C39D002C
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 19:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35932873C4
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C37199E80;
	Sat, 16 Nov 2024 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="uxU1GykK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23E191F9B
	for <linux-kselftest@vger.kernel.org>; Sat, 16 Nov 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731779971; cv=none; b=Rxx/z6pQ7LUMyCauH8vm4ZUHa5grmPXDnIltji8mS+jTeufvTsA3jpqHOsJ1Tz4+LGQCFqKl43sCEipXm4xGDp2kmxHGAO5/8cReQPM5S4RDfZuIkoXszEe3dn4CkMBiXnHtiKGm0InHlNWJKpGqR0plWu/nM+G+cfN61VLPk44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731779971; c=relaxed/simple;
	bh=bIwDxueUJud+n2/mIeUPWBecNLHhmDU7Xn2mmiUGf6s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/NczYSdpCS3z5haIzbeCn629jx6i/XvaN7XGlZ5Os19wFCCqcRQTWcJ7OOe0Paxl5rFMOVjOFdiwNG7HTSnL8bfthM+Z5AVjQr7cDPNSFPSb8RlMWtTAOuXV03mB05Ewyu1pE2N2OQzFyH+wPHdbkeKqh9QMypOrWx7UJfelYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=uxU1GykK; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cc250bbc9eso13384716d6.2
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Nov 2024 09:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731779969; x=1732384769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NgfUO+bQWj6bU8BgCVOh0fIa47vMCexDt60Dq7gXNk=;
        b=uxU1GykKNMZCbWxpjzqobztisCh9k6Tx6uWhHxXDuyD+rXG48SF4MUVGkr0KkfMDwl
         qzZAop8JzhtNcpREH+mcVL92W0+hSfPBkUt9iju8Izy1dJuI4okjTgyNs0qcAr7zhC31
         sjwoOKFCcMxj6cMFpEVKHFLZjkjOGRoPc2BolRWiSUO3bmVVB+WUoS7NoHUwUgenHoRA
         5mt8Kb4SKK1Vb1U1G+5J45gy1L+cDlPB/6ye2wugK5PnYUHmh2FydpbweLslJ0E6yeWH
         aq89LNXrEaARk499i9WTH3nLaxZFM9q+DCSTgqtLH8fYzKiP1Y02rsYespE1knE3ux0z
         0jAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731779969; x=1732384769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NgfUO+bQWj6bU8BgCVOh0fIa47vMCexDt60Dq7gXNk=;
        b=AQVVGFWRYBn3F29trSx1FBMW93Z93EGwLVkNcLti0+/RqNNZrL6gE0FEq9rvQPWylI
         Qml96IerLWtx5SSaEukii8BPUbRunsb+Ees0CLYmpqLRXpskFGY7cR5O5BP5K1CYJB1Y
         cmjGF4lPPWwA8BvkWQh8SnBBbZj2Q7n63JOELRbDNeiHpv5MOYyXXxWM8YTeWQR52wb9
         Fzl2yn2QOiG9cb3HvuW4M+T4Az+CfNFWZ6YaD2YEy7IFSw8OCzfapNQ9tZbe1zqwBfCC
         YeDeAXjWN+Kmxlyvtv/6Mbp0ceLn1HvUcjdCDpTp9vB0zcnQ8ecvUTlvKQivPWH4XbHr
         CMlA==
X-Forwarded-Encrypted: i=1; AJvYcCWzW3TMgqn+Cpjx1EV2yuxO5vuyo77D2NEHn0cTVGaGMs6EwoJ/37eAOyJcSvOHKgn/DkLLkp8dXzux0G1/G6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlmxP4CjjD6A1it24/2zghSMqVE3LxpruAkl2LPXwPU6eiiKA2
	/Lh5TzhMhPWVZ0pXUrYRfkfos5QKaKG9K+uMKJPMddi5InC4CMQZEfPIgqY5fjg=
X-Google-Smtp-Source: AGHT+IEMOLNEsp5sqgIkt52tiSL0kf4hziLkF3l6oWPXAHVLzfNvt2ajo6yR1l9MnxJe6dgs1UWO0g==
X-Received: by 2002:a05:6214:5d0a:b0:6cb:e6b2:4a84 with SMTP id 6a1803df08f44-6d3fb7cc924mr77641716d6.14.1731779968837;
        Sat, 16 Nov 2024 09:59:28 -0800 (PST)
Received: from soleen.c.googlers.com.com (51.57.86.34.bc.googleusercontent.com. [34.86.57.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca309d6sm280530085a.94.2024.11.16.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 09:59:28 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pasha.tatashin@soleen.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	derek.kiernan@amd.com,
	dragan.cvetic@amd.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	shuah@kernel.org,
	vegard.nossum@oracle.com,
	vattunuru@marvell.com,
	schalla@marvell.com,
	david@redhat.com,
	willy@infradead.org,
	osalvador@suse.de,
	usama.anjum@collabora.com,
	andrii@kernel.org,
	ryan.roberts@arm.com,
	peterx@redhat.com,
	oleg@redhat.com,
	tandersen@netflix.com,
	rientjes@google.com,
	gthelen@google.com
Subject: [RFCv1 2/6] pagewalk: Add a page table walker for init_mm page table
Date: Sat, 16 Nov 2024 17:59:18 +0000
Message-ID: <20241116175922.3265872-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Page Detective will use it to walk the kernel page table. Make this
function accessible from modules, and also while here make
walk_page_range() accessible from modules, so Page Detective could
use it to walk user page tables.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/pagewalk.h |  2 ++
 mm/pagewalk.c            | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index f5eb5a32aeed..ff25374470f0 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -124,6 +124,8 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, const struct mm_walk_ops *ops,
 			void *private);
+int walk_page_range_kernel(unsigned long start, unsigned long end,
+			   const struct mm_walk_ops *ops, void *private);
 int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
 		void *private);
 int walk_page_mapping(struct address_space *mapping, pgoff_t first_index,
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 5f9f01532e67..050790aeb15f 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -478,6 +478,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 	} while (start = next, start < end);
 	return err;
 }
+EXPORT_SYMBOL_GPL(walk_page_range);
 
 /**
  * walk_page_range_novma - walk a range of pagetables not backed by a vma
@@ -541,6 +542,37 @@ int walk_page_range_novma(struct mm_struct *mm, unsigned long start,
 	return walk_pgd_range(start, end, &walk);
 }
 
+/**
+ * walk_page_range_kernel - walk a range of pagetables of kernel/init_mm
+ * @start:	start address of the virtual address range
+ * @end:	end address of the virtual address range
+ * @ops:	operation to call during the walk
+ * @private:	private data for callbacks' usage
+ *
+ * Similar to walk_page_range_novma() but specifically walks init_mm.pgd table.
+ *
+ * Note: This function takes two looks: get_online_mems(), and mmap_read, this
+ * is to prevent kernel page tables from being freed while walking.
+ */
+int walk_page_range_kernel(unsigned long start, unsigned long end,
+			   const struct mm_walk_ops *ops, void *private)
+{
+		get_online_mems();
+		if (mmap_read_lock_killable(&init_mm)) {
+			put_online_mems();
+			return -EAGAIN;
+		}
+
+		walk_page_range_novma(&init_mm, start, end, ops,
+				      init_mm.pgd, private);
+
+		mmap_read_unlock(&init_mm);
+		put_online_mems();
+
+		return 0;
+}
+EXPORT_SYMBOL_GPL(walk_page_range_kernel);
+
 int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, const struct mm_walk_ops *ops,
 			void *private)
-- 
2.47.0.338.g60cca15819-goog


