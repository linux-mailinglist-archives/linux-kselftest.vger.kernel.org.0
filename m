Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DD54D1876
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 13:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346820AbiCHM7y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 07:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbiCHM7x (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 07:59:53 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C102BB23;
        Tue,  8 Mar 2022 04:58:53 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228BiuRt014705;
        Tue, 8 Mar 2022 12:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=jIzA6sdYS4OpZklclX1bBzOYFYHMlhsCzjUveLVF8VE=;
 b=Z8BdetqgQOYHUMKp138HF9JzbII13wCWhCOgBPi27M8nw/DVUEllTgNPBpSyvHFfaINC
 uuqfMx3BhqeeIAcm2SPSxCN52RfcUcJHliolAsTBmlwZ12XUDLzQ2rxwTSErKmTnOBP3
 tIU1Bxiakf6qn6krQ0AQgbqnMV4DKYmk0Cd3bxKqq24+LQkNbh3xCeUMgrenK1UfBNoX
 RstjW5wSi6fzOadKPubj6LNv03D+wH5+S+9LonlPeohBwQeQh1EvtkVt0eyaBcfEEeiX
 G547vCQn4zU5cLryN4DN8z7IBR7HVRr2IyPjnO8bIVcvS9yyYupFaH/XFvR4E5rcDtoS Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3envcuvwh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:58:50 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 228CRSa3006761;
        Tue, 8 Mar 2022 12:58:50 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3envcuvwgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:58:50 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228Cq0SX009361;
        Tue, 8 Mar 2022 12:58:48 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3ekyg8yfpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 12:58:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228CladC39452942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 12:47:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2533511C04A;
        Tue,  8 Mar 2022 12:58:45 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9EF511C04C;
        Tue,  8 Mar 2022 12:58:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Mar 2022 12:58:44 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 0/5] memop selftest for storage key checking
Date:   Tue,  8 Mar 2022 13:58:36 +0100
Message-Id: <20220308125841.3271721-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VSPTinBryQK2DKWX1Nail1ZWqN6W4F5w
X-Proofpoint-ORIG-GUID: 1dWKeXB8UY2cFcTSMeDqnAcw0KpsAbmb
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxlogscore=774
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080065
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
Similarly, test both vcpu and vm ioctls.

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

 tools/testing/selftests/kvm/s390x/memop.c | 735 ++++++++++++++++++----
 1 file changed, 617 insertions(+), 118 deletions(-)


base-commit: ee6a569d3bf64c9676eee3eecb861fb01cc11311
-- 
2.32.0

