Return-Path: <linux-kselftest+bounces-35093-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CA0ADB62D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF41172A6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD2328689B;
	Mon, 16 Jun 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mKrFUSEX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE3A45C0B;
	Mon, 16 Jun 2025 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090032; cv=none; b=VyvCJ/CK2tAdxJWjAMnhEkIU3VOV7hxSWKI7f2ncHTmA4YOPLPOVF1s9W3tduWx7NM+2HTeXw5H20Ma6gaeRgs9mUnTWCkmHvjUoKgzzHtzf220JBnQ5wWRWb8ihClCwzPP9DOq3GIbm01KoJiDocIJ//NyrbSyjifVPt55cLh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090032; c=relaxed/simple;
	bh=2zRcQizOM4ntY0YZSkZU9ZEFZSs4ck7HXXAIL7uXvDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLwC5JCy7K23NnV4KmqJUh3yl7J2TowVCXT3gRkb7Z3T+gkzFhdnc+D0BEuuPUEJ7kR/pNZPRkQJbuxC26wp26uxRIVJ2B/qnjW9bGlkes+8KH/+tExlxQ+ZPGI978jBw4iBbmOjY5pUTN4ajvbIPTH/9F/l2mTIR3cYcDu7pCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mKrFUSEX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G84HVG014238;
	Mon, 16 Jun 2025 16:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gnb8gT4f9/b+H6cn3
	hiFT7Ob32zrk4dZrwq1ZTZHFkU=; b=mKrFUSEXI4g/5YlUynL6xARLlxvoHpDpr
	GcuyRmQnKjgO2YosAvoUrfXqMQ9QtJGYxmOjrdOKoCtp5IzrA9d0hiqnwUU1kYI9
	/zZUpGnm7JiK4nfswyNEoI99msAjwisqmPlT9Tvydvjf8zOd3AQchPVwTeh4HQAM
	rfW4eSBKOcOS12pAQOz1ewT5537raGy3ZXmVEWw52vfnCQY46ahFMhSCzYML91ok
	C4c/cLQo+gpeE3RZYVBSDrNFpmxr4wl4Yks2ND59rC9V6LScM4Ux9hqlrRrgfkbJ
	zQP0Y4yyBUOBqg0je1geY1Ug1aGPxd5tNki6iO3ZW8LTt0apMQt+A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn2vrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:06:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55GFumVA020812;
	Mon, 16 Jun 2025 16:06:50 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 478ygn2vrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:06:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GEXo5r014278;
	Mon, 16 Jun 2025 16:06:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 479p426he5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 16:06:49 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GG6kEI55640444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 16:06:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DD7020043;
	Mon, 16 Jun 2025 16:06:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8EDD20040;
	Mon, 16 Jun 2025 16:06:40 +0000 (GMT)
Received: from li-c18b6acc-24ee-11b2-a85c-81492619bda1.ibm.com.com (unknown [9.43.33.110])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Jun 2025 16:06:40 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH 1/6] mm/selftests: Fix virtual_address_range test issues.
Date: Mon, 16 Jun 2025 21:36:27 +0530
Message-ID: <20250616160632.35250-2-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616160632.35250-1-aboorvad@linux.ibm.com>
References: <20250616160632.35250-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDEwMiBTYWx0ZWRfX7L2TRUDsmRl/ /89I6QgAP3J0o6JXB66T3RtTOFDbAb7PH743/bnWGmFK+hkjXgTEZnMAYnGS914Gf36OgiaQpLy VvKE05H7HeNBHfc71cGGuxpzgQuevp59Hnvt7UldyUBc8ooeVxOoudSrJymltjeS6MdIP8vL9Mc
 9lyivoEGcoC2s3zNUiXIThEZPNFhy+1BdGokk8vd0mpMVD12vq+ADQnL+BgEXWSlro6lHlWStQy LRJkUq3QnC+XeYXt83TvxYwXnlvX3KR8XR8Fq6O1W6daMG8Re5SIYryLjMTONI0Scea+AGpYXIM D/u+04szly/omVCtF+1Kp0xdefQPO4QnleDCuVbRlGppOLlFoq6V5ei/of/0yi0YgP+jITp/Bjz
 1pjUXN6m6suo7COlrs//rDc3kgf4EcQ0IKWaublSwfZ6UrOJamcX9074Hk4vX7IV2DStmci6
X-Authority-Analysis: v=2.4 cv=fYSty1QF c=1 sm=1 tr=0 ts=6850411b cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=0_35Z4S1ohBUcDDc-C8A:9
X-Proofpoint-ORIG-GUID: guKlIXlpthdCmbceel_anr-JnwHYfwfF
X-Proofpoint-GUID: R_JBOrA5584VdThZW0qVwm_HUw4E4Mtb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160102

From: Donet Tom <donettom@linux.ibm.com>

In this patch, we are fixing three issues in the virtual_address_range
test.

1. validate_addr() checks if the allocated address is within the range.
In the current implementation, if addr is greater than HIGH_ADDR_MARK,
the test fails. However, addr will be greater than HIGH_ADDR_MARK if
high_addr is set. Therefore, if high_addr is set, we should not check
the (addr > HIGH_ADDR_MARK) condition.

2.In main(), the high address is stored in hptr, but for mark_range(),
the address passed is ptr, not hptr. Fixed this by changing ptr[i] to
hptr[i] in mark_range() function call.

3./proc/self/maps may not always have gaps smaller than MAP_CHUNK_SIZE.
The gap between the first high address mapping and the previous mapping
is not smaller than MAP_CHUNK_SIZE.

$cat /proc/3713/maps
10000000-10010000 r-xp 00000000 fd:00 36140094
10010000-10020000 r--p 00000000 fd:00 36140094
10020000-10030000 rw-p 00010000 fd:00 36140094
4ee80000-4eeb0000 rw-p 00000000 00:00 0
578f0000-57c00000 rw-p 00000000 00:00 0
57c00000-7fff97c00000 r--p 00000000 00:00 0
7fff97c00000-7fff97e20000 r-xp 00000000 fd:00 33558923
7fff97e20000-7fff97e30000 r--p 00220000 fd:00 33558923
7fff97e30000-7fff97e40000 rw-p 00230000 fd:00 33558923
7fff97f40000-7fff98020000 r-xp 00000000 fd:00 33558924
7fff98020000-7fff98030000 r--p 000d0000 fd:00 33558924
7fff98030000-7fff98040000 rw-p 000e0000 fd:00 33558924
7fff98050000-7fff98090000 r--p 00000000 00:00 0
7fff98090000-7fff980a0000 r-xp 00000000 00:00 0
7fff980a0000-7fff980f0000 r-xp 00000000 fd:00 2634
7fff980f0000-7fff98100000 r--p 00040000 fd:00 2634
7fff98100000-7fff98110000 rw-p 00050000 fd:00 2634
7fffcf8a0000-7fffcf9b0000 rw-p 00000000 00:00 0
1000000000000-1000040000000 r--p 00000000 00:00 0   --> High Addr
2000000000000-2000040000000 r--p 00000000 00:00 0
4000000000000-4000040000000 r--p 00000000 00:00 0
8000000000000-8000040000000 r--p 00000000 00:00 0
e800098110000-fffff98110000 r--p 00000000 00:00 0
$

In this patch, the condition that checks for gaps smaller than MAP_CHUNK_SIZE has been removed.

Fixes: d1d86ce28d0f ("selftests/mm: virtual_address_range: conform to TAP format output")
Fixes: b2a79f62133a ("selftests/mm: virtual_address_range: unmap chunks after validation")
Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 tools/testing/selftests/mm/virtual_address_range.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index b380e102b22f..606e601a8984 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -80,7 +80,7 @@ static void validate_addr(char *ptr, int high_addr)
 	if (high_addr && addr < HIGH_ADDR_MARK)
 		ksft_exit_fail_msg("Bad address %lx\n", addr);
 
-	if (addr > HIGH_ADDR_MARK)
+	if (!high_addr && addr > HIGH_ADDR_MARK)
 		ksft_exit_fail_msg("Bad address %lx\n", addr);
 }
 
@@ -117,7 +117,7 @@ static int validate_lower_address_hint(void)
 
 static int validate_complete_va_space(void)
 {
-	unsigned long start_addr, end_addr, prev_end_addr;
+	unsigned long start_addr, end_addr;
 	char line[400];
 	char prot[6];
 	FILE *file;
@@ -134,7 +134,6 @@ static int validate_complete_va_space(void)
 	if (file == NULL)
 		ksft_exit_fail_msg("cannot open /proc/self/maps\n");
 
-	prev_end_addr = 0;
 	while (fgets(line, sizeof(line), file)) {
 		const char *vma_name = NULL;
 		int vma_name_start = 0;
@@ -151,12 +150,6 @@ static int validate_complete_va_space(void)
 		if (start_addr & (1UL << 63))
 			return 0;
 
-		/* /proc/self/maps must have gaps less than MAP_CHUNK_SIZE */
-		if (start_addr - prev_end_addr >= MAP_CHUNK_SIZE)
-			return 1;
-
-		prev_end_addr = end_addr;
-
 		if (prot[0] != 'r')
 			continue;
 
@@ -223,8 +216,7 @@ int main(int argc, char *argv[])
 
 		if (hptr[i] == MAP_FAILED)
 			break;
-
-		mark_range(ptr[i], MAP_CHUNK_SIZE);
+		mark_range(hptr[i], MAP_CHUNK_SIZE);
 		validate_addr(hptr[i], 1);
 	}
 	hchunks = i;
-- 
2.43.5


