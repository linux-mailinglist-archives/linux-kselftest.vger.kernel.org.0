Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE32D9CE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Dec 2020 17:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440308AbgLNQnf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Dec 2020 11:43:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726223AbgLNQn0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Dec 2020 11:43:26 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BEGXo0k127305;
        Mon, 14 Dec 2020 11:42:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=qQNdKQTyRkYaixt4lWet7dFji2zr1UbmBbHsGgFbjNc=;
 b=HqU0mRzxzKuoAwzJy+w07PPqNtjQ5un6Gmka/g3gR6zw2rILhZKmlAkMz+QMiJVX/vMt
 ymMWJPF1L+Bu03iSBc7Y1I4DAYM1bFDO/XXBIiBHOit6pvnP5lkmAINLM3rAN70LtRg0
 pLq5mNRVT3DGp9Gc/y5wWCz6eBscUcgUl5erMGdC62F6bUA20E4IZq92xSa/maVt8Szd
 666qOpxPCf83lf20q5ToCONnXhxBCihqQtmfxnfzFJeT2jHORswLn5Pv6LtJdh7FkZfH
 HWEDk3Ry1Zd0GDybcNSSmNoXYwDtOIJqcG2HLidecJoJtoaJ7YN5BIWVH5glW9bS4r2o DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35eaxv9yu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 11:42:34 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BEGYjFF132023;
        Mon, 14 Dec 2020 11:42:34 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35eaxv9yt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 11:42:33 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BEGavFl013299;
        Mon, 14 Dec 2020 16:42:31 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 35cng8bgr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 16:42:31 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BEGdwAY37683514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 16:39:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56CEEA405B;
        Mon, 14 Dec 2020 16:39:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8201A4062;
        Mon, 14 Dec 2020 16:39:55 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.75.77])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Dec 2020 16:39:55 +0000 (GMT)
From:   Harish <harish@linux.ibm.com>
To:     shuah@kernel.org, akpm@linux-foundation.org,
        sandipan@linux.ibm.com, jhubbard@nvidia.com, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com, bgeffon@google.com,
        almasrymina@google.com, suxingxing@loongson.cn
Cc:     Harish <harish@linux.ibm.com>, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/vm: Fix building protection keys test
Date:   Mon, 14 Dec 2020 22:09:51 +0530
Message-Id: <20201214163951.141399-1-harish@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-14_09:2020-12-11,2020-12-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012140114
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The previous patch tries to include a arch check for powerpc using
findstring, which prevents test from building on powerpc arch. Fix
this with filtering using machine type.

Signed-off-by: Harish <harish@linux.ibm.com>
---
 tools/testing/selftests/vm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 691893afc15d..0dc632cdbc73 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -61,7 +61,7 @@ TEST_GEN_FILES += $(BINARIES_64)
 endif
 else
 
-ifneq (,$(findstring $(ARCH),powerpc))
+ifneq (,$(filter $(MACHINE),ppc64 ppc64le))
 TEST_GEN_FILES += protection_keys
 endif
 
-- 
2.26.2

