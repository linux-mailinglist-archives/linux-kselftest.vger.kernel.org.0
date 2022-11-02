Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B416164CB
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 15:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiKBOSG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 10:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiKBOR5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 10:17:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8154227CC9;
        Wed,  2 Nov 2022 07:17:40 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2E1LYw030940;
        Wed, 2 Nov 2022 14:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=r0ezURG67+JabrkrYwuCQHrDrhSIGXmDG7A3aP0cnlc=;
 b=BWdITT5f2qKrEeMhKg8n4wUbeEjtO2xRn4onnbdqrVcd+hXObM2lOscBAAIa1uoRQJAz
 gLdMV4EXQPJ3btaaAmEUjO56T3291foPCflTKh7cVTeLnzedrb18WRelkJ68/Wx0PKSA
 1CsXHKwVilrcaRtC3trc7CV34/CyRbyJjHIn3t15Cntlq5m8slynZGfySc3kiGRxdpfN
 DW1fNYQswv3i2Kv9o0/r8magIIulE9iHKdCGgQanxMIXRQ2Z0TiCGrTB1NWIPiFRnYA6
 IHMGT2C0xBUTSpUlhGIHYK4uyI7jVuE9KP/9++7Nj7MRGClMTBxwcjVpq2pyclX6jn24 GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkmqfue99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:17:37 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2E1Nqp031195;
        Wed, 2 Nov 2022 14:17:36 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkmqfue6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:17:36 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2E5Qbr020647;
        Wed, 2 Nov 2022 14:17:33 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3kgut9d5yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:17:33 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2EI6AY52101610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 14:18:06 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E137A4053;
        Wed,  2 Nov 2022 14:17:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 874D2A4051;
        Wed,  2 Nov 2022 14:17:29 +0000 (GMT)
Received: from osiris (unknown [9.145.56.93])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Nov 2022 14:17:29 +0000 (GMT)
Date:   Wed, 2 Nov 2022 15:17:28 +0100
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
Subject: [PATCH 2/5] s390/cmpxchg: make variables local to each case label
Message-ID: <Y2J7+HqgAZwnfxsh@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
 <20221012205609.2811294-2-scgl@linux.ibm.com>
 <Y2J61LWSV+HolIeT@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2J61LWSV+HolIeT@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9VrhBqep3GfQVu6F3Vqn6Jcq2GB8Ya4n
X-Proofpoint-ORIG-GUID: wd43Z2fMcPqLszpLrNvYi2xXQvFSOsVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_10,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 mlxlogscore=788 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211020090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make variables local to each case label. This limits the scope of
variables and allows to use proper types everywhere.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/cmpxchg.h | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/cmpxchg.h b/arch/s390/include/asm/cmpxchg.h
index 56fb8aa08945..2ad057b94481 100644
--- a/arch/s390/include/asm/cmpxchg.h
+++ b/arch/s390/include/asm/cmpxchg.h
@@ -88,11 +88,10 @@ static __always_inline unsigned long __cmpxchg(unsigned long address,
 					       unsigned long old,
 					       unsigned long new, int size)
 {
-	unsigned long prev, tmp;
-	int shift;
-
 	switch (size) {
-	case 1:
+	case 1: {
+		unsigned int prev, tmp, shift;
+
 		shift = (3 ^ (address & 3)) << 3;
 		address ^= address & 3;
 		asm volatile(
@@ -115,7 +114,10 @@ static __always_inline unsigned long __cmpxchg(unsigned long address,
 			  [mask] "d" (~(0xff << shift))
 			: "memory", "cc");
 		return prev >> shift;
-	case 2:
+	}
+	case 2: {
+		unsigned int prev, tmp, shift;
+
 		shift = (2 ^ (address & 2)) << 3;
 		address ^= address & 2;
 		asm volatile(
@@ -138,7 +140,10 @@ static __always_inline unsigned long __cmpxchg(unsigned long address,
 			  [mask] "d" (~(0xffff << shift))
 			: "memory", "cc");
 		return prev >> shift;
-	case 4:
+	}
+	case 4: {
+		unsigned int prev;
+
 		asm volatile(
 			"	cs	%[prev],%[new],%[address]\n"
 			: [prev] "=&d" (prev),
@@ -147,7 +152,10 @@ static __always_inline unsigned long __cmpxchg(unsigned long address,
 			  [new] "d" (new)
 			: "memory", "cc");
 		return prev;
-	case 8:
+	}
+	case 8: {
+		unsigned long prev;
+
 		asm volatile(
 			"	csg	%[prev],%[new],%[address]\n"
 			: [prev] "=&d" (prev),
@@ -157,6 +165,7 @@ static __always_inline unsigned long __cmpxchg(unsigned long address,
 			: "memory", "cc");
 		return prev;
 	}
+	}
 	__cmpxchg_called_with_bad_pointer();
 	return old;
 }
-- 
2.34.1

