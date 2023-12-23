Return-Path: <linux-kselftest+bounces-2411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D2481D221
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 05:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E175B28359D
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Dec 2023 04:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5131392;
	Sat, 23 Dec 2023 04:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLE0ntR+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE61368
	for <linux-kselftest@vger.kernel.org>; Sat, 23 Dec 2023 04:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e20c9c4080so41586427b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Dec 2023 20:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703305144; x=1703909944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yzOnnfcizg793z1bTTo1OJr4lB84vx2e8wyRTapkvIs=;
        b=lLE0ntR+zEWFdzWCvjjUJmVDp9z8t5fnIdFrV38f2FiThoAvJBLHryywXJXO5+qXac
         N2uITMudGV9tdb5iVqLmidfUWAs4mMlV8HOW17lXU1YOmimXeyA6K6EiSpIP/pdtXNls
         feZp0uUeBwsEX8VLe8DYryVLIxVmv4uyZdPLnArjd4yfSXMnjysjAj+bFxaukaDaNQ1X
         Q9wbMkJjyehQcmwv1zGiH3viASULLZSOWZhPVzTaaMBUMFGTaH6yKtNo5DP3Z+LziY0S
         /wzqASgCIXrEPu7XoksvdDZsvZqLH/8po5kJptlXZm2K2Y514ppbcXFViBliLIyQIdoG
         WK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703305144; x=1703909944;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yzOnnfcizg793z1bTTo1OJr4lB84vx2e8wyRTapkvIs=;
        b=RlqxL3cXUviz192ozRLpm1e35JkffehDbzbWxu9sUk+9Xmmge+FGYTYCCQG0R+vVsq
         zM39C1XXMCM3FjBFLaHp2hY10eFJxl/XOZ4W3Sev6MrFtnXCZneVQCRGOFGmdS99lh8d
         epLCv29jwjg0VcSqSBnpq6IGeN27rnUP7eelG+UJzzIblavE+PA+adyoNIzFp/NlyLS9
         l7JEl2ow1p0rKLwN4dTvZdNq8QsNwnGCc8z8zoMQsJEnjlH9Tb0Fx4KSbp3nu6g1lXSX
         e8hrgVtAybFlawGN5jV6eyyRtfoSixgAOKXv0lZoojSaxYXEhz0xh3ileGEdn2qAut1e
         wDPQ==
X-Gm-Message-State: AOJu0Yxl0YPQwTZTpFNezp93ltRaMI5ATnl2lWiy80iPdUDxRr3QCn4k
	h1TMFrMKvGXtZU7uFT+4ISObCvyf/ItLYMjvCGZm
X-Google-Smtp-Source: AGHT+IHGponKp0XQTyzs9vH3r6ydI9jS3rtBdIKJ69/XZfN3KnpaJcoZkLX2kT/Wy5dYTgSdwfJ+hALF20xOPA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:690c:3389:b0:5e8:90de:db6c with SMTP
 id fl9-20020a05690c338900b005e890dedb6cmr1246726ywb.1.1703305144116; Fri, 22
 Dec 2023 20:19:04 -0800 (PST)
Date: Sat, 23 Dec 2023 12:18:58 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231223041858.1991349-1-davidgow@google.com>
Subject: [PATCH] kunit: Fix some comments which were mistakenly kerneldoc
From: David Gow <davidgow@google.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Rae Moar <rmoar@google.com>
Cc: kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

The KUnit device helpers are documented with kerneldoc in their header
file, but also have short comments over their implementation. These were
mistakenly formatted as kerneldoc comments, even though they're not
valid kerneldoc. It shouldn't cause any serious problems -- this file
isn't included in the docs -- but it could be confusing, and causes
warnings.

Remove the extra '*' so that these aren't treated as kerneldoc.

Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312181920.H4EPAH20-lkp@intel.com/
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index 1db4305b615a..f5371287b375 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -60,7 +60,7 @@ static void kunit_device_release(struct device *d)
 	kfree(to_kunit_device(d));
 }
 
-/**
+/*
  * Create and register a KUnit-managed struct device_driver on the kunit_bus.
  * Returns an error pointer on failure.
  */
@@ -124,7 +124,7 @@ static struct kunit_device *kunit_device_register_internal(struct kunit *test,
 	return kunit_dev;
 }
 
-/**
+/*
  * Create and register a new KUnit-managed device, using the user-supplied device_driver.
  * On failure, returns an error pointer.
  */
@@ -141,7 +141,7 @@ struct device *kunit_device_register_with_driver(struct kunit *test,
 }
 EXPORT_SYMBOL_GPL(kunit_device_register_with_driver);
 
-/**
+/*
  * Create and register a new KUnit-managed device, including a matching device_driver.
  * On failure, returns an error pointer.
  */
-- 
2.43.0.472.g3155946c3a-goog


