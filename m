Return-Path: <linux-kselftest+bounces-18439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A0987D83
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 06:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AF228342D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 04:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EE6171E65;
	Fri, 27 Sep 2024 04:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miwQ4aP6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4670171092;
	Fri, 27 Sep 2024 04:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727410443; cv=none; b=oZZcYoRaml0Q3WzkGQJscnXX+PGFqHffZQcWiQlVTRznEseVajdEDXsModXa/zYLdKSctUBdFWalmZCNS7Wz3JwzOFzvFa0cs8WRhkhiE2MX4TtSQ+mt+tEnpZXE83XXfEeLw9Q+jOmpMHlFEzwwMpnUkqZIc7TOjOrgFDCR8F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727410443; c=relaxed/simple;
	bh=o1mp1D74UI9E7IMGxkY0GJk9Ctz5Y8Xr+aXJNGB3eUw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gq6Amc+BcCFETjbmAE3GdHp+DeX+uoKoYRo12uErC/euHYn0rjmb7Vsoj/Ge7EEqxJrFBdVv16y7Pv8kAuMj8WzfFsLvphLG77kH6/WcEke0uQyEB+Qn7YcnVlVldpIWHzYkc3invlWvzCao4+YtbCCDHA/3RseC34c2CuUM/tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miwQ4aP6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71b8d10e990so135693b3a.3;
        Thu, 26 Sep 2024 21:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727410440; x=1728015240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vUExd/HvXISJzOnUZpKfBxGs6Kqdkihoj+/Acbs9JJc=;
        b=miwQ4aP6XvsKZhJeFBLWzdG7IKlll2dcD2NO+m/T9X15ia0VaWN1DhskMLSXXavQwm
         yiI7UvXxYl2dkRmSp0ohp34zWRpRg8TxjCcYSiTLyULGu2f9ZyXwDzbJxxUSlC/QjY5o
         3RDxsTxh/7ZMyCi6JC4/h3V+S6xwJdsmw79I88a7C00fDGqoJlAght9XainEE9ny3sSF
         e4ZEJUt8kAQE3pa/79N/A6nQ5RX8CUVKuzi3Ot6OrYxpX+1ABfEf0s/zzvbS0WPxmCOo
         CnjMiyZjrRAN3mhum4ph5/L+Q1ijZKrax1FwhhQBUr6Ygiy1jVuNtlp398kHgiBbQe46
         APiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727410440; x=1728015240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUExd/HvXISJzOnUZpKfBxGs6Kqdkihoj+/Acbs9JJc=;
        b=rzbHE/0GLnq2pmB+041jeC5GBPq3K5R91CBB2Ls9lz6uJ+Q6WnR+2kJQVOH2aH23c9
         5T+OeH78Gjty0439cwWGzEC285226gORixoA3xXzpQq05jlhZVxSvBLEq5jWn+FwEJ4f
         1YPszEyscsz/727Mfl6JmnWnguov0mG6Hx3Yky1OKf9WLicJS5on+4qCk54A5XscjWOX
         pYHhBB5dEx+pXy7COgXc/Yy0uirbk5k/+pqsmTOugeASJoJHbXfF0fL3Ps16qmM3Izck
         f7s3nwD39x0P32Xyt36bYXpKm2hOk4LdJYTQ6wxIpUEvXlWb+k5mgvHbupVwg/e1RJdr
         M0vA==
X-Forwarded-Encrypted: i=1; AJvYcCUCpeyK7eLIXV87lS/7ETMqamO04VahS7z66JDK4HWiVAGMSDVp8tTtoKmeN68NqOxB7HXr18NkQatmcyk=@vger.kernel.org, AJvYcCV1Lu3aA1V1jwCw6Zgrzs3B+NgsAjsOiOhmY93cth26Jtx9JFXj5QmT8O+cdLJqnAWVBp+jtSsST2yT8g==@vger.kernel.org, AJvYcCVt4rruWVNEWUXBcPuIy/+hZ/Dv3B9KO/XmqTglmyaqlwWsN2Ta6BWjg9ZzJKgyVkATmBFYqo7+Um/a4DKAXGQ1@vger.kernel.org
X-Gm-Message-State: AOJu0YyEtJ//bg4mg6wh2kUV5InFNLKwNgENaG00UH+sVQ4kljmxAWPI
	flZA12kI1OwSQKjwQ6k/Y/EfMH7f9fyQoGbQgREdoqrW99U6RgEnFmn/hephN+9rfA==
X-Google-Smtp-Source: AGHT+IE5SAx7BYv5N77+UUEF9ITGukQudJ+s69ilmU5GDAbJqHJJi2THX8m6kLa+SqCaWtIsyVq8Zw==
X-Received: by 2002:a05:6a20:6f05:b0:1d2:e987:c343 with SMTP id adf61e73a8af0-1d4fa6c82a8mr2700027637.24.1727410440409;
        Thu, 26 Sep 2024 21:14:00 -0700 (PDT)
Received: from haliu-mac.redhat.com ([240e:34c:5766:2070:398a:da67:287e:ed6c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2cb063sm689941a12.55.2024.09.26.21.13.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Sep 2024 21:13:59 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] selftests: rds: move include.sh to TEST_FILES
Date: Fri, 27 Sep 2024 12:13:49 +0800
Message-Id: <20240927041349.81216-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The include.sh file is generated for inclusion and should not be executable.
Otherwise, it will be added to kselftest-list.txt. Additionally, add the
executable bit for test.py at the same time to ensure proper functionality.

Fixes: 3ade6ce1255e ("selftests: rds: add testing infrastructure")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/rds/Makefile | 3 ++-
 tools/testing/selftests/net/rds/test.py  | 0
 2 files changed, 2 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 tools/testing/selftests/net/rds/test.py

diff --git a/tools/testing/selftests/net/rds/Makefile b/tools/testing/selftests/net/rds/Makefile
index da9714bc7aad..cf30307a829b 100644
--- a/tools/testing/selftests/net/rds/Makefile
+++ b/tools/testing/selftests/net/rds/Makefile
@@ -4,9 +4,10 @@ all:
 	@echo mk_build_dir="$(shell pwd)" > include.sh
 
 TEST_PROGS := run.sh \
-	include.sh \
 	test.py
 
+TEST_FILES := include.sh
+
 EXTRA_CLEAN := /tmp/rds_logs
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
old mode 100644
new mode 100755
-- 
2.39.3 (Apple Git-146)


