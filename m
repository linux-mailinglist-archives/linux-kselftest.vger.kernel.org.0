Return-Path: <linux-kselftest+bounces-12464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DCC912E5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 22:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446A51C23E75
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060A417C200;
	Fri, 21 Jun 2024 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Tcpa6OGI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D617B513;
	Fri, 21 Jun 2024 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000913; cv=none; b=Yg5qRVvDZrELIfSyAZEC6lOprAR46potWObiKt0XFJu9TGy4ZilKeF59T/L+1M0kjHNPhC2XB8kId8KJeBKXeEsb3x8DY8FC/XmaBi0AiMfu/XJ+KQJYdvPqGOOkkwGuAmDJ9xdc3vxK0jnJpLie3EDAr3Qq5QVgpt3zPnsCKb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000913; c=relaxed/simple;
	bh=NLqDO3bQVXHXHdmS+4+Cz3TmArSNe596g/MH8L03zf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=un77KBo3EsTMPNbzrffE5cjLmQ6I5VqCI2h/IT9nZIDKkwujY3q/PC31H4pCIXhk0OjdUZDJrS/P15GgZkdbyR11THRlbw+dIssPhRefbXqw1obrBG4eMSbI10F3VeaaTx0ug4SOYk5fHAS3Pr2ifdL+BsPzr7uE3De6zkkjvfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=Tcpa6OGI; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1719000913; x=1750536913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cgWmlGVHD/WLDCXmIqfk8nrWeurU4qavflNPAcqQXUQ=;
  b=Tcpa6OGIIVFPmuojUX1LJNt5HqxXi5LMdKL6MqynUuJjIf5doWvrNAM8
   sF7TzUMuEWPp7eTe0exXO2tE13UMTw+fOinj9e3R1lTxXhAihsbMukDIh
   Z7j6qw6KZO9BY9eJ0TNfNb3kFnOyVHFm4MD2s4U6raatxvi8CQeJLnmtE
   Y=;
X-IronPort-AV: E=Sophos;i="6.08,255,1712620800"; 
   d="scan'208";a="303949657"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 20:15:10 +0000
Received: from EX19MTAUEC001.ant.amazon.com [10.0.0.204:38687]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.50.120:2525] with esmtp (Farcaster)
 id 6725e830-b8a7-4b4d-9f50-20de851c1f32; Fri, 21 Jun 2024 20:15:08 +0000 (UTC)
X-Farcaster-Flow-ID: 6725e830-b8a7-4b4d-9f50-20de851c1f32
Received: from EX19D008UEA002.ant.amazon.com (10.252.134.125) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 20:15:08 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEA002.ant.amazon.com (10.252.134.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 20:15:07 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.95.134.31) by
 mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34 via Frontend Transport; Fri, 21 Jun 2024 20:15:06 +0000
From: Roman Kagan <rkagan@amazon.de>
To: <linux-kernel@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Dragan Cvetic <dragan.cvetic@amd.com>,
	Fares Mehanna <faresx@amazon.de>, Alexander Graf <graf@amazon.de>, "Derek
 Kiernan" <derek.kiernan@amd.com>, <linux-kselftest@vger.kernel.org>,
	<nh-open-source@amazon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-mm@kvack.org>, David Woodhouse <dwmw@amazon.co.uk>, Andrew Morton
	<akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RFC 1/3] mseal: expose interface to seal / unseal user memory ranges
Date: Fri, 21 Jun 2024 22:14:59 +0200
Message-ID: <20240621201501.1059948-2-rkagan@amazon.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621201501.1059948-1-rkagan@amazon.de>
References: <20240621201501.1059948-1-rkagan@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Fares Mehanna <faresx@amazon.de>

To make sure the kernel mm-local mapping is untouched by the user, we will seal
the VMA before changing the protection to be used by the kernel.

This will guarantee that userspace can't unmap or alter this VMA while it is
being used by the kernel.

After the kernel is done with the secret memory, it will unseal the VMA to be
able to unmap and free it.

Unseal operation is not exposed to userspace.

Signed-off-by: Fares Mehanna <faresx@amazon.de>
Signed-off-by: Roman Kagan <rkagan@amazon.de>
---
 mm/internal.h |  7 +++++
 mm/mseal.c    | 81 ++++++++++++++++++++++++++++++++-------------------
 2 files changed, 58 insertions(+), 30 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index b2c75b12014e..5278989610f5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1453,6 +1453,8 @@ bool can_modify_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end);
 bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
 		unsigned long end, int behavior);
+/* mm's mmap write lock must be taken before seal/unseal operation */
+int do_mseal(unsigned long start, unsigned long end, bool seal);
 #else
 static inline int can_do_mseal(unsigned long flags)
 {
@@ -1470,6 +1472,11 @@ static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
 {
 	return true;
 }
+
+static inline int do_mseal(unsigned long start, unsigned long end, bool seal)
+{
+	return -EINVAL;
+}
 #endif
 
 #ifdef CONFIG_SHRINKER_DEBUG
diff --git a/mm/mseal.c b/mm/mseal.c
index bf783bba8ed0..331745ac7064 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -26,6 +26,11 @@ static inline void set_vma_sealed(struct vm_area_struct *vma)
 	vm_flags_set(vma, VM_SEALED);
 }
 
+static inline void clear_vma_sealed(struct vm_area_struct *vma)
+{
+	vm_flags_clear(vma, VM_SEALED);
+}
+
 /*
  * check if a vma is sealed for modification.
  * return true, if modification is allowed.
@@ -109,7 +114,7 @@ bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start, unsigned long
 
 static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct **prev, unsigned long start,
-		unsigned long end, vm_flags_t newflags)
+		unsigned long end, vm_flags_t newflags, bool seal)
 {
 	int ret = 0;
 	vm_flags_t oldflags = vma->vm_flags;
@@ -123,7 +128,10 @@ static int mseal_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto out;
 	}
 
-	set_vma_sealed(vma);
+	if (seal)
+		set_vma_sealed(vma);
+	else
+		clear_vma_sealed(vma);
 out:
 	*prev = vma;
 	return ret;
@@ -159,9 +167,9 @@ static int check_mm_seal(unsigned long start, unsigned long end)
 }
 
 /*
- * Apply sealing.
+ * Apply sealing / unsealing.
  */
-static int apply_mm_seal(unsigned long start, unsigned long end)
+static int apply_mm_seal(unsigned long start, unsigned long end, bool seal)
 {
 	unsigned long nstart;
 	struct vm_area_struct *vma, *prev;
@@ -183,11 +191,14 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
 		unsigned long tmp;
 		vm_flags_t newflags;
 
-		newflags = vma->vm_flags | VM_SEALED;
+		if (seal)
+			newflags = vma->vm_flags | VM_SEALED;
+		else
+			newflags = vma->vm_flags & ~(VM_SEALED);
 		tmp = vma->vm_end;
 		if (tmp > end)
 			tmp = end;
-		error = mseal_fixup(&vmi, vma, &prev, nstart, tmp, newflags);
+		error = mseal_fixup(&vmi, vma, &prev, nstart, tmp, newflags, seal);
 		if (error)
 			return error;
 		nstart = vma_iter_end(&vmi);
@@ -196,6 +207,37 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
 	return 0;
 }
 
+int do_mseal(unsigned long start, unsigned long end, bool seal)
+{
+	int ret;
+
+	if (end < start)
+		return -EINVAL;
+
+	if (end == start)
+		return 0;
+
+	/*
+	 * First pass, this helps to avoid
+	 * partial sealing in case of error in input address range,
+	 * e.g. ENOMEM error.
+	 */
+	ret = check_mm_seal(start, end);
+	if (ret)
+		goto out;
+
+	/*
+	 * Second pass, this should success, unless there are errors
+	 * from vma_modify_flags, e.g. merge/split error, or process
+	 * reaching the max supported VMAs, however, those cases shall
+	 * be rare.
+	 */
+	ret = apply_mm_seal(start, end, seal);
+
+out:
+	return ret;
+}
+
 /*
  * mseal(2) seals the VM's meta data from
  * selected syscalls.
@@ -248,7 +290,7 @@ static int apply_mm_seal(unsigned long start, unsigned long end)
  *
  *  unseal() is not supported.
  */
-static int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
+static int __do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 {
 	size_t len;
 	int ret = 0;
@@ -269,33 +311,12 @@ static int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 		return -EINVAL;
 
 	end = start + len;
-	if (end < start)
-		return -EINVAL;
-
-	if (end == start)
-		return 0;
 
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	/*
-	 * First pass, this helps to avoid
-	 * partial sealing in case of error in input address range,
-	 * e.g. ENOMEM error.
-	 */
-	ret = check_mm_seal(start, end);
-	if (ret)
-		goto out;
+	ret = do_mseal(start, end, true);
 
-	/*
-	 * Second pass, this should success, unless there are errors
-	 * from vma_modify_flags, e.g. merge/split error, or process
-	 * reaching the max supported VMAs, however, those cases shall
-	 * be rare.
-	 */
-	ret = apply_mm_seal(start, end);
-
-out:
 	mmap_write_unlock(current->mm);
 	return ret;
 }
@@ -303,5 +324,5 @@ static int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 SYSCALL_DEFINE3(mseal, unsigned long, start, size_t, len, unsigned long,
 		flags)
 {
-	return do_mseal(start, len, flags);
+	return __do_mseal(start, len, flags);
 }
-- 
2.34.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


