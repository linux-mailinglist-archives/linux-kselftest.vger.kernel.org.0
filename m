Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB94773332
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 01:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjHGXBi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 19:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjHGXBe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 19:01:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B101710F3
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 16:01:32 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d4ca2881833so2644349276.3
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 16:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691449292; x=1692054092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cvBt015EcTFztTll0vjYcigrW3DKQzPiIwftCLBNbM=;
        b=4OG8fBnSqfhUNNOlfnfz98xpsIB7sZynFZMU9BXRZDeo8igEknP1RefaC4s7LZNeCf
         qpPMus4Yv/693O6vUY7liG7wBhF61GbZ8Gu50050qv8TPVkOR1TRkquqD7DNpNJoljU+
         9tVv8DfberuiWwZgc+Mhd2FTDtLVWo5AeWlfuEs7knlnoTv4Cr2Q+2WQS9QdlWEc5HtG
         kYvhjSIf7NxYeJmrftUnpUB4FM2sjylnNKHyYe0/15Ub5mzT68NKrfIaUv/flzcCe0Hd
         gm1FMmNrSAwZad9C6TB9Ffn68907ViOZrpQdw/VIsQ0pd9YLYsuh0Byhq7ugSxaq5/E5
         9FKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691449292; x=1692054092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5cvBt015EcTFztTll0vjYcigrW3DKQzPiIwftCLBNbM=;
        b=SsO1cEMR43xZiHKxhVJZC0yvMNuA/sqXMzrb2aVbE7KBNCmU7lxy+b64rtMKSV8Pkt
         8csdsLl+yzwXfuDtvBWtkCh0Y5dc+4CPh1hgWCGRoKd2X+stOKmPcVcs56m5fR4gHA/e
         zhoWhmbe6J/r+qYi3vP5kEwNw7iTEoZDZrNYm9Rm5UaCv0Rq1/kchYY7AC758ow43RJr
         5EW5rgTNNHQlIli8WOsdz/3waeGssjcBiKk0KcCRtzhS1T7gJJb6GAAqErx3fAiaxt4u
         TFyQWbxHn8diOFWjh1ydAFDLHziMqceSryGlCieHWYG6pl26bvnw4PdoXaOprCUwnTyC
         XpmQ==
X-Gm-Message-State: AOJu0YwKv/TXdQDcJanH0qRmo61Jmvy1SK5qqqauY9OK66s0+HNKUn5B
        UZStx/sANwb92suR/7oygouKHaLnxZJHIlkM1g==
X-Google-Smtp-Source: AGHT+IGdw3ugUEUdCbd6fq8R3RilcWFcQ1uc3EKy8wFjzIC2OfpZfHcOLTYB9nd+UNWfigkUWKaPVAQg8LLScvzD2Q==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:e6d3:0:b0:d10:5b67:843c with SMTP
 id d202-20020a25e6d3000000b00d105b67843cmr59428ybh.4.1691449291933; Mon, 07
 Aug 2023 16:01:31 -0700 (PDT)
Date:   Mon,  7 Aug 2023 23:01:05 +0000
In-Reply-To: <cover.1691446946.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1691446946.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <053b45023744f62bd97cd4f87f048ab514f42b9d.1691446946.git.ackerleytng@google.com>
Subject: [RFC PATCH 02/11] KVM: guest_mem: Add ioctl KVM_LINK_GUEST_MEMFD
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KVM_LINK_GUEST_MEMFD will link a gmem fd's underlying inode to a new
file (and fd).

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/uapi/linux/kvm.h |  8 +++++
 virt/kvm/guest_mem.c     | 73 ++++++++++++++++++++++++++++++++++++++++
 virt/kvm/kvm_main.c      | 10 ++++++
 virt/kvm/kvm_mm.h        |  7 ++++
 4 files changed, 98 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index eb900344a054..d0e2a2ce0df2 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -2299,4 +2299,12 @@ struct kvm_create_guest_memfd {
 	__u64 reserved[6];
 };
 
+#define KVM_LINK_GUEST_MEMFD	_IOWR(KVMIO,  0xd5, struct kvm_link_guest_memfd)
+
+struct kvm_link_guest_memfd {
+	__u64 fd;
+	__u64 flags;
+	__u64 reserved[6];
+};
+
 #endif /* __LINUX_KVM_H */
diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index 30d0ab8745ee..1b3df273f785 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -477,6 +477,79 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 	return __kvm_gmem_create(kvm, size, flags, kvm_gmem_mnt);
 }
 
+static inline void __kvm_gmem_do_link(struct inode *inode)
+{
+	/* Refer to simple_link() */
+
+	inode->i_ctime = current_time(inode);
+	inc_nlink(inode);
+
+	/*
+	 * ihold() to add additional reference to inode for reference in dentry,
+	 * created in kvm_gmem_alloc_file() -> alloc_file_pseudo(). This is not
+	 * necessary when creating a new file because alloc_inode() creates
+	 * inodes with i_count = 1, which is the refcount for the dentry in the
+	 * file.
+	 */
+	ihold(inode);
+
+	/*
+	 * dget() and d_instantiate() complete the setup of a dentry, but those
+	 * have already been done in kvm_gmem_alloc_file() ->
+	 * alloc_file_pseudo()
+	 */
+}
+
+int kvm_gmem_link(struct kvm *kvm, struct kvm_link_guest_memfd *args)
+{
+	int ret;
+	int fd;
+	struct fd f;
+	struct kvm_gmem *gmem;
+	u64 flags = args->flags;
+	u64 valid_flags = 0;
+	struct inode *inode;
+	struct file *dst_file;
+
+	if (flags & ~valid_flags)
+		return -EINVAL;
+
+	f = fdget(args->fd);
+	if (!f.file)
+		return -EINVAL;
+
+	ret = -EINVAL;
+	if (f.file->f_op != &kvm_gmem_fops)
+		goto out;
+
+	/* Cannot link a gmem file with the same vm again */
+	gmem = f.file->private_data;
+	if (gmem->kvm == kvm)
+		goto out;
+
+	ret = fd = get_unused_fd_flags(0);
+	if (fd < 0)
+		goto out;
+
+	inode = file_inode(f.file);
+	dst_file = kvm_gmem_alloc_file(inode, kvm_gmem_mnt);
+	if (IS_ERR(dst_file)) {
+		ret = PTR_ERR(dst_file);
+		goto out_fd;
+	}
+
+	__kvm_gmem_do_link(inode);
+
+	fd_install(fd, dst_file);
+	return fd;
+
+out_fd:
+	put_unused_fd(fd);
+out:
+	fdput(f);
+	return ret;
+}
+
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		  unsigned int fd, loff_t offset)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ee331cf8ba54..51cc8b80ebe0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5177,6 +5177,16 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_gmem_create(kvm, &guest_memfd);
 		break;
 	}
+	case KVM_LINK_GUEST_MEMFD: {
+		struct kvm_link_guest_memfd params;
+
+		r = -EFAULT;
+		if (copy_from_user(&params, argp, sizeof(params)))
+			goto out;
+
+		r = kvm_gmem_link(kvm, &params);
+		break;
+	}
 	default:
 		r = kvm_arch_vm_ioctl(filp, ioctl, arg);
 	}
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 798f20d612bb..f85f452133b3 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -41,6 +41,7 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 int kvm_gmem_init(void);
 void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
+int kvm_gmem_link(struct kvm *kvm, struct kvm_link_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		  unsigned int fd, loff_t offset);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
@@ -61,6 +62,12 @@ static inline int kvm_gmem_create(struct kvm *kvm,
 	return -EOPNOTSUPP;
 }
 
+static inline int kvm_gmem_link(struct kvm *kvm,
+				struct kvm_link_guest_memfd *args)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int kvm_gmem_bind(struct kvm *kvm,
 					 struct kvm_memory_slot *slot,
 					 unsigned int fd, loff_t offset)
-- 
2.41.0.640.ga95def55d0-goog

