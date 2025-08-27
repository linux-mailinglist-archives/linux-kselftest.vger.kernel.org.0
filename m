Return-Path: <linux-kselftest+bounces-40114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09722B38E97
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Aug 2025 00:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF0D7C3453
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 22:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B2330FC30;
	Wed, 27 Aug 2025 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vod2eeVa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2755030F920
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334606; cv=none; b=h3aIdfY3PASv2dZYKAYkIXJHYQ8QHXo5/M12G7JbaRWtmdYhi0dNnaYTG6hEmRD3EwwRf/TiAZFbI5JokCpdKx4jfLVawr/Mp3nLP021+aV2LQuIZNUP22irE31aEDSPLgGG45TSBbFEPrFqtUnBLnoVEPC4JU8NtgL7FB8Jt/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334606; c=relaxed/simple;
	bh=UV40lWEU1CK8wkwXXYA9M+vhaPbr7DhrqOxUAeNCRJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e+YeBC07tG3qUOjwQcsYpKbw64qbP7F2v5wCfR9uBouA+THjZ1gatu3GbMBco3URfQalcmgr8chq/yvX9UHLUwB3fr3+eO4sNH0lY+C14p77x/bgihe82veo0pFUzQU5ITA/9Os/7ShIP2W3XAt6jJGMbF/ZI2aa0wvvuc56Djw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vod2eeVa; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-325e31cecd6so268900a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 15:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756334602; x=1756939402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKcxlPw0uQjBkw7eQMnE+gmOL2ekj9P4WG4v5yuEZSw=;
        b=vod2eeVaG9wM5K3kMJQUXDUIs0qUQmbSpjatH1C0VQtHAZNudlYjdOSs4Mz3L+Wsr0
         Xf8NkhtoHLdlMbHtLhepBZgxwsIzZCgToO6bYPJlE+M2X75B5pdPdZpqRjNHvlP/Kwju
         CPEWmXknSGiP7munSagw5dkuKQM+bpqBAiPbx0sIi5aB2cUsdrbunHwqBQSTIDRiKbP+
         1ftpgfg9xI1258b1WKxVHLiPL9Lf6jZIGIzZnQxvt9qpdQaaV/NwHkaTrjYVcC2DvB/6
         oUsFg5x9cJv8FQcWAXTmA9bsCLDd5etuqmFhEDkdsS/UbG3V70dTig0MIYladc63PzsY
         iVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756334602; x=1756939402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKcxlPw0uQjBkw7eQMnE+gmOL2ekj9P4WG4v5yuEZSw=;
        b=kqj+4wzMrG9bpnigiweCkHm5/d/dVuLKPvovB6r+OoZ4R/JyE6BCOhUb5CqKTg1RcV
         ytyoSJeZd1M7xkQQwFkMEnjnlwIQYxNTYySSyTXOhvBiPUB/3chdBEFowcgTf+ozI9Ow
         QlCl7RpEobukV+082DWjVH0R6JhjXXJc8GsqbjBxlvT9M/bKYRdpR2fMpNUlHuIsYL+T
         /NBXBNntiU3Ll6DMdPFOc6YypmBM2BHKHd4GMztCq2NbVRKm1DpgCrJwht/LDrQBwz+8
         kyGimcszNERyrgqiQ6saafQRrVt8POSLwEtw11+OIFv0q3WTyRLw/781/4KY0WPqf/+a
         PHWA==
X-Forwarded-Encrypted: i=1; AJvYcCUOb1HaWOj3mCM62VUn4e/+2d3JjKtmwmjcO3yPktrC3iKDaL5MVxo2HnJ5Efwv8OXZ0FOk2aBBBxlyyC70jCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweX4bH8+zBVfly2WRDgdYs9gMNsqSoMOq+e2Bjvdfg3H4k9J92
	okz7GYwB3CFDyH1Gb2ITCdEir9M+wwlB8eU734bP81oXfUMpzYJXCbzOyR3Rrwzns2jvA00yHrE
	Kkbd/NTjqJHJlkaba3Niufb12pQ==
X-Google-Smtp-Source: AGHT+IGNhCki+zRNFnf7AupQOwuzR8TBEtFWXAfIyU7yRpBo61MiAC41fjzXQhOiSXx1TrtlLAFGHZ8M3ImJd0zqNQ==
X-Received: from pjl11.prod.google.com ([2002:a17:90b:2f8b:b0:325:7fbe:1c64])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:da8c:b0:327:7c8e:8725 with SMTP id 98e67ed59e1d1-3277c8eb5a6mr3670514a91.10.1756334602319;
 Wed, 27 Aug 2025 15:43:22 -0700 (PDT)
Date: Wed, 27 Aug 2025 15:43:20 -0700
In-Reply-To: <20250827175247.83322-7-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827175247.83322-2-shivankg@amd.com> <20250827175247.83322-7-shivankg@amd.com>
Message-ID: <diqztt1sbd2v.fsf@google.com>
Subject: Re: [PATCH kvm-next V11 4/7] KVM: guest_memfd: Use guest mem inodes
 instead of anonymous inodes
From: Ackerley Tng <ackerleytng@google.com>
To: Shivank Garg <shivankg@amd.com>, willy@infradead.org, akpm@linux-foundation.org, 
	david@redhat.com, pbonzini@redhat.com, shuah@kernel.org, seanjc@google.com, 
	vbabka@suse.cz
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, dsterba@suse.com, 
	xiang@kernel.org, chao@kernel.org, jaegeuk@kernel.org, clm@fb.com, 
	josef@toxicpanda.com, kent.overstreet@linux.dev, zbestahu@gmail.com, 
	jefflexu@linux.alibaba.com, dhavale@google.com, lihongbo22@huawei.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	tabba@google.com, shivankg@amd.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, pvorel@suse.cz, bfoster@redhat.com, vannapurve@google.com, 
	chao.gao@intel.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com, 
	shdhiman@amd.com, yan.y.zhao@intel.com, Neeraj.Upadhyay@amd.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, aik@amd.com, jgg@nvidia.com, 
	kalyazin@amazon.com, peterx@redhat.com, jack@suse.cz, hch@infradead.org, 
	cgzones@googlemail.com, ira.weiny@intel.com, rientjes@google.com, 
	roypat@amazon.co.uk, chao.p.peng@intel.com, amit@infradead.org, 
	ddutile@redhat.com, dan.j.williams@intel.com, ashish.kalra@amd.com, 
	gshan@redhat.com, jgowans@amazon.com, pankaj.gupta@amd.com, papaluri@amd.com, 
	yuzhao@google.com, suzuki.poulose@arm.com, quic_eberman@quicinc.com, 
	linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Shivank Garg <shivankg@amd.com> writes:

> 
> [...snip...]
> 

I meant to send this to you before this version went out but you were
too quick!

Here's a new version, Fuad and I reviewed this again internally. The
changes are:

+ Sort linux/pseudo_fs.h after linux/pagemap.h (alphabetical)
+ Don't set MNT_NOEXEC on the mount, since SB_I_NOEXEC was already set
  on the superblock
+ Rename kvm_gmem_inode_make_secure_inode() to kvm_gmem_inode_create()
    + Emphasizes that there is a creation in this function
    + Remove "secure" from the function name to remove confusion that
      there may be a "non-secure" version
+ In kvm_gmem_inode_create_getfile()'s error path, return ERR_PTR(err)
  directly instead of having a goto


From ada9814b216eac129ed44dffd3acf76fce2cc08a Mon Sep 17 00:00:00 2001
From: Ackerley Tng <ackerleytng@google.com>
Date: Sun, 13 Jul 2025 17:43:35 +0000
Subject: [PATCH] KVM: guest_memfd: Use guest mem inodes instead of anonymous
 inodes

guest_memfd's inode represents memory the guest_memfd is
providing. guest_memfd's file represents a struct kvm's view of that
memory.

Using a custom inode allows customization of the inode teardown
process via callbacks. For example, ->evict_inode() allows
customization of the truncation process on file close, and
->destroy_inode() and ->free_inode() allow customization of the inode
freeing process.

Customizing the truncation process allows flexibility in management of
guest_memfd memory and customization of the inode freeing process
allows proper cleanup of memory metadata stored on the inode.

Memory metadata is more appropriately stored on the inode (as opposed
to the file), since the metadata is for the memory and is not unique
to a specific binding and struct kvm.

Co-developed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/uapi/linux/magic.h |   1 +
 virt/kvm/guest_memfd.c     | 126 ++++++++++++++++++++++++++++++-------
 virt/kvm/kvm_main.c        |   7 ++-
 virt/kvm/kvm_mm.h          |   9 +--
 4 files changed, 116 insertions(+), 27 deletions(-)

diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index bb575f3ab45e5..638ca21b7a909 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -103,5 +103,6 @@
 #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
 #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
 #define PID_FS_MAGIC		0x50494446	/* "PIDF" */
+#define GUEST_MEMFD_MAGIC	0x474d454d	/* "GMEM" */

 #endif /* __LINUX_MAGIC_H__ */
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 08a6bc7d25b60..234e51fd69ff6 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1,12 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/anon_inodes.h>
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
+#include <linux/fs.h>
 #include <linux/kvm_host.h>
 #include <linux/pagemap.h>
-#include <linux/anon_inodes.h>
+#include <linux/pseudo_fs.h>

 #include "kvm_mm.h"

+static struct vfsmount *kvm_gmem_mnt;
+
 struct kvm_gmem {
 	struct kvm *kvm;
 	struct xarray bindings;
@@ -385,9 +389,44 @@ static struct file_operations kvm_gmem_fops = {
 	.fallocate	= kvm_gmem_fallocate,
 };

-void kvm_gmem_init(struct module *module)
+static int kvm_gmem_init_fs_context(struct fs_context *fc)
+{
+	if (!init_pseudo(fc, GUEST_MEMFD_MAGIC))
+		return -ENOMEM;
+
+	fc->s_iflags |= SB_I_NOEXEC;
+	fc->s_iflags |= SB_I_NODEV;
+
+	return 0;
+}
+
+static struct file_system_type kvm_gmem_fs = {
+	.name		 = "guest_memfd",
+	.init_fs_context = kvm_gmem_init_fs_context,
+	.kill_sb	 = kill_anon_super,
+};
+
+static int kvm_gmem_init_mount(void)
+{
+	kvm_gmem_mnt = kern_mount(&kvm_gmem_fs);
+
+	if (IS_ERR(kvm_gmem_mnt))
+		return PTR_ERR(kvm_gmem_mnt);
+
+	return 0;
+}
+
+int kvm_gmem_init(struct module *module)
 {
 	kvm_gmem_fops.owner = module;
+
+	return kvm_gmem_init_mount();
+}
+
+void kvm_gmem_exit(void)
+{
+	kern_unmount(kvm_gmem_mnt);
+	kvm_gmem_mnt = NULL;
 }

 static int kvm_gmem_migrate_folio(struct address_space *mapping,
@@ -463,11 +502,70 @@ bool __weak kvm_arch_supports_gmem_mmap(struct kvm *kvm)
 	return true;
 }

+static struct inode *kvm_gmem_inode_create(const char *name, loff_t size,
+					   u64 flags)
+{
+	struct inode *inode;
+
+	inode = anon_inode_make_secure_inode(kvm_gmem_mnt->mnt_sb, name, NULL);
+	if (IS_ERR(inode))
+		return inode;
+
+	inode->i_private = (void *)(unsigned long)flags;
+	inode->i_op = &kvm_gmem_iops;
+	inode->i_mapping->a_ops = &kvm_gmem_aops;
+	inode->i_mode |= S_IFREG;
+	inode->i_size = size;
+	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
+	mapping_set_inaccessible(inode->i_mapping);
+	/* Unmovable mappings are supposed to be marked unevictable as well. */
+	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
+
+	return inode;
+}
+
+static struct file *kvm_gmem_inode_create_getfile(void *priv, loff_t size,
+						  u64 flags)
+{
+	static const char *name = "[kvm-gmem]";
+	struct inode *inode;
+	struct file *file;
+	int err;
+
+	err = -ENOENT;
+	/* __fput() will take care of fops_put(). */
+	if (!fops_get(&kvm_gmem_fops))
+		goto err;
+
+	inode = kvm_gmem_inode_create(name, size, flags);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		goto err_fops_put;
+	}
+
+	file = alloc_file_pseudo(inode, kvm_gmem_mnt, name, O_RDWR,
+				 &kvm_gmem_fops);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_put_inode;
+	}
+
+	file->f_flags |= O_LARGEFILE;
+	file->private_data = priv;
+
+	return file;
+
+err_put_inode:
+	iput(inode);
+err_fops_put:
+	fops_put(&kvm_gmem_fops);
+err:
+	return ERR_PTR(err);
+}
+
 static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 {
-	const char *anon_name = "[kvm-gmem]";
 	struct kvm_gmem *gmem;
-	struct inode *inode;
 	struct file *file;
 	int fd, err;

@@ -481,32 +579,16 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags)
 		goto err_fd;
 	}

-	file = anon_inode_create_getfile(anon_name, &kvm_gmem_fops, gmem,
-					 O_RDWR, NULL);
+	file = kvm_gmem_inode_create_getfile(gmem, size, flags);
 	if (IS_ERR(file)) {
 		err = PTR_ERR(file);
 		goto err_gmem;
 	}

-	file->f_flags |= O_LARGEFILE;
-
-	inode = file->f_inode;
-	WARN_ON(file->f_mapping != inode->i_mapping);
-
-	inode->i_private = (void *)(unsigned long)flags;
-	inode->i_op = &kvm_gmem_iops;
-	inode->i_mapping->a_ops = &kvm_gmem_aops;
-	inode->i_mode |= S_IFREG;
-	inode->i_size = size;
-	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
-	mapping_set_inaccessible(inode->i_mapping);
-	/* Unmovable mappings are supposed to be marked unevictable as well. */
-	WARN_ON_ONCE(!mapping_unevictable(inode->i_mapping));
-
 	kvm_get_kvm(kvm);
 	gmem->kvm = kvm;
 	xa_init(&gmem->bindings);
-	list_add(&gmem->entry, &inode->i_mapping->i_private_list);
+	list_add(&gmem->entry, &file_inode(file)->i_mapping->i_private_list);

 	fd_install(fd, file);
 	return fd;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 18f29ef935437..301d48d6e00d0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6489,7 +6489,9 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	if (WARN_ON_ONCE(r))
 		goto err_vfio;

-	kvm_gmem_init(module);
+	r = kvm_gmem_init(module);
+	if (r)
+		goto err_gmem;

 	r = kvm_init_virtualization();
 	if (r)
@@ -6510,6 +6512,8 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 err_register:
 	kvm_uninit_virtualization();
 err_virt:
+	kvm_gmem_exit();
+err_gmem:
 	kvm_vfio_ops_exit();
 err_vfio:
 	kvm_async_pf_deinit();
@@ -6541,6 +6545,7 @@ void kvm_exit(void)
 	for_each_possible_cpu(cpu)
 		free_cpumask_var(per_cpu(cpu_kick_mask, cpu));
 	kmem_cache_destroy(kvm_vcpu_cache);
+	kvm_gmem_exit();
 	kvm_vfio_ops_exit();
 	kvm_async_pf_deinit();
 	kvm_irqfd_exit();
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 31defb08ccbab..9fcc5d5b7f8d0 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -68,17 +68,18 @@ static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
 #endif /* HAVE_KVM_PFNCACHE */

 #ifdef CONFIG_KVM_GUEST_MEMFD
-void kvm_gmem_init(struct module *module);
+int kvm_gmem_init(struct module *module);
+void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		  unsigned int fd, loff_t offset);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 #else
-static inline void kvm_gmem_init(struct module *module)
+static inline int kvm_gmem_init(struct module *module)
 {
-
+	return 0;
 }
-
+static inline void kvm_gmem_exit(void) {};
 static inline int kvm_gmem_bind(struct kvm *kvm,
 					 struct kvm_memory_slot *slot,
 					 unsigned int fd, loff_t offset)
--
2.51.0.268.g9569e192d0-goog

