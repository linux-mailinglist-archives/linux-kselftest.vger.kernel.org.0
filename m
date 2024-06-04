Return-Path: <linux-kselftest+bounces-11181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D658FB256
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 14:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BCF1C20E6F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 12:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EE3147C85;
	Tue,  4 Jun 2024 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbokmere"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1111474C4;
	Tue,  4 Jun 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504375; cv=none; b=N5xhFut6FBObf35JxZ62ORvBGfBtA+d6LuaEnGdNDn/KrtF9JW9Svmq+xM80hqJerCHXPZqfSFufMb4csxl1LOrlB+nNFuphPb0U+c5k2Pa8W0eLWmKpIUjIHftq03elf6fhFkJEfD5E2PxipEEpKbF0PitN0wXef0AT1Ypc0V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504375; c=relaxed/simple;
	bh=SummDxouOGlU7IgU6AXvmDabJn0ASZr5+1Pu30VLmLg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dx7Ku8GjbDeAwquofX6e0bcLdTGbF4ufXGkEoIZgdjfL0LN59FwGWmzdjxHWSgi4+pycbyeHLCIy7+E7sTO7PEzpVQH8j/ZWOIZ3MHclUjOqKSUYZVI3lLjt9OBlS4F6DV2yePHOx5tMaJPpmGvUiv1vBZE4rZP1g7q5+UgD3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbokmere; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eaaa3be101so3842131fa.0;
        Tue, 04 Jun 2024 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717504372; x=1718109172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj+nK1mCKwm8YE53nt8me8RE7m7ZJlrzUOfVRauTT1Y=;
        b=kbokmereWHltRD4E/iPdVncHIlXPoZNZ6EH2Th4TKLUbNW5PJ+xVPODWrjROjmFpXA
         3G5Z0RsPOAkD8pjiuxlzac7NS8sDs4CadlRiHNixRR0W1FUJLoEgp4a2AFTsYVCAWrbK
         RHfMNCC3ZMMsQFLtmOQvx101tjJ0z9+TmAcvq+ibjcX1wGeImhqNjr4DOw24oGPq+iWi
         Xn9o6rxhjnhdyxZuCz1F6m2GC8MxIckDg/SWoBXgc9Uw72ERfB9nPMV/ZUg2iZO7qQmc
         wXm8waU2DrYkh6ZIR4NqrO2ZY61HzBPB+PzBAY/18IaJOJZpn08awq9FOhk6MHNjaVhQ
         KAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504372; x=1718109172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pj+nK1mCKwm8YE53nt8me8RE7m7ZJlrzUOfVRauTT1Y=;
        b=WSPiBLFQwJYiYQLT0EESSJVqHFv1Cf6fN+Xwv9khO4b1rfXx2PHw+xRzvLPi32Xk4k
         dHRGakykLpv4AtkUAXnpc9BV0Xo4GBeCnlgkTLi+QACx3/Zbt7W6EY0bVZ+/XK29avi5
         c8m1c3MEnC6tgxD5W7ZAjBq6Zxrc35fy0ZLTF66Gi+3yBUI84JU1e8FE1H5ySl5p6X3a
         R086k8Fzv46XhDzUgDe4g5NTSbFGNtw5fvxW6QfR69Qb5NRK7mwvZiztI7uO50E3afR+
         95CVwwNbnf0XvvcAAaf8skB2j0L/0UMcZaTbKDQvL/pfJpJjlrXQx971PVTAkoUyz1L7
         02eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDD/TRLfhQUHisgBXywj1T0RBJon9bXTuXUogAKn5VL0St48x0CW0ylXM0/pDOSLADw1b6fXcfBP59lIQQE0zgLSIgDdwlTtGVmCQoSwetiyHujxZqmNdRpUh4z12LjUm5es40w/x4bQUNa2nD
X-Gm-Message-State: AOJu0Yw+29/ZW+ybSSSYe3iKMSKrdXBKGIHTMnp06FOxxIOZDEUY6DLY
	mEEVhmIlailUbISPp6ZG4QwjtjLYhXvAazoALUC0sXyJfhqrs+gr
X-Google-Smtp-Source: AGHT+IHcSXdDIh8lx41srPQud1VgcG+ztrz0/EsKzZCNwbU83kojtuotoQECws9hfEfQMcAclKpz1A==
X-Received: by 2002:ac2:58ed:0:b0:52a:b1d7:222b with SMTP id 2adb3069b0e04-52b89834f33mr6602472e87.5.1717504371787;
        Tue, 04 Jun 2024 05:32:51 -0700 (PDT)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e535567e9sm7209179f8f.21.2024.06.04.05.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:32:51 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] kunit: string-stream-test: Make it a separate module
Date: Tue,  4 Jun 2024 13:32:02 +0100
Message-Id: <20240604123204.10412-4-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604123204.10412-1-ivan.orlov0322@gmail.com>
References: <20240604123204.10412-1-ivan.orlov0322@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the only way to build string-stream-test is by setting
CONFIG_KUNIT_TEST=y. However, CONFIG_KUNIT_TEST is a config option for
a different test (`kunit-test.c`).

Introduce a new Kconfig entry in order to be able to build the
string-stream-test test as a separate module. Import the KUnit namespace
in the test so we could have string-stream functions accessible.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 lib/kunit/Kconfig              | 8 ++++++++
 lib/kunit/Makefile             | 2 +-
 lib/kunit/string-stream-test.c | 2 ++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 34d7242d526d..b0713c0f9265 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -45,6 +45,14 @@ config KUNIT_TEST
 	  purposes by developers interested in testing that KUnit works as
 	  expected.
 
+config KUNIT_STRING_STREAM_TEST
+	tristate "KUnit test for string-stream" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
+	help
+	  Enables the KUnit test for the string-stream (C++ stream style string
+	  builder used in KUnit for building messages). For the string-stream
+	  implementation, see lib/kunit/string-stream.c.
+
 config KUNIT_EXAMPLE_TEST
 	tristate "Example test for KUnit" if !KUNIT_ALL_TESTS
 	default KUNIT_ALL_TESTS
diff --git a/lib/kunit/Makefile b/lib/kunit/Makefile
index 900e6447c8e8..4793a3960f07 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -18,10 +18,10 @@ endif
 obj-y +=				hooks.o
 
 obj-$(CONFIG_KUNIT_TEST) +=		kunit-test.o
+obj-$(CONFIG_KUNIT_STRING_STREAM_TEST) += string-stream-test.o
 
 # string-stream-test compiles built-in only.
 ifeq ($(CONFIG_KUNIT_TEST),y)
-obj-$(CONFIG_KUNIT_TEST) +=		string-stream-test.o
 obj-$(CONFIG_KUNIT_TEST) +=		assert_test.o
 endif
 
diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 7511442ea98f..d03cac934e04 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -534,3 +534,5 @@ static struct kunit_suite string_stream_test_suite = {
 	.init = string_stream_test_init,
 };
 kunit_test_suites(&string_stream_test_suite);
+MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
+MODULE_LICENSE("GPL");
-- 
2.34.1


