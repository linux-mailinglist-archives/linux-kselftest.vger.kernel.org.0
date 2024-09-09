Return-Path: <linux-kselftest+bounces-17512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7E6971110
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 10:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEDF281D14
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 08:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316A1BA26A;
	Mon,  9 Sep 2024 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5TSn1Zu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839011B9B26;
	Mon,  9 Sep 2024 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868639; cv=none; b=DnGFwXzlEx07xYz1rGT2uuYkIdSw7ZtTFlRJAntp4W8ZEE0NWiMV406ql90hmpWjz/6DTD5VPWJcdJDISK2WVp/OgBRUBsQl1XyurJ3psFOWufyMWlJvzKwKcMr3CJiESqcjiRaDE9JCLT0otznhx5qZiLZF6SQA0XFVzftNs/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868639; c=relaxed/simple;
	bh=3uUcilVnojt4+ddh4TttNjspH/Ah42tEMA3oIXy4hyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZnCTGPigUydlVbEnx3rDq48h7yEVGVGRVU1szDeN1H1dEEwyBR118BTfxba0Bz9D7rReISK/7+sp8s+9NZng4hsRh9NWimjmwYmrumzh55+NT4O6QwWMARIqVAobfUdjR9FlHrgS3XPyEstC+bL4LLYldXHsOhSlFWGt0wxCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5TSn1Zu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so2605856f8f.1;
        Mon, 09 Sep 2024 00:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868636; x=1726473436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diK2vfMDlJNUyXW9lcHoHKMejPsgQZ2jk7i/6JqtmLQ=;
        b=K5TSn1Zu9wSHyg22vRIUBJRFZE0+nW0Fx61sQgywJSYKXXLa24rlxyssEtJDaq1Mkz
         N26Q+luc+IVHFIj1bRTkUUTHI/zFHRIqKaNalJUWYm5xcWqiKgDxb7xpeCefYsPul2n8
         Bba6XMUX3g6obJ4S6/rElfdPZ+IsIG/w4z546vGJYNC1UuTFPjFeOniceUmzwIlWHyn0
         0UynNYF3onJH3dpO2ZQdHi9JXqT77KzrZZqDC1ZZpeOheJV1Ztx5whzaeu+muKUMi6+K
         x2IESbG4MFYSNwCWX4H4eAiYUiEkL8Pgl2toMjS//8s6VoRpFy4gWv0u5afnOO57z5qZ
         mS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868636; x=1726473436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diK2vfMDlJNUyXW9lcHoHKMejPsgQZ2jk7i/6JqtmLQ=;
        b=KvN7UiVsuoDXFVMMFR0eAgWOL8sUMfAwB9i7rNsSVMH8At2ycZfkGfgm2wOrb524Qk
         JAPL8SYV7t64eRoWTBdwkehIzwuT8UFB853rmtQV2Fle56ou39YB7YGyOkXNCZiHpE6U
         XCUzMAd9L/PQFH29eKSjuQvtIsoxPYKkrU/Qs/9eVRkfquPBAd8G4tNid2RGb+0vrOwe
         zOt4n6uUOBVICspaQ+xHJq6hf7+EGBt5r7bvNsIIuXwx7sM9U2r4qJYqRUV1gRlahAjq
         Exn0V/IcPO2L37GvQzjIbtEOIQ3zqrP+EHh5Imzb7cm9M/G+Cqcaw2/4/uGq/dcpPwvu
         Hqhg==
X-Forwarded-Encrypted: i=1; AJvYcCUPihdABBPFC/HaFqR4d01GlhVltIRcBfm6i2dtniSdD78m8iRYFWneq3g9MY8QZ+xCK1g=@vger.kernel.org, AJvYcCUvTkDJruDZ3Se60ORLIIgoBHHujuO6Q73h3CtRwrrgmwp16rnWn8TvbZmBexBvZp/84miLoZU+8rJP1A==@vger.kernel.org, AJvYcCV9F9AhS26NOhp0NpVtem4LWt9QFBH0+OYw4uENk9wC+WhSRR0IRphSjcJ2PjH5A5IicHZTFdHr0+4KbvaP4A==@vger.kernel.org, AJvYcCVHEyMdwXE7mDQdt7rS2YHME1Po+fspeZxn0zAU55krw17T+A/pSchs8lf/IcPN2XEkJ1QnJp1JH5XsSeg=@vger.kernel.org, AJvYcCWTencOdfl0NdzDRpMzknC25N7dB+ykjoSrVrXzAUE99VCYIooRlRAd6dgT0zdPSTWQLnDlZekypol0+mMN@vger.kernel.org, AJvYcCWZk3H3YFLZRSEwu9zZvdfXlKmo5aKycb9ngyuxZHSJa7CcDKb3YIoADOo5gHp8hPPQBAXbHgi7fK3sL8Jp@vger.kernel.org, AJvYcCWd9V4BtsAVh9z+dTYYRmfQFfZL6MFZx+YyuO92lknnWoGZBToXDg+bHLBmapEdoxtENkjVRfUnorr1/y5ubb6G@vger.kernel.org
X-Gm-Message-State: AOJu0YyuppX+HNfvgcQNBrPy83ADsTztYvuR66OzzhMDNd6tW6WtbcnA
	ZNRCHmuu8Bp+kJ00GF1wkEwSkCfclKeBdqXddY9Pl6hK6zE7EEId
X-Google-Smtp-Source: AGHT+IFme0X5nXLgn/ucuf8q8ansjRE1zBSf1qUsO6JYCVp2iHcyiqIaQ+1W/AW6ZFOhV/STuqOK5w==
X-Received: by 2002:adf:fe84:0:b0:371:8e3c:59 with SMTP id ffacd0b85a97d-378895c2578mr7417099f8f.5.1725868635798;
        Mon, 09 Sep 2024 00:57:15 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895675b7esm5303001f8f.50.2024.09.09.00.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 00:57:15 -0700 (PDT)
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
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH RESEND v2 19/19] prandom: Include <linux/percpu.h> in <linux/prandom.h>
Date: Mon,  9 Sep 2024 09:54:02 +0200
Message-ID: <20240909075641.258968-20-ubizjak@gmail.com>
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

<linux/percpu.h> include was removed from <linux/prandom.h>
in d9f29deb7fe8 ("prandom: Remove unused include") because
this inclusion broke arm64 due to a circular dependency
on include files.

__percpu tag is defined in include/linux/compiler_types.h, so there
is currently no direct need for the inclusion of <linux/percpu.h>.
However, in [1] we would like to repurpose __percpu tag as a named
address space qualifier, where __percpu macro uses defines from
<linux/percpu.h>.

The circular dependency was removed in xxxxxxxxxxxx ("random: Do not
include <linux/prandom.h> in <linux/random.h>") and it cleared
the path for the inclusion of <linux/percpu.h> in <linux/prandom.h>.

This patch is basically a revert of d9f29deb7fe8
("prandom: Remove unused include").

[1] https://lore.kernel.org/lkml/20240812115945.484051-4-ubizjak@gmail.com/

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/prandom.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index f7f1e5251c67..f2ed5b72b3d6 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/once.h>
+#include <linux/percpu.h>
 #include <linux/random.h>
 
 struct rnd_state {
-- 
2.46.0


