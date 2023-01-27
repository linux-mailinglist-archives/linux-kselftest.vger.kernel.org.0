Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE46867ECB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 18:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjA0Rqu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 12:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbjA0Rqt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 12:46:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C287D2AB;
        Fri, 27 Jan 2023 09:46:47 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RGrbqa021060;
        Fri, 27 Jan 2023 17:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=VxG+aiZhuhssr8QPHzlAfPnXU7va5TskD2lv8gKu11w=;
 b=HIdofbICN06aRj/VbWJAqoAUUBNxmLgXL6LVdSs4HbMLnODBcdDf/IoL5NOARRaZMVp2
 PnCzsBP/x/cKi8fMbjDGwEbSs52oJSFm2PZVEY3X8T2qgh8FikkzP1YFVyYcCnO5ffD5
 MZxCE8cIRHiWB15wGZ6B4lbWfUe7l51kHwXQDuzTPJFTtIw4j6Nwri9N7WcNxGZMc575
 CT5fbyNAVX1zzaF8YJUylmBD4PlVxzn+a11P5EQH/cmOA7S5Fit2x3gK3xzp/6tVcHgn
 yR7uVlovXO3BGNW8Dt4Icam0G5fFazYhoBxlGKoozQHln3pOmYg7grxf41+HXOpER+/a yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncjhk9d56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 17:46:43 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RHcIjI005768;
        Fri, 27 Jan 2023 17:46:43 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncjhk9d4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 17:46:42 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R5kv7S010790;
        Fri, 27 Jan 2023 17:46:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6qv52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 17:46:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RHkbeg48169350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 17:46:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C2CA2004B;
        Fri, 27 Jan 2023 17:46:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3923120043;
        Fri, 27 Jan 2023 17:46:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 17:46:37 +0000 (GMT)
From:   Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Huth <thuth@redhat.com>
Subject: [RFC PATCH v1] KVM: selftests: Compile s390 tests with -march=z10
Date:   Fri, 27 Jan 2023 18:45:52 +0100
Message-Id: <20230127174552.3370169-1-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3n17b4DYyHozSj_3UXQ1i8oMNO3MKu5a
X-Proofpoint-ORIG-GUID: 3hjY8SkT8txt3NFncvzqm9PmjfM6ikfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301270164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The guest used in s390 kvm selftests is not be set up to handle all
instructions the compiler might emit, i.e. vector instructions, leading
to crashes.
Limit what the compiler emits to the oldest machine model currently
supported by Linux.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---


Should we also set -mtune?
Since it are vector instructions that caused the problem here, there
are some alternatives:
 * use -mno-vx
 * set the required guest control bit to enable vector instructions on
   models supporting them

-march=z10 might prevent similar issues with other instructions, but I
don't know if there actually exist other relevant instructions, so it
could be needlessly restricting.


 tools/testing/selftests/kvm/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 1750f91dd936..df0989949eb5 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -200,6 +200,9 @@ CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
 	-I$(<D) -Iinclude/$(ARCH_DIR) -I ../rseq -I.. $(EXTRA_CFLAGS) \
 	$(KHDR_INCLUDES)
+ifeq ($(ARCH),s390)
+	CFLAGS += -march=z10
+endif
 
 no-pie-option := $(call try-run, echo 'int main(void) { return 0; }' | \
         $(CC) -Werror $(CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
-- 
2.34.1

