Return-Path: <linux-kselftest+bounces-11179-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174B28FB252
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 14:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E5CAB242E3
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 12:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360B146D63;
	Tue,  4 Jun 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xd+73NHF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EAC146A9B;
	Tue,  4 Jun 2024 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504371; cv=none; b=dB5YXVyWkJ79Yjj1YBJgPYkcepkZaA8df9t2HSlBhdJ0KgHPrtWV9Pm2IQbN4unafQ5Le0GzJHHg18LNDgXFop/jXgWdGdH8AU6IapFbx2IHrSkdv4mOY4hoGkknQx6xb0l/5YzI8IrPwWR2emy7IesvIeZJvnwh+YyUOj3szSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504371; c=relaxed/simple;
	bh=WwmjeOQu72FaUg1dfsnXq/tC9I4b3h2WVybb3KIPNKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KrEDFfFUJFc/6Y3cm0UpgbhYVzm0rmCOYUsR7sHWx9t8P+6BfVBBni5zWgJo+snGztgWffXztmxfB6IYdf5vi0BL9JL0ZBZElsVoRpK1ueSpacCekcieo6t7jE4etopgsHQzeZAB8hB85DRwLY3Ec5teFaj3iYg3TE2e0/f5T8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xd+73NHF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42111da672eso6641635e9.0;
        Tue, 04 Jun 2024 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717504367; x=1718109167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hm8JZD/Uu53KILH4Z+apiOCSWKZ89tmhz9RtA/wLq8=;
        b=Xd+73NHFMjM8sSXy0Ss2BEK6Q7Ux4B6MUsNgNfmEbTK1ZX0xAzEsAx8sfYWIv01k6Y
         NjBrKJtdvWJffkDF43EEWvi0BA8RA2s75rUeT5Gd4RbEXe2isbHszW614C4W2MlcEGA1
         6y1+T1YCh61l+tVKzubDtBDutGm8Mmo4l5UybwC83ncTYyaGxDCYVnWugm6g7RXVsvxf
         A5VVGp1sR5zUKAcNt01XFBjlsft9O9vKpSuqPt0/gCPY7Q+4m17ifoBF33rPeq6rCTmG
         2h6aMHMuXT1cbv0eC/i8DnC04fK2q4OpqD1D2HowW5sMfD4lxdiCkl2uubJi8VcZIwif
         s5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504367; x=1718109167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hm8JZD/Uu53KILH4Z+apiOCSWKZ89tmhz9RtA/wLq8=;
        b=Z3VSAb03/eDnvkLQMsY9J4ywwwzXWrXTaW10qy4TEAN/yTq6MkSgNApEnIfsYtyhCh
         yaqe5dVFL9endE7FnNAN8fbJirVTG4+CWM86rFQ66//lQXVH6Fq/vsoFG8mI1+it4ykP
         ZRv5F/ZyXQRLDXkZpCpVmxbizNbDa20Wacj9przA0JZG1KbVZ+Dry99sBtKDSaR/ECl3
         DZP3eHSe0YLsyQFaCuKBOZfeZLhX8C1Plz/397h3ya6uhmgj2sFAiMXk0fzC/S1FCOa/
         Km3GBi1i3qCsVidjhKnnKYfMtKxgWtTsuFR42e1OCXuFAnDvw68iKkcTkNa+CABA20n0
         6SeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA4ar67y2fCCf4Mn3BM+HgtdGpLp+Q5kw7lrMXflHVRiECYnf/3v4JlcxbHKNrhbrkoOb5/NK5WjWjzwEPViJFtLU2paL9dJkTgjryYeH/W4Zq2T9+/Zei3XkJae49e8jhXD2CnDOS7LFMXHHF
X-Gm-Message-State: AOJu0Yw/tpAnqW+bwuwg7UDkdrOQBUMp9UwmxiWmg0HHvqlJ+26Kwix/
	gTA0iL/Q2Nng8jTlLlD3KPQQixmFQ4PA0I6n8oFbm3vqvomZRURX
X-Google-Smtp-Source: AGHT+IFY+sD7IjToSbM9mBDxRiXhglvCWpFcKPGlj2cppS5xmG904hULLwsLKMYEg4ipIaZCyhJnyQ==
X-Received: by 2002:adf:e289:0:b0:359:79f1:bab4 with SMTP id ffacd0b85a97d-35e0f30c9c3mr7466982f8f.3.1717504367544;
        Tue, 04 Jun 2024 05:32:47 -0700 (PDT)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e535567e9sm7209179f8f.21.2024.06.04.05.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:32:47 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] kunit: string-stream: export non-static functions
Date: Tue,  4 Jun 2024 13:32:00 +0100
Message-Id: <20240604123204.10412-2-ivan.orlov0322@gmail.com>
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

Export non-static functions from the string-stream.c file into the KUnit
namespace in order to be able to access them from the KUnit core tests
(when they are loaded as modules).

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 lib/kunit/string-stream.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 54f4fdcbfac8..a5e3339854da 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -10,7 +10,7 @@
 #include <kunit/test.h>
 #include <linux/list.h>
 #include <linux/slab.h>
-
+#include <kunit/visibility.h>
 #include "string-stream.h"
 
 
@@ -86,6 +86,7 @@ int string_stream_vadd(struct string_stream *stream,
 
 	return 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(string_stream_vadd);
 
 int string_stream_add(struct string_stream *stream, const char *fmt, ...)
 {
@@ -98,6 +99,7 @@ int string_stream_add(struct string_stream *stream, const char *fmt, ...)
 
 	return result;
 }
+EXPORT_SYMBOL_IF_KUNIT(string_stream_add);
 
 void string_stream_clear(struct string_stream *stream)
 {
@@ -113,6 +115,7 @@ void string_stream_clear(struct string_stream *stream)
 	stream->length = 0;
 	spin_unlock(&stream->lock);
 }
+EXPORT_SYMBOL_IF_KUNIT(string_stream_clear);
 
 char *string_stream_get_string(struct string_stream *stream)
 {
@@ -131,6 +134,7 @@ char *string_stream_get_string(struct string_stream *stream)
 
 	return buf;
 }
+EXPORT_SYMBOL_IF_KUNIT(string_stream_get_string);
 
 int string_stream_append(struct string_stream *stream,
 			 struct string_stream *other)
@@ -148,11 +152,13 @@ int string_stream_append(struct string_stream *stream,
 
 	return ret;
 }
+EXPORT_SYMBOL_IF_KUNIT(string_stream_append);
 
 bool string_stream_is_empty(struct string_stream *stream)
 {
 	return list_empty(&stream->fragments);
 }
+EXPORT_SYMBOL_IF_KUNIT(string_stream_is_empty);
 
 struct string_stream *alloc_string_stream(gfp_t gfp)
 {
@@ -168,6 +174,7 @@ struct string_stream *alloc_string_stream(gfp_t gfp)
 
 	return stream;
 }
+EXPORT_SYMBOL_IF_KUNIT(alloc_string_stream);
 
 void string_stream_destroy(struct string_stream *stream)
 {
@@ -179,6 +186,7 @@ void string_stream_destroy(struct string_stream *stream)
 	string_stream_clear(stream);
 	kfree(stream);
 }
+EXPORT_SYMBOL_IF_KUNIT(string_stream_destroy);
 
 static void resource_free_string_stream(void *p)
 {
@@ -200,8 +208,10 @@ struct string_stream *kunit_alloc_string_stream(struct kunit *test, gfp_t gfp)
 
 	return stream;
 }
+EXPORT_SYMBOL_IF_KUNIT(kunit_alloc_string_stream);
 
 void kunit_free_string_stream(struct kunit *test, struct string_stream *stream)
 {
 	kunit_release_action(test, resource_free_string_stream, (void *)stream);
 }
+EXPORT_SYMBOL_IF_KUNIT(kunit_free_string_stream);
-- 
2.34.1


