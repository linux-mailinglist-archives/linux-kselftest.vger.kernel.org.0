Return-Path: <linux-kselftest+bounces-18627-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D97F98A2D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AEA22823E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215701917C7;
	Mon, 30 Sep 2024 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbyAAphp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B9D190064;
	Mon, 30 Sep 2024 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699838; cv=none; b=f6h6GniG45otiof/213I4xY/ct4gadEMmBgGNUussyY45M8ITl0jDtxluyciW0Vb+UN2vJgXVwJVZZ+panujdXfWQ7iwaI3DJ0ZVAMgi3LNnN0eQESQiljdfbZ7lgcu3/nTa98SWLnSQm+MbwwdeNTxrVGHyinixi48FGaE3DkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699838; c=relaxed/simple;
	bh=8FnpV8pfNTtAult4r6PHmRMy2NVO4ZM/CFmfsQMzUcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDlzUycU0ahQ8nuk52tZ6rBdMLmGzjI0R1e/K6QzqQiCYjuWuMqgN6u3j/clm2vn1FgtMZkEvhcw6oex41Vs+fnGE9Rq4ISOjsy3DUa0N/1W8lcblO9cDQE0rGYgs1HibrJjecS62QnpwNqDlOsRJE8nv2XK3gouUlmZ2P6/fqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbyAAphp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb1e623d1so40073445e9.0;
        Mon, 30 Sep 2024 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699834; x=1728304634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIz4XxD/MXWvSuHKaNsZDh3MppYU6Ey9Ren8dN/1Nnw=;
        b=HbyAAphpUEKM7Z/kT8Wg4y9qUBIc3W71/TL1p9r/AMqNfsp38qj5uRZiKFsyDDNPwA
         BRILOVpCWN3UtEkclYwd8kxo6j9mjNueGibxZAQsINHE1DwNmvb0mI5Bb45IULxmydQn
         6CAXT8pvnK5C7MGGVrM9/Ak6/ccqTa6qtWxpctigF+LPE+q4HF1AZK+v8I74EoU7lwgX
         cwodiwSRZZYW5capbUWhfvWNufICG9YtM5nAyBSGsbp++9GM4+3W2ljfY89dFChzqZal
         ZJLZ/c2pX3kIBpjdvqXVjo4HDr35wk5H8cMriwUY3YNO3pVkEcq2npBeHRlypiiE/i+5
         0WJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699834; x=1728304634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIz4XxD/MXWvSuHKaNsZDh3MppYU6Ey9Ren8dN/1Nnw=;
        b=KpDwSp1HwWIPR6rrAElGNyYz92HqmLrcg0NiR3VhwhbqExmNATRYcdlpU2KffdgL4q
         S6jmPrrsnxkbxF/N/FO2gyI79bc9SiuNNcSvcrSiwip+dcT0erPyNs+8YhuJrch5iJxY
         vnleCSvJq97T3My325alVlkXLLNgJbJRTJOk7G29oZ2F4dQArsquTY8uvjITZ3N3S20h
         FPiQywySibvZKiDhbHbxRAKzl+e4Ckeowp0QmPvRv5FP/EEnbGyq3AFWATJPolVjbscf
         lcLGfZwZdQyf9FYF7S9j8pB0r8pCkuHs2VSt/nXEF9PMekWPtO02ZjUsUPxL3z0SF9Xv
         eR5A==
X-Forwarded-Encrypted: i=1; AJvYcCULwM63HjK7FXoP9RfZeuY5qavjWut/zlvZ+oSeYBZdLd6VtxoUlgpyj+0YLGqucU+ZzGVfoy2P9HuyEKBQ@vger.kernel.org, AJvYcCUaQqMIlxEMX5HODmPT9VU1I9M7FDbIC7V90YY/Ol6wzfmgZaQP9vwv6ZdQdgWb7W7sM6zHKnD+4rDmMA==@vger.kernel.org, AJvYcCUpaX78ChZLGpEZWnYppAi1dLWXbRS8oS9cz32DxvNMMTCXWFbNO8UMZiiEHp+G20PwICZbVSW3RtYRStgcVg==@vger.kernel.org, AJvYcCVIyP94g39xr1K5MMa+osKtuwW9sy6PjUCmw0Aq1uXd7h0BvIWfCrLZzSrRl1pfmfrpPLY=@vger.kernel.org, AJvYcCVyaEy/5NHYAlp6mz3UA+duDGLyQeuIskABbw3zZuKNzBUMMIM2L+zad9dfRa34VxegMrbOYFdmwz4U+DDT0b27@vger.kernel.org, AJvYcCWtwiMlL6M4OhYjtkw1ORJ7S5GUBu84zJQqXBidH03i5eMGzM8u/4ttKQhjX1jEB4LbWiZuGr4r9bgjmsHi@vger.kernel.org, AJvYcCXVszerHk/vlNtH/3Ut0ZPtdRtZL9zruajSmoC7hL61WrnGNnJdLjIjzp73KbXUEb8YoOQgz711MIZxehs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyhIc1fxNrQTvpse59IvxdxJUi3tsO9SZr/2EF5XHqMtMJ1UT
	xvVnLeSLkbeK7bx96l/m+mh2YsPbOMlPYjUXgqA5X0gpVvX7u0/V
X-Google-Smtp-Source: AGHT+IHLebdUj03VIWRmjVk+jZmmDpfIAH8/fQg7ILqXr2avcVfhMeGRYFMjONtxE6BzkKSMTbFFfw==
X-Received: by 2002:a05:600c:1549:b0:42c:a574:6360 with SMTP id 5b1f17b1804b1-42f584a1d5cmr91192685e9.29.1727699834409;
        Mon, 30 Sep 2024 05:37:14 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:13 -0700 (PDT)
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
Subject: [PATCH v3 04/19] drm/lib: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:15 +0200
Message-ID: <20240930123702.803617-5-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930123702.803617-1-ubizjak@gmail.com>
References: <20240930123702.803617-1-ubizjak@gmail.com>
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
2.46.2


