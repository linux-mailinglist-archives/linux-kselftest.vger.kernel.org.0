Return-Path: <linux-kselftest+bounces-28757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01350A5CAB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 17:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F543AA1D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4EF25EFBA;
	Tue, 11 Mar 2025 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="g46Q8Yyd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F52080D9;
	Tue, 11 Mar 2025 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741710082; cv=none; b=lGXfeZ5NiBk2TAXlrskc/b31GlJrik2ivEf4pOKKzRw8VD1Vpya+fqCRoxnHj1KhsboVITnc5K4eU/HxB7I0fK06W1DCzpNvp361VbE+ZBYjogJbURngt7fSNhoQwDfgvrb6MuEBZq3rijoHwjkL5J+Xq/r/B2ncVdRU12F0qEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741710082; c=relaxed/simple;
	bh=GYGQSWMmGehgUQ3u9W6vrBEz0DsLmVxBYZw6fjbC130=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IHje4rT8hdv7aifhHGxd6B+wy3UvYLvm7sQLjFLolH9+8OQ6KuTwz9NYvTkE7QSU2RMRMyTPs2CWYzYm1J0DXKDwjB505gKHKxXSrolH0Mgp45VeGLsnuNzElrw8tAcYF0DJ4KAiUWsAWz9L5Dn404a/S/r8fndLkBldYzcAP0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=g46Q8Yyd; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Andrey Kalachev <kalachev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1741710073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zklo9sF/IW4Ipfk3DqbkxcZ3lU6yko995bFAigRpWDs=;
	b=g46Q8YydqPHV7NqdGzBBQfWeqfU6qsbIaTcpcQmVber2J0xqxZr6UNDXNMtos9ehtNx2zE
	GUlvtX5/1T/oOzE5isljsNSNk3y8h967jjYLOrEFaCFZ5X4ZtpDJO4toCODM3TGF89Mrt5
	XllMb5u1Uiua+mUkpz1M8ZMVhzjwCmw=
To: stable@vger.kernel.org
Cc: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	npache@redhat.com,
	kalachev@swemel.ru,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1.y] selftests/vm: fix undefined reference of the `default_huge_page_size`
Date: Tue, 11 Mar 2025 19:21:13 +0300
Message-Id: <20250311162113.12458-1-kalachev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commit a584c7734a4d ("selftests: mm: fix map_hugetlb failure on
64K page size systems") backported the fix from v6.8 to stable v6.1.
The patch uses default_huge_page_size() function, which definition
moved into vm_util.[ch] by commit bd4d67e76f699 ("selftests/mm:
merge default_huge_page_size() into one") merged to upsream since
v6.4. However, in v6.1 common definition/declaration for the
default_huge_page_size() we doesn't have, the following build
error is seen:

map_hugetlb.c:79:25: warning: implicit declaration of function
‘default_huge_page_size’ [-Wimplicit-function-declaration]
   79 |         hugepage_size = default_huge_page_size();
      |                         ^~~~~~~~~~~~~~~~~~~~~~
/usr/bin/ld: /tmp/ccx95BZz.o: in function `main':
map_hugetlb.c:(.text+0x104): undefined reference to
`default_huge_page_size'

Place default_huge_page_size() function body into map_hugetlb.c
to fix this issue.

Fixes: a584c7734a4d ("selftests: mm: fix map_hugetlb failure on 64K page size systems")
Signed-off-by: Andrey Kalachev <kalachev@swemel.ru>
---
 tools/testing/selftests/vm/map_hugetlb.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index c65c55b7a789..5826c50b6736 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -67,6 +67,30 @@ static int read_bytes(char *addr, size_t length)
 	return 0;
 }
 
+/*
+ * default_huge_page_size copied from mlock2-tests.c
+ */
+unsigned long default_huge_page_size(void)
+{
+	unsigned long hps = 0;
+	char *line = NULL;
+	size_t linelen = 0;
+	FILE *f = fopen("/proc/meminfo", "r");
+
+	if (!f)
+		return 0;
+	while (getline(&line, &linelen, f) > 0) {
+		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
+			hps <<= 10;
+			break;
+		}
+	}
+
+	free(line);
+	fclose(f);
+	return hps;
+}
+
 int main(int argc, char **argv)
 {
 	void *addr;
-- 
2.39.5


