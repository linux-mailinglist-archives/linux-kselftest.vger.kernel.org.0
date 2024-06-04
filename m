Return-Path: <linux-kselftest+bounces-11182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E68518FB258
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 14:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C651F214C6
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAB81482E7;
	Tue,  4 Jun 2024 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OANPKk/6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117EC147C76;
	Tue,  4 Jun 2024 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504376; cv=none; b=l+vdAt9KZBzIWUOvysIy09Ek5u8IavodRjxxS0suNwT7J9l8XpgBicRs3CU/d2y02MuQguBiK4u7Cw2C4JBCeq7pftLrOXq1xKN6iGZjkDUHwFIBzkyd8VCPDpR0bBzwA8LSNlqf3ME7TtyZ983w1xqj+q6UXMEA7gJ2o8C+R/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504376; c=relaxed/simple;
	bh=8l84IiSkdT4NCQTONJ+krCv3ALHT7sKoSDUEmuB3hQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CScMClvlGOKj1IsSphiZvfvltR7RCZlP6c8yj8iOYAZZt0A8/QM/lA6arzEccZWcWJSB/6IgnUPD5m6Z2IYHsQQmpDPtMWgO9go6GeEnD9Iv4LiJwsiT3ipBM3oA15AivzTKJxcqbUZasw4+1SNd9abk0jsMPt97y5kwmZzomoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OANPKk/6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42152e2d384so364825e9.3;
        Tue, 04 Jun 2024 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717504373; x=1718109173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI5LoNcYQivAnNze7yHQ7N0aSL5De3/uw+ZctyPJStE=;
        b=OANPKk/6700BegFV3r5CIG169rv7/tu4tXoYproWS1+ydXvXp8+o//FkPTU6wBavTF
         K7UnsijaRJC1vGdt9uJe5MOHIBYY0kIc9onpBpBJ4nGV3XIpYJgFIp8KUXE6MBcKY9Dc
         kXLxxYlqBckmwALewB8293+pIr7rcm+ZTNiAYo0V9XjrJXJ41SaSM0U2iWHCEReM8bnE
         A6fPokKTcyRphAvrrpGwPgxCZyzOD9qRk7pGH9TL5abO3xn/SHclzBCaio0lk5cX7HmJ
         FeGDnqAHwOJioazQ1pe2RB8QM++Vp3yPjUvkrcCTF8UqQ2x0/B1u+K5zf2iiE+KhEWaY
         e8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717504373; x=1718109173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI5LoNcYQivAnNze7yHQ7N0aSL5De3/uw+ZctyPJStE=;
        b=VwmxFlIw4szCpp1snI4UO4dqISfulSJXNaTsvM2bRuKBzUTlEdlSwDnvmThos67fp3
         LdkDt2l95kriyrSqESPrTEFnIH7F6y3vLZYHRmLBBOEF7GnaXBWaD0OFBErsB5VCLPnm
         KFVVhTHisabDrL882tTMziZJ8lczhaLB5m3GRqwYC9Dxt8ZquEfCFY009nFmcwmgThSD
         j1BprALl9XNKKr42tjFbhQLn3OBhGSWQtX/nTeXzAvptJD/E8B9ojL50a/hpEX9A3EL/
         H0pA+MJYzQ9hJPgZTXVdBn3TX92hXB97RPnpU5Cx89853jk9Zi/4z6XUfOYZJN9icHZL
         /v2g==
X-Forwarded-Encrypted: i=1; AJvYcCWy4yKjZtQVl4UInglQAC6eUxVObrag/EwpuyNFpog6rAhPolssR4qIkJId5bzKqH/2a6BQvgTy4jBZ+EGItTKHNjrFRCJk47txdLDSyTAD2lNphIqhSuhBTqdHdP/1M23btfnUvotU6qsGVFCr
X-Gm-Message-State: AOJu0YwQT9dqIeu2sU8sdIoUB7/iGHHyV+88i/CBPiah1BouNDt/dNxf
	nJyzULVToCLCpKJRYUBK5/7LSJmTMj9P/NvmVCG3SNE0QXkQO8hw
X-Google-Smtp-Source: AGHT+IF7e+otMbfOkeziWjPXugKhtYVwF5NfTIElBb0knNAgix9rgln0wV1tQXGx+/BEaO3dTldEgQ==
X-Received: by 2002:adf:e38a:0:b0:354:fa0d:1422 with SMTP id ffacd0b85a97d-35e0f2590damr8384064f8f.1.1717504373344;
        Tue, 04 Jun 2024 05:32:53 -0700 (PDT)
Received: from ivan-HLYL-WXX9.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e535567e9sm7209179f8f.21.2024.06.04.05.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:32:53 -0700 (PDT)
From: Ivan Orlov <ivan.orlov0322@gmail.com>
To: brendan.higgins@linux.dev,
	davidgow@google.com,
	rmoar@google.com
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] kunit: assert: export non-static functions
Date: Tue,  4 Jun 2024 13:32:03 +0100
Message-Id: <20240604123204.10412-5-ivan.orlov0322@gmail.com>
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

Export non-static functions from the assert.c file into the KUnit
namespace in order to be able to access them from the tests if
they are compiled as modules.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 lib/kunit/assert.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 867aa5c4bccf..f394e4b8482f 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -38,6 +38,7 @@ void kunit_assert_print_msg(const struct va_format *message,
 	if (message->fmt)
 		string_stream_add(stream, "\n%pV", message);
 }
+EXPORT_SYMBOL_IF_KUNIT(kunit_assert_print_msg);
 
 void kunit_fail_assert_format(const struct kunit_assert *assert,
 			      const struct va_format *message,
@@ -112,6 +113,7 @@ VISIBLE_IF_KUNIT bool is_literal(const char *text, long long value)
 
 	return ret;
 }
+EXPORT_SYMBOL_IF_KUNIT(is_literal);
 
 void kunit_binary_assert_format(const struct kunit_assert *assert,
 				const struct va_format *message,
@@ -180,6 +182,7 @@ VISIBLE_IF_KUNIT bool is_str_literal(const char *text, const char *value)
 
 	return strncmp(text + 1, value, len - 2) == 0;
 }
+EXPORT_SYMBOL_IF_KUNIT(is_str_literal);
 
 void kunit_binary_str_assert_format(const struct kunit_assert *assert,
 				    const struct va_format *message,
@@ -232,6 +235,7 @@ void kunit_assert_hexdump(struct string_stream *stream,
 			string_stream_add(stream, " %02x ", buf1[i]);
 	}
 }
+EXPORT_SYMBOL_IF_KUNIT(kunit_assert_hexdump);
 
 void kunit_mem_assert_format(const struct kunit_assert *assert,
 			     const struct va_format *message,
-- 
2.34.1


