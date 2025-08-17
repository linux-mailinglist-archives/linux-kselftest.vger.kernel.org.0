Return-Path: <linux-kselftest+bounces-39169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95433B29270
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 11:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A177D20024F
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E45221F26;
	Sun, 17 Aug 2025 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="KnWO6qx+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619E222127D
	for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 09:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755423389; cv=none; b=MGzvdDADqjjskai69d0haAAfRJD9qSHu7Az3OKmgjYkpQKwwGNN+dCagky9EJrtAgmRZv0Il9U5Ypse+pPgm05mrraS0X3J5ZUPJQDZy8Qij0eaEmVUjPzZb8qPTQGHBwaPhmOu/zibdT72uMe1TSsM18EbxmuEqgSNdTEDbZ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755423389; c=relaxed/simple;
	bh=QUVIStTkAQtgw3rORRQT/eO6z9COm4pxchQ0/kMZ11U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UslwIjv6cNxjDohcuHwOPPPGuH5ClS9pbd5ezew30v+GV3vWd2PXLyCp9L82cb8XwFJ4AENUPs0ESlEC4L5CFIeV/CfSnpA29Zhd2HhZwUlf5hJMag83N0+VXVKMaJ1AXM2RT1SuIPVRSbn1odU75K9lkCKZt4AiCSoR06d+k5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=KnWO6qx+; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id F0595104CFE4
	for <linux-kselftest@vger.kernel.org>; Sun, 17 Aug 2025 15:06:13 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in F0595104CFE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1755423373; bh=QUVIStTkAQtgw3rORRQT/eO6z9COm4pxchQ0/kMZ11U=;
	h=Date:From:To:Cc:Subject:From;
	b=KnWO6qx+3Omav/kQlEIbycpae23KbLgMyA2EFv9K2qZ9vJAtFXy7YxgYqR/tXlik0
	 Wqa4pnhpBPmE67nb+13+G8BdzF9Y3qJq6QMlrmWoOW2fZ1MaWfrJDN+KS2gbYGZo8n
	 evRHblvmZl0u9LstCebco9g3mI6Q+Z5/sA5tH760=
Received: (qmail 9060 invoked by uid 510); 17 Aug 2025 15:06:13 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 2.131342 secs; 17 Aug 2025 15:06:13 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 17 Aug 2025 15:06:11 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 5FC76360040;
	Sun, 17 Aug 2025 15:06:11 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id 4AF6E1E812D4;
	Sun, 17 Aug 2025 15:06:11 +0530 (IST)
Date: Sun, 17 Aug 2025 15:06:05 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: ming.lei@redhat.com, shuah@kernel.org, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: [PATCH] selftests: ublk: Use ARRAY_SIZE() macro to improve code
Message-ID: <aKGihYui6/Pcijbk@bhairav-test.ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use ARRAY_SIZE() macro while calculating size of an array to improve
code readability and reduce potential sizing errors.
Implement this suggestion given by spatch tool by running
coccinelle script - scripts/coccinelle/misc/array_size.cocci
Follow ARRAY_SIZE() macro usage pattern in ublk.c introduced by,
commit ec120093180b9 ("selftests: ublk: fix ublk_find_tgt()")
wherever appropriate to maintain consistency.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
Testing:
* build checked for testing/selftests/ublk
* tested by running 
	$ ./kublk --help
Which exercises the impacted code path.

 tools/testing/selftests/ublk/kublk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 95188065b2e9..6512dfbdbce3 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1400,7 +1400,7 @@ static int cmd_dev_get_features(void)
 
 			if (!((1ULL << i)  & features))
 				continue;
-			if (i < sizeof(feat_map) / sizeof(feat_map[0]))
+			if (i < ARRAY_SIZE(feat_map))
 				feat = feat_map[i];
 			else
 				feat = "unknown";
@@ -1477,7 +1477,7 @@ static void __cmd_create_help(char *exe, bool recovery)
 	printf("\tdefault: nr_queues=2(max 32), depth=128(max 1024), dev_id=-1(auto allocation)\n");
 	printf("\tdefault: nthreads=nr_queues");
 
-	for (i = 0; i < sizeof(tgt_ops_list) / sizeof(tgt_ops_list[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(tgt_ops_list); i++) {
 		const struct ublk_tgt_ops *ops = tgt_ops_list[i];
 
 		if (ops->usage)
-- 
2.34.1


