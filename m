Return-Path: <linux-kselftest+bounces-2004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E79814296
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 08:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3959D1F23E37
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 07:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89024D535;
	Fri, 15 Dec 2023 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4M406bEs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3FF10963
	for <linux-kselftest@vger.kernel.org>; Fri, 15 Dec 2023 07:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5d1b2153ba1so2238487b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 23:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702625963; x=1703230763; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ3XYd4VAh0rMwZdPZnf0/R4/jXxDQ1RiH7pfcHiYc8=;
        b=4M406bEsdMF6O3NRYBNV0wD3FBpWItAMUWZdgyj29cY5Bsaecy5YDs0h2B8ApR8Uz9
         8XuPdszBhfvNpgEEWWDE6df7Z7zMRWgPOAZNjcd0xZeQkoxRczhnXOT5lxkSqXkP1uhY
         FC3n6HG6YnzcuiSyL6rxUiouLm7ywgAkZRroHB7aggZ4RdM76a/vy8tEGPn5cLToLoi2
         pz6c4hcAJq6Y0soTQS5Y72IRGWW/PNlHlfhGByc5xfjrydePSep2ecgVVrMiJnI1hAbl
         Iq4Mi3JwVzP56tcPtYd6B+M8PPKiTsJW8EkyTUZ28Q2yE3WYsZc4S3oJXiRl7+HQZB/g
         CKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702625963; x=1703230763;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ3XYd4VAh0rMwZdPZnf0/R4/jXxDQ1RiH7pfcHiYc8=;
        b=psAwUTv5T58pw7AB9wPqWx7cwE3ctZR9VpwPVb8TwCKUW//mfoaAUmWgsWO48h5Xl4
         Zgbt/BXJp7Jc8I78+1iZWclHRhrOayeVVfa8oJfVMrm3Sm6bxUNWA089ogC8o+ft00zx
         8Qjv3JFtCXS/UEr+aNbluB4uMiMoXljmmRxBT1HqB5+//cGDBP6Lk3QU+lkWYG7BStR1
         Ihk6e4duVFNAGNgIi55N7m2Ek9zxsRTngVwNa1g6MEHCekvbnkyizSDqQWs0vZWdGERE
         /PpW2Za9UNYHV6aVF7TBesKN7y9lFhhLa6oi8+XtmAY+tWP9YCgwbY1n/TKS9qQIiZ/m
         O2Ng==
X-Gm-Message-State: AOJu0YxOYFj1kyUVIXGyP8QM3bywfmHthQ1nFFGTkwqCuwPx9IYXlJbk
	bnckTbsZatj+xpeeydhuvrZV2KzP87L90w==
X-Google-Smtp-Source: AGHT+IESolPUWUjcu8ehVBMVbwsHg0hbt8xH+da+fFZstOFajYilu1HiXZJcR+VkbSIMMfIUvRBPM/Nns0DS4A==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:690c:3604:b0:5e3:d2af:8b78 with SMTP
 id ft4-20020a05690c360400b005e3d2af8b78mr27176ywb.3.1702625962892; Thu, 14
 Dec 2023 23:39:22 -0800 (PST)
Date: Fri, 15 Dec 2023 15:39:09 +0800
In-Reply-To: <20231215-kunit_bus-v4-0-4f5160e2f95e@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231215-kunit_bus-v4-0-4f5160e2f95e@google.com>
X-Mailer: b4 0.13-dev-099c9
Message-ID: <20231215-kunit_bus-v4-2-4f5160e2f95e@google.com>
Subject: [PATCH v4 2/5] fortify: test: Use kunit_device
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


