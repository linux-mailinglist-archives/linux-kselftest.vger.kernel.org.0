Return-Path: <linux-kselftest+bounces-29202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AC0A649BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 11:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB5D1894D01
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC282238164;
	Mon, 17 Mar 2025 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zaav33xT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D2221577
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206852; cv=none; b=GHTVo0WgPprRpukCDBfqORzr3vU9+BZJ1OkUQqkG2SHa/8NsF7//0kg0uXpxJRM/lYkmOJUIU63VN1TknsRJ1mnnFmj21oPfsuQ+PQgZIAowfegqTB5MpdQkyqsKWKHXT6pBcB4OpLeNp0F6Wa4STYMlIm2a6pt0rdkP92Yzu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206852; c=relaxed/simple;
	bh=xK2ZBkUkyt1F/UpRmUx4V+BWA8zhSQC4XnXhnJZY+2Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WgOzpUH1geeayjbnhGSin7VIh5s1tToPX0Fu6fkcz8JoZtq8wQGeNKTvvdsN/cCUmu7RxG67Nz/jf6N8/6FIO57b5CZwdZ9kPIM43PTuzc1VOuY60PaWtUDibMpxJmIYLYlL/CG3FSJ2vPmp3vxFWgOGtS3wul7fopPXkIbeLj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zaav33xT; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so11333955e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Mar 2025 03:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742206849; x=1742811649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kbZ86BA4kdFbqSY9+s8S+XusL7glxmlCPxfcM9oxYBA=;
        b=zaav33xTjNFCDYSGQOjKZZ+at+Gp6OpDwFcCApT4dAEFRgl3bLNTVvNxzKjZOMclkq
         mUsllDAvacdUuZIWs/UyVOMhElmf5FxemxfXiKtSvUjArM2AUrzfiFZnQCJNqj9+YKL3
         2WN7yHOmezs3XvGaroUCYH8jNZWZFoUkp6pEUabdl42tqm+whyRxffPx6tRWdNZ2lMER
         n77bASU2rsNkTew7Inx7dgAfrqFHieWNnZxtpQ9i3O97/60s1bhl5DVvDI5loWBh7tAI
         njma+i5yf+TLeeeLh+Blfi69SVsAi4V0tssw/MBz9lF0nx5Zb9Qg+SPEjXFmT6PR6Kf0
         M0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742206849; x=1742811649;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbZ86BA4kdFbqSY9+s8S+XusL7glxmlCPxfcM9oxYBA=;
        b=BrufbPLH89bryxLeuTaaODpIAw/0ZFUODPM1Ve3wy4vyxcaRBLgDHxh6Jw2SfHMDF3
         3qzHEYO0hO9EiBQRjhvO55YhJpp72C/9K/w1/B+FnYeRp4aZcQ08guvcTmyvK4KhYhd6
         9UsmmOTSVkCuqbyNV59xoM2bQbaGhstAbQyu4u1o2iA6sM3Hf1IsfS9kT0a5KgiycmMv
         gZzGpWl+O1n45oDuKx5MBHry75aDcYnT/3jRR27WcQmtaTH7IWXucKczDeoHlkrltfoH
         AQbr7Gzq0gWWidPUVRSK3N5nO4/vrTickhHy4KSACc3LAuscggZfYNBp45ESs8DjChoe
         0dcw==
X-Forwarded-Encrypted: i=1; AJvYcCXKDIAmbomtl1ChoMRh3xCZM6u2OUFCp/vDmisWcyzhkpoagbQ3559Sw+PmoFgfFAP+QGxD09lK9uYOHeW+Chg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2SH4Lj+uas4hwZKGDJ7HQBckk55v3I7TrsiNnpnKmG1Ue5thl
	tQEtyScJBJdu7Q6bIUdaI5g8IwLjHl0++y1orgaKbKI8b2h7Gi+LvtDAlq3pRY50ngpjouOORQH
	NkeUxw93WuA==
X-Google-Smtp-Source: AGHT+IEzYbPI9MyXHYu4Ac9ur08nSh+vGUDuVixK4h8Z9GABnEMfkvbGKDEW4lcqW9eMX+ON+NXpj/wTIp3w+Q==
X-Received: from wmdd21.prod.google.com ([2002:a05:600c:a215:b0:43b:c914:a2d9])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:350a:b0:43c:f70a:2af0 with SMTP id 5b1f17b1804b1-43d1ec8643amr128960045e9.16.1742206849047;
 Mon, 17 Mar 2025 03:20:49 -0700 (PDT)
Date: Mon, 17 Mar 2025 10:20:34 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHH312cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0NzXcuCtGLd5Pzc3NS8kmJdI5Mks7REUxND8+QUJaCegqLUtMwKsHn RsbW1ALTkndhfAAAA
X-Change-Id: 20250317-9pfs-comments-24b6fa5417cd
X-Mailer: b4 0.14.2
Message-ID: <20250317-9pfs-comments-v1-1-9ac96043e146@google.com>
Subject: [PATCH] selftests/mm: Add commentary about 9pfs bugs
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="utf-8"

As discussed here:

https://lore.kernel.org/lkml/Z9RRkL1hom48z3Tt@google.com/

This code could benefit from some more commentary.

To avoid needing to comment the same thing in multiple places (I guess
more of these SKIPs will need to be added over time, for now I am only
like 20% of the way through Project Run run_vmtests.sh Successfully),
add a dummy "skip tests for this specific reason" function that
basically just serves as a hook to hang comments on.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
To: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/gup_longterm.c |  6 +-----
 tools/testing/selftests/mm/map_populate.c |  8 +++-----
 tools/testing/selftests/mm/vm_util.h      | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 03271442aae5aed060fd44010df552a2eedcdafc..21595b20bbc391a0e5d0ab0563ac4ce5e1e0069f 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -97,11 +97,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 
 	if (ftruncate(fd, size)) {
 		if (errno == ENOENT) {
-			/*
-			 * This can happen if the file has been unlinked and the
-			 * filesystem doesn't support truncating unlinked files.
-			 */
-			ksft_test_result_skip("ftruncate() failed with ENOENT\n");
+			skip_test_dodgy_fs("ftruncate()");
 		} else {
 			ksft_test_result_fail("ftruncate() failed (%s)\n", strerror(errno));
 		}
diff --git a/tools/testing/selftests/mm/map_populate.c b/tools/testing/selftests/mm/map_populate.c
index 433e54fb634f793f2eb4c53ba6b791045c9f4986..9df2636c829bf34d6d0517e126b3deda1f3ba834 100644
--- a/tools/testing/selftests/mm/map_populate.c
+++ b/tools/testing/selftests/mm/map_populate.c
@@ -18,6 +18,8 @@
 #include <unistd.h>
 #include "../kselftest.h"
 
+#include "vm_util.h"
+
 #define MMAP_SZ		4096
 
 #define BUG_ON(condition, description)						\
@@ -88,11 +90,7 @@ int main(int argc, char **argv)
 
 	ret = ftruncate(fileno(ftmp), MMAP_SZ);
 	if (ret < 0 && errno == ENOENT) {
-		/*
-		 * This probably means tmpfile() made a file on a filesystem
-		 * that doesn't handle temporary files the way we want.
-		 */
-		ksft_exit_skip("ftruncate(fileno(tmpfile())) gave ENOENT, weird filesystem?\n");
+		skip_test_dodgy_fs("ftruncate()");
 	}
 	BUG_ON(ret, "ftruncate()");
 
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 0e629586556b5aae580d8e4ce7491bc93adcc4d6..6effafdc4d8a23f91f0adcb9e43d6196d651ba88 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -5,6 +5,7 @@
 #include <err.h>
 #include <strings.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
+#include "../kselftest.h"
 
 #define BIT_ULL(nr)                   (1ULL << (nr))
 #define PM_SOFT_DIRTY                 BIT_ULL(55)
@@ -32,6 +33,23 @@ static inline unsigned int pshift(void)
 	return __page_shift;
 }
 
+/*
+ * Plan 9 FS has bugs (at least on QEMU) where certain operations fail with
+ * ENOENT on unlinked files. See
+ * https://gitlab.com/qemu-project/qemu/-/issues/103 for some info about such
+ * bugs. There are rumours of NFS implementations with similar bugs.
+ *
+ * Ideally, tests should just detect filesystems known to have such issues and
+ * bail early. But 9pfs has the additional "feature" that it causes fstatfs to
+ * pass through the f_type field from the host filesystem. To avoid having to
+ * scrape /proc/mounts or some other hackery, tests can call this function when
+ * it seems such a bug might have been encountered.
+ */
+static inline void skip_test_dodgy_fs(const char *op_name)
+{
+	ksft_test_result_skip("%s failed with ENOENT. Filesystem might be buggy (9pfs?)\n", op_name);
+}
+
 uint64_t pagemap_get_entry(int fd, char *start);
 bool pagemap_is_softdirty(int fd, char *start);
 bool pagemap_is_swapped(int fd, char *start);

---
base-commit: a91aaf8dd549dcee9caab227ecaa6cbc243bbc5a
change-id: 20250317-9pfs-comments-24b6fa5417cd

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


