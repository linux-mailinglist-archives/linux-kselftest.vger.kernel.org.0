Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4089F30E00D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Feb 2021 17:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhBCQvb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Feb 2021 11:51:31 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:13300 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230440AbhBCQva (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Feb 2021 11:51:30 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 113GfaGi001351;
        Wed, 3 Feb 2021 10:50:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=Vo+J1sUw/XFbTDvrMV+FYZU7PwWzMzb/TFBuQnGfEGQ=;
 b=nGoQyx+0EqCvGDgdyHx9jMNX4MuA7YNWNizJ3Fk5rc3UTVwE/9wlN6YYSsJ2Z1s5BDGx
 g+fwUWVnaiZQUjeenYxIlsqUmc2gwu+7zRzWeKqZ2UHoxcFA86xPG1SNbwTAj11E+hYG
 3t2kayvW7VmDlgrOxHhFVjNWbkQMjxZGUS66ieuyzALkjM8YN4C0jlA28Q59ItVGv8uh
 VFY93r065NRmlyTa16fvFWu8xYCThqIeuP0npvIR/ZyEjNKevQtLzJ0Ixw4hfOIV7rcb
 PWkEXA9+21BRFMjqlLxUjzkMQ8GqXxCBW0QVXpNaoeqsB1gHkvmOCg7Z9cLiXYBkUGUu cg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36d5r6dfr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Feb 2021 10:50:14 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 3 Feb 2021
 16:50:12 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 3 Feb 2021 16:50:12 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.44])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A692945;
        Wed,  3 Feb 2021 16:50:11 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v4 1/4] lib: vsprintf: scanf: Negative number must have field width > 1
Date:   Wed, 3 Feb 2021 16:50:06 +0000
Message-ID: <20210203165009.6299-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=476 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030100
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If a signed number field starts with a '-' the field width must be > 1,
or unlimited, to allow at least one digit after the '-'.

This patch adds a check for this. If a signed field starts with '-'
and field_width == 1 the scanf will quit.

It is ok for a signed number field to have a field width of 1 if it
starts with a digit. In that case the single digit can be converted.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 lib/vsprintf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3b53c73580c5..28bb26cd1f67 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3434,8 +3434,12 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 		str = skip_spaces(str);
 
 		digit = *str;
-		if (is_sign && digit == '-')
+		if (is_sign && digit == '-') {
+			if (field_width == 1)
+				break;
+
 			digit = *(str + 1);
+		}
 
 		if (!digit
 		    || (base == 16 && !isxdigit(digit))
-- 
2.20.1

