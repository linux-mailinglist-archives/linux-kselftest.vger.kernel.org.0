Return-Path: <linux-kselftest+bounces-33212-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4FABA38D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CACD1C02CF1
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F45C227BA5;
	Fri, 16 May 2025 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yh7rT+kN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF624280004
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423195; cv=none; b=Bf74mXF8EXujNZxNODsRkmNz4crfxsbQMwgSFArMCs9QWVLyofLCZ6cSqSo7zjxuABNr2o8soER1+nq5FIdw3HR1myVyAD514iZGYYKFXkwEPJPdSgVrZuebIER7eNYdHi1CLerAcrMmdf0+JFRRWkAdB6IERQzt6QbLumw/6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423195; c=relaxed/simple;
	bh=QA09MJMyJxOFYe9+ikrFvPn2cBVci7MJUmojY5Mf1zw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZDFIBCtL1kDODOCLIR9cjxrW0r6CtTct1C6qUrFW/XVlX8T/4L/l40rVolWku2xMpvOKMdQ5ZRwFlKG4fVFMX/fAQoSJyP95RJm+R5ww7r7sqxmnMyAi86NyTDeMu5N8vxMgLM7e8Bqsf6dRl+1r/infr4OFKnpHNf/LJOuPmU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yh7rT+kN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26fa2cac30so95831a12.2
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747423193; x=1748027993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xCETEWEGOjTalbSLIaZmyGje6hO8rkmPCiIeq57x+e0=;
        b=yh7rT+kNL2dgcRai85HYCwV00N18p/uX0l7wiKSZmv64GnjX6dnNUWLJxaXZ8L3tIG
         PzG/W+A6f658SKV2etU9pVU5B3VOet4tH/2dmGE78nvM17xXkrqLaxNMHl6iFdwiDtRD
         EWK6OJvWymp83OUgqPeUw0r8h8JCjy6NGuK6kTiDRiEQvJj9QREiV3Qop/d6SzAws+MD
         /A2y+QLvG02n0vsz8AdjQ2KzA1nr+vjZ2EAEF9ucjFTdNaab1deQ8URK2lg92SsEKjkP
         tBzyKkrwSxD8uVXHqIXAM0QG3I8xtXC8/AKrl2MFryEzsEQS/fBJ5lFzVBN/FbkXai/W
         TXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423193; x=1748027993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCETEWEGOjTalbSLIaZmyGje6hO8rkmPCiIeq57x+e0=;
        b=waq6vCYPSAO9h7Xx8FFJHMQWFTcPMt/STAdTLaXgdph/oPUR9fCa0KrN6ffAsIppCR
         +252QPaRM6CY4dO5nw6Tkf9JR6cRfyD0Mf8n9ver0lgyRaiRmUGnlAVouHPbKMOAwlkt
         asdUFjq0f9qffCBLypZBRZgKmvIrmNQMm+XS/6BqEqK3QcPE8QtfS+LJE0Vz12+EC/Jw
         fc7qKsWW2w0Oy0jGR+tDFGGfow1cJegDjbPqO6IdxWE+SGo86rX7LEMO6Fx6ov5iw1DX
         G3kDPy8QH8DsMYQksc48XTr+yM+ce/7fjCkySzZ0XucCQORUkOYCdWTdSDj1u++9VZ5j
         2JAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/HEma0B0CdBRPVBYxgSKRMgZUuHCp9E3dlJLbo8lnznetgATtQYwIGD+cdlMCvyrAMc+8ISmW8ex9vpmrQhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2LTWuVyBUebFwvl5+YmMouCHdmipj1q51lOgJJ96ak399+P8j
	EmfaJAO8idJpzxt2mFoOG2eMU1bSjZubDE57KZMRdVBLgaSTPOx3U0A49Yy5I0pS74kZr3gMCPc
	YZNbSTFUlMA==
X-Google-Smtp-Source: AGHT+IFVdk8ag77NHV6klVaWmSuIMbULzB9iU8rEnVl7/mRah8MbE3K2zTeRWhT1xArBQ5v8lCjSdl+K3tTk
X-Received: from pfaw14.prod.google.com ([2002:a05:6a00:ab8e:b0:739:8cd6:c16c])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9f90:b0:216:5f67:2d90
 with SMTP id adf61e73a8af0-2170ce0b11bmr6682312637.34.1747423193077; Fri, 16
 May 2025 12:19:53 -0700 (PDT)
Date: Fri, 16 May 2025 19:19:23 +0000
In-Reply-To: <cover.1747368092.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747368092.git.afranji@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <1322a07a0eaad85938446a561d868cfcad7b4ecb.1747368092.git.afranji@google.com>
Subject: [RFC PATCH v2 03/13] KVM: guest_mem: Refactor out kvm_gmem_alloc_view()
From: Ryan Afranji <afranji@google.com>
To: afranji@google.com, ackerleytng@google.com, pbonzini@redhat.com, 
	seanjc@google.com, tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	tabba@google.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	shuah@kernel.org, andrew.jones@linux.dev, ricarkol@google.com, 
	chao.p.peng@linux.intel.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com, 
	vannapurve@google.com, erdemaktas@google.com, mail@maciej.szmigiero.name, 
	vbabka@suse.cz, david@redhat.com, qperret@google.com, michael.roth@amd.com, 
	wei.w.wang@intel.com, liam.merwick@oracle.com, isaku.yamahata@gmail.com, 
	kirill.shutemov@linux.intel.com, sagis@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

kvm_gmem_alloc_view() will allocate and build a file out of an inode.

Will be reused later by kvm_gmem_link()

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Ryan Afranji <afranji@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 virt/kvm/guest_memfd.c | 61 +++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 2ee26695dc31..a3918d1695b9 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -470,49 +470,47 @@ static struct inode *kvm_gmem_inode_make_secure_inode(const char *name,
 	return inode;
 }
 
-static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
-						  u64 flags)
+static struct file *kvm_gmem_alloc_view(struct kvm *kvm, struct inode *inode,
+				     const char *name)
 {
-	static const char *name = "[kvm-gmem]";
-	struct inode *inode;
+	struct kvm_gmem *gmem;
 	struct file *file;
-	int err;
 
-	err = -ENOENT;
 	if (!try_module_get(kvm_gmem_fops.owner))
-		goto err;
+		return ERR_PTR(-ENOENT);
 
-	inode = kvm_gmem_inode_make_secure_inode(name, size, flags);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
+	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
+	if (!gmem) {
+		file = ERR_PTR(-ENOMEM);
 		goto err_put_module;
 	}
 
 	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
 				 &kvm_gmem_fops);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto err_put_inode;
-	}
+	if (IS_ERR(file))
+		goto err_gmem;
 
 	file->f_flags |= O_LARGEFILE;
-	file->private_data = priv;
+	file->private_data = gmem;
+
+	kvm_get_kvm(kvm);
+	gmem->kvm = kvm;
+	xa_init(&gmem->bindings);
+	list_add(&gmem->entry, &file_inode(file)->i_mapping->i_private_list);
 
-out:
 	return file;
 
-err_put_inode:
-	iput(inode);
+err_gmem:
+	kfree(gmem);
 err_put_module:
 	module_put(kvm_gmem_fops.owner);
-err:
-	file = ERR_PTR(err);
-	goto out;
+	return file;
 }
 
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
-	struct kvm_gmem *gmem;
+	static const char *name = "[kvm-gmem]";
+	struct inode *inode;
 	struct file *file;
 	int fd, err;
 
@@ -520,28 +518,23 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 	if (fd < 0)
 		return fd;
 
-	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
-	if (!gmem) {
-		err = -ENOMEM;
+	inode = kvm_gmem_inode_make_secure_inode(name, size, flags);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
 		goto err_fd;
 	}
 
-	file = kvm_gmem_inode_create_getfile(gmem, size, flags);
+	file = kvm_gmem_alloc_view(kvm, inode, name);
 	if (IS_ERR(file)) {
 		err = PTR_ERR(file);
-		goto err_gmem;
+		goto err_put_inode;
 	}
 
-	kvm_get_kvm(kvm);
-	gmem->kvm = kvm;
-	xa_init(&gmem->bindings);
-	list_add(&gmem->entry, &file_inode(file)->i_mapping->i_private_list);
-
 	fd_install(fd, file);
 	return fd;
 
-err_gmem:
-	kfree(gmem);
+err_put_inode:
+	iput(inode);
 err_fd:
 	put_unused_fd(fd);
 	return err;
-- 
2.49.0.1101.gccaa498523-goog


