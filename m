Return-Path: <linux-kselftest+bounces-45366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728BC4FA79
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 20:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150BE3B146A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B283C3A5E8F;
	Tue, 11 Nov 2025 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKSJ+k8f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39AA217F55
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 19:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762891086; cv=none; b=ZItMqxqvn2IJIiTkXjeMH3rXwnYNkJ5dCf2WT1yXMYy4LjyodiCVhojYNu3VLnTQ/O3Oz5sO1Kug1pAhjttoaW9ezYsc+WThYGijUaHRGyvckNzJ8jJ7Lje+9wcrchVjBd7RqRGddbEGidExnSaA8IFsfHl64yJdWrzsn+wJ64k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762891086; c=relaxed/simple;
	bh=62sKlTrI0pxAC8MsCjHaTOLDapsx/YJT2jYwGk/YKdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ofiN8OAUb63uBO3eTvSL1HfL9e8MClEvJBOf0oAppQZryMa8c/CN4dca/HUnIIsUMK7g7+lQ6M+J0pgT6aM2jBg5cfgIdL/qgxTjUbNVqBIrTNAoch3fp/qNZkXK8yqONyxEfyDlq83ieiVLvHDGj0CZakWORAtOLs6b72AK5mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKSJ+k8f; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47116aaf345so16815e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 11:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762891083; x=1763495883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgqlcdicdOlvJS4d4lOKT+0mM+91PtUwo1QhcetW41s=;
        b=hKSJ+k8fZGT096+ddl8ISH5rFKI3ErCDbIvcpLCKdO7UPypquJE4vL0daq2cRzzvju
         BLJaTwVRjWzKOA7yfw6aVilpBJfcUTwLL+M8cpvdpAFO9tl2mxn2VwLrDglGyO68OVNS
         4S43WF9B95pGQxA/JVquRvH7QWKGAPwtmhVI9IS207Veeh776ptyiZHDIBWQgkamTccN
         A8nTVex14gCRwgSXmmBZnfDwVGMbxnwVBCOXx+5JQjYK0fHXarx+ypghdZd4fl93OmMj
         9WBoC9+eaykoMZPkPvnOfHeGkYL3ZyzZonhkScHk9UZNpbdq9jpetjiWLbVVxKEi8v4s
         YfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762891083; x=1763495883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgqlcdicdOlvJS4d4lOKT+0mM+91PtUwo1QhcetW41s=;
        b=f+TzaBnpDNdUF0zJJNz+1zSKJqjSsn6zgbPkYe0d8IVbVRkClQ7CDyhsQmndDOldTd
         xivQhJTZVrKd/JYp9VeXlHS4h/H6H+KzyFpLV/XrJGM8JoIo7RbB+SbYOc3K4EJ1uJWy
         O2iIIffcy5AkehCgmigEhKyHkF0ixVKTTOEkuumqKflsn6BD333YkxNCqlyLg6k5DmB+
         /mHn1PS/wWxWq5DMeH/PJCSCNgOkeEzJB/CBCW+NhRUTpdqNB2KID4rLuVI8BrC6ht1E
         DA02br89k+x2lY4JAQrG8GTb67BoxL3YZCx8A+p7BCPhuYzfP32iNWmSNs5o3g6kd2KA
         +XcA==
X-Forwarded-Encrypted: i=1; AJvYcCVnV5WS9cLxYv41MqnSmrjMvFsTJoT2xDFBd8o+Qne2P1E6G9/hy6UnMOQFnhL0yQtgJviL++TDPZGrq9gWXp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJFDZDzDjjzsTbWIKFhiv/EQ1HsF0RPgLyrdObxoUgxNLTz50
	FgcTWSkTFhHMs6JnJv0OVnjUUZUweyjCBr5mvjKzXKqxE70WIx8cuZXE
X-Gm-Gg: ASbGnctd8BZAit6ozGSvKIfEtw5mnuwncyVMkqDRdYATK/Ojls9GxIBInJCETCvi+Ys
	tD/ud2Ix6He1qjOoGmVN1QIjaIQxTwavmlZU83ZdrREUiYezWQ1oLNf7k+5H2pXMAD5Dm7sSk8K
	n1bu3zDIMSO8aVLH9yUZ+infMHRzZPSY8mQW2bGSbpFLod5zzlHO6rKI/Awn0hfmD9lsT3byGOH
	3FLfkfPrBvXQ1v7BSXUahkHdKE/V79mPa0wKbQ95fPQRRwjdvNTR3FWDDKftsEFtJHzUmEANv5H
	klcXsjH2+3WICWppT5SVjoEUdGttzzQoMi7r5Y5aHZKsGCCVn6txiO6dlHCDGDsM9S5vMy7wf2w
	AiwrnbDGEOm3Jy6TuGZmFqYw+9dyaQIIXrU0ggzreMkSt3UbHoa1htG414s+80+BXhdJZYNL8ht
	7jt8C1kK472k6IjbD/1N66rY3/UsA=
X-Google-Smtp-Source: AGHT+IE21rOv3E/xf61ATIbFY5zukw0tfOg7SCkZGn4ZrAkN7p8psKMVSUEEhKXeXEJZn8Yww8oxyA==
X-Received: by 2002:a05:600c:4f54:b0:477:5b01:7d49 with SMTP id 5b1f17b1804b1-477870c9a70mr2783175e9.4.1762891083060;
        Tue, 11 Nov 2025 11:58:03 -0800 (PST)
Received: from bhk ([196.239.144.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce211d8sm405969865e9.11.2025.11.11.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:58:02 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: akpm@linux-foundation.org,
	peterx@redhat.com,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH] selftests/mm/uffd: remove static address usage in shmem_allocate_area()
Date: Tue, 11 Nov 2025 21:54:27 +0100
Message-ID: <20251111205739.420009-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current shmem_allocate_area() implementation uses a hardcoded virtual
base address(BASE_PMD_ADDR) as a hint for mmap() when creating shmem-backed
test areas. This approach is fragile and may fail on systems with ASLR or
different virtual memory layouts, where the chosen address is unavailable.

Replace the static base address with a dynamically reserved address range
obtained via mmap(NULL, ..., PROT_NONE). The memfd-backed areas and their
alias are then mapped into that reserved region using MAP_FIXED, preserving
the original layout and aliasing semantics while avoiding collisions with
unrelated mappings.

This change improves robustness and portability of the test suite without
altering its behavior or coverage.

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
Testing:
A diff between running the mm selftests on 6.18-rc5 from before and after
the change show no regression on x86_64 architecture with 32GB DDR5 RAM.
 tools/testing/selftests/mm/uffd-common.c | 25 +++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 994fe8c03923..492b21c960bb 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -6,11 +6,11 @@
  */
 
 #include "uffd-common.h"
+#include "asm-generic/mman-common.h"
 
 uffd_test_ops_t *uffd_test_ops;
 uffd_test_case_ops_t *uffd_test_case_ops;
 
-#define BASE_PMD_ADDR ((void *)(1UL << 30))
 
 /* pthread_mutex_t starts at page offset 0 */
 pthread_mutex_t *area_mutex(char *area, unsigned long nr, uffd_global_test_opts_t *gopts)
@@ -142,30 +142,37 @@ static int shmem_allocate_area(uffd_global_test_opts_t *gopts, void **alloc_area
 	unsigned long offset = is_src ? 0 : bytes;
 	char *p = NULL, *p_alias = NULL;
 	int mem_fd = uffd_mem_fd_create(bytes * 2, false);
+	size_t region_size = bytes * 2 + hpage_size;
 
-	/* TODO: clean this up.  Use a static addr is ugly */
-	p = BASE_PMD_ADDR;
-	if (!is_src)
-		/* src map + alias + interleaved hpages */
-		p += 2 * (bytes + hpage_size);
+	void *reserve = mmap(NULL, region_size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS,
+			-1, 0);
+	if (reserve == MAP_FAILED) {
+		close(mem_fd);
+		return -errno;
+	}
+
+	p = (char *)reserve;
 	p_alias = p;
 	p_alias += bytes;
 	p_alias += hpage_size;  /* Prevent src/dst VMA merge */
 
-	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
+	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
 			   mem_fd, offset);
 	if (*alloc_area == MAP_FAILED) {
+		munmap(reserve, region_size);
 		*alloc_area = NULL;
+		close(mem_fd);
 		return -errno;
 	}
 	if (*alloc_area != p)
 		err("mmap of memfd failed at %p", p);
 
-	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
+	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
 			  mem_fd, offset);
 	if (area_alias == MAP_FAILED) {
-		munmap(*alloc_area, bytes);
+		munmap(reserve, region_size);
 		*alloc_area = NULL;
+		close(mem_fd);
 		return -errno;
 	}
 	if (area_alias != p_alias)
-- 
2.51.2


