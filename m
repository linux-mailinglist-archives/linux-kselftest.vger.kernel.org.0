Return-Path: <linux-kselftest+bounces-33965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7A9AC71BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 21:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3383C1C016DA
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 19:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2BF21D594;
	Wed, 28 May 2025 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HT47kzr7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E2D21FF3B
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748461971; cv=none; b=m+3PMUOAXvE20Uu6T75Vvp/4ipEWAL1s6kuDha+JNuak262sSGTBaGIyoP2FPbGrqR0lYtzho6XARlsNvuhLe9mZKB292SR4XmKkXD2hpboqwKqQFxMBYVr7D8Zx6zbr66nHrpGH2qDwLEqDPx9mv22lW56q602cnL4ujxY8Q98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748461971; c=relaxed/simple;
	bh=31R4xKWKmitjG5RnBTZ6fLS+lQ/xEclC30oq87oWNSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=odDsPP26hyF1AqhcE9sl18gkHVN0pMWbS94x9mOWQZc65BZAM7fuFlESQjm4RB0xSp9XEYjFGogacm1dG4J2PwuLyIcMCdSzQwtN7GVgJWwR3YER5LuFG3Qu1Epr6MNG1IQ/7Uep5ZQvsAmtnIFh5KXY/VhbWYrXFP+kOdb3a2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HT47kzr7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748461968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g+3zZ1K31xkV4VckIAeGyggNzsEYBYLzL0Y5N0v1H1Q=;
	b=HT47kzr7n3YDtVnrEexGftdH/0VJL4TE2MdRpIE8uazINytsp9cS7xAlSDSUop7HXdzar9
	iLywH7Qx2E38VIm8VQ6kFaj6+sUUkEWMha2EoSSlZnEqCMRhc4Leky+Ssz41XOp0Omw541
	gCC7lR82oCqU0tdUHPmu6GtHkQVlADY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-_ycaMKMxNfmjCMvb5gH69g-1; Wed, 28 May 2025 15:52:47 -0400
X-MC-Unique: _ycaMKMxNfmjCMvb5gH69g-1
X-Mimecast-MFC-AGG-ID: _ycaMKMxNfmjCMvb5gH69g_1748461966
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so1213015e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 12:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748461966; x=1749066766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+3zZ1K31xkV4VckIAeGyggNzsEYBYLzL0Y5N0v1H1Q=;
        b=quEomM3T1S0kzyakkPyh87T6jvgkIza5zMHTD9O3tBI1AIaUCm7/1TnreMI13dPJD1
         +/F3Osv+SnDFdT6ATBOBPeas4oYXhKvGpeFyO0AJVxCubSUBxtiW0vz2ZScqrxAnTMAD
         mkCO4cWSx4T6nnnjeEMfvoLL6411sh+n5o9OHBiki98hhma+eQlFk7nlSCWd14G/0pB9
         Tv4W1FAl6Tz4epZ/ragkKZKqKPQ7F5o9kuwatsH/GT2Xce/Mt73Rm+tRH+MicEA/zxr0
         nhT0wgQyeZdBE35PuFojvnhK+39SQL/BekBoPGH/HOyPu3zuccTL8m3iIrwnGJjaCoC8
         uBEg==
X-Forwarded-Encrypted: i=1; AJvYcCXS+c5m6/4nL5ixuMtzT1M6XW/k9Zl2oqPMUaSzkwQFS24Jegre/nrtWRQHz1fKHOS/+hWshErqKPOcxKSjAi0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3th5KCuIHt5puHmmlLqv+Tqg89sZgp0cwvz4QE6awJx+byk24
	YkGPw8COWOjvu7LTebSTmSZ6cK+8X/XasTul2bmRuwsbsr/bXlYynVwRqeC0iypNKE+IiT7VQez
	rJiOPL6WzDJ38Yti1gn+N+27tQ8Alr6pyMqM+Ve8JF/wXKhsccbiDQQLptQdlxp1fM22JgA==
X-Gm-Gg: ASbGncvw1dNPxM2geZ1mxlonEWZGw2qg7TYjB7hYj1qD1BavkaQIYfumyKrAgEK66VG
	ZoHDMwxXcAxadMZgeTmUsbi0PJvRujgnkB6tzb91bpKQcWcam2s2oK4TRAodqaOH4WismxzHCwo
	byxE891wjktM6lqeNfXcjMtQczSxnyOkFmT+Dj79NaPjC+bTRJ6oqoTW3UI2Y5RGsf+O6ZR6TAm
	99uilOI7fWfT5xC426GQ1x5CAGKu/IIhDrutuYB9QOfmxMGqP1WieMsrSMM+YAhcVmqBr5esMCn
	b5lrv3qpjAhrRxUeB4vqfJxw+f9Gr6LELGgTvw==
X-Received: by 2002:a05:600c:64c6:b0:442:ffa6:d07e with SMTP id 5b1f17b1804b1-44c9141d996mr142856515e9.1.1748461966140;
        Wed, 28 May 2025 12:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgw89HXpBys9AtsSs/u0lppq8iYMgrEKAe3lvjHHrT75X3gsbzLMb8QzLWDC7F41Sro+0ENQ==
X-Received: by 2002:a05:600c:64c6:b0:442:ffa6:d07e with SMTP id 5b1f17b1804b1-44c9141d996mr142856365e9.1.1748461965729;
        Wed, 28 May 2025 12:52:45 -0700 (PDT)
Received: from localhost (p57a1aa11.dip0.t-ipconnect.de. [87.161.170.17])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4eac89d98sm2283367f8f.42.2025.05.28.12.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 12:52:45 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v1] selftests/mm: two fixes for the pfnmap test
Date: Wed, 28 May 2025 21:52:44 +0200
Message-ID: <20250528195244.1182810-1-david@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When unregistering the signal handler, we have to pass SIG_DFL, and
blindly reading from PFN 0 and PFN 1 seems to be problematic on !x86
systems. In particularly, on arm64 tx2 machines where noting resides
at these physical memory locations, we can generate RAS errors.

Let's fix it by scanning /proc/iomem for actual "System RAM".

Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/all/232960c2-81db-47ca-a337-38c4bce5f997@arm.com/T/#u
Fixes: 2616b370323a ("selftests/mm: add simple VM_PFNMAP tests based on mmap'ing /dev/mem")
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Tested-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/pfnmap.c | 61 +++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/pfnmap.c b/tools/testing/selftests/mm/pfnmap.c
index 8a9d19b6020c7..866ac023baf5c 100644
--- a/tools/testing/selftests/mm/pfnmap.c
+++ b/tools/testing/selftests/mm/pfnmap.c
@@ -12,6 +12,8 @@
 #include <stdint.h>
 #include <unistd.h>
 #include <errno.h>
+#include <stdio.h>
+#include <ctype.h>
 #include <fcntl.h>
 #include <signal.h>
 #include <setjmp.h>
@@ -43,14 +45,62 @@ static int test_read_access(char *addr, size_t size, size_t pagesize)
 			/* Force a read that the compiler cannot optimize out. */
 			*((volatile char *)(addr + offs));
 	}
-	if (signal(SIGSEGV, signal_handler) == SIG_ERR)
+	if (signal(SIGSEGV, SIG_DFL) == SIG_ERR)
 		return -EINVAL;
 
 	return ret;
 }
 
+static int find_ram_target(off_t *phys_addr,
+		unsigned long long pagesize)
+{
+	unsigned long long start, end;
+	char line[80], *end_ptr;
+	FILE *file;
+
+	/* Search /proc/iomem for the first suitable "System RAM" range. */
+	file = fopen("/proc/iomem", "r");
+	if (!file)
+		return -errno;
+
+	while (fgets(line, sizeof(line), file)) {
+		/* Ignore any child nodes. */
+		if (!isalnum(line[0]))
+			continue;
+
+		if (!strstr(line, "System RAM\n"))
+			continue;
+
+		start = strtoull(line, &end_ptr, 16);
+		/* Skip over the "-" */
+		end_ptr++;
+		/* Make end "exclusive". */
+		end = strtoull(end_ptr, NULL, 16) + 1;
+
+		/* Actual addresses are not exported */
+		if (!start && !end)
+			break;
+
+		/* We need full pages. */
+		start = (start + pagesize - 1) & ~(pagesize - 1);
+		end &= ~(pagesize - 1);
+
+		if (start != (off_t)start)
+			break;
+
+		/* We need two pages. */
+		if (end > start + 2 * pagesize) {
+			fclose(file);
+			*phys_addr = start;
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+
 FIXTURE(pfnmap)
 {
+	off_t phys_addr;
 	size_t pagesize;
 	int dev_mem_fd;
 	char *addr1;
@@ -63,14 +113,17 @@ FIXTURE_SETUP(pfnmap)
 {
 	self->pagesize = getpagesize();
 
+	/* We'll require two physical pages throughout our tests ... */
+	if (find_ram_target(&self->phys_addr, self->pagesize))
+		SKIP(return, "Cannot find ram target in '/proc/iomem'\n");
+
 	self->dev_mem_fd = open("/dev/mem", O_RDONLY);
 	if (self->dev_mem_fd < 0)
 		SKIP(return, "Cannot open '/dev/mem'\n");
 
-	/* We'll require the first two pages throughout our tests ... */
 	self->size1 = self->pagesize * 2;
 	self->addr1 = mmap(NULL, self->size1, PROT_READ, MAP_SHARED,
-			   self->dev_mem_fd, 0);
+			   self->dev_mem_fd, self->phys_addr);
 	if (self->addr1 == MAP_FAILED)
 		SKIP(return, "Cannot mmap '/dev/mem'\n");
 
@@ -129,7 +182,7 @@ TEST_F(pfnmap, munmap_split)
 	 */
 	self->size2 = self->pagesize;
 	self->addr2 = mmap(NULL, self->pagesize, PROT_READ, MAP_SHARED,
-			   self->dev_mem_fd, 0);
+			   self->dev_mem_fd, self->phys_addr);
 	ASSERT_NE(self->addr2, MAP_FAILED);
 }
 
-- 
2.49.0


