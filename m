Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1E44603DB
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Nov 2021 05:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhK1EQV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Nov 2021 23:16:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231809AbhK1EOV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Nov 2021 23:14:21 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AS3lUgr020383;
        Sun, 28 Nov 2021 04:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=CKBnb3MYe70rtX3nRjCGRYnZT+Pr+vtwmuUljcDB2Ts=;
 b=WsNKl04CSEYHwC1drAoUHyOZa3TA9fSZ/SkhiOnwdWhEWL5aamXTqEoh8vGAs2dD1rRU
 WIpej+Z/FxjGO0uCMmm+X55GrqCeiKTxsaZ7Tibxf2h5Le2buoKUZi/3Jm41VZbQWDMW
 r1oB/DL0JlbcAP4sdgOTkip4loxNYHWuW0a3sVyLYs/poheJlrJP3j8OOItgmI2cz9Ek
 OtDu+5hyYQWFFSSUivVbjHWMBNmf5wYdWd58BAkM4KrO8WI6A7Swa4au7qId03Bml8tC
 F3p8SaH1fTQd7rJlxf8ZB1fhuFLRGd+aQFhqRtBdyX1+6GtGgK1iQW74oIbvXlvem+TX AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cm1btgsbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 04:10:56 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AS40hrx025803;
        Sun, 28 Nov 2021 04:10:55 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cm1btgsbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 04:10:55 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AS47ptj006771;
        Sun, 28 Nov 2021 04:10:55 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3ckca9kgja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Nov 2021 04:10:55 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AS4Asdn22938106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 28 Nov 2021 04:10:54 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6DD6AE071;
        Sun, 28 Nov 2021 04:10:54 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 988BEAE063;
        Sun, 28 Nov 2021 04:10:54 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 28 Nov 2021 04:10:54 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     jarkko@kernel.org, linux-integrity@vger.kernel.org
Cc:     peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 0/2] selftests: tpm2: Determine available PCR bank
Date:   Sat, 27 Nov 2021 23:10:50 -0500
Message-Id: <20211128041052.1395504-1-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fb1-HEzOGXurhCWsrD-Nwi-cMAY7AP1M
X-Proofpoint-ORIG-GUID: cKlxzCW9jnx2OiHhAurr2uQ5zHHjVZbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-27_06,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111280018
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

This series of patches fixes two issues with TPM2 selftest.
- Determines available PCR banks for use by test cases
- Resets DA lock on TPM2 to avoid subsequent test failures

  Stefan

v4:
 - Switch to query TPM2_GET_CAP to determine the available PCR banks
 - Moved call to reset DA lock into finally branch at end of test
 - Dropped patch 3

v3:
 - Mention SHA-256 PCR bank as alternative in patch 1 description

v2:
 - Clarified patch 1 description 
 - Added patch 3 with support for SHA-384 and SHA-512



Stefan Berger (2):
  selftests: tpm2: Determine available PCR bank
  selftests: tpm2: Reset the dictionary attack lock

 tools/testing/selftests/tpm2/tpm2.py       | 31 ++++++++++++++++++++++
 tools/testing/selftests/tpm2/tpm2_tests.py | 31 ++++++++++++++++------
 2 files changed, 54 insertions(+), 8 deletions(-)

-- 
2.31.1

