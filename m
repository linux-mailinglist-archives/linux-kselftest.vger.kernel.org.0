Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9AD724C5E
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 21:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbjFFTGS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 15:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbjFFTFB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 15:05:01 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB611BE1
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 12:04:40 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-256b2c2baf1so5844425a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078277; x=1688670277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l7m/+H3bbKiFYeplsxMS6SzLQH+bOrcqP3X6Nh5dkpY=;
        b=14V+ikDqPeP4Yv1OdmN8nd7QZ5MMjeGKWKaRSYFOZag9l1JWEXWB4ucnpLMnABlXZA
         EKyjA/Hep4b5XPLE3jo+/oAtPajUrqdw+KeK/h9os1d0usuctIgWW9M+esmzYCfBXl4x
         ASFKNceH4Dvr96zHhOZ0uM2fLtsPSrNxdz17wPPKIRFX8xmJyoeEp2adnxvZEKqN8X4Y
         OM4Rksx4vK290PDLeLyuR9aPGnO/Zd4sMVHFMKGC9zk+GBNtZUBayI8BLZ7Yas0LD8pw
         GLTAE9YptousowvGxGw0V5tbYjLuLpB0CEXyROZYUG+NBDy7fuPXlo1tE0nXFLN+WEBW
         wc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078277; x=1688670277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7m/+H3bbKiFYeplsxMS6SzLQH+bOrcqP3X6Nh5dkpY=;
        b=EuJj1UinzsQTaOdHYW3Wxhvl/kR7JeTmxVwZUbikw3WsHg7hqOMNcQZeWtpNlCfRCQ
         FsInCNaYxMkwfHTDA+yy/vwLbm9aU2/BVoWXTrCxBJT/z1iW7Fgt0Op7bAxQqZFjMl1D
         PYkycpTckP6JiGJb/hgol7qNBv/stJredbNZlY6XlQka+HHoMyrr/NjUyBcYC5hRE51j
         W4SKa2i3cXTpmOK0WhQJKePapzVR+1vA/ullsFNQiZKPCnf/ZHdxQUorfOrCtdcqK9oQ
         zu7zvRfhNJQXC1WDSMx/AkzeU3a7gn5SZg5V4aLGOCG6OMx3VrHCsCTTvdG7bjtAXiIh
         aXvQ==
X-Gm-Message-State: AC+VfDw1dloESXTshqGW3sHq9Pm9KYJrusHMbxMIKcfMqfhRwqWlywSv
        vNHouopkimGTeuyCgTEu8lNaaYe04iYOBwLcig==
X-Google-Smtp-Source: ACHHUZ400PPpzSqOQyBrlXwnbK9H57gIHhF9scqTSjoAqyx8OcXSiJ7wdR2icZ3OG98VTDSuHd/HQ93iA5Sxt1cqNg==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a17:90b:3003:b0:253:4808:7587 with
 SMTP id hg3-20020a17090b300300b0025348087587mr772798pjb.7.1686078277257; Tue,
 06 Jun 2023 12:04:37 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:58 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <67168b07e8d4a0c714fce5f030671b376d8ca001.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 13/19] KVM: guest_mem: Refactor kvm_gmem fd creation to be
 in layers
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, pbonzini@redhat.com, seanjc@google.com,
        shuah@kernel.org, willy@infradead.org
Cc:     brauner@kernel.org, chao.p.peng@linux.intel.com,
        coltonlewis@google.com, david@redhat.com, dhildenb@redhat.com,
        dmatlack@google.com, erdemaktas@google.com, hughd@google.com,
        isaku.yamahata@gmail.com, jarkko@kernel.org, jmattson@google.com,
        joro@8bytes.org, jthoughton@google.com, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, liam.merwick@oracle.com,
        mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
        qperret@google.com, rientjes@google.com, rppt@kernel.org,
        steven.price@arm.com, tabba@google.com, vannapurve@google.com,
        vbabka@suse.cz, vipinsh@google.com, vkuznets@redhat.com,
        wei.w.wang@intel.com, yu.c.zhang@linux.intel.com,
        kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, x86@kernel.org,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

First create a gmem inode, then create a gmem file using the inode,
then install the file into an fd.

Creating the file in layers separates inode concepts (struct kvm_gmem)
from file concepts and makes cleaning up in stages neater.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_mem.c | 86 +++++++++++++++++++++++++-------------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index 8708139822d3..2f69ef666871 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -375,41 +375,27 @@ static const struct inode_operations kvm_gmem_iops = {
 	.setattr	= kvm_gmem_setattr,
 };
 
-static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags,
-			     struct vfsmount *mnt)
+static struct inode *kvm_gmem_create_inode(struct kvm *kvm, loff_t size, u64 flags,
+					   struct vfsmount *mnt)
 {
+	int err;
+	struct inode *inode;
+	struct kvm_gmem *gmem;
 	const char *anon_name = "[kvm-gmem]";
 	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
-	struct kvm_gmem *gmem;
-	struct inode *inode;
-	struct file *file;
-	int fd, err;
-
-	fd = get_unused_fd_flags(0);
-	if (fd < 0)
-		return fd;
 
 	inode = alloc_anon_inode(mnt->mnt_sb);
-	if (IS_ERR(inode)) {
-		err = PTR_ERR(inode);
-		goto err_fd;
-	}
+	if (IS_ERR(inode))
+		return inode;
 
 	err = security_inode_init_security_anon(inode, &qname, NULL);
 	if (err)
 		goto err_inode;
 
-	file = alloc_file_pseudo(inode, mnt, "kvm-gmem", O_RDWR, &kvm_gmem_fops);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto err_inode;
-	}
-
+	err = -ENOMEM;
 	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
-	if (!gmem) {
-		err = -ENOMEM;
-		goto err_file;
-	}
+	if (!gmem)
+		goto err_inode;
 
 	xa_init(&gmem->bindings);
 
@@ -426,24 +412,41 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags,
 	mapping_set_large_folios(inode->i_mapping);
 	mapping_set_unevictable(inode->i_mapping);
 
-	file->f_flags |= O_LARGEFILE;
-	file->f_mapping = inode->i_mapping;
-	file->private_data = gmem;
-
-	fd_install(fd, file);
-	return fd;
+	return inode;
 
-err_file:
-	fput(file);
 err_inode:
 	iput(inode);
-err_fd:
-	put_unused_fd(fd);
-	return err;
+	return ERR_PTR(err);
+}
+
+
+static struct file *kvm_gmem_create_file(struct kvm *kvm, loff_t size, u64 flags,
+					 struct vfsmount *mnt)
+{
+	struct file *file;
+	struct inode *inode;
+
+	inode = kvm_gmem_create_inode(kvm, size, flags, mnt);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
+
+	file = alloc_file_pseudo(inode, mnt, "kvm-gmem", O_RDWR, &kvm_gmem_fops);
+	if (IS_ERR(file)) {
+		iput(inode);
+		return file;
+	}
+
+	file->f_flags |= O_LARGEFILE;
+	file->f_mapping = inode->i_mapping;
+	file->private_data = inode->i_mapping->private_data;
+
+	return file;
 }
 
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *gmem)
 {
+	int fd;
+	struct file *file;
 	loff_t size = gmem->size;
 	u64 flags = gmem->flags;
 
@@ -462,7 +465,18 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *gmem)
 #endif
 	}
 
-	return __kvm_gmem_create(kvm, size, flags, kvm_gmem_mnt);
+	fd = get_unused_fd_flags(0);
+	if (fd < 0)
+		return fd;
+
+	file = kvm_gmem_create_file(kvm, size, flags, kvm_gmem_mnt);
+	if (IS_ERR(file)) {
+		put_unused_fd(fd);
+		return PTR_ERR(file);
+	}
+
+	fd_install(fd, file);
+	return fd;
 }
 
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-- 
2.41.0.rc0.172.g3f132b7071-goog

