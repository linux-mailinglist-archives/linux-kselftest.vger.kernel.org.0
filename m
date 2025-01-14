Return-Path: <linux-kselftest+bounces-24460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8FA10BC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 17:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F53A1187
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3691C2324;
	Tue, 14 Jan 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TYd+3SM/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TN14Vn5s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54FF15C15C;
	Tue, 14 Jan 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870834; cv=none; b=jW4aqQcRztbWYLbzm27wpu1dgplswZY5B7Q8eHZh8EmA20QbzQmLm7T6rvBLXBZY1cCI5dTnVG1fak+xwraxgJ/FvF4oi51G2S/CFDmyJHMQtuDNeLyJPU26XZhD9aIFn2ag8bYaaojkM7JZJhuzeIjxY68Q5dNY65DLBsd1TiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870834; c=relaxed/simple;
	bh=gR157o96GOD5Fi5AXkbUAbIHuV8f9whd7ZV2AeOIVu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TSsk6oTowIKFtPyuYq0IMIrnZKxhkxidtOSPBmnjiKc0LBK5yR4qMDefp0fmwbeztvTxk8UJrroOKfdSO9gDj6A2lfd1gnwIje8EVS8dGf6J0QBpH/QMt9MIZFvqWoJfNO376HyqJ9LiVIuANVLyRpQV5cltFhQ6AJH/q+iaZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TYd+3SM/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TN14Vn5s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736870831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jc6lPJWBXfz2WyOhO1yRIjUxMkwiFWRg7L1C1Eo7ZW8=;
	b=TYd+3SM/Zzv8AeGJDtkHtFw5Zc07ZYkaqucBnYDTJBEwsbwaWlXHvqvHWkDlu72h3Z6Wd1
	TmTfIV0GaDhM/tD898JAabg9DEIa43vvV8rhJfw4ELBS27eASXQVxqVX7R5qvadW1uZ3SJ
	7ClAvHdSkHaoJYIiNYtUJL8a2ifV/z52TGJyCJx+gFdqPZUIy20DhrWGVzN58UuoTMRhF6
	aCS4pVMfvt1vT7yD1Y1F6+MtAEQmRktdAuc1vpPaerfqKk890qiemIJa7domNDepp1pdvU
	A8IafqZZmYsoTwklNjujlNr9NLKnGF8LOKGgvr9OZZJi+8rGx/R2VCR7vvxq3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736870831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jc6lPJWBXfz2WyOhO1yRIjUxMkwiFWRg7L1C1Eo7ZW8=;
	b=TN14Vn5silJWC6WJq8XDyL63P8p11yF1750ISYCYPkpibeDxk2BH0U6KeJuuQECo7vLBzn
	x7BU9R0ToQjc6rAg==
Date: Tue, 14 Jan 2025 17:06:47 +0100
Subject: [PATCH v4 3/4] selftests/mm: vm_util: Split up /proc/self/smaps
 parsing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250114-virtual_address_range-tests-v4-3-6fd7269934a5@linutronix.de>
References: <20250114-virtual_address_range-tests-v4-0-6fd7269934a5@linutronix.de>
In-Reply-To: <20250114-virtual_address_range-tests-v4-0-6fd7269934a5@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>, 
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736870827; l=2915;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=gR157o96GOD5Fi5AXkbUAbIHuV8f9whd7ZV2AeOIVu8=;
 b=w4OIeFsyazqsWCb42afv7zGrsXsPmDhiUXiU0G/0S+jHi5uqcgpHGFHrnJlu+GKmwp+XkwCiX
 TMob5JaYSQdDteTjGBmt3vMUIt6mJRqhvM03Tv7+D6ZfV2KKG4mQuPX
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Upcoming changes want to reuse the /proc/self/smaps parsing logic to
parse the VmFlags field.
As that works differently from the currently parsed HugePage counters,
split up the logic so common functionality can be shared.

While reworking this code, also use the correct sscanf placeholder for
the "uint64_t thp" variable.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/vm_util.c | 42 +++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index d8d0cf04bb57fd22bd7748fffec6a23c3103e35c..a450ab353f8e710a6bfce347bc3a7309920c70f5 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -2,6 +2,7 @@
 #include <string.h>
 #include <fcntl.h>
 #include <dirent.h>
+#include <inttypes.h>
 #include <sys/ioctl.h>
 #include <linux/userfaultfd.h>
 #include <linux/fs.h>
@@ -193,13 +194,11 @@ unsigned long rss_anon(void)
 	return rss_anon;
 }
 
-bool __check_huge(void *addr, char *pattern, int nr_hpages,
-		  uint64_t hpage_size)
+char *__get_smap_entry(void *addr, const char *pattern, char *buf, size_t len)
 {
-	uint64_t thp = -1;
 	int ret;
 	FILE *fp;
-	char buffer[MAX_LINE_LENGTH];
+	char *entry = NULL;
 	char addr_pattern[MAX_LINE_LENGTH];
 
 	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
@@ -211,23 +210,40 @@ bool __check_huge(void *addr, char *pattern, int nr_hpages,
 	if (!fp)
 		ksft_exit_fail_msg("%s: Failed to open file %s\n", __func__, SMAP_FILE_PATH);
 
-	if (!check_for_pattern(fp, addr_pattern, buffer, sizeof(buffer)))
+	if (!check_for_pattern(fp, addr_pattern, buf, len))
 		goto err_out;
 
-	/*
-	 * Fetch the pattern in the same block and check the number of
-	 * hugepages.
-	 */
-	if (!check_for_pattern(fp, pattern, buffer, sizeof(buffer)))
+	/* Fetch the pattern in the same block */
+	if (!check_for_pattern(fp, pattern, buf, len))
 		goto err_out;
 
-	snprintf(addr_pattern, MAX_LINE_LENGTH, "%s%%9ld kB", pattern);
+	/* Trim trailing newline */
+	entry = strchr(buf, '\n');
+	if (entry)
+		*entry = '\0';
 
-	if (sscanf(buffer, addr_pattern, &thp) != 1)
-		ksft_exit_fail_msg("Reading smap error\n");
+	entry = buf + strlen(pattern);
 
 err_out:
 	fclose(fp);
+	return entry;
+}
+
+bool __check_huge(void *addr, char *pattern, int nr_hpages,
+		  uint64_t hpage_size)
+{
+	char buffer[MAX_LINE_LENGTH];
+	uint64_t thp = -1;
+	char *entry;
+
+	entry = __get_smap_entry(addr, pattern, buffer, sizeof(buffer));
+	if (!entry)
+		goto err_out;
+
+	if (sscanf(entry, "%9" SCNu64 " kB", &thp) != 1)
+		ksft_exit_fail_msg("Reading smap error\n");
+
+err_out:
 	return thp == (nr_hpages * (hpage_size >> 10));
 }
 

-- 
2.47.1


