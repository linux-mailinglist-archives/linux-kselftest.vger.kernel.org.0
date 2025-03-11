Return-Path: <linux-kselftest+bounces-28701-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2805EA5BAF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 09:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619C53AE8C2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5671F2253E4;
	Tue, 11 Mar 2025 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MRSacfzG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C436C223704
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741682530; cv=none; b=npd1QIRtw6dByNoOg6giogT2ls5hx80uOzvzpxlUNXmxs/Uw9oEPU1LFoSmnwGvG+uCY5XrUck1E1Ud106Ec7FKX08lhNuIMmoftzz38dzjjRtHiJEQj41B/uYgPKi9sRwEsmZEL8/ZtLYKh7yGZGHwAt0o63/wIkahhT+BL61g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741682530; c=relaxed/simple;
	bh=M+Aj8Hu8pTKkJbOOGW0ujiPM31CYtzdPsBt/j7I0ZTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J0/ZClGhlv5bHc916sAETKPB2lbdgdnnFZGZp1COahKV/Qw6RjSIcjt0KmP33yzi9OZ4hWEkxrqhOBZXdHYcgFuF3ZP+hte3pDcbgLY3zC/hkIZUcOh21LBuLMqSsQvQu+m0tYVnhdEg+2HWdf35TP5hBtr12J0cxVdxvwIcxFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MRSacfzG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKFblq016033;
	Tue, 11 Mar 2025 08:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=R7l+S7unw8HaDq3ycvl5vpv+2cv+
	Okn+aN2afRCN2Hs=; b=MRSacfzGOrk8njYP7aTBskXEB51mu73CoEhJVkDYsQ/A
	KtFVUoKch8E394WpLPC/T9eRnQxX7joEfxf6ebHwy2SxCAS8jCYvOSNh/0xJUO1R
	vPwDmdWLLjYPVFj98jaqoTvbpHVcM6BSgkSVsV2PLuzQuyXhZ2xuAkliJ/fH0GXp
	Ay9uBz4KSRBEgd7i2DR7RNsbYvVv0z4F1dAPOEl/6Pc8u6/OJ10YsNaWNRf88gxW
	3aUmBbDBTA2uNl6CDaB/zgrPgucDpxrgWfoqBzG5EvmCELMjyiFpelDBouXf54q0
	W4W8m0ZR/hGzi+J7MwnEeihxvYDO9ky+Y9l323dzsA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a1gp4uj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:41:41 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52B8CLRd007304;
	Tue, 11 Mar 2025 08:41:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a1gp4uj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:41:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52B6ei2x027566;
	Tue, 11 Mar 2025 08:41:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4591qkk508-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 08:41:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52B8fZqN36307332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 08:41:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF4F720049;
	Tue, 11 Mar 2025 08:41:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1395020040;
	Tue, 11 Mar 2025 08:41:33 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.204.206.207])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 08:41:32 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: catalin.marinas@arm.com, shuah@kernel.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, yury.khrustalev@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] selftest/powerpc/mm/pkey: fix build-break introduced by commit 00894c3fc917
Date: Tue, 11 Mar 2025 14:11:29 +0530
Message-ID: <20250311084129.39308-1-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XjiArt6L0DCuKkUNmeos7SdNVMkgrYU4
X-Proofpoint-ORIG-GUID: SRAKZlZkEm18QLdCEcWQrintl1Z8lLK1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_01,2025-03-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 mlxlogscore=631 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110057

Build break was reported in the powerpc mailing list for next-20250218 with below errors

make[1]: Nothing to be done for 'all'.
BUILD_TARGET=/root/venkat/linux-next/tools/testing/selftests/powerpc/mm; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C mm all
  CC       pkey_exec_prot
In file included from pkey_exec_prot.c:18:
/root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h: In function ‘pkeys_unsupported’:
/root/venkat/linux-next/tools/testing/selftests/powerpc/include/pkeys.h:96:34: error: ‘PKEY_UNRESTRICTED’ undeclared (first use in this function)
   96 |         pkey = sys_pkey_alloc(0, PKEY_UNRESTRICTED);
      |                                  ^~~~~~~~~~~~~~~~~

https://lore.kernel.org/all/20250113170619.484698-2-yury.khrustalev@arm.com/ patchset
has been queued to arm64/for-next/pkey_unrestricted which is causing a build break
in the selftest/powerpc builds.

Commit 6d61527d931ba ("mm/pkey: Add PKEY_UNRESTRICTED macro") added a macro
PKEY_UNRESTRICTED to handle implicit literal value of 0x0 (which is "unrestricted").
Add the same to selftest/powerpc/pkeys.h to fix the reported build break.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/lkml/3267ea6e-5a1a-4752-96ef-8351c912d386@linux.ibm.com/T/
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
Catalin, can you take this fix via arm64/for-next/pkey_unrestricted?
Patch applies clean on top of arm64/for-next/pkey_unrestricted

 tools/testing/selftests/powerpc/include/pkeys.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/powerpc/include/pkeys.h b/tools/testing/selftests/powerpc/include/pkeys.h
index c6d4063dd4f6..d6deb6ffa1b9 100644
--- a/tools/testing/selftests/powerpc/include/pkeys.h
+++ b/tools/testing/selftests/powerpc/include/pkeys.h
@@ -24,6 +24,9 @@
 #undef PKEY_DISABLE_EXECUTE
 #define PKEY_DISABLE_EXECUTE	0x4
 
+#undef PKEY_UNRESTRICTED
+#define PKEY_UNRESTRICTED	0x0
+
 /* Older versions of libc do not define this */
 #ifndef SEGV_PKUERR
 #define SEGV_PKUERR	4
-- 
2.48.1


