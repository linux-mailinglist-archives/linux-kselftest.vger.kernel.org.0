Return-Path: <linux-kselftest+bounces-487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 276BE7F66C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 19:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68B328167C
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 18:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8890624A0E;
	Thu, 23 Nov 2023 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="DrC1T99i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43902D40
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:58:28 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c8880f14eeso14847301fa.3
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700765906; x=1701370706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGDig6YgBY65aRC6yCBQTLGsMwfbG6Dc++Rh1cU7fbM=;
        b=DrC1T99i0M2ZaIhu7Xi8wj3jQMkFXQpgn77EmwbppqJvw9LThxqAgjxu07PvCPrJEY
         wp3jkXWKXWWbwTGWonmdyNL93JlQjRTEP5MUmfEgzHVPPvfAzAWBXOBQIlbdwquX3TQT
         g8IX6/YCdVbGu0B4tiNVgiZ/GUbKU+eh8KijcRCNny7Snl8wuvpQ+gunhezXWPvfvUlM
         aY1BAsZJ4l2gtTNwqmXSyuuyaa0Rw7tuKwwgONQ4WqXlZme+1Qc1j0BseJjV/Rxchat3
         hhyHShY7A02RsC3i5B4jfVPczmaSlDhM/IRuBVVLfLAYM3EqQnMqnJH5DwusAgX9K3Ap
         3c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765906; x=1701370706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IGDig6YgBY65aRC6yCBQTLGsMwfbG6Dc++Rh1cU7fbM=;
        b=cCZXWcRvVKE8YTkX6qduwE39KLfMO+99R5TXSNg36XY+BLOKCaopRMTwEy///h1gmZ
         GQw9ePQbGaJk4tXU4GOEIKkMlPofdVo2uxzdQEXnF97Y6uK+xF+7/TpMEMtKUpUJK1ZP
         TgbKj5r3dWeKME9/e+9VQ8YZeNRSG8v1ISTtRMXrrBtdMotwACloYkH8v8EybVXcLMdZ
         5WjPiQpB2L5XVU10AUIRMxUGNOZ17wdI1xOh1S2H3HZuBgUImo9Z9mzTH5kZpW8JAH0n
         jSyWCF5ustoJgJaJwOY7522Zq7c6/WTqfh1YQamH3v6KPFcAEUpPGcIAu7OOHuOOANLK
         i4Cw==
X-Gm-Message-State: AOJu0YxmNXMocHXOX7dVseSg14ieftt+CvuL3Uh4wGHLXo6OREbqA+yj
	m3JdpSNmUab6YBGJxy55+HhR7Q==
X-Google-Smtp-Source: AGHT+IFY1/C0dQe7cOOy2B31dSRmgNpyJ4PnGGQCob4NYZKF2UsPTkohGqYxikaY7xsNsW23oO0U/w==
X-Received: by 2002:a2e:9ac3:0:b0:2c5:14da:91f2 with SMTP id p3-20020a2e9ac3000000b002c514da91f2mr219754ljj.22.1700765906008;
        Thu, 23 Nov 2023 10:58:26 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906231700b009ff1997ce86sm1115944eja.149.2023.11.23.10.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:58:25 -0800 (PST)
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
Subject: [PATCH 0/5] tools: selftests: riscv: Fix compiler warnings
Date: Thu, 23 Nov 2023 19:58:16 +0100
Message-ID: <20231123185821.2272504-1-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Müllner <christoph.muellner@vrull.eu>

When building the RISC-V selftests with a riscv32 compiler I ran into
a couple of compiler warnings. While riscv32 support for these tests is
questionable, the fixes are so trivial that it is probably best to simply
apply them.

Note that the missing-include patch and some format string warnings
are also relevant for riscv64.

Christoph Müllner (5):
  tools: selftests: riscv: Fix compile warnings in hwprobe
  tools: selftests: riscv: Fix compile warnings in cbo
  tools: selftests: riscv: Add missing include for vector test
  tools: selftests: riscv: Fix compile warnings in vector tests
  tools: selftests: riscv: Fix compile warnings in mm tests

 tools/testing/selftests/riscv/hwprobe/cbo.c               | 6 +++---
 tools/testing/selftests/riscv/hwprobe/hwprobe.c           | 4 ++--
 tools/testing/selftests/riscv/mm/mmap_test.h              | 3 +++
 tools/testing/selftests/riscv/vector/v_initval_nolibc.c   | 2 +-
 tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c | 3 +++
 tools/testing/selftests/riscv/vector/vstate_prctl.c       | 4 ++--
 6 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.41.0


