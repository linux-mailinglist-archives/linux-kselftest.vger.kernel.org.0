Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA2E664D55
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 21:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjAJU1L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 15:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjAJU06 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 15:26:58 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F43392E2;
        Tue, 10 Jan 2023 12:26:57 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AKP6nZ018499;
        Tue, 10 Jan 2023 20:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cA8XJvyVgGxAY7KShYJGljhyy4b1i01QqIUktkumM/g=;
 b=sKdDdJiogOFp3JOela2SKcLAVlnPRIqGqVUaiOavtbukqLKu2FThNurN6CsZy4C+XtVP
 d3QcFTQxIy2XXAJ6oTgwQUUnxEIIeY/+4He3/A0yNoT5+QxrZZbgbkLyelTIWu1VCMse
 O5K6CtbMC7r2nEZzDHkXAqDlxSk/aiCAm9rKWDYuAQqBnazut9HaKnUx8tMweYGiuOW1
 kLoYOBL4rtA5vjYUKwj6TVCtg6K1Mf7i9v8orI1VrjQQk7T+qUQS5Is00oNsvIndyekI
 evnrL4nlMxsO6gb0SL/YLV4b+NfOTLByxPo4Z2I0G+bpQafYs5zgnLsU4Hp/iRpgQGNT Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1f1ng10f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:48 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30AKQ3sg020789;
        Tue, 10 Jan 2023 20:26:47 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1f1ng100-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:47 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30AIoVwj014076;
        Tue, 10 Jan 2023 20:26:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3my00fne84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30AKQfZV45613364
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 20:26:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9558420040;
        Tue, 10 Jan 2023 20:26:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1119720043;
        Tue, 10 Jan 2023 20:26:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jan 2023 20:26:41 +0000 (GMT)
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
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v5 10/10] KVM: s390: selftest: memop: Fix integer literal
Date:   Tue, 10 Jan 2023 21:26:32 +0100
Message-Id: <20230110202632.2533978-11-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110202632.2533978-1-scgl@linux.ibm.com>
References: <20230110202632.2533978-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Q7HGdz9GBgwk_UEPL69yMugCGGm7Yvlb
X-Proofpoint-GUID: C7BgqCchxBC96-yTcMFLC18GhgD_b9pk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The address is a 64 bit value, specifying a 32 bit value can crash the
guest. In this case things worked out with -O2 but not -O0.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Fixes: 1bb873495a9e ("KVM: s390: selftests: Add more copy memop tests")
---
 tools/testing/selftests/kvm/s390x/memop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 03f74c6c9fee..2173f7bca601 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -838,7 +838,7 @@ static void guest_copy_key_fetch_prot_override(void)
 	GUEST_SYNC(STAGE_INITED);
 	set_storage_key_range(0, PAGE_SIZE, 0x18);
 	set_storage_key_range((void *)last_page_addr, PAGE_SIZE, 0x0);
-	asm volatile ("sske %[key],%[addr]\n" :: [addr] "r"(0), [key] "r"(0x18) : "cc");
+	asm volatile ("sske %[key],%[addr]\n" :: [addr] "r"(0L), [key] "r"(0x18) : "cc");
 	GUEST_SYNC(STAGE_SKEYS_SET);
 
 	for (;;) {
-- 
2.34.1

