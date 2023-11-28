Return-Path: <linux-kselftest+bounces-754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D91357FC811
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BA74B2106D
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 21:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0EF44C7A;
	Tue, 28 Nov 2023 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCtp6mL1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406282D56;
	Tue, 28 Nov 2023 13:36:18 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-77d708e4916so314314085a.3;
        Tue, 28 Nov 2023 13:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701207377; x=1701812177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+7egZpgbxWlQy7x1pNLLDFc7cb12zF09MZ6gXGVBBI=;
        b=bCtp6mL1ul/UWguDZAwtY/6sx3jH4/Ej34/IZyhHTEd0nU2A7WGCyP5nl0Nuue9vx4
         KMRTMPJbTGptvB4OAcVDFwmcfEPJy3iCUaMbns2ibPDoCNPVRWz9LGXbp3ZTqlQkkake
         NM3cOHK+NJKBmVgm64Bgxxfyx/QuL+Op+53EhhAOh/k1SnKdIFrj6SYTczalDF1RWRQy
         oLnzSPoAIJ466rr44DGTMGB3Tr08kkO08L5vAySj84XaVrmKGgJDQtAXdl/VeNRcez0g
         dXpn2s72HUXzn402sHv/jc4FLVAmvBUBA31aSGI3p+1rUNoZJkkRrbC6zfVXZupCvLMY
         9W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701207377; x=1701812177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+7egZpgbxWlQy7x1pNLLDFc7cb12zF09MZ6gXGVBBI=;
        b=HER3tA758eiCu+RcOoilS9pmPVay/QDLYIxc3vo0yzNAH89qsdfbutu+Hd5sC7eZeJ
         w5DIzeJLnlcxBwty9SxV5qzGcm23HY6S60cuWy2NEnXJzsYOp9aSulQpV8kEHESpcKcP
         aF9zysrcO6DK4GG76LGdm308kUN5wlLu4qrZAWrsa/7o7Sru9vMQ9czAAhSVzCkS8+fv
         wxas+67ZcPbXAiKq0weuJDDVsW0nz6Bo1DiXy8cuRi0Dh/xEvmlQB5rsaSqkcO1L6NGU
         pZ4S1wlySoK1i85vNp6b3t2XgMU3jKF0BuJrU7QsQlHbhFNdUeL6QsbjFrw65DFS98VN
         PS3A==
X-Gm-Message-State: AOJu0YykKIgbyZD1GKTWvjpSx6ye6o/rFVPJcLZ3PY/g4SivJuKA2M7B
	2WEx+dxGjBje/sJJcS74BhDeAcqfsU4pbQ==
X-Google-Smtp-Source: AGHT+IGezPzPpBB7DD09TuoxH+6HfyyvNO4ke1lW5qOxroc6VuYdtXuB6VytQfYAYI66586Qug016w==
X-Received: by 2002:a05:620a:852f:b0:778:9156:3f07 with SMTP id pe47-20020a05620a852f00b0077891563f07mr16334065qkn.24.1701207377382;
        Tue, 28 Nov 2023 13:36:17 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id q5-20020a05620a0c8500b00775bb02893esm4819851qki.96.2023.11.28.13.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:36:17 -0800 (PST)
From: angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To: skhan@linuxfoundation.org
Cc: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	angquan yu <angquan21@gmail.com>
Subject: [PATCH] Fix Format String Warning in breakpoint_test
Date: Tue, 28 Nov 2023 15:36:07 -0600
Message-Id: <20231128213607.59587-1-angquan21@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: angquan yu <angquan21@gmail.com>

This commit resolves a compiler warning regardingthe
use of non-literal format strings in breakpoint_test.c.

The functions `ksft_test_result_pass` and `ksft_test_result_fail`
were previously called with a variable `msg` directly, which could
potentially lead to format string vulnerabilities.

Changes made:
- Modified the calls to `ksft_test_result_pass` and `ksft_test_result_fail`
by adding a "%s" format specifier. This explicitly declares `msg` as a
string argument, adhering to safer coding practices and resolving
the compiler warning.

This change does not affect the functional behavior of the code but ensures
better code safety and compliance with recommended C programming standards.

The previous warning is "breakpoint_test.c:287:17:
warning: format not a string literal and no format arguments
[-Wformat-security]
  287 |                 ksft_test_result_pass(msg);
      |                 ^~~~~~~~~~~~~~~~~~~~~
breakpoint_test.c:289:17: warning: format not a string literal
and no format arguments [-Wformat-security]
  289 |                 ksft_test_result_fail(msg);
      |    "

Signed-off-by: angquan yu <angquan21@gmail.com>
---
 tools/testing/selftests/breakpoints/breakpoint_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test.c b/tools/testing/selftests/breakpoints/breakpoint_test.c
index 3266cc929..d46962a24 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test.c
@@ -284,9 +284,9 @@ static void check_success(const char *msg)
 	nr_tests++;
 
 	if (ret)
-		ksft_test_result_pass(msg);
+		ksft_test_result_pass("%s", msg);
 	else
-		ksft_test_result_fail(msg);
+		ksft_test_result_fail("%s", msg);
 }
 
 static void launch_instruction_breakpoints(char *buf, int local, int global)
-- 
2.39.2


