Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2405A930A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 11:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiIAJXr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 05:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiIAJXp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 05:23:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA6612D532;
        Thu,  1 Sep 2022 02:23:41 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2818oTDk007722;
        Thu, 1 Sep 2022 09:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=oSpC5mfTK/eTWZhpCaXSlm6QucnN1qjlhlAhzjYSCDA=;
 b=lkPKs22EYOgbXnJIrshh6Ab9d8Ui1y5c5rtXlhCY4lXzlb6H7cTAGeVyd2Ew2/8LHrGe
 08XkvABk1MyZplmP1F7aa2nb4Y5tfD3lQL0ryBaNorLVp9PSEXARUTlTm7uBDQwfra/x
 RHRF3icGVmWL9BS1jFqTsSQzT0bUAcjduUdtG2/JG+otLAxA+thRYMABIh+niskWrTs5
 Jx+dmW5vi083Y5iPXoovqq4xvPyz2L1zWOaAxgoVrtQEBDCjnunIPnjSHFultP+4OIDQ
 En3z8zE36x/fTL7+1xeK7EfbtcTISXp4Imrm9YN11HM6BKXgSupMEycCoEDOP6VgMrnZ +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jask195en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:23:31 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28190mY8022084;
        Thu, 1 Sep 2022 09:23:31 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jask195dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:23:31 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2819MLJa017370;
        Thu, 1 Sep 2022 09:23:28 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3j7ahhvrsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Sep 2022 09:23:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2819NPSi32244048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Sep 2022 09:23:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A78AA404D;
        Thu,  1 Sep 2022 09:23:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A31BAA4053;
        Thu,  1 Sep 2022 09:23:22 +0000 (GMT)
Received: from tarunpc.ibmuc.com (unknown [9.43.6.31])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  1 Sep 2022 09:23:22 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     akpm@linux-foundation.org, shuah@kernel.org,
        axelrasmussen@google.com
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, aneesh.kumar@linux.ibm.com,
        Tarun Sahu <tsahu@linux.ibm.com>
Subject: [PATCH] selftest: vm: remove deleted local_config.* from .gitignore
Date:   Thu,  1 Sep 2022 14:53:15 +0530
Message-Id: <20220901092315.33619-1-tsahu@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rsrvjOzlMhuFJjMrWE2gRcX6unwHEljk
X-Proofpoint-GUID: CjDuGkUjmAorZRs14t50ojyzlRmXt3kg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_06,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=762 mlxscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209010040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit d2d6cba5d6623245a80cc151008cce825c8b6248 ("selftest: vm: remove
orphaned references to local_config.{h,mk}") took care of removing
orphaned references. This commit remove local_config from .gitignore.

Parent Patch
Commit 69007f156ba7aead6c75b0046958ad3396f5aed1 ("Kselftests: remove
support of libhugetlbfs from kselftests")


Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
---
 tools/testing/selftests/vm/.gitignore | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 31e5eea2a9b9..7b9dc2426f18 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -30,7 +30,6 @@ map_fixed_noreplace
 write_to_hugetlbfs
 hmm-tests
 memfd_secret
-local_config.*
 soft-dirty
 split_huge_page_test
 ksm_tests
-- 
2.31.1

