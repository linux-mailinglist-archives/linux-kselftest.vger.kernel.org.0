Return-Path: <linux-kselftest+bounces-17495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE4C971086
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 09:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3886828125B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F39F1B1D44;
	Mon,  9 Sep 2024 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHFxniWR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D871B1431;
	Mon,  9 Sep 2024 07:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868614; cv=none; b=KfbUHKeQeXb/BB0BgguDci6DrIsDP9i5opPaQDKLjfg3xokkEEWAZ4Moths2ci/Vka8UZhArwEjJ5pQ9a/JIsS3lax49tw63BpeF5Wb8sILrz5S3t6AprovGL11bl6KhgIpHq/qNwXcqXhItlTBy8HUNzn/faEqFzniapurnLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868614; c=relaxed/simple;
	bh=1U0hmGZ4pOGyuQtP3rk/Vzanpq0gsss3Giyw2VXlUys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCUmbtKs4nFIETV2n30EdNNyZ7ROj806qeQb6xPwBQxsrvP6Fv7UMc0JiUmX9srSmQ75iAd3+XmJvvkexMlismK+MmA6eylMGK6AJirbt17zV6T1a3UYz6oxlLGpdBIVzraYBIINCipHWTvooiNSsCA/MRLTKob2OjcJdgFHYDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHFxniWR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so16602845e9.1;
        Mon, 09 Sep 2024 00:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868610; x=1726473410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRfmK9XiELkgvke2KZ1pLgHNaRcKS5bA/Qy7jNwAfDM=;
        b=FHFxniWRWrXa0+yefJLVkgHr++mOx3ZGfJ26M/HxCHGRxcCOsznaGbvkrMdK1CmZRm
         c3iGt9sHhHxpKNe3rOdNJCswAbjsI8UQjWS7Tmq5g7JgWft8JrOQcbGSuKCPsyrzdC+r
         NS4uhLKyQcZWBehdjKrB2Ou+hJ7NEjcWz9ldDrUTMYOVlqpJ+Fx0CDjDaE3VK1qwyUbh
         MWwF4lQt2qUtFskCsW9NDy8STzcebfSP+C66p2+2HMm5GN/t1ZpvVBo6Bhgyie6lP9a0
         2PWph6IdqhJCJEnjz4h8k4Ok4vmsHaPGhttCSB2e53FmUMn5SzmwcGrzjV6ZapiZV8Bp
         Fz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868610; x=1726473410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRfmK9XiELkgvke2KZ1pLgHNaRcKS5bA/Qy7jNwAfDM=;
        b=lCKy3D/2hEgpCrzDsTd1SNVP6KkWaePgfGYlS8mXa5AXmIhIdzDrMFQqnjM/l7gpuM
         dxnOMBeBbeymBkVeSF606kzv8VtVkY9chGF22/0RaK6f8N0z+SkcssSY1N7yJCJAuIvo
         5yWXZjr4vdWqZSBhVPZfAwkcWlogXFCGk64ZLV1zbyM9PxAtiLYcFZUV/zgXjWS4hrvF
         FxyYH1Fp++iP+bWK7nu1Iela2DpNXDlcbpZzeqhec582iPjmNVrne6+XGfiFi0ls7FsS
         kab1kKwfNWP6bp5vOENheEfaupCAWWN7e4kXufIYJzelSMNjsDx4749IIfPLJND40Jmr
         DVdA==
X-Forwarded-Encrypted: i=1; AJvYcCUpq8ErsMhWpxm5qKVdQu5kvM9jWXUe7rF+HABfOkexUmj6LghdUhvSEyvCBhhKEdATzj2B7WbGMVOZits=@vger.kernel.org, AJvYcCUwMEDbap9BVZWLWDiazS/RceCsE0hJjKT3CvhvyPXGorWJAz0eNph4F+JJTQSBEyvirIr7LKHQxAcdBg==@vger.kernel.org, AJvYcCVe5E6esLPSd3Qvncmv0QcKIQnVX87NUWWkYHdgfV+3EvsF9lQ8X+mJnl0cNbrKJFV5sBU=@vger.kernel.org, AJvYcCWCm5NXShmKLCIf+ZYOfzGnV1v4w0o6P8/Nec2ssUzw/CkHNu6brYwuHaN64ujhLcatY2zntzSx7Y2CHrObUtQ+@vger.kernel.org, AJvYcCWKAf1TC5bAOAjiaYuAq1RqngU2DZdfC3cQ5B63V2/VTJZal1zw8Ka2HoghBwdyTI5CLQmG22Gb6IKYy52x@vger.kernel.org, AJvYcCWoi7CJREJNYmWeBLrxUG3K03AJsdTHEXKrlG+Iw56lvsclsDySkEpSV9ETc+QNFAMW/X3rNisv7XY77V1fPQ==@vger.kernel.org, AJvYcCX9jWC4tEVL/qABfVOMa1BSE8QZoWtp04JkUDhk94cfKU6id0/XRhKQc8ji2y+0RUDJ2r4IQT25uYkoiaHf@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtX0uhp1SikAeEYsWMqX2NBX6Xi2Ud8ileywtd8DS7a8h/0zX
	WfsXLQfDMPLbhBSRDVVi/bikbroKAXh3psjzbJ8ZNfBUrRIyc6A7X2Ukflo3MkE=
X-Google-Smtp-Source: AGHT+IGXcCDv4DFDPdFSIqVFPwRvA3mDfJWQsySfBoGz736imUoLNDjdjo5DUMJkSdrlazNFf7whxA==
X-Received: by 2002:a05:600c:4e8d:b0:429:d43e:dbb9 with SMTP id 5b1f17b1804b1-42c9f9caa4emr65165305e9.23.1725868610286;
        Mon, 09 Sep 2024 00:56:50 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:56:49 -0700 (PDT)
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
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH RESEND v2 02/19] crypto: testmgr: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon,  9 Sep 2024 09:53:45 +0200
Message-ID: <20240909075641.258968-3-ubizjak@gmail.com>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
---
 crypto/testmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index f02cb075bd68..eeb7edd99a93 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -23,7 +23,7 @@
 #include <linux/fips.h>
 #include <linux/module.h>
 #include <linux/once.h>
-#include <linux/random.h>
+#include <linux/prandom.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 #include <linux/string.h>
-- 
2.46.0


