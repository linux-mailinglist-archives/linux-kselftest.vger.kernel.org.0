Return-Path: <linux-kselftest+bounces-33210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 991F2ABA387
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 21:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544241C02C3B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCE527FB35;
	Fri, 16 May 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNEmi2L4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF1327FB18
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423190; cv=none; b=kW75aFYZ+FowSOSSVgHmeVSF83dm56MVuolcw4eVI7fPRU9qYxtTDrvr9Mv/o4tcyHpaKGYdlo7yp7uFKZLx5elArfW38QjkpGIGykdT7L2fmHE9zHDA+Iq0WKI+E0IKXpii/MRPxNmor/66359A0F+tJq6zmQEBKRwQJFr+zs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423190; c=relaxed/simple;
	bh=dS83jb+y7xN20tz+qtsg/BVSv9ToIR1GtYl9j8CiIQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VYb1+DhtQXglZ2Ph+7aVxnML4b2qxV+OvjvIa5AoLv0aCgFf4iyiiwtCi7X5NaAGNf2KpRi0Ury9gRx+zAQ8KjBt4WrcVFeIf99/Jr0D6AZzNfwVaIFlHmsyj3ojVSOMheObJLF7PjzJlpo9EuFfzlOXXCJMORiTZieCuHZ1zTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNEmi2L4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-231d7f590ffso8695965ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747423188; x=1748027988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zJH+idMyD211PTmBVVKp6b1RIvZ685Zg0MbGCG1vks=;
        b=lNEmi2L4+ijGzhsFQqq+5973EZxQnB71PTpYPxQimnM9NwoGvTeFaI6vuP9PcAZ1AC
         E+e3iLggKsnwSm2fPhIZXTrcB0ie7L0Nke9aX/Nql9/ZQ2ZKL/VRL28YV8FetBW80LPI
         LcqfgRYoRkp4tDOGYeiWHWC+MO3k2CgWjw8MDUs1EJiFhf+B3rrQHy/UTtjOOeO9jQTX
         9DddzMs0Fu6qNG3f1e7AUKH+gJAxkPk99GUWilMAEri7ZVaPo5fJSHtx1ajMkV4xWmUJ
         efbujl1JLJKVbzg6otTuNweX/QilWBQnD/pfebIdQL1yO9e937KFdQwU6EqytkGTitOd
         soJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423188; x=1748027988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zJH+idMyD211PTmBVVKp6b1RIvZ685Zg0MbGCG1vks=;
        b=cevCeyA7p4aeSGM8Nn2vfxafDN30Ch7UfnLyvGv9X4x2CMGi3rV1QPxXFVrlqlN8DD
         lvXqSR/yksxqFsLHwsxsKumMVPlplpDE4Wz5B4NDbS2jGQyUyukHEnkj9TDgGdBNLiTZ
         /L4z/6Os64doUVQDDwbuYUlqADVNaJp2HGjYWxEkcS5DptjBqsMeyjnYQgw1wNcgN8qT
         ce+4t/OwJEED7kpT0tZauvMLJcAsGr4NGZJrgsXCRBICmK37f07gEPDc8bzYly59QmSu
         OjliUBSHzqLJCcagkDILN5/PtByDkMQBVjC4a1LwIGLazDlneLERPHwMz8KH9Rpfsyny
         gXmA==
X-Forwarded-Encrypted: i=1; AJvYcCXJiRq67ZpOkZOKkt3QkCsf5FD653AwgffvJoxIXoFRHNqpb+1Ob8i8XV5XrBf3ugDGP9Hnde6wDQdZIn22tts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/tglGBRpP2GfjYuuegfoPbaHhGtuNlaAz/BwYmnioWZ+d2+DW
	kRugVUkspMGDwh754D7PfnnYvNwaeKHlQ6C3NrE9g6H5O5cN5oSEZl/E2gJdt4agYcJd50b+hMW
	pd4jWZwk6Dw==
X-Google-Smtp-Source: AGHT+IHSFgvebc0wpYjCknBRQjRfr1kshPZ9VPLjcsDoJ4Cjt0l0gPb930vxLxt7iLXiRL6Pz2kWGl52Gpa6
X-Received: from plgi15.prod.google.com ([2002:a17:902:cf0f:b0:231:bbbe:3c94])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e94c:b0:22e:5e82:6701
 with SMTP id d9443c01a7336-231de31179amr45763825ad.18.1747423187689; Fri, 16
 May 2025 12:19:47 -0700 (PDT)
Date: Fri, 16 May 2025 19:19:21 +0000
In-Reply-To: <cover.1747368092.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747368092.git.afranji@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <1f42c32fc18d973b8ec97c8be8b7cd921912d42a.1747368092.git.afranji@google.com>
Subject: [RFC PATCH v2 01/13] fs: Refactor to provide function that allocates
 a secure anonymous inode
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

From: David Hildenbrand <david@redhat.com>

alloc_anon_secure_inode() returns an inode after running checks in
security_inode_init_security_anon().

Also refactor secretmem's file creation process to use the new
function.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 fs/anon_inodes.c   | 23 ++++++++++++++++-------
 include/linux/fs.h | 13 +++++++------
 mm/secretmem.c     |  9 +--------
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 583ac81669c2..0ce28959c43a 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -55,17 +55,20 @@ static struct file_system_type anon_inode_fs_type = {
 	.kill_sb	= kill_anon_super,
 };
 
-static struct inode *anon_inode_make_secure_inode(
-	const char *name,
-	const struct inode *context_inode)
+static struct inode *anon_inode_make_secure_inode(struct super_block *s,
+		const char *name, const struct inode *context_inode,
+		bool fs_internal)
 {
 	struct inode *inode;
 	int error;
 
-	inode = alloc_anon_inode(anon_inode_mnt->mnt_sb);
+	inode = alloc_anon_inode(s);
 	if (IS_ERR(inode))
 		return inode;
-	inode->i_flags &= ~S_PRIVATE;
+
+	if (!fs_internal)
+		inode->i_flags &= ~S_PRIVATE;
+
 	error =	security_inode_init_security_anon(inode, &QSTR(name),
 						  context_inode);
 	if (error) {
@@ -75,6 +78,12 @@ static struct inode *anon_inode_make_secure_inode(
 	return inode;
 }
 
+struct inode *alloc_anon_secure_inode(struct super_block *s, const char *name)
+{
+	return anon_inode_make_secure_inode(s, name, NULL, true);
+}
+EXPORT_SYMBOL_GPL(alloc_anon_secure_inode);
+
 static struct file *__anon_inode_getfile(const char *name,
 					 const struct file_operations *fops,
 					 void *priv, int flags,
@@ -88,7 +97,8 @@ static struct file *__anon_inode_getfile(const char *name,
 		return ERR_PTR(-ENOENT);
 
 	if (make_inode) {
-		inode =	anon_inode_make_secure_inode(name, context_inode);
+		inode = anon_inode_make_secure_inode(anon_inode_mnt->mnt_sb,
+						     name, context_inode, false);
 		if (IS_ERR(inode)) {
 			file = ERR_CAST(inode);
 			goto err;
@@ -318,4 +328,3 @@ static int __init anon_inode_init(void)
 }
 
 fs_initcall(anon_inode_init);
-
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..8eeef9a7fe07 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -309,7 +309,7 @@ struct iattr {
  */
 #define FILESYSTEM_MAX_STACK_DEPTH 2
 
-/** 
+/**
  * enum positive_aop_returns - aop return codes with specific semantics
  *
  * @AOP_WRITEPAGE_ACTIVATE: Informs the caller that page writeback has
@@ -319,7 +319,7 @@ struct iattr {
  * 			    be a candidate for writeback again in the near
  * 			    future.  Other callers must be careful to unlock
  * 			    the page if they get this return.  Returned by
- * 			    writepage(); 
+ * 			    writepage();
  *
  * @AOP_TRUNCATED_PAGE: The AOP method that was handed a locked page has
  *  			unlocked it and the page might have been truncated.
@@ -1141,8 +1141,8 @@ struct file *get_file_active(struct file **f);
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
 
-/* Page cache limit. The filesystems should put that into their s_maxbytes 
-   limits, otherwise bad things can happen in VM. */ 
+/* Page cache limit. The filesystems should put that into their s_maxbytes
+   limits, otherwise bad things can happen in VM. */
 #if BITS_PER_LONG==32
 #define MAX_LFS_FILESIZE	((loff_t)ULONG_MAX << PAGE_SHIFT)
 #elif BITS_PER_LONG==64
@@ -2607,7 +2607,7 @@ int sync_inode_metadata(struct inode *inode, int wait);
 struct file_system_type {
 	const char *name;
 	int fs_flags;
-#define FS_REQUIRES_DEV		1 
+#define FS_REQUIRES_DEV		1
 #define FS_BINARY_MOUNTDATA	2
 #define FS_HAS_SUBTYPE		4
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
@@ -3195,7 +3195,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
 extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
 extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
 extern struct file * open_exec(const char *);
- 
+
 /* fs/dcache.c -- generic fs support functions */
 extern bool is_subdir(struct dentry *, struct dentry *);
 extern bool path_is_under(const struct path *, const struct path *);
@@ -3550,6 +3550,7 @@ extern int simple_write_begin(struct file *file, struct address_space *mapping,
 extern const struct address_space_operations ram_aops;
 extern int always_delete_dentry(const struct dentry *);
 extern struct inode *alloc_anon_inode(struct super_block *);
+extern struct inode *alloc_anon_secure_inode(struct super_block *, const char *);
 extern int simple_nosetlease(struct file *, int, struct file_lease **, void **);
 extern const struct dentry_operations simple_dentry_operations;
 
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 1b0a214ee558..c0e459e58cb6 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -195,18 +195,11 @@ static struct file *secretmem_file_create(unsigned long flags)
 	struct file *file;
 	struct inode *inode;
 	const char *anon_name = "[secretmem]";
-	int err;
 
-	inode = alloc_anon_inode(secretmem_mnt->mnt_sb);
+	inode = alloc_anon_secure_inode(secretmem_mnt->mnt_sb, anon_name);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
-	err = security_inode_init_security_anon(inode, &QSTR(anon_name), NULL);
-	if (err) {
-		file = ERR_PTR(err);
-		goto err_free_inode;
-	}
-
 	file = alloc_file_pseudo(inode, secretmem_mnt, "secretmem",
 				 O_RDWR, &secretmem_fops);
 	if (IS_ERR(file))
-- 
2.49.0.1101.gccaa498523-goog


