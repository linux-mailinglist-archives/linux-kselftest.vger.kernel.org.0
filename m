Return-Path: <linux-kselftest+bounces-15571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF987955419
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 02:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4C91C20B4D
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 00:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178CA1361;
	Sat, 17 Aug 2024 00:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW1DZvCu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147E63C;
	Sat, 17 Aug 2024 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723853924; cv=none; b=pRnHPc4P0q3VNcgqO3dyM6uoE9gI4YVdBU1BIEmGlFsQMR8T3rWVrPQTv+TLEpWyTT4KEoc0iRNYl7ZQysQCJF2pZ75vnx75VTb0hIZwPWTCJQ+xp8Dj33j/D4Ly7gqjyS8V70syKbK6/RqppU6Lt9E7DKZ8cw9EUZSCTVN7Z+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723853924; c=relaxed/simple;
	bh=wxZ0fURU6BVyD4NMhxsgOZ9Hl4+rpPyQ2k0OfS8AnqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnM4nd0I2jCc6CFpGvO9p7kMV4e4/NGXiRGfYAgtXzIyYxC+8oyfIN8yGZdbfU9zXnsurElDYfj1w5UXUbar+HZ53doTTH8tS9O7WhZos0L3sCe5IAx0wFSl0F+0Y4+yj7bip51Wy7c2dj3CVpB9O6YvLgFf7zDuG+jIpLGEld0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HW1DZvCu; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f0271b0ae9so31780151fa.1;
        Fri, 16 Aug 2024 17:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723853920; x=1724458720; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQdfB2TJjcHTWcrkMiwvMjty3cwhCh0Z/hQjDmUKSz0=;
        b=HW1DZvCuqC414z1RfI+ZbC+bqcTgNEqs43Su1ELN4tRlvt+QtI7A/CC64A1ocaLqCI
         hNXSpJYbxlUI/WUR8s1RFrjJRQM+8sQ/ozDdMMcHwqHispyzVHTWc8V1MgKOi6W2Bdwm
         h8cwrEx9DVUCC0iQ/6frxnEgAUOPLy8x26rTz16G+WTz0YpDwK/3nCwJoSFNL/N4DZiZ
         EsIqo56tldqHob/hle86WQIPKeSy077cY99QWA5Co/oMH7JJDd/8JTdFi58E1Jojxdbm
         MO4HqlAHS0WE9UYAmhrAjWhOFE8xAp+M6MGX3hyO7cOGyf3FmlA/kUWeVl1Zw9UKIUT5
         33QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723853920; x=1724458720;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQdfB2TJjcHTWcrkMiwvMjty3cwhCh0Z/hQjDmUKSz0=;
        b=NJsotI9ZmXlI6ulqxMqo7yQohxaFPRYyw+NQV0RFiaEvEFlt1iFyNsfKWPf2rEIhAe
         VjOhySfffNKCh1+NGxdlGyqjWltOuMFhiiV+YbbR79U/FAsqjh6VyK1r6g31wofQHtnx
         biom0iOFq5wqw3GfK6I94HwHOVD+1N9zLOlOoacVLWGkhqAdq2dJZW8xFZcIIVbeV3/C
         vPxd8ErhdgB8ajKaXeD6m/pylIlKIlkS0ghffpnMgRFtGzSTGvLy1SPSZy6YYJzrUX8N
         CklEZiFniMNJci6cQKaul6hxWIicgYx+XNNhO1ub7Eoo1/STZUi3sZ9z08731FPnNkUo
         ptxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMridDA0Z+VzdWZtwAypltOapFZELx1Ok4b/8Prn54/XQ2C3kDnSA/Wg2TxuPrGCxrpIbyousYvBwni9NjV0IwTBoVgNY4KlzGhTd+TPB7VgHlo6PXPYX3T/cd0duksxPGBjCmpQ2Y1xum6VVo
X-Gm-Message-State: AOJu0YxlclCdj889+A8STgH6PRIeHJiNw4ovr+QnUT9cIo5qPabmIMO+
	TmYli/AO7Wls74cJZcn5Bl18zDteRdvx0h6OOnJaYCTIKb74OU1a2L2lCDuC
X-Google-Smtp-Source: AGHT+IFZ9b78tVtcZPQGq9NYpF0/YwksiknLfMYODd0Q+Kd8EWcZCWbrFfO0fyGveiS9SrzB4Z6g/g==
X-Received: by 2002:a2e:d01:0:b0:2f1:9248:c325 with SMTP id 38308e7fff4ca-2f3be5f8cecmr29055721fa.31.1723853919102;
        Fri, 16 Aug 2024 17:18:39 -0700 (PDT)
Received: from [192.168.1.91] ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d781047asm104842055e9.0.2024.08.16.17.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 17:18:38 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Sat, 17 Aug 2024 01:18:29 +0100
Subject: [PATCH v3 2/7] mm/munmap: Replace can_modify_mm with
 can_modify_vma
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240817-mseal-depessimize-v3-2-d8d2e037df30@gmail.com>
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
In-Reply-To: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, jeffxu@chromium.org, oliver.sang@intel.com, 
 torvalds@linux-foundation.org, Michael Ellerman <mpe@ellerman.id.au>, 
 Kees Cook <kees@kernel.org>, Pedro Falcato <pedro.falcato@gmail.com>
X-Mailer: b4 0.14.1

We were doing an extra mmap tree traversal just to check if the entire
range is modifiable. This can be done when we iterate through the VMAs
instead.

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/mmap.c | 11 +----------
 mm/vma.c  | 19 ++++++++++++-------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3af256bacef3..30ae4cb5cec9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1740,16 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, struct list_head *uf,
 		bool unlock)
 {
-	struct mm_struct *mm = vma->vm_mm;
-
-	/*
-	 * Check if memory is sealed, prevent unmapping a sealed VMA.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, start, end)))
-		return -EPERM;
-
-	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
+	return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, unlock);
 }
 
 /*
diff --git a/mm/vma.c b/mm/vma.c
index 84965f2cd580..5850f7c0949b 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
+		/* Don't bother splitting the VMA if we can't unmap it anyway */
+		if (!can_modify_vma(vma)) {
+			error = -EPERM;
+			goto start_split_failed;
+		}
+
 		error = __split_vma(vmi, vma, start, 1);
 		if (error)
 			goto start_split_failed;
@@ -723,6 +729,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 	next = vma;
 	do {
+		if (!can_modify_vma(next)) {
+			error = -EPERM;
+			goto modify_vma_failed;
+		}
+
 		/* Does it split the end? */
 		if (next->vm_end > end) {
 			error = __split_vma(vmi, next, end, 0);
@@ -815,6 +826,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	__mt_destroy(&mt_detach);
 	return 0;
 
+modify_vma_failed:
 clear_tree_failed:
 userfaultfd_error:
 munmap_gather_failed:
@@ -860,13 +872,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (end == start)
 		return -EINVAL;
 
-	/*
-	 * Check if memory is sealed, prevent unmapping a sealed VMA.
-	 * can_modify_mm assumes we have acquired the lock on MM.
-	 */
-	if (unlikely(!can_modify_mm(mm, start, end)))
-		return -EPERM;
-
 	/* Find the first overlapping VMA */
 	vma = vma_find(vmi, end);
 	if (!vma) {

-- 
2.46.0


