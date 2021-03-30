Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F0834E5B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Mar 2021 12:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhC3KrY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Mar 2021 06:47:24 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:41108 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231370AbhC3Kq7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Mar 2021 06:46:59 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12UAg2NH020739;
        Tue, 30 Mar 2021 05:46:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=be7gahKOHkuRaNoGKguDexXs3BpP7vM9QCY/E9w655k=;
 b=B+0giYs4sXwTukL/zPnY6u2/3etJTKd7FXnuJuL2FtGAtkA/Zi/wS6gtHp8JXaRGLs8L
 QJy015G6HSlidJS0/blMbiu3Oze9YMIVYotEFjKKx1FRp1pSsbe9h9LTpHCsljuPRmFe
 Ak6EkFpYIU7hq+kJKf1I73dlxWTxPOlRE8BK9rn8BDnr6hD45kr7KVJJ5/9KwavNRp9l
 D0nwjshCOMyshZMHnoYgswhNuHJEaiBI5pT/FI7LK54KhatqQJt4aLjNMOcnJplAqlu6
 qP4OWnQWcIoS3o4pCxl1kcmJZhWubft6xviarltQ2OewH2n8+afBOclLW/SUlZIokexk dQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 37kfhx1ed8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Mar 2021 05:46:08 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 30 Mar
 2021 11:46:06 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Tue, 30 Mar 2021 11:46:06 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7077211D6;
        Tue, 30 Mar 2021 10:46:00 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v8 1/4] lib: vsprintf: scanf: Negative number must have field width > 1
Date:   Tue, 30 Mar 2021 11:45:55 +0100
Message-ID: <20210330104558.16481-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 2C0J9MvZYOrwOKzf3SQbpi1CRS_fUTN-
X-Proofpoint-ORIG-GUID: 2C0J9MvZYOrwOKzf3SQbpi1CRS_fUTN-
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=596
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103300076
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
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/vsprintf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 41ddc353ebb8..f78651e9b030 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3466,8 +3466,12 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
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

