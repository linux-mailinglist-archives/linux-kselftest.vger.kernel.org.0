Return-Path: <linux-kselftest+bounces-12163-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CA290DA38
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 19:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA431F24151
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625AC14431B;
	Tue, 18 Jun 2024 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzyqog9F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B394413DB8C;
	Tue, 18 Jun 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730227; cv=none; b=f92qkjVPLGGMLskHNtEmz+tPz0mXRpFhnEsW4fuxEAx4Z1YnP2SbqFIAVFf1u1f2Xhk7QsZGUZvV27VfepndETYCudtCx4BN5sernmf83ucqu/SH6Js7x5nlLUixEGmOILX6l40c3a3ooHdy6V+eiZtmW6qsTCjGeHE1ucEpp2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730227; c=relaxed/simple;
	bh=y77maUkMDgNMGrIAaQkRG4WelBqtE6wMoJVHqbH+lrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZUcabtYUbATvlXp/MnggvEJg/S7AwX6kDNC2iHuUt5qHOV95ZQLHpkGnB0qhpjjbf5xQyFbkOp4N4hQsulEkIEwF/JP3cuF/M15KQirCgQt5rz4KRYgseXai5lstEfK7P2+tyITyYPKtWsYaiNYzEq6r/xLZZIlnj3vbHBjfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzyqog9F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4210f0bb857so5347535e9.1;
        Tue, 18 Jun 2024 10:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718730224; x=1719335024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXiw2cg2WvBZ7niIviAA2vybXATvCHwxCpkgD4X21ig=;
        b=Jzyqog9FJ9UIRcZgz8BkRYA3I7DZfTKup33mYXPzkmGw815TBGK1NKmQ4tdYugjddJ
         +t6RA1CVpS388/Gn0XBHAVxi7D66AbXKS0698rJRIri6qknNXXIWbm0XmYVdPmx4YykI
         QdtA5wjH8X0TX52BVy6biF2XQ+MvH686P1/Q9BSXc7xL3ldM4Qw0dEhhbEaH+EXOw/RR
         AIuRAdGkKbOSQxefAp9tTw3ZmcW6Irx3emaiwGoWNxh3pBa8gtNWTIOnKC5AKkR/IyHv
         hmT3FTE1Z2Dns3/DjV/M8OsFd/G0Z+/zHazEo8EBTDws6zMEwVfv4opPeWB4VYCFZcMK
         Hrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718730224; x=1719335024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXiw2cg2WvBZ7niIviAA2vybXATvCHwxCpkgD4X21ig=;
        b=PO5hVQ727En70H+pCQjRrXCp7tzqjXIvK//+X6PuYziIiP+e/GX8fv8woCFGL24hhh
         98KEFoGOghmLG5qgusqQYgLzxljZvFYrPIGDs6cF7JJ2oDL5/sruvSnDvKtcVYfs7UhQ
         zTpq5bb/mgYMbBE46YYdByC5+DG7kyUPA0RpZ4jZho+IK1zQy8IcBkd32ZOnLACTYsz6
         0hraHTBORo1naa9piC/IcpJW5INZNNAxj/PsS3iMVrsgnIT8IeUZtZNJVMscJUX6ktpO
         dn2177i8X988UqfFD/erFprXL/O6xuTk43TkqZi/8b+nXZcDm0bl6gToryckF8/if4ea
         juoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeytSkgvl94Abrjkkp1TP1GILHpQNtqtdl5inqWrh+Fx1NRu0Q258F4Wy5ZSXsq8Rh2YxeWIAn0uGqTMpFIdk2YMrQ/zoo211+sRlu1R71xuXHaANClC8u45tdquFp4eSXqSQuLsBqe1oYkON2
X-Gm-Message-State: AOJu0YwnuE5YqahipZOt0/gqsR47hji+78AcRBNHSLDQ/W7P73kfH5jS
	uoUIR8nvamx/fa5U6PDGT2aFgfjDmPIn1EkZV3bpPzKMK4CN8MrW
X-Google-Smtp-Source: AGHT+IF+1V7Qh6xybIcGMh1MFuiBg9tdjlU4c4sAtl2CjAU694Djj8nNbKLBCydNtbkGm433lt8OtA==
X-Received: by 2002:a05:6000:2c3:b0:35f:1b2f:8697 with SMTP id ffacd0b85a97d-363170ed553mr156121f8f.1.1718730224049;
        Tue, 18 Jun 2024 10:03:44 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:9a30:967d:12af:741a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075114dcfsm14526163f8f.114.2024.06.18.10.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:03:43 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 3/5] kunit: string-stream-test: Make it a separate module
Date: Tue, 18 Jun 2024 18:03:29 +0100
Message-Id: <20240618170331.264851-4-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618170331.264851-1-ivan.orlov0322@gmail.com>
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com>
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

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- No changes

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
index 30f6bbf04a4a..478beb536dc9 100644
--- a/lib/kunit/Makefile
+++ b/lib/kunit/Makefile
@@ -19,10 +19,10 @@ endif
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


