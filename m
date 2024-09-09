Return-Path: <linux-kselftest+bounces-17482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B6A970F1E
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8631F22A5A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89BE1B140E;
	Mon,  9 Sep 2024 07:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Em5wTufw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5AA1B0132;
	Mon,  9 Sep 2024 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725865716; cv=none; b=dZ0CoNrEbE2hrC5bOht/QcseUlV1cPQNtkqQeMromBKPDb6kvsSU0NlOkJ1vh6nU4N1Eg252KSSQDXWV/qTIVZgao1XCbWlfaGvE/PjntWMpE07Mh07VHaePblsB0tbCMyJbTLXrET/91foYtJaT809tK9df5OfBrR1vly5EuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725865716; c=relaxed/simple;
	bh=p48Rzz1oFrPh7OwCz62uWL5xWiFSQ26ws2cGJATf+h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oW9qHRmnhq4ngBjZPDKjPmUqyF+YIBNNL1lv0D84bn6JXtxIG15U/dBo3v+tgx4g4y9W+Avx9FXid/cO02hMIuRAFqzB8a6+5vst/7l+qpNBc9J9CixJulMSUgLl0XFnEYUAIJnpsqzfwiJDGe3ZOgEFjIUGKgBSRBWQscYE01s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Em5wTufw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c3eef39eso2225603f8f.0;
        Mon, 09 Sep 2024 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725865713; x=1726470513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK7oAHt19v4bPo2zqG0Ykp0jbeXdGIHNkoqennHtifs=;
        b=Em5wTufwPauZC/s3SGdtbn1x+nwp+J5d8yCFuGOYCetf8ITPeQcEDt845oxNHwp9EB
         9XG+s93uejtzMJ7e/ABVbrl5ZJ4eAK3Tag/cdmWUvNYHaZ7Z1xneDcxU6pSCMHLdHBBE
         EGDnIlUNGmK71v2GPANSDQg6g0fdZ49EHraXXtvHMHxOkvgN3i4eRvrKxCrlv8YhObXU
         VnMyfZPNKYqVlEm3gMzEIbIIByYh6Awyom51VcKwKCOJdTVD9n6ynKXHVnyvVxP4/9Pm
         t402DQwfto/v2N6NiLf08/1CVT2keJhj6BqvzZH7QjYApfAJzqF+7hqN+/pNFCTVrEj1
         bQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725865713; x=1726470513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK7oAHt19v4bPo2zqG0Ykp0jbeXdGIHNkoqennHtifs=;
        b=H4wnaEqUuZTzDkGy+CqITLTLmdhF2rQB04cO2vNZqceKpnHGBp0j5McT0WW+mKTGkg
         9wxbEhtnK3tzFgOM5g8VrbVxsG63leWGFp+HWaS8ZQtcOoB7ZBmXGmKlI2h2Na6AZkvJ
         469ToStbSxggJCgLT99S+dtUC+oKzrtTRPNBDRDfUYeecXdaOZBrY+mS5L52RVy0dnw4
         kUNlc5Lzt2oNq7GWPSSIsFPaqfqysORlZ8vNs/73SdOqvS6cpC/BYT+pe90d75Y5t6QK
         w3/ssxO5BnGyNo14BzSkbi6AjOYl6cLM91E0gH2+N/zgF9EVN6mS7h5xDbX+37GOWTDV
         hXwg==
X-Forwarded-Encrypted: i=1; AJvYcCUHV0KRYO7SjrJ3TTe/6ZeSobD2/aO3tNpPLSTpfes0I+BDt0ZIgOpt6gZiUJ5Parjr+6LeuGpJgqrrhj2YwYkC@vger.kernel.org, AJvYcCUfyq3vwuIcjZ8VIcg0OipLeAmbFU5NfQvSD7JoNcQr9sx2Ja3FEa5la0OsFJJL4DWLIvs=@vger.kernel.org, AJvYcCUkl4isD17lcc+8WqTMmFJYn0kMKT4Xzjd5aUKU054igG7kUD6rVRNtuEC4YUBXP503FEC2y6ZHccojXm8zUQ==@vger.kernel.org, AJvYcCWfm0XlpX2b/WY6tGB5kSrKN7zmZtkaRaXN6k7QCLnKXHh/nBtJR1ty3+LkThktPsvGSGNGIJvSwdgsOVY=@vger.kernel.org, AJvYcCWwWy50+a8SK7PoU1IoxD2DWaCIBDjnpNkzl6bHXMpBMbBDtOu3Sj/HGjRIssfbs7lKFdx7mgMb71SNO7Cc@vger.kernel.org, AJvYcCXdzfp2MLA0EoEc9bsgOsJDzhAI5P7OdFkIIDzNmTK595oD3Y6rQnK9B7RBtUfghf5H5/9HJSr5jzsuZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6PJwlRw+c7sO278Bwv05e/nxrWpa5yb8QHHVOfI3zDa2oDx0j
	9yVFcMNtWg8qeWXyzdg/NaQPxFE6t/VTANrG5eSdamYcQfaqMBue
X-Google-Smtp-Source: AGHT+IFi67K8QB4r8x5dBm9y5325f1H3SNjB1ndU/CGDMv41P1K19WzeQTZI+70hfCKm0xevGHxxxA==
X-Received: by 2002:a05:6000:1143:b0:371:87d4:8f12 with SMTP id ffacd0b85a97d-378895ca2e1mr6475478f8f.17.1725865713228;
        Mon, 09 Sep 2024 00:08:33 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d375asm5178754f8f.66.2024.09.09.00.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:08:31 -0700 (PDT)
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
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 10/19] lib/interval_tree_test.c: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:05:24 +0200
Message-ID: <20240909070742.75425-11-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909070742.75425-1-ubizjak@gmail.com>
References: <20240909070742.75425-1-ubizjak@gmail.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/interval_tree_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/interval_tree_test.c b/lib/interval_tree_test.c
index f37f4d44faa9..837064b83a6c 100644
--- a/lib/interval_tree_test.c
+++ b/lib/interval_tree_test.c
@@ -2,7 +2,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/interval_tree.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/slab.h>
 #include <asm/timex.h>
 
-- 
2.46.0


