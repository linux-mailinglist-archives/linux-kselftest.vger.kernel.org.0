Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E95447D8C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 22:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbhLVVbX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 16:31:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239878AbhLVVbX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 16:31:23 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMLLRI9013138;
        Wed, 22 Dec 2021 21:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=C5GlPGGyAgCU46yQJci8FUIiTGb4xW1TL894ObhExwY=;
 b=PjhzS6v/FqOzUhCk1PZPHPo/7XLQES8tybqoh1oJ+TjWEeiVO/FUohkwR4gsR/hB6rIn
 /uwBaDPuw05uP+AbVF4oQrsl8Ncus6n+C2aFsA9eKA4YujL+UlXwhrme+KFWR8bNj8YN
 rFqhod7GI10GY4pDMb/90/TmgVrG5e8Lwlbgk+q9VTh5ZNi9OP0LcOy8YVvyPFg7dnuX
 x+Y+/YxubB9UrJ3jTJ6iw0T14I9gd9A/A0xYLJPmSt3HiInnVIn8MqtFbwdD2LZvkjAl
 HV9bMLneWbQKBOnMjeLdV/gXg6RzSW3HTKM1MfuCRo94g6Q1kC8qV5Yh8bUtA3t0VbXY 9Q== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d48n53n8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 21:31:16 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BMLM7rS012489;
        Wed, 22 Dec 2021 21:31:06 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3d16wk24q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 21:31:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BMLV3Ip43581834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 21:31:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF55D11C04A;
        Wed, 22 Dec 2021 21:31:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C423911C058;
        Wed, 22 Dec 2021 21:31:01 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.95.213])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Dec 2021 21:31:01 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Nageswara Sastry <rnsastry@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, Takashi Iwai <tiwai@suse.de>,
        Joey Lee <jlee@suse.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] selftest/kexec: minor update to the existing test
Date:   Wed, 22 Dec 2021 16:30:50 -0500
Message-Id: <20211222213052.6771-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -e1t5jKsai_JKq5qaEf3_9UjLd_jZy_J
X-Proofpoint-ORIG-GUID: -e1t5jKsai_JKq5qaEf3_9UjLd_jZy_J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=938
 impostorscore=0 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112220112
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some distros are now storing the Kconfig in /lib/modules/`uname -r`/config.
Check there first before attempting to read it from /proc or extract it
from the kernel image.

Fix "ignored null byte in input" warning.

Mimi Zohar (2):
  selftest/kexec: fix "ignored null byte in input" warning
  selftests/kexec: update searching for the Kconfig

 tools/testing/selftests/kexec/kexec_common_lib.sh   | 13 +++++++++----
 .../testing/selftests/kexec/test_kexec_file_load.sh |  5 +++--
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.27.0

