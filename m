Return-Path: <linux-kselftest+bounces-25704-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CE6A27711
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 17:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7B91883EE2
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7F92153C8;
	Tue,  4 Feb 2025 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKdvq97d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057D2153C0;
	Tue,  4 Feb 2025 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738686266; cv=none; b=hKXPSEzYCzJse6sCD/PokviGBzw4mpADqOskc5SbmMfoBGdmittyItQWrab3MidcCzLzn+u6EO9/LnlGtrQRp3JOwBW6Yrb+lPB+oEj7sqmpExtwgg5qR+cPqVirp9fMfQu+o/xAFQ7GyDNMOQKS8QZ8Vh0cA+p0+nPyDjkZsEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738686266; c=relaxed/simple;
	bh=KUxFX+4f0Aizw7Mg85WPdNi8c0DEahMb6LLBmtuIvak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/deK8PmCT9ymmPHHsWbN94bHYs+eRk8mzPi9Badn3rHw27QVyaDUhokymhSl47I84KPvQ9ewU9Qi3VO3XQG0s8XeB370xHFqssnDSFutPpJ6erUDNth/8iQgAeIvb0Tut5ZaGgaxxBg7XYf3X3iit6ZHOl5fwnIfMF5gEOpbRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKdvq97d; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f9cd8ecbceso1077839a91.0;
        Tue, 04 Feb 2025 08:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738686264; x=1739291064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K89iMvYVIaxnJ+fqwfSq5htV0qyp5rhqJml9Bv4LRmc=;
        b=UKdvq97dkT/DoIfphkQIqSa8yc15NEwA1f58iV5Sxy+AOti5NKy369bxYXhXMAHiVh
         mOhCU57k3GOK5pJ/7kbOuh00KTBHn0BqJMmbKzLkMtCSYuq2gl0yhSvx8l+2UVag3ioa
         2WOP061o3L1mE2gSA46EXMbYFOej+vrT2Gs30LzWYWghQvOHjbDx5r9FsYZIiWhAhUKW
         lz2EES/OCj7x6fWi+8qmXXc1TSHfJoosiV7KQyUioq6Jfjd03BxZCZi3nf3ZEt5BKgIm
         g9PorHZzOuR4H+uO6FeaVVwSa2D4chRQp45LrRzHRU8VaxDZfn/qBaq7kre5UmJ8dArJ
         2sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738686264; x=1739291064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K89iMvYVIaxnJ+fqwfSq5htV0qyp5rhqJml9Bv4LRmc=;
        b=its0WVME2/7s+3qa2weo9qlX5vL33T35mfWdEUJEZUIRIh/IyLwgkBxd6/IbtdMm7c
         RJDWsFtVBgL1Gy/E/vVuakN/BjpJdBTIeOpR6dWgr63QlYtuy3g+fEia6W4gn5XtddmI
         QcFh4EhLZVXraSvUly6Px0ji9Lu0kiENKPYLAAPP2EiJyVbK1iPR/UZnlugQZv9ygs5r
         hLYFqBVlevhK6ecVx+IjHsbOCzx2TMuGKU0M4t1WoTwnOwDXzg9ErMUIaaM5zyeF9vyx
         5x3/vQnNtJeqzJoRV7St+FQ9IS/Kp1TSHU2WwjDlMTkIJsbxs+epjBqkfQNjmgq9YiWC
         pqAA==
X-Forwarded-Encrypted: i=1; AJvYcCXP6EXfWHZbiGZO5s3Hqb2k9lhIUkBZlj6HsTdU1T4cKQCJanEwcaCFBu8CXqKCHHlFr+h0zXMdBAJ7Og4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1ZBun925Iho+eyMv77Kfz2TObs58S7SwqmNXYikqy229CW3J1
	uKHcg07pPOiwxV8BPxflJNSai6qgIXnAq+Ancc6qJ80j4+MDA4vrerUBCypu
X-Gm-Gg: ASbGncuOA6vG9P+xCak6Kn7jn4CW+8pRBXHrCf8Yk3rNnlfjjAg9IiU3O56P9ih+X0F
	qrQ8xYhIKvGUjcMuPzNHF4JpoQY/nYSsPwFMg2Dh/bIe5+ETOVtkHkgp+IbX7IHxTHUBpPF/LRR
	DZsgc5uV/mfXG9Wg0bOIuD531lerDajZsPtMUaarS/rpl0vnrKLEBvdzULh8nHkyqk0y2O3MzE5
	sp3do9m3yium7OGxBr2AFOK2DIX8oJw/w7EfGrKmqLYWCOOVIP76M7a/NZBtJqSuv9ggFMZB8RW
	5acADcQU04BT7Zk1WAIajY0x+9+mP46kmVgwmQ==
X-Google-Smtp-Source: AGHT+IE+t9Q0e0NTv5Lqu9aYMx1Bpc7GcxHoh0GazGwA8Lf1cfTs4FCqTeCL17FslcTvdiqqyyq8iw==
X-Received: by 2002:a17:90b:2c8c:b0:2ea:712d:9a82 with SMTP id 98e67ed59e1d1-2f83ac81fbamr38733712a91.29.1738686263628;
        Tue, 04 Feb 2025 08:24:23 -0800 (PST)
Received: from localhost.localdomain ([2405:201:5c08:585d:6eb6:f5fb:b572:c7c7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bc97d3dsm13797897a91.7.2025.02.04.08.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:24:23 -0800 (PST)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH] selftests: net: fix grammar in reuseaddr_ports_exhausted.c log message
Date: Tue,  4 Feb 2025 21:54:00 +0530
Message-ID: <20250204162400.2295-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a grammatical error in a test log message in
reuseaddr_ports_exhausted.c for better clarity as a part of lfx
application tasks

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 tools/testing/selftests/net/reuseaddr_ports_exhausted.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/reuseaddr_ports_exhausted.c b/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
index 066efd30e294..7b9bf8a7bbe1 100644
--- a/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
+++ b/tools/testing/selftests/net/reuseaddr_ports_exhausted.c
@@ -112,7 +112,7 @@ TEST(reuseaddr_ports_exhausted_reusable_same_euid)
 		ASSERT_NE(-1, fd[0]) TH_LOG("failed to bind.");
 
 		if (opts->reuseport[0] && opts->reuseport[1]) {
-			EXPECT_EQ(-1, fd[1]) TH_LOG("should fail to bind because both sockets succeed to be listened.");
+			EXPECT_EQ(-1, fd[1]) TH_LOG("should fail to bind because both sockets successfully listened.");
 		} else {
 			EXPECT_NE(-1, fd[1]) TH_LOG("should succeed to bind to connect to different destinations.");
 		}
-- 
2.47.1


