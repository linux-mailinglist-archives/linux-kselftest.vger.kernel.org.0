Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78C906C8068
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 15:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjCXOyj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 10:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjCXOyi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 10:54:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008814EDE;
        Fri, 24 Mar 2023 07:54:33 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OELsQ1005719;
        Fri, 24 Mar 2023 14:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=z7pokYLoD51PbCRwEi+WaTVuf+LZfBzExfGlrYiJvxg=;
 b=rbybVeqGS0WSM7EEhp+Ha8186yM7MysUVPKmi4q2XyfM5eq2z8GVo7vdfvEhVboJFpBR
 5ydu2sDPbxA4HMwWyKBLB/+aJzwi8CyA0Aqk7IJblVWalmsRylAuAn/nYV9YqewkFOEn
 K2wv5aGKTfakfTaCedcjWQ66Gzokd7XXCE2lIRI6lFQBv342Bs6pcHDUhbRMTOBkjqN9
 4QcXHIGWonmmsOKJpn07+C87UHjJghLqjEngqGKwoTJI0gsn3NAS96yA+K3NietgRRFP
 3/KxwJxMmGo9lCpcwJdW9jDcH/fcpuufnaI1duvXJcp5cArWkEsKa7nVfOUQtFuiSYNB Gw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3phdjegrk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 14:54:30 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32NLcpAo015828;
        Fri, 24 Mar 2023 14:54:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3pgxv8gsy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 14:54:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32OEsPcZ18219302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Mar 2023 14:54:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 000F22004E;
        Fri, 24 Mar 2023 14:54:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 997A120040;
        Fri, 24 Mar 2023 14:54:24 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 24 Mar 2023 14:54:24 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, shuah@kernel.org
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/2] KVM: s390: CMMA migration selftest and small bugfix
Date:   Fri, 24 Mar 2023 15:54:22 +0100
Message-Id: <20230324145424.293889-1-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZTg-HLazEU_AG9AHivkdXHbN-n9mhVPx
X-Proofpoint-ORIG-GUID: ZTg-HLazEU_AG9AHivkdXHbN-n9mhVPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_08,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=897 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240117
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v2:
---
* swap order of patches (thanks Claudio)
* add r-b
* add comment why memslots are zeroed

Add a new selftest for CMMA migration. Also fix a small issue found during
development of the test.

Nico Boehr (2):
  KVM: s390: fix KVM_S390_GET_CMMA_BITS for GFNs in memslot holes
  KVM: s390: selftests: add selftest for CMMA migration

 arch/s390/kvm/kvm-s390.c                      |   4 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 tools/testing/selftests/kvm/s390x/cmma_test.c | 680 ++++++++++++++++++
 3 files changed, 685 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/s390x/cmma_test.c

-- 
2.39.1

