Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03564521DAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 17:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345385AbiEJPNs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 11:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345274AbiEJPNl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 11:13:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A6956C0B;
        Tue, 10 May 2022 07:47:35 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24ADiC0n032561;
        Tue, 10 May 2022 14:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=nc4wvKIlLNgw5pp2mTULQu+zzV+gEDQdNP16pTfNqVY=;
 b=Vru/aqLwDpkkm7IcJYPNzMkpRa40IjPHiZbYWP9XYi1BPOpgBSsTWbiQeZtZMzqDtVHT
 aJvn+L+aaDFRV9qyH9g3XC4qXtp3t1/lLTEhyxN1u0f+gfNji0O4aQzgx5V7k7JMDK0d
 L34tXkLQgZCWOR+VF6uNpcI0lp1KjacUi/HQXGyV7RMNyTM5BjUXAuhvDrkINwmvIF62
 WmbPGh5mZ/nCkcYBuHnsFMqD+I31Q4qxMHsE42I+wki/MH5B3Bk5iu0Zc6ILzdBtJBRW
 kjsgAQddyFgw0ollI6dZzTK/PypW0FEUVHw9QHs+3ae5i2WYFu8R5SrbTglTii6ZXvZZ Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fyrupt3ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 14:47:31 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24AEkkaG011453;
        Tue, 10 May 2022 14:47:31 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fyrupt3ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 14:47:31 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24AEdqIm022211;
        Tue, 10 May 2022 14:47:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3fwgd8u9hx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 14:47:28 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24AEl8X032309726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 14:47:08 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65DE0A405B;
        Tue, 10 May 2022 14:47:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05821A4054;
        Tue, 10 May 2022 14:47:25 +0000 (GMT)
Received: from t46lp73.. (unknown [9.152.108.100])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 May 2022 14:47:24 +0000 (GMT)
From:   Steffen Eiden <seiden@linux.ibm.com>
To:     Greg KH <greg@kroah.com>, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nico Boehr <nrb@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v4 0/2] s390: Ultravisor device
Date:   Tue, 10 May 2022 14:47:22 +0000
Message-Id: <20220510144724.3321985-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8iDgig8a50N3AyShSf76EGHVd1nDRDSk
X-Proofpoint-GUID: WcSUbroq2uyI-mc9ttzLo7UNlzw2fkNW
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_03,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205100067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
These errors are reported back to userspace using the UV return code
field.

The first patch introduces the new device as a module configured to be
compiled directly into the kernel (y) similar to the s390 SCLP and CHSH
miscdevice modules. The second atch introduces Kselftests which verify error
paths of the ioctl.

@Greg
   There is now a userspace tool "pvattest" that uses the new device:
   https://github.com/ibm-s390-linux/s390-tools/tree/for-2.22

   We are currently discussing some nits regarding the processing
   of certificates and the user interface and add the tool to
   s390-tools/master afterwards.
   However, the interface to the kernel is fixed.
   The tool (pvattest) will be in s390-tools 2.22 that accompanies
   linux 5.18.
   You will be most interested in S390-tools/pvattest/src/uvio.{h,c}
   and S390-tools/pvattest/src/pvattest.c

v3->v4:
  * Dropped the QUI related patches, as we agreed that we do not want
    to expose the QUI-UVC to userspace for now.
  * Kconfig option was misplaced inside the S390 TAPE group ->fixed
  * Some nits fixed:
  	* dropped the X from S390X in the uvdevice.h guard
	* fixes kernel doc style issue in uvdevice.c

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

Steffen Eiden (2):
  drivers/s390/char: Add Ultravisor io device
  selftests: drivers/s390x: Add uvdevice tests

 MAINTAINERS                                   |   3 +
 arch/s390/include/asm/uv.h                    |  23 +-
 arch/s390/include/uapi/asm/uvdevice.h         |  51 ++++
 drivers/s390/char/Kconfig                     |  10 +
 drivers/s390/char/Makefile                    |   1 +
 drivers/s390/char/uvdevice.c                  | 264 +++++++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/drivers/.gitignore    |   1 +
 .../selftests/drivers/s390x/uvdevice/Makefile |  22 ++
 .../selftests/drivers/s390x/uvdevice/config   |   1 +
 .../drivers/s390x/uvdevice/test_uvdevice.c    | 276 ++++++++++++++++++
 11 files changed, 652 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/include/uapi/asm/uvdevice.h
 create mode 100644 drivers/s390/char/uvdevice.c
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/Makefile
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/config
 create mode 100644 tools/testing/selftests/drivers/s390x/uvdevice/test_uvdevice.c

-- 
2.30.2

