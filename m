Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42D1F38FD
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2019 20:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfKGTyD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 14:54:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32768 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKGTyD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 14:54:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id c184so3259842pfb.0
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2019 11:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ghp1ccQ5fcbrX+RPWdRWrW5V+/l6RykYTQKYb1Z+Wp4=;
        b=MF2KEhwsFOY2JznvdfjXOUNj6W3qYNeau+VKgjLdGcoHKMwypDOQ9+KNmwpoguPBnA
         7i/obFhGjyKDKsUMxeH64dpCWx1uMOpGLtazJ2WOFQJj2EgXR2EKcxlrJHXs+HFIxiKU
         AjzqDaEAAzRnfgvLsssB5KV+gpsE0RcbDcp+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ghp1ccQ5fcbrX+RPWdRWrW5V+/l6RykYTQKYb1Z+Wp4=;
        b=h7PLnicgwdhgQnNMg1r8Cb4jQ+FbZp897xlWUHJqosfKfbHbr2oqguBtH6f5PbrOhB
         kZ9R/6Mou7K95Bcw5pi6J79w/5wxFVhdGxO1ErfERSSTk/iQaf/Wf8xjJUKwVI9CmzzB
         MHMTfUuB3xMF7pl5Itgvu6pw6wFr6LKtaqgATO3XFfGVPLDcdMrqQqF8DYmhd0sdpEKC
         iYF8byFMib8bwi87vAOIkrwz569ilmRiBWAiy8vdfHH/F261Bxx2z5MTi6LfCV5Hfylh
         Hwym84aDRooiqYLpF3xTI5LErfbhnmq7U4i12BDBWzfL3Uz+SLp8GEDyO+xaJwy2vG74
         ocuw==
X-Gm-Message-State: APjAAAWHHBF3fnxbJ4eoCH5owIG0CNbmbA/H1kL2xpWj+Jxi6tqjunB9
        xPdCOASf7ItUuzeB+mi7fSWIKw==
X-Google-Smtp-Source: APXvYqxa4V3GDy6MxEr8e4GyHJt30Yq7/f7FjZfuQPYkIlqBQ0ZxitLHpBCbWZAaGGArGLkuPC825w==
X-Received: by 2002:a63:f852:: with SMTP id v18mr4706535pgj.71.1573156442796;
        Thu, 07 Nov 2019 11:54:02 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y2sm3365870pfe.126.2019.11.07.11.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 11:54:02 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Nicolas Geoffray <ngeoffray@google.com>, kernel-team@android.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH 1/2] memfd: Fix COW issue on MAP_PRIVATE and F_SEAL_FUTURE_WRITE mappings
Date:   Thu,  7 Nov 2019 14:53:54 -0500
Message-Id: <20191107195355.80608-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolas Geoffray <ngeoffray@google.com>

F_SEAL_FUTURE_WRITE has unexpected behavior when used with MAP_PRIVATE:
A private mapping created after the memfd file that gets sealed with
F_SEAL_FUTURE_WRITE loses the copy-on-write at fork behavior, meaning
children and parent share the same memory, even though the mapping is
private.

The reason for this is due to the code below:

static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
{
        struct shmem_inode_info *info = SHMEM_I(file_inode(file));

        if (info->seals & F_SEAL_FUTURE_WRITE) {
                /*
                 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
                 * "future write" seal active.
                 */
                if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
                        return -EPERM;

                /*
                 * Since the F_SEAL_FUTURE_WRITE seals allow for a MAP_SHARED
                 * read-only mapping, take care to not allow mprotect to revert
                 * protections.
                 */
                vma->vm_flags &= ~(VM_MAYWRITE);
        }
        ...
}

And for the mm to know if a mapping is copy-on-write:
static inline bool is_cow_mapping(vm_flags_t flags)
{
        return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
}

The patch fixes the issue by making the mprotect revert protection
happen only for shared mappings. For private mappings, using mprotect
will have no effect on the seal behavior.

Cc: kernel-team@android.com
Signed-off-by: Nicolas Geoffray <ngeoffray@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
Google bug: 143833776

 mm/shmem.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 447fd575587c..6ac5e867ef13 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2214,11 +2214,14 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 			return -EPERM;
 
 		/*
-		 * Since the F_SEAL_FUTURE_WRITE seals allow for a MAP_SHARED
-		 * read-only mapping, take care to not allow mprotect to revert
-		 * protections.
+		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
+		 * MAP_SHARED and read-only, take care to not allow mprotect to
+		 * revert protections on such mappings. Do this only for shared
+		 * mappings. For private mappings, don't need to mask VM_MAYWRITE
+		 * as we still want them to be COW-writable.
 		 */
-		vma->vm_flags &= ~(VM_MAYWRITE);
+		if (vma->vm_flags & VM_SHARED)
+			vma->vm_flags &= ~(VM_MAYWRITE);
 	}
 
 	file_accessed(file);
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog
