Return-Path: <linux-kselftest+bounces-28933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A290A5F32A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 12:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669387A6D3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B23266EF2;
	Thu, 13 Mar 2025 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWZa8nBH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4963926869B
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866293; cv=none; b=UvoZW6qXlRsn+TyljfntrIVqCpuHt3gfTnKdqjC034SMZQMXDwyD7oxpiKEDg5V0ju7bHm1dsTyc6GSYFU9eAfE5vWt/8+V1PO29dP8anvlX1s8hVNnuQfcrg/C9+edrickTJXNrTrkzgLSOwE3BDXhUstwlcJvC0fRkPZAmWRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866293; c=relaxed/simple;
	bh=5fLDKvq7QfjMD1rpic/O5Jy44W9yZO5UGhmiIAM5Nww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=JDQKQXhQGWD7zCArRctRioa9z/Gql3Adb9s42JVOkAVHl1wKuHxZaXXdARU+cTE21abhgNhxvaHbpa0YkFGKERgPzUpnKi1K0wW8CoC+re3Nqtlx/Q0yGTn6sDftnscgqpsIaN7VIn90iinDBJpWeMppdhc/HwN7I+9m47uHLjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWZa8nBH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbqX7vwCNjEpHKJ2wPiix10XVQC29l2r3Yj9fEcNr2k=;
	b=bWZa8nBHoXG3GREn2Bx7JrXtcNxzSkst9p0mvZfAAUdEEhYpgyxd0+104qxKLRCjK7EdHp
	LvHyV4ao/PPHTDZEqaAWFJOVfMRXZpbWTY5fU8OKGcx44tW3N5db537HoF605uQ9p6PZ7Y
	7rcbv0SistoNF1StwFbi9en/bsg7fyc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-MkMQl6stM_2N_4svBd2gCQ-1; Thu, 13 Mar 2025 07:44:49 -0400
X-MC-Unique: MkMQl6stM_2N_4svBd2gCQ-1
X-Mimecast-MFC-AGG-ID: MkMQl6stM_2N_4svBd2gCQ_1741866288
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43935e09897so6482325e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 04:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866287; x=1742471087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PbqX7vwCNjEpHKJ2wPiix10XVQC29l2r3Yj9fEcNr2k=;
        b=OM6TS4KB/8TULT/3vSrQPpxCgo9mdYl5PXqhScGalZso+YHi1mb+bRsk0n+uwIHw/C
         7pT1JMch053jU1A0Iz11+ShuikHk6jUmb+SYA5GPVtCrRE0s9MSQAUc9hoza4e/bY1sC
         pSSiwXsLRHPpJTOdFDkd0h6z01GoDT1zFIsIUBnENRnItVaXayEYmuEW4XrHVh3xP6Wj
         YNhZzDYfqCE+9kDPkeaeBwEUd6mI/S0IWOgQygCf2VqYGDOEBRkHjQK4WxiY4/oSO0fW
         b7xS8c0VaXkVyHkPRKUbNoehEP7qlNu8R++picdWuf2JoTCIlQ6jESV62ZdmCCvoR4Fx
         chcQ==
X-Gm-Message-State: AOJu0YxcDLoi+YZHdrpCfJl1yBfi2nwDzflzTvfgxlkn6k9+GQ8E5wBK
	3tQM0D0kZTalxDwDLr2deo01uxPiLrWPZSpqeBfJABna9jgkITHRtACGrM2t32BvpiwTg3rJVI2
	luiJJXAWU2BW3zwwwLPeY9X6TOccFRDlLNi/uhLY4cdVvfz2VAggUt5QfC8DMzKgaHNb/uSvosW
	WoffSDsUTF6W6XUA6wQxUaSCGcy10Qlzeq7dt208r3ONNR8wN/bcLS
X-Gm-Gg: ASbGncusBJyBLS+0KaH6ZYpJ1w3od/CsE978c3Uy8VHEe2ymzMVadI9w9/VX3OUfIIc
	c5om0xU1SUKWAdjsKXSp6iLvIWTPS7pbe1jC50bK4k1wlgftFxIpk7bbTZ9iquwz67DmZJQeY89
	1asnxEwBh+sQGRFE0vkMWbQoaW5SoPhhnFivW9fDfSEF3rTBAHjXweZGoN/Wk/2daEO9bL38uGU
	yUuFp2lNEnCPwcxmaFANoJBiGUfaOMjcjguVWgvrR4lHbXwchocK+LQBq2ukzys0Cdklr6BwIop
	t7RNcUD/v8/88FeMk4ud
X-Received: by 2002:a05:600c:3512:b0:43c:fe15:41c9 with SMTP id 5b1f17b1804b1-43cfe154338mr111255455e9.9.1741866287362;
        Thu, 13 Mar 2025 04:44:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDgHdaZ1G01z8VuKBQ3BfPMVXgqQ5rvdTXEZ7bpTSjr+Dr16GZrLUPpD2KPNpGCET/hDHX7g==
X-Received: by 2002:a05:600c:3512:b0:43c:fe15:41c9 with SMTP id 5b1f17b1804b1-43cfe154338mr111254865e9.9.1741866286869;
        Thu, 13 Mar 2025 04:44:46 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:45 -0700 (PDT)
From: Alessandro Carminati <acarmina@redhat.com>
To: linux-kselftest@vger.kernel.org
Cc: David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	dri-devel@lists.freedesktop.org,
	kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	loongarch@lists.linux.dev,
	x86@kernel.org,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 08/14] loongarch: Add support for suppressing warning backtraces
Date: Thu, 13 Mar 2025 11:43:23 +0000
Message-Id: <20250313114329.284104-9-acarmina@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313114329.284104-1-acarmina@redhat.com>
References: <20250313114329.284104-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

From: Guenter Roeck <linux@roeck-us.net>

Add name of functions triggering warning backtraces to the __bug_table
object section to enable support for suppressing WARNING backtraces.

To limit image size impact, the pointer to the function name is only added
to the __bug_table section if both CONFIG_KUNIT_SUPPRESS_BACKTRACE and
CONFIG_DEBUG_BUGVERBOSE are enabled. Otherwise, the __func__ assembly
parameter is replaced with a (dummy) NULL parameter to avoid an image size
increase due to unused __func__ entries (this is necessary because __func__
is not a define but a virtual variable).

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 arch/loongarch/include/asm/bug.h | 42 ++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index f6f254f2c5db..b79ff6696ce6 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -3,49 +3,65 @@
 #define __ASM_BUG_H
 
 #include <asm/break.h>
+#include <kunit/bug.h>
 #include <linux/stringify.h>
 #include <linux/objtool.h>
 
 #ifndef CONFIG_DEBUG_BUGVERBOSE
-#define _BUGVERBOSE_LOCATION(file, line)
+#define _BUGVERBOSE_LOCATION(file, func, line)
 #else
-#define __BUGVERBOSE_LOCATION(file, line)			\
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR(func)  .long func - .;
+#else
+# define __BUG_FUNC_PTR(func)
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
+#define __BUGVERBOSE_LOCATION(file, func, line)			\
 		.pushsection .rodata.str, "aMS", @progbits, 1;	\
 	10002:	.string file;					\
 		.popsection;					\
 								\
 		.long 10002b - .;				\
+		__BUG_FUNC_PTR(func)				\
 		.short line;
-#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
+#define _BUGVERBOSE_LOCATION(file, func, line) __BUGVERBOSE_LOCATION(file, func, line)
 #endif
 
 #ifndef CONFIG_GENERIC_BUG
-#define __BUG_ENTRY(flags)
+#define __BUG_ENTRY(flags, func)
 #else
-#define __BUG_ENTRY(flags) 					\
+#define __BUG_ENTRY(flags, func)				\
 		.pushsection __bug_table, "aw";			\
 		.align 2;					\
 	10000:	.long 10001f - .;				\
-		_BUGVERBOSE_LOCATION(__FILE__, __LINE__)	\
+		_BUGVERBOSE_LOCATION(__FILE__, func, __LINE__)	\
 		.short flags; 					\
 		.popsection;					\
 	10001:
 #endif
 
-#define ASM_BUG_FLAGS(flags)					\
-	__BUG_ENTRY(flags)					\
+#define ASM_BUG_FLAGS(flags, func)				\
+	__BUG_ENTRY(flags, func)				\
 	break		BRK_BUG;
 
-#define ASM_BUG()	ASM_BUG_FLAGS(0)
+#define ASM_BUG()	ASM_BUG_FLAGS(0, .)
+
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC    __func__
+#else
+# define __BUG_FUNC    NULL
+#endif
 
-#define __BUG_FLAGS(flags, extra)					\
-	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags))		\
-			     extra);
+#define __BUG_FLAGS(flags, extra)				\
+	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags, %0)) \
+			     extra : : "i" (__BUG_FUNC) );
 
 #define __WARN_FLAGS(flags)					\
 do {								\
 	instrumentation_begin();				\
-	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ANNOTATE_REACHABLE(10001b));\
+	if (!KUNIT_IS_SUPPRESSED_WARNING(__func__))			\
+		__BUG_FLAGS(BUGFLAG_WARNING|(flags), ANNOTATE_REACHABLE(10001b));\
 	instrumentation_end();					\
 } while (0)
 
-- 
2.34.1


