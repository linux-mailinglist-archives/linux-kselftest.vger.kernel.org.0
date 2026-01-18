Return-Path: <linux-kselftest+bounces-49263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 795B7D39580
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39F703009498
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F173D331A5E;
	Sun, 18 Jan 2026 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z38z0iD7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530632B9A9
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744295; cv=none; b=r+DoyCb6V0q2z2/X4G5YnjjLZ/HGvPeoNDa7MTZiBUJcgBPHPZCq2V6SCdswrFCkX832SoaD8riwMJVcUlQAPTYI5H2xDanU7kQCweQ+TZC4xuDeIthgsaIkwl3MTu0ER3MfCOD0T/onF+kFmVfNabPK03rBlLtXPW2nYODINxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744295; c=relaxed/simple;
	bh=cA7Wf24xRZMGvexNF5EukLQTMHLTWcEpzc1WQZ7dY4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxR1syJSJoonaIiiZfj6c+juwc2hpwyuuo0tSO6k8Lrrf1NUBT27p9mYNhj8zC5n/pRQXyjXNBK/humYE3EHBvmFOEX7vpIt+2XzD+it3/OzygKWtNezLSOMcL3iLRRqgwC/KedSmZEXBdpmgqh+h+cyNfT/JhPJ9wAusw+f9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z38z0iD7; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso1975107a91.3
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 05:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768744293; x=1769349093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=syzpHEUbQUtSB0CZW+o/t8+Mx8hSQ1o3vVToB9s2LHA=;
        b=Z38z0iD7eymLBCBNvgoSnr9vZ4sKUsBpYmVGt5ZVVkitogMwyi4oxF20YMtXzBEhuG
         xYNbZw3AThjLH6kYnKeCAQQhbo22gYqf3f9/8TBBMC/2J7m5XQOmKud3fCBBrKWlfiVS
         UIG85wpYbFduM22WpH3vDrEheQY9b7TtCz3726VTqktANFAoniEnlSqH9wBEtEGpHOJe
         boraWnWmFHds/xgumhCoMuLhW3mNzZBGudRqWbSLC6bwTeIiwhbWbZNtBPK4c4RDY86S
         Bw1+n/hsu8gOM+cELL/JMbwK5dkx0GAVmT4L2ksUqo1SapgXCxjSexravI6N0ZpB98HH
         D5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768744293; x=1769349093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syzpHEUbQUtSB0CZW+o/t8+Mx8hSQ1o3vVToB9s2LHA=;
        b=miONK3QSdbjOt2vMRfENnlNepEicsIgperg3oSds2a3h+gaXjk3ltMhAZIfkIA96Sg
         FqeqzQ4mTOvk/+PspcRj9cx7xmOVOxxdFBntNbONyzjULqXNp1vmwN8vDrg6JaA4cXcn
         5u2Z/eK2KsOHVF8dXdRyzjulAoRnS/KH16V4+GDlfHVgpr2VaeFkYHAXshO1jK35hrfX
         h+4EPqNsWQiR2zaj0dQOr4BpSq0D55sCzHzBuxU+NoCSVKRv5o1eECpXjA1yR3r3WwTX
         0ibe9JjY8nXSw9HoeOrg7N9KNmkwNGx6UcXicKPtgahs79CASyXSmZ/gnqs5yLMYyPdd
         4kNA==
X-Forwarded-Encrypted: i=1; AJvYcCVCPe9SnwPcH7HSxJZMmjXcEWlKkoWxh2vBx3tv2xxmXue8y+D2YFrINn+56V2xo0XOPUN4QBFJP24yYJZP2No=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVi1KFW5+Xls9zv79GCEte0RNlXL1iq4lNpxu+yhkImKtoatRX
	xW+KYwZpLCFR/WROpntiN7YVC8PJN/Wp9+tR+9AXq4kZ6B595Y287bgn
X-Gm-Gg: AY/fxX7qiMdidxXl8t7j60OU/BslFuHtAkEfGXIdUEMO46jP9Xk7Hjn0At+lI3DfBNE
	njQ+6RrIO/39ekiR0bDskEGVJS/o4hIGBYeZpQvbudCT8deU2wEtWVOFMSjYugBQCCZSVx8/9G4
	qch7oE2MrtfCzJmqPkFZOKM4QEjEZs4+es12e6dT0LeyLTRW7pR2AyRlZEAhxt3UaZ4R1BSK6+J
	A9ND5WjDoNrcAIbIAeWULo9MelzZOTDqXy8U2RWOgLLeKdIk214fZIe6zJJSnFq3xUOogjqWFxx
	t1ajcUW3ew+BuZ/YpYchrtBthIgRwre2wMTBbq/KGI3nzGLaRjiO7Kh5Nk90teVpUCpOC3OAJ3I
	0BO41fn8n+rzYzuQWAfWCf8ywVx9Zo5psGfUbbPpbxL6m0I7gt+sPaJVQ/FQZ9s/BHdI=
X-Received: by 2002:a17:90b:2d43:b0:33b:cbb2:31ed with SMTP id 98e67ed59e1d1-35272d72abamr6856556a91.0.1768744293069;
        Sun, 18 Jan 2026 05:51:33 -0800 (PST)
Received: from localhost ([2407:cdc0:b010::101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352677ec701sm9206524a91.5.2026.01.18.05.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 05:51:32 -0800 (PST)
From: zishun yi <zishun.yi.dev@gmail.com>
To: shuah@kernel.org
Cc: vivek.kasireddy@intel.com,
	akpm@linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	richard.weiyang@gmail.com,
	reddybalavignesh9979@gmail.com,
	zishun yi <zishun.yi.dev@gmail.com>
Subject: [PATCH v1] selftests: udmabuf: fix hugepage size calculation
Date: Sun, 18 Jan 2026 21:51:26 +0800
Message-ID: <20260118135126.102472-1-zishun.yi.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udmabuf's test 6 and 7 is intended to verify the behavior of 2MB huge pages migration,
but the helper function still calculates the size using standard (4KB) pages.

Signed-off-by: zishun yi <zishun.yi.dev@gmail.com>
---
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index d78aec662586..8887fb9b79df 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -69,7 +69,7 @@ static int create_udmabuf_list(int devfd, int memfd, off64_t memfd_size)
 	for (i = 0; i < NUM_ENTRIES; i++) {
 		list->list[i].memfd  = memfd;
 		list->list[i].offset = i * (memfd_size / NUM_ENTRIES);
-		list->list[i].size   = getpagesize() * NUM_PAGES;
+		list->list[i].size   = page_size * NUM_PAGES;
 	}
 
 	list->count = NUM_ENTRIES;
@@ -115,8 +115,8 @@ static int compare_chunks(void *addr1, void *addr2, off64_t memfd_size)
 	while (i < NUM_ENTRIES) {
 		off = i * (memfd_size / NUM_ENTRIES);
 		for (j = 0; j < NUM_PAGES; j++, k++) {
-			char1 = *((char *)addr1 + off + (j * getpagesize()));
-			char2 = *((char *)addr2 + (k * getpagesize()));
+			char1 = *((char *)addr1 + off + (j * page_size));
+			char2 = *((char *)addr2 + (k * page_size));
 			if (char1 != char2) {
 				ret = -1;
 				goto err;
@@ -126,7 +126,7 @@ static int compare_chunks(void *addr1, void *addr2, off64_t memfd_size)
 	}
 err:
 	munmap(addr1, memfd_size);
-	munmap(addr2, NUM_ENTRIES * NUM_PAGES * getpagesize());
+	munmap(addr2, NUM_ENTRIES * NUM_PAGES * page_size);
 	return ret;
 }
 
@@ -240,7 +240,7 @@ int main(int argc, char *argv[])
 	addr1 = mmap_fd(memfd, size);
 	write_to_memfd(addr1, size, 'a');
 	buf = create_udmabuf_list(devfd, memfd, size);
-	addr2 = mmap_fd(buf, NUM_PAGES * NUM_ENTRIES * getpagesize());
+	addr2 = mmap_fd(buf, NUM_PAGES * NUM_ENTRIES * page_size);
 	write_to_memfd(addr1, size, 'b');
 	ret = compare_chunks(addr1, addr2, size);
 	if (ret < 0)
@@ -256,7 +256,7 @@ int main(int argc, char *argv[])
 	size = MEMFD_SIZE * page_size;
 	memfd = create_memfd_with_seals(size, true);
 	buf = create_udmabuf_list(devfd, memfd, size);
-	addr2 = mmap_fd(buf, NUM_PAGES * NUM_ENTRIES * getpagesize());
+	addr2 = mmap_fd(buf, NUM_PAGES * NUM_ENTRIES * page_size);
 	addr1 = mmap_fd(memfd, size);
 	write_to_memfd(addr1, size, 'a');
 	write_to_memfd(addr1, size, 'b');
-- 
2.52.0


