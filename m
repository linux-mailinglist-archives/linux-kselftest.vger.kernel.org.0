Return-Path: <linux-kselftest+bounces-1774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEDE810728
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 02:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76B24B21027
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 01:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909A5A49;
	Wed, 13 Dec 2023 01:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i53XthTO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F25BD
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 17:02:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcc6933a14so733408276.1
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Dec 2023 17:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702429328; x=1703034128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kZ407BZUjf1nTaNFv/lydV9QLh6SjAtGxOmdW2rHzpg=;
        b=i53XthTOpyTBdUW+WiFagcPjBQVVp1FQbf/Ac6dvZRCLoO214u+pR88jZvpPunzb/j
         6ogryEcMMLo7NnnI/1Hi2dwpnTTzvp133rdOtzdcAdJiUqwGH1BUc9pN7I1RGKl7JMEm
         fEjV79dNoj2OZObewmepN2iIyQ0aw/mAYBpkId06kaKdh1dvLaun0GmrS5D9pphhAyuy
         yyaBTcvenIIbm1DtdJM9nBFad3k7LfKK5+wL7Aip2tsviBQFOhaW/M3Hxir3f7XgmQIp
         A5iVEa1iap5Seut+NPBVGk3guo3ww84uO0kvk6cxn++AQPiUBoUET3QLaS6X438YJD87
         zPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702429328; x=1703034128;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZ407BZUjf1nTaNFv/lydV9QLh6SjAtGxOmdW2rHzpg=;
        b=US8RR/2+cOWZENs5auX9ZxKYzorqC55RBcPDPg0HXZT7eySSGLnTW/NTrzDgngH+Iy
         5BCqx6q0ce5NNNcEPVj7xS0Th0xnCOdfjsLocabfvbLI8rDFEu2Gl+SFDovNXvmLfOfd
         OW5R7ReIek6lFSfwKoDSOPV+WGtIwre1/9PohaCz4m+vuWm8fVZSmhe3PawK31K9cSR/
         zjW4d+4P1wkHAeEn4qTln33o6gyi3ZcY4TePn6QDWLD2BDfRU7a/yClp5ETRjrFvRPFB
         9herVT8B2YvmX1yAHoqctPUgqAC7ghZo9CCk7TM5pTzzKMfLOBmu8bdFt9GxGi3pU1tT
         jKWw==
X-Gm-Message-State: AOJu0Yw3fMmehI+gDG5+R9fmLMtTxDnEpPbihJVI7cVuGM9lzpZuJKJ+
	LD4MQgHTd98DZIz3b4G07k7b6+twKw==
X-Google-Smtp-Source: AGHT+IGqh6A2C4LBDSwxDzJVO+NoByY9A5DvrqbepeEPTSZPaqsmWW9SaiNRK2kz6afSq5yi/8IqEI4wGw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a05:6902:343:b0:db5:f536:17d4 with SMTP id
 e3-20020a056902034300b00db5f53617d4mr46384ybs.11.1702429328425; Tue, 12 Dec
 2023 17:02:08 -0800 (PST)
Date: Wed, 13 Dec 2023 01:01:56 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213010201.1802507-1-rmoar@google.com>
Subject: [PATCH v4 1/6] kunit: move KUNIT_TABLE out of INIT_DATA
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, dlatypov@google.com, 
	brendan.higgins@linux.dev, sadiyakazi@google.com
Cc: keescook@chromium.org, arnd@arndb.de, linux-kselftest@vger.kernel.org, 
	linux-arch@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Alter the linker section of KUNIT_TABLE to move it out of INIT_DATA and
into DATA_DATA.

Data for KUnit tests does not need to be in the init section.

In order to run tests again after boot the KUnit data cannot be labeled as
init data as the kernel could write over it.

Add a KUNIT_INIT_TABLE in the next patch for KUnit tests that test init
data/functions.

Signed-off-by: Rae Moar <rmoar@google.com>
---
Changes since v3:
- No changes

 include/asm-generic/vmlinux.lds.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index bae0fe4d499b..1107905d37fc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -370,7 +370,8 @@
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
 	BPF_RAW_TP()							\
-	TRACEPOINT_STR()
+	TRACEPOINT_STR()						\
+	KUNIT_TABLE()
 
 /*
  * Data section helpers
@@ -699,8 +700,7 @@
 	THERMAL_TABLE(governor)						\
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
-	EARLY_LSM_TABLE()						\
-	KUNIT_TABLE()
+	EARLY_LSM_TABLE()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\

base-commit: b285ba6f8cc1b2bfece0b4350fdb92c8780bc698
-- 
2.43.0.472.g3155946c3a-goog


