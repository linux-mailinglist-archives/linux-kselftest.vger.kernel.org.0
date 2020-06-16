Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F131F1FA88C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jun 2020 08:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgFPGM7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Jun 2020 02:12:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726052AbgFPGM6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Jun 2020 02:12:58 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05G62X1n043574;
        Tue, 16 Jun 2020 02:12:57 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31msf0amqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 02:12:57 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05G6BP4d010721;
        Tue, 16 Jun 2020 06:12:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 31mpe81x1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Jun 2020 06:12:54 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05G6Cq0E60686604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jun 2020 06:12:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06DB5A4062;
        Tue, 16 Jun 2020 06:12:52 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2ACEA4060;
        Tue, 16 Jun 2020 06:12:50 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.88.230])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 16 Jun 2020 06:12:50 +0000 (GMT)
From:   Harish <harish@linux.ibm.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Harish <harish@linux.ibm.com>, aneesh.kumar@linux.ibm.com,
        skhan@linuxfoundation.org
Subject: [PATCH] selftests/vm: Run va_128TBswitch test with hugepages
Date:   Tue, 16 Jun 2020 11:42:45 +0530
Message-Id: <20200616061246.51754-1-harish@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_11:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 suspectscore=1 malwarescore=0 mlxscore=0 clxscore=1011
 cotscore=-2147483648 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006160040
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use the --run-hugetlb option to run va_128TBswitch with hugepages
configured

Signed-off-by: Harish <harish@linux.ibm.com>
---
 tools/testing/selftests/vm/run_vmtests | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/run_vmtests b/tools/testing/selftests/vm/run_vmtests
index a3f4f30f0a2e..ca0be11250bf 100755
--- a/tools/testing/selftests/vm/run_vmtests
+++ b/tools/testing/selftests/vm/run_vmtests
@@ -267,13 +267,16 @@ fi
 echo "-----------------------------"
 echo "running virtual address 128TB switch test"
 echo "-----------------------------"
-./va_128TBswitch
+# Configure minimum hugepages to run test with hugepages
+echo $(( $lackpgs + $nr_hugepgs )) > /proc/sys/vm/nr_hugepages
+./va_128TBswitch --run-hugetlb
 if [ $? -ne 0 ]; then
     echo "[FAIL]"
     exitcode=1
 else
     echo "[PASS]"
 fi
+echo $nr_hugepgs > /proc/sys/vm/nr_hugepages
 fi # VADDR64
 
 echo "------------------------------------"
-- 
2.24.1

