Return-Path: <linux-kselftest+bounces-28636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6657BA59970
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A746D16ED2A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8821122DFA7;
	Mon, 10 Mar 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fi99kbZp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D022DF9C
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 15:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619619; cv=none; b=djEK9huDofbgHebMhK6h7r1nztGzTXURg/Eku2NfPF6wyrfHufeL1V238IM3/VQ/BW4yy/KBDbpwcRVY1XPX0StX9RSjzFbBGzMYnY8V+c1hr3lY1jZUUQYE9g5QyxYf6o/eYT9AtLfHZIiQxNNGqXEjtO9i3EXimdaEx6g3upw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619619; c=relaxed/simple;
	bh=G0bMb29ZpgJV0/CkJZpzg+0z8//qkfB6ATS+lahL2BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CR25K85w3N2mozImUMIkQbFqIA1KQ5PIMr946ZPfvzDTCXbZCAaLP/gEF5P9HpdDiOGtGI+sLPZTamlQ8u4BCGFDyBvxpI8Euc4n46wAENth/JKKhLYATiJqIudCau/CR7nrAnXybplbRztA5SkvRkQlGSRJJ7yqridwI7WVTdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fi99kbZp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2235189adaeso72916615ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 08:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619617; x=1742224417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Radg/O1kYDcS8p0IZNGBH2Vna601zEl7dWErY3x7IKQ=;
        b=fi99kbZpHioLtGi82zxDgaCnhZ0CNWGyWwVuW/RajEZPlNGRK4ot6wphvsUusWBGFj
         iTnzUjn2YnQ5AzoepGwOY/BMI1eE/ihbWpPemAhi8g3tK8PCW7/V480KhZmvtAqXyRJW
         QDxhEoV4nMX8DtZq8+8/O3ErEDtDkKf+IbHy2V8SZ83NGd8tOesgL9o7YVJY+vhZSLq+
         YN9exj9JHUDH0I5PKAUQ69yPktuR+CuGVMTL227KLso44YD9git4DYZMdrL1lOPXiiTT
         hd4Z6y6OKDamDUF3Kdry+2LA16OF9C2/pBXDAW2Mch3d4k4ZkbNNsXLLh2tSkj5Nwn5B
         S80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619617; x=1742224417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Radg/O1kYDcS8p0IZNGBH2Vna601zEl7dWErY3x7IKQ=;
        b=CyT1+sHyczrSCew3mWNfEMuWT5gXd3Foue5afx+WEeXNe0fCI4J2+fcB6YV+SK6P72
         CEkyJZZPGWmTsucfT2NkFTPkIgQXYKhPXiMUk87Bxy6jV5kN4XKVHtSJva261+p4SDHS
         eL7CbSc5FkIkN6HMn3lHhNb4KeKEVB3WbYXJp1o5isXwhnzXZC+DYyJr6GGviIc+XboU
         QfPhHNc5lMdnZcZGbCHaQdvdZm5XKjaaqUZqTyfw3eRxc5/I8YNCFSFYd2O+Lb3lTEus
         l8Pvp9CQlkWCQ2i3lqaq4GXWttsaIk8+crXZoys9nSCGCWTCgHUDxxCkh6Et9e5U/qlL
         Sb6A==
X-Forwarded-Encrypted: i=1; AJvYcCVdNuSafUnMucNywllSJFx7GZEOWNXNqSrYuAAnFZ3OEhQ2SzMeSl7QGqPkPbgyhgOc4D6IhRGgLbw8IcvmZ3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mKSF2MNcWxCeDm+R3S2F1A6stBYpGxEqUCb4CdaF4BY8XDsF
	TIRLC2ykOQJlqQo1wabof+kI3BrYi3cqY6IAnr8zqRgkMIACRgaDG99UHNcIhuI=
X-Gm-Gg: ASbGncuAty3G9v5b8TpuT/s0AntiHAUSFfHUfQJLcIbRY+1DoGDYYnHOOu0f0WUDpXq
	OaDm7LVNsPVJBE6wuj9HQ7nxaHdSues/+sX5bTBD15gRng+eCVV8Bxc1yFuK66dxOhAMj/AAqUa
	kDEBitMyEOQ7KmZ6V24HfqPfmz0RfMnDT6+jpnt1nczzz9z6Vbehvm6pvAi749Leb4hhpbznB2+
	pMaOlXmOKC/RMoanxAZGMGPEBmcSjFz+dh9Zav8KR5aG0Qlebc0WQU0a2O/lOzgCxxxaBmSv3xE
	GvlckOpUy2rs0RNb+P6ArMIBORtARUr+mO/1hiukXXQXJg==
X-Google-Smtp-Source: AGHT+IFYtJx1zpZXoyRZ/KHJTP5G1HNeErNj7hP1Uj5JhhNtVjlp1IKO2nyoOwTegiQflbbotJG7Sw==
X-Received: by 2002:a17:903:2308:b0:215:58be:334e with SMTP id d9443c01a7336-224628603d2mr147459315ad.10.1741619617154;
        Mon, 10 Mar 2025 08:13:37 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:13:36 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 06/17] riscv: misaligned: use correct CONFIG_ ifdef for misaligned_access_speed
Date: Mon, 10 Mar 2025 16:12:13 +0100
Message-ID: <20250310151229.2365992-7-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310151229.2365992-1-cleger@rivosinc.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

misaligned_access_speed is defined under CONFIG_RISCV_SCALAR_MISALIGNED
but was used under CONFIG_RISCV_PROBE_UNALIGNED_ACCESS. Fix that by
using the correct config option.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index ffac424faa88..7fe25adf2539 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -362,7 +362,7 @@ static int handle_scalar_misaligned_load(struct pt_regs *regs)
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
-#ifdef CONFIG_RISCV_PROBE_UNALIGNED_ACCESS
+#ifdef CONFIG_RISCV_SCALAR_MISALIGNED
 	*this_cpu_ptr(&misaligned_access_speed) = RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED;
 #endif
 
-- 
2.47.2


