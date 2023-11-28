Return-Path: <linux-kselftest+bounces-783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 339A37FC9D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 23:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBCEFB20D2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DB937D06;
	Tue, 28 Nov 2023 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsO10W1q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0287019A6;
	Tue, 28 Nov 2023 14:46:25 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-67a14f504f8so21906676d6.0;
        Tue, 28 Nov 2023 14:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701211584; x=1701816384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhpsd/CJqEzY2wViCgUIbvNNXzGivZKIEmu3PQkzhVE=;
        b=XsO10W1qy+mn6Jn2XJIxwFQda9GAd1l86NcOKW0FIS4X30PWcnafgnYBcgWvDd8vmV
         cEHV4GVANUDTvwghgrKVKMbsa3l0Bsb6sr711dGbC3yZsdTxnzGDVIBZbAxd71zsFU0X
         kVlkiAVgQ8+2Jni9zkyJp5udj0ibaduBnV3vIRWGiAJlYYaai8Ej1nk6BUd9b/TrPzz2
         q2XwUHj3SxV/WMRI/z+wpJvULjICgspCVH270Qv8nqsk5pIOtmtwSSwA+da3n+qJXEjY
         q8f3JArkkGXtN7ZW7Nm5Y88C77gCGfH4ZD92+hXBrFwJcegLmh0TFv2N0WoEvJbdwpHa
         HIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701211584; x=1701816384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhpsd/CJqEzY2wViCgUIbvNNXzGivZKIEmu3PQkzhVE=;
        b=G0sgdxHFCX8gkh2DuOsQv1cGeUr01l/hVnzhpYQAmRubCnnr6kic8u84N8PX9x97cS
         aBVP2CNo1/9E0ppdQrl3OKPioB3R90Rx74EI7hhjAoJ62HtBg6SoXQ5rHqmPEUFm6Gfg
         N14YcYWjRQYCWNUVpypCXwZjhmDvHB0yRifg6G0EbAQXlTTrCh03YGoH6J82+ZqvjbMh
         wTbNbY21TMp6JKzf26yA1jgB1GjcbbN2oOrDIa9G9FhHypbsCbgnlLHSV0vosYw8FH4f
         MPQY5EL0zZfNKuKQLuaAbX/8Nkz3XVd+WjvsEMgJfSsPX5+23CwBX4U3Kubc+CH82m9e
         HB3Q==
X-Gm-Message-State: AOJu0Yyea1pU+EMtvopn3YiC/puTfF5lCYX9TJg23VeBYiO4NBMAxBPh
	ealeoMRQmFVZtKVFqGT0Ha8=
X-Google-Smtp-Source: AGHT+IE6pRwhOTqRhINFN2eazXP7q4ErDCKPBsRwJZFUkJDiwFErGp8qdvqAseNy6DBU+RYnFDa6hQ==
X-Received: by 2002:a05:6214:806:b0:67a:590a:18f6 with SMTP id df6-20020a056214080600b0067a590a18f6mr3626618qvb.51.1701211584122;
        Tue, 28 Nov 2023 14:46:24 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id em15-20020ad44f8f000000b0067a543e6379sm1336565qvb.75.2023.11.28.14.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 14:46:23 -0800 (PST)
From: angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To: skhan@linuxfoundation.org
Cc: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	angquan yu <angquan21@gmail.com>
Subject: [PATCH] Fix Format String Warnings in lam.c
Date: Tue, 28 Nov 2023 16:46:07 -0600
Message-Id: <20231128224607.71334-1-angquan21@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: angquan yu <angquan21@gmail.com>

This commit addresses compiler warnings in lam.c related to the usage
of non-literal format strings without format arguments in the
'run_test' function.

Warnings fixed:
- Resolved warnings indicating that 'ksft_test_result_skip' and
'ksft_test_result' were called with 't->msg' as a format string without
accompanying format arguments.

Changes made:
- Modified the calls to 'ksft_test_result_skip' and 'ksft_test_result'
to explicitly include a format specifier ("%s") for 't->msg'.
- This ensures that the string is safely treated as a format argument,
adhering to safer coding practices and resolving the compiler warnings.

Signed-off-by: angquan yu <angquan21@gmail.com>
---
 tools/testing/selftests/x86/lam.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 8f9b06d9c..215b8150b 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -817,7 +817,7 @@ static void run_test(struct testcases *test, int count)
 
 		/* return 3 is not support LA57, the case should be skipped */
 		if (ret == 3) {
-			ksft_test_result_skip(t->msg);
+			ksft_test_result_skip("%s", t->msg);
 			continue;
 		}
 
@@ -826,7 +826,7 @@ static void run_test(struct testcases *test, int count)
 		else
 			ret = !(t->expected);
 
-		ksft_test_result(ret, t->msg);
+		ksft_test_result(ret, "%s", t->msg);
 	}
 }
 
-- 
2.39.2


