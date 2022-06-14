Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982FE54B605
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jun 2022 18:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244756AbiFNQ04 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jun 2022 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235828AbiFNQ0z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jun 2022 12:26:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BC42BB20;
        Tue, 14 Jun 2022 09:26:54 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EGQoiA031134;
        Tue, 14 Jun 2022 16:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6/TalSMpRDCZ4+DG9lsQ67+dg6iiSAzSJZ/PRuZfARA=;
 b=iZgfswXrcDEE0bPKWRRGxQVrFe2bfrtXBxdUpWvdcmzZOVCZXH8z7Cvxp9i/96rAYmm7
 rh1x1cwiQQqLwkI/QhAxZ/okMZf6bZJY5u2JsEFHVBRTBWcQ7/XTz8+KDb2OuG4qu3qq
 RqKbzBv3Nb9SKuv5c4ocN4Rza9Dbjx/8DzJmWcWnDd0+ilmOvyKDDi87U63ffsBptCHD
 vRvgBHIjBBPj71jB4r2upWAUWtVeYheBP2x+WLUZA5PPGljwn7sGd1X9g5x0ktatRnOy
 B8d4oEOF2Bzfk66ZhajsJN8lwgPVnZmMJZjPFThM/Q0Ltu8eDUVqt4PqtCCcYb6rK7Sw dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gppa6739m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 16:26:53 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25EGQqL5031459;
        Tue, 14 Jun 2022 16:26:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gppa67342-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 16:26:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25EG6v4N031317;
        Tue, 14 Jun 2022 16:26:41 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3gmjajcms5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 16:26:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25EGQcQu14942552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jun 2022 16:26:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05AB54C040;
        Tue, 14 Jun 2022 16:26:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97E684C046;
        Tue, 14 Jun 2022 16:26:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jun 2022 16:26:37 +0000 (GMT)
From:   Janis Schoetterl-Glausch <scgl@linux.ibm.com>
To:     thuth@redhat.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, pbonzini@redhat.com
Cc:     david@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org, scgl@linux.ibm.com, shuah@kernel.org
Subject: [PATCH] KVM: s390: selftests: Fix memop extension capability check
Date:   Tue, 14 Jun 2022 18:26:35 +0200
Message-Id: <20220614162635.3445019-1-scgl@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <36d83871-343d-e8a0-1aed-05bf386f9b1b@redhat.com>
References: <36d83871-343d-e8a0-1aed-05bf386f9b1b@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bbCm_KGA5GT1nJ6yz2bkdsVAd0LVogjw
X-Proofpoint-ORIG-GUID: B8dsVfyF-Pfrxd7CIb6Ie_WRb-G7_jJr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_06,2022-06-13_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=863 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206140062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the inverted logic of the memop extension capability check.

Fixes: 97da92c0ff92 ("KVM: s390: selftests: Use TAP interface in the memop test")
Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
---


Here you go.
Hope it doesn't get lost as a reply, but I can always resend
and it's not super critical after all.


 tools/testing/selftests/kvm/s390x/memop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
index e704c6fa5758..e1056f20dfa1 100644
--- a/tools/testing/selftests/kvm/s390x/memop.c
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -769,7 +769,7 @@ int main(int argc, char *argv[])
 	ksft_set_plan(ARRAY_SIZE(testlist));
 
 	for (idx = 0; idx < ARRAY_SIZE(testlist); idx++) {
-		if (testlist[idx].extension >= extension_cap) {
+		if (extension_cap >= testlist[idx].extension) {
 			testlist[idx].test();
 			ksft_test_result_pass("%s\n", testlist[idx].name);
 		} else {
-- 
2.32.0

