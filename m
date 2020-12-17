Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29B12DD6B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 19:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgLQSCP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 13:02:15 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:35266 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726773AbgLQSCP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 13:02:15 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHHpgXL007072;
        Thu, 17 Dec 2020 12:01:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=z4AX9nY0wUY3aYEqQYqhIIm+lM+tibJFtoRM2hd5E50=;
 b=n3cCEJrW5L8PEzwS3mJoSxLM/unZpbet3UP8SGQWlwtM740MacQuujj29N0VmbATqOin
 XzTkrGRqacWcGKU4g6lBGt/92ju5cIKcx9vOOJ78xknAtSGDVtCj9R5t021Vdfbc+Qcd
 4OYnPSD4x2n7xDEJ/pD2MxUY/J0fnqJlFFPAs2+OgJrAvJw/RCpNNs2Txp906CbYzUHa
 ODPtk79CWohqZxTgLljLXmD7kYi9098UrGnl2sxjnYkMoqpd1LAg2aXuEfrADCF99Dkt
 hCUOJAjsZ+oNRvJYWrtYgErBQCUpPeYzbB+pTGrVJC1Qbr/kPRmwyeGcjipjgH0xgox4 9Q== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35cu5ry5ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Dec 2020 12:01:01 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 17 Dec
 2020 18:01:00 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 17 Dec 2020 18:01:00 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.236])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BA74511CA;
        Thu, 17 Dec 2020 18:00:59 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>, <shuah@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v3 1/4] lib: vsprintf: scanf: Negative number must have field width > 1
Date:   Thu, 17 Dec 2020 18:00:54 +0000
Message-ID: <20201217180057.23786-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=384 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012170123
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
---
 lib/vsprintf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 14c9a6af1b23..8954ff94a53c 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -3433,8 +3433,12 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
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

