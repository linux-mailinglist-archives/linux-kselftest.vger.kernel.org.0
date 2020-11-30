Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777012C874E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Nov 2020 16:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgK3O7b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Nov 2020 09:59:31 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:9960 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727847AbgK3O73 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Nov 2020 09:59:29 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AUEonkT002183;
        Mon, 30 Nov 2020 08:58:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=9VYWpCdY0I9xOemESRcvO83ePQj13AxQZIJRIQm2SPY=;
 b=PcfGy+IicFFuei15prL3Q/Mk+VRH1MQc4Qbr/lDnLUfvE8v8FFccNxNtlXEWPM21v6tt
 jISnwgm1rxxUcrVCPyKkk4ruQvo43wCeg7jhgogylGJ91T1zUnUdOJJs2wJweQAOlPKy
 UwE7OmOH3xr0UFRnlGufGRDYfGAXfYFl+sNesu9amL5L2cVlzGuLKXqSpGa3LWJpZ2aj
 zCyGSB9hbThSd+c7/SaP2TO4ssyUDTE9l94Tc0ei7USVOibY4VS+ulB9XjRQgDtXI6Tn
 vijW1kApg8NO7IXlVvJG3O7yYxz+icR8fO72VeHrSjwtmDouu5dBCAsbrhgkrvlg0RYE TQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 353mu7a4sd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 08:58:17 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 30 Nov
 2020 14:58:14 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 30 Nov 2020 14:58:14 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.188])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0D2C22C1;
        Mon, 30 Nov 2020 14:58:14 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>, <shuah@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 4/4] MAINTAINERS: Add lib/test_scanf.c to VSPRINTF
Date:   Mon, 30 Nov 2020 14:58:00 +0000
Message-ID: <20201130145800.19960-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201130145800.19960-1-rf@opensource.cirrus.com>
References: <20201130145800.19960-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=839
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300097
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Adds the new scanf test to the VSPRINTF group.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7887d2161be4..d2bf38bd3d0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18782,6 +18782,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git
 F:	Documentation/core-api/printk-formats.rst
 F:	lib/test_printf.c
+F:	lib/test_scanf.c
 F:	lib/vsprintf.c
 
 VT1211 HARDWARE MONITOR DRIVER
-- 
2.20.1

