Return-Path: <linux-kselftest+bounces-28938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B173A5F35C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 12:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3AC19C07EB
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EE0268C53;
	Thu, 13 Mar 2025 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ffFI9KB1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F263268C50
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866316; cv=none; b=eetX6I/HZYsgjHMTF0PTkFK2oGqSz5it5/Ac+uprygs+iwmPs9vknI4/xhzdQeXs3/SKZUqBHhDXrmZz15qKAB+DLqCjltgNhnwoTskIXsCjFNbH3gLTPbhpWWwUcnxscb9k0F0j7a6SNVr9WTapBZHp0SAMoLFAEtjl+s3etNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866316; c=relaxed/simple;
	bh=xetTM7NbHTpP54GNd2evXkwpRCX6m2HaBd9Qo2PRDeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=Nfs5tZiBSk9+oD9Vcobz3NCpH9e+sYiTv8o0mysZAiuCG1nMVo5m1Pb0E6yQobzpOvb8SmEnEIU9OYRPKrdPVVONqawAxkn5WSXgp7L8ELqg9drjg6kY2puM25o3fHYmseKJjIBtVdBZUgry6UCDtBQOFhKX/lxlztZv2SjSKgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ffFI9KB1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741866314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BMlGspdrpbJ31u0fCjYvjyAZlqg7W4BaKawB7P7nRsE=;
	b=ffFI9KB1MoknlgN/YaPXeQF5V9K879W8sTP0/pNncTGHIxQKNo7RThXUS/I5vDSeRr0sjo
	fuirh5Ikmfxfpzfx+6g3fbEThTnubLhR1hQp7aTc/AEA2KJ8yXezep2Qq6hB9geBRrwUuA
	NwKmkHdNlo/8hCXzKSjP/mpN94QvssM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-W8V_AIXXMu2ILA-IG7LuaQ-1; Thu, 13 Mar 2025 07:45:02 -0400
X-MC-Unique: W8V_AIXXMu2ILA-IG7LuaQ-1
X-Mimecast-MFC-AGG-ID: W8V_AIXXMu2ILA-IG7LuaQ_1741866301
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso6562855e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Mar 2025 04:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866300; x=1742471100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMlGspdrpbJ31u0fCjYvjyAZlqg7W4BaKawB7P7nRsE=;
        b=lovQTfzIHgmKM4KXcyCq+heWFCCiDw4qv2pMJUsOUuGXzOXMaetMVwac5nEL4SbGWq
         VhTJT5aaAffUrvu7MVrBwUjIovxFEUYHY/ZH9+4X7Me+iUTOfZr8heCbWNTpVD1QSi0w
         VuPa5z5nR+2dk3S3JxhLQ53UfCbRw7N6V9583uNGwNTvdNa41Hc4a4gNYFt5ulfqaC47
         7hDv0yS7ZpXL/BnRq+6zXr/8zdoD7SIkSpGaSMqkG6CQhW9enxH2zsqsv1tK5KKnrBJi
         ee/5iEjgkQwKs3ac3WJI/InlwPjzRGcwWIzGCNP1WwMQrRHjVcDSHZbKpwmaah5/57f5
         xd9w==
X-Gm-Message-State: AOJu0YzhJTXdKFH48TMno9YG+ibSp5qaZYwGNAkgKI2vc96M1vfl8r+n
	Hfx1QOCzoNE58wt9u58RnXYsloaHt6bKxLmS6WkNY1Tq7+QhvFdyda/rkFsIH7/9pqfvbVD5sZP
	jxIwCG4hfzzcSx3991DFbYOISeg9Qs/uS4uUYcIF3kVGhn6MNGevQidaH+Y10+66uQSCC/Qfv3N
	pNZCpb4aRG7b46JWpbiyFWrUekqRYasyYihu5cEkLXUb0pKbU/f548
X-Gm-Gg: ASbGncvVQWhtYWkiqbVenzfnvDfompWaIcnPUCkN7EOLzZxFeyK21GXKrRf+Soh+G8V
	ORT9jk/4P0H/lF5KxObYSmPCtjrV1mwr8wd4y670e8j/sFNWh3SPFNNWXw2iAC0UFCcmhO77QJy
	pu66gMW6W5CFBcu6CA/80Ut4dbeQdHe7k2JAGUjqU+NqX5EgrFtKVtc7bgrScf3k3x96TsP4G/i
	AUitV1g6V9peCTa4jMKVWqQZUKdZbB1KLeDSDK2ZwcnjPF9pKf1bxfEqqMfxFdMHFoZ3TmEBhf0
	+MoaZa+jem3f2EidJ+qz
X-Received: by 2002:a05:600c:470a:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-43cf44c76ccmr144327275e9.2.1741866300593;
        Thu, 13 Mar 2025 04:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERxTxm4YW1Ezaow82Z48NXt1aSx6Vv01Gh0iy7KljuVnLSLjwCs9KSAjTKcqnBX6jh4hKEWQ==
X-Received: by 2002:a05:600c:470a:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-43cf44c76ccmr144326735e9.2.1741866300120;
        Thu, 13 Mar 2025 04:45:00 -0700 (PDT)
Received: from lab.hqhome163.com ([81.57.75.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d188b754asm17844115e9.14.2025.03.13.04.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:44:59 -0700 (PDT)
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
	Michael Ellerman <mpe@ellerman.id.au>,
	Alessandro Carminati <acarmina@redhat.com>
Subject: [PATCH v4 14/14] powerpc: Add support for suppressing warning backtraces
Date: Thu, 13 Mar 2025 11:43:29 +0000
Message-Id: <20250313114329.284104-15-acarmina@redhat.com>
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
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 arch/powerpc/include/asm/bug.h | 37 +++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 1db485aacbd9..5b06745d20aa 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -14,6 +14,9 @@
 	 .section __bug_table,"aw"
 5001:	 .4byte \addr - .
 	 .4byte 5002f - .
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+	 .4byte 0
+#endif
 	 .short \line, \flags
 	 .org 5001b+BUG_ENTRY_SIZE
 	 .previous
@@ -32,30 +35,46 @@
 #endif /* verbose */
 
 #else /* !__ASSEMBLY__ */
-/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3 to be FILE, LINE, flags and
-   sizeof(struct bug_entry), respectively */
+/* _EMIT_BUG_ENTRY expects args %0,%1,%2,%3,%4 to be FILE, __func__, LINE, flags
+   and sizeof(struct bug_entry), respectively */
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#ifdef CONFIG_KUNIT_SUPPRESS_BACKTRACE
+# define HAVE_BUG_FUNCTION
+# define __BUG_FUNC_PTR	"	.4byte %1 - .\n"
+#else
+# define __BUG_FUNC_PTR
+#endif /* CONFIG_KUNIT_SUPPRESS_BACKTRACE */
+
 #define _EMIT_BUG_ENTRY				\
 	".section __bug_table,\"aw\"\n"		\
 	"2:	.4byte 1b - .\n"		\
 	"	.4byte %0 - .\n"		\
-	"	.short %1, %2\n"		\
-	".org 2b+%3\n"				\
+	__BUG_FUNC_PTR				\
+	"	.short %2, %3\n"		\
+	".org 2b+%4\n"				\
 	".previous\n"
 #else
 #define _EMIT_BUG_ENTRY				\
 	".section __bug_table,\"aw\"\n"		\
 	"2:	.4byte 1b - .\n"		\
-	"	.short %2\n"			\
-	".org 2b+%3\n"				\
+	"	.short %3\n"			\
+	".org 2b+%4\n"				\
 	".previous\n"
 #endif
 
+#ifdef HAVE_BUG_FUNCTION
+# define __BUG_FUNC	__func__
+#else
+# define __BUG_FUNC	NULL
+#endif
+
 #define BUG_ENTRY(insn, flags, ...)			\
 	__asm__ __volatile__(				\
 		"1:	" insn "\n"			\
 		_EMIT_BUG_ENTRY				\
-		: : "i" (__FILE__), "i" (__LINE__),	\
+		: : "i" (__FILE__), "i" (__BUG_FUNC),	\
+		  "i" (__LINE__),			\
 		  "i" (flags),				\
 		  "i" (sizeof(struct bug_entry)),	\
 		  ##__VA_ARGS__)
@@ -80,7 +99,7 @@
 		if (x)						\
 			BUG();					\
 	} else {						\
-		BUG_ENTRY(PPC_TLNEI " %4, 0", 0, "r" ((__force long)(x)));	\
+		BUG_ENTRY(PPC_TLNEI " %5, 0", 0, "r" ((__force long)(x)));	\
 	}							\
 } while (0)
 
@@ -90,7 +109,7 @@
 		if (__ret_warn_on)				\
 			__WARN();				\
 	} else {						\
-		BUG_ENTRY(PPC_TLNEI " %4, 0",			\
+		BUG_ENTRY(PPC_TLNEI " %5, 0",			\
 			  BUGFLAG_WARNING | BUGFLAG_TAINT(TAINT_WARN),	\
 			  "r" (__ret_warn_on));	\
 	}							\
-- 
2.34.1


