Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DD645D229
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Nov 2021 01:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344426AbhKYAnp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 19:43:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344871AbhKYAln (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 19:41:43 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOMplKR002502;
        Thu, 25 Nov 2021 00:38:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vhS/t8ty6L7ShWjAyb76gQbtxCrJrEAZqpR+Ca3s+pQ=;
 b=nm/pkVMaOtilxrFKWtYe0dZEFH3iiLgAFrVXFTWxh0e/5lFMMRiMyrclwhbhqirQ0uOj
 VObVLRVNVCDRCCG9bUX6DVCnkr5AbYJTQWAdFySQSKj3wN1eRkc6yeQGanvJcfvkf/hi
 WB7un61hU/RZOb18SgID37sOrbrbnYp3TkwlnEoCe9qj0oEmCDWrcnevFlr4kFk6xP0E
 vn3sE8QMokSxw00M59a7j+mJ8GvPPzRi8s7Bdq6Oj0OLH6NPDS6gKgzQp2flTqryJ76t
 /H2byV3K6QgikBQYP4h1+/kWDWcjLbKD9K0T85By3IxtyrUd/ABf95PuLc2toBor1Bs2 NA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chxjbsfw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 00:38:31 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AP0CCZd014607;
        Thu, 25 Nov 2021 00:38:31 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chxjbsfvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 00:38:31 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AP0NCha010157;
        Thu, 25 Nov 2021 00:38:29 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma05wdc.us.ibm.com with ESMTP id 3cernbm36r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 00:38:29 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AP0cT1D49873214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 00:38:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 460B7B2067;
        Thu, 25 Nov 2021 00:38:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DE97B2066;
        Thu, 25 Nov 2021 00:38:29 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Nov 2021 00:38:29 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 0/3] selftests: tpm2: Probe for available PCR bank
Date:   Wed, 24 Nov 2021 19:38:24 -0500
Message-Id: <20211125003827.1360432-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H0oTmrwQ0y4xHIjnmFZ1De4h2bC6vY8i
X-Proofpoint-ORIG-GUID: HuMv6Vlq9fKfkBAfv7LGeRNf48AhIjI3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_06,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 lowpriorityscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111250000
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

This series of patches fixes two issues with TPM2 selftest.
- Probes for available PCR banks
- Resets DA lock on TPM2 to avoid subsequent test failures

It also extends the test cases with support for SHA-384 and SHA-512
PCR banks.

  Stefan

v3:
 - Mention SHA-256 PCR bank as alternative in patch 1 description

v2:
 - Clarified patch 1 description 
 - Added patch 3 with support for SHA-384 and SHA-512

Stefan Berger (3):
  selftests: tpm2: Probe for available PCR bank
  selftests: tpm2: Reset the dictionary attack lock
  selftests: tpm2: Add support for SHA-384 and SHA-512

 tools/testing/selftests/tpm2/tpm2.py       | 12 ++++++-
 tools/testing/selftests/tpm2/tpm2_tests.py | 37 +++++++++++++++++-----
 2 files changed, 40 insertions(+), 9 deletions(-)

-- 
2.31.1

