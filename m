Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D03731346F
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Feb 2021 15:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhBHOF0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 Feb 2021 09:05:26 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:17104 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232395AbhBHODQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 Feb 2021 09:03:16 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 118Dv56C010374;
        Mon, 8 Feb 2021 08:02:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=fdItN4cXOh4NHJFQBoEiQA3Lj7cK6f2ROujNTVJnLjQ=;
 b=H5Hj3Gkm0vgV33AfW1PZ+iq0VfpjPlW6PoXHk9vpvobLY3/xhVnLT5Hu/kburpN6OWfh
 df2ykmF9JoOPs/BO4NaoAppSzNauw9+jcAsrcpteHc80mqJURxJSFapuOseyZCfyhhzS
 lbJ3nz+DNix6HfRSGwCGybTR3VA0tEkzyeo/W0oeQ7/P3T8oUSVZpHGlGle8qA5SiWsC
 HoWhMYYnaqiai3TPNBHmY4wO+r2eq7QJFC4zPIggApk3JA2tFXVCGwpvsjjx7ByfuyEV
 FfsrksFfU6sUobcUWNwnZDWEJj8sODknFDxynS9bIOiT/K4s6R5VhOUxUXz7RYrxCl+6 gw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36jdac99p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Feb 2021 08:02:00 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 8 Feb 2021
 14:01:58 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 8 Feb 2021 14:01:58 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.240])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B991D45;
        Mon,  8 Feb 2021 14:01:57 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pmladek@suse.com>, <rostedt@goodmis.org>,
        <sergey.senozhatsky@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v5 2/4] lib: vsprintf: Fix handling of number field widths in vsscanf
Date:   Mon, 8 Feb 2021 14:01:52 +0000
Message-ID: <20210208140154.10964-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210208140154.10964-1-rf@opensource.cirrus.com>
References: <20210208140154.10964-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080095
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The existing code attempted to handle numbers by doing a strto[u]l(),
ignoring the field width, and then repeatedly dividing to extract the
field out of the full converted value. If the string contains a run of
valid digits longer than will fit in a long or long long, this would
overflow and no amount of dividing can recover the correct value.

This patch fixes vsscanf() to obey number field widths when parsing
the number.

A new _parse_integer_limit() is added that takes a limit for the number
of characters to parse. The number field conversion in vsscanf is changed
to use this new function.

If a number starts with a radix prefix, the field width  must be long
enough for at last one digit after the prefix. If not, it will be handled
like this:

 sscanf("0x4", "%1i", &i): i=0, scanning continues with the 'x'
 sscanf("0x4", "%2i", &i): i=0, scanning continues with the '4'

This is consistent with the observed behaviour of userland sscanf.

Note that this patch does NOT fix the problem of a single field value
overflowing the target type. So for example:

  sscanf("123456789abcdef", "%x", &i);

Will not produce the correct result because the value obviously overflows
INT_MAX. But sscanf will report a successful conversion.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changed since v3:
- Consistently use SIZE_MAX as the "infinity" value when passing to
  size_t arguments.
- Use while-loop instead of for-loop in _parse_integer_limit().
- Keep the existing arguments for _parse_integer() on their original line.
  And the corresponding arguments to _parse_integer_limit() formatted/wrapped
  the same way as _parse_integer().
- Remove redundant check for (max_chars == 0) in simple_strntoull().
- Fixed "vsscanf" -> "vsscanf()" in commit message.
---
 lib/kstrtox.c  | 13 ++++++--
 lib/kstrtox.h  |  2 ++
 lib/vsprintf.c | 82 +++++++++++++++++++++++++++++---------------------
 3 files changed, 59 insertions(+), 38 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index a118b0b1e9b2..0fdd07a03564 100644
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
+unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
+				  size_t max_chars)
 {
 	unsigned long long res;
 	unsigned int rv;
 
 	res = 0;
 	rv = 0;
-	while (1) {
+	while (max_chars--) {
 		unsigned int c = *s;
 		unsigned int lc = c | 0x20; /* don't tolower() this line */
 		unsigned int val;
@@ -82,6 +84,11 @@ unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long
 	return rv;
 }
 
+unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *p)
+{
+	return _parse_integer_limit(s, base, p, SIZE_MAX);
+}
+
 static int _kstrtoull(const char *s, unsigned int base, unsigned long long *res)
 {
 	unsigned long long _res;
diff --git a/lib/kstrtox.h b/lib/kstrtox.h
index 3b4637bcd254..158c400ca865 100644
--- a/lib/kstrtox.h
+++ b/lib/kstrtox.h
@@ -4,6 +4,8 @@
 
 #define KSTRTOX_OVERFLOW	(1U << 31)
 const char *_parse_integer_fixup_radix(const char *s, unsigned int *base);
+unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *res,
+				  size_t max_chars);
 unsigned int _parse_integer(const char *s, unsigned int base, unsigned long long *res);
 
 #endif
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 28bb26cd1f67..1ede80c376b7 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -53,29 +53,43 @@
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
+	return simple_strntoull(cp, SIZE_MAX, endp, base);
+}
 EXPORT_SYMBOL(simple_strtoull);
 
 /**
@@ -88,7 +102,7 @@ EXPORT_SYMBOL(simple_strtoull);
  */
 unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base)
 {
-	return simple_strtoull(cp, endp, base);
+	return simple_strntoull(cp, SIZE_MAX, endp, base);
 }
 EXPORT_SYMBOL(simple_strtoul);
 
@@ -109,6 +123,19 @@ long simple_strtol(const char *cp, char **endp, unsigned int base)
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
@@ -119,10 +146,7 @@ EXPORT_SYMBOL(simple_strtol);
  */
 long long simple_strtoll(const char *cp, char **endp, unsigned int base)
 {
-	if (*cp == '-')
-		return -simple_strtoull(cp + 1, endp, base);
-
-	return simple_strtoull(cp, endp, base);
+	return simple_strntoll(cp, SIZE_MAX, endp, base);
 }
 EXPORT_SYMBOL(simple_strtoll);
 
@@ -3449,25 +3473,13 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			break;
 
 		if (is_sign)
-			val.s = qualifier != 'L' ?
-				simple_strtol(str, &next, base) :
-				simple_strtoll(str, &next, base);
+			val.s = simple_strntoll(str,
+						field_width > 0 ? field_width : SIZE_MAX,
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
+						 field_width > 0 ? field_width : SIZE_MAX,
+						 &next, base);
 
 		switch (qualifier) {
 		case 'H':	/* that's 'hh' in format */
-- 
2.20.1

