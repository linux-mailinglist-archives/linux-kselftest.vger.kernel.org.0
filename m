Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453F01CB651
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 19:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgEHRte (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 13:49:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHRte (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 13:49:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 048HZSDB178919;
        Fri, 8 May 2020 13:49:26 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30vtwcuwn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 13:49:26 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 048HafCJ181657;
        Fri, 8 May 2020 13:49:26 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30vtwcuwmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 13:49:25 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 048Hj59M027627;
        Fri, 8 May 2020 17:49:24 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 30s0g5wu7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 May 2020 17:49:24 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 048HnLFm63504400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 May 2020 17:49:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58BD0AE045;
        Fri,  8 May 2020 17:49:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFD87AE04D;
        Fri,  8 May 2020 17:49:19 +0000 (GMT)
Received: from fir03.in.ibm.com (unknown [9.121.59.65])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 May 2020 17:49:19 +0000 (GMT)
From:   Sandipan Das <sandipan@linux.ibm.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com,
        aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com,
        mpe@ellerman.id.au, fweimer@redhat.com
Subject: [PATCH 2/2] selftests: vm: pkeys: Fix powerpc access right updates
Date:   Fri,  8 May 2020 23:19:15 +0530
Message-Id: <5f65cf37be993760de8112a88da194e3ccbb2bf8.1588959697.git.sandipan@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1588959697.git.sandipan@linux.ibm.com>
References: <cover.1588959697.git.sandipan@linux.ibm.com>
In-Reply-To: <cover.1588959697.git.sandipan@linux.ibm.com>
References: <cover.1588959697.git.sandipan@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-08_15:2020-05-08,2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=1 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2005080144
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The Power ISA mandates that all writes to the Authority
Mask Register (AMR) must always be preceded as well as
succeeded by a context-synchronizing instruction. This
applies to both the privileged and unprivileged variants
of the Move To AMR instruction.

Fixes: 130f573c2a79 ("selftests/vm/pkeys: introduce powerpc support")
Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
---
 tools/testing/selftests/vm/pkey-powerpc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/pkey-powerpc.h b/tools/testing/selftests/vm/pkey-powerpc.h
index eb5077de8f1e..1ebb586b2fbc 100644
--- a/tools/testing/selftests/vm/pkey-powerpc.h
+++ b/tools/testing/selftests/vm/pkey-powerpc.h
@@ -55,7 +55,8 @@ static inline void __write_pkey_reg(u64 pkey_reg)
 	dprintf4("%s() changing %016llx to %016llx\n",
 			 __func__, __read_pkey_reg(), pkey_reg);
 
-	asm volatile("mtspr 0xd, %0" : : "r" ((unsigned long)(amr)) : "memory");
+	asm volatile("isync; mtspr 0xd, %0; isync"
+		     : : "r" ((unsigned long)(amr)) : "memory");
 
 	dprintf4("%s() pkey register after changing %016llx to %016llx\n",
 			__func__, __read_pkey_reg(), pkey_reg);
-- 
2.17.1

