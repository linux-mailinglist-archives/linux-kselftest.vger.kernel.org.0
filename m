Return-Path: <linux-kselftest+bounces-42151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB64B96079
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 15:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5737C188C1B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Sep 2025 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4146A324B0E;
	Tue, 23 Sep 2025 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPnHAh9M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90B54204E
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634557; cv=none; b=vGSqqNwmfDk9/ILbzBl6SY72pKIgu6Az4dzwsEAykX38X7+L9lljK8L0W9vXQEiKNWzjp0CsOSeUenx4AdLTQDcdKkI9fbFamBg0vxhBJO3ieB25S6EkgkojWzUM1zYht/VfCCE/c6z1+zRs04tJBPWRWCo91uEwC/Sy2YqVYHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634557; c=relaxed/simple;
	bh=znG+h1jxg1Nxsh5ZmX6zvmi5M/TTvGYDRaPtUzWhfv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q3mfvEymmmH3onwmDyzMT1nYHmvgMJXzAoQgueNWVGOru8SURpqKEfX2PvL63/esJ4FeE7i+xWaKGynYjMcz096AdfYTAXKvtj39+a5+ZTeuPjnJUMULuv+dHahhWnMjksh9UcYHKju4kkf/Qe+gshUuX7Bxip2mIqric0FqmdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPnHAh9M; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b550eff972eso3344210a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Sep 2025 06:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758634555; x=1759239355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b2lr3Dutx6B6eyqvnP3X8YmF2V5je7kl2Qtl4kqgQ+w=;
        b=SPnHAh9M+uygku8KRu8/Czsh4K3A4nUvV3YZSTdt8BQ15KcIxmT23co9YTKHQ0Jtai
         LHEsSrfy5DZNNrSbWwuHYgibJu/NxFNGxTrx4FB7ogZyKHLGqZglRXi1S1Hh7wJsk/e1
         v5SGA/qVmzPtKUIeGRnTOgDKtDmzogihUhHzSXlR4RUfx5dVXkPT0pWx7ASTsrIisjkC
         juzCkgLfxfXVpy5hwXBdyV6GuWjFE9pdzuEgD97lmeRZuNgXmDwOZYM2frxMd6kBCFg6
         LFA+bcT39y3dnpPQA90JNyrcDG/XUI+yUXex5k8CIy1eIuJZONLA7OkpkmjZNt+DNTLQ
         wz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634555; x=1759239355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2lr3Dutx6B6eyqvnP3X8YmF2V5je7kl2Qtl4kqgQ+w=;
        b=gec1NLUUGl9742M2p5cVMwU83S4zJE1G35RLZgkQWctjVqsHLB4H3gRnpLyWN7Thv4
         GZX9laN9nBf811czPKHa2UTNnN9aGEZ0a7oMIi3ZDofbDyj+c0n8VslPeEBY60N4BYQH
         YvCs31RCwfiZKFq+XPS1P6siBdGiOyyvBwGlSpQfejzO0zwgLd2/ByqWW4CKqJxCj6tP
         cWt0+/KW99Ykfoy2SklP9ojIFiFjZvZ7qTbbrlFOEUymzIi1RS8M26Vn882Y0sEgtYc5
         2FfDB8xELr4P3kXigZN/1ythGJM2Z+mB0W700fPkkuj2WioN06Fnc4S7Du7+F1Kr6G4K
         LF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVfJMr/ZdXYh06SxXtIvh3MwWSy4P1fpkwReLTNWO4jfJ0wbHFcBSy7ld+4jpuNn5vaPoSqxWetzrvxntULOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwWLVrG6Pzrl8jmYVhQ8t+9gmL8WRSd4iPmHFuk53Q39LjIwTm
	G61z+zuVxJrue8Cqrai07PyqcZN4hcAnbwvAHJAR7sGqlRp+FS9tCzttpr8YfqDE5cw=
X-Gm-Gg: ASbGncu3z3JhkJC+9gDdQMqwIKcsJ1n7wCzFUfP96eQbZCTc/H3XICWc9aZarQYRtl9
	7VTWUU7zImW79zub4SFpsqx8V9j6nRTGtfBSY6fs7pJNX2tnGT6bqvTt/fjL84dLHFXcn4dLVHF
	XXI5q1h4FbV5cEDy9jQN3bXiHpyJJd19Hc/XaMfTr4RL+kUAbWffxs7aJn+0xDGtjT2mA7HR6nX
	sXyI1fauPxb6VYYFhyN/Hnhfff28dp53JkxK4RHF42wtLPWwid5lKU6YcF/SI0TVxSBOq5Dvxmd
	2uWdSNadBG2mOm2sYZwvcYjVM90hN8ZrcQHSaP53WuQ3zUeo5eah6kGmXuVZT6+LMHHeTnnQeS1
	bGS2NAUHMcxAgKC6gQkCVXHKDdtddmfAGt96ErEMR9jB2sizFiNb3cwh3TeWdgQ==
X-Google-Smtp-Source: AGHT+IGpLljN2OiXQ7LYAbyOym/Z+AvCTP3frfN8kdVxo9sEwr2v9ypMWNZZliit7cvuFp/8r358yA==
X-Received: by 2002:a17:90b:1cc8:b0:330:84dc:d11b with SMTP id 98e67ed59e1d1-332a9592ce8mr3068232a91.18.1758634554863;
        Tue, 23 Sep 2025 06:35:54 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f31:8167:5965:2f65:11fe:4108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060619245sm16476002a91.1.2025.09.23.06.35.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Sep 2025 06:35:54 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: shuah@kernel.org
Cc: tglx@linuxtronix.de,
	dvyukov@google.com,
	sidharthseela@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftest:sud_test: Fix "usigned" -> "unsigned"
Date: Tue, 23 Sep 2025 19:05:22 +0530
Message-Id: <20250923133521.39257-1-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trivial fix to a spelling mistake in comments.
Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
--

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index 2eb2c06303f2..6b846f5c1fa6 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -140,7 +140,7 @@ TEST(bad_prctl_param)
 	prctl_invalid(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, 1, -1L, &sel, EINVAL);
 
 	/*
-	 * Allowed range overflows usigned long
+	 * Allowed range overflows unsigned long
 	 */
 	prctl_invalid(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, -1L, 0x1, &sel, EINVAL);
 
-- 
2.39.5 (Apple Git-154)


