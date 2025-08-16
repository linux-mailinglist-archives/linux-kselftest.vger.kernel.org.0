Return-Path: <linux-kselftest+bounces-39135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE6AB28A6E
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 06:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FDE1CC2AAC
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Aug 2025 04:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD11B040B;
	Sat, 16 Aug 2025 04:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VUjdM7Bi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181F115624D;
	Sat, 16 Aug 2025 04:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755316930; cv=none; b=c/yu+2VieDnLKk38mWMkhqjXDMaB7hfVrRiTehcnWyyP+kOPMe7F2V8/6Rmwe050y2mmsbMAXtZgnu5EWEYsB4nkGFq55Vd3SL+ZUBzuvs8DvidChXoHIW22QC/zl/kQf8Lwb5d1ztFl+q1y7DPDHbSuOwjayj0PDgoLDdjFKII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755316930; c=relaxed/simple;
	bh=PS5Pfnsgzf+EBcCoRTm3hzeeJC5U1+mDDWHbdD+JVCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FdeFOCrgkzyxMsOsAMjiVixe8/dBl24H3ssprPIxGlSWDUv/EBS8aBTptG/injXvNqrBo74p2F3HfA8pXIoKpfR8/tqzxgto9eWxgCxGpGnkzVe8PKfPViB/bzEY/JGPZw/3LSLDhFYYZkgLYyhrHS337+zoAKnrRQVsHalZr4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VUjdM7Bi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G30C6H027452;
	Sat, 16 Aug 2025 04:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YaS8eetIOBTsJvP2L
	Rw1VSFkVozD05zxymGqu38YCZ8=; b=VUjdM7BiI3qlX2BRakrkYOL/lQsK05Zrj
	02ZQU4n5iMGmfuNAL5gnSeEkK7jSv/fWPI+ykTgPqZoEWIvLpmUUdWclGV8ECJd6
	jIpx9ovfBX9qef8gqWzDgQaYVxBhKtXXg3O5cr7V2JTgY0gAo0Yp6U1Qxn8BOg43
	HRikfbrptfcfZycl/mIPgy8OkX+ZeEpH9Hwe4PmQaiI2uU8AXL/bmQecJh8crxRa
	7HrVKcar3TNS6G0N5vdnBuQ/tpyK7BC7IPJRLq7Aa53eMGl0yYdnYGdUXpCExiBL
	JKdUMtH6Nb8gmqQpfji+xdyYDQDpQbj5JuejQvT+WkTxPyuChFAyg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhnxr44k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:01:45 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57G41iQ1003014;
	Sat, 16 Aug 2025 04:01:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jhnxr44g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:01:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57G37Mkj017581;
	Sat, 16 Aug 2025 04:01:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc43f75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Aug 2025 04:01:43 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57G41e6R52953414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Aug 2025 04:01:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CA0020043;
	Sat, 16 Aug 2025 04:01:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1688220040;
	Sat, 16 Aug 2025 04:01:29 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.36.5.210])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 Aug 2025 04:01:28 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: akpm@linux-foundation.org, Liam.Howlett@oracle.com,
        lorenzo.stoakes@oracle.com, shuah@kernel.org, pfalcato@suse.de,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        baohua@kernel.org, richard.weiyang@gmail.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, donettom@linux.ibm.com,
        ritesh.list@gmail.com, aboorvad@linux.ibm.com
Subject: [PATCH v4 1/7] mm/selftests: Fix incorrect pointer being passed to mark_range()
Date: Sat, 16 Aug 2025 09:31:07 +0530
Message-ID: <20250816040113.760010-2-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816040113.760010-1-aboorvad@linux.ibm.com>
References: <20250816040113.760010-1-aboorvad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XbqJzJ55 c=1 sm=1 tr=0 ts=68a002a9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8
 a=Ikd4Dj_1AAAA:8 a=Jsdhh-2Z5yyD8EuTVZ4A:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: rQIx0Wj7JcxnF7kaPSlheNKjBHxiBHHy
X-Proofpoint-GUID: SyqJ54v-8eGbNXwKAE_xeczvg8BQXYhR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNyBTYWx0ZWRfXxQ5raNDnLApF
 pHE0+1uAahT2+Mn98eDgUtrIvKf/7HKqmhOPvzcPG5dD6I2XscA35eiCuq1LeBlPVWQM+sDf03q
 poGa67cP1mQsGmRckkEqJz53HIK/NLlbFeGIwXKOn4BrBTY6RXPVzJAP7cP+hrz0Q/TETWVp9ih
 ewee+qxWhwl4k7fUgeZxObu2ywgI1KSbbYqgNSbD4Jd6+71n9TXEr8eKeiYevZij/j0UQvpjMqw
 KarYVLW9wTvMAbq8YO/2PrIi9+CktxzP4H1DprWcYGX4DwMcuxnDYBRB1uIzZNoR3Dua+NwQovA
 c8Y4FIRp6W0sdo+lYKUXN+xPoTKSVWrKlM4fdYjwHUGa9kOr/zyzhTZdpvY3iZn/fSG7SryiFi5
 M5SxyOmA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160027

From: Donet Tom <donettom@linux.ibm.com>

In main(), the high address is stored in hptr, but for mark_range(),
the address passed is ptr, not hptr. Fixed this by changing ptr[i] to
hptr[i] in mark_range() function call.

Fixes: b2a79f62133a ("selftests/mm: virtual_address_range: unmap chunks after validation")
Co-developed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 tools/testing/selftests/mm/virtual_address_range.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 3c21d136962c..e7ef6759baa1 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -227,7 +227,7 @@ int main(void)
 		if (hptr[i] == MAP_FAILED)
 			break;
 
-		mark_range(ptr[i], MAP_CHUNK_SIZE);
+		mark_range(hptr[i], MAP_CHUNK_SIZE);
 		validate_addr(hptr[i], 1);
 	}
 	hchunks = i;
-- 
2.47.1


