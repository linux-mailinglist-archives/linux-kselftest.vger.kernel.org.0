Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9858A4952CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jan 2022 18:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377186AbiATRCS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jan 2022 12:02:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29682 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238397AbiATRCS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jan 2022 12:02:18 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KGg4vc029253;
        Thu, 20 Jan 2022 17:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=faFAGZiXw89o1XTPDemJsvkGPTZrfUXh4fkm6hC9r8w=;
 b=bnGqC2M90S+pflYr7eyx8iUsHJpcndv4iNIjsvlx8MBSLCk+VxTlPbTJRX4RcoN3FGAX
 tPJmQNndE8DqesYCbZ96Y/gFzaSJZAq7yMbndxOqru9Zn0F/iYMPyDkkspf7oeN+/Dqq
 TCsSbA7SwZhu/2YLDlqxYI31DVUYwcibT2yo2KRNfwKHPiGDXibMHmml6zIggrbox9wp
 w5AnF5AjK+Lh9TzyjdAlZYZTQd+429TXLngIV4iwQhPB+83HlwpaVE7CHiZz2FJvu9LC
 1UsZg5aosWfmBcc6kcJRuSjNc6l+iMG2HYyWmyr2WG+zuGbGeSesi2wH9zLl2SKf6GLC 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqbftre39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 17:01:52 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20KGfn2g025468;
        Thu, 20 Jan 2022 17:01:51 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqbftre2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 17:01:51 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20KGwLUX020608;
        Thu, 20 Jan 2022 17:01:50 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 3dknwc4au1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 17:01:50 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20KH1nmB28442964
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 17:01:49 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75EF3BE05B;
        Thu, 20 Jan 2022 17:01:49 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D88DBE090;
        Thu, 20 Jan 2022 17:01:47 +0000 (GMT)
Received: from farosas.linux.ibm.com.com (unknown [9.211.115.36])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jan 2022 17:01:46 +0000 (GMT)
From:   Fabiano Rosas <farosas@linux.ibm.com>
To:     kvm@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        pbonzini@redhat.com, shuah@kernel.org, mpe@ellerman.id.au,
        npiggin@gmail.com, aik@ozlabs.ru, paulus@samba.org
Subject: [PATCH 0/2] KVM: selftests: Add powerpc support
Date:   Thu, 20 Jan 2022 14:01:07 -0300
Message-Id: <20220120170109.948681-1-farosas@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Vt5lnMRW-frrE0qtwx0y1fHTa95vbB7m
X-Proofpoint-GUID: 6ID9o5tI49DXU_7cTmgwD34Rl3vS2CE6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_06,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 bulkscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200088
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series adds the initial support for ppc64le Book3s with Radix
MMU.

At this time I'm including only the kvm_page_table test and a dummy
test to serve as a sample of what can be done with these tests. I
intend to make a pass over the remaining common tests and add the ones
which could be built for powerpc as well.

patch 1: a prerequisite small fix for the powerpc vcpu_ioctl. It is
         the same I already sent to the ppc mailing list but I'll
         include it here to make this a complete series.

patch 2: the actual infrastructure support.

Fabiano Rosas (2):
  KVM: PPC: Book3S HV: Stop returning internal values to userspace
  KVM: selftests: Add support for ppc64le

 MAINTAINERS                                   |   3 +
 arch/powerpc/kvm/powerpc.c                    |   8 +
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |  14 +-
 .../selftests/kvm/include/kvm_util_base.h     |   7 +
 .../selftests/kvm/include/ppc64le/processor.h |  43 +++
 tools/testing/selftests/kvm/lib/kvm_util.c    |   5 +
 .../testing/selftests/kvm/lib/powerpc/hcall.S |   6 +
 .../selftests/kvm/lib/powerpc/processor.c     | 343 ++++++++++++++++++
 .../testing/selftests/kvm/lib/powerpc/ucall.c |  67 ++++
 .../selftests/kvm/powerpc/sample_test.c       | 144 ++++++++
 11 files changed, 638 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/ppc64le/processor.h
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/hcall.S
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/ucall.c
 create mode 100644 tools/testing/selftests/kvm/powerpc/sample_test.c

-- 
2.34.1

