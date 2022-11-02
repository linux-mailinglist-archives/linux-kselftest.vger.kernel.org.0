Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49676164B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 15:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiKBORG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 10:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiKBORE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 10:17:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6805524F33;
        Wed,  2 Nov 2022 07:17:02 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2DnHl3025642;
        Wed, 2 Nov 2022 14:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=rBcOVcE8p21SjX59jNF12Bk39Ytjo9izhdBtdZz+66s=;
 b=bbQIQfrX18ZUfgygUq5meDRQ5C0f+8f0GGhYNXEvICoPz0Bfl8JC6huWw6GhxVK+hGJs
 ci80ejKo7ct9b+JaYrbijnXZjRl21JqM+aNnflEiqWL/3VRdHHZCiPbnaXDw1i/yQjrr
 Ef3XzwVbndNp+2Viu46Mw1Q5uy4ERmZzr4H5BfXKF8Qbr8aXFjsUB/Ttl2WVIX26B8BH
 UMtNOiwMggP8TbDtjfu334MpIkfHP0bpCNeePxQheX/OeerazXE6yDZNDdSKrIIJDuPj
 0jCNkJCc/8+4rc9JKKiPo15mHLh594AIfXArTxbiCrItwIeXngmIaY/XBhVZCDzviwa1 0A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkss69ct5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:16:57 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2DoWgJ031654;
        Wed, 2 Nov 2022 14:16:57 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkss69cky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:16:57 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2E5jfi018093;
        Wed, 2 Nov 2022 14:16:49 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3kgut8n602-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:16:49 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2EHM7244302820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 14:17:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7463AE04D;
        Wed,  2 Nov 2022 14:16:45 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 295FCAE051;
        Wed,  2 Nov 2022 14:16:45 +0000 (GMT)
Received: from osiris (unknown [9.145.56.93])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Nov 2022 14:16:45 +0000 (GMT)
Date:   Wed, 2 Nov 2022 15:16:43 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 1/5] s390/cmpxchg: use symbolic names for inline assembly
 operands
Message-ID: <Y2J7yzQYt/bjLQXY@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
 <20221012205609.2811294-2-scgl@linux.ibm.com>
 <Y2J61LWSV+HolIeT@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2J61LWSV+HolIeT@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -DBb08EzdRP5iJjnt_miWFRpiaZELN8g
X-Proofpoint-ORIG-GUID: qcMSui0K3sancHdTcUItlhp2wAfGu3QK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_10,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxlogscore=702 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make cmpxchg() inline assemblies more readable by using symbolic names
for operands.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/cmpxchg.h | 76 ++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 34 deletions(-)

diff --git a/arch/s390/include/asm/cmpxchg.h b/arch/s390/include/asm/cmpxchg.h
index 84c3f0d576c5..56fb8aa08945 100644
--- a/arch/s390/include/asm/cmpxchg.h
+++ b/arch/s390/include/asm/cmpxchg.h
@@ -96,56 +96,64 @@ static __always_inline unsigned long __cmpxchg(unsigned long address,
 		shift = (3 ^ (address & 3)) << 3;
 		address ^= address & 3;
 		asm volatile(
-			"       l       %0,%2\n"
-			"0:     nr      %0,%5\n"
-			"       lr      %1,%0\n"
-			"       or      %0,%3\n"
-			"       or      %1,%4\n"
-			"       cs      %0,%1,%2\n"
-			"       jnl     1f\n"
-			"       xr      %1,%0\n"
-			"       nr      %1,%5\n"
-			"       jnz     0b\n"
+			"	l	%[prev],%[address]\n"
+			"0:	nr	%[prev],%[mask]\n"
+			"	lr	%[tmp],%[prev]\n"
+			"	or	%[prev],%[old]\n"
+			"	or	%[tmp],%[new]\n"
+			"	cs	%[prev],%[tmp],%[address]\n"
+			"	jnl	1f\n"
+			"	xr	%[tmp],%[prev]\n"
+			"	nr	%[tmp],%[mask]\n"
+			"	jnz	0b\n"
 			"1:"
-			: "=&d" (prev), "=&d" (tmp), "+Q" (*(int *) address)
-			: "d" ((old & 0xff) << shift),
-			  "d" ((new & 0xff) << shift),
-			  "d" (~(0xff << shift))
+			: [prev] "=&d" (prev),
+			  [tmp] "=&d" (tmp),
+			  [address] "+Q" (*(int *)address)
+			: [old] "d" ((old & 0xff) << shift),
+			  [new] "d" ((new & 0xff) << shift),
+			  [mask] "d" (~(0xff << shift))
 			: "memory", "cc");
 		return prev >> shift;
 	case 2:
 		shift = (2 ^ (address & 2)) << 3;
 		address ^= address & 2;
 		asm volatile(
-			"       l       %0,%2\n"
-			"0:     nr      %0,%5\n"
-			"       lr      %1,%0\n"
-			"       or      %0,%3\n"
-			"       or      %1,%4\n"
-			"       cs      %0,%1,%2\n"
-			"       jnl     1f\n"
-			"       xr      %1,%0\n"
-			"       nr      %1,%5\n"
-			"       jnz     0b\n"
+			"	l	%[prev],%[address]\n"
+			"0:	nr	%[prev],%[mask]\n"
+			"	lr	%[tmp],%[prev]\n"
+			"	or	%[prev],%[old]\n"
+			"	or	%[tmp],%[new]\n"
+			"	cs	%[prev],%[tmp],%[address]\n"
+			"	jnl	1f\n"
+			"	xr	%[tmp],%[prev]\n"
+			"	nr	%[tmp],%[mask]\n"
+			"	jnz	0b\n"
 			"1:"
-			: "=&d" (prev), "=&d" (tmp), "+Q" (*(int *) address)
-			: "d" ((old & 0xffff) << shift),
-			  "d" ((new & 0xffff) << shift),
-			  "d" (~(0xffff << shift))
+			: [prev] "=&d" (prev),
+			  [tmp] "=&d" (tmp),
+			  [address] "+Q" (*(int *)address)
+			: [old] "d" ((old & 0xffff) << shift),
+			  [new] "d" ((new & 0xffff) << shift),
+			  [mask] "d" (~(0xffff << shift))
 			: "memory", "cc");
 		return prev >> shift;
 	case 4:
 		asm volatile(
-			"       cs      %0,%3,%1\n"
-			: "=&d" (prev), "+Q" (*(int *) address)
-			: "0" (old), "d" (new)
+			"	cs	%[prev],%[new],%[address]\n"
+			: [prev] "=&d" (prev),
+			  [address] "+Q" (*(int *)address)
+			: "0" (old),
+			  [new] "d" (new)
 			: "memory", "cc");
 		return prev;
 	case 8:
 		asm volatile(
-			"       csg     %0,%3,%1\n"
-			: "=&d" (prev), "+QS" (*(long *) address)
-			: "0" (old), "d" (new)
+			"	csg	%[prev],%[new],%[address]\n"
+			: [prev] "=&d" (prev),
+			  [address] "+QS" (*(long *)address)
+			: "0" (old),
+			  [new] "d" (new)
 			: "memory", "cc");
 		return prev;
 	}
-- 
2.34.1

