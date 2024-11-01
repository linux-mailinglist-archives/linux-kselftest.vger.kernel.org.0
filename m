Return-Path: <linux-kselftest+bounces-21300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC149B92F0
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 15:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB1E1C20B3A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 14:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F7E3BBE5;
	Fri,  1 Nov 2024 14:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="kMbq5D5u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629929475;
	Fri,  1 Nov 2024 14:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730470588; cv=pass; b=YxftPWmZUEfeMmvg5Y7+swc0Nmwq7WjsOZA8tIcP1ijYJZsAPSY614IYdWC1Ia53N0sT14xOWcATru+Ww+4sxCuHjw24ikg+idoIKmz0YMATqxbu6rflIBGRSt0ELA0CriSp+uCxyrJJEEn/tOS4yFaE3ncdS96Eu50Y875GDpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730470588; c=relaxed/simple;
	bh=HbN9Tc2DvDZuyWjnp1OhvQikIf+Sz8xYcrmXdiycAug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aSgEr1OjPmKDnDvGt7Rx+fWxIpFfTPRTikx0drMQqmoXTZDRgAA5DSM8KVhzlKEYVekIhT34vNkIytRqIpWxxdl91beJTj7ZDVGQgh298HYwArwE/F5n2DXds9trvc1EaLA4NNUzN6W/eseCktmUCdNYO2u2dVVrX3poTmOgLEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=kMbq5D5u; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730470575; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kVEf9La18gUx61NeS/ypACpSeDx1iIBtgSHdQr8OlXV9fgbtxXYqCRudmVnItPieZ5Z1bHTG3azswRiKahVYNvhaHCP3tLC/sJ9KB7oY33norhcr1Cz1xRmbgZ4xvdXEBCtm8yw6NlbBHwCDABwdouGnLiccZ3kNwHBlP2jKUB0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730470575; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=g44Wl7tnRmFijuzlRmhgh38eYyyvVTOHdNmRVeRjRyg=; 
	b=LabxpNW+KExwUo6U+UghWKhnPmVGLfAcqZ9Q+LF8WVLLcO/w/YlBvbBtv8i/q3+xkdit3VB/Dc522ElQ4JLoTCyKaoGKoBWYcOABg7d3al9c9Voe0NS3Yowpi31uqylQrNYUz3sz9lbvHOWbACOVZc2MqQI/RjJsQrH1mfh2Zl8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730470575;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=g44Wl7tnRmFijuzlRmhgh38eYyyvVTOHdNmRVeRjRyg=;
	b=kMbq5D5uY0xiYgLnuuV4gUtAEAznDJq+y9o+YsskO2il0WL/lMICQebmbpO6f4ts
	WBGoM7MI9wLhHV0iKKzSTjyFS2EGmLcn+ptzGzu1YVYWSazyrCpWpogUiANkkvprRM5
	W6BfF8TpgnSEebJl9XZgUXTcDK1mf6WvLgue0WBM=
Received: by mx.zohomail.com with SMTPS id 1730470574622616.129871650149;
	Fri, 1 Nov 2024 07:16:14 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: hugetlb_dio: Check for initial conditions to skip in the start
Date: Fri,  1 Nov 2024 19:15:57 +0500
Message-Id: <20241101141557.3159432-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The test should be skipped if initial conditions aren't fulfilled in
the start instead of failing and outputting non-compliant TAP logs. This
kind of failure pollutes the results. The initial conditions are:
- The test should only execute if /tmp file can be allocated.
- The test should only execute if huge pages are free.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Before:
TAP version 13
1..4
Bail out! Error opening file
: Read-only file system (30)
 # Planned tests != run tests (4 != 0)
 # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0

After:
TAP version 13
1..0 # SKIP Unable to allocate file: Read-only file system
---
 tools/testing/selftests/mm/hugetlb_dio.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/hugetlb_dio.c b/tools/testing/selftests/mm/hugetlb_dio.c
index f9ac20c657ec6..60001c142ce99 100644
--- a/tools/testing/selftests/mm/hugetlb_dio.c
+++ b/tools/testing/selftests/mm/hugetlb_dio.c
@@ -44,13 +44,6 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
 	if (fd < 0)
 		ksft_exit_fail_perror("Error opening file\n");
 
-	/* Get the free huge pages before allocation */
-	free_hpage_b = get_free_hugepages();
-	if (free_hpage_b == 0) {
-		close(fd);
-		ksft_exit_skip("No free hugepage, exiting!\n");
-	}
-
 	/* Allocate a hugetlb page */
 	orig_buffer = mmap(NULL, h_pagesize, mmap_prot, mmap_flags, -1, 0);
 	if (orig_buffer == MAP_FAILED) {
@@ -94,8 +87,20 @@ void run_dio_using_hugetlb(unsigned int start_off, unsigned int end_off)
 int main(void)
 {
 	size_t pagesize = 0;
+	int fd;
 
 	ksft_print_header();
+
+	/* Open the file to DIO */
+	fd = open("/tmp", O_TMPFILE | O_RDWR | O_DIRECT, 0664);
+	if (fd < 0)
+		ksft_exit_skip("Unable to allocate file: %s\n", strerror(errno));
+	close(fd);
+
+	/* Check if huge pages are free */
+	if (!get_free_hugepages())
+		ksft_exit_skip("No free hugepage, exiting\n");
+
 	ksft_set_plan(4);
 
 	/* Get base page size */
-- 
2.39.5


