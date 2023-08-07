Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E563D773331
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjHGXBg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjHGXBc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:01:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6B4C6
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 16:01:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5896bdb0b18so9022057b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 16:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691449290; x=1692054090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bl1TLMRbvm5qHwbmYRTb4VdYc7Xj9ZoiU46WkqVPij4=;
        b=2BOtUuEUFEIj9skMvKxqhTWLGWm0zT85W9Ihp2s4CpbxeUR5ws+01RJ+HQ+yYQxSKj
         woBvSb4Gk9IPbajI2xb83HAVL2vNi6DqnESZhzmotF6Ol6W/EJeSILA9FOeYje4rZmlQ
         jwLqD4etekit8dCQHL06GwEffA8P+bK2BwprQsLD6vr9T5p2VjUY/rSCPLXKN8pg0X2n
         lqCQCQsl6ilU2YFEKJfBss9T/uJCTM8wKKp4u8S1wqiZfR4YgIj+8oKUyz68tt/c7dCt
         50DX3ArGIPxPQ5orgu4PasB4iVOVKIP4vUILDfnEp1whQTtvB9OscnFZjDC5X2wkcQqB
         1e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449290; x=1692054090;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bl1TLMRbvm5qHwbmYRTb4VdYc7Xj9ZoiU46WkqVPij4=;
        b=QnwcAIRS3+R7QOBFaGWznvuJvsF3DaIHFMqSuNqSNhIV675dcU7QraTt5yYjJwSWPg
         hVftCW6adxa5JJM6e3IT2/yfWj3wJPStnzN+lbXHRf+K+H7doQwXAuvd741kP+P0REfg
         lmhqcNvKdKoYZchuOzFDog8mL0Q8vB1CNeBqPryTq13p0rjigwh6Whr/LI5oFV8JMCft
         8wTj4HA6HNGi1dcHmj+bjeg7EN3fdUaooq3S+Gt/Pkwlu3Nv8wmwJMnbpZETaOakhbBv
         jjFXqCVPR4sZT0deCuRuQP1uarEFqBjHxL/PXu3YVFhLSD+DQEyVGjIKLxRKpSrGVOiT
         c0yg==
X-Gm-Message-State: AOJu0YyT0RwgyecVV1vmzAwf1OpF0JC8vpxU1TIILm/7o4i31RGRsfeL
        l+KILnmxoplVUoXBsKJo6XVaXf046xN0O5PVMw==
X-Google-Smtp-Source: AGHT+IFL47JJrdOOCTSSCqmQW4kyE1p9SLbuAhrBqFamUwBb9QpVhVP6lKw0HpbJOyLQyDEH0YWD7t8AgUzH5zj9ig==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a05:690c:c05:b0:576:e268:903d with
 SMTP id cl5-20020a05690c0c0500b00576e268903dmr109985ywb.2.1691449290326; Mon,
 07 Aug 2023 16:01:30 -0700 (PDT)
Date:   Mon,  7 Aug 2023 23:01:04 +0000
In-Reply-To: <cover.1691446946.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1691446946.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <21569429bcd8be29f1719649aae0067a00172b66.1691446946.git.ackerleytng@google.com>
Subject: [RFC PATCH 01/11] KVM: guest_mem: Refactor out kvm_gmem_alloc_file()
From:   Ackerley Tng <ackerleytng@google.com>
To:     pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, andrew.jones@linux.dev,
        ricarkol@google.com, chao.p.peng@linux.intel.com, tabba@google.com,
        jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        vannapurve@google.com, ackerleytng@google.com,
        erdemaktas@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kvm_gmem_alloc_file() will allocate and build a file out of an inode.

Will be reused later by __kvm_gmem_link()

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_mem.c | 53 ++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index 3a3e38151b45..30d0ab8745ee 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -365,12 +365,42 @@ static const struct inode_operations kvm_gmem_iops = {
 	.setattr	= kvm_gmem_setattr,
 };
 
+static struct file *kvm_gmem_alloc_file(struct kvm *kvm, struct inode *inode,
+					struct vfsmount *mnt)
+{
+	struct file *file;
+	struct kvm_gmem *gmem;
+
+	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
+	if (!gmem)
+		return ERR_PTR(-ENOMEM);
+
+	file = alloc_file_pseudo(inode, mnt, "kvm-gmem", O_RDWR, &kvm_gmem_fops);
+	if (IS_ERR(file))
+		goto err;
+
+	file->f_flags |= O_LARGEFILE;
+	file->f_mapping = inode->i_mapping;
+
+	kvm_get_kvm(kvm);
+	gmem->kvm = kvm;
+	xa_init(&gmem->bindings);
+
+	file->private_data = gmem;
+
+	list_add(&gmem->entry, &inode->i_mapping->private_list);
+
+	return file;
+err:
+	kfree(gmem);
+	return file;
+}
+
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags,
 			     struct vfsmount *mnt)
 {
 	const char *anon_name = "[kvm-gmem]";
 	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
-	struct kvm_gmem *gmem;
 	struct inode *inode;
 	struct file *file;
 	int fd, err;
@@ -399,34 +429,15 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags,
 		goto err_inode;
 	}
 
-	file = alloc_file_pseudo(inode, mnt, "kvm-gmem", O_RDWR, &kvm_gmem_fops);
+	file = kvm_gmem_alloc_file(kvm, inode, mnt);
 	if (IS_ERR(file)) {
 		err = PTR_ERR(file);
 		goto err_fd;
 	}
 
-	file->f_flags |= O_LARGEFILE;
-	file->f_mapping = inode->i_mapping;
-
-	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
-	if (!gmem) {
-		err = -ENOMEM;
-		goto err_file;
-	}
-
-	kvm_get_kvm(kvm);
-	gmem->kvm = kvm;
-	xa_init(&gmem->bindings);
-
-	file->private_data = gmem;
-
-	list_add(&gmem->entry, &inode->i_mapping->private_list);
-
 	fd_install(fd, file);
 	return fd;
 
-err_file:
-	fput(file);
 err_fd:
 	put_unused_fd(fd);
 err_inode:
-- 
2.41.0.640.ga95def55d0-goog

