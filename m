Return-Path: <linux-kselftest+bounces-28937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4673A5F34C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 12:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF4618967FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9664526AA8F;
	Thu, 13 Mar 2025 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0TqN5Ng"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D6526AAA9
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866304; cv=none; b=uL2jC5nIcOTW5Aiucq39tlWicOQtN3n6dVWGoSRQK9oZOoj04cUFmm/8ouKmnP5DAah5VeCtMzf1RjfKxzZe6HmqhOCeN24+Z9Ro2n7nz3o/fi0QT9cSgCK4AZ5Izk6arKnDxEDLRLMnvsDWQPGmaArtsMaHLyd4YJZCsMRJfyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866304; c=relaxed/simple;
	bh=IBY1cNO3qDPo2x35DSNukBNEFYKja79GMNoThS6fomc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=WzKCw3qeMkHJKGa4LvjpZoCkZOIXPmtJO61cTrGurSGHibOqLzBzcmJdqiv/C1D0EXbit+kjAZrKXxO+lo6BsYAOn3St/8OQVt3q4ZyGRCCEycXPM+rZR2b/atgxj2KY5h7nYZJxaVTdyGkxLrXWBrmkYrnZeptLajhNenU6/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V0TqN5Ng; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gL6tEDolxd3AJJcGJnpcVh0p0Gir2o2MhbQax2LwBfI=;
	b=V0TqN5Ng4Zzu/ImLu7mN+jZKmhJbD9drlIK3nzhvhL4pDlHO5W3u9VY4kr51B6hGvJCU+8
	k2ALvxkM5jTTX95J0CzkLtMeom3+p+GARnQvNgz04Mpqe+Qpcetj2CSANe2EJ447aaoJi3
	72d4ncC3sJtbLjFKwwrJXmEG5p2XsuQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-ydKr9BTuOoWTFpXXonMRMw-1; Thu, 13 Mar 2025 07:45:00 -0400
X-MC-Unique: ydKr9BTuOoWTFpXXonMRMw-1
X-Mimecast-MFC-AGG-ID: ydKr9BTuOoWTFpXXonMRMw_1741866299
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43bd0586a73so5906085e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 04:45:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866298; x=1742471098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gL6tEDolxd3AJJcGJnpcVh0p0Gir2o2MhbQax2LwBfI=;
        b=ei+OrVE/7uLJeJlTDbVKCG/ZvABTL5MkUdbBTrxDi3ERu2zm6sm+4FwSr7DxEz51jH
         zm4q94GqkNgdwpoXURaBDKoKjhSPV4+XXZdl8mPo+si2q3h1310NMIR8ASsqL14aHhsE
         NuByYGclW8HTkvRR7MqXOx8AEh5PaF9ia+pgWTmX2x0zJylrXVINLBnfQB7u7bpBGc5M
         n3PYVz/F4MNfSZwSleL1pGKvoUl4Jf4Pm9qu0ogeziAiWwO/H7to7y2my/W+P5i+SE4L
         1pXyu96Sn3cmmlPK0DQLP92omjqJ5BvNFtrvVJscrxd8t3QHvSznCC2ZnaMrr3kvzMIJ
         90qQ==
X-Gm-Message-State: AOJu0YwvXFyKDTKilwPE9yoQ4/Z2XAzoDa7DcV8UWVODvb3voPxK8JEm
	ZN5FEUPcFAQpghBRJM6pByfqyicJSw3RyfqfPe6eS3C1wGmxQ8OUtaGFkI16SSwvYyu5UwYAJK4
	HGbj+l4/987fDLGbN6HUalpqRedxJi1L3Z6/k5NKktO1pu6UBkDrbrAocInlmbGHpcq/6q9s7ks
	yzODHxwdqlnK6oz84Kr0AR/mLKg773aDednUMAblBdDmWFOML20U8n
X-Gm-Gg: ASbGncuLv/lAFuUx4fSSrGFSig3atXFQ12WWekfmmaq7+wnEb8hOYzqhlTOxezX0jl/
	7NzGSh6twWdxlZwOZcwzmMe6ivoWFZvNevxWqSh8tetH7FeUg/XlndMlNSwDBMbwSWI7Gvg/NuV
	0/wFJsj8PGVCxGdSgLDgQtl1kwXc4XTQ528b7Syx1Ge/ptYyzCbr3OR7G59Q0gTyc34K84CfhdB
	1yx84rpbgO4n9nct80l68FzL7JRTLMaskMM3PS0dvZDYyg6KjmL2K9LFiLM6/RJYlCUOyfeXJ72
	EY3RMLwFGikfkO8PFQ5y
X-Received: by 2002:a05:600c:1908:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-43cec28d58fmr198762645e9.10.1741866298414;
        Thu, 13 Mar 2025 04:44:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3R3Nh+MesHXp5r1AiRFiydlKhpsUv7CB4RneKkaatJviaz79nmlaZTG/mhvpsulZ3LqTgOQ==
X-Received: by 2002:a05:600c:1908:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-43cec28d58fmr198761995e9.10.1741866297943;
        Thu, 13 Mar 2025 04:44:57 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:57 -0700 (PDT)
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
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 13/14] riscv: Add support for suppressing warning backtraces
Date: Thu, 13 Mar 2025 11:43:28 +0000
Message-Id: <20250313114329.284104-14-acarmina@redhat.com>
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

To simplify the implementation, unify the __BUG_ENTRY_ADDR and
__BUG_ENTRY_FILE macros into a single macro named __BUG_REL() which takes
the address, file, or function reference as parameter.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 arch/riscv/include/asm/bug.h | 38 ++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 1aaea81fb141..79f360af4ad8 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -30,26 +30,39 @@
 typedef u32 bug_insn_t;
 
 #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-#define __BUG_ENTRY_ADDR	RISCV_INT " 1b - ."
-#define __BUG_ENTRY_FILE	RISCV_INT " %0 - ."
+#define __BUG_REL(val)	RISCV_INT " " __stringify(val) " - ."
 #else
-#define __BUG_ENTRY_ADDR	RISCV_PTR " 1b"
-#define __BUG_ENTRY_FILE	RISCV_PTR " %0"
+#define __BUG_REL(val)	RISCV_PTR " " __stringify(val)
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	__BUG_REL(%1)
+#else
+# define __BUG_FUNC_PTR
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
 #define __BUG_ENTRY			\
-	__BUG_ENTRY_ADDR "\n\t"		\
-	__BUG_ENTRY_FILE "\n\t"		\
-	RISCV_SHORT " %1\n\t"		\
-	RISCV_SHORT " %2"
+	__BUG_REL(1b) "\n\t"		\
+	__BUG_REL(%0) "\n\t"		\
+	__BUG_FUNC_PTR "\n\t"		\
+	RISCV_SHORT " %2\n\t"		\
+	RISCV_SHORT " %3"
 #else
 #define __BUG_ENTRY			\
-	__BUG_ENTRY_ADDR "\n\t"		\
-	RISCV_SHORT " %2"
+	__BUG_REL(1b) "\n\t"		\
+	RISCV_SHORT " %3"
 #endif
 
 #ifdef CONFIG_GENERIC_BUG
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC	NULL
+#endif
+
 #define __BUG_FLAGS(flags)					\
 do {								\
 	__asm__ __volatile__ (					\
@@ -58,10 +71,11 @@ do {								\
 			".pushsection __bug_table,\"aw\"\n\t"	\
 		"2:\n\t"					\
 			__BUG_ENTRY "\n\t"			\
-			".org 2b + %3\n\t"                      \
+			".org 2b + %4\n\t"                      \
 			".popsection"				\
 		:						\
-		: "i" (__FILE__), "i" (__LINE__),		\
+		: "i" (__FILE__), "i" (__BUG_FUNC),		\
+		  "i" (__LINE__),				\
 		  "i" (flags),					\
 		  "i" (sizeof(struct bug_entry)));              \
 } while (0)
-- 
2.34.1


