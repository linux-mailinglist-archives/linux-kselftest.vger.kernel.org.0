Return-Path: <linux-kselftest+bounces-27152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32316A3F1D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 11:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68142188B1A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 10:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9F520469D;
	Fri, 21 Feb 2025 10:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cl1EevkJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A02204587;
	Fri, 21 Feb 2025 10:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133338; cv=none; b=ZyZvxxW/WzLqMFso+6KjmwgQOW2Amt5IifPleuvxOLx/tXdDvuTzCzTA5hPS3quPwQpBUm0P+ImIITl7qL08pnfvZa36qvthtCprKtqznkcDwy+7ON0TCbH4sUdc4lJ70cJfSHXhF5q05UqI3pLckfxJAfjKCL2DX6htj9w4wtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133338; c=relaxed/simple;
	bh=Sjc1BaSMeJRPeCcL/epzdtctw6/nuuB3OAwal9CBkZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAFNBrW4dlKnu0XvVGxED7Kl37yH7753gr7kisZAiK+KbRY4FhETYYum8z7NgBp6FRwcl2zfNxjsZVJDEKi4oMX9S1X8FQPr2UNEQ6p5X/jdFRymw4/clP/a6Ey0f7vqV3emLneNJwElEuJesTN+h47rAa+LdOF3HqU8h7tApVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cl1EevkJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220f4dd756eso37502375ad.3;
        Fri, 21 Feb 2025 02:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740133335; x=1740738135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BUiInESylQ443K1PbNMFuTYC6xpLt2zG6UzEqWDU58A=;
        b=Cl1EevkJ/k5SdM1wbb4OxJ77Gw3N8hFViYg1dGRvK9r2CngsKuVqAFv6JMPo40JAAx
         aXfGtNf/+yIKNTKgFkLLnJqOJIIVhJTEnYb3vtsZYJ1RX6Nhgymx7y0x0i9Qcn2Xpe2O
         +ZbTYOgNJ7ZSAxWe0JyexoMNxPS9vmNRBdFpM062Xnv67NVuDWeHdBKZKZyxIC6WnKU7
         y2fy+RMlA67aR774L8PXNwrWr/uCGDL6ENUaSVwRiwFMA4oFX83gCyO77VFvo5mMYNyP
         1ZWGyvp8wxkaTqM03DN9i38GQuJMaGh6wRuAPvMUddx9kaRVcbTkgPnfD29wH2UXfbC8
         8CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740133335; x=1740738135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUiInESylQ443K1PbNMFuTYC6xpLt2zG6UzEqWDU58A=;
        b=d3rOu3FIsnS1MGXZ32sbrDG3xGtEb4JhT9DWCVqjkto3h1XTHtyEFqaCkRjhMouNvU
         5ORod+f1tsIiqMT0QaessCmlD6yFkwo69V/rZVr59OkBfYZV7evBLN90o3CO2mbU0ewp
         nkwWGJZ4m3SGc+SLzYpkFY95enR8lqk0kehPFn9q/n59HwulApzeCbvbAOlUkIh+45LN
         rZ2z0JsGEds94L5NKuUU4si4P0lwdLjvgFgNXBpY3MZvpP6OER85c44He7qZTz/TadXz
         zw+qBYGEjPyf2jOX8mvEZYGYdfQ26jU8uZYf6tE1/pMdc/7PQ/vj4ROF+/KcuM7KfJkQ
         6a0A==
X-Forwarded-Encrypted: i=1; AJvYcCUp0O79QO3+cNNdUpbfDixq6ngAPSHUcs2tD/qTqvGE06YuSLK6S9Ciui2JC06l4u1t1/cvSKlctOA3yLnrYITB@vger.kernel.org, AJvYcCVZn9LMjcG1fe4rdxW3bF0snzoSWcT3/J+uWBABlOTnrG6GE9u5SlEVpAQB6uYMvnsV0KpXp5kWqu+6uPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20nfKx6e6XtiJ/DkNoi/CMklymduFE8kY6+UFeK2Y8wIa+a59
	bY0abtcz+BCliKAD1ndNcot8eDvnJFzpwzjATxSJ0CpxVBhnAIJk
X-Gm-Gg: ASbGncvIzDkhYC+zQ0qMVPX/e+0h2lH1SwF93bEJimm8WUXq46MSupezUY6SvJa4zAx
	Utwd24+YqzMSjXLoOo2fXQ6S0ca4lhq00MtleKYMWGRbyeBOV1gSgvq7SfoPFGp8h6GFqWeRT+U
	qO108e8Hn3R8zrwKdRzX7JGCgieQm+7h6S9OuyHAdcrzBRxmIqzyNFGeSS6gJTkZIad3viPCUFt
	ukfYBznuJjRQ5Ym+GMr/J1dRJGIiaHTozipTQJdVxrLuZaXAdVrcq9NK7jrABc5iIEzV5T+aiVZ
	nH/84xWoSng6r8FA1B2bx5P1S7xy50KXCyt0QdE+m6CZNm0=
X-Google-Smtp-Source: AGHT+IHDNNa9+STTHVJu9rG3iYk4wdYRkirFxgdhDuCzUpvTXWsEe5U1+ypJwPqU6S1lu1S8FtE5Xw==
X-Received: by 2002:a17:902:e5d0:b0:21f:9107:fca3 with SMTP id d9443c01a7336-2219ff5efccmr36540465ad.30.1740133334784;
        Fri, 21 Feb 2025 02:22:14 -0800 (PST)
Received: from localhost.localdomain ([14.139.69.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2211d4c9c64sm87690365ad.214.2025.02.21.02.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:22:14 -0800 (PST)
From: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
To: kees@kernel.org
Cc: Bharadwaj Raju <bharadwaj.raju777@gmail.com>,
	joel.granados@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH sysctl-next v2] selftests/sysctl: fix wording of help messages
Date: Fri, 21 Feb 2025 15:51:49 +0530
Message-ID: <20250221102151.5593-1-bharadwaj.raju777@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix grammar such as "number amount of times is
recommended" etc -> "the recommended number of
times".

Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
---
 tools/testing/selftests/sysctl/sysctl.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index f6e129a82ffd..db1616857d89 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -857,7 +857,7 @@ list_tests()
 	echo
 	echo "TEST_ID x NUM_TEST"
 	echo "TEST_ID:   Test ID"
-	echo "NUM_TESTS: Number of recommended times to run the test"
+	echo "NUM_TESTS: Recommended number of times to run the test"
 	echo
 	echo "0001 x $(get_test_count 0001) - tests proc_dointvec_minmax()"
 	echo "0002 x $(get_test_count 0002) - tests proc_dostring()"
@@ -884,7 +884,7 @@ usage()
 	echo "Valid tests: 0001-$MAX_TEST"
 	echo ""
 	echo "    all     Runs all tests (default)"
-	echo "    -t      Run test ID the number amount of times is recommended"
+	echo "    -t      Run test ID the recommended number of times"
 	echo "    -w      Watch test ID run until it runs into an error"
 	echo "    -c      Run test ID once"
 	echo "    -s      Run test ID x test-count number of times"
@@ -898,7 +898,7 @@ usage()
 	echo Example uses:
 	echo
 	echo "$TEST_NAME.sh            -- executes all tests"
-	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 number of times is recommended"
+	echo "$TEST_NAME.sh -t 0002    -- Executes test ID 0002 the recommended number of times"
 	echo "$TEST_NAME.sh -w 0002    -- Watch test ID 0002 run until an error occurs"
 	echo "$TEST_NAME.sh -s 0002    -- Run test ID 0002 once"
 	echo "$TEST_NAME.sh -c 0002 3  -- Run test ID 0002 three times"
-- 
2.48.1


