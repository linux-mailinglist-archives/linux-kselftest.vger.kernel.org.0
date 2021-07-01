Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD04A3B9480
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jul 2021 18:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhGAQHJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jul 2021 12:07:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230005AbhGAQHI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jul 2021 12:07:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161G3kbO018503;
        Thu, 1 Jul 2021 12:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jwpL9XXnuEroQhs6QYfgPLWjME2s+w8TJoKkzlJ32fY=;
 b=AhuEuWqQ6u+m4d6YuV42ygHiq+X77gj2H/eaG7ERvbBtr1qN2aXTzjs3LiBRxjomQkxG
 G6FwJZJCYxH7IorKic6W4qK58t0Y2268MGEEdxAz46HU94gPjORj+LWdoi4S6eg8i8k4
 /KuXWC8Mhj7xRiLnLy8XY9hx1ZzkiAk31EM6ms/f6BpwakXwvoEvakWHkHD131tlliGm
 yOm8c9UR7/dsyo+QcigtLlUKQrZ1XrTrJ4cc85eZXOzXu40KWv3fO244pa6exT7W87tY
 7QsZ6DVlmwbf3NRxFzsMycC8SSOQ3odWbtDjgUY5vMoMgbei7ZdsP6bSM/vryEI2BFdk NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hepr4sh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 12:04:32 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 161G3vsn018935;
        Thu, 1 Jul 2021 12:04:31 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39hepr4sg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 12:04:31 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 161Fv6OU024687;
        Thu, 1 Jul 2021 16:04:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 39duv8hahh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 16:04:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 161G4QdB22085896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Jul 2021 16:04:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D4D95206B;
        Thu,  1 Jul 2021 16:04:26 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 2B20A52065;
        Thu,  1 Jul 2021 16:04:26 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
        id E75E1E03CC; Thu,  1 Jul 2021 18:04:25 +0200 (CEST)
From:   Christian Borntraeger <borntraeger@de.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        vkuznets@redhat.com, wanghaibin.wang@huawei.com
Subject: [PATCH] KVM: selftests: do not require 64GB in set_memory_region_test
Date:   Thu,  1 Jul 2021 18:04:25 +0200
Message-Id: <20210701160425.33666-1-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MuhLx3pChNNubrKtsTco1XduxodZjQnT
X-Proofpoint-GUID: jjk3-JYbNDcXscFbBev0D6uEDPpVW7mx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_08:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010095
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Unless the user sets overcommit_memory or has plenty of swap, the latest
changes to the testcase will result in ENOMEM failures for hosts with
less than 64GB RAM. As we do not use much of the allocated memory, we
can use MAP_NORESERVE to avoid this error.

Cc: Zenghui Yu <yuzenghui@huawei.com>
Cc: vkuznets@redhat.com
Cc: wanghaibin.wang@huawei.com
Cc: stable@vger.kernel.org
Fixes: 309505dd5685 ("KVM: selftests: Fix mapping length truncation in m{,un}map()")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tools/testing/selftests/kvm/set_memory_region_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index d8812f27648c..d31f54ac4e98 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -377,7 +377,8 @@ static void test_add_max_memory_regions(void)
 		(max_mem_slots - 1), MEM_REGION_SIZE >> 10);
 
 	mem = mmap(NULL, (size_t)max_mem_slots * MEM_REGION_SIZE + alignment,
-		   PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		   PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
 	TEST_ASSERT(mem != MAP_FAILED, "Failed to mmap() host");
 	mem_aligned = (void *)(((size_t) mem + alignment - 1) & ~(alignment - 1));
 
-- 
2.31.1

