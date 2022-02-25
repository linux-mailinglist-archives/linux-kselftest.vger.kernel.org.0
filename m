Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA26C4C49A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Feb 2022 16:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242349AbiBYPx4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 10:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbiBYPxz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 10:53:55 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF471C8870;
        Fri, 25 Feb 2022 07:53:23 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21PDmDJU030142;
        Fri, 25 Feb 2022 15:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=PXePGcV/3Z67rdFpmkL41/Ekw+WDmpHX4QWqkTJP984=;
 b=Hh14zROpN81L4lsjfuYAyHI4vHZT58jBn5sVXJutiY90aTEm3s9vvoNu8uFUhUWAwAEF
 vwGEo0aSnD8KA66zqXHctUTGzNGsRi1zsPyo7hV1yl6fla/3JdmL7dCfmBIZDfueQitv
 TEM62SJfJc1z6R7/yaVAixuuILx9gvZKRFiY+EzKLri5beV0mAhSmi57qnlSw6LERdpV
 FyPvYSVmTtQsp0J7NJAS8HxSDtwl3miBaKTL2MaeBF65QEruD9opBIEN9XV35O7z2Fgb
 6KfETOTPTKtKuomiXY1ZsvSkGXUzuMUJl+YHMxPp4VVDFAQQXjLRQnu/0ftN1+I7rye5 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ef0am3dv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 15:53:20 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21PFVRx6012642;
        Fri, 25 Feb 2022 15:53:19 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ef0am3du7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 15:53:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21PFqD3R023978;
        Fri, 25 Feb 2022 15:53:18 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3ear69sp5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 15:53:18 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21PFrEL640370506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 15:53:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEFB3AE058;
        Fri, 25 Feb 2022 15:53:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52FD2AE057;
        Fri, 25 Feb 2022 15:53:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Feb 2022 15:53:14 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] memop selftest for storage key checking
Date:   Fri, 25 Feb 2022 16:53:06 +0100
Message-Id: <20220225155311.3540514-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220211182215.2730017-11-scgl@linux.ibm.com>
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kL_BQ8_up1fYDh5CrsgcMCX3A2oPsFW2
X-Proofpoint-ORIG-GUID: E3BwjWN9Jhz16157t3iN1j5sAl4mlHrm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_09,2022-02-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=827 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Refactor memop selftest and add tests.
Add storage key tests, both for success as well as failure cases.
Similarly test both vcpu and vm ioctls.

v1 -> v2
 * restructure commits
 * get rid of test_* wrapper functions that hid vm.vm
 * minor changes

v0 -> v2
 * complete rewrite

v1: https://lore.kernel.org/kvm/20220217145336.1794778-1-scgl@linux.ibm.com/
v0: https://lore.kernel.org/kvm/20220211182215.2730017-11-scgl@linux.ibm.com/

Janis Schoetterl-Glausch (5):
  KVM: s390: selftests: Split memop tests
  KVM: s390: selftests: Add macro as abstraction for MEM_OP
  KVM: s390: selftests: Add named stages for memop test
  KVM: s390: selftests: Add more copy memop tests
  KVM: s390: selftests: Add error memop tests

 tools/testing/selftests/kvm/s390x/memop.c | 734 ++++++++++++++++++----
 1 file changed, 616 insertions(+), 118 deletions(-)


base-commit: ee6a569d3bf64c9676eee3eecb861fb01cc11311
-- 
2.32.0

