Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEB745B4E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 08:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhKXHLh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 02:11:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229604AbhKXHLh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 02:11:37 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO6qExX027705;
        Wed, 24 Nov 2021 07:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=IJLHZQifoiETtvnnH/RBXQq3vXrw6so9RqfGX0Q+Tpg=;
 b=dCCybZlen40uRB5uq01Gefdfno33SZWlZS7BCYmfNFYow8iseon1CI01W1W6tczlJyh0
 Cb4MFdqLHMMDl3yiiQPOeXPvby0FYG6V/ellbFJMgLvot/XsqejpEjMWbDdeyh7GVCS5
 qs/MqzT171lvwx9zJW88z6P3fFMxl2psUCaa0HJAcTedbHCU5BNJA/yGXb0uBsEdamT3
 7/h7ScYZ8uIITrsBPmhp/F6H+SwfKMv5AtJLOQq3dKFWhUNnZa89bgdM6LvtHR8/zwGI
 1m//ujsop+gQOX/ed3Wiw9p2/gmaElydpCtMFff+F34CbyUC667w1RvKb6isl4aicKaJ OA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chggpr8uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 07:08:21 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AO6x5dc028886;
        Wed, 24 Nov 2021 07:08:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3cer9jvxc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 07:08:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AO713e763242512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 07:01:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E44542041;
        Wed, 24 Nov 2021 07:08:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2BE142045;
        Wed, 24 Nov 2021 07:08:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.156.104])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Nov 2021 07:08:10 +0000 (GMT)
From:   Nageswara R Sastry <rnsastry@linux.ibm.com>
To:     zohar@linux.ibm.com, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org, mpe@ellerman.id.au,
        shuah@kernel.org
Cc:     nayna@linux.ibm.com, dja@axtens.net, gcwilson@linux.ibm.com
Subject: [PATCH 1/3] selftest/kexec: fix "ignored null byte in input" warning
Date:   Wed, 24 Nov 2021 12:38:00 +0530
Message-Id: <20211124070802.1765-1-rnsastry@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Lg8yQIoJSJy-1Ww9lHu2Qy39DBXTiCAH
X-Proofpoint-ORIG-GUID: Lg8yQIoJSJy-1Ww9lHu2Qy39DBXTiCAH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_02,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240040
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mimi Zohar <zohar@linux.ibm.com>

Instead of assigning the string to a variable, which might contain a
null character, redirect the output and grep for the string directly.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/kexec/test_kexec_file_load.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
index 2ff600388c30..99f6fc23ee31 100755
--- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -97,10 +97,11 @@ check_for_imasig()
 check_for_modsig()
 {
 	local module_sig_string="~Module signature appended~"
-	local sig="$(tail --bytes $((${#module_sig_string} + 1)) $KERNEL_IMAGE)"
 	local ret=0
 
-	if [ "$sig" == "$module_sig_string" ]; then
+	tail --bytes $((${#module_sig_string} + 1)) $KERNEL_IMAGE | \
+		grep -q "$module_sig_string"
+	if [ $? -eq 0 ]; then
 		ret=1
 		log_info "kexec kernel image modsig signed"
 	else
-- 
2.23.0

