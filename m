Return-Path: <linux-kselftest+bounces-1423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B4480A04C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 11:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5112281952
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 10:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4361426D;
	Fri,  8 Dec 2023 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDr9tcj4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43EA1735
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Dec 2023 02:09:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-daee86e2d70so2584295276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Dec 2023 02:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702030197; x=1702634997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ3XYd4VAh0rMwZdPZnf0/R4/jXxDQ1RiH7pfcHiYc8=;
        b=VDr9tcj4StnA6acjRdrtszhpigA+LyEHfIwbdwp5vEDSLyQ2c06X0f1qayIhI8+EAM
         r6FhkDaaKJDAFG2WPAqaLSFgFJYgJTQmwSinohvw6fX9JU05gn1piF4HSMp1QyjuD+hc
         LlgfLm9xm/qiGoZ+JYDrryT6EFNdLOCNWFYWUNJJIkjz86006ehBfhgbvosPV1O4WBPU
         ABaqxj2OzKfF8pO28M7kbucpENFfkZVMQ+R/GvWK0j/oeVPrTz99IIeQ5nRoaxIhWa7G
         qQ5dED3iTrJbm5hEMRwp3R0L563dY3XUizJ0DaECRNx5LvnFnzhjznIrwqajOL4Tp+9H
         x8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702030197; x=1702634997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ3XYd4VAh0rMwZdPZnf0/R4/jXxDQ1RiH7pfcHiYc8=;
        b=JjtkgLWChSwJAU4zdJY2g5IjDLlO+WpKQNERPy44wdBrlijITtixYMT/WFtDi5xO1O
         keKQcNviaRIuM+870Zid3aLwZhKnp3iaOfv0Dj/AdEehTi/Sf8MuxdcfYqJJAzDkCkj3
         29sNzqhaIH1Z8PGmGadjq800a7VPdbw03iWBl7MBRsdi+tllWw8FjvscfEMqr15kBILZ
         d1fXCES48IRyHG1es86S9ZyTzXIIdoIKyB3Jv+2eVpHP7FWajpQbJmRZOS6k+Va1dSQp
         a+rxxMLZzo24BkVnlweitIBfeJSlsVPSXnuAyRKSfhli6Yp6mJAZaU/QdeMxMY8PjAxu
         r+Vg==
X-Gm-Message-State: AOJu0YwUnQQ//9TdaVaeVJsHMdEak/3web5xi0nlwZEMWDPWiUkEdZ+5
	EQ1QgdfzMwso8CUz0h+QXx905s6t6LneqQ==
X-Google-Smtp-Source: AGHT+IEoLvJsRYtYBtpiMYYBRwRZCWLln+T0Te5bpJ5ZhKJL6iGz1n9WIFhdhIvRsrqNCPNn+H/9E0PqoIsEoA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:fc12:0:b0:dbc:1b65:fd8c with SMTP id
 v18-20020a25fc12000000b00dbc1b65fd8cmr43469ybd.5.1702030196750; Fri, 08 Dec
 2023 02:09:56 -0800 (PST)
Date: Fri, 08 Dec 2023 18:09:30 +0800
In-Reply-To: <20231208-kunit_bus-v2-0-e95905d9b325@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208-kunit_bus-v2-0-e95905d9b325@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231208-kunit_bus-v2-2-e95905d9b325@google.com>
Subject: [PATCH v2 2/4] fortify: test: Use kunit_device
From: davidgow@google.com
To: Rae Moar <rmoar@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org, 
	David Gow <davidgow@google.com>
Content-Type: text/plain; charset="utf-8"

Using struct root_device to create fake devices for tests is something
of a hack. The new struct kunit_device is meant for this purpose, so use
it instead.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/fortify_kunit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index c8c33cbaae9e..2e4fedc81621 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -15,6 +15,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <kunit/device.h>
 #include <kunit/test.h>
 #include <linux/device.h>
 #include <linux/slab.h>
@@ -269,7 +270,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 	size_t len;							\
 									\
 	/* Create dummy device for devm_kmalloc()-family tests. */	\
-	dev = root_device_register(dev_name);				\
+	dev = kunit_device_register(test, dev_name);			\
 	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev),			\
 			       "Cannot register test device\n");	\
 									\
@@ -303,7 +304,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
 	checker(len, devm_kmemdup(dev, "Ohai", len, gfp),		\
 		devm_kfree(dev, p));					\
 									\
-	device_unregister(dev);						\
+	kunit_device_unregister(test, dev);				\
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(devm_kmalloc)
 

-- 
2.43.0.472.g3155946c3a-goog


