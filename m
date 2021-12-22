Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E757A47D8C5
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 22:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbhLVVbW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 16:31:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239173AbhLVVbW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 16:31:22 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMKB4jU013930;
        Wed, 22 Dec 2021 21:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LMCKsYDSgWU68Pq4F970el0OH2FT6dTQlCiEQzzpTOk=;
 b=L0jxOjMTJ25mvTUplhfFHHH6AR+g8x2nykbBr/01H1/BKT/AFnD+Nv67knMFEgkbiaCZ
 MRRvc1mKbS1uBO1DMvtUGtYiTI9hE/p0eC4RY2BB/Mmh6NN9DTRFVftlTKh3yeuy7ff0
 uddP/PIQVLPG/h0IuOBI+Ovrb7TNWf59c8yRw0js/k8TPASbTcmO7hwcwuCm26W9efeA
 Mnil5ZkoHIsnk2eeUpOQJ0Jeo7R9io01PN2RqD148/FiEflZ1IQ2kin2AQGYP2rtyzjB
 Pqb1ElonET2Kfrcvm2X8L/oxR7fAx8GOskK75iTGgE3MbOR5TrSUuvBlusOMSaBG/lz1 HQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d47ssmukw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 21:31:14 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BMLM5JE004516;
        Wed, 22 Dec 2021 21:31:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3d179a865s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 21:31:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BMLV8Hg47448448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 21:31:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B785811C054;
        Wed, 22 Dec 2021 21:31:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C01211C04A;
        Wed, 22 Dec 2021 21:31:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.95.213])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Dec 2021 21:31:07 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Takashi Iwai <tiwai@suse.de>,
        Joey Lee <jlee@suse.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] selftests/kexec: update searching for the Kconfig
Date:   Wed, 22 Dec 2021 16:30:52 -0500
Message-Id: <20211222213052.6771-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211222213052.6771-1-zohar@linux.ibm.com>
References: <20211222213052.6771-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i3CDj2thOqffQSG8bXbv7X51QwWISv09
X-Proofpoint-ORIG-GUID: i3CDj2thOqffQSG8bXbv7X51QwWISv09
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=857 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220112
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

First check /lib/modules/`uname -r`/config, before using the IKCONFIG.
In addition, the configs.ko might be compressed.  Fix the configs.ko
name.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Distros: is storing the Kconfig in /lib/modules/`uname -r`/config common?

 tools/testing/selftests/kexec/kexec_common_lib.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
index 43017cfe88f7..5a1b8ae04c64 100755
--- a/tools/testing/selftests/kexec/kexec_common_lib.sh
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -138,15 +138,20 @@ kconfig_enabled()
 	return 0
 }
 
-# Attempt to get the kernel config first via proc, and then by
-# extracting it from the kernel image or the configs.ko using
-# scripts/extract-ikconfig.
+# Attempt to get the kernel config first by checking the modules directory
+# then via proc, and finally by extracting it from the kernel image or the
+# configs.ko using scripts/extract-ikconfig.
 # Return 1 for found.
 get_kconfig()
 {
 	local proc_config="/proc/config.gz"
 	local module_dir="/lib/modules/`uname -r`"
-	local configs_module="$module_dir/kernel/kernel/configs.ko"
+	local configs_module="$module_dir/kernel/kernel/configs.ko*"
+
+	if [ -f $module_dir/config ]; then
+		IKCONFIG=$module_dir/config
+		return 1
+	fi
 
 	if [ ! -f $proc_config ]; then
 		modprobe configs > /dev/null 2>&1
-- 
2.27.0

