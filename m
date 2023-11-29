Return-Path: <linux-kselftest+bounces-791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5C07FCD89
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 04:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577261C20AD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Nov 2023 03:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0975689;
	Wed, 29 Nov 2023 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxr5Claw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDC4E1;
	Tue, 28 Nov 2023 19:36:28 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d279bcce64so850217b3.3;
        Tue, 28 Nov 2023 19:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701228987; x=1701833787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qhpsd/CJqEzY2wViCgUIbvNNXzGivZKIEmu3PQkzhVE=;
        b=Gxr5ClawcMr0jE4AZxWDC/nTeAMe0rBaTfaSWawF1MHC3wBh0OlGX1VKhKmMlGzJT2
         /Um6HbldbvJ1JTGtvU4K39KL4pDqYYFNkG8XhHvpAuZNh1BDgN1qE0tOxMTBhCRAexP3
         HpOJCHGp6MOSaDG/lyHCMbJaMmjqp+7NSVjn2m57hQ5H7pujg3oqB3zfJ/wMycA43WWj
         FPifgq6E0Y9kMI3RdECsAFQG3r4lbWe4MCVFy6AScoXExUCHU+rG4dFnKwy1yb3aJL5z
         lKHgXGETNi31SmYHUJ0wXf6mlzE5sSDVcjaKiqz7WgI4FftJCv7Pj6rmU4X2Z5Uv63MT
         HPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701228987; x=1701833787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhpsd/CJqEzY2wViCgUIbvNNXzGivZKIEmu3PQkzhVE=;
        b=sDJ+nrOpJm58RZrmYt4fX5y/qrCxv6d+pmwu89XlFqZz/6nx1hRVIX0PBN/w2J4/Ol
         GevULGoSX/SvNHa5YNEBwDYrCcxyqlazvVuErYQyAJWadzUGClb0qxjkc1V7HhzNfRzl
         Zs1paArp6CJdBWKXnXGU1iAzPDcdi9RD1+rhOxYoupW7kWYMjPqTyduJfaJ5XdyQ0e58
         znV++ycRZ5Lj5IbNm6NPgA6gG7mroseQGJ5qQJdlhBo7mkfHdUjmaUaZlo5KJtSkOUYx
         H9Pq5YBhA1rD52twcdvWCNyof9xiEgMToHmhFSFI5Mrf4s8cqwquGITPsfDpqxtxwtft
         /XKA==
X-Gm-Message-State: AOJu0Yw41YJwRDsllToZtOfYjxWvxdL5UAxfiNoRrUU7Z+eu6Iy/KsTM
	VRjzox+OX70UdOkGemBJC34=
X-Google-Smtp-Source: AGHT+IEYDxU9JuPKASBFJDFF8v4y5UuoZ6eVXG8K+0j41N8DcXcmVAbDc+BthCLyChsaWyTYWMk5pg==
X-Received: by 2002:a0d:c983:0:b0:5c9:86c:216c with SMTP id l125-20020a0dc983000000b005c9086c216cmr17462276ywd.46.1701228987546;
        Tue, 28 Nov 2023 19:36:27 -0800 (PST)
Received: from angquan-linux.. ([72.36.119.4])
        by smtp.gmail.com with ESMTPSA id a24-20020a0ca998000000b00677a12f11bcsm5726238qvb.24.2023.11.28.19.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 19:36:27 -0800 (PST)
From: angquan yu <angquan21@gmail.com>
X-Google-Original-From: angquan yu
To: skhan@linuxfoundation.org
Cc: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	angquan yu <angquan21@gmail.com>
Subject: [PATCH] selftests:x86: Fix Format String Warnings in lam.c
Date: Tue, 28 Nov 2023 21:36:15 -0600
Message-Id: <20231129033615.5083-1-angquan21@gmail.com>
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


