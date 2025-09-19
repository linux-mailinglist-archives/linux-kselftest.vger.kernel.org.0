Return-Path: <linux-kselftest+bounces-41952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92733B899B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 15:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC2E17727E
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 13:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0505731197B;
	Fri, 19 Sep 2025 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cTRcqis9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B5311966
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287216; cv=none; b=lmQwkdYIWM16JokY1K2hwESxqSAYAE4EDF9AaPVEcovdoQWRwzNIREbtFEXZndma20wW3v4eKmHXotbZ5S9NvIVcA0m+jBTuKK5UAqLTcfqzzJmc2lmng6Ue7Ci1vZF4gt/hNbWyAU1JXeQ2PbLlMIALFVMsjqozlubLfuN9oKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287216; c=relaxed/simple;
	bh=CEQREJ+9sE8ZRNG+NfCcDfGBdfafdlTZitq1Fenri1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ash9YPjSH3oj2eR77Dlt/cZugiNG2PSldSyDZiPJX6qZiAbc0pj6dG+xhN8oDuMQGJDLGuXNuol4k/WaW4opbIKRmg4AMAMGreMTd0TKG8Z7BfoTh+0DBJH0ityXv/vhg9N60x56MhyuM1cYJcG9mbVq5ZvTJ6ktTK1VeKM1+no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cTRcqis9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24456ce0b96so23955905ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 06:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287214; x=1758892014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GkofW6KtUkwUdgZb+yZah5ECJQKBkU1k3qjUK5RSSQ=;
        b=cTRcqis9cKl9x7JwLatZtNO1/juB+u+uQMPi3oh7nttj5EhC1BtX50l1tKUzBkPLYr
         GnDkTVJvwVxkxBQixXev0Qk4j7Yrmluad1JNAaIVMfOMM5SDw+eP9XsocXRkU6rkOsGB
         AVjyqGIv6o7QtpWrLTaAobg0+KSO6qORco4gH7yCpFTuSYlgwsR7jmbbLFgWRWrqNhoe
         MJSKMp9jSUJOr8hzPWbHygV7P4y1fNFJHIBqZJidtfs58f43Tre/8gv4XEVYwc9fUqKg
         xoFDBqFVEYPN8WOwiQttnu+U8vbBcZZbkGxsUfFA7zpLcSVJntKl6AijIQqcNVhSfOrc
         8V7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287214; x=1758892014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5GkofW6KtUkwUdgZb+yZah5ECJQKBkU1k3qjUK5RSSQ=;
        b=lyW7TNATxaWYK9IqkRsb0iOmPu+mkw/gSM7E/XMTB2Vo9sqqY1lUQZ2YaV1x4dMKZb
         ueHYWCFkr3Jvs99vWbveWf5F9Na5SPe4LOcaiz2kkEBixvbEvcIg0P/1xnnDcypC09WE
         UCul3MkE9soueF1sOLEWhjhrFsHpytgb/sSLjeciUqLb8vNFNsOCf+qSTnbOIy3aBpP/
         ymBKXwasqgM/WsqLIZ1/Rmuc2Ugw5znOIZ+SlGLRdmnVyIF7tVnQZBAaj5P0bvn4r+Ht
         ii0lc15quC0kLb5/5OUDc8mjDfF/Um+kMrXyT62e/dIOioAsjxy4nQLfz0k/BH0ft6hG
         pzzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNZEfHWgmZ+bf2SHf5HdHfWTzCVJD0REUaorrMT5xc9RhrE5goaIyU+E48IwUwdSZP0FWIVmiA4KpTdPaSBp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWYWueca8JIOIl8LYPjLbMJW44ucwpKBgU0bV4PGL+5fVphdV6
	tdD2k0dw+TGiTzAWCCsCVV1DSpdLuuIvYVMUKGJ1bVg/sqAlSbxN4WhlAQOfnFR6lLM=
X-Gm-Gg: ASbGncs5AhsGYDaOMWbcUDDyuGz+PwiDpeXNiRcp75rO5c9sCsFkpXko0qVe6oxr385
	4ldyXV8en+miW+THZrpGF3oOjkyXhdK8OO6Kjsx+ENAPsIFQaR4Pnq4fIqqOt6jZNBrEb67Hg8o
	BZ93L0EKys+yv1dATZfrj219kT2OiB7EhZm2jlJUAx2DHwHTivi4adXV2O+AnTbxzstyB6x2nIl
	J9lUjJg+HWvcA8iM7hxOVjWvUkIcTNk7TT8vWeFRLQxjPPIBKvjMtvZd5fvNaSjcDQKGUyJIBQE
	gbrhSRc05R4pShA9Rr65dy87DCQuzQIBlEyZoTpyb/5ObP7W+xMmteliYQ/LX+RavifSD3YfpTr
	gkXzhZs2A4oyL2XruUc/c5umMa8lQARtoWx9PIEElMufvk4k=
X-Google-Smtp-Source: AGHT+IHr5sMr/zdX7WDbCbAlnraq6nlmulLXz9ca/DHI8paZd8/0/Lo0LvgEROpUt8AfOZfHDDWsjg==
X-Received: by 2002:a17:902:cf01:b0:24c:e9de:ee11 with SMTP id d9443c01a7336-269b8ef73b0mr50156855ad.17.1758287214209;
        Fri, 19 Sep 2025 06:06:54 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:53 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	libo.gcs85@bytedance.com,
	Yongting Lin <linyongting@bytedance.com>
Subject: [PATCH V2 7/8] mshare: selftests: Add test case to demostrate the swapping of mshare memory
Date: Fri, 19 Sep 2025 21:06:19 +0800
Message-Id: <20250919130620.56518-7-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250919130620.56518-1-linyongting@bytedance.com>
References: <20250919130620.56518-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This case is quit simple by using madvise(MADV_PAGEOUT), but for verifying
the memory size of being swappd, we need to setup the memcg and attach test
process to this memcg before perform the test.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/.gitignore |  1 +
 tools/testing/selftests/mshare/Makefile   |  2 +-
 tools/testing/selftests/mshare/memory.c   | 71 +++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/mshare/memory.c

diff --git a/tools/testing/selftests/mshare/.gitignore b/tools/testing/selftests/mshare/.gitignore
index 406f31bd432c..116774fa2b82 100644
--- a/tools/testing/selftests/mshare/.gitignore
+++ b/tools/testing/selftests/mshare/.gitignore
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 basic
+memory
diff --git a/tools/testing/selftests/mshare/Makefile b/tools/testing/selftests/mshare/Makefile
index 651658d091c5..b0418b8c30f2 100644
--- a/tools/testing/selftests/mshare/Makefile
+++ b/tools/testing/selftests/mshare/Makefile
@@ -2,6 +2,6 @@
 
 CFLAGS = $(KHDR_INCLUDES) -Wall -g -O2
 
-TEST_GEN_PROGS := basic
+TEST_GEN_PROGS := basic memory
 
 include ../lib.mk
diff --git a/tools/testing/selftests/mshare/memory.c b/tools/testing/selftests/mshare/memory.c
new file mode 100644
index 000000000000..4bb0d22b9c03
--- /dev/null
+++ b/tools/testing/selftests/mshare/memory.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mman.h>
+
+#include "../kselftest_harness.h"
+#include "util.c"
+
+FIXTURE(memory)
+{
+	char filename[128];
+	int fd;
+
+	char cgroup[128];
+
+	void *addr;
+	size_t align_size;
+};
+
+FIXTURE_SETUP(memory)
+{
+	ASSERT_NE(create_mshare_test_cgroup(self->cgroup, sizeof(self->cgroup)), -1);
+
+	attach_to_cgroup(self->cgroup);
+
+	self->align_size = mshare_get_info();
+	self->fd = create_mshare_file(self->filename, sizeof(self->filename));
+	ASSERT_NE(self->fd, -1);
+	ASSERT_NE(ftruncate(self->fd, self->align_size), -1);
+
+	ASSERT_NE(mshare_ioctl_mapping(self->fd, MB(2),
+				MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED),
+			-1);
+	self->addr = mmap(NULL, self->align_size, PROT_READ | PROT_WRITE,
+						MAP_SHARED, self->fd, 0);
+	ASSERT_NE(self->addr, MAP_FAILED);
+}
+
+FIXTURE_TEARDOWN(memory)
+{
+	ASSERT_NE(munmap(self->addr, self->align_size), -1);
+	close(self->fd);
+
+	ASSERT_NE(unlink(self->filename), -1);
+	dettach_from_cgroup(self->cgroup);
+
+	ASSERT_NE(remove_cgroup(self->cgroup), -1);
+}
+
+TEST_F(memory, swap)
+{
+	size_t swap_size;
+
+	/* fill physical memory */
+	memset(self->addr, 0x01, MB(2));
+
+	/* force to reclaim the memory of mshare */
+	ASSERT_NE(madvise(self->addr, MB(2), MADV_PAGEOUT), -1);
+
+	swap_size = read_swap_from_cgroup(self->cgroup);
+	ASSERT_NE(swap_size, -1);
+
+	/* convert to bytes */
+	swap_size *= 4096;
+
+	ksft_print_msg("Tip: Please configure swap space before running this test.\n");
+
+	/* allow an error of 10% */
+	ASSERT_GT(swap_size, MB(2) * 9 / 10);
+}
+
+TEST_HARNESS_MAIN
-- 
2.20.1


