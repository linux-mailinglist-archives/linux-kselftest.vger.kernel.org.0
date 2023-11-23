Return-Path: <linux-kselftest+bounces-491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938937F66C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 19:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 507D7281A34
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 18:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8F3E496;
	Thu, 23 Nov 2023 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="cQMI8JJm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC2D40
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:58:35 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a04196fc957so167463166b.2
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700765913; x=1701370713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r701pvo9PbgE9h16+HzDZMKOHNQtZ1R5aBMPWWKprHM=;
        b=cQMI8JJmM8qjaLeMVk4RNlEsMuL127P+aY4k8iy/iz8h0VwIqjg0Qihxdk99fZNmxL
         Hz8KX4+zHEUEgjPLGnVccBEMSwprXl1g+Wy2X9BtTwsIXXL/WI3D1WxCxHnwEwqbHC12
         zoLilQGEH+gfogv7ZzS4MqET4mzHT4Nw38xvqIl8jaycFnsVCVqixr6bGi5jENyzqCPS
         mVO6VuOE8QmSNgbqsp0J1wl9z9PDAqlzX4vJtrhduJFmL6ElRHQbNMPkpunXJMQFLILe
         KzRmKazci7LYxbgKyg/FhlFJnOH/NgQH0U2ch9v9WtJ1dHq09Rt4EpArQzZUIjfDVYr/
         fvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765913; x=1701370713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r701pvo9PbgE9h16+HzDZMKOHNQtZ1R5aBMPWWKprHM=;
        b=LOQqFqYp+j5tzKKV9omoJydo9NCQZ5nl7uQmIDtoRP0MoakbvMDm2bKz0WjoNXKyfA
         WwsZM0CI5JyMLq2gBE0CZgWBWrKmIJaYjikTjzV35Qhf2DxBR8BXtwFGgH4JAmUaG0FJ
         3Kva7uZB+veWy+bMAUzV/yszqD/Fkni1C/rwCZBLEwj8m+sV2600BuxXZvV4jU4rNNqK
         liMYiUODH69ccU8HjeQ14+ZpCVG2eaTLGl0vkpmiSgnzX8d3YRk+GcEQvxqRyiFcVBsO
         ddnpi7bymixHZDXsdmvwGt0vd6wIKe3J/s2t8p+sPA2IRD1/JnVkWkZ6F+vwjJf6nl9c
         KDPg==
X-Gm-Message-State: AOJu0Yy2ZjskxyRGiIJ8Sr11M5htHQRlH01tp16/WXe4dG079NNoU6/Y
	jR0VcRrMF8U+1v8XqTr/M9su7SlcnL+s67lS2Kh2lU6X
X-Google-Smtp-Source: AGHT+IGo/4pGiY2CzvH24z/qYlIQMvNju8tGcNRKHAO+YNqcSuXvNbr1QJbcmN9PcnnekmGYewrQBw==
X-Received: by 2002:a17:906:b188:b0:9e6:f7c6:792f with SMTP id w8-20020a170906b18800b009e6f7c6792fmr159047ejy.17.1700765913533;
        Thu, 23 Nov 2023 10:58:33 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906231700b009ff1997ce86sm1115944eja.149.2023.11.23.10.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:58:32 -0800 (PST)
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
Subject: [PATCH 4/5] tools: selftests: riscv: Fix compile warnings in vector tests
Date: Thu, 23 Nov 2023 19:58:20 +0100
Message-ID: <20231123185821.2272504-5-christoph.muellner@vrull.eu>
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
the vector tests. Let's follow the recommendation in
Documentation/printk-formats.txt to fix these warnings.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 tools/testing/selftests/riscv/vector/v_initval_nolibc.c | 2 +-
 tools/testing/selftests/riscv/vector/vstate_prctl.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
index 66764edb0d52..1dd94197da30 100644
--- a/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/v_initval_nolibc.c
@@ -27,7 +27,7 @@ int main(void)
 
 	datap = malloc(MAX_VSIZE);
 	if (!datap) {
-		ksft_test_result_fail("fail to allocate memory for size = %lu\n", MAX_VSIZE);
+		ksft_test_result_fail("fail to allocate memory for size = %d\n", MAX_VSIZE);
 		exit(-1);
 	}
 
diff --git a/tools/testing/selftests/riscv/vector/vstate_prctl.c b/tools/testing/selftests/riscv/vector/vstate_prctl.c
index b348b475be57..8ad94e08ff4d 100644
--- a/tools/testing/selftests/riscv/vector/vstate_prctl.c
+++ b/tools/testing/selftests/riscv/vector/vstate_prctl.c
@@ -68,7 +68,7 @@ int test_and_compare_child(long provided, long expected, int inherit)
 	}
 	rc = launch_test(inherit);
 	if (rc != expected) {
-		ksft_test_result_fail("Test failed, check %d != %d\n", rc,
+		ksft_test_result_fail("Test failed, check %d != %ld\n", rc,
 				      expected);
 		return -2;
 	}
@@ -87,7 +87,7 @@ int main(void)
 	pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
 	rc = riscv_hwprobe(&pair, 1, 0, NULL, 0);
 	if (rc < 0) {
-		ksft_test_result_fail("hwprobe() failed with %d\n", rc);
+		ksft_test_result_fail("hwprobe() failed with %ld\n", rc);
 		return -1;
 	}
 
-- 
2.41.0


