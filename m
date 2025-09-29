Return-Path: <linux-kselftest+bounces-42572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0710ABA920A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 13:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58F93A23B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 11:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC412FFF88;
	Mon, 29 Sep 2025 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bveEvQhO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CC52F9D92
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146899; cv=none; b=uWePAxRsPLFMWCqVbf1raVdfMi34Qu9mWZIhqqbuR1DzTdcIMuQeKlGrIRsWke9tGInTQpY2Pde9GBvsvSJWOTbcRbSwF968XmgOhTyrHiHDtvaHfNeJQFLynbxZHQCeCdAloxZ4IwOcSuUQeSSf34gN2Gfn4SW1fdCfEKCTTyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146899; c=relaxed/simple;
	bh=vkwL+PGNZASsXf9M09tTQFZ5+KuEzqyB7R4nlUavslI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SO00mF4iI0fqD2FeXQ4VxJ9Yz4OM7SAguBQrABieYi6rYFILMzG8TIXG+0/8F511EGuX/faetZMdL0baSi+0wwmJNObVOtc02mQkeW8J37F/15xcZmBeWXJfR2aNrsxCIGlakQllA3HngBZkZDgnztScAQxKUDbIrJzCIa3qFO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bveEvQhO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-782023ca359so1942815b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759146897; x=1759751697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/nxMwSBQwOydmRinFjGwKZjIbNHBnsDSojBIvT19KMQ=;
        b=bveEvQhOjjJ3Bc7Uf5A7keCApcES4KA8zMtydq0Pi1fZnl+LOJmx3C4UhjruueJ6DN
         FWgomqp0REIWDp6M6NMdgFY2gzShPQbjS94bTGCL1Gpid5Lyp7TUV0GJuHEvg+Gr1VnP
         tSnCMC63s1B8mSRUX5mM5NdHNNJ7qfPCIrIrlQxE/Hu8MU0LIBe1R4fioXbPCHkgCd27
         lBofZLfESaKKdkrBKNquZuiU0nWf1yZ0mlnTxyLJf3018SNviC1yUz+EjXQuLOIDU5jd
         wkeVNWbNhmu2oSyzPWL+FqHwExtj5C+PAdvsLRsZ7ZB1ytNtFgdxezu88d2NVgOhXGyh
         Gysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759146897; x=1759751697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/nxMwSBQwOydmRinFjGwKZjIbNHBnsDSojBIvT19KMQ=;
        b=okWoeAMO97FJGKOej/gmS8MDw2aceqFLBclxFQ1HUcMPtz74B3bbfRqWxBmE2YtIsv
         Rim3yDYAAn68CaloaD7sM3/VI9zx5TvjnYhz1EJ8BTwBr7mEfTYcCBBRvn0+41I/kaoX
         v3Qmn5tB9f+gdWAw4pYMwT1J/Dx2Qjxm3dGn2q9ghzAg1YyyWnf8HdlVOqq7rgAqpAgx
         n3bR0QCXOZ1JEDlSHZHRtbyxnd/oYb/nU54KP4X4CI6qGiCmhjjr7I6CBmyBc/gys7qN
         eb9joEW5pU5yAk6OIfHUHl6GKvBmvaMltVR+WYFzLYA+12Pf39GtlQ0LT5IiL/7e6+it
         1xBw==
X-Forwarded-Encrypted: i=1; AJvYcCXXYUIXqpjlkGQR7h6WO+fPt7S+EcoadQrkS8xV/SIjPrxpJ/OU3zTaZlWxDu/HCToKFDxFF+o6fFmwxR0X1TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvSd0bbA/yTIUWJFikz0v15uh+yhvp0aHB0erGyLp2w7E4jxVw
	FsvDV2xY+vxjuMGqC45jnIM3VkwE7qFQ8s5Qk2Kz17jsOBrS+vcVVYqa
X-Gm-Gg: ASbGnct5D8/jULgVrpGwJYLXFof7sZDp6uzqCqkSsmgfyV4p53D2Bot1FTJrKxGebSE
	FLb5HAnQeVfH6+F0A5RoU8xYvQYEj4KcpQg0hpH/Dp446ZFXDbHORAYJUNr9LA9bQlWhXcxYGx8
	TMmEv4Kb9++ro+hwZqVCs6K20+pHVNHnWu7jt00q6QvCsaD2Wq9aysx6i63Xvick672D8HTBXyC
	WWWU6Wr19ttLBtyhYfPwsmNIvVzB57iMNE6YHhUHkq3hr7GCE0vgnYA+cyZP+g4EFlY4e81eK2I
	qhNQjl+uYTWZUl4JHhBPM9dj/aUf55MgYD5FVkot00yetXLfBTFcsG7s3RHQtD7fSDcia2QS/Lp
	6LlZIDWG2M2RWk3/xZpY68d3v98q9
X-Google-Smtp-Source: AGHT+IGZZNUqAN5enffrxbMWSeJ5zzoNuwdSyjXDEWzGn3w9G1pwp20etolI1Qt0978OXhgQfd+jHA==
X-Received: by 2002:a17:90b:33c7:b0:32e:753d:76da with SMTP id 98e67ed59e1d1-3342a2abad6mr17486517a91.20.1759146896814;
        Mon, 29 Sep 2025 04:54:56 -0700 (PDT)
Received: from y740.local ([2401:4900:1f30:25ff:36cb:10ee:ba03:839f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be384c5sm16983570a91.26.2025.09.29.04.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:54:56 -0700 (PDT)
From: Sidharth Seela <sidharthseela@gmail.com>
To: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	nathan@kernel.org,
	shuah@kernel.org,
	morbo@google.com,
	justinstitt@google.com,
	nick.desaulniers+lkml@gmail.com
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	david.hunter.linux@gmail.com,
	Sidharth Seela <sidharthseela@gmail.com>
Subject: [PATCH v1] selftests: cachestat: Fix warning on declaration under label
Date: Mon, 29 Sep 2025 17:24:06 +0530
Message-ID: <20250929115405.25695-2-sidharthseela@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix warning caused from declaration under a case label. The proper way
is to declare variable at the beginning of the function. The warning
came from running clang using LLVM=1; and is as follows:
--
-test_cachestat.c:260:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
  260 |                 char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
      |

Signed-off-by: Sidharth Seela <sidharthseela@gmail.com>
---

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index c952640f163b..0305e736f2b8 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -226,7 +226,7 @@ bool run_cachestat_test(enum file_type type)
 	int syscall_ret;
 	size_t compute_len = PS * 512;
 	struct cachestat_range cs_range = { PS, compute_len };
-	char *filename = "tmpshmcstat";
+	char *filename = "tmpshmcstat", *map;
 	struct cachestat cs;
 	bool ret = true;
 	int fd;
@@ -257,7 +257,7 @@ bool run_cachestat_test(enum file_type type)
 		}
 		break;
 	case FILE_MMAP:
-		char *map = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
+		map = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
 				 MAP_SHARED, fd, 0);
 
 		if (map == MAP_FAILED) {
-- 
2.47.3


