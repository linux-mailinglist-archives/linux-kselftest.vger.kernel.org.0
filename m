Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A804D4CD603
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Mar 2022 15:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiCDOMk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Mar 2022 09:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbiCDOMj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Mar 2022 09:12:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE661BA93D;
        Fri,  4 Mar 2022 06:11:52 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224DnaGE031070;
        Fri, 4 Mar 2022 14:11:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=LeeW8mmOAOKB4reeE5OJx+eR5eDYk2REbvrR7EQFt70=;
 b=Wmqjxrmt515C8HdWYW7WCKNGAmRU/seA4c3unqLusxdu6JuLmG/gwyQim00PNpm5b2gA
 s4oQHM4MVwZumPjvQ1XhoHEyE2F29hzMHc8fPjSCzinHB4JJuIrWUyEZ4YvsUCdLjiQK
 ENVaz4jvJ8asUo0tNAbIUgQATo2pDA+GpQp6llsfIculTj/p6DvzG186lPfegvFjErnT
 VjaVyB1RD+R9Os140nJBTGKE/QbA/d1ci37HFqQZYNcrDSFwN6EpgkGYKyhVegyk9o8j
 +xEy4AeYpIBD17awetXP6McaAp17mBd6sjoy04Q2/45hcdrZwS+8ZNYB9SLaVen+OEGW 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ekgwgv6xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 14:11:50 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 224Dd7XR011099;
        Fri, 4 Mar 2022 14:11:50 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ekgwgv6wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 14:11:50 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 224E7f2C029608;
        Fri, 4 Mar 2022 14:11:47 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3ek4ka9n8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 14:11:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 224EBiXI20119904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Mar 2022 14:11:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63D694203F;
        Fri,  4 Mar 2022 14:11:44 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4F5142049;
        Fri,  4 Mar 2022 14:11:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.12.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Mar 2022 14:11:41 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/4] s390: Ultravisor device
Date:   Fri,  4 Mar 2022 09:11:37 -0500
Message-Id: <20220304141141.32767-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Q3VOevPhPlguO061mKAn7xX1GjNgOpwJ
X-Proofpoint-ORIG-GUID: aVZCzT9JxECYqJsllcEcJ0_fvSO5feZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_06,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds an Ultravisor(UV) device letting the userspace send some
Ultravisor calls to the UV. Currently two calls are supported.
Query Ultravisor Information (QUI) and
Receive Attestation Measurement (Attest[ation]).

The UV device is implemented as a miscdevice accepting only IOCTLs.
The IOCTL cmd specifies the UV call and the IOCTL arg the request
and response data depending on the UV call.
The device driver writes the UV response in the ioctl argument data.

The 'uvdevice' does no checks on the request beside faulty userspace
addresses, if sizes are in a sane range before allocating in kernel space,
and other tests that prevent the system from corruption.
Especially, no checks are made, that will be performed by the UV anyway
(E.g. 'invalid command' in case of attestation on unsupported hardware).
These errors are reported back to Userspace using the UV return code
field.

The first two patches introduce the new device as a module configured to be
compiled directly into the kernel (y) similar to the s390 SCLP and CHSH
miscdevice modules. Patch 3&4 introduce Kselftests which verify error
paths of the ioctl.

v2->v3:
   The main change is that QUI is now introduced after Attestation as we
   might not want pick it. Also the Kselftest patch is splitted into
   Attestation and QUI so that they can be picked without requiring
   QUI support of the uvdevice.

  * dropped the Kconfig dependency
  * reorganized the series:
    - Patch 1 now covers the introduction of the uvdevice and Attestation
    - Patch 2 adds QUI to uvdevice
    - Patch 3/4 add Kselftests for Attestation and QUI
  * fixed some nits
  * added some comments

v1->v2:
  * ioctl returns -ENOIOCTLCMD in case of a invalid ioctl command
  * streamlined reserved field test
  * default Kconfig is y instead of m
  * improved selftest documentation

Steffen Eiden (4):
  drivers/s390/char: Add Ultravisor io device
  drivers/s390/char: Add Query Ultravisor Information to uvdevice
  selftests: drivers/s390x: Add uvdevice tests
  selftests: drivers/s390x: Add uvdevice  QUI tests

 MAINTAINERS                                   |   3 +
 arch/s390/include/asm/uv.h                    |  23 +-
 arch/s390/include/uapi/asm/uvdevice.h         |  53 +++
 drivers/s390/char/Kconfig                     |  10 +
 drivers/s390/char/Makefile                    |   1 +
 drivers/s390/char/uvdevice.c                  | 320 ++++++++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/drivers/.gitignore    |   1 +
 .../selftests/drivers/s390x/uvdevice/Makefile |  22 ++
 .../selftests/drivers/s390x/uvdevice/config   |   1 +
 .../drivers/s390x/uvdevice/test_uvdevice.c    | 281 +++++++++++++++
 11 files changed, 715 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/include/uapi/asm/uvdevice.h
 create mode 100644 drivers/s390/char/uvdevice.c
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/Makefile
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/config
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c

-- 
2.25.1

