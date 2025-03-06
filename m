Return-Path: <linux-kselftest+bounces-28426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C04FDA5553F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 19:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76251170BCA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 18:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56750270EA5;
	Thu,  6 Mar 2025 18:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="EFWz9dw6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AD2702C2
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Mar 2025 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286545; cv=none; b=UCtWrWhhioRUK4ZFrbgWXLlN8EFZcTFvEx4qYhTk6toEJtqDwT/3Jc9K/9SS5V9ua8qZk17FOITRmM7QkaKFfoWjeq8g+w0dS+gDCAhqTw5sSLe2ykfd/RWwTKQyIxR1jPASs+3LsanIsrGCOC0kGnDRPB3rkJSAxb6lnnJAXVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286545; c=relaxed/simple;
	bh=9Dig6sAHtsyHbkq2491f7Tg8tRugSKtgbFGFfoTAC3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjcZVafHgr3sj8MAWP42PHJrF9sg4vLgpVQRNBHqaVk/U/UWqRiAhpzNAOORstLr7oINbdHKFTv+vfAMtiLDp33vUWHSa2NCG09PlB6BUKYbxXZMvaR75FB4z2i9U+TGw4/lHlrjlx3ZKZ7up6EmyEKGo/YkgS6uB7xuGWrXpSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=EFWz9dw6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bbb440520so12277405e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Mar 2025 10:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741286542; x=1741891342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAl6qbd5AUIqBk2GNL7RYgkgYgmohGeVwmROfTx+sCw=;
        b=EFWz9dw6n6WUMBqu2bwYeIT6Oh7OKtdAXlw04wweBBV/anWKZmrRtGxaSdE1KZf0EK
         RvaDX0TmekAoxoGUWTxHbYPi5/kePwX+YxYSoJNV5MRkQK5t3aoaD9VcR9axCASVDjNE
         5/7oRzDzbhnOFDI10ZDQSFkKXNIGF9fmswR+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741286542; x=1741891342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAl6qbd5AUIqBk2GNL7RYgkgYgmohGeVwmROfTx+sCw=;
        b=mk2xZNie5DmBwY7zRL6UVWxYoVwz20+LbEBTByw4Xuje5NccCGbhb2SrklzYCFTATo
         ngp5bMpnxwpFBtLwFq5uiw+5V+gUP3Fj7Mtnd7DqWfnvJWzCvdRcdJp5yAA13VBHENCS
         sfPUOapkqQVWIA4n91g1kjO3byNY3MvHFSdJI5TMJg8emM1FcDezzGWdR9Fi5QUZLXhj
         yKJgXWoIgTWC+f+afKeQgHAGNg4CsJMrm/6rXZL81SkDthdg6MzjXghYU4FqqDIUckPX
         r1ug7hk4NImQgeKIoL7+wovpq5vGd4Dq/Pb2zRE269MquyiBpM0WjItpg4J1I6BxV9nN
         JdCw==
X-Forwarded-Encrypted: i=1; AJvYcCVFzYgtsKNzRVLr7150A4d2h8X8cIXGzWjPALHYcbRe7Z/CNaRbntryriHf/DGZH617e4YzFjYs/MMVftC28Ks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9mb2rVgcNmIImr+N//cdlsO9AIWmlmar9FtR/7PnfV9tdXtEG
	uX73zgAYprnpqSxLU57j1fdLQd9AMCvCLEQGgFg24SPHtOeJMMhInL5PLWBo2LA=
X-Gm-Gg: ASbGncvEFCYC7LfvpTm3rDXPMEQ+D4OrJlDohcd4fC2ZK/2YVKQRivBFxZcYTQKGe95
	Qtpy3v7cGBLaEoencQJ/YNY2aocP0TJByV3MxqnpX2ZyjXnQZGCjt5SRFC4DqZfbpW8UG3vTN92
	9JbR5YPO5DHp4XgrGj7VSzcyFJ8DG5NAMf02ZSvYf/EIwLjre4FAGy8y2A44aaMsh4eQZsy7JcB
	uFa7hVPcvgpoeeFuKB9UiJOFuu8ZJe+qi2mM3uF23h5Kb9vnd+WchvDr7mFjp06qaJ5KdJaYnAA
	AUah+qIwPLGJRq3q5ngD6uEbMW8ZIcUpngltzIigPKBBFj4+o4/Z35FNMQFT1QKYDuE+OpjmjMA
	N30w6QA==
X-Google-Smtp-Source: AGHT+IEe5BwBXjl5g/UzaCny2ATgwBksaUC6y4ZTKWmkNFRie4pvQ0MC4LOjIjjxc7s/T6NPUmwSxg==
X-Received: by 2002:a05:600c:3b1e:b0:439:9ee1:86bf with SMTP id 5b1f17b1804b1-43c5c98089bmr7080135e9.7.1741286541998;
        Thu, 06 Mar 2025 10:42:21 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c55e6sm57052725e9.23.2025.03.06.10.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:42:21 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <shuah@kernel.org>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] selftests/nolibc: use O_RDONLY flag instead of 0
Date: Thu,  6 Mar 2025 18:41:22 +0000
Message-ID: <20250306184147.208723-5-louis@kragniz.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306184147.208723-1-louis@kragniz.eu>
References: <20250306184147.208723-1-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This doesn't matter much, but is what the standard says.

Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index e8faddcecf9d..a5abf16dbfe0 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1130,8 +1130,8 @@ int run_syscall(int min, int max)
 		CASE_TEST(mmap_bad);          EXPECT_PTRER(1, mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL); break;
 		CASE_TEST(munmap_bad);        EXPECT_SYSER(1, munmap(NULL, 0), -1, EINVAL); break;
 		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
-		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
-		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
+		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", O_RDONLY), -1); if (tmp != -1) close(tmp); break;
+		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", O_RDONLY), -1, ENOENT); if (tmp != -1) close(tmp); break;
 		CASE_TEST(openat_dir);        EXPECT_SYSZR(1, test_openat()); break;
 		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
-- 
2.45.2


