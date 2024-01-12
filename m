Return-Path: <linux-kselftest+bounces-2895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC64982BB95
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 08:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7861C2094C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jan 2024 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1015B5C1;
	Fri, 12 Jan 2024 07:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mpZdZsKZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377EF14F66;
	Fri, 12 Jan 2024 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705043934;
	bh=1mGvbpuqwHtoANCV1zxPQROR5hRRyjn81bfXlsqdtlk=;
	h=From:To:Cc:Subject:Date:From;
	b=mpZdZsKZk1liMVoBMl9BW48ImM2eycPAcD60OJjUCvQlK3yBVJH7Z1AxTTSwLxwgG
	 E/cHfULVXqZ4C1/JgmbhVPlaRJmmU5XZMgk0TLQKTI8hSrHf7Tlwm2mgVb7uIXua+o
	 naGk5SJNSQ51SHcMvQf8Qn1lBNshBb0v47m7x6sf/3D+oKsw9M5gr7cG/hZQ0UHL0D
	 iRYuwEmRUdJ5A6x7ejfGt1APvGNaQa1GYqmoCANhv4NlWcKyHsK9Ad2m48lQOZnBRz
	 mTXEkc0w88Z6x3owMRt/VMPlqyjk9jq9KlcZrRVzFZxNbrMrnOHatbqFqDz6ZnxIuz
	 LzXSn3s017cgw==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 15AE73780894;
	Fri, 12 Jan 2024 07:18:51 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/mm: mremap_test: fix build warning
Date: Fri, 12 Jan 2024 12:18:50 +0500
Message-ID: <20240112071851.612930-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use 2 separate variables of types int and unsigned long long instead of
confusing them. This corrects the correct print format for each of them
and removes the build warning:

warning: format ‘%d’ expects argument of type ‘int’, but argument 2 has type ‘long long unsigned int’

Fixes: a4cb3b243343 ("selftests: mm: add a test for remapping to area immediately after existing mapping")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Don't just fix the print format, instead use different variables
---
 tools/testing/selftests/mm/mremap_test.c | 27 ++++++++++++------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 1d4c1589c305..2f8b991f78cb 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -360,7 +360,8 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 			      char pattern_seed)
 {
 	void *addr, *src_addr, *dest_addr, *dest_preamble_addr;
-	unsigned long long i;
+	int d;
+	unsigned long long t;
 	struct timespec t_start = {0, 0}, t_end = {0, 0};
 	long long  start_ns, end_ns, align_mask, ret, offset;
 	unsigned long long threshold;
@@ -378,8 +379,8 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 
 	/* Set byte pattern for source block. */
 	srand(pattern_seed);
-	for (i = 0; i < threshold; i++)
-		memset((char *) src_addr + i, (char) rand(), 1);
+	for (t = 0; t < threshold; t++)
+		memset((char *) src_addr + t, (char) rand(), 1);
 
 	/* Mask to zero out lower bits of address for alignment */
 	align_mask = ~(c.dest_alignment - 1);
@@ -420,8 +421,8 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 
 		/* Set byte pattern for the dest preamble block. */
 		srand(pattern_seed);
-		for (i = 0; i < c.dest_preamble_size; i++)
-			memset((char *) dest_preamble_addr + i, (char) rand(), 1);
+		for (d = 0; d < c.dest_preamble_size; d++)
+			memset((char *) dest_preamble_addr + d, (char) rand(), 1);
 	}
 
 	clock_gettime(CLOCK_MONOTONIC, &t_start);
@@ -437,14 +438,14 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 
 	/* Verify byte pattern after remapping */
 	srand(pattern_seed);
-	for (i = 0; i < threshold; i++) {
+	for (t = 0; t < threshold; t++) {
 		char c = (char) rand();
 
-		if (((char *) dest_addr)[i] != c) {
+		if (((char *) dest_addr)[t] != c) {
 			ksft_print_msg("Data after remap doesn't match at offset %llu\n",
-				       i);
+				       t);
 			ksft_print_msg("Expected: %#x\t Got: %#x\n", c & 0xff,
-					((char *) dest_addr)[i] & 0xff);
+					((char *) dest_addr)[t] & 0xff);
 			ret = -1;
 			goto clean_up_dest;
 		}
@@ -453,14 +454,14 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	/* Verify the dest preamble byte pattern after remapping */
 	if (c.dest_preamble_size) {
 		srand(pattern_seed);
-		for (i = 0; i < c.dest_preamble_size; i++) {
+		for (d = 0; d < c.dest_preamble_size; d++) {
 			char c = (char) rand();
 
-			if (((char *) dest_preamble_addr)[i] != c) {
+			if (((char *) dest_preamble_addr)[d] != c) {
 				ksft_print_msg("Preamble data after remap doesn't match at offset %d\n",
-					       i);
+					       d);
 				ksft_print_msg("Expected: %#x\t Got: %#x\n", c & 0xff,
-					       ((char *) dest_preamble_addr)[i] & 0xff);
+					       ((char *) dest_preamble_addr)[d] & 0xff);
 				ret = -1;
 				goto clean_up_dest;
 			}
-- 
2.42.0


