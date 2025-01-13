Return-Path: <linux-kselftest+bounces-24364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD624A0B7F9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 14:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586DB1882FDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 13:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EAB2451DA;
	Mon, 13 Jan 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JC9KfFs9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="akBV3Alj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC171AAC4;
	Mon, 13 Jan 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736774235; cv=none; b=EYwUPrDXx1cPy97WdLtyt3rhaGVwDi9s45qH75Z/wPly6LXTg4Mk9EKtnIWbbFXgE/aCVuy0zrVeUVjqEAbjTerQo+f7S2Xa+RZgmUjRei7d5U73/b5w487om8hnG+njW09moEdSNHaLxBS7oN6KbnM37WG4MOirIW0G1yaT2Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736774235; c=relaxed/simple;
	bh=6BHmjOZjGkeOAxEqViu35ESnPzRfjS5CZ+5Ol52x1DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bg9NC94Nd7wjiLbSpSux6uCOpPZzkcoCYdnb/FmL6zTsMxsosRYAiF6i/fXMFJiAQqF7bT+pUEWtxInkADHgMDBIpX23FTMycHxcXITxW8WCsal04380BgSdj51QIe1G1EfrGgop6VD1GkghmbISTf2mw8gL6jh9aGRaRRvS2+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JC9KfFs9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=akBV3Alj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736774232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/blv4n22o4xwWzbzoYSZD2Qy5uJLVnQWfTrkFwx7l5I=;
	b=JC9KfFs9JRXBreQf5tTCEIA1Ao/60W8ETgVULszb5IjAOS4XhzBsmguV0z4dqb+hhlDY31
	ygcP4IHPscYdJkrpg4+LBOops94w8k6dI0FAJbVjF3w8M6KpOKt0DEyLu134egeSa7C2Df
	JHtRsIGBWHFvVUc0PKV5eTwoMgtldEQd/QqgoGI5SorvLXZbOKkyz7mLm7n+VsYBEKV9O5
	84IN+p2CW6y1mKNX/bIXA/oKP9wWIIXVt+vJt6RCTA93NqX3a7jktamava233cQXNmtIyy
	AbXRuaVGSoytzsRu/kbfim8TpJLI06qRngTzJaXqf6nt+aa0NjzfB3AAkafHxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736774232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/blv4n22o4xwWzbzoYSZD2Qy5uJLVnQWfTrkFwx7l5I=;
	b=akBV3AljlG0D1RueAA+llky0t1bUlT/ReAoBYz+3tA96RoxFhJdo/Ej4ttqRYBFASO9Vom
	JOqtMbCEWhwUxsCw==
Date: Mon, 13 Jan 2025 14:15:37 +0100
Subject: [PATCH v3 3/4] selftests/mm: vm_util: Split up /proc/self/smaps
 parsing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250113-virtual_address_range-tests-v3-3-f4a8e6b7feed@linutronix.de>
References: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
In-Reply-To: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736774229; l=2860;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=6BHmjOZjGkeOAxEqViu35ESnPzRfjS5CZ+5Ol52x1DA=;
 b=kpnruwzlgMo/dc08nb/9iPLsVW71YnBKUlSIi/oNgq/lXX5w4hmH5bzGI8CKBfFvq82kX/ZME
 L/MltRi86xRCLZc6e+9DcqmU/KPMVlsaDy6rFzqC8ID23MLQyvGI34P
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Upcoming changes want to reuse the /proc/self/smaps parsing logic to
parse the VmFlags field.
As that works differently from the currently parsed HugePage counters,
split up the logic so common functionality can be shared.

While reworking this code, also use the correct sscanf placeholder for
the "uint64_t thp" variable.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/selftests/mm/vm_util.c | 42 +++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index d8d0cf04bb57fd22bd7748fffec6a23c3103e35c..8468a19d6acca10c7e9228c03a935cdeb2402b5d 100644
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
+	char *entry;
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


