Return-Path: <linux-kselftest+bounces-36002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFC0AEC094
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 22:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94763B13E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCB32EBDC8;
	Fri, 27 Jun 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dKh/KZGT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A4B2EBBA8
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054745; cv=none; b=ZKytcr1jZlHv1bfxZj0i/tLbJecSityKUdALEOn9qH/auQ9xdMoMyt93zTDZuR/BRpSs4aUHnW+rhZnd+Gi+ZCcYtLW+aFq7tap+bI+jZGFjJG+cYW2EfZn/r952jQX77+u20vNHOJig2BkOF1knEgC+qzlrydIBYLZumxN0ZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054745; c=relaxed/simple;
	bh=58VetzeaoTTUO6xje0ZO9jyJyh/pGGsMiDy6XnPNWFI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lR/sdJroTKfaPujnfZQMO5Lx4XUK5poSCCf0mys3/A7Jvpo9Q/GuWMq2z0/DSJAptJ/VTm718tUCc3Gr5XJMRjNhg8XUpdubH9XBjmtFb17p7uWTJTCxyRjyFEJQTDYPAlW0UjpVYf9G0CTU4dflSTl8VRPUYapcyZKE2az2sWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dKh/KZGT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31f4a9f67cso468659a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 13:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751054744; x=1751659544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vF3w72k6M2FJsnp0yQuYIlc0wWajODBZmfeD8ZMb3YY=;
        b=dKh/KZGTJJmmyZVnLiXJt6/T/jXdsjmoeSKouw2rnvrwgoui/FoqpND1oeCoX9KnRy
         yYxiOOw1lMUnaKVN00CExAQ12AlU8kl0qEqyvKi4VduQSx7Xoe55NJNLCbwjnMDgEY/4
         R5w8o6UBzwXPWyQI9FPJDcOokiMIj27kgLXjqfBadhVmW4o93AMAo6CsfLngSmowdKK/
         NGn842CF7seV+gnkvEzAco4tFHxRawItzMtg7kO6vXHhQ5Mxxsj4Sctsi8ubwO/yJkJt
         3FmuktSXFwtCqmLeXdpacWSmeOptXW3vJgCLiCmr/1oP9A3cI6limxXysgj2kS26Tl+p
         ZxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751054744; x=1751659544;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vF3w72k6M2FJsnp0yQuYIlc0wWajODBZmfeD8ZMb3YY=;
        b=AhIooHZ+RxU3/sU3vy3qTHSDlaWl1J9+FYrS70UsNxVRzlqk7X5TFGCf08WuCuRewR
         buTehs2M6Q9n+kZ8xICCK3IngY9cCI8lEhNbKwsaACLXSg51h8GaPqn+B3FFzvuXPoCk
         /HIEMNwjYKlAhbrGq3OKgeV265y9rMnckF79FyY+jWfgsptKSI8pW/HEjg0PJCrPCEiA
         hlmiyqZLY5V20AThVZ0wzmlWx0vUL6Yajpk9T8TWHnMoz/laJATbYWfWYP3z2yOmw4c/
         Lw5sHy9s/N8D/uK9qn/1B0p86ZA7UNcX8Oo/MaJmshE4lcnx5ZQaq9iBne/VNaVPlQq1
         0DWA==
X-Forwarded-Encrypted: i=1; AJvYcCXHCpH4oJV6absFLmwKozzNB8ecne67D6suPXKEcP8uuePLBZ3kg9OZEbQmmyIWMkQfYvt+l2kroQWgf9icNiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX0mAim7SpT5NZQdSB+l3QzrQLewGTU2U3AQVOFm6QvZDPc7iE
	oT5ajFIun9BLZEctwXshK75LA7c9IQGoR03u4d4n7ivd5uw5oEWW2hCsEAAIdgOfx5AximA69sT
	nT5bXo04iRA8ZXx8coi05Qk6fjA==
X-Google-Smtp-Source: AGHT+IGgA2AyrASEeQalRWqmeezLlku7J3nX7jKNCFbgJ5auTtUg89qGUZ4YgwmCCUCUy/MWeJoqjGwBDkr/pL380g==
X-Received: from pjbnb6.prod.google.com ([2002:a17:90b:35c6:b0:311:8076:14f1])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5683:b0:313:23ed:6ff with SMTP id 98e67ed59e1d1-318c8ff234emr5811759a91.1.1751054743828;
 Fri, 27 Jun 2025 13:05:43 -0700 (PDT)
Date: Fri, 27 Jun 2025 20:04:51 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627200501.1712389-1-almasrymina@google.com>
Subject: [PATCH net-next v1 1/2] selftests: pp-bench: remove unneeded linux/version.h
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

linux/version.h was used by the out-of-tree version, but not needed in
the upstream one anymore.

While I'm at it, sort the includes.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506271434.Gk0epC9H-lkp@intel.com/
Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 .../selftests/net/bench/page_pool/bench_page_pool_simple.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
index f183d5e30dc6..1cd3157fb6a9 100644
--- a/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
+++ b/tools/testing/selftests/net/bench/page_pool/bench_page_pool_simple.c
@@ -5,15 +5,12 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/interrupt.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-
-#include <linux/version.h>
 #include <net/page_pool/helpers.h>
 
-#include <linux/interrupt.h>
-#include <linux/limits.h>
-
 #include "time_bench.h"
 
 static int verbose = 1;

base-commit: 8efa26fcbf8a7f783fd1ce7dd2a409e9b7758df0
-- 
2.50.0.727.gbf7dc18ff4-goog


