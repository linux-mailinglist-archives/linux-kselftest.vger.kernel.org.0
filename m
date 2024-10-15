Return-Path: <linux-kselftest+bounces-19715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC47299E14B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 10:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8669F2826D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230231D89ED;
	Tue, 15 Oct 2024 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PD9td/OJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC081CF296;
	Tue, 15 Oct 2024 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728981481; cv=none; b=GuxEj/hHOIqbLlnJKtHrlM90zC/xps3TtzobOBuKf6/LysF/1cb9inuYzclJo6qXHLbmgAhrJGxYQfDbAt+Bu7eOAXt6PbMLphDlThU7GZMfbzKohUDzrggUnSPmDEfgup8caOsIeAA/7c+eHQkV3OTmWEfs8zVXre3yQjfb5pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728981481; c=relaxed/simple;
	bh=lxyiRdAloX3OMwJi5pTglGoCGM/S9e+/s2470fayYg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eX61ldTKdpDeyVl9IkMyXYylEB0HzdGQy4e6cbNCnDznKfqN6AAQH4X5A3gaKkMg/sxQuFbvHOoi+jE33ntuGfsDNwMzyYDut45DDxefSzm5DQa8uoTMbzBpiZpngh8yCtuBCKF4+4UneYvzZ+upM8HEqxvztsISC6eEaVD6dg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PD9td/OJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7ssZ7022825;
	Tue, 15 Oct 2024 08:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Nr8izOCpgTUdj+cim
	Z1bZNzQeDkN9UIFAqAPWglx36Y=; b=PD9td/OJLZ47mfzNXsqdAS2LPekxuaxVt
	M7C3HNVoylMIhZ6S1H+Z3t8uLLqU9KDE1IzpoXMYuY0HVRi4WmYmuDUgtzOLGkqN
	LpEQ/Sdo98xG5qYsARhWrphS5IGxjxKxbHCxc0n8Zr8eba+65ZhmBSZwZq1BhNmT
	ghj81p7gOuP6AUCdHgUuuqzDlIzDwH4JfX0AcdHek80xvhPdh+TVhbZs+LB63Zf+
	X8yRPEGeHQgHYjliIfII8Wg53TH+1uEINP8H+qHu387/B9kXRhX+LoJ7TBMGbWWr
	V9pswrCSMYVG2KIv4ut16bmOrDJ1T6NoPVRoLDR3xhYlqEDliT+KA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429me106jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:56 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49F8btX8026762;
	Tue, 15 Oct 2024 08:37:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429me106jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F8GaPs006415;
	Tue, 15 Oct 2024 08:37:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4284xk2nqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:37:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49F8bpng36307216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 08:37:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29AA420040;
	Tue, 15 Oct 2024 08:37:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93EC420043;
	Tue, 15 Oct 2024 08:37:50 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.49.63])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Oct 2024 08:37:50 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, schlameuss@linux.ibm.com
Subject: [PATCH v6 5/5] selftests: kvm: s390: correct IP.b length in uc_handle_sieic debug output
Date: Tue, 15 Oct 2024 10:37:44 +0200
Message-ID: <20241015083744.761838-6-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015083744.761838-1-schlameuss@linux.ibm.com>
References: <20241015083744.761838-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7vuRUO0c8Red2-_bTbFu0SKfknQtwUJX
X-Proofpoint-ORIG-GUID: VFSZaH-J4TsYtrZEZBy6uif2vDCFZQvA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=684 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410150056

The length of the interrupt parameters (IP) are:
a: 2 bytes
b: 4 bytes

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/ucontrol_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index db8776269373..e69e22504428 100644
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


