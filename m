Return-Path: <linux-kselftest+bounces-9855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84028C167F
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 22:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE3C1C20A0C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 20:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8636D13C3CE;
	Thu,  9 May 2024 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AxwfSOIx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2421139577
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284942; cv=none; b=T0hJUQJojXBuzDgIAks5Da3iScOL6fWe+Jc534JcUUsiz8z9HzmC034txTZ6FPslPCM6bsexBoZMAxv7PF88wlP4Mj9/V1f5GXev10pLfxBgKLPzlKVoy83iYYTqGQ1pWriHe8aZM0js24GgQu8hdTLdQ0bgjXEaww0ieh+pHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284942; c=relaxed/simple;
	bh=CvcWkJAQj9Bm62LgZlJ41X+wznoeEHyavNlXM2IT2VU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YRkCFJYKHwXAT5XMHnwIliaIngbtUjJIvxd0Nq+/KdG4tx/BkNnJ2glvb1PM8Jj5DiDaV3oim7d0dueUoIQQCD6/liJNAxVRdPk1QRGx0SMwXY/KPdUno87mN3odr7sBkHKHqq+dry3FqkggW2sSBLqR5S+0iMZTzSY0iU/OKp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AxwfSOIx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be25000a4so21370037b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284940; x=1715889740; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d9gHi1CbuLmtBbPnbX9/epVkdMwUWIuJUi+ysiedamw=;
        b=AxwfSOIxB7X4lCX7KlTTKj9P+KlvuHl4UFqAhx0nRYC+szBlTgXC+wk14QT01Q2WcW
         BIreFKEMDJrsc4F3hISzNbmHzocwQp+pgTRmAgDj3gNNt2xfeRXZJPZnNWjLaw20Ip1h
         CbhT6eZ2dIPJ+IFiQfo64wD+2YI+FGCG3HgE0QbbfO7V1YRbW5gFmpXmEokFpOJpC2bo
         fxGYCX+Bcho33mVShaXRAE6wymuktjoId3onE1k1jwEEoPdgCcx8RU070VXGN3c0ONWe
         dQzzwqUOHgls2x2X/RmhyfN7J3udQbmpUwEQLbTW9EGsHACQo4fwRA415xz0jObShuXZ
         4qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284940; x=1715889740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9gHi1CbuLmtBbPnbX9/epVkdMwUWIuJUi+ysiedamw=;
        b=jG7v5mxYQCS3FVJmCOZxZdgdCTR7EAGwsQBcq536NtTfZPFdUfQrfArp/pasvJW1g6
         MtdN/N3CVAcwlSMpSHQFvTKB25Bj/HNPe4YKSDMu7mgsUN68EfapJZhmhL3XvtPH1cqD
         wt0aGt1DBlGTqrZYBvDgm2/xQh8jbfOPh+ZlqfKJMMV/GlSiM6mESIRHdi8RSFkdbAHe
         B/b5oZXPCd3gD3OTJWoKvmIXmwwM4NOXtxK3EsPfaLfE8Hp22T+Za5FforNz66ndxtV+
         FsvU/IGWZVeEZaHKs6dAzepQ6yq75wKN/T9AaE5eSy/gy05y+oz+DKvfaGKWpoaS62Cs
         N7vw==
X-Forwarded-Encrypted: i=1; AJvYcCXUVcfAG+lKJ/WlaeUaX4vw4effr4X/FNwGmpU46owlbBbiwSTcsPOlsRR8KpyH608Xmn6V/1/w/rMuf/Z9Yf9SQB5yCh4RIle8VV4eZ0xl
X-Gm-Message-State: AOJu0YyLr1l9LmhAGzP6M6otRUNEi+K3xpIfSvsXjweTO2xB8dj8biYo
	/UxQjVeubwbI9gHANy07QY37JaNRhVKKSmQQA+wyJmjFhUPPgx+DU0Z7ZNytX2dgdnTcjvOyDzF
	xWw==
X-Google-Smtp-Source: AGHT+IH1HCGu1gIE3DSLG2ih1KsG2DZ9PZD+3gGDYLQl8TsAe58wSaCRg5bXsgFKtYHhpV1brH7f43Zpxyg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:6f8c:b0:61b:ea12:d0b with SMTP id
 00721157ae682-622aff85f0cmr1708317b3.2.1715284939723; Thu, 09 May 2024
 13:02:19 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:24 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-33-edliaw@google.com>
Subject: [PATCH v3 32/68] selftests/mm: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
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


