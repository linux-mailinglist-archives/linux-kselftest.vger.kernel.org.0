Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5CF19E792
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Apr 2020 22:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgDDUhl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Apr 2020 16:37:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbgDDUhl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Apr 2020 16:37:41 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 034KYBsa131082
        for <linux-kselftest@vger.kernel.org>; Sat, 4 Apr 2020 16:37:40 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 306pajtj2t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Sat, 04 Apr 2020 16:37:40 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <svens@linux.ibm.com>;
        Sat, 4 Apr 2020 21:37:16 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 4 Apr 2020 21:37:12 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 034KbXCW29360514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 4 Apr 2020 20:37:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5613BAE053;
        Sat,  4 Apr 2020 20:37:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44897AE051;
        Sat,  4 Apr 2020 20:37:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  4 Apr 2020 20:37:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id D72D3E0193; Sat,  4 Apr 2020 22:37:32 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     svens@stackframe.org, Thomas Gleixner <tglx@linutronix.de>,
        Steve Winslow <swinslow@gmail.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 1/2] selftests/vDSO: prevent SIGFPE if vdso_info.nbucket is zero
Date:   Sat,  4 Apr 2020 22:37:03 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20040420-0020-0000-0000-000003C1A6A6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040420-0021-0000-0000-0000221A5B3D
Message-Id: <20200404203704.69412-1-svens@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-04_17:2020-04-03,2020-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=860
 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004040185
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If vdso_info can't be parsed correctly, vdso_info.nbucket might
contain zero. Add a check and return NULL which will fail the
symbol lookup.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 tools/testing/selftests/vDSO/parse_vdso.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 1dbb4b87268f..8e5a70a24d9a 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -226,6 +226,9 @@ void *vdso_sym(const char *version, const char *name)
 		return 0;
 
 	ver_hash = elf_hash(version);
+	if (!vdso_info.nbucket)
+		return NULL;
+
 	ELF(Word) chain = vdso_info.bucket[elf_hash(name) % vdso_info.nbucket];
 
 	for (; chain != STN_UNDEF; chain = vdso_info.chain[chain]) {
-- 
2.17.1

