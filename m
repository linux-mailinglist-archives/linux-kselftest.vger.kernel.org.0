Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6F341AE34
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Sep 2021 13:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbhI1Lxa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 07:53:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60924 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240381AbhI1Lx2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 07:53:28 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SApfwK021111;
        Tue, 28 Sep 2021 07:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=frlVS1az/WulHbrX6D1bYZP2D7LX8/U+EvRFZZvVv3Y=;
 b=lVQG/EJAye4HaVBUbci1rvRpEFpzoSPx1TXIu2ijVJlj1tYGbNzdsQKFMNI//a7OISjq
 BB7SPeBNhTNJySZKuL0G5OrsaBTYCkGiscpr5jiVIanvYYgMFfb7yX+Gq1k1yFaocXRC
 C4nG05eqnfQwO86rdWWNF968lo6gSUFqs4jO4XFI3QYTcd5+xGZ8inuz9VkdsGHUPuZ8
 fdZTOnM4VqIAnX97gUfHykpC55Yp4z2iTGFrW39+5Kj69om0AIXPdVzYFBCAy+P2A31f
 paN+gM2LTFcXllhhadQsce4+9p+/GeCmsNhlb66y+LEBdVNwoNfdb/1J7xhMxzLGRbBJ 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bby6qcf4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 07:51:14 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18SAv26Y023990;
        Tue, 28 Sep 2021 07:51:13 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bby6qcf41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 07:51:13 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18SBhHbe012840;
        Tue, 28 Sep 2021 11:51:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3b9u1jux9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 11:51:12 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18SBp8uG000732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 11:51:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F9D011C05E;
        Tue, 28 Sep 2021 11:51:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB89B11C04C;
        Tue, 28 Sep 2021 11:51:03 +0000 (GMT)
Received: from pratiks-thinkpad.ibm.com (unknown [9.43.58.127])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Sep 2021 11:51:03 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        shuah@kernel.org, farosas@linux.ibm.com, kjain@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        psampat@linux.ibm.com, pratik.r.sampat@gmail.com
Subject: [PATCH v8 0/2] Interface to represent PAPR firmware attributes
Date:   Tue, 28 Sep 2021 17:21:00 +0530
Message-Id: <20210928115102.57117-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Hr71Fp_CKehqAkrOAFSu_7vVi5AF_6VR
X-Proofpoint-ORIG-GUID: jjDfv2T8fmnGw42LRkoVeGaBqrtkaeGq
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280065
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RFC: https://lkml.org/lkml/2021/6/4/791
PATCH v1: https://lkml.org/lkml/2021/6/16/805
PATCH v2: https://lkml.org/lkml/2021/7/6/138
PATCH v3: https://lkml.org/lkml/2021/7/12/2799
PATCH v4: https://lkml.org/lkml/2021/7/16/532
PATCH v5: https://lkml.org/lkml/2021/7/19/247
PATCH v6: https://lkml.org/lkml/2021/7/20/36
PATCH v7: https://lkml.org/lkml/2021/7/23/26 

Changelog v7-->v8
1. Rebased and tested against 5.15
2. Added a selftest to check if the energy and frequency attribues
   exist and their files populated

Also, have implemented a POC using this interface for the powerpc-utils'
ppc64_cpu --frequency command-line tool to utilize this information
in userspace.
The POC for the new interface has been sent to the powerpc-utils mailing
list for early review: https://groups.google.com/g/powerpc-utils-devel/c/r4i7JnlyQ8s

Sample output from the powerpc-utils tool is as follows:

# ppc64_cpu --frequency
Power and Performance Mode: XXXX
Idle Power Saver Status   : XXXX
Processor Folding Status  : XXXX --> Printed if Idle power save status is supported

Platform reported frequencies --> Frequencies reported from the platform's H_CALL i.e PAPR interface
min        :    NNNN GHz
max        :    NNNN GHz
static     :    NNNN GHz

Tool Computed frequencies
min        :    NNNN GHz (cpu XX)
max        :    NNNN GHz (cpu XX)
avg        :    NNNN GHz

Pratik R. Sampat (2):
  powerpc/pseries: Interface to represent PAPR firmware attributes
  selftest/powerpc: Add PAPR sysfs attributes sniff test

 .../sysfs-firmware-papr-energy-scale-info     |  26 ++
 arch/powerpc/include/asm/hvcall.h             |  24 +-
 arch/powerpc/kvm/trace_hv.h                   |   1 +
 arch/powerpc/platforms/pseries/Makefile       |   3 +-
 .../pseries/papr_platform_attributes.c        | 312 ++++++++++++++++++
 tools/testing/selftests/powerpc/Makefile      |   1 +
 .../powerpc/papr_attributes/.gitignore        |   2 +
 .../powerpc/papr_attributes/Makefile          |   7 +
 .../powerpc/papr_attributes/attr_test.c       | 107 ++++++
 9 files changed, 481 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-papr-energy-scale-info
 create mode 100644 arch/powerpc/platforms/pseries/papr_platform_attributes.c
 create mode 100644 tools/testing/selftests/powerpc/papr_attributes/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/papr_attributes/Makefile
 create mode 100644 tools/testing/selftests/powerpc/papr_attributes/attr_test.c

-- 
2.31.1

