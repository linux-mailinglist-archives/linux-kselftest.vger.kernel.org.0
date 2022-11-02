Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FFE6164D2
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 15:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiKBOSu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 10:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiKBOSe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 10:18:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882BCC2C;
        Wed,  2 Nov 2022 07:18:20 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2DU4CX013125;
        Wed, 2 Nov 2022 14:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=YFTsEs3iYkeJ11zwWAGSuW0qerFlwmfOZMncpGF0Qi4=;
 b=DjsVnYFZzAtZ0sV3WjrOFJ++ZPKZ1JNM9zTpiwChFWekADNQpO9c12kVAr0e7PvUhLAl
 v91JJ+WxXDBnN4VE0ImB8LgZp2WinbnekF40tkw9YIVTcilMybt6LZHdoZ33teiRB6I0
 EcxjE0mjQpFoRH8xwNFAo+nfERwXEIBlNJv69AZI9uj5MCEJ26mlC7/0d8oY1wRRPweB
 zomC5VDwX4HX1W9Dse4lg7I0bXz2q49R3EE17DHR8nAnQDSlDThDY/UEPhvUdgPqAVVC
 lgMKHBXgewgRSYQXZhXOn2pjWsv6obEVhM/HvT45fXWy347BepOGv9KcvYYE+N2tRsum HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkrc64t5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:18:15 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A2CFHGC019893;
        Wed, 2 Nov 2022 14:18:14 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkrc64t4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:18:14 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2E6fud008796;
        Wed, 2 Nov 2022 14:18:12 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3kguejd6pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Nov 2022 14:18:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2EI9AW53346702
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 14:18:09 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7685F4203F;
        Wed,  2 Nov 2022 14:18:09 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB38942045;
        Wed,  2 Nov 2022 14:18:08 +0000 (GMT)
Received: from osiris (unknown [9.145.56.93])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  2 Nov 2022 14:18:08 +0000 (GMT)
Date:   Wed, 2 Nov 2022 15:18:07 +0100
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
Subject: [PATCH 3/5] s390/cmpxchg: remove digits from input constraints
Message-ID: <Y2J8H82B6JhJhrp2@osiris>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
 <20221012205609.2811294-2-scgl@linux.ibm.com>
 <Y2J61LWSV+HolIeT@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2J61LWSV+HolIeT@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C6KEQjwpTbWDYA88PfOFXYc0ASy5lyp7
X-Proofpoint-ORIG-GUID: lgA7BhzU9a0lOETZGHZAGNs64cYwhdPK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_10,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=895 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Instead of using a digit for input constraints simply initialize the
corresponding output operand in C code and use a "+" constraint
modifier.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/cmpxchg.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/cmpxchg.h b/arch/s390/include/asm/cmpxchg.h
index 2ad057b94481..1c5785b851ec 100644
--- a/arch/s390/include/asm/cmpxchg.h
+++ b/arch/s390/include/asm/cmpxchg.h
@@ -142,26 +142,24 @@ static __always_inline unsigned long __cmpxchg(unsigned long address,
 		return prev >> shift;
 	}
 	case 4: {
-		unsigned int prev;
+		unsigned int prev = old;
 
 		asm volatile(
 			"	cs	%[prev],%[new],%[address]\n"
-			: [prev] "=&d" (prev),
+			: [prev] "+&d" (prev),
 			  [address] "+Q" (*(int *)address)
-			: "0" (old),
-			  [new] "d" (new)
+			: [new] "d" (new)
 			: "memory", "cc");
 		return prev;
 	}
 	case 8: {
-		unsigned long prev;
+		unsigned long prev = old;
 
 		asm volatile(
 			"	csg	%[prev],%[new],%[address]\n"
-			: [prev] "=&d" (prev),
+			: [prev] "+&d" (prev),
 			  [address] "+QS" (*(long *)address)
-			: "0" (old),
-			  [new] "d" (new)
+			: [new] "d" (new)
 			: "memory", "cc");
 		return prev;
 	}
-- 
2.34.1

