Return-Path: <linux-kselftest+bounces-795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D12B7FCDAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 04:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D712C2832B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 03:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACE463AA;
	Wed, 29 Nov 2023 03:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axMIPd3L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C6412C;
	Tue, 28 Nov 2023 19:57:48 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-423d9d508d1so8253451cf.1;
        Tue, 28 Nov 2023 19:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701230268; x=1701835068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+7egZpgbxWlQy7x1pNLLDFc7cb12zF09MZ6gXGVBBI=;
        b=axMIPd3LMQGw9JR/mgxmxdzi45GUg7wOaT11eZ3kMc0vSEVwZ260sdBGXLvooX8a9q
         aov9iD/RWyXHIIDxe9JPjRPtsE63adqT7mfVFcFZAX1lbmlGhNa6gy4OOt2JIbh922oL
         Cw9JEPUpcHBYu/kqBO0jMUC+tTsHHDhf3qeQrE4m56DQmSjxHavHirDQ+3+j7odOa++V
         cZMzeraIYcflyQihzRn+gOeQIuLk1DRGMD9+d/8yyHEcDXdENSGCfaVR/Kee63fj5NUc
         vikaE67j0QqtV2J+BmhAKJSIdmnUrCqPgwGmBMMozqKhp8wOPK/25bJ+VHyB7ro7WLMq
         epFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701230268; x=1701835068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+7egZpgbxWlQy7x1pNLLDFc7cb12zF09MZ6gXGVBBI=;
        b=TZu0BB+JqxH72NLJH10Atq+dAa289ag4+oOB4emw63i3dhDNA5iMxfp4iW9z1Jr34b
         AYNfa0Z0Wb2y+5UtRlC7IMEI6cFAclzMe5KsK4LE5WHL4JpMzryKAJ1TNrRATNS6UaRS
         aGOAaMeL3Q80v3o9gABiHiyG7FVICVslZaHd7Z8jfUoULSldzLWmjsyGVpZKfJnh7OR7
         w1He4y7o/69eSQe9ngXz4P01nffK9qWnLJh3n/GtOEpbbsg3JsNJKjeP/Jls94MrzbET
         sXhM0yCLAlBYMgwxFWJWsED9sSihkY5RI/4NWABm56nD05onWdy8Yn1QycGiFU0enB4S
         NNXw==
X-Gm-Message-State: AOJu0Yxx0ehWJK50riYZCkB5+LYmaIMAh8uaFFMdZjnx0FpUl6a+vuc6
	CgOKj7+1iuOwHVLtHps4aqiUrV38yun3+g==
X-Google-Smtp-Source: AGHT+IH2nerrAbR4UKFseuAz9tLLm1UezMyHgCtiGQv6I9Y3LrgtI+O5AtNwduG/CvW9qzCpzSFXtg==
X-Received: by 2002:ac8:4e81:0:b0:423:852e:8273 with SMTP id 1-20020ac84e81000000b00423852e8273mr21762989qtp.61.1701230267865;
        Tue, 28 Nov 2023 19:57:47 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id i10-20020ac860ca000000b004199c98f87dsm5139943qtm.74.2023.11.28.19.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 19:57:47 -0800 (PST)
From: angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To: skhan@linuxfoundation.org
Cc: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	angquan yu <angquan21@gmail.com>
Subject: [PATCH] selftests:breakpoints: Fix Format String Warning in breakpoint_test
Date: Tue, 28 Nov 2023 21:57:26 -0600
Message-Id: <20231129035726.6273-1-angquan21@gmail.com>
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


