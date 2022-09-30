Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1135F1459
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiI3VIJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 17:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiI3VII (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 17:08:08 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3E61ABFD6;
        Fri, 30 Sep 2022 14:08:06 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28UKhA7o021100;
        Fri, 30 Sep 2022 21:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Xu0H5UfpQsFJQrNSTollubi/5t/SW6aJGRMjyCemwpA=;
 b=kNR1tusqhAP1W9CP1taPxd7sYArCKSfUfYrVWyYg+YF1AVYOj9jw3JbYSun8MgNw2HDF
 mslmAq9pbD6Lu5V3YnhmrXnxy4V/HERy96CpKFwa3zVFfGf2OWqyDH0gRn2kCiA6hfe0
 cC7pPjFkUzIX53eFbuEccR0+tvFkJ7Jtj59Mngokxm+2/7MpqByieqCH8fbFC3r20Nad
 JE/63Fba0BbUGC2G8uGjkBdM1TycFzmFgUbwl1DLuRwajbVgDeDxciMx1BEwT5fyNgOY
 cQFOXEkvN8InrS7SXHZ93vbscq3gFz8Ms0869QhJhASFgIp7Xa0c8b25B2wDjFv1VbXY Vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jx7r3ggbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:01 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28UKhqhg022803;
        Fri, 30 Sep 2022 21:08:01 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jx7r3ggb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:08:01 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28UL5fpM000687;
        Fri, 30 Sep 2022 21:07:59 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3jssh8xet8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 21:07:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28UL7uM951249490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Sep 2022 21:07:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44289A405B;
        Fri, 30 Sep 2022 21:07:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9B58A405C;
        Fri, 30 Sep 2022 21:07:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Sep 2022 21:07:55 +0000 (GMT)
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
Subject: [PATCH v1 0/9] KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
Date:   Fri, 30 Sep 2022 23:07:42 +0200
Message-Id: <20220930210751.225873-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cy6BvvwuhQW2wWK6a76owBHuLw0jFZPQ
X-Proofpoint-ORIG-GUID: yG4IYyw_GrFQY__GCBnTDXOab8NwZ7ki
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 clxscore=1011 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=768 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209300131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

User space can use the MEM_OP ioctl to make storage key checked reads
and writes to the guest, however, it has no way of performing atomic,
key checked, accesses to the guest.
Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
mode. For now, support this mode for absolute accesses only.

This mode can be use, for example, to set the device-state-change
indicator and the adapter-local-summary indicator atomically.

Janis Schoetterl-Glausch (9):
  s390/uaccess: Add storage key checked cmpxchg access to user space
  KVM: s390: Extend MEM_OP ioctl by storage key checked cmpxchg
  Documentation: KVM: s390: Describe KVM_S390_MEMOP_F_CMPXCHG
  KVM: s390: selftest: memop: Pass mop_desc via pointer
  KVM: s390: selftest: memop: Replace macros by functions
  KVM: s390: selftest: memop: Add bad address test
  KVM: s390: selftest: memop: Add cmpxchg tests
  KVM: s390: selftest: memop: Fix typo
  KVM: s390: selftest: memop: Fix wrong address being used in test

 Documentation/virt/kvm/api.rst            |  18 +-
 include/uapi/linux/kvm.h                  |   5 +
 arch/s390/include/asm/uaccess.h           | 187 ++++++
 arch/s390/kvm/gaccess.h                   |   4 +
 arch/s390/kvm/gaccess.c                   |  56 ++
 arch/s390/kvm/kvm-s390.c                  |  50 +-
 tools/testing/selftests/kvm/s390x/memop.c | 704 +++++++++++++++++-----
 7 files changed, 874 insertions(+), 150 deletions(-)


base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
-- 
2.34.1

