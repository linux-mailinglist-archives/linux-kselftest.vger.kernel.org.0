Return-Path: <linux-kselftest+bounces-492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 483AD7F66C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 19:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D86281BFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Nov 2023 18:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9877141232;
	Thu, 23 Nov 2023 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="lMrpwtT8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DA5D54
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:58:36 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991c786369cso166409866b.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Nov 2023 10:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1700765915; x=1701370715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vE4taij5q3MAjmiPUZKHE8qoF6TdBc6iBW1aIWJ4LYw=;
        b=lMrpwtT8QXuTgaqbLHjMRLG+t/59U5KedCK3NhKbEPpJsOdmFxMIlvx20vmYNZmfZ1
         t13Y4JlUqz6slxj+Y1gpzbxy1iVr7T5P2iv44BpGYDowATlcyY54kL/bwWWCJWgUE0+n
         9vl6cs0AL0N3jHUtD0nzAEs7oRP3sm8ss/blYAh150OvKZmTQJRRQq235qcHmienZaNr
         RRABTWM18akM09CCl/NxPIBNcKv1pkFrDN/pnXOunehrWUBmi6lHNdHwWmcWrgjli6mT
         i9bvVEy97zRThVaey22nhFtN2oau0W2qo6YwmpYcYG/rv+mMkfpTDd/xdNbdJfEx0x1J
         katA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765915; x=1701370715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE4taij5q3MAjmiPUZKHE8qoF6TdBc6iBW1aIWJ4LYw=;
        b=HCigdOiUHgf5huj4oiNCPILIV2xHiNwLT7AkR9KjEiykYgFr/48melKPmJrgyZvOmx
         hunhzYt/zvlH3FBrdzJQCXwTFR8LckptHUGvsFy5c6ka83k2rNs1ZRjhQvfmSSEtgGFw
         Mo+Jgveq/Jg2zaM1oh4KuATl0FNXWS+DmvKir5Mt7up/hgqV4NEVtztP2nHHYwqeithJ
         EK1YuFOyDoydbg/Qzx0v3WQMKrtbzw7SxpXYqeUny1CeBNSt3K5IOYcwImKhDi8fc2XK
         MVwraOvf2Jhp4oTcV8qkr6eFcck1j+jq+sZRjpTS+WciwEYxxHcDfC5Xef7oUF7AGl4Q
         qCWg==
X-Gm-Message-State: AOJu0Yz7rt6DiVCZF4reLyfMhKqPkir11f9NmFHjHrj4e8vr3RDNKzjV
	c55fjTdUBXtjQo97Yw6EQW6oAa88mKEKjAkYXDBFoVWd
X-Google-Smtp-Source: AGHT+IGq6dOMJJMtU5Up+yGiMT76gDi7Z83Zw3jt75JpsMbNdpOYO4U2mN9YDUlYYRNjg8nPchbdWA==
X-Received: by 2002:a17:906:1ccd:b0:a00:a591:929 with SMTP id i13-20020a1709061ccd00b00a00a5910929mr195955ejh.24.1700765915300;
        Thu, 23 Nov 2023 10:58:35 -0800 (PST)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at. [62.178.148.172])
        by smtp.gmail.com with ESMTPSA id l23-20020a170906231700b009ff1997ce86sm1115944eja.149.2023.11.23.10.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:58:34 -0800 (PST)
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
Subject: [PATCH 5/5] tools: selftests: riscv: Fix compile warnings in mm tests
Date: Thu, 23 Nov 2023 19:58:21 +0100
Message-ID: <20231123185821.2272504-6-christoph.muellner@vrull.eu>
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

When building the mm tests with a riscv32 compiler, we see a range
of shift-count-overflow errors from shifting 1UL by more than 32 bits
in do_mmaps(). Since, the relevant code is only called from code that
is gated by `__riscv_xlen == 64`, we can just apply the same gating
to do_mmaps().

Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 tools/testing/selftests/riscv/mm/mmap_test.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/riscv/mm/mmap_test.h b/tools/testing/selftests/riscv/mm/mmap_test.h
index 9b8434f62f57..2e0db9c5be6c 100644
--- a/tools/testing/selftests/riscv/mm/mmap_test.h
+++ b/tools/testing/selftests/riscv/mm/mmap_test.h
@@ -18,6 +18,8 @@ struct addresses {
 	int *on_56_addr;
 };
 
+// Only works on 64 bit
+#if __riscv_xlen == 64
 static inline void do_mmaps(struct addresses *mmap_addresses)
 {
 	/*
@@ -50,6 +52,7 @@ static inline void do_mmaps(struct addresses *mmap_addresses)
 	mmap_addresses->on_56_addr =
 		mmap(on_56_bits, 5 * sizeof(int), prot, flags, 0, 0);
 }
+#endif /* __riscv_xlen == 64 */
 
 static inline int memory_layout(void)
 {
-- 
2.41.0


