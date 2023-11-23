Return-Path: <linux-kselftest+bounces-490-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F437F66C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 19:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED6AB211BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 18:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54CA41A8F;
	Thu, 23 Nov 2023 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="Wut90YIg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239561B3
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:58:33 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54acdd65c88so297358a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700765911; x=1701370711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gBMT1D8EIh0bBWoj7ImRklCKaan3pldMceeCzs+vUQ=;
        b=Wut90YIgGWdeYAfFnYgnkugdn4Ab3YQZLngX+t7BRQtw0bQlJapmf/um1Yd5xyAIDU
         yzjHihrUKawz6T/TgU0M6EAU6hsuivLBqbHORBy2xZOhOgNjlAnMfVBf6wOOpg8tZmiK
         7/n+6oC533vD+5tGEQRkJ7UjS0xYxqAUjH9QFMao/cP2hBBJczlXc6ijT+LfHn1RMyfc
         p+XX/GP3L5LTeWf3cQKGspTvXh5kmwEziwHFyLlRTD3X6NfS4Hc1b0ei9qhrS6jP9ZBA
         1yleh2JLIUzbn/JCqJHoia363GAfwnQ7+VflDk6ysr1WAVF7PkMNSpjVp911t+DCZig0
         2t/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765911; x=1701370711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gBMT1D8EIh0bBWoj7ImRklCKaan3pldMceeCzs+vUQ=;
        b=pfuU20XngBswTRY3bHlqOlwr/JBHBFOXUIXP3QGECNV6dLBJiGE0emX5m4LgzpMmkq
         EnbWZLkzfAYd7Wb93vbP4AmKXL0CeUTiCpZY3YPqItLQIAmZ41/5H2V/aF7EaQ9eEqAY
         4EQ5uEkRRc/ZSny5NCzNw+91F0IEi/4T4JcYNrCpDYxN+syYvjWX11MlnjC0aIl+KrI9
         lIl5xWxDPMGp/6qYha0xQKa+vLZiD6YBwsi1NxMqIL+C9KA86KU4p8o+2Zqa+wBirDa3
         3nD56llTz8RHcvqBRqUWCitHlCEL/ZqH966uqiZz9tKbYIJMBM3x6CZmdX14tuMAnUmE
         HvTg==
X-Gm-Message-State: AOJu0YwC1zfUewgw4yYELHMUq2rmiCjm2ymPvlO25yxnszyGpIXk6fyd
	GghTymgc0PjJvek6SHa/jZYso/yJxH2hNPwr8zu1ljTT
X-Google-Smtp-Source: AGHT+IHM33vf1NCGDtR+L8oDLbeP6Km4LXuLVeIqB8PR1IIY6cQtOKQe4/t/v35w1zVrGzfmN4G2PA==
X-Received: by 2002:a17:907:d30c:b0:9bf:d65d:dc0f with SMTP id vg12-20020a170907d30c00b009bfd65ddc0fmr232442ejc.4.1700765911728;
        Thu, 23 Nov 2023 10:58:31 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906231700b009ff1997ce86sm1115944eja.149.2023.11.23.10.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:58:31 -0800 (PST)
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
Subject: [PATCH 3/5] tools: selftests: riscv: Add missing include for vector test
Date: Thu, 23 Nov 2023 19:58:19 +0100
Message-ID: <20231123185821.2272504-4-christoph.muellner@vrull.eu>
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

GCC raises the following warning:
  warning: 'status' may be used uninitialized
The warning comes from the fact, that the signature of waitpid() is
unknown and therefore the initialization of GCC cannot be guessed.
Let's add the relevant header to address this warning.

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
index 2c0d2b1126c1..1f9969bed235 100644
--- a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/wait.h>
+
 #define THIS_PROGRAM "./vstate_exec_nolibc"
 
 int main(int argc, char **argv)
-- 
2.41.0


