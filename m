Return-Path: <linux-kselftest+bounces-17496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F112097108D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B041C2216C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085A81B2526;
	Mon,  9 Sep 2024 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjcUlpoI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E61B1D5D;
	Mon,  9 Sep 2024 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868615; cv=none; b=UN3mW/xBlWhS/+f+eflakGPHj7rb2E0g4YW/qNWY5E7zNwNM0IlW82ub5bbcoyPOx4Gpn+0sVFc1F4sQ4sZFj+X9ob3jQujexwDrYrB9cC0EhKL/ymmpzC9gFL7G+qNnz3A6DAoyphlkFGzE4ypfai5kN9L/0LYnfv3gfiraf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868615; c=relaxed/simple;
	bh=g+4ueaAVd+pinXS7ngoiJxQtzxinuP3fYBqECJexNQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMXR/ipzsJ0iG5TPlm4JKpMEozkBTRNtd8/73/OKnaALZxzLD9zBJ94C271CMpLuSwlAxr9jJROSZcXQhQXgfSSTQLSxpA90AKCMWLkkwZ4ywh9hDhkL27gP8zAy40vYq50h5pEir+7j1Srx9EqK0jCny/93MCajhdQuAZS5b1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjcUlpoI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so6249575e9.0;
        Mon, 09 Sep 2024 00:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868612; x=1726473412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14qfBrUBkIolMsRSnhXU/v/JiTjLcMYNIcdp3nVnQBY=;
        b=PjcUlpoIHWjh2cD+yVGSre4BHRIiifHiHk5fZfYOK0Qfs4/pE6jjKPP1bL4MmcT03C
         g8/3eOMABZOgnjztNHjsn0Y0nC2bGWHthQl5EqaM1X97oJWfSIs16tvPsVUV0kLmSAwv
         YTHsE/Jkk+90sKDibLHRlJvEqXNI9ckDgCEofYQb3/ZrcCAsgpl9evYbFF/qUXJN/ROE
         I6z5JvT+2URj+z/aUAe1I1hCrN+DXjBXgWLmnLUkw7P8M7LkYRChm+RlrplNP4ZCgPVV
         NOSCdXKPM4vaJi4yoAdjFY7vMI5qkoLu2huND+H48tloopYPvRC+uEvoxzWqj7hsYGVA
         Azgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868612; x=1726473412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14qfBrUBkIolMsRSnhXU/v/JiTjLcMYNIcdp3nVnQBY=;
        b=vFIJjfvx0s8LjXwiIaXDLvQuP/aEKpYiEnmofzIcCidSJ0nrZP3E/0RZUqdNnswc8l
         VbqxHe/j5UFcRpKpOHVBe+9vVudymnorjvVhybuyooHxqBhRnDrZjPKsW1UsAvuMJqR7
         A+J5PA9WcaVkS6kV6RldyrpoS71eu9WiXayZQ7XQLm8dXAeJsVoxr31QPe2SdeSUblLR
         tBgOO9TTuGGNt3a19oHY4OBfeYE6SinK6eVhfyg4d7ddlbU64mXWQF+QXf2YiUuhI1PS
         wMnnvmtGJ2SPYTjBUGgw0BOudcCLIiQiNCCj9fIP652mrlDMZuGbR8MSLKkjFSe6clb8
         SRRg==
X-Forwarded-Encrypted: i=1; AJvYcCV0KGm0BNmglgFC8Ti9NU6kgCSjXVL0fZzw0juB4x2xORTCUGCu02TwYy+mWx/cKqdy2zw=@vger.kernel.org, AJvYcCVUdpar35HbSuLBs/7i9pLY1Vu7NPIcChoMCAsqrNGTj7Xk6LhTIlA8h5PaoeTzk2xPpVGvobgVoUshpbV6FRS3@vger.kernel.org, AJvYcCWhmGMYfwfpdfXDcBEW+lZK3NNGXdyULCZHHcjH6opET1pBanbI3OeR7rNo6ofOOkjzO66fyNuJ2CW7Qd61@vger.kernel.org, AJvYcCWpcWgRZ0UjVTT7IThcg+20mhSGGTREvTPrn9hy1uFEiphW1VFQeTmvH/UrkOciqta832/PCXih0rNiTmWm@vger.kernel.org, AJvYcCXBWwlDx5VzT8Z6FH9xk8Liiu/zcy88X4Ajlv+U+60Mv4YAja+/6MdUuaRJD1DKRpup5DoaDGWLCd3+LA==@vger.kernel.org, AJvYcCXna7O/F8gCE1s4Nqa3gQSNQAxOzCCMuqTvVO9BdKiCU/ySWMmTIaBOnvozMMHgNd2fMSA7RPyvEzQMEJs=@vger.kernel.org, AJvYcCXxPHNAVnQbJvBJjhm/juo9bsZOXr0YeD/z6T/fcvtrc+mmDmdFzQeBGgPUJabWbb2PaQLufZczKCfZGDxNPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtt2iQrW5HTbwmUjk0pVSvJ3aBtXx8NQgYuWukqio/ZqY308oP
	nje9ZmCMvHE5tEaE82uhl9DvZ7hZy2b+SVcjGXxJQA3O73SyGjFn
X-Google-Smtp-Source: AGHT+IESGKS/b/3I+SBf3rTXq+UoAQ/sBaFO4c/YOVV0ofXN+ihvCL604F2/r2duzQEowocOYCixTA==
X-Received: by 2002:a05:600c:17d4:b0:42c:b16e:7a22 with SMTP id 5b1f17b1804b1-42cb16e7addmr29272525e9.12.1725868612166;
        Mon, 09 Sep 2024 00:56:52 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:56:51 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-fscrypt@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH RESEND v2 03/19] drm/i915/selftests: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:46 +0200
Message-ID: <20240909075641.258968-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/i915/selftests/i915_gem.c    | 2 +-
 drivers/gpu/drm/i915/selftests/i915_random.h | 2 +-
 drivers/gpu/drm/i915/selftests/scatterlist.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_gem.c b/drivers/gpu/drm/i915/selftests/i915_gem.c
index 61da4ed9d521..0727492576be 100644
--- a/drivers/gpu/drm/i915/selftests/i915_gem.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem.c
@@ -4,7 +4,7 @@
  * Copyright © 2018 Intel Corporation
  */
 
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #include "gem/i915_gem_internal.h"
 #include "gem/i915_gem_pm.h"
diff --git a/drivers/gpu/drm/i915/selftests/i915_random.h b/drivers/gpu/drm/i915/selftests/i915_random.h
index 05364eca20f7..70330a2e80f2 100644
--- a/drivers/gpu/drm/i915/selftests/i915_random.h
+++ b/drivers/gpu/drm/i915/selftests/i915_random.h
@@ -26,7 +26,7 @@
 #define __I915_SELFTESTS_RANDOM_H__
 
 #include <linux/math64.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #include "../i915_selftest.h"
 
diff --git a/drivers/gpu/drm/i915/selftests/scatterlist.c b/drivers/gpu/drm/i915/selftests/scatterlist.c
index 805c4bfb85fe..7e59591bbed6 100644
--- a/drivers/gpu/drm/i915/selftests/scatterlist.c
+++ b/drivers/gpu/drm/i915/selftests/scatterlist.c
@@ -22,7 +22,7 @@
  */
 
 #include <linux/prime_numbers.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #include "i915_selftest.h"
 #include "i915_utils.h"
-- 
2.46.0


