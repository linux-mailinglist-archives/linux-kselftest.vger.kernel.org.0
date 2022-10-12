Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B765FCC90
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 22:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJLU4d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 16:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJLU40 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 16:56:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A7752442;
        Wed, 12 Oct 2022 13:56:25 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CKi9H3025550;
        Wed, 12 Oct 2022 20:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=1PuDpjSFWDvxAeAfoCZnMFkZH26Yu5cUrDXtdLgDV1s=;
 b=Zlj6067Ij4UK6A05UhGwGqtgI6w7TtQ/h8wNm2Vgl0jtaamUn2JhKB6DzYu5a1qqeI0C
 BuJCxMX1GG2/20s49TqBgv2qI/iGogkM3nSXlCUC/Fn+e2IvDZxeMck4lYCGSe2lQWLr
 PM0YISLTs3GrCeZ7HCzQaypKCwFS5ecC9BCwxx4l9BJAoTKQaFzo6lG3d59bwWCEOSGB
 p09/xF2bSRWI07V++AIfEgCtyzVQ50Ss65C6pW1udY9nTkzq3ZzTqqy28ABU+IloxUeE
 hTEsnh3Ztscgo2XPmNHQ5DZO0F+c2Zl+ri/TXUiEnl0n8T9jpTlZivIGrykAgS3LvtQu UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k62v1kjaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:22 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29CKjDTx028254;
        Wed, 12 Oct 2022 20:56:21 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k62v1kj9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:21 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29CKrxSO030513;
        Wed, 12 Oct 2022 20:56:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3k30u94xx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 20:56:19 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29CKulQl48300484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 20:56:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 274A35204E;
        Wed, 12 Oct 2022 20:56:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A1DD05204F;
        Wed, 12 Oct 2022 20:56:15 +0000 (GMT)
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
Subject: [PATCH v2 9/9] KVM: s390: selftest: memop: Fix wrong address being used in test
Date:   Wed, 12 Oct 2022 22:56:09 +0200
Message-Id: <20221012205609.2811294-10-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221012205609.2811294-1-scgl@linux.ibm.com>
References: <20221012205609.2811294-1-scgl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AMi6Dm22KS96HeLWt0RV4yTPreZ_EPaj
X-Proofpoint-GUID: knxT8wRWUjPTGZeEqhJ2-u2j5vAfbRyJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_10,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxlogscore=956 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The guest code sets the key for mem1 only. In order to provoke a
protection exception the test codes needs to address mem1.

Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---
 tools/testing/selftests/kvm/s390x/memop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index 7491f1731460..e7b3897ee60a 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -760,9 +760,9 @@ static void test_errors_key(void)
 
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

