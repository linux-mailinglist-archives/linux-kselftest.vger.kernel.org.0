Return-Path: <linux-kselftest+bounces-488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87507F66C6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 19:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4447DB210B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 18:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F123405CC;
	Thu, 23 Nov 2023 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="gJ7RVFr3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94B19E
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:58:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a00ac0101d9so159848566b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700765908; x=1701370708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhz1HO1TFrn+esU2JyrDQXLuWyA0tprcaBHDYdqjcxQ=;
        b=gJ7RVFr3BplZ5mzK9yqnTTzgxxePX12hdwZxTOZVjyvDkAHDNGRB9FOY1tBe9+Tciy
         v7+tjZrsyNjceJy18oL2Z0PyHfCOdBAa15uMgul5YIDOoogvZDnkNBz8RSJS8OeHMjlG
         hAU+224l4M7e5HgXkBk8ZP2krc+RG2WQMkmTJK/UIaU+wYVsssIBc4bQbKWJVqXmxvfD
         hkCm4zbKHfUKLnUOYqSq8HANBiB2FpLtzGTRmi8l6CQcN842fdGCr6pchNq2uSiwvp3J
         cZk79Z716Rz97DCQQXzbpTNlzgAXJFj5vVsv+doYGPWUVaxoW+jdHvP6vIYbyhBjx2sp
         DzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765908; x=1701370708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dhz1HO1TFrn+esU2JyrDQXLuWyA0tprcaBHDYdqjcxQ=;
        b=fXlIO/hketUE75a4LSjlXFki5mTB3ZCktrCdfCP2Tu7RpTGji4MoGsR6/MzFck0rZp
         LeHiNJzueUQHcEo0EA++TQJLwWlvuAwF7t5Hy4LuDkKwd2DqLt/zKEiWaUF40paD5CAd
         veBCDfsIlGe/0YPruxbtAqeADQuyjEwSIh/FK8LsRhUqARK6f9sZgcZBIgNRe0XldeE9
         cKCeS+pIBTSK5/WgbhE6vWcUb9MJNP/noBsyVcIlOjeASpf1fRyYFl8W8oADqZiHACTs
         f82i8pMIGMEa+I2WgH4xr51Fxvh3R3w68bB3XB2ys1apnnQRcYWwOvSsC6/72XL5l+uB
         9scw==
X-Gm-Message-State: AOJu0Yz5oe1M0383fBfp2+nKFemOcb9aB9fYPI+iF/EdmZRPQRwL9Kj/
	AUVW8GP9PK63RnQhMtXjXgdT+A==
X-Google-Smtp-Source: AGHT+IHuV5dXf2Er0VwPFonFK4Fp1h+h+XsSB+7tO9pY2bovS/v0cFYLhOuYH9heihq0E1lWqqNMWw==
X-Received: by 2002:a17:906:d4:b0:a01:8ef2:849 with SMTP id 20-20020a17090600d400b00a018ef20849mr177665eji.4.1700765908104;
        Thu, 23 Nov 2023 10:58:28 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906231700b009ff1997ce86sm1115944eja.149.2023.11.23.10.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:58:27 -0800 (PST)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Shuah Khan <shuah@kernel.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	=?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>
Subject: [PATCH 1/5] tools: selftests: riscv: Fix compile warnings in hwprobe
Date: Thu, 23 Nov 2023 19:58:17 +0100
Message-ID: <20231123185821.2272504-2-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
References: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Müllner <christoph.muellner@vrull.eu>

GCC prints a couple of format string warnings when compiling
the hwprobe test. Let's follow the recommendation in
Documentation/printk-formats.txt to fix these warnings.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 tools/testing/selftests/riscv/hwprobe/hwprobe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/hwprobe.c b/tools/testing/selftests/riscv/hwprobe/hwprobe.c
index c474891df307..abb825811c70 100644
--- a/tools/testing/selftests/riscv/hwprobe/hwprobe.c
+++ b/tools/testing/selftests/riscv/hwprobe/hwprobe.c
@@ -29,7 +29,7 @@ int main(int argc, char **argv)
 		/* Fail if the kernel claims not to recognize a base key. */
 		if ((i < 4) && (pairs[i].key != i))
 			ksft_exit_fail_msg("Failed to recognize base key: key != i, "
-					   "key=%ld, i=%ld\n", pairs[i].key, i);
+					   "key=%lld, i=%ld\n", pairs[i].key, i);
 
 		if (pairs[i].key != RISCV_HWPROBE_KEY_BASE_BEHAVIOR)
 			continue;
@@ -37,7 +37,7 @@ int main(int argc, char **argv)
 		if (pairs[i].value & RISCV_HWPROBE_BASE_BEHAVIOR_IMA)
 			continue;
 
-		ksft_exit_fail_msg("Unexpected pair: (%ld, %ld)\n", pairs[i].key, pairs[i].value);
+		ksft_exit_fail_msg("Unexpected pair: (%lld, %llu)\n", pairs[i].key, pairs[i].value);
 	}
 
 	out = riscv_hwprobe(pairs, 8, 0, 0, 0);
-- 
2.41.0


