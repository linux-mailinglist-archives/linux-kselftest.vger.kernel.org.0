Return-Path: <linux-kselftest+bounces-41186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E775CB51E73
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 19:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4925E4208
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Sep 2025 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6BD298CC4;
	Wed, 10 Sep 2025 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGz9d66G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E06329F1B
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Sep 2025 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757523634; cv=none; b=ZT6m6jSTO7mA6V7v9l0ULJITNZLk5HMG8rvLGiKJhTc1jLghJOA0NsboDZt1L3tP/1g72AtAEqOsWkpCYN1DseNafEqe/IGkLOSvZPpCDByY0PhnnDm3lrhKmfPdHbRNo3t6bcQPQOuzy2HtLJfavo+YO0PgK7E/peiK09uWwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757523634; c=relaxed/simple;
	bh=p+NVPNkWx25cSfYoK0FO8C9FqWaXq5V69UlkKtuHWKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pglvbi7WhiTsDU+VtJazE1IDVeZU7zoeigs/49pBdgTQ0psHXkdLVdP8mzNc/qsDcwZi3qL7frSoTFTAPaCnTf3Ca8C3Zvv2Ed0x+JCFt33RAPHshctG29WG+csFLNwsqcsaSLACUm2Z9M4jLY5DtBKvZABEr7lDp7V8DVzyA8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cGz9d66G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757523630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UDjic9ICmOZRP08A7LmsmRHImNuEcHgVdZxPz5GGj18=;
	b=cGz9d66GW7lGsS6UUokXNAR7AKLbJBTpd2UBm8HgI+vqufXixs1k93P1fIqQ4NPYx6vZql
	w603VhdN+DbRwaDbTSBDu2VmbB9pLR41vaw8aYLFXzKpdapfdqWaWApaaUWMmihJSxXG4n
	Wn4LZ5PYBL4K1e4Fcv0AhqWBW1fHNi0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-FP45MaW2Ng2VZ2jA6U_uyg-1; Wed,
 10 Sep 2025 13:00:29 -0400
X-MC-Unique: FP45MaW2Ng2VZ2jA6U_uyg-1
X-Mimecast-MFC-AGG-ID: FP45MaW2Ng2VZ2jA6U_uyg_1757523627
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78DDB18002C0;
	Wed, 10 Sep 2025 17:00:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.22.10])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 748331956095;
	Wed, 10 Sep 2025 17:00:21 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-mm@kvack.org,
	safety-architecture@lists.elisa.tech,
	acarmina@redhat.com,
	kstewart@linuxfoundation.org,
	chuckwolber@gmail.com,
	Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [RFC v2 PATCH 2/3] /dev/mem: Add initial documentation of memory_open() and mem_fops
Date: Wed, 10 Sep 2025 18:59:59 +0200
Message-ID: <20250910170000.6475-3-gpaoloni@redhat.com>
In-Reply-To: <20250910170000.6475-1-gpaoloni@redhat.com>
References: <20250910170000.6475-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This patch proposes initial kernel-doc documentation for memory_open()
and most of the functions in the mem_fops structure.
The format used for the specifications follows the guidelines
defined in Documentation/doc-guide/code-specifications.rst

Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
---
 drivers/char/mem.c | 231 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 225 insertions(+), 6 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 48839958b0b1..e69c164e9465 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -75,9 +75,54 @@ static inline bool should_stop_iteration(void)
 	return signal_pending(current);
 }
 
-/*
- * This funcion reads the *physical* memory. The f_pos points directly to the
- * memory location.
+/**
+ * read_mem - read from physical memory (/dev/mem).
+ * @file: struct file associated with /dev/mem.
+ * @buf: user-space buffer to copy data to.
+ * @count: number of bytes to read.
+ * @ppos: pointer to the current file position, representing the physical
+ *        address to read from.
+ *
+ * This function checks if the requested physical memory range is valid
+ * and accessible by the user, then it copies data to the input
+ * user-space buffer up to the requested number of bytes.
+ *
+ * Function's expectations:
+ *
+ * 1. This function shall check if the value pointed by ppos exceeds the
+ *    maximum addressable physical address;
+ *
+ * 2. This function shall check if the physical address range to be read
+ *    is valid (i.e. it falls within a memory block and if it can be mapped
+ *    to the kernel address space);
+ *
+ * 3. For each memory page falling in the requested physical range
+ *    [ppos, ppos + count - 1]:
+ *   3.1. this function shall check if user space access is allowed (if
+ *        config STRICT_DEVMEM is not set, access is always granted);
+ *
+ *   3.2. if access is allowed, the memory content from the page range falling
+ *        within the requested physical range shall be copied to the user space
+ *        buffer;
+ *
+ *   3.3. zeros shall be copied to the user space buffer (for the page range
+ *        falling within the requested physical range):
+ *     3.3.1. if access to the memory page is restricted or,
+ *     3.2.2. if the current page is page 0 on HW architectures where page 0 is
+ *            not mapped.
+ *
+ * 4. The file position '*ppos' shall be advanced by the number of bytes
+ *    successfully copied to user space (including zeros).
+ *
+ * Context: process context.
+ *
+ * Return:
+ * * the number of bytes copied to user on success
+ * * %-EFAULT - the requested address range is not valid or a fault happened
+ *   when copying to user-space (i.e. copy_from_kernel_nofault() failed)
+ * * %-EPERM - access to any of the required physical pages is not allowed
+ * * %-ENOMEM - out of memory error for auxiliary kernel buffers supporting
+ *   the operation of copying content from the physical pages
  */
 static ssize_t read_mem(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
@@ -166,6 +211,54 @@ static ssize_t read_mem(struct file *file, char __user *buf,
 	return err;
 }
 
+/**
+ * write_mem - write to physical memory (/dev/mem).
+ * @file: struct file associated with /dev/mem.
+ * @buf: user-space buffer containing the data to write.
+ * @count: number of bytes to write.
+ * @ppos: pointer to the current file position, representing the physical
+ *        address to write to.
+ *
+ * This function checks if the target physical memory range is valid
+ * and accessible by the user, then it writes data from the input
+ * user-space buffer up to the requested number of bytes.
+ *
+ * Function's expectations:
+ * 1. This function shall check if the value pointed by ppos exceeds the
+ *    maximum addressable physical address;
+ *
+ * 2. This function shall check if the physical address range to be written
+ *    is valid (i.e. it falls within a memory block and if it can be mapped
+ *    to the kernel address space);
+ *
+ * 3. For each memory page falling in the physical range to be written
+ *    [ppos, ppos + count - 1]:
+ *   3.1. this function shall check if user space access is allowed (if
+ *        config STRICT_DEVMEM is not set, access is always granted);
+ *
+ *   3.2. the content from the user space buffer shall be copied to the page
+ *        range falling within the physical range to be written if access is
+ *        allowed;
+ *
+ *   3.3. the data to be copied from the user space buffer (for the page range
+ *        falling within the range to be written) shall be skipped:
+ *     3.3.1. if access to the memory page is restricted or,
+ *     3.3.2. if the current page is page 0 on HW architectures where page 0
+ *            is not mapped.
+ *
+ * 4. The file position '*ppos' shall be advanced by the number of bytes
+ *    successfully copied from user space (including skipped bytes).
+ *
+ * Context: process context.
+ *
+ * Return:
+ * * the number of bytes copied from user-space on success
+ * * %-EFBIG - the value pointed by ppos exceeds the maximum addressable
+ *   physical address
+ * * %-EFAULT - the physical address range is not valid or no bytes could
+ *   be copied from user-space
+ * * %-EPERM - access to any of the required pages is not allowed
+ */
 static ssize_t write_mem(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
@@ -322,6 +415,42 @@ static const struct vm_operations_struct mmap_mem_ops = {
 #endif
 };
 
+/**
+ * mmap_mem - map physical memory into user space (/dev/mem).
+ * @file: file structure for the device.
+ * @vma: virtual memory area structure describing the user mapping.
+ *
+ * This function checks if the requested physical memory range is valid
+ * and accessible by the user, then it maps the physical memory range to
+ * user-mode address space.
+ *
+ * Function's expectations:
+ * 1. This function shall check if the requested physical address range to be
+ *    mapped fits within the maximum addressable physical range;
+ *
+ * 2. This function shall check if the requested  physical range corresponds to
+ *    a valid physical range and if access is allowed on it (if config STRICT_DEVMEM
+ *    is not set, access is always allowed);
+ *
+ * 3. This function shall check if the input virtual memory area can be used for
+ *    a private mapping (always OK if there is an MMU);
+ *
+ * 4. This function shall set the virtual memory area operations to
+ *    &mmap_mem_ops;
+ *
+ * 5. This function shall establish a mapping between the user-space
+ *    virtual memory area described by vma and the physical memory
+ *    range specified by vma->vm_pgoff and size;
+ *
+ * Context: process context.
+ *
+ * Return:
+ * * 0 on success
+ * * %-EAGAIN - invalid or unsupported mapping requested (remap_pfn_range()
+ *   fails)
+ * * %-EINVAL - requested physical range to be mapped is not valid
+ * * %-EPERM - no permission to access the requested physical range
+ */
 static int mmap_mem(struct file *file, struct vm_area_struct *vma)
 {
 	size_t size = vma->vm_end - vma->vm_start;
@@ -550,13 +679,47 @@ static loff_t null_lseek(struct file *file, loff_t offset, int orig)
 	return file->f_pos = 0;
 }
 
-/*
+/**
+ * memory_lseek - change the file position.
+ * @file: file structure for the device.
+ * @offset: file offset to seek to.
+ * @orig: where to start seeking from (see whence in the llseek manpage).
+ *
+ * This function changes the file position according to the input offset
+ * and orig parameters.
+ *
+ * Function's expectations:
+ * 1. This function shall lock the semaphore of the inode corresponding to the
+ *    input file before any operation and unlock it before returning.
+ *
+ * 2. This function shall check the orig value and accordingly:
+ *   2.1. if it is equal to SEEK_CUR, the current file position shall be
+ *        incremented by the input offset;
+ *   2.2. if it is equal to SEEK_SET, the current file position shall be
+ *        set to the input offset value;
+ *   2.3. any other value shall result in an error condition.
+ *
+ * 3. Before writing the current file position, the new position value
+ *    shall be checked to not overlap with Linux ERRNO values.
+ *
+ * Assumptions of Use:
+ * 1. the input file pointer is expected to be valid.
+ *
+ * Notes:
  * The memory devices use the full 32/64 bits of the offset, and so we cannot
  * check against negative addresses: they are ok. The return value is weird,
  * though, in that case (0).
  *
- * also note that seeking relative to the "end of file" isn't supported:
- * it has no meaning, so it returns -EINVAL.
+ * Also note that seeking relative to the "end of file" isn't supported:
+ * it has no meaning, so passing orig equal to SEEK_END returns -EINVAL.
+ *
+ * Context: process context, locks/unlocks inode->i_rwsem
+ *
+ * Return:
+ * * the new file position on success
+ * * %-EOVERFLOW - the new position value equals or exceeds
+ *   (unsigned long long) -MAX_ERRNO
+ * * %-EINVAL - the orig parameter is invalid
  */
 static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 {
@@ -584,6 +747,35 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 	return ret;
 }
 
+/**
+ * open_port - open the I/O port device (/dev/port).
+ * @inode: inode of the device file.
+ * @filp: file structure for the device.
+ *
+ * This function checks if the caller can access the port device and sets
+ * the f_mapping pointer of filp to the i_mapping pointer of inode.
+ *
+ * Function's expectations:
+ * 1. This function shall check if the caller has sufficient capabilities to
+ *    perform raw I/O access;
+ *
+ * 2. This function shall check if the kernel is locked down with the
+ *    &LOCKDOWN_DEV_MEM restriction;
+ *
+ * 3. If the input inode corresponds to /dev/mem, the f_mapping pointer
+ *    of the input file structure shall be set to the i_mapping pointer
+ *    of the input inode;
+ *
+ * Assumptions of Use:
+ * 1. The input inode and filp are expected to be valid.
+ *
+ * Context: process context.
+ *
+ * Return:
+ * * 0 on success
+ * * %-EPERM - caller lacks the required capability (CAP_SYS_RAWIO)
+ * * any error returned by securty_locked_down()
+ */
 static int open_port(struct inode *inode, struct file *filp)
 {
 	int rc;
@@ -691,6 +883,33 @@ static const struct memdev {
 #endif
 };
 
+/**
+ * memory_open - set the filp f_op to the memory device fops and invoke open().
+ * @inode: inode of the device file.
+ * @filp: file structure for the device.
+ *
+ * Function's expectations:
+ * 1. This function shall retrieve the minor number associated with the input
+ *   inode and the memory device corresponding to such minor number;
+ *
+ * 2. The file operations pointer shall be set to the memory device file operations;
+ *
+ * 3. The file mode member of the input filp shall be OR'd with the device mode;
+ *
+ * 4. The memory device open() file operation shall be invoked.
+ *
+ * Assumptions of Use:
+ * 1. The input inode and filp are expected to be non-NULL.
+ *
+ * Context: process context.
+ *
+ * Return:
+ * * 0 on success
+ * * %-ENXIO - the minor number corresponding to the input inode cannot be
+ *   associated with any device or the corresponding device has a NULL fops
+ *   pointer
+ * * any error returned by the device specific open function pointer
+ */
 static int memory_open(struct inode *inode, struct file *filp)
 {
 	int minor;
-- 
2.48.1


