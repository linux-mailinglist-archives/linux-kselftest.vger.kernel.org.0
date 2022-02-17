Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4FA4B9EF3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 12:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbiBQLho (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 06:37:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239924AbiBQLhm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 06:37:42 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83E01B78C;
        Thu, 17 Feb 2022 03:37:27 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HABvwT000795;
        Thu, 17 Feb 2022 11:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jgMzF4Ni0eGA4OONPUhvtPkYyU4OFQyeFoXgK5Tg20U=;
 b=tGE8je2ID/YxryhRGpHw3J7Ym8YUcRI89XA1FEREeC5uRS3ACPd8/zToo1oZvRWKu2/b
 OstLyWhu7eNCAcn2h458OWLbMHuEtzI6TepslUOb2G8WdrOYLQZcB7rgCXX6+PZdv5dh
 8POzQOUyfKFpShblPwbJ9pLzESJ6jCcABL1s2QJJZyz8QLxJfKm+0kLWAJt2yjscfrHe
 +vkx6EAn8zDooKGLfq3A2LLli7J0Om1ShVqQ43zxXwr/T7nYUei/rdaejVyqTnpnZVmE
 s1rCUCyPDUamb5s1m2VdzLEZrgaMg209GDJSzs/4xpOoNZBn5E2TtSwcO9yquAyMcxFJ 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9m1ntcv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 11:37:24 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21HBLLjF004332;
        Thu, 17 Feb 2022 11:37:24 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e9m1ntcua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 11:37:24 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21HBZnDa028358;
        Thu, 17 Feb 2022 11:37:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3e64h9y5dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 11:37:22 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21HBbJVp35258876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 11:37:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 595775204E;
        Thu, 17 Feb 2022 11:37:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.114.12.92])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 225035207A;
        Thu, 17 Feb 2022 11:37:18 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 0/3] s390: Ultravisor device
Date:   Thu, 17 Feb 2022 06:37:14 -0500
Message-Id: <20220217113717.46624-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zidn7y2A38B8FfZYnNEis0TV6ue8XLMG
X-Proofpoint-ORIG-GUID: TwY6zA9qN2bj8on8Z4-ELGKhwyJ5UhIJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_04,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 clxscore=1011
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170051
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

Steffen Eiden (3):
  drivers/s390/char: Add Ultravisor io device
  drivers/s390/char: Add Ultravisor attestation to uvdevice
  selftests: drivers/s390x: Add uvdevice tests

 MAINTAINERS                                   |   3 +
 arch/s390/include/asm/uv.h                    |  23 +-
 arch/s390/include/uapi/asm/uvdevice.h         |  46 +++
 drivers/s390/char/Kconfig                     |   9 +
 drivers/s390/char/Makefile                    |   1 +
 drivers/s390/char/uvdevice.c                  | 325 ++++++++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/drivers/.gitignore    |   1 +
 .../selftests/drivers/s390x/uvdevice/Makefile |  22 ++
 .../selftests/drivers/s390x/uvdevice/config   |   1 +
 .../drivers/s390x/uvdevice/test_uvdevice.c    | 280 +++++++++++++++
 11 files changed, 711 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/include/uapi/asm/uvdevice.h
 create mode 100644 drivers/s390/char/uvdevice.c
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/Makefile
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/config
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c

-- 
2.25.1

