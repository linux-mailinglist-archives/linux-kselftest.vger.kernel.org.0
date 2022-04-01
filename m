Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028CF4EF88B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Apr 2022 19:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344628AbiDAREt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Apr 2022 13:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346870AbiDAREt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Apr 2022 13:04:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517EA15E8AC;
        Fri,  1 Apr 2022 10:02:59 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231Ffs3S002054;
        Fri, 1 Apr 2022 17:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=nfHd4a7XAPp5zaEVmLl89M0fu2s7CMLMernxxZ/Tg1w=;
 b=maBM0eNuiXyTT6DXq3pucGH9ctcdV6KHvfZhmzJskcFgBDuXXQClJfUeS5df3AljGcVI
 ZRa0JjN+1puqu/nM2K9X9VmvzXXREbm5kglNPmLvuWTR1g7OV+GiEEdKfR11Lzrx3CFN
 UtYmOJaiR9mcOMh3lHuJWg0CWRNx9QFuwW5LCs9B1YE5FiqqrdMeB73culO+h7p1mOBw
 wEKUY2KXvvFamwxr2eUyGynTl5cyGSFN78+AoPF3VW52Q+wsgRsX64Nc3X2jhiesGaYU
 NzOsSVVJQ/Dwnm9BlTVIW+4L2qvEh7XAApUvQwJnb5Que9khJJtYEr6ZznVNwlqs4xXp Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f648s1mcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:02:56 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 231GMNgn008245;
        Fri, 1 Apr 2022 17:02:55 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f648s1mbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:02:55 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 231GxVWe003041;
        Fri, 1 Apr 2022 17:02:53 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3f1t3j3ea2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 17:02:53 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 231H2oeE48562566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Apr 2022 17:02:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1600B4204D;
        Fri,  1 Apr 2022 17:02:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A627A42059;
        Fri,  1 Apr 2022 17:02:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Apr 2022 17:02:49 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/2] Dirtying, failing memop: don't indicate suppression
Date:   Fri,  1 Apr 2022 19:02:45 +0200
Message-Id: <20220401170247.1287354-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C9C-BczXw24qCc_h0LswoIqY6_Tmpvs5
X-Proofpoint-ORIG-GUID: _rvUJXjzm8vbuxpMW8nx0s8W1lgmcnhI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_05,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=792
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010082
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If a memop fails due to key checked protection, after already having
written to the guest, don't indicate suppression to the guest, as that
would imply that memory wasn't modified.

This could be considered a fix to the code introducing storage key
support, however this is a bug in KVM only if we emulate an
instructions writing to an operand spanning multiple pages, which I
don't believe we do.

Janis Schoetterl-Glausch (2):
  KVM: s390: Don't indicate suppression on dirtying, failing memop
  KVM: s390: selftest: Test suppression indication on key prot exception

 arch/s390/kvm/gaccess.c                   | 47 ++++++++++++++---------
 tools/testing/selftests/kvm/s390x/memop.c | 43 ++++++++++++++++++++-
 2 files changed, 70 insertions(+), 20 deletions(-)


base-commit: 1ebdbeb03efe89f01f15df038a589077df3d21f5
-- 
2.32.0

