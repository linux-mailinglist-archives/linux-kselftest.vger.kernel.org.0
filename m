Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2640547D8DC
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 22:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhLVVgU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 16:36:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234222AbhLVVgU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 16:36:20 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMLDIls005274;
        Wed, 22 Dec 2021 21:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XTjTf9pbhvJ4dEZtdy1dWmdIbs4FdTkVSeAQRaR7f0w=;
 b=izxpPwredIkOFuGykGLDxSAoagx9HcrCVE/Xzm5z0xm6rz/Gh1JyBAWRWF7QQNNmfROi
 LmOBR8Ac6eN9zUhmcEo4FfjdrjOz8Q9yPBIaKaW9xH5gXimL1NH5T+DCsrXZm5+PzM3M
 VJ3Sm6NfSnDSCYaXJrXEtQabSMP5nMhfiPTca8wNBIVS+bVxC+jQ9XO+SYjBRRKnuj3A
 +8lMTfZP+JVaefUzC4YJuH7OeYLmFu7TT7oflKqFnuDs1F/BEySdNH+6YlwJf+caAG03
 z7xDFD+0MZJuUHjTm1/J9ugBlqUYJAC2CEqHk68+nt00nmwljLtFDHuXhWoeE/wlnj85 Fw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d4bra0akc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 21:36:13 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BMLNaQb004564;
        Wed, 22 Dec 2021 21:31:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3d179a203d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 21:31:10 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BMLV7af39715206
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 21:31:07 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CD3811C04C;
        Wed, 22 Dec 2021 21:31:07 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D3A711C050;
        Wed, 22 Dec 2021 21:31:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.95.213])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Dec 2021 21:31:06 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Takashi Iwai <tiwai@suse.de>,
        Joey Lee <jlee@suse.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] selftest/kexec: fix "ignored null byte in input" warning
Date:   Wed, 22 Dec 2021 16:30:51 -0500
Message-Id: <20211222213052.6771-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222213052.6771-1-zohar@linux.ibm.com>
References: <20211222213052.6771-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CtoJYWcNIoqE8bc4oF542JxRax7UZ7p1
X-Proofpoint-GUID: CtoJYWcNIoqE8bc4oF542JxRax7UZ7p1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220112
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Instead of assigning the string to a variable, which might contain a
null character, redirect the output and grep for the string directly.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Comment: this patch was previously posted as part of Nageswara's larger
 patch set.

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
2.27.0

