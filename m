Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BE62C874A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Nov 2020 16:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgK3O7Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Nov 2020 09:59:24 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:16456 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725897AbgK3O7X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Nov 2020 09:59:23 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AUEonkP002183;
        Mon, 30 Nov 2020 08:58:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=todyPYDddRJjN7wtN7bYZhhAu/yS/aucjMxjuKcurXk=;
 b=bVoxusZzzjinjKCAzytYiwNCfdizmtSdy1ZvDEvGMVI42aSfaAFkeg6ulEPrBpUtZ7Tb
 vYu9juC1hSNgCGCLRqMkG7y9ZMpuS5bRTGmJZSIgIeudGDBxosu85ZDnUFSL06V1uKVp
 ZcTP/66YhjvjaTSKWZ53BTqz6WGN3Y2ki/s/Jc0BJuGewSNDtGDg3kM2qtgCIMh935TU
 kDtwHgCUC/gWxwHRvZY4P3QKUXhGSrdUXD89MFIeydNplLAHJNdCf2jlKFEQ9LWuErvG
 09gk2mv2Wwv73KLqsYj1qfcG8PxfS5vV7k/1dxnafdPrndwrZSUdF6XsQF7TqKiJ+mJy Ow== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 353mu7a4s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 08:58:11 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 30 Nov
 2020 14:58:09 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 30 Nov 2020 14:58:09 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (ausnpc0lsnw1.ad.cirrus.com [198.61.64.188])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DC32C2A1;
        Mon, 30 Nov 2020 14:58:02 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>, <shuah@kernel.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 1/4] lib: vsprintf: Fix handling of number field widths in vsscanf
Date:   Mon, 30 Nov 2020 14:57:57 +0000
Message-ID: <20201130145800.19960-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 mlxscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300097
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The existing code attempted to handle numbers by doing a strto[u]l(),
ignoring the field width, and then bitshifting the field out of the
converted value. If the string contains a run of valid digits longer
than will fit in a long or long long, this would overflow and no amount
of bitshifting can recover the correct value.

This patch fixes vsscanf to obey number field widths when parsing
the number.

A new _parse_integer_limit() is added that takes a limit for the number
of characters to parse. The number field conversion in vsscanf is changed
to use this new function.

The cases of a base prefix or leading '-' that is >= the maximum field
width is handled such that the result of a sccanf is consistent with the
observed behaviour of userland sscanf.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 lib/kstrtox.c  | 13 +++++--
 lib/kstrtox.h  |  2 ++
 lib/vsprintf.c | 93 ++++++++++++++++++++++++++++++--------------------
 3 files changed, 68 insertions(+), 40 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index a14ccf905055..0ac2ee8bd9d0 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -39,20 +39,22 @@ const char *_parse_integer_fixup_radix(const char *s, unsigned int *base)
 
 /*
  * Convert non-negative integer string representation in explicitly given radix
- * to an integer.
+ * to an integer. A maximum of max_chars characters will be converted.
+ *
  * Return number of characters consumed maybe or-ed with overflow bit.
  * If overflow occurs, result integer (incorrect) is still returned.
  *
  * Don't you dare use this function.
  */
-unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
+unsigned int _parse_integer_limit(const char *s, unsigned int base,
+				  unsigned long long *p, size_t max_chars)
 {
 	unsigned long long res;
 	unsigned int rv;
 
 	res = 0;
 	rv = 0;
-	while (1) {
+	for (; max_chars > 0; max_chars--) {
 		unsigned int c = *s;
 		unsigned int lc = c | 0x20; /* don't tolower() this line */
 		unsigned int val;
@@ -82,6 +84,11 @@ unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long
 	return rv;
 }
 
+unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
+{
+	return _parse_integer_limit(s, base, p, INT_MAX);
+}
+
 static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
 {
 	unsigned long long _res;
diff --git a/lib/kstrtox.h b/lib/kstrtox.h
index 3b4637bcd254..4c6536f85cac 100644
--- a/lib/kstrtox.h
+++ b/lib/kstrtox.h
@@ -4,6 +4,8 @@
 
 #define KSTRTOX_OVERFLOW	(1U << 31)
 const char *_parse_integer_fixup_radix(const char *s, unsigned int *base);
+unsigned int _parse_integer_limit(const char *s, unsigned int base,
+				  unsigned long long *res, size_t max_chars);
 unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *res);
 
 #endif
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 14c9a6af1b23..21145da468e0 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -53,29 +53,47 @@
 #include <linux/string_helpers.h>
 #include "kstrtox.h"
 
-/**
- * simple_strtoull - convert a string to an unsigned long long
- * @cp: The start of the string
- * @endp: A pointer to the end of the parsed string will be placed here
- * @base: The number base to use
- *
- * This function has caveats. Please use kstrtoull instead.
- */
-unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
+static unsigned long long simple_strntoull(const char *startp, size_t max_chars,
+					   char **endp, unsigned int base)
 {
-	unsigned long long result;
+	const char *cp;
+	unsigned long long result = 0ULL;
 	unsigned int rv;
 
-	cp = _parse_integer_fixup_radix(cp, &base);
-	rv = _parse_integer(cp, base, &result);
+	if (max_chars == 0) {
+		cp = startp;
+		goto out;
+	}
+
+	cp = _parse_integer_fixup_radix(startp, &base);
+	if ((cp - startp) >= max_chars) {
+		cp = startp + max_chars;
+		goto out;
+	}
+
+	max_chars -= (cp - startp);
+	rv = _parse_integer_limit(cp, base, &result, max_chars);
 	/* FIXME */
 	cp += (rv & ~KSTRTOX_OVERFLOW);
-
+out:
 	if (endp)
 		*endp = (char *)cp;
 
 	return result;
 }
+
+/**
+ * simple_strtoull - convert a string to an unsigned long long
+ * @cp: The start of the string
+ * @endp: A pointer to the end of the parsed string will be placed here
+ * @base: The number base to use
+ *
+ * This function has caveats. Please use kstrtoull instead.
+ */
+unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base)
+{
+	return simple_strntoull(cp, UINT_MAX, endp, base);
+}
 EXPORT_SYMBOL(simple_strtoull);
 
 /**
@@ -88,7 +106,7 @@ EXPORT_SYMBOL(simple_strtoull);
  */
 unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base)
 {
-	return simple_strtoull(cp, endp, base);
+	return simple_strntoull(cp, UINT_MAX, endp, base);
 }
 EXPORT_SYMBOL(simple_strtoul);
 
@@ -109,6 +127,19 @@ long simple_strtol(const char *cp, char **endp, unsigned int base)
 }
 EXPORT_SYMBOL(simple_strtol);
 
+static long long simple_strntoll(const char *cp, size_t max_chars, char **endp,
+				 unsigned int base)
+{
+	/*
+	 * simple_strntoull safely handles receiving max_chars==0 in the
+	 * case we start with max_chars==1 and find a '-' prefix.
+	 */
+	if (*cp == '-' && max_chars > 0)
+		return -simple_strntoull(cp + 1, max_chars - 1, endp, base);
+
+	return simple_strntoull(cp, max_chars, endp, base);
+}
+
 /**
  * simple_strtoll - convert a string to a signed long long
  * @cp: The start of the string
@@ -119,10 +150,7 @@ EXPORT_SYMBOL(simple_strtol);
  */
 long long simple_strtoll(const char *cp, char **endp, unsigned int base)
 {
-	if (*cp == '-')
-		return -simple_strtoull(cp + 1, endp, base);
-
-	return simple_strtoull(cp, endp, base);
+	return simple_strntoll(cp, UINT_MAX, endp, base);
 }
 EXPORT_SYMBOL(simple_strtoll);
 
@@ -3433,8 +3461,11 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 		str = skip_spaces(str);
 
 		digit = *str;
-		if (is_sign && digit == '-')
+		if (is_sign && digit == '-') {
+			if (field_width == 1)
+				break;
 			digit = *(str + 1);
+		}
 
 		if (!digit
 		    || (base == 16 && !isxdigit(digit))
@@ -3444,25 +3475,13 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			break;
 
 		if (is_sign)
-			val.s = qualifier != 'L' ?
-				simple_strtol(str, &next, base) :
-				simple_strtoll(str, &next, base);
+			val.s = simple_strntoll(str,
+						field_width > 0 ? field_width : UINT_MAX,
+						&next, base);
 		else
-			val.u = qualifier != 'L' ?
-				simple_strtoul(str, &next, base) :
-				simple_strtoull(str, &next, base);
-
-		if (field_width > 0 && next - str > field_width) {
-			if (base == 0)
-				_parse_integer_fixup_radix(str, &base);
-			while (next - str > field_width) {
-				if (is_sign)
-					val.s = div_s64(val.s, base);
-				else
-					val.u = div_u64(val.u, base);
-				--next;
-			}
-		}
+			val.u = simple_strntoull(str,
+						 field_width > 0 ? field_width : UINT_MAX,
+						 &next, base);
 
 		switch (qualifier) {
 		case 'H':	/* that's 'hh' in format */
-- 
2.20.1

