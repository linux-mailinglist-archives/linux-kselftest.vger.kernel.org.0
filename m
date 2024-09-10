Return-Path: <linux-kselftest+bounces-17671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC3097469E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Sep 2024 01:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62840B235C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC81BAEE1;
	Tue, 10 Sep 2024 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7sacZs9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902A61BA273
	for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726011889; cv=none; b=PuFiNx1quLBV4UY7OG/bln+tOIqZ27rAN670xt0krM+PIjl8RijMsDb/4xdZEwi60R9eXX5/+DrFjQHmHaPE1c7NoqNxAe5Xt1AP/qXMWaOrH1q5yxXOrXfmyPCehYG6mZxzCVEwZ0CAH/VD0Bir8Z4HmZ6YUPlWbXqMHHpVgJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726011889; c=relaxed/simple;
	bh=P/1nrx2IuQ6u/tRlLat3CEqnsSzaylehYsr5F1KL3bU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iTjvqxpOxVlzVTBfiZX9qcYFh/oZ9eglyTD5BWAAH4kDQZvCN0N0hABvP3UI1gs0CiYxvD25ew34gniVFGVSOHapZLmY0JjRxbyaQDi8/1kldwmMGUoYpzURN3NoOFMPDRQYoj+i3AZHtcZg/bdpXIx/NKtx5FauwaNk/ZviWNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7sacZs9; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7d50777abf1so3526090a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2024 16:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726011887; x=1726616687; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCQtr3LYUTrh92YO/TM3BLSTa63Bn54Ak3CYVuDQSOE=;
        b=t7sacZs9AlFE4x4E3+KTOKInB2V0MmaMJQoRCuR02qrwGFkvM0mxP5K38OISL8gDeu
         hcTzlUroNQaYx6AE8MckIHId1JeAOkl5RlhPD1EXP6/AOKAe+VRRFvhon0HWltj3+/d5
         UnnxYSaVpjkKGxrZDleMATnhRanJzVMxIvBsT5xoAZyufKEJolFrimI9w5+USNAKznxW
         8ubWqgQbyFG6CKxllzWOMK5NOXwlVdxegnhAVXF8T2tcmkLhdwGxcDCyk+WOYsgYWtbE
         sHWUP59OqHhfBhvvj+7l45xo7Xihb0VeLemdsyjLOlpWnZizRY1gOe0roWqLvVCZv4gM
         ctEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726011887; x=1726616687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wCQtr3LYUTrh92YO/TM3BLSTa63Bn54Ak3CYVuDQSOE=;
        b=JG4MdBfm+8Btn7APO8zitdZ/24Gglybh5ebaeVs5d8ZtXIsC7wO2nSr53qdQO8pcqo
         jtzjtsv3cmL636gF9rJ//wXgO9DUDNLpQxxwjJL7DK/RU8dm65EQY4oiufukfFLjupWx
         tVw0ETBKOLLON6QCnZZ1tfTJYO4gjoewo69aYwGr7qTeG8QplD1xF3u3DfKxBV2Tt5kl
         SJpT48/CSieeAtaBPbq0aQq9h05AcBseyrk44uzEx/VCIDS2/OoTzzFDQlVDr0tldDMP
         HTrzF85CWpdTedlOagCuY95O+wiFnaO0OoRroFYapbTsa9nUn6dSo2sqQk4Mu3LE/34j
         0dCA==
X-Forwarded-Encrypted: i=1; AJvYcCUUkg6VYUZ1zukCcF6xv5plBuUNHndl2smDOjNCqxzCJbgSjtbq5jjSvq4AonBZ4XbWMypETEOJ/P2IGr6XyqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE2bOye2fyq/l2sDpi3P0U/nSTECyaJH6AhcI8iM4IgTB0NIzG
	diEcWt6AUL6kRuKYUCHPMt3N8yQRq73NCFgBDUcd7dLzgPBu883HjW0hp0kVmSZSkHIiMIqrt7J
	C25DqCTd1VOffVFgOypCRGQ==
X-Google-Smtp-Source: AGHT+IH5Nj5kPHNo6rBfhQxFH2WNjr8MfjXL+h+toY4sJe8PVOOMsYFK1lr+WyYqGBk0WvcoCe7tmQGhI2Eo6rySgw==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:902:b686:b0:205:5db4:44b8 with
 SMTP id d9443c01a7336-2074c63a9cemr948735ad.5.1726011886284; Tue, 10 Sep 2024
 16:44:46 -0700 (PDT)
Date: Tue, 10 Sep 2024 23:43:39 +0000
In-Reply-To: <cover.1726009989.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1726009989.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <9f287e19cb80258b406800c8758fc58eff449d56.1726009989.git.ackerleytng@google.com>
Subject: [RFC PATCH 08/39] mm: truncate: Expose preparation steps for truncate_inode_pages_final
From: Ackerley Tng <ackerleytng@google.com>
To: tabba@google.com, quic_eberman@quicinc.com, roypat@amazon.co.uk, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, seanjc@google.com, 
	pbonzini@redhat.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, isaku.yamahata@intel.com, muchun.song@linux.dev, 
	mike.kravetz@oracle.com
Cc: erdemaktas@google.com, vannapurve@google.com, ackerleytng@google.com, 
	qperret@google.com, jhubbard@nvidia.com, willy@infradead.org, 
	shuah@kernel.org, brauner@kernel.org, bfoster@redhat.com, 
	kent.overstreet@linux.dev, pvorel@suse.cz, rppt@kernel.org, 
	richard.weiyang@gmail.com, anup@brainfault.org, haibo1.xu@intel.com, 
	ajones@ventanamicro.com, vkuznets@redhat.com, maciej.wieczor-retman@intel.com, 
	pgonda@google.com, oliver.upton@linux.dev, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-fsdevel@kvack.org
Content-Type: text/plain; charset="UTF-8"

This will allow preparation steps to be shared

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/mm.h |  1 +
 mm/truncate.c      | 26 ++++++++++++++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..ffb4788295b4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3442,6 +3442,7 @@ extern unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info);
 extern void truncate_inode_pages(struct address_space *, loff_t);
 extern void truncate_inode_pages_range(struct address_space *,
 				       loff_t lstart, loff_t lend);
+extern void truncate_inode_pages_final_prepare(struct address_space *);
 extern void truncate_inode_pages_final(struct address_space *);
 
 /* generic vm_area_ops exported for stackable file systems */
diff --git a/mm/truncate.c b/mm/truncate.c
index 4d61fbdd4b2f..28cca86424f8 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -424,16 +424,7 @@ void truncate_inode_pages(struct address_space *mapping, loff_t lstart)
 }
 EXPORT_SYMBOL(truncate_inode_pages);
 
-/**
- * truncate_inode_pages_final - truncate *all* pages before inode dies
- * @mapping: mapping to truncate
- *
- * Called under (and serialized by) inode->i_rwsem.
- *
- * Filesystems have to use this in the .evict_inode path to inform the
- * VM that this is the final truncate and the inode is going away.
- */
-void truncate_inode_pages_final(struct address_space *mapping)
+void truncate_inode_pages_final_prepare(struct address_space *mapping)
 {
 	/*
 	 * Page reclaim can not participate in regular inode lifetime
@@ -454,6 +445,21 @@ void truncate_inode_pages_final(struct address_space *mapping)
 		xa_lock_irq(&mapping->i_pages);
 		xa_unlock_irq(&mapping->i_pages);
 	}
+}
+EXPORT_SYMBOL(truncate_inode_pages_final_prepare);
+
+/**
+ * truncate_inode_pages_final - truncate *all* pages before inode dies
+ * @mapping: mapping to truncate
+ *
+ * Called under (and serialized by) inode->i_rwsem.
+ *
+ * Filesystems have to use this in the .evict_inode path to inform the
+ * VM that this is the final truncate and the inode is going away.
+ */
+void truncate_inode_pages_final(struct address_space *mapping)
+{
+	truncate_inode_pages_final_prepare(mapping);
 
 	truncate_inode_pages(mapping, 0);
 }
-- 
2.46.0.598.g6f2099f65c-goog


