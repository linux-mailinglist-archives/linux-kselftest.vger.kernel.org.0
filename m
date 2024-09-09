Return-Path: <linux-kselftest+bounces-17475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79B0970EF1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B071C21CF1
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5A41AE863;
	Mon,  9 Sep 2024 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQU3G4J2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBF413AD1C;
	Mon,  9 Sep 2024 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865703; cv=none; b=id1nvuzqCwQCXeforI5tGmHE7Y/eYSllFdwvm+QJVEJv0+u7wVZhRb9aJs+wQNzA63D0euBcf/RfFkfH4Vraf3RNk/+fr3JezUtEDhQ/0mAVkRQ+igr807xjuxtqEc+uTHRDXKGMs3dgei0XkKE/yrxsZwITzYSn61bhamyXWgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865703; c=relaxed/simple;
	bh=g+4ueaAVd+pinXS7ngoiJxQtzxinuP3fYBqECJexNQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtkvBvwAmHxBm194CHY2rj8GslzC1I5VGOCix1I0CnanZTSU6Xc8KrwcQmz2dlaht2Oyq3ZG2myYqoyA+A9APkwPJ0u8P7XY/nPElOM5Fkp5CIXF4M+3/nu5rqgEoA7xrdc4wY5I8x6D6yKYiYpf0NsF2+zxDEd2n31e4pwPYIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQU3G4J2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so3589816f8f.3;
        Mon, 09 Sep 2024 00:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865700; x=1726470500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14qfBrUBkIolMsRSnhXU/v/JiTjLcMYNIcdp3nVnQBY=;
        b=hQU3G4J2f5opptF6nobEZlQ2chslsAACLVtz47Q5TgjT0mzyHBU8VSfXZxkv4zRz1p
         HZft2PttL/Dz75vD/aUX6LIMy6HnasYjv9FtEe+BIHRyFhdff6fh+1b4PmfAUnKaa6DI
         iaDCM5+BLKrUqHWbIkYOzzZFaTzXenFXYBAMowSwGuTgxE/YjqZqSLev9HIOiK5xHgD+
         Jj9FTNxJwgoILSvwWWX0+eYrnwpvdRzpL/VHcuw8HW7Elm6etAQO6UX8in5VhBMvIEhd
         xcJGpqmZZnHR8sX1RvzrvePy10YUco7QaBKHKGbK/nP0bqZZpjUMljkuGFov7t/UKBVk
         vtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865700; x=1726470500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14qfBrUBkIolMsRSnhXU/v/JiTjLcMYNIcdp3nVnQBY=;
        b=iKJiIVtKXs9ksyLhEZ09BmZ9f0lCtnqx8FEKt6gpr52yOtNZGhUP/6fypJOhcn7E1W
         CD3RSWfg88Dmiz+0WmBBNmW7wfMZ6SoRJRRLpNUuZTh5FeWgo9OXUSrUqZVDUqrsnaLZ
         +xGhg2mqv3QJL+H37EEHoSqtT5dAfFo+nb5zYz8hRN9CDwxKGRiI7eg/ElJ/GBi+PWlI
         HH5WuoWSc7mYoEyBsmTLn7S7AuYJQGzjGbvWtfA1PqvVnW6KObEpzGhhybBGtFEcMg6+
         z2mejmD0EeM56GMebv75FnzONoPYuXPV0wLuWx+6v17SlK7KPsEq/AjEt9mpHsyoK5FC
         W1Og==
X-Forwarded-Encrypted: i=1; AJvYcCUa6HjDxf/PEO/VdlcZ2FhA0//OSfx4HYy564AGjiPA6p/YTJ6GIltnZNp5Od09BOw3DYjowiQj/cJcD94=@vger.kernel.org, AJvYcCUrTt7+Xfo2l+7rVG76po2luYBFAB+TbvVFt7tN3JwsT0mHo4QJ1ZIRs6dbUtSjg+keOAff3+bx8gMWug==@vger.kernel.org, AJvYcCUxSjmJgFFuTA8ZAVa3Sh8tmLcy6uE3Lj60mOmxA4dMSlecDGE4LbZ9bGGbbbObSvTX6Hi4hNsDw7tsIn6SNu4c@vger.kernel.org, AJvYcCVeERAOBOtk0t++U4s/LiZy9nSIjU/MspKywDB5T13CKBvXBrNj15t9CS7fDrBefFGKkieLjUtzeXLehfgVoA==@vger.kernel.org, AJvYcCWt6+9U5BZxiAi2QO+Ev9ui4e8UrJ5RtwBtgTU05UrsdCgAq9huJCLRc/7TduSe4xhc69yWLa4I3YJvHxj7@vger.kernel.org, AJvYcCXseY/mXwuEpmaECXnSaRQNL2UDTDH9XVrhj2HtOKZvTyGAQvs2E1uVWxw+S/76papZmVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdRnUa9Sqf0vOwgTH5xMmY3VQ3s4AUiPXxk0O4mf/5AxG3ZewH
	uy6xyxruhSOAfEClOUNsK9uTJx/zcGDBaKdrqmWA8nPdv/CWBNoZ
X-Google-Smtp-Source: AGHT+IHMxHViAQuYhY7LbiGTRSQjuSO1CzAuIEbDmKQ7N1Z92ayMooKBy6B84PbIuJbIoGvJODw6LA==
X-Received: by 2002:adf:f4c2:0:b0:374:cb5c:2956 with SMTP id ffacd0b85a97d-3789243fd67mr6064910f8f.40.1725865699969;
        Mon, 09 Sep 2024 00:08:19 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:19 -0700 (PDT)
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
	kunit-dev@googlegroups.com
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 03/19] drm/i915/selftests: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:17 +0200
Message-ID: <20240909070742.75425-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
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


