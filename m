Return-Path: <linux-kselftest+bounces-18630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634AE98A2EB
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CA591C22A73
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FA81925BA;
	Mon, 30 Sep 2024 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmTNIqOS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784718E343;
	Mon, 30 Sep 2024 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699841; cv=none; b=b605GIcKxhYeD0HxG0Gs4uMEwzujmyNHGERl3e7zj2Ftd8tvc/2AKgYqHac8HloBnRXci3FxlYNIBCAn+pJi/LCVOdkWTEOKAUZ0Ec9GWQbRXR2b5c+/bS7hTM96hYmVu/7RoDE2IoL3ocSzPoFJ+3dz8J9AQGxrtO8FC57L7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699841; c=relaxed/simple;
	bh=CGWdWkYxxooP7+yKn1oyL+mkmR9CNCLKxkG8lVp4Hkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCw3eDxTqEVItPDx0JkOPKZ2LOqHI+J0bvK4DNtQ/R28oYB5eJYLiy46kcNLGqIEHCoIOuQuvfHeGGcWyjS1cnnCJwugbIQBTvUJjmb3uT5UZvMD3QJ3Z6xYxyQKuClP6Tdbc1PrpcLLqJAOsqgnlkeD08sA7HeKQbg2OQdu/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmTNIqOS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37ccf0c0376so2404954f8f.3;
        Mon, 30 Sep 2024 05:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699838; x=1728304638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzOLLRPC71jtL2OjNuAlvY4gjd1poR9VKDBddhyc4rA=;
        b=kmTNIqOSuUNTKgoYdVOWxt1JcKuXAW7FWb6yYQtu858EZhujJyjH/ImjAdEMGQt/vN
         E8/20ueL/9n4GRSgzxvX2FeICZYqtd8d1jri+XW3lHJ3pwOhZoDoFIbfNTJuB3IA+e5D
         zlwdI5ruLRILdHkmyYe3VI4ywH0CWo9zGGA3/CupIh9v7jHyYJM5s5XDn9y2c4vqc/sW
         K41q1jJea/pWOEdM/ieqcxJIWW5GIdW2RcI8h2mCgkjje8Hilyze5pSLGI1VFBb9WtRI
         Wi4tGeGwPPjpDc9LbRfKhvVV+vzX0G5/eHMyAjifWZ4QjmssGHUsMW9g4WHSUdNtd3cl
         sZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699838; x=1728304638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzOLLRPC71jtL2OjNuAlvY4gjd1poR9VKDBddhyc4rA=;
        b=gGRPxU5JSxnroR4eaWVMb2L/oeuVS3HLe+aNBheMs+FKt1EpnnNBuwG2vtAxE4eABB
         orHUTvVlS4dyuiVMwzoyX87Cb0DfgAlhja6tINyw3RWWzGcHhC/L2udcdMzqXmNkFEHq
         c92B2546hy8jsOTVHTiWwi87fx3h4SeY6dQ4Auutda/xpxOp3Pf6WSHVmrbjtFu3vwrY
         41L21Vpvc3cxV9jh4NYspz4rd6ntuwerSLxkCwMEYW1yiUox7Xk5oyb2kpQjyJVNA4wq
         kcA117MVIuivdayIBL1Y3ZNXoQ8L/aw7GOv2mDpeSPluUpkn+SLzsEEFmehfHwBwZCcD
         fqYA==
X-Forwarded-Encrypted: i=1; AJvYcCUJX1G7BTPHWj+zT+88QrqpmCjmlkBitP+7ztKT5XQLnbyAT26EI5k9ZQPSCJSktXNzIf2LCOQ2/hBNlw==@vger.kernel.org, AJvYcCURiMxsmq79lPbuH1dMcFLrxhoJKHumFBYQ3It4vSVBEBy+rW+IFq2u9LTmIR4/bwLv7Fj0WxjQk/7Aw7/yXvmG@vger.kernel.org, AJvYcCUeWcBNpJqCyLGhLrwNKZmfG8IqPRsF8LwTYpFm1ydoL4XyvIwMmwhPbCEsRP1iohgyiaMBePXqX141Ar0=@vger.kernel.org, AJvYcCV4YQtVATSa465BnLjkTgCljV5PNRoANLHGJNDBSpJKmzsGePkg5k9JOghzxb5palY7H3U=@vger.kernel.org, AJvYcCWV3OWK9Balz5WHJpgz/tsADJ7RiYqrFzkStonE6OSzBzONMrtjut+EyGFWQ+PnOCzwWhLkjpVPeAIu2e2e@vger.kernel.org, AJvYcCWy9FARgfaVCZggs86PtBRkBCKM0mQ+B74gXZNGbXKuLMcwnptT4UnnCEqmuGkxtOi30uju7/X7m7ENW5K4@vger.kernel.org, AJvYcCXUuWTNwgbbHsgka5XVy7z162Zd5LP3hjNrsoAU3J+8HFb4Og7dWLZwNutVTUtWszr9MCBCrZtpSULtj358aA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvxEtVky4vnjjZiEGrLDymN9PCegalTRdVxIoM4onp1LU8SYz
	bbeEqATtzKHbPsgc+WW886YNPu+iGlD/P6+MxSlexuxaDx4rjdl7
X-Google-Smtp-Source: AGHT+IGh71qi0qyayzgI7eFDFpBLWxTr/OTyditWnrNY5k5QUB6Kmr2d+RBqzeFs+cdbH+f8p3vxFQ==
X-Received: by 2002:a05:6000:108f:b0:37c:cd0d:3437 with SMTP id ffacd0b85a97d-37cd5b09c91mr5194049f8f.58.1727699837996;
        Mon, 30 Sep 2024 05:37:17 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:17 -0700 (PDT)
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
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH v3 07/19] fscrypt: Include <linux/once.h> in fs/crypto/keyring.c
Date: Mon, 30 Sep 2024 14:33:18 +0200
Message-ID: <20240930123702.803617-8-ubizjak@gmail.com>
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

Include <linux/once.h> header to allow the removal of legacy
inclusion of <linux/prandom.h> from <linux/random.h>.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2: Include <linux/once.h> instead of <linux/prandom.h>
---
 fs/crypto/keyring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/crypto/keyring.c b/fs/crypto/keyring.c
index 6681a71625f0..82fcc5683649 100644
--- a/fs/crypto/keyring.c
+++ b/fs/crypto/keyring.c
@@ -22,6 +22,7 @@
 #include <crypto/skcipher.h>
 #include <linux/key-type.h>
 #include <linux/random.h>
+#include <linux/once.h>
 #include <linux/seq_file.h>
 
 #include "fscrypt_private.h"
-- 
2.46.2


