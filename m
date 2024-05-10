Return-Path: <linux-kselftest+bounces-9941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 413828C1ADD
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 02:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD591F24DD7
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 00:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D45713340B;
	Fri, 10 May 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdzEZ8XN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAE01332A6
	for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2024 00:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299832; cv=none; b=sOfQlF4xp5RZe6xetGVFAT5EmADnFEaEQQuP2PvQHCW7tQFqvAd/j6iRItT7zB0eMmFmlAImQ/hwql4ZIy+GitJwUbhrXX8CyaS0nyv71BGSt6zzoHHC9iPNdS6bDtYGr2+DnQN1TAw6rLGxSJ1CXCgqe9xzaZ1sqjvIJ0mGISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299832; c=relaxed/simple;
	bh=RsjgWBtfx+Wdynl3OehbM6pnDJQOFsg4D7D5YqcOv9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oD3wTm8VP1pPkAq0yxUK9U6Z3ICSd0LSrwGgCMWrWQzqjVLZIKpP70IJfwmwPHxhIrvlF9YXf53MDDshdeQQvSJ95vSCiiXCtm/WQQX63Mv7CqzY5X66KeRfzIjHykbvcAYGRTi9WBEdpPbU1Jm8cQkjw1uNL8A1yf6q8xcLN3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdzEZ8XN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f44b2e0bf2so1554192b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 17:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299830; x=1715904630; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mr4NdGT2PNvZU+5L6nsbhn20MQoXzIm4/FSacRpNfog=;
        b=fdzEZ8XNRrwOiGvrhzIQjyS4REJwax2XHsO1dA/bvOXZSFwZZvpiXwbnUDc2v+lgN7
         zZAI0d1/Ki1ARK8Gi270pxdJS9841rx5EjOBFxqMv6+eYOQ7S3JZp4gJ4IKfMhCpkyqq
         kTqTbf1DWvDN+njwcvQ+G2n5aXR+3kKDUXQd56vOP4Jb6hLBmXt5IKMhfInp2UMSFqZd
         CWh+YwJwH+9VicT1Lnvf/Jbu10qqUQGt+LAwk94ALZaTvE6v7WAo7b9xgpS3D8HdWo3s
         0/A+RkvrZQMuX3Oo9MmazfFWod4cH71Lcv/h/5TP2cOyxbVt5BI1p/v0x9lo8TImzh2u
         BsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299830; x=1715904630;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mr4NdGT2PNvZU+5L6nsbhn20MQoXzIm4/FSacRpNfog=;
        b=jO8DteUrtTriRJ2MUTpVNhKjhRIlEfzob4vN6vp4t1YN6iLTIPc/a3MhIMB0sZZo9A
         wfqV2zlMsMt8QmuNSeo07JC0J/QOLOQpZTS3XHd/FJ2gi7ejX3Cb8g36HCKKsDdNJziU
         VICse7kw2wfxfD6PchqTZYZNQthCvlEYK2ljA+6N+0DJv8I7nQDIVbXUU4T2IoAX4g/B
         KaQhhl3Dx4E0Z8Wnbq3zmG0idtU7ao6rTpxjvYUwFizKurxujm/m06Yo7wVzQbzZBslt
         wnjEOTBa4yQ0OwBlVe+rlhXc488zNki1tZDLLnO/Vgjq/tVj859FTmodYOd5JSjXY95p
         /yFw==
X-Forwarded-Encrypted: i=1; AJvYcCXno0DY1Fa8bHapmoKi30NiZb/nRFL84yVdc5T8vKgPUVKZzFtaZ4MPdMV0iEsUapzoor38m3J3Glo61ElJTejHKEPQc5PKayIq7xQWDvqv
X-Gm-Message-State: AOJu0Yx311W9hibRM5fU+kXHtXN26NPVUtFJIZ4GMyZ2YDbJJ5T95PGS
	g9vMyH4U9ZAiJOOBhCYEf2qMu2q7mzyluigriTpega+ZcFs/pFOsaej58Ag3y84Cxtq7frxh76p
	DSQ==
X-Google-Smtp-Source: AGHT+IGkqcBYg1ifiUd3TZtoa2X7YmEYrYy5gqzOTI3Rl8hbGb6PZhI2rE5TebYUa8SG5dpiJTZlea5cdbc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:c93:b0:6ea:e2d9:f2af with SMTP id
 d2e1a72fcca58-6f4e015f786mr15106b3a.0.1715299830166; Thu, 09 May 2024
 17:10:30 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:47 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-31-edliaw@google.com>
Subject: [PATCH v4 30/66] selftests/mm: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/cow.c                   | 1 -
 tools/testing/selftests/mm/gup_longterm.c          | 1 -
 tools/testing/selftests/mm/hugepage-mmap.c         | 1 -
 tools/testing/selftests/mm/hugepage-mremap.c       | 2 --
 tools/testing/selftests/mm/hugetlb-madvise.c       | 2 --
 tools/testing/selftests/mm/hugetlb-read-hwpoison.c | 2 --
 tools/testing/selftests/mm/khugepaged.c            | 1 -
 tools/testing/selftests/mm/ksm_functional_tests.c  | 1 -
 tools/testing/selftests/mm/madv_populate.c         | 1 -
 tools/testing/selftests/mm/map_populate.c          | 2 --
 tools/testing/selftests/mm/mdwe_test.c             | 1 -
 tools/testing/selftests/mm/memfd_secret.c          | 2 --
 tools/testing/selftests/mm/mlock2-tests.c          | 1 -
 tools/testing/selftests/mm/mrelease_test.c         | 1 -
 tools/testing/selftests/mm/mremap_dontunmap.c      | 1 -
 tools/testing/selftests/mm/mremap_test.c           | 2 --
 tools/testing/selftests/mm/mseal_test.c            | 1 -
 tools/testing/selftests/mm/pagemap_ioctl.c         | 1 -
 tools/testing/selftests/mm/pkey-helpers.h          | 1 -
 tools/testing/selftests/mm/protection_keys.c       | 1 -
 tools/testing/selftests/mm/seal_elf.c              | 1 -
 tools/testing/selftests/mm/split_huge_page_test.c  | 2 --
 tools/testing/selftests/mm/thuge-gen.c             | 2 --
 tools/testing/selftests/mm/uffd-common.h           | 1 -
 24 files changed, 32 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 32c6ccc2a6be..8747ffef200f 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -6,7 +6,6 @@
  *
  * Author(s): David Hildenbrand <david@redhat.com>
  */
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <string.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 9423ad439a61..53c257f6159c 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -6,7 +6,6 @@
  *
  * Author(s): David Hildenbrand <david@redhat.com>
  */
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <string.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/mm/hugepage-mmap.c b/tools/testing/selftests/mm/hugepage-mmap.c
index 267eea2e0e0b..edb46888222f 100644
--- a/tools/testing/selftests/mm/hugepage-mmap.c
+++ b/tools/testing/selftests/mm/hugepage-mmap.c
@@ -16,7 +16,6 @@
  * range.
  * Other architectures, such as ppc64, i386 or x86_64 are not so constrained.
  */
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index c463d1c09c9b..8e22822bb754 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -11,8 +11,6 @@
  * To make sure the test triggers pmd sharing and goes through the 'unshare'
  * path in the mremap code use 1GB (1024) or more.
  */
-
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
index e74107185324..70c40c67bc5d 100644
--- a/tools/testing/selftests/mm/hugetlb-madvise.c
+++ b/tools/testing/selftests/mm/hugetlb-madvise.c
@@ -11,8 +11,6 @@
  * filesystem.  Therefore, a hugetlbfs filesystem must be mounted on some
  * directory.
  */
-
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
diff --git a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
index ba6cc6f9cabc..6b8b41b4f754 100644
--- a/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
+++ b/tools/testing/selftests/mm/hugetlb-read-hwpoison.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 829320a519e7..d18bf400dae6 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -1,4 +1,3 @@
-#define _GNU_SOURCE
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 37de82da9be7..b0af40ddb0fb 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -6,7 +6,6 @@
  *
  * Author(s): David Hildenbrand <david@redhat.com>
  */
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <string.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index ef7d911da13e..f2c8223ff3d4 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -6,7 +6,6 @@
  *
  * Author(s): David Hildenbrand <david@redhat.com>
  */
-#define _GNU_SOURCE
 #include <stdlib.h>
 #include <string.h>
 #include <stdbool.h>
diff --git a/tools/testing/selftests/mm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
index 5c8a53869b1b..ff4d4079bd0e 100644
--- a/tools/testing/selftests/mm/map_populate.c
+++ b/tools/testing/selftests/mm/map_populate.c
@@ -4,8 +4,6 @@
  *
  * MAP_POPULATE | MAP_PRIVATE should COW VMA pages.
  */
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/mman.h>
diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index 1e01d3ddc11c..200bedcdc32e 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -7,7 +7,6 @@
 #include <linux/mman.h>
 #include <linux/prctl.h>
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/auxv.h>
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 9a0597310a76..0ba721d45d35 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -4,8 +4,6 @@
  *
  * Author: Mike Rapoport <rppt@linux.ibm.com>
  */
-
-#define _GNU_SOURCE
 #include <sys/uio.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
index 7f0d50fa361d..99dc39bf2fec 100644
--- a/tools/testing/selftests/mm/mlock2-tests.c
+++ b/tools/testing/selftests/mm/mlock2-tests.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sys/mman.h>
 #include <stdint.h>
 #include <unistd.h>
diff --git a/tools/testing/selftests/mm/mrelease_test.c b/tools/testing/selftests/mm/mrelease_test.c
index 100370a7111d..d78bf686e99f 100644
--- a/tools/testing/selftests/mm/mrelease_test.c
+++ b/tools/testing/selftests/mm/mrelease_test.c
@@ -2,7 +2,6 @@
 /*
  * Copyright 2022 Google LLC
  */
-#define _GNU_SOURCE
 #include <errno.h>
 #include <stdbool.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/mm/mremap_dontunmap.c b/tools/testing/selftests/mm/mremap_dontunmap.c
index 1d75084b9ca5..934fa6b441b2 100644
--- a/tools/testing/selftests/mm/mremap_dontunmap.c
+++ b/tools/testing/selftests/mm/mremap_dontunmap.c
@@ -5,7 +5,6 @@
  *
  * Copyright 2020, Brian Geffon <bgeffon@google.com>
  */
-#define _GNU_SOURCE
 #include <sys/mman.h>
 #include <linux/mman.h>
 #include <errno.h>
diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 1b03bcfaefdf..0d8dc16b63be 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -2,8 +2,6 @@
 /*
  * Copyright 2020 Google LLC
  */
-#define _GNU_SOURCE
-
 #include <errno.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 41998cf1dcf5..d35ee37311a7 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/mman.h>
 #include <sys/mman.h>
 #include <stdint.h>
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 2d785aca72a5..50d6bfc8db05 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <fcntl.h>
 #include <string.h>
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 1af3156a9db8..37d6b01ce90a 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _PKEYS_HELPER_H
 #define _PKEYS_HELPER_H
-#define _GNU_SOURCE
 #include <string.h>
 #include <stdarg.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 48dc151f8fca..9f7de92caeda 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -21,7 +21,6 @@
  *	gcc -mxsave      -o protection_keys    -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
  *	gcc -mxsave -m32 -o protection_keys_32 -O2 -g -std=gnu99 -pthread -Wall protection_keys.c -lrt -ldl -lm
  */
-#define _GNU_SOURCE
 #define __SANE_USERSPACE_TYPES__
 #include <errno.h>
 #include <linux/elf.h>
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
index f2babec79bb6..0438695bc45a 100644
--- a/tools/testing/selftests/mm/seal_elf.c
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sys/mman.h>
 #include <stdint.h>
 #include <unistd.h>
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index d3c7f5fb3e7b..ae6ac950d7a1 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -3,8 +3,6 @@
  * A test of splitting PMD THPs and PTE-mapped THPs from a specified virtual
  * address range in a process via <debugfs>/split_huge_pages interface.
  */
-
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index ea7fd8fe2876..28a5c31bd791 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -12,8 +12,6 @@
    ipcrm -m by hand, like this
    sudo ipcs | awk '$1 == "0x00000000" {print $2}' | xargs -n1 sudo ipcrm -m
    (warning this will remove all if someone else uses them) */
-
-#define _GNU_SOURCE 1
 #include <sys/mman.h>
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index cc5629c3d2aa..abb44319264a 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -7,7 +7,6 @@
 #ifndef __UFFD_COMMON_H__
 #define __UFFD_COMMON_H__
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


