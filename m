Return-Path: <linux-kselftest+bounces-748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D67F37FC6A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 22:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FECB2834D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 21:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F424438E;
	Tue, 28 Nov 2023 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flo9Wp7W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A539D;
	Tue, 28 Nov 2023 13:02:31 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67a48761e96so13174016d6.1;
        Tue, 28 Nov 2023 13:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701205351; x=1701810151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9+7egZpgbxWlQy7x1pNLLDFc7cb12zF09MZ6gXGVBBI=;
        b=flo9Wp7WqFxYcnDRVlIADypEJg813kdmo7cm1Yhfmx7tEfr4TEo/PE87pb/MfuxBaO
         6qSD5EvoU3JeV2+qzaICsGiHoRVzrn7wIG5pLKQkzS8WVK6rDVD+y5S6NT2dX0ZY0rn6
         b/SOidcj/dAHsr4MDWRKsFhb7hkwxbi8OpN3NZ6sMCb1fQ8Iq4vlJXeeCY0CUl389PW0
         Q5l0jIy8qfhe2oOX3DlW0tTsXBOStxwei5gODA11+rZuFPRWlc3YkUPImRfzyPMam7ld
         qrO1A80qZQTYWd9JouUkjkaYsiWusUK5+i3VG3++wmvfWyXMLuFL4h9f9TyfTJUG+oks
         YXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205351; x=1701810151;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+7egZpgbxWlQy7x1pNLLDFc7cb12zF09MZ6gXGVBBI=;
        b=E9zb6re2CNqBC/1PhPece83dNWldQyIU9tGYl1DWn6O05TeevIdDsjdW45Qe3FdGMj
         FxqvEzkr68fIdLq0U7EEFJQ4fSzBP6QHxwzHAsrrl6bw8+sNfxpdzFx6sDUdBrWFKUzD
         z1kUnIbAAltD1PYl5bAJU+8X04/nm8k1x7HD7z7wTKNxZ4FUOCJFoxqsEAu8rMQ86k32
         fbLn0pzBOneFEPZt1dVgcYrde5R1mg6d5pU5aEQzs//8qpfxIG4jvuJN3UKAF7elamzj
         TB4KDel7dG2d/S6Jd/rmFmPlHJOyHrSBojRUjjQM/9SnMQKOE3Vejox/Fj7ZISvpdsSA
         eCPA==
X-Gm-Message-State: AOJu0YwRdfWMxe+cyn+2OAsag9HWrEUcinfD/EJ3ViGEKZF31AEQqU+g
	36DqiPSaa2QuXeGCpUuEMWc=
X-Google-Smtp-Source: AGHT+IHvdIQ4P2xpE4t9kourHMRIG+9XmyoLK1o6I3iLJdpNg5Ta7hWYSNzjXm+dS0DJM+V4QqLfbg==
X-Received: by 2002:ad4:5cc7:0:b0:67a:4da4:e23c with SMTP id iu7-20020ad45cc7000000b0067a4da4e23cmr8302455qvb.56.1701205350707;
        Tue, 28 Nov 2023 13:02:30 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id ee17-20020a05620a801100b0077d84ad9744sm3748037qkb.36.2023.11.28.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 13:02:30 -0800 (PST)
From: angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	angquan yu <angquan21@gmail.com>
Subject: [PATCH] Fix Format String Warning in breakpoint_test
Date: Tue, 28 Nov 2023 15:02:06 -0600
Message-Id: <20231128210206.56868-1-angquan21@gmail.com>
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


