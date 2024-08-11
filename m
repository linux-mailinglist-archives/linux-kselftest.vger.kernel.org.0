Return-Path: <linux-kselftest+bounces-15122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BCC94E1BB
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D664B20E56
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Aug 2024 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409641494B2;
	Sun, 11 Aug 2024 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIw+pSyt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F53B64E;
	Sun, 11 Aug 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723388453; cv=none; b=hkhZSBsHeM9g+p7yzhsMpLi6vOD9xUaxvbMLLOmAM8tlhx1pE2PeUtWnlV37k5Y+P8H9vy8iXagy978REhLarNPgESOoFd0nrZ2pL+xsS8RaSZzU+5KMXkr0NKyTWrsmp+BKYd6HrWk18d33Ag/zy5cgBVhqPpudJUskoz5YHIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723388453; c=relaxed/simple;
	bh=S9IJOizBISp63DNmHQaW5E+RvhnQ/UMlG1+NU22jFDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0dhXH0uH0VBx5FgCPxB765NMXPEw44jo47bSzmr1sHn/VizH2WZnT7T4FaibWYAhn5AlFzcaBOTT4FljQyuPwkiMrO+uoFoVo8YKE6tQd9sWjvOzKZYGAf7rKaDn66aQ0oNZdcQz1GQBuVykvESrEleL1jgLuA/V4t10y4r9NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIw+pSyt; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7093abb12edso2640470a34.3;
        Sun, 11 Aug 2024 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723388451; x=1723993251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pfBc+ff67QC7mdj/Loo7l4PIYi+bwKE4KNgOnmb8TNU=;
        b=AIw+pSytbaHRdON10Ru5adGfBWgoVfusjnnp++FkL16fJUcyoxtt4y30qSBXz42J8L
         dla1GPP1GKN9M3tjymBIcsmYtzNzeS0R0QzEWsNN06ofQGjAA0/sbW8+SPmHrdSeEah6
         O8Qrpe4u92UqrqUYDtuNSA2jYxN6V0wn6D7d4yT1ReoAlaCuQoSShXRyqtbFeMkHYLJQ
         P6aY1F5PrEYlxfUTyWKcRuVvegTOy2sdWeZrP8d1u+InIzi0wl5mEzSvUTv8QXskmwiE
         abMYpsGXkKq17pmBEynngcxeK0ydPG6t7UjnCRT0LNSomK/WxZJzN3YtjblDg9p1SwSv
         dznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723388451; x=1723993251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfBc+ff67QC7mdj/Loo7l4PIYi+bwKE4KNgOnmb8TNU=;
        b=eyuiovVZgFNAHwMi1+atm91vjMWnl2CLYann1RNEjFwkXKIVNZoP02rUhOLZ4jCous
         QaTLj0PU8x4VHg8FEPQ5O8KdErHMH/XB/c6Av+U/AS04Jfb4c9J1D85/i1fCGNwuIA7K
         99QlxPq6sh0cl6PCUakHBtha57MqQXX1JlypyW2hGE63TDwmAgqh1H1PC1kyaCxkQxR6
         lJtFZGCMQTgDm0ANVQt5q5LhuwcSS/6cvuSSiJpT/gMPvCOJvIwoxnz6ak6tlVzIVus/
         73CcQfKJ2JI2soNl6EFMuRJGSVagZaedeTmAJjYtrZEnK7sew2azYGi3J+yZQEaMJtIj
         y+fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtDSg340lzxCpC1whLzy87NiLnXj7dgceoe7bgkSwMjiv1wb0jd20dLKsxG9ipIsUJPbXTyJTqZd2cLoSMEs35sYgwo8MzrXCqHuITq9ejBgjXRO8SVbK3j1qX+mmQAyEnZAnZcBVbXO+DGXXwibgjSORTn4gddV0PxvOah8Y9TrUIPvUTUQ==
X-Gm-Message-State: AOJu0Yww++wV9M3n78qyh44DCa8xMLVkQJPpfDpL/3sW0D8ZPq5cOFCF
	EhjnTuRudFYE/4BRZ0aMoYC9XoT0j8jTNiybv4UGv6WBcrI7L4jJ
X-Google-Smtp-Source: AGHT+IEMA414kW03hmeGkCEkocWgIKzclm9K+gA1MhdJCW4WGO0QgA0cpEC+ZM64V/Fm2ASyi6bF/Q==
X-Received: by 2002:a05:6830:621c:b0:704:45b5:6464 with SMTP id 46e09a7af769-70b7c47cb7dmr10612414a34.29.1723388450627;
        Sun, 11 Aug 2024 08:00:50 -0700 (PDT)
Received: from localhost.localdomain ([49.37.215.150])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7c3dbe04068sm2711311a12.6.2024.08.11.08.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 08:00:50 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	mkoutny@suse.com,
	shuah@kernel.org
Cc: Mohammed Anees <pvmohammedanees2003@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kselftest/cgroup: Add missing newline in test_zswap.c
Date: Sun, 11 Aug 2024 10:58:58 -0400
Message-ID: <20240811145900.433711-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 190096017..7c849d836 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -351,7 +351,7 @@ static int test_zswap_writeback(const char *root, bool wb)
 		goto out;
 
 	if (wb != !!zswpwb_after) {
-		ksft_print_msg("zswpwb_after is %ld while wb is %s",
+		ksft_print_msg("zswpwb_after is %ld while wb is %s\n",
 				zswpwb_after, wb ? "enabled" : "disabled");
 		goto out;
 	}
-- 
2.43.0


