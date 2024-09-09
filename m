Return-Path: <linux-kselftest+bounces-17497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A39971095
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDC0281014
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FCD1B29BA;
	Mon,  9 Sep 2024 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjCJOmz4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009061B2507;
	Mon,  9 Sep 2024 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868616; cv=none; b=ECIBC0E/KpIpU44wANhLkBL3HStlVBMNtsifb0Sz7g8bSR7Wfyn53co1WE8VRqFaL+ynrO+J9mbWW3ISC+j64Yl8UaZ8h07/Gz0vw9+w7So9/4Qo9fEcfjuLPaZ7jDXdp4tF6ZXplKQoifrV3cSjEPHGpDeKRNuI8GHk4HRyol4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868616; c=relaxed/simple;
	bh=dwpD06pHM6cKKxt34fstEUoMKuSyMqg9srk/BNxTwYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hA6AHmukk11hF3BbNrClgeWE+xYa4cEF3D7Q1f9DAqaXvmITH/YbeXS74VN4cDqjglZlfPMWbzbvJxCbW4QHy+HIvYlYPbjZLboO+d0BSeyR305huQpIzTij0yg2WuayTczM91tzb8xiJqjZyvRpeID0AaBe/MhDZXuLdlvwwP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjCJOmz4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374d29ad870so2414949f8f.3;
        Mon, 09 Sep 2024 00:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868613; x=1726473413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWDfXNbOPKK8OkK/H/srkd9h9NgocC7Imjlm69NJz1o=;
        b=LjCJOmz48HPY3xB7nngT/pf93I+3lHV6S0UtAbfVRsG/zPethFBH8ASrLlHoovGmf9
         AgNX8mjE6mpDXNdD4wcQah0FFdPeQW4c6O6SCwbZpo7uLo0AC22X4TXhXzlIPfSJ0DCC
         1nlkmsihauz/V4kE1FZ1SYO1/9qSW8WSwAqsdPpD7ggT5UBI3E2WAPSVJK0c5fLuol6X
         bKKxFoywI32eF00kkGEB4NprRAPUIgX0U8Uil9hnA/m/uYS/xqzdjvn2BKR9XEa14nyA
         4NQYGCunljlarvyOfvglLOM1adndNLHMSjY8jnhlQiNiLMrTBEK2ynZuqC/CDV3vEaO6
         HysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868613; x=1726473413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWDfXNbOPKK8OkK/H/srkd9h9NgocC7Imjlm69NJz1o=;
        b=haaqkNHWZG+c4i+roQqmL+hZfoEH4SUnGbU+91UpCLFG6cIAc9AmDWvYpjXXRQvkyX
         t+LKpd8dBePEd9J/i3YmWxOOqrnic1Y2IE3cxo7T1+r9eOCMU1oQVyLVvcKFE27zcLys
         hEUvf/CEAYIRkKHzhnSprptrNxx50RKty2LritXMOU6doQLpXbUl67YQFf0f8CxGMj1a
         2MIu7/Ninbvptr9lceZA2t0AWq92ynJcqr7ysTo+mMEbD7SR3pLRvPYaO8l1JsdYWsd7
         u6uycGTRwcsbC/RmLMjsfwjHf5opa7gWOPm6wD0vFTxQtvMt0mURizX1pqzpjnIai4N9
         nt9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuHag6LpRYU/QffMtQn0CcSnKjvdBUyEHAzkcJ2qJnmPTYlTDR9ApxZ6ERH/urTQlvP/w=@vger.kernel.org, AJvYcCV0vN9+pwY1yyO8MQ6vue2HhOA6TdU4cD94w/MvlHzGa3ZEo89dnNmET7sr4zx5di8KYAdYNpb1tfEHxEA=@vger.kernel.org, AJvYcCVQP0QmlAvJnc0wxEhoiARWRLugXYzgwUe7r1eAHIwRCCAU93kHcmrxjO6wVwmllqfgpMraWN+NvIzcRwx9@vger.kernel.org, AJvYcCVVrLqTc6vcgBiPIwnQv8x1Kva1/lHkAIseNFSXkAQItvh+RAw+rTa3Dzaw9FXrE+vCncz+aDGvEpCdog==@vger.kernel.org, AJvYcCW0QWl3FYO8CwB9pTT8SWmLc4LrzaCqki0ZVpeIEwCp7wpHG0xr95ltX5YMQ4w3IyHrlZfgcaitOnaMWBwR/g==@vger.kernel.org, AJvYcCWOf4WXGJMgEITDfjel9g5XSbmRPyg5wM66Ptl5YdEnHz88SFdyC4nFhI0G9RAHwK7lk4Fv2VAbXhYG/ErW@vger.kernel.org, AJvYcCX+lgLzDijSdsGxME1/fdZtZT73owAgfDDyFBoTFjvHCBEd+JqQRyi3YWm47DmxwB6Q+cBKetCYQ/st8Nme6oq5@vger.kernel.org
X-Gm-Message-State: AOJu0YyAo8sxzeV/7CkrWLRMK4tjbVi/5S7Zsv30NO2yhT8bpLD1yIQQ
	A4NU5waI8d3JUmoWCIgTXL+c3aHaRxWH6hy30WV/+MXv1kzDT6IK
X-Google-Smtp-Source: AGHT+IEJwY2izSi9JvPnlSkxsbiABRBgLXcw/WN/9+VtYgXEpeqF7jtackiugNKAcXHsm6kUmrt+Ng==
X-Received: by 2002:a05:6000:e07:b0:368:7fbc:4062 with SMTP id ffacd0b85a97d-378895e2f23mr6668484f8f.33.1725868613138;
        Mon, 09 Sep 2024 00:56:53 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:56:52 -0700 (PDT)
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
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH RESEND v2 04/19] drm/lib: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:47 +0200
Message-ID: <20240909075641.258968-5-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909075641.258968-1-ubizjak@gmail.com>
References: <20240909075641.258968-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Substitute the inclusion of <linux/random.h> header with
<linux/prandom.h> to allow the removal of legacy inclusion
of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/lib/drm_random.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lib/drm_random.h b/drivers/gpu/drm/lib/drm_random.h
index 5543bf0474bc..9f827260a89d 100644
--- a/drivers/gpu/drm/lib/drm_random.h
+++ b/drivers/gpu/drm/lib/drm_random.h
@@ -6,7 +6,7 @@
  * be transposed to lib/ at the earliest convenience.
  */
 
-#include <linux/random.h>
+#include <linux/prandom.h>
 
 #define DRM_RND_STATE_INITIALIZER(seed__) ({				\
 	struct rnd_state state__;					\
-- 
2.46.0


