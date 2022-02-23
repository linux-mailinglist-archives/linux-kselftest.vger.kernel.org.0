Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D304C15AF
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Feb 2022 15:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiBWOtQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Feb 2022 09:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiBWOtQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Feb 2022 09:49:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB0DB54EE;
        Wed, 23 Feb 2022 06:48:48 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NDfpkv023403;
        Wed, 23 Feb 2022 14:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=o7j5iHiT8UTKVsgeEcvLHgmHFsqwXBtiP2sSdM2L4xk=;
 b=GIMmBnIZvxc31EfH9Pv5qLr7sSCgEyb8IsAMZzyUuIbEuKjuhGTG2ujjXz7fJwnZfo0a
 FcCy414Y4ScyJSFbFOLSyi3fWT5Z0eXYWGHDcK9dCPQQAqnSc6Gvk/mYkt7npQRaN+jS
 +hTfMKu8uPleq2kkoAR9Fl/hlnEDwbyz96snQAyiZhPKuZ7R61dFzrDsGN+eFQBTDCgH
 kq4uWs34JOW5SjKlt14W1dOBlL79eKKqbE8IVi6Wu8D2/AY2Vapv7ivWpOsEVp5XyoNQ
 EdhnyE43IRVOZ+mGKpA6LBXQTZ8IoIr/kxIyD3GBuxnEr/WYyyy82qXSKyxWSDKHjfb2 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edp1jhn0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 14:48:40 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NETsWV003055;
        Wed, 23 Feb 2022 14:48:40 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edp1jhmyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 14:48:40 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NEXiag015044;
        Wed, 23 Feb 2022 14:48:38 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ear69aujj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 14:48:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NEmXc937093748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 14:48:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68B0E4204D;
        Wed, 23 Feb 2022 14:48:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AC2D42049;
        Wed, 23 Feb 2022 14:48:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.12.92])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 14:48:31 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/3] s390: Ultravisor device
Date:   Wed, 23 Feb 2022 09:48:27 -0500
Message-Id: <20220223144830.44039-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bxgI3EJe9dmfHTbd1e1cIWlOIIZe4Dln
X-Proofpoint-GUID: rNMnPAXNf77I7QH57Zeka8g1Uu-3iGGy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_06,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230083
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
miscdevice modules. Patch 3/3 introduces selftests which verify error
paths of the ioctl.

v1->v2:
  * ioctl returns -ENOIOCTLCMD in case of a invalid ioctl command
  * streamlined reserved field test
  * default Kconfig is y instead of m
  * improved selftest documentation

Steffen Eiden (3):
  drivers/s390/char: Add Ultravisor io device
  drivers/s390/char: Add Ultravisor attestation to uvdevice
  selftests: drivers/s390x: Add uvdevice tests

 MAINTAINERS                                   |   3 +
 arch/s390/include/asm/uv.h                    |  23 +-
 arch/s390/include/uapi/asm/uvdevice.h         |  46 +++
 drivers/s390/char/Kconfig                     |  11 +
 drivers/s390/char/Makefile                    |   1 +
 drivers/s390/char/uvdevice.c                  | 308 ++++++++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/drivers/.gitignore    |   1 +
 .../selftests/drivers/s390x/uvdevice/Makefile |  22 ++
 .../selftests/drivers/s390x/uvdevice/config   |   1 +
 .../drivers/s390x/uvdevice/test_uvdevice.c    | 281 ++++++++++++++++
 11 files changed, 697 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/include/uapi/asm/uvdevice.h
 create mode 100644 drivers/s390/char/uvdevice.c
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/Makefile
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/config
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c

-- 
2.25.1

