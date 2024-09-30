Return-Path: <linux-kselftest+bounces-18625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB1498A2CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82E2EB253E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B62018FC99;
	Mon, 30 Sep 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ede+pFZa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D72D18E764;
	Mon, 30 Sep 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699835; cv=none; b=OgNGDjMiH3g3q+Ot8uIu2qgKaRYzxsDmCrE9qiLhonTSM+topZdEsh5Zyz98DYl1IG4mbUtFsWNJXPEm/LLkhzaLQpAOlvKUo7HuY+naZqbxET3u/hSX3uHY63/AeNRp7ho7qeSfM17tDFUNB2d3HiYHZQ2rLG79X/Jjj6SrlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699835; c=relaxed/simple;
	bh=MyUoBU7yKsM1yzSjavbBbSS0zyXuHEmAJbnaHv6n4/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpY0gbS8K8SffP7HluJ/Amvt6SCKKvTYFhu1zZ82lGzqwJA9LhM6LrDkP+U4h0oegNBEdyckgakpa2GpwVKbyP6SEBPKbVeBb8b52P1nzJLJVrT/4hI9G9yC8vdtpH5mKzMRDUYpHQM54jbNIg+Dc0QwM2PefcOHRHvWdG2HrhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ede+pFZa; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37cc5fb1e45so2860588f8f.2;
        Mon, 30 Sep 2024 05:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727699832; x=1728304632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6G4Ex/yEG0PawIZnX5kHSAD3j0oy1BU4Shaq5r1xaw=;
        b=Ede+pFZaEH0nuY27B9pA17b+ykcToECOmv+BrBfeQ8Q3Arq/W/FePKfAiIHFg4tJUK
         RMgQDBPa5+JJhxoVBHxol4i5uPeOb/MYCxAtWecEApM+Nl0EgLJWITgK/x6saBzmqjzb
         QtRD4nXFePEzNUcv2kInaXr1zbGoI5T15tC9yr3QMZ5zeb2yULKEljQRXfyi8QdPm7Hq
         p8sxiYccmO6JH1/Fd/VxM6eut9pM/snOekmyKi+tnA2YzrpG8m68+V3VBhpqyM8jcFI9
         eDa69XR/01TzwwGl21YK1i9oSBw1hY6iM5BXjxEzT5KQVc+u9VVjZpqgKySb5NzAmU3G
         MI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727699832; x=1728304632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6G4Ex/yEG0PawIZnX5kHSAD3j0oy1BU4Shaq5r1xaw=;
        b=RO2/FHazZOTfRYdhOLBvHXL7DFp5EwOdmYaB/RXPZPNYjFZOB2MCsGMLRWwvMNBWyk
         XLYTd8md3uhm3quN0H6AX9TL0R7gldz8miol4oByYS0s2FKwJHI8BiiF/+QalfPVaUrJ
         cchuaBk+gle6t/BEI+2VFYyS3VN2E3ctoE85NK1RYCoG7h11TAG82x0/xvecHu8bLjxM
         RFfigOAx/HuPrjOtrTHhutFW/cA/lfvqb2QnNR4MWd6H+k7ldmvmtdhf/DbGeqEdJ9b+
         ycETTWGagrtLsZrtoLC9vPerkU08Hmzw4wAFIe/lNoRwjiRDlMmQn82eWEOUlZgMcBPW
         te2g==
X-Forwarded-Encrypted: i=1; AJvYcCU4alf1VOHsu2VmvrJY7aHXe77NWjkrO2CL70CY/OoS3A1Y8rh/u5e1Giigxg2nAwdHXHI=@vger.kernel.org, AJvYcCUJqjpiZCsSm9JSJcnwlA6ITYaRmBAKHx1WBBQUeE8Kfis4Obrhpbx/IYxXMAbsgjUsAOZ70M8KVhcRwys=@vger.kernel.org, AJvYcCV+x3M7QQ74qTWyk++8XuRe5+8z3PkqsxCRbUs9dtXxQ8PYX3xKcXLh/xizLEi1TaX3U27uc4uUufgGqv3b0Qy+@vger.kernel.org, AJvYcCVFyr6FfjiY8lSrLaHircAXj7JgD2AW8NrQKCka/CDJl05COuvZIR2/tbJppb1hL5NKPC+cpLClrRsgKqkZ@vger.kernel.org, AJvYcCVWAen8Ahxs/W5b2wRx+afQFno7duDecnz/CAJNtCFmf4PTU2vEIm5nzD5HP2sMOlR+oAwyAogX/Btb3/E8ew==@vger.kernel.org, AJvYcCXEwvRqLtWzbwXz7uri3iSCtFJw9GYXSRtS4kv7B0epi7cpLiuFB9WKSeKPJlZdGiPK4FDdIGJtrvVgCg==@vger.kernel.org, AJvYcCXSJRWt/1drBdDgPZEIhbKDzDlGPvj4sXnqBTlRYUeY85HXA1qpMwh985chD59qXEz3nWsv8LVtMKkKAMRd@vger.kernel.org
X-Gm-Message-State: AOJu0YxGhdxZ21IimkGWSymJ4CfNNJXg/u5ZiM1FzVO9aA8O/EGMMQS6
	cPpluSSJyk1i9AcPov5GUmr9aW3sFxeeGO3MWtjhh6Vh3W3ZfBxs
X-Google-Smtp-Source: AGHT+IFB6/hHEmYYfhNOCdbJlS8GC1KGQPWBaBcyFYt3K3bCumyRmpa2UpR9z404TFq/hhpGQgYEVQ==
X-Received: by 2002:adf:cc84:0:b0:37c:ccdf:a2e3 with SMTP id ffacd0b85a97d-37cd5ad92e3mr6377920f8f.33.1727699831651;
        Mon, 30 Sep 2024 05:37:11 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52308sm149011355e9.43.2024.09.30.05.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:37:11 -0700 (PDT)
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
Subject: [PATCH v3 02/19] crypto: testmgr: Include <linux/prandom.h> instead of <linux/random.h>
Date: Mon, 30 Sep 2024 14:33:13 +0200
Message-ID: <20240930123702.803617-3-ubizjak@gmail.com>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
---
 crypto/testmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index ee8da628e9da..43472e79533c 100644
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
2.46.2


