Return-Path: <linux-kselftest+bounces-18626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFE398A2CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416721C2186D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC13F19046E;
	Mon, 30 Sep 2024 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIW4oFiI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3418FC75;
	Mon, 30 Sep 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699836; cv=none; b=Bsv3utztS7xer5RxHsAWVe3fdAvEnPElM8ZV35LCcEMwuHofFsrgP15ggYFtmkDiKorOKY7aBC2a32NGu4VINh9ifY+9tAuu4TgPzZpvzwpu/HQ7REGkmIs/lKhbiSQoKLCRUtMUQA2ltnu4Zknqr2VXadNRv0zCI24v6OXAarw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699836; c=relaxed/simple;
	bh=d/y31NV6bNlMd9In05zXYIk+xyfIZ1P0Q7H9JsQro7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLPM2nlUt06knG03wCNQlhyYR2JVkABSze5ymHCFfXk3hQQmYypo+wOfNDl4iRcyjuXPRrcO5+Bc2wy705OmojRw8Aq3HPCw475iDywz8mnmdlVrPyoO06QkyNvTyxMtC1BEG+240SPR/vjchHu+y8GAAUkbj13Wq2mYOll3j4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIW4oFiI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so39514085e9.1;
        Mon, 30 Sep 2024 05:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699833; x=1728304633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWdhzc84IUX3iZRvSVXhcMocJl1l3V+3RFdCYOgUVyI=;
        b=jIW4oFiIfvzEa2jXJlrUOoChrug0AwMmFNcDIzEv+6Ss/uLdh6PtLDxIG4CF9shkY6
         CMLHxBISc7fYVGNKBRmI3DYSb2rOsMTPw5fgBJADsieHbu1qhtehisdkITmtaakKrKEr
         9fcm6yupPWfRCoo9fko6eTVzPuQ4WHTxnyauJrpZ90kIEaUT2fFnJlHPjk5hKOj7/fSA
         nBCVYFAMEL9SaTylgWCrYdZ2gDj/W9iJQlsdAERGoWgxMfTeHL8tgEvicBp4S6wf9i2U
         ujKXFn6xS7Yokoh45aqAZ/NEYhr80U4fsHMDbr7NshMipVByL21rWTQRuVxGtmgHrmM1
         HHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699833; x=1728304633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWdhzc84IUX3iZRvSVXhcMocJl1l3V+3RFdCYOgUVyI=;
        b=WopFGwu2f7dSJPgsm1HoM9yp4G/M1P5am+2A6DQDfTDGKJBwww+JqXW15mK1osJSIV
         h23MrFhbS93ealBf+KVeJcnIMBFfJbYIoFtG4obN10CYyjXC1ndMWf3HkzxWSZTRmoSF
         7Eq/z66IO+nn5TgyTx54rjiFQjtV6FhZFeKiurSyCEn741ggNAiWNhxJbunmorsz9i3r
         M6XDVO4fLz0rNX4+uULMZmzUKFfPowQ2dnXShR6kV8w6PRtT4oB5MKVvHp+CgvGwXcM3
         81dDJcpsPtCkjRm/5Kik/t52BcsBZ/RjulGVgyYufndYWm4PQjTJdrdIboRPAn1hVJif
         SFRg==
X-Forwarded-Encrypted: i=1; AJvYcCUhEoxyFWKkUjjlQR7NrXKZbWW1ezdjT8ltf3Ko3CyJZjUNyHn0jBjH1mmAU68Ds6GNFQPTWlhWp+RcPrg=@vger.kernel.org, AJvYcCV3UXV6lKVzms7oub/fZs2GfADblDJ+bj3lxh1FAjmc6lMOxVolJPpYy7SZrBDL3CfBC6sLhRJnHZ9c7nW8@vger.kernel.org, AJvYcCVLcMkAzbhySr0UPFADJSgvZfG8zIKYF+Ai1luPCaJ5MaLCFKLbTJw5Xj6l1L2gODahmKLLVpxclTUBA70icg==@vger.kernel.org, AJvYcCVVB2btzvTDNdYOBJtT7ADb56a8It9jQ7Clcp0Ji1/NzvNC2YSQTUPEkkhq/m7QvqNmYITnzruttsMWXg==@vger.kernel.org, AJvYcCVm1g/AXJkZC/aGYsEaNGq+SpqoF6TcBe143e57pIfYj22j74P7B+4o4wg+vWRLn9wxHN86aHfzx0gP2sCk@vger.kernel.org, AJvYcCWz9/eOq5/dOjYTa8DYueGwMtvitrfsLl9dQUmWYyOn3kJdtIp3KE/sk0GVOlGae7cHoSY=@vger.kernel.org, AJvYcCXNzra2bl6I3XXjA8faubewWFaU/HJgMavrvuTfhhedScx8f7EmLyjjbowud++GqowSZy5YnQv5f1jLycVxpE10@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6PfPh6uEkE5hJacvzPA2dBA3Fk2erbHYDZV4FqRH/XtaOaHZp
	wqDJsQYdE/hVIT46VcdLNxTiibRAev5NlxJovZQ2JMuJUeQfHYtJ61kRHPUyZfQ=
X-Google-Smtp-Source: AGHT+IFcXQiYgy1UCejNT8Qld3tDPg5srqzSDnRCPSydZyRhIwizEVC4oe/1cX76nhckBGiahi+2eg==
X-Received: by 2002:a05:600c:c5:b0:426:5269:1a50 with SMTP id 5b1f17b1804b1-42f6944174dmr24736915e9.11.1727699832942;
        Mon, 30 Sep 2024 05:37:12 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:12 -0700 (PDT)
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
Subject: [PATCH v3 03/19] drm/i915/selftests: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:14 +0200
Message-ID: <20240930123702.803617-4-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930123702.803617-1-ubizjak@gmail.com>
References: <20240930123702.803617-1-ubizjak@gmail.com>
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
2.46.2


