Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE29C34CFFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Mar 2021 14:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhC2MYQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Mar 2021 08:24:16 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:7948 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230098AbhC2MYK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Mar 2021 08:24:10 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TCMBAi030000;
        Mon, 29 Mar 2021 07:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=be7gahKOHkuRaNoGKguDexXs3BpP7vM9QCY/E9w655k=;
 b=OBrMAQzKcEB/5q+QP8U0anUC0bYVaAvyVkRSkZbQb47MxjV32TsPpdY+vTNuQcGbrPfx
 E6mis4/9LcPklIct43qz6LctoyKiy5+PYNVlUNLhUMNyBCaGPntq7ipmcQHeNGRic2nk
 y1deCLGupe3UN4uH55K2eGxjxEglnLCIDsFwWczJ8Kq8lWOxqVlNDB5RHdsKLsDEeOvu
 mBo1RJ5gD6DFEnEuNlT4s8gdq9JWjfke66x1ZSzFnJ1RyP4h4Pk0xCKX04tsIwa+t8eO
 HUQLxSFUe75l+zgxAzGswBfKjJZZh/xWiAzHpLTkoEdTabsojoRZ9PMOSUUx/255lGfY zA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 37j2452cm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Mar 2021 07:23:32 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 29 Mar
 2021 13:08:27 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Mon, 29 Mar 2021 13:08:27 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.138])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7B8EC11CF;
        Mon, 29 Mar 2021 12:08:27 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v7 1/4] lib: vsprintf: scanf: Negative number must have field width > 1
Date:   Mon, 29 Mar 2021 13:08:21 +0100
Message-ID: <20210329120824.3006-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FHpyh3QG9b-u_BweZhXwuKy8C2WvLczn
X-Proofpoint-GUID: FHpyh3QG9b-u_BweZhXwuKy8C2WvLczn
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=589 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103290097
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

