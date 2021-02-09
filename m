Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02289315343
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Feb 2021 16:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhBIP51 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Feb 2021 10:57:27 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:52436 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232566AbhBIP50 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Feb 2021 10:57:26 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 119Feba3008252;
        Tue, 9 Feb 2021 09:56:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=5CEkKZOhO+kXh7ZJjl0JUmcEc38rbW3K6ghRgk6Zs3Q=;
 b=qXUjWgAJECHF3EiAxvEUS/K7dVH7IdUJOlYovbmKqKJ1zZ9ZfPl1K+5wTO3n2RJl5z91
 bh3KjNJN6vLDdpBOwqz5qxC//AC5JF7E0ylpGvfKlSIpk2EGYBE/tAq7BvxzPeyJ8h/G
 2rZqRQ037e0Fh1svLuYY8hXqUDP3CjtoW0n6JelmP7cjK/1cI17hBzUb2g0c67AkgNeY
 BucJmA6FtHcEYeCRAjwvu9Vh1z2Wn/1aMZazkBUULXCsN9NS4pFRqXRxdWL7ETUFE7o5
 UyEoPLcXN1fEE6cgV3i83acjDVNNdTW772fccI0CL5kW+R5/eFMF45E0Z01PphcrU+66 3g== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 36hrv2c1af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 09 Feb 2021 09:56:12 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 9 Feb 2021
 15:56:10 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 9 Feb 2021 15:56:10 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.240])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 179F011CA;
        Tue,  9 Feb 2021 15:56:06 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v6 1/4] lib: vsprintf: scanf: Negative number must have field width > 1
Date:   Tue, 9 Feb 2021 15:56:01 +0000
Message-ID: <20210209155604.6998-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=522 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090081
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

