Return-Path: <linux-kselftest+bounces-44043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF47C09E9B
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 20:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2095B40076A
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 18:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1193002D0;
	Sat, 25 Oct 2025 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eATwI546"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266CC2D978A
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418185; cv=none; b=IowmkqeVxNolVrCCGvAfxfdh3a1sGUDQWZRkxakwMIS2j1Mc6mUswEsoBkPY+8LxtI9l67PK86j8Nz1xwXF9an+0dqlEswjdvu9GaJSPBLoympqF5rwCF42IVrAOTm7ujqRwpa57mVS4C63YKTDoOBxVq38d8cGkvFf4ZG5NLeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418185; c=relaxed/simple;
	bh=3jV0KfbqyUjr6nh2vaI4XUsvRoHBlT0uhCZEnBsgLUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L5YhWIe3x4yUMfXYgOwoXAe2jfsqWjWYreWMBXTv02VX+ig8WE80g4fM1T3qV/VCvrm8ZuYl5R80oURZ2/YLBXpjdByh0JxNvyYNSwo6RBI2LXj8tToL1DxIaZGpNzUWuwx46pvuhS7KndrlwA9RNXbtkQvONyjAvdoqLURwIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eATwI546; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-33255011eafso3158128a91.1
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 11:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761418183; x=1762022983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIRvzi8j6zwlZeQRUUP2B9p5LHiwZA8VZKiF7rQQGE4=;
        b=eATwI546hyMk4GmPjV99wT5Khcsf31Shup7XZmZ80FgNskJgBeltLj+C4Scngud0Kb
         eDD8L9N4+Tbxh/DaEFxWsqJtt+HYit+4spTTAkkxXJEpf5PoZpWi8CBpDVrtGHDO2z9l
         j+pKDe4fxM9tZHr476u6zbT93c6Aeh6XwpxLgdysfrA2btUH03LcwI6Ucd1Yu3nlIiiZ
         /gySeCShrSneBdT7PI/+zd5fDoONqFaV/MvMmooV+2oIhBSMFSglLRAlSWVLf588+Y8z
         Yft4jCs/ei/cc0TFYUCxvad5/EPhZDdCyWoDm5hR2+HuNhYPIJ+LaGQdHJuare79M8v0
         v2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761418183; x=1762022983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIRvzi8j6zwlZeQRUUP2B9p5LHiwZA8VZKiF7rQQGE4=;
        b=YCrHogLBBptbFf24AEZF/Cjoy1cIhMbDhCXVutf7eUYqHWybw4mTsPhhQr+pzZi4AU
         tzzEj5Y7raEdM+b1ok9+3fz4P/6iaNNuCeaVHtGuQC2TyJgWKgwTAXLqOfYWETMswOc8
         Cji5qBFbxTXEDTJsFNJGaftPctgxVKlnweQNMHM/+WFzxQcQ+g6fE0/QcbDT9jtG7eds
         hnLqU8MlRkfcvEmr0Uobzha/jXtbKNPc13hsAxrBXMfRZlZuRu7NIkt+TuO2qHVcYRzp
         A8A0YFmWUvyJHwwYyJEL44OkwPM2oK66csOQDhm0RWPH/p1m44bHiM4MBoQkVNuCnVvt
         TIhg==
X-Forwarded-Encrypted: i=1; AJvYcCXwzNefXX5eOOn5x4+ReFF5bWNB2piA+NjX7DqxTLM8tSkATePS5aWJ7OySEu0ywNk9NL/BpnEe6Lb4Vm2re6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYBwLKja7WPe8OV2+N3935gKTmk5yu7YwdDP4+qPjqDGi890qh
	2yfhcLEwfQt36KwDRm2vYSAsMWPbBeOJaKyJaL0iEbdXvNOm28ngX5l8
X-Gm-Gg: ASbGnctrk96xp4cdXReqaVBHkE7QpkAUqWqhk3jU6oD7+wcyuu4c+2l8WYyxHKfCMh3
	xsbQAAQdrMx4b+cKhRLOuf2/dDPHCxir3csBRPONAspAEb47ACfNt9vLN1LD3bPJx1E5cZyqHn0
	TwMbD0FPaNkNO8F1JDXugBgnQuSWuenLjjzIC+d5kYZnm+75yIbPKhhQGsO+MhKP/9FqW/8jELf
	KcOiDwWQrAKd8fC6nu8RpXWO+dtQ5QDu0ya8Acvx5UoJ1MBqvPZ9QoMH6waVNZJcNhBWmsmnlX1
	TXRQBaAm1lXGUVYmHh6i98Z6YZNKI8T5GoDJNGqMFwR3tLxzLJfby54ggH/Q+AHAK09EKIngVZ4
	vnsFSiV2Nx0i+ay1/BTWwRnkoAhg1+gNEZSLagBfAKICqRpSRCvYORshIYZSFCWfHv4+ii5oY85
	y4IwwCA3LUlEenUsJXZ2rBfP3jacalyv8kJ+kyHVPNGq3LV+q2xtDNaic=
X-Google-Smtp-Source: AGHT+IHAiMH9JhYQraNgPguxjgZGjEFmFQTsB3vEnaOVZ8IpIk6BfW2plHMfNLdpmtJSevEWDj22Og==
X-Received: by 2002:a17:902:ccc8:b0:292:64ec:8f4b with SMTP id d9443c01a7336-29264ec9336mr315255035ad.43.1761418183223;
        Sat, 25 Oct 2025 11:49:43 -0700 (PDT)
Received: from prakrititz-UB.. ([2a09:bac5:3c3f:a82::10c:1a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0996esm29589375ad.28.2025.10.25.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 11:49:42 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH] selftests/seccomp: fix pointer type mismatch in UPROBE test
Date: Sun, 26 Oct 2025 00:19:04 +0530
Message-ID: <20251025184903.154755-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compilation error in UPROBE_setup caused by pointer type mismatch
in ternary expression. The probed_uretprobe and probed_uprobe function
pointers have different type attributes (__attribute__((nocf_check))),
which causes the conditional operator to fail with:

  seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
  expression [-Wincompatible-pointer-types]

Cast both function pointers to 'const void *' to match the expected
parameter type of get_uprobe_offset(), resolving the type mismatch
while preserving the function selection logic.

Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..e13ffe18ef95 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
 		ASSERT_GE(bit, 0);
 	}
 
-	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
+	offset = get_uprobe_offset(variant->uretprobe ?
+		(const void *)probed_uretprobe : (const void *)probed_uprobe);
 	ASSERT_GE(offset, 0);
 
 	if (variant->uretprobe)
-- 
2.48.1


