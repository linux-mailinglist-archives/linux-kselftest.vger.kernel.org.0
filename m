Return-Path: <linux-kselftest+bounces-12161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D7890DA34
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 19:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57E841C224C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 17:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7034913D50B;
	Tue, 18 Jun 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HspTQGey"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BAB446DE;
	Tue, 18 Jun 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730225; cv=none; b=q9hx78U5Aal4Nj7trtumKgYAkYb5+ndUEOx9ij0l1YW6ltX+hi2DqEcBuZteG4PWJicSz1HFNG7Wegg6uXvGTagjow1vyYQ4os5pM2PCK5hdOZ2D9Z+0VV0yLpIrHhVEuH+ZLv3NK4CcrdENymSYq6HVOmL7OB0YwDi4YhEsV5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730225; c=relaxed/simple;
	bh=7Lrm5+AWdaKxvEhiaBBcO4hr5S2usGXrWc1qJviviII=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HB6+tyuj0YQA06whdht0DpiOLnnJVJFG6gfRlXEzBRCyH+3JM3+lQiKLCzdHRRfPWoeAq8hwOW77G1LnoyJd9lNywZDFF4ifKpIIvjc6pK40J34hk2+qwsJfXsKBdzA/1CgUhkS+WDo3fTlglqWiImqFQ6jtRSzHv+ipmM4JuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HspTQGey; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-421de6e748aso3969645e9.2;
        Tue, 18 Jun 2024 10:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718730222; x=1719335022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6CkSNvbsbD/csGgBXiDgeAAjWGuLKCSHHlpvUyQacc=;
        b=HspTQGeyu3kgJAz1agOuxch/TLa10qcUIU+BrmSZz53phBKHJelWEMq4LiRrmhiFk3
         MxVUr2S5a+639cr4oUUZW3cEokhbkeSZvIznDOShV/MaxdatMNAHXOsX36BcZHPVyV6c
         LNZFnwcW8lRYZAouoSATG0YNWlj1yCh2rU/8gb/TyO1c7rFHeKnRGernPPqp01eS/TWu
         iQIrwWQzzx+l2o/troyg/9ExXXPnXFHXRdS4N54hFbqC8AVi1oFqqTYuaOS5nVnwMPRC
         qkI2FDTLj3TDFNH77IZ8oN1aVEfpyLeaadbC4JBXQ0QW+Caus86RrHw6EzsEFCqOBUJz
         h2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718730222; x=1719335022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6CkSNvbsbD/csGgBXiDgeAAjWGuLKCSHHlpvUyQacc=;
        b=ZEYFgWas+hjgxhHavPjzu5/tnSjxeNKMqXP98oDQEhDYphm2f1jDrHTrXg9k6opBaq
         GlEi5YEUEVRGOIdeyZd2aV93H6zoCgEW8bG+dZRuPfjWr3hz3aRdHfSqQW2BrNleJG3Q
         LuYkfPFpfrW/uTx1gMuWyMJcMw+VC3dXv72VuPVlp4khKXj5N+UVpQL6uKSiWv+iCvcL
         66N91/+6rjopD34L/RHWF6buan6OR2LzL4/mo4MCkHE548ZFb30h8V2gZpgLKdkU4DIV
         12/Q84kJ4h/Ehyfb25nCHyzziMg/xgZNXVoXulVmcOJB2i7vGZB3c5KGixHciDSq+9os
         z6mw==
X-Forwarded-Encrypted: i=1; AJvYcCVy9YTO6lVhmG0JmRPl9BPiQtcmPFE3yEH5PsXYCdXqcGztvn/XqqPLJZCBkKbtKZHl0tMp/4WBMXmSKEuKqRysX+EP/3ZV4cQdnIpFxZ0n4W3BCjAS2l6GyzqabJxpX698TDzkUHOXATAuJ7VU
X-Gm-Message-State: AOJu0YyTCV0F+K2kseVfsdIGVxA57La8s493pSaVOvjZqks98WnltSwE
	VL/bjgqDvzTgB7feiEAIwW9x/Y3zRv6+EI6veon4P9KblnsBBtxD
X-Google-Smtp-Source: AGHT+IGlVFAtHC9qlbI5WK1EHI7eHollSyTOqI/xsKWmEA8FNW359bwB+/O1qlRRmPaL2JeFyS+4bg==
X-Received: by 2002:a5d:47cc:0:b0:360:874b:af9a with SMTP id ffacd0b85a97d-363195b2c64mr127929f8f.3.1718730221728;
        Tue, 18 Jun 2024 10:03:41 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([2a01:4b00:d20e:7300:9a30:967d:12af:741a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075114dcfsm14526163f8f.114.2024.06.18.10.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:03:41 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 1/5] kunit: string-stream: export non-static functions
Date: Tue, 18 Jun 2024 18:03:27 +0100
Message-Id: <20240618170331.264851-2-ivan.orlov0322@gmail.com>
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

Export non-static functions from the string-stream.c file into the KUnit
namespace in order to be able to access them from the KUnit core tests
(when they are loaded as modules).

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
V1 -> V2:
- No changes

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


