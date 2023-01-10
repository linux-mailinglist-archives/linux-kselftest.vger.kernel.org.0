Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB386664D45
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 21:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjAJU1G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 15:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjAJU0v (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 15:26:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF565D40E;
        Tue, 10 Jan 2023 12:26:49 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30AKC7j6013052;
        Tue, 10 Jan 2023 20:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8tizxCOubcmXIJMGkuv7TYh/NU+sO3zbtZqsZc5D6hE=;
 b=mIAqlNLQYalgQRo/5HCpe1/7kVY1gE0hhgTVtYKV/4sylmh+De5GsqorxMcSNUisQNbm
 1P9piE62joqRrFgyJM9BoNrq9ZMDSNpjcS/i7iaVf+QCpbjn9zAH04lq68gnbz/L52cC
 boTumb0pLisWNzuE1lpdTD0jbx1WMT+MRPNdYh/hiIHkK/mf+HNCIQTvdhJjZNQT9N52
 00/PzMIU41m/Gy7OB+usUBl2+yKvpd7HeKVaMtBt6SvkNFB2fAv72pFlHapBteRTrNs+
 aIKkTMG6AUzpfezD6pyLbr9WuB6BButQfqYRmW+fw8dJ+MABsyJe14yb/6tI91w47RZp Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1euj08yr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:47 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30AKCTMZ014070;
        Tue, 10 Jan 2023 20:26:47 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n1euj08yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:47 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30AIGZ8I000654;
        Tue, 10 Jan 2023 20:26:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3my0c6ndgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 20:26:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30AKQfbg49807776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 20:26:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0495620040;
        Tue, 10 Jan 2023 20:26:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F2472004B;
        Tue, 10 Jan 2023 20:26:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jan 2023 20:26:40 +0000 (GMT)
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
Subject: [PATCH v5 09/10] KVM: s390: selftest: memop: Fix wrong address being used in test
Date:   Tue, 10 Jan 2023 21:26:31 +0100
Message-Id: <20230110202632.2533978-10-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230110202632.2533978-1-scgl@linux.ibm.com>
References: <20230110202632.2533978-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2gcZBuPbsgBl6-ZXLLgKmvPMT0eZ9BKh
X-Proofpoint-ORIG-GUID: Cqg8YuA0aU6YWklDLaoW3qlxRVV8ki5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_09,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301100133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The guest code sets the key for mem1 only. In order to provoke a
protection exception the test codes needs to address mem1.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 238a3f20bcc1..03f74c6c9fee 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -756,9 +756,9 @@ static void test_errors_key(void)
 
 	/* vm/vcpu, mismatching keys, fetch protection in effect */
 	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, WRITE, mem1, t.size, GADDR_V(mem1), KEY(2));
-	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, t.size, GADDR_V(mem2), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vcpu, LOGICAL, READ, mem2, t.size, GADDR_V(mem1), KEY(2));
 	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, WRITE, mem1, t.size, GADDR_V(mem1), KEY(2));
-	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, READ, mem2, t.size, GADDR_V(mem2), KEY(2));
+	CHECK_N_DO(ERR_PROT_MOP, t.vm, ABSOLUTE, READ, mem2, t.size, GADDR_V(mem1), KEY(2));
 
 	kvm_vm_free(t.kvm_vm);
 }
-- 
2.34.1

