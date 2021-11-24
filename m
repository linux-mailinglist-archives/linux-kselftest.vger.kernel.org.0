Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C25045C6F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 15:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352626AbhKXOQy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 09:16:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19298 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349180AbhKXOQd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 09:16:33 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOCr4uT022008;
        Wed, 24 Nov 2021 14:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+SSRMsz4kkkwnuz+VydatvUJKjZaijHf7IB5EPMPlbM=;
 b=c+W/mp8BUhI59sePLLlihqTMuuTPe0KQkemS+46dtTn5Q7/60OrlQx9IBmO+mrhE0O6x
 nludzdV8eJAYeLD6Yr4DHy5LxCvizsmVmWZUyiLG3/oNXsc3d68hWNuNa1u71Y/VwMZR
 0VBfBdvTed30xSIv4RZ6NFvloz1KYLg+wMNaNuZW1NJc24LdhfjPETillx5040jDwuKB
 q+s8pfe+fDzWhfggTEFNJy7LfROk37/+0ozQbMKOT3eNcj50J5u2D4ODLeDWcIeDMhL6
 IKuXnl2CJ4Lohk+dAa8F9Oe3Udy9PSualQIDhJ8+fSv9HOVGkUssaZ3PoUavTIGmkJl3 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chnsjhs4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 14:13:22 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AODhDVU003781;
        Wed, 24 Nov 2021 14:13:22 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chnsjhs41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 14:13:22 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AOE812p024030;
        Wed, 24 Nov 2021 14:13:20 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 3cernatg3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 14:13:20 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AOEDKnb54067494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 14:13:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69C22B2067;
        Wed, 24 Nov 2021 14:13:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F759B2065;
        Wed, 24 Nov 2021 14:13:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 24 Nov 2021 14:13:20 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/3] selftests: tpm2: Probe for available PCR bank
Date:   Wed, 24 Nov 2021 09:13:11 -0500
Message-Id: <20211124141314.1356338-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XiU5eXjSRVEDVwTZ6PhJUeuCxN6_3Zmw
X-Proofpoint-GUID: aHwRlNDvJc2wed15c-g0PB_3p29ZSrzs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_04,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240079
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This series of patches fixes two issues with TPM2 selftest.
- Probes for available PCR banks
- Resets DA lock on TPM2 to avoid subsequent test failures

It also extends the test cases with support for SHA-384 and SHA-512
PCR banks.

  Stefan

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

