Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEB8798BA2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 19:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245352AbjIHR6J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 13:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245241AbjIHR6H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 13:58:07 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFCE1FC9
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Sep 2023 10:58:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5958487ca15so25460377b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Sep 2023 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694195882; x=1694800682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fOWw6cIr3DHErX8Jy6XcNouUGNoG83SlOd1aTTOGtPk=;
        b=gxc06Z9c/AzYTHOJWlKbIU/KmhObfzuUvf+z+B2B3TrKmQfg0IlWfeLQILhngLBQ/a
         DBaV8imXRYbjxfHmFdNJxyGVwtyPdGnKuj3hO+++i1oc0kdkOFHdwxDa7dBe2XCycbmz
         Y9toewjuNheKViZHK8+y6CBUHJ0U97TuROQQjpqPLAy0VmZHjl1824dGU7UKJQAqWMms
         DFO/5vyVZVU2TZkm4TmRoa9gTEv1MpL/su5FN6VdfSzlIrLU1vIDRSZY4SdiRJLbqPN5
         wjag4BhQ9mjis5kZlKCWjD1eDIWsBfhlNWZ1d71yyXScr9oR3nY2e/ZW5U733Y/w0mvq
         0TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694195882; x=1694800682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOWw6cIr3DHErX8Jy6XcNouUGNoG83SlOd1aTTOGtPk=;
        b=Jmb8GBhe6PEGibNfSjdeQOmv/dYwJFJUxMpwt29RFXoyt2+uVo+HyFz4JwatmEtJRZ
         fbFT91D5zNngmnDDaWfuWNMZqP76n+Draw7CzXc4cpsmcXMcPPkckCjZuPgJN+Rj5KSc
         p28EAyQmEejpTVyDCMiZJ42vfoZB86YZCbJGwDbVcqO/Y/ts6zpcVF2tUyrRpWzTvBbl
         +RfVMKdjxNWxmEPPW4MRFN48i+UQiV+h2HTwJgGeYLKP7LOO/KNbZhh67O1N8W6U8i57
         ODSMOXrPGLFE1XocufaObtiPiuTNbgSHBG48vY0NA3Afvr5ly+WqUM9WY4EZGGDYvBQ2
         dYyA==
X-Gm-Message-State: AOJu0YyW3oJu5ZPBktXf2ay04e+uw1RBuWOBKJeq9MsqZo5Jp3SmHUUK
        acAsFhP9ns/LD+KHt6ruO4lK0sKgLrURMjaT
X-Google-Smtp-Source: AGHT+IE5bvyoUpPyi5zts+0vRvDDIo/LdDOiErDcfAUR6eXex8q5LfTR+2Qdlr+ta/HZrQD4sEhbFIAJ61n546Jd
X-Received: from mclapinski.waw.corp.google.com ([2a00:79e0:9b:0:aa82:a90b:b76f:32b0])
 (user=mclapinski job=sendgmr) by 2002:a81:ae66:0:b0:58c:6ddd:d27c with SMTP
 id g38-20020a81ae66000000b0058c6dddd27cmr76506ywk.6.1694195882399; Fri, 08
 Sep 2023 10:58:02 -0700 (PDT)
Date:   Fri,  8 Sep 2023 19:57:37 +0200
In-Reply-To: <20230908175738.41895-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20230908175738.41895-1-mclapinski@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908175738.41895-2-mclapinski@google.com>
Subject: [PATCH v2 1/2] mm/memfd: add ioctl(MEMFD_CHECK_IF_ORIGINAL)
From:   Michal Clapinski <mclapinski@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Yi Liu <yi.l.liu@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Steve French <stfrench@microsoft.com>,
        Simon Ser <contact@emersion.fr>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Luca Vizzarro <Luca.Vizzarro@arm.com>,
        Jeff Xu <jeffxu@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Cc:     Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a way to check if an fd points to the memfd's original open fd
(the one created by memfd_create).
Useful because only the original open fd can be both writable and
executable.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst |  1 +
 fs/hugetlbfs/inode.c                               |  9 +++++++++
 include/linux/memfd.h                              | 12 ++++++++++++
 mm/memfd.c                                         |  9 +++++++++
 mm/shmem.c                                         |  9 +++++++++
 5 files changed, 40 insertions(+)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 4ea5b837399a..9a0782116ac2 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -355,6 +355,7 @@ Code  Seq#    Include File                                           Comments
 0xB6  all    linux/fpga-dfl.h
 0xB7  all    uapi/linux/remoteproc_cdev.h                            <mailto:linux-remoteproc@vger.kernel.org>
 0xB7  all    uapi/linux/nsfs.h                                       <mailto:Andrei Vagin <avagin@openvz.org>>
+0xB8  00     linux/memfd.h
 0xC0  00-0F  linux/usb/iowarrior.h
 0xCA  00-0F  uapi/misc/cxl.h
 0xCA  10-2F  uapi/misc/ocxl.h
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 316c4cebd3f3..89ff46f7ac54 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -35,6 +35,7 @@
 #include <linux/magic.h>
 #include <linux/migrate.h>
 #include <linux/uio.h>
+#include <linux/memfd.h>
 
 #include <linux/uaccess.h>
 #include <linux/sched/mm.h>
@@ -1324,6 +1325,12 @@ static void init_once(void *foo)
 	inode_init_once(&ei->vfs_inode);
 }
 
+static long hugetlbfs_file_ioctl(struct file *file, unsigned int cmd,
+				 unsigned long arg)
+{
+	return memfd_ioctl(file, cmd, arg);
+}
+
 const struct file_operations hugetlbfs_file_operations = {
 	.read_iter		= hugetlbfs_read_iter,
 	.mmap			= hugetlbfs_file_mmap,
@@ -1331,6 +1338,8 @@ const struct file_operations hugetlbfs_file_operations = {
 	.get_unmapped_area	= hugetlb_get_unmapped_area,
 	.llseek			= default_llseek,
 	.fallocate		= hugetlbfs_fallocate,
+	.unlocked_ioctl		= hugetlbfs_file_ioctl,
+	.compat_ioctl		= hugetlbfs_file_ioctl,
 };
 
 static const struct inode_operations hugetlbfs_dir_inode_operations = {
diff --git a/include/linux/memfd.h b/include/linux/memfd.h
index e7abf6fa4c52..50f512624c92 100644
--- a/include/linux/memfd.h
+++ b/include/linux/memfd.h
@@ -3,14 +3,26 @@
 #define __LINUX_MEMFD_H
 
 #include <linux/file.h>
+#include <linux/ioctl.h>
 
 #ifdef CONFIG_MEMFD_CREATE
 extern long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg);
+extern long memfd_ioctl(struct file *file, unsigned int cmd, unsigned int arg);
 #else
 static inline long memfd_fcntl(struct file *f, unsigned int c, unsigned int a)
 {
 	return -EINVAL;
 }
+static inline long memfd_ioctl(struct file *f, unsigned int c, unsigned int a)
+{
+	return -EINVAL;
+}
 #endif
 
+/*
+ * Return 1 if the memfd is original (i.e. was created by memfd_create,
+ * not reopened), 0 otherwise.
+ */
+#define MEMFD_CHECK_IF_ORIGINAL		_IOR(0xB8, 0, int)
+
 #endif /* __LINUX_MEMFD_H */
diff --git a/mm/memfd.c b/mm/memfd.c
index 1cad1904fc26..06bcb970c387 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -262,6 +262,15 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 	return error;
 }
 
+long memfd_ioctl(struct file *file, unsigned int cmd, unsigned int arg)
+{
+	if (cmd == MEMFD_CHECK_IF_ORIGINAL)
+		return (file->f_mode & FMODE_WRITE) &&
+		       !(file->f_mode & FMODE_WRITER);
+
+	return -EINVAL;
+}
+
 #define MFD_NAME_PREFIX "memfd:"
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
diff --git a/mm/shmem.c b/mm/shmem.c
index 02e62fccc80d..347fcba15fb7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -79,6 +79,7 @@ static struct vfsmount *shm_mnt;
 #include <linux/rmap.h>
 #include <linux/uuid.h>
 #include <linux/quotaops.h>
+#include <linux/memfd.h>
 
 #include <linux/uaccess.h>
 
@@ -4459,6 +4460,12 @@ const struct address_space_operations shmem_aops = {
 };
 EXPORT_SYMBOL(shmem_aops);
 
+static long shmem_file_ioctl(struct file *file, unsigned int cmd,
+			     unsigned long arg)
+{
+	return memfd_ioctl(file, cmd, arg);
+}
+
 static const struct file_operations shmem_file_operations = {
 	.mmap		= shmem_mmap,
 	.open		= shmem_file_open,
@@ -4471,6 +4478,8 @@ static const struct file_operations shmem_file_operations = {
 	.splice_read	= shmem_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
+	.unlocked_ioctl = shmem_file_ioctl,
+	.compat_ioctl   = shmem_file_ioctl,
 #endif
 };
 
-- 
2.42.0.283.g2d96d420d3-goog

