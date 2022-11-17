Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA4062E829
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 23:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240903AbiKQWTe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 17:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240638AbiKQWTE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 17:19:04 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77A4898DD;
        Thu, 17 Nov 2022 14:18:20 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHKJCRf017007;
        Thu, 17 Nov 2022 22:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fc57af/VTFsz80sg8wGPJId4epZzg6ina/ZrpxzgHkE=;
 b=fR0T5pvNIZ4ohYNvZS/rr5LoGbDjjR7YRWBZJsqqXfe4GKEVTM04rLHQCCqIW/K2nKat
 heLWiQ+I4/vq57DeSLWmS26LqWbDE8ipOAhExn0mPxfIHF8SRo3cTtiwGu8I+6w5i950
 2B/XcNXlnP+SyY0xkXzRHAkZK9ZmBFS3qCIPymC1oJc1ZxfMqFeI8lwKte63oYsA8Ieh
 iUKJkdxOpVV262mzfnqMbGqkkYjiED7nZzQDflO1/wf/wOvrHGAeQJvEoyIWBAHn2gBy
 yg7kdpjYZ9zfoZXEyE4rjOcZBrqDKQWxJ1UxmGEYnlsH5TY1N4YtmfQqO86rMyfljhje pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwuvytkhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:16 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AHMIFk3017011;
        Thu, 17 Nov 2022 22:18:15 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kwuvytkgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:15 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AHM6S8B012903;
        Thu, 17 Nov 2022 22:18:13 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3kwthe05wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 22:18:13 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AHMIAUx65995074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 22:18:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46CD5A4051;
        Thu, 17 Nov 2022 22:18:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4E77A4055;
        Thu, 17 Nov 2022 22:18:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Nov 2022 22:18:09 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>
Subject: [PATCH v3 7/9] KVM: s390: selftest: memop: Add bad address test
Date:   Thu, 17 Nov 2022 23:17:56 +0100
Message-Id: <20221117221758.66326-8-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221117221758.66326-1-scgl@linux.ibm.com>
References: <20221117221758.66326-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DTp2cPpEmKqfhHbqpI3MnFX0KjJjB-05
X-Proofpoint-GUID: y6fu6NesRt5HbGhgpfpG5zj8PuAKJwCv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170157
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add test that tries to access, instead of CHECK_ONLY.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 269b181731c8..13eeb50c036b 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -965,7 +965,9 @@ static void _test_errors_common(struct test_info info, enum mop_target target, i
 
 	/* Bad guest address: */
 	rv = ERR_MOP(info, target, WRITE, mem1, size, GADDR((void *)~0xfffUL), CHECK_ONLY);
-	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory access");
+	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory address");
+	rv = ERR_MOP(info, target, WRITE, mem1, size, GADDR((void *)~0xfffUL));
+	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory address");
 
 	/* Bad host address: */
 	rv = ERR_MOP(info, target, WRITE, 0, size, GADDR_V(mem1));
-- 
2.34.1

