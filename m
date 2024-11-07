Return-Path: <linux-kselftest+bounces-21618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C759C08A4
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 15:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0645C1C23150
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA92212F0E;
	Thu,  7 Nov 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cJw0WTWn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34D212EFC;
	Thu,  7 Nov 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988819; cv=none; b=ExazhsUarq/aLmSV4wxma0HmzUZLsB8VO08cvIX481jEZZWRguvJxzNgC+QqzN0W9Q9po4CXA70w2VNkspkPeRuiNL0dCAAZWkTtqF7jPzdu4yFVn3OF9/+rKOSIycYQ40vW1me7iVngHuucFf6fFihSN0mzvkH1nGQkDxYCOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988819; c=relaxed/simple;
	bh=0Akm99fiUjDLQWjgdtQxgIzIU4uZqg4GICm+FUUmUrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWfFF2MHgPRMYSzn/Mxj5CW6Vj4INFrV/hNSXvIMNSwg4UK7LBmcAqc7aS/iOya3RGv1hWer++fXBvn2ByHFeOdNg1QtKI71R9oFlTRxQ29dN4QLYqTidg2uRlH0s+BhixTMpgmhJw3d2eVVZ+J70gFjgyirxEDxGo0T1NdWJL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cJw0WTWn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7E9ujb031318;
	Thu, 7 Nov 2024 14:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=XCx6W3n9SVzNXJdyU
	8z+Gfygwq4oHLz88kpgVI2eLc0=; b=cJw0WTWnTuldImspDCWPMNnD86tjqP+JC
	WE36T9fI+vTc0dVNNIh24SBT9waA/YuOohV9DD2P1A5Hs2fwC2AIOf2x+iOaJPqI
	RsM68eHsNVkDAbqY4SNfuJaABtq+HmRg++TvCKYrcQ1BSDfaptzaivVK2HIjlFLf
	3nhCcMJnThw1gKKIC1cxUD0QK6Sg1oI1lFPv3Pecn4/n1VF0fyy88RApV4N2XOgu
	7g0JYGuOlwdpVMhMDOVZtoUEj78OupYlkhY7WUpVxs+4v1ucJmNtGOZMD56zdh/G
	OdU4WT3DLQtElcpkQAhcfzmgc/5xZSJxgg94POQddmAGcu2PrJMuA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rxmrr4m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:10:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7CdeHF024242;
	Thu, 7 Nov 2024 14:10:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsyydvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:10:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7EAZRV47186370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 14:10:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED8B720040;
	Thu,  7 Nov 2024 14:10:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0F3720049;
	Thu,  7 Nov 2024 14:10:34 +0000 (GMT)
Received: from darkmoore.boeblingen.de.ibm.com (unknown [9.152.222.253])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 14:10:34 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v7 5/5] selftests: kvm: s390: correct IP.b length in uc_handle_sieic debug output
Date: Thu,  7 Nov 2024 15:10:24 +0100
Message-ID: <20241107141024.238916-6-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107141024.238916-1-schlameuss@linux.ibm.com>
References: <20241107141024.238916-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: izty_Qe93jeS9L-krbVGxPLrytEKAD27
X-Proofpoint-GUID: izty_Qe93jeS9L-krbVGxPLrytEKAD27
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 mlxlogscore=620 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070110

The length of the interrupt parameters (IP) are:
a: 2 bytes
b: 4 bytes

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/ucontrol_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index 71e76337d9dc..549021ada4d2 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -375,7 +375,7 @@ static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) *self)
 	struct kvm_run *run = self->run;
 
 	/* check SIE interception code */
-	pr_info("sieic: 0x%.2x 0x%.4x 0x%.4x\n",
+	pr_info("sieic: 0x%.2x 0x%.4x 0x%.8x\n",
 		run->s390_sieic.icptcode,
 		run->s390_sieic.ipa,
 		run->s390_sieic.ipb);
-- 
2.47.0


