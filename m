Return-Path: <linux-kselftest+bounces-41928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64147B89252
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 12:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A4D188CCB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9133093BA;
	Fri, 19 Sep 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdYT4Wjt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7921124DD17
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279004; cv=none; b=ayAFiskCja9gC2Kx28wqVuXjAc5WG+DwH+B3R/2ugI3b++hY/gOYS7Ua7hScMzGszhh+vQ7LCOaW8PLFNFQXeXDNk8wh6w/GmEiK+vl8MaA/YrUFMhZn8dluimT7z1sQF7pVyeVxUrtSJFJFEIGe3nuhAEFeUcb8JJyj+nhkZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279004; c=relaxed/simple;
	bh=rKZL/H7ypymzwpKKnbem/RnOpyiC4W0s7l9WUy2A9xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oypBwX2p0+sSyIS6Ve77Pq5IIREBUyMiXunaTdw4fg8fO4cLOYDlgN6PDslEhAIiQGlshBJlXidXHE4o9N9d/LUmqn32Jq4W+QnXoLjRXpqGv6Pj0s7awueCcXLcTiqQUU7XdaXh4TLsqVsDEab1MPmE4Ep9pJngFHEso607nn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdYT4Wjt; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f0efc935fso21856b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 03:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758279003; x=1758883803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nlPaNwJCwFBeS5h6NPn6J7B9IvDaJFfkhCJEhtD3j8=;
        b=MdYT4WjtSXFXr/13xf4KqDcJmd8iSPe3OfSOD6xFdmwBMzoR1SXuzIQXJk6lZqngLe
         LEzX1mE6aIImNbtf+wR+Pa0hVArdhrJF2DGqevfVx9uhn4tn+P1Jxqz03hTNF6uVTnxS
         PIs/OobPpTU4gaOQiLhRrp8j0cqzvqbJtsIVxdjDfkUr6NRerBUVzmvtVW0vLZfW49GS
         xodywCOljGlCRdjpsjApunyDbBsf1DhD+88rk6x1nhH/HB1xVvqnYYzjYZtN3La3+XI+
         x2f/TY69zoMK6pWtkeQFL5LZg6WLOiKuEuL4ZP892sLFRvhOx33IM7DVML9ZOIDeEXbk
         5JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758279003; x=1758883803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nlPaNwJCwFBeS5h6NPn6J7B9IvDaJFfkhCJEhtD3j8=;
        b=ujO1WUbRv3nN6FCr4Qs6FpIt+LQ5bZfjKkKCTRkSD2GyQ7QMnkuGCxvE3hHJLejku7
         8Fqsktq0z31AqUgw/iHT8A+k0KyRI3lni8eW3jrEIBTcxi5qjswbO+digZKQMZPZrxy5
         O/DjJGRVXPbzjrwnZmDvwHSKzdVMjLJaYF3YjPiPwtW///p58flsXC0baXJF5etwNbQK
         b5k2GvTfdmxcvokWxXEuNGVU6CWZUUNiXp1daQPJ5mKqaWqa8aN7Y08Vi1iB+uAArpNG
         J7n9tJNhXHdd0TG20is6DUEKaAnVAXYrm151x+m6VIhhFyNiHNTRPzrZ+B8y+QSAjD0C
         ZBng==
X-Forwarded-Encrypted: i=1; AJvYcCXgAvjcWmZXICGMq4BkKmXvOxYy7DjZaDyW17Bv/nS9ehEUqWm83m5p5Y3i5uanOwCRxMBSQr6brADZuAWGH8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvFbH8Mo9i7JEXWaVgcxMwrevAE0zX0mtj4nsyH21uw9Li3lYZ
	J6GO7ec4vYJDsWH946yYlwpivsfXjT9vzNc4CxbDS0utTnScHIpq6z3Q0p1+cPVt
X-Gm-Gg: ASbGncs7swXTvlmfIaHmJC0GoGPim4Fpu4M4HEr+SiUlXfFYq8dMZrMWbk1+MMpUuFJ
	6meDcU1b/zpTNkNUK61QvXvg0dEfoHV5Maw9sbCTn54kfVV14e+JpiijureF+pt9eiegLCMgREK
	i+iGE/S0aaWhfrnmpJ8R845zivkFGjTAQmEic8mbBmzhPtJadqN9AcufHloJUnmFsMhVV09mDlZ
	Ig0pk4E9EKOA/1eKZU064uhngiBuFV7ER7a3UpHLhp1Dfv/30s2YXcha47LX/pQEhYaLVePyxt3
	rJ5n0ieVuv6ZIC+qyi3AL4a7gN9xrBLWBYEuCNkifao1KliYXKrROhyI+UAG8bj0rMmqNHQzrDx
	7M/QXWBxygPAaNcUX2mRQOm1mGDzF
X-Google-Smtp-Source: AGHT+IECnXLe86m48/eNbqrv24RB5ihKOoMDR1ROIy0Zofq0xXtoRiDRdz7E8E8BkgGDK3ZZiRM0Fg==
X-Received: by 2002:a05:6a00:14cb:b0:771:f8c3:1d1b with SMTP id d2e1a72fcca58-77e4eaa9a33mr2093467b3a.3.1758279002531;
        Fri, 19 Sep 2025 03:50:02 -0700 (PDT)
Received: from ranganath.. ([2406:7400:98:8a46:5008:3da:1c80:3e37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e87fb4698sm1408850b3a.96.2025.09.19.03.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 03:50:01 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Ranganath V N <vnranganath.20@gmail.com>
Subject: [RESEND PATCH] selftests/filesystems: Fix build warning on anon_inode_test
Date: Fri, 19 Sep 2025 16:19:47 +0530
Message-ID: <20250919104948.67953-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang warning null passed where non-null argument is expected.

anon_inode_test.c:45:19: warning: argument 3 null where non-null expected [-Wnonnull]
   45 |         ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
      |                   ^~~~~~~~

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
Adding missed mainters to the patch

 tools/testing/selftests/filesystems/anon_inode_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
index 73e0a4d4fb2f..f796dad679db 100644
--- a/tools/testing/selftests/filesystems/anon_inode_test.c
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -38,11 +38,13 @@ TEST(anon_inode_no_chmod)
 TEST(anon_inode_no_exec)
 {
 	int fd_context;
+	static char *argv[] = { NULL };
+	static char *envp[] = { NULL };
 
 	fd_context = sys_fsopen("tmpfs", 0);
 	ASSERT_GE(fd_context, 0);
 
-	ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
+	ASSERT_LT(execveat(fd_context, "", argv, envp, AT_EMPTY_PATH), 0);
 	ASSERT_EQ(errno, EACCES);
 
 	EXPECT_EQ(close(fd_context), 0);
-- 
2.43.0


